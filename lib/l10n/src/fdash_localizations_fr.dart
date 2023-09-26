// ignore_for_file: avoid_escaping_inner_quotes, unnecessary_brace_in_string_interps, unnecessary_string_escapes, always_use_package_imports

import 'package:intl/intl.dart' as intl;
import 'fdash_localizations.g.dart';

/// The translations for English (`en`).
class FDashLocalizationsFr extends FDashLocalizations {
  FDashLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get validatorRequiredItem => 'Remplissez ce champ obligatoire.';

  @override
  String validatorMinLength(int minLength) {
    return intl.Intl.pluralLogic(
      minLength,
      locale: localeName,
      one: 'Entrez au moins un caractère.',
      other: 'Entrez au moins $minLength caractères.',
    );
  }

  @override
  String validatorMaxLength(int maxLength) {
    return intl.Intl.pluralLogic(
      maxLength,
      locale: localeName,
      other: 'Entrez jusqu\'à $maxLength caractères.',
    );
  }

  @override
  String get validatorUrl => 'Entrez une URL valide au format https://…';

  @override
  String get validatorRegExp => 'Entrez une réponse valide.';

  @override
  String validatorEntryFormat(String entryFormat) {
    return 'Entrer dans le format $entryFormat.';
  }

  @override
  String get validatorNan => 'Entrez un numéro valide.';

  @override
  String validatorMinValue(String minValue) {
    return 'Entrez un nombre égal ou supérieur à $minValue.';
  }

  @override
  String validatorMaxValue(String maxValue) {
    return 'Entrez un nombre jusqu\'à $maxValue.';
  }

  @override
  String get dataAbsentReasonAskedDeclined => 'Je choisis de ne pas répondre.';

  @override
  String get narrativePageTitle => 'Narratif';

  @override
  String get questionnaireGenericTitle => 'Enquête';

  @override
  String get questionnaireUnknownTitle => 'Sans titre';

  @override
  String get questionnaireUnknownPublisher => 'Editeur inconnu';

  @override
  String get validatorDate => 'Entrez une date valide.';

  @override
  String get validatorTime => 'Entrez une heure valide.';

  @override
  String get validatorDateTime => 'Entrez une date et une heure valides.';

  @override
  String validatorMinOccurs(int minOccurs) {
    return intl.Intl.pluralLogic(
      minOccurs,
      locale: localeName,
      one: 'Sélectionnez au moins une option.',
      other: 'Sélectionnez $minOccurs ou d\'autres options.',
    );
  }

  @override
  String validatorMaxOccurs(int maxOccurs) {
    return intl.Intl.pluralLogic(
      maxOccurs,
      locale: localeName,
      one: 'Sélectionnez jusqu\'à une option.',
      other: 'Sélectionnez jusqu\'à $maxOccurs.',
    );
  }

  @override
  String validatorSingleSelectionOrSingleOpenString(Object openLabel) {
    return 'Sélectionnez une option ou saisissez un texte libre dans \"$openLabel\".';
  }

  @override
  String validatorMaxSize(String maxSize) {
    return 'Sélectionnez un fichier sous $maxSize.';
  }

  @override
  String validatorMimeTypes(String mimeTypes) {
    return 'Sélectionnez un fichier de l\'un des types suivants: $mimeTypes.';
  }

  @override
  String get dataAbsentReasonAskedDeclinedInputLabel =>
      'Je choisis de ne pas répondre.';

  @override
  String get dataAbsentReasonAskedDeclinedOutput => 'N\'a pas répondu';

  @override
  String get dataAbsentReasonAsTextOutput => '[COMME TEXTE]';

  @override
  String get autoCompleteSearchTermInput => 'Entrer le terme de recherche…';

  @override
  String get responseStatusToCompleteButtonLabel => 'Compléter';

  @override
  String get responseStatusToInProgressButtonLabel => 'Modifier';

  @override
  String get progressQuestionnaireLoading =>
      'L\'enquête est en cours de chargement…';

  @override
  String get handlingSaveButtonLabel => 'Économiser';

  @override
  String get handlingUploadButtonLabel => 'Télécharger';

  @override
  String get handlingUploading => 'Téléchargement de l\'enquête…';

  @override
  String get loginStatusLoggingIn => 'S\'inscrire…';

  @override
  String get loginStatusLoggedIn => 'Signé en …';

  @override
  String get loginStatusLoggingOut => 'Signer la fin…';

  @override
  String get loginStatusLoggedOut => 'Signé…';

  @override
  String get loginStatusUnknown => 'Vous ne savez pas ce qui se passe ?';

  @override
  String get loginStatusError => 'Quelque chose n\'a pas fonctionné.';

  @override
  String get handlingSaved => 'Enquête sauvegardée.';

  @override
  String get handlingUploaded => 'Enquête téléchargée.';

  @override
  String aggregationScore(Object score) {
    return 'Score: $score';
  }

  @override
  String get aggregationTotalScoreTitle => 'Score total';

  @override
  String get fillerOpenCodingOtherLabel => 'Autres';

  @override
  String fillerAddAnotherItemLabel(Object itemLabel) {
    return 'Ajouter un autre élément \"$itemLabel\"';
  }

  @override
  String get fillerExclusiveOptionLabel => '(exclusif)';
}
