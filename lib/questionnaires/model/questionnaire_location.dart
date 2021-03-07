import 'dart:collection';

import 'package:collection/collection.dart';
import 'package:fhir/r4.dart';
import 'package:flutter/foundation.dart';

/// Visit FHIR [Questionnaire] through linkIds.
/// Can provide properties of current location and move to adjacent items.
class QuestionnaireLocation extends ChangeNotifier with Diagnosticable {
  final Questionnaire questionnaire;
  final QuestionnaireItem questionnaireItem;
  QuestionnaireResponse? questionnaireResponse;
  QuestionnaireResponseItem? _questionnaireResponseItem;
  final String linkId;
  final QuestionnaireLocation? parent;
  final int siblingIndex;
  final int level;

  LinkedHashMap<String, QuestionnaireLocation>? _orderedItems;

  /// Go to the first location top-down of the given [Questionnaire].
  /// Will throw [Error]s in case this [Questionnaire] has no items.
  QuestionnaireLocation(this.questionnaire)
      : linkId = ArgumentError.checkNotNull(questionnaire.item?.first.linkId),
        questionnaireItem =
            ArgumentError.checkNotNull(questionnaire.item?.first),
        parent = null,
        siblingIndex = 0,
        level = 0;

  /// All siblings at the current level as FHIR [QuestionnaireItem].
  /// Includes the current item.
  List<QuestionnaireItem> get siblingQuestionnaireItems {
    if (level == 0) {
      return questionnaire.item!;
    } else {
      return parent!.questionnaireItem.item!;
    }
  }

  /// All children below the current level as FHIR [QuestionnaireItem].
  /// Returns an empty list when there are no children.
  List<QuestionnaireItem> get childQuestionnaireItems {
    if ((questionnaireItem.item == null) || (questionnaireItem.item!.isEmpty)) {
      return <QuestionnaireItem>[];
    } else {
      return questionnaireItem.item!;
    }
  }

  List<QuestionnaireLocation> get siblings {
    return _LocationListBuilder._buildLocationList(
        questionnaire, siblingQuestionnaireItems, parent, level);
  }

  List<QuestionnaireLocation> get children {
    return _LocationListBuilder._buildLocationList(
        questionnaire, childQuestionnaireItems, this, level + 1);
  }

  bool get hasNextSibling {
    return siblingQuestionnaireItems.length > siblingIndex + 1;
  }

  bool get hasPreviousSibling => siblingIndex > 0;

  QuestionnaireLocation get nextSibling => siblings.elementAt(siblingIndex + 1);

  bool get hasParent => parent != null;

  bool get hasChildren =>
      (questionnaireItem.item != null) && (questionnaireItem.item!.isNotEmpty);

  /// Find the [QuestionnaireLocation] that corresponds to the linkId.
  /// Throws an [Exception] when no such [QuestionnaireLocation] exists.
  QuestionnaireLocation findByLinkId(String linkId) {
    _ensureOrderedItems();
    return _orderedItems![linkId]!;
  }

  set responseItem(QuestionnaireResponseItem? questionnaireResponseItem) {
    _questionnaireResponseItem = questionnaireResponseItem;
    notifyListeners();
  }

  QuestionnaireResponseItem? get responseItem => _questionnaireResponseItem;

  bool get isReadOnly {
    if (questionnaireItem.type == QuestionnaireItemType.group) {
      return true;
    }

    if (questionnaireItem.readOnly == Boolean(true)) {
      return true;
    }

    if (questionnaireItem.type == QuestionnaireItemType.quantity) {
      if (questionnaireItem.extension_?.firstWhereOrNull((ext) =>
              ext.url ==
              FhirUri(
                  'http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire-calculatedExpression')) !=
          null) {
        return true;
      }
    }

    return false;
  }

  LinkedHashMap<String, QuestionnaireLocation> _addChildren() {
    final LinkedHashMap<String, QuestionnaireLocation> locationMap =
        LinkedHashMap<String, QuestionnaireLocation>();

    locationMap[linkId] = this;
    if (hasChildren) {
      for (final child in children) {
        locationMap.addAll(child._addChildren());
      }
    }

    return locationMap;
  }

  void _ensureOrderedItems() {
    if (_orderedItems == null) {
      final LinkedHashMap<String, QuestionnaireLocation> locationMap =
          LinkedHashMap<String, QuestionnaireLocation>();
      locationMap.addAll(_addChildren());
      QuestionnaireLocation currentSibling = this;
      while (currentSibling.hasNextSibling) {
        currentSibling = currentSibling.nextSibling;
        locationMap.addAll(currentSibling._addChildren());
      }
      _orderedItems = locationMap;
    }
  }

  /// Get an [Iterable] of [QuestionnaireLocation] in pre-order.
  /// see: https://en.wikipedia.org/wiki/Tree_traversal
  Iterable<QuestionnaireLocation> preOrder() {
    _ensureOrderedItems();
    return _orderedItems!.values;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);

    properties.add(StringProperty('linkId', linkId));
    properties
        .add(FlagProperty('children', value: hasChildren, ifTrue: 'children'));
    properties.add(IntProperty('level', level));
    properties.add(IntProperty('siblingIndex', siblingIndex));
    properties.add(IntProperty('siblings', siblings.length));
  }

  QuestionnaireLocation._(this.questionnaire, this.questionnaireItem,
      this.linkId, this.parent, this.siblingIndex, this.level);
}

/// Build list of [QuestionnaireLocation] from [QuestionnaireItem] and meta-data.
class _LocationListBuilder {
  static List<QuestionnaireLocation> _buildLocationList(
      Questionnaire _questionnaire,
      List<QuestionnaireItem> _items,
      QuestionnaireLocation? _parent,
      int _level) {
    int siblingIndex = 0;
    final locationList = <QuestionnaireLocation>[];

    for (final item in _items) {
      locationList.add(QuestionnaireLocation._(
          _questionnaire, item, item.linkId!, _parent, siblingIndex, _level));
      siblingIndex++;
    }

    return locationList;
  }
}
