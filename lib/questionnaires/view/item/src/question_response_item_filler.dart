import 'package:faiadashu/coding/coding.dart';
import 'package:faiadashu/l10n/l10n.dart';
import 'package:faiadashu/logging/src/logger.dart';
import 'package:faiadashu/questionnaires/questionnaires.dart';
import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';

/// Filler for a [QuestionnaireResponseItem].
class QuestionResponseItemFiller extends ResponseItemFiller {
  final QuestionItemModel questionResponseItemModel;

  QuestionResponseItemFiller(
    QuestionnaireFillerData questionnaireFiller,
    this.questionResponseItemModel, {
    Key? key,
  }) : super(questionnaireFiller, questionResponseItemModel, key: key);

  @override
  State<StatefulWidget> createState() => QuestionResponseItemFillerState();
}

class QuestionResponseItemFillerState
    extends ResponseItemFillerState<QuestionResponseItemFiller> {
  static final _qrimLogger = Logger(QuestionResponseItemFillerState);

  late final QuestionItemModel questionResponseItemModel;

  late final FocusNode _skipSwitchFocusNode;

  late final RenderingString? _promptText;

  QuestionResponseItemFillerState();

  @override
  void initState() {
    super.initState();

    questionResponseItemModel = widget.questionResponseItemModel;

    _skipSwitchFocusNode = FocusNode(
      skipTraversal: true,
      debugLabel: 'SkipSwitch ${responseItemModel.nodeUid}',
    );

    _promptText =
        questionResponseItemModel.questionnaireItemModel.promptTextItem?.text;
  }

  @override
  void dispose() {
    _skipSwitchFocusNode.dispose();
    super.dispose();
  }

  void _setDataAbsentReason(Code? dataAbsentReason) {
    if (mounted) {
      setState(() {
        questionResponseItemModel.dataAbsentReason = dataAbsentReason;
      });
    }
  }

  Widget _answerFillerWidget() {
    return _HorizontalAnswerFillers(
      questionResponseItemModel,
      questionnaireTheme,
    );
  }

  Widget? _promptTextWidget(BuildContext context) {
    final promptText = _promptText;
    if (promptText == null) return null;

    return Xhtml.fromRenderingString(
      context,
      promptText,
    );
  }

  Widget? _questionSkipperWidget() {
    if (questionnaireTheme.canSkipQuestions &&
      !widget.questionnaireItemModel.isReadOnly &&
      !widget.questionnaireItemModel.isRequired
    ) {
      return Row(
        children: [
          Text(
            FDashLocalizations.of(context)
                .dataAbsentReasonAskedDeclinedInputLabel,
          ),
          Switch(
            focusNode: _skipSwitchFocusNode,
            value: questionResponseItemModel.isAskedButDeclined,
            onChanged: (bool value) {
              _setDataAbsentReason(
                value ? dataAbsentReasonAskedButDeclinedCode : null,
              );
            },
          ),
        ],
      );
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    _qrimLogger.trace(
      'build ${widget.responseItemModel} hidden: ${widget.responseItemModel.questionnaireItemModel.isHidden}, enabled: ${widget.responseItemModel.isEnabled}',
    );

    return AnimatedBuilder(
      animation: widget.responseItemModel,
      builder: (context, _) {
        return AnimatedCrossFade(
          alignment: Alignment.topLeft,
          firstChild: Focus(
// Only enable for low-level focus coding
/*            onFocusChange: (gainedFocus) {
              debugDumpFocusTree();
            }, */
            focusNode: focusNode,
            child: QuestionnaireTheme.of(context).questionResponseItemLayoutBuilder(
              context,
              widget.responseItemModel as QuestionItemModel,
              _answerFillerWidget(),
              titleWidget: titleWidget,
              promptTextWidget: _promptTextWidget(context),
              questionSkipperWidget: _questionSkipperWidget(),
            ),
          ),
          secondChild: const SizedBox(
            height: 0,
            width: double.infinity,
          ),
          crossFadeState: questionResponseItemModel.displayVisibility !=
                      DisplayVisibility.hidden &&
                  questionResponseItemModel.structuralState ==
                      StructuralState.present
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
          duration: const Duration(milliseconds: 300),
        );
      },
    );
  }
}

class _HorizontalAnswerFillers extends StatefulWidget {
  final QuestionItemModel questionResponseItemModel;
  final QuestionnaireThemeData questionnaireTheme;

  const _HorizontalAnswerFillers(
    this.questionResponseItemModel,
    this.questionnaireTheme, {
    Key? key,
  }) : super(key: key);

  @override
  _HorizontalAnswerFillersState createState() =>
      _HorizontalAnswerFillersState();
}

class _HorizontalAnswerFillersState extends State<_HorizontalAnswerFillers> {
  static final _logger = Logger(_HorizontalAnswerFillersState);

  final _answerFillers = <String, QuestionnaireAnswerFiller>{};

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _initAnswerFillers();
  }

  void _initAnswerFillers() {
    final fillableAnswerModels =
        widget.questionResponseItemModel.fillableAnswerModels;
    for (final answerModel in fillableAnswerModels) {
      _answerFillers[answerModel.nodeUid] =
          QuestionnaireTheme.of(context).createQuestionnaireAnswerFiller(
        answerModel,
        key: ValueKey<String>('answer-filler-${answerModel.nodeUid}'),
      );
    }
  }

  void _addAnswerFiller(AnswerModel answerModel) {
    _answerFillers[answerModel.nodeUid] =
        QuestionnaireTheme.of(context).createQuestionnaireAnswerFiller(
      answerModel,
      key: ValueKey<String>('answer-filler-${answerModel.nodeUid}'),
    );
  }

  void _removeAnswerFiller(QuestionnaireAnswerFiller answerFiller) {
    final answerModel = answerFiller.answerModel;

    setState(() {
      widget.questionResponseItemModel.removeAnswerModel(answerModel);
      final removedAnswerFiller = _answerFillers.remove(answerModel.nodeUid);
      _logger.debug(
        'Removed answerfiller: $removedAnswerFiller',
      );
    });
  }

  Iterable<Widget> _decorateAnswerFillers(
    BuildContext context,
    bool isRepeating,
    bool hasMoreThanOneAnswer,
  ) {
    return isRepeating
        ? _answerFillers.values.map<Widget>(
            (answerFiller) => widget.questionnaireTheme.decorateRepeatingAnswer(
              context,
              answerFiller,
              hasMoreThanOneAnswer &&
                      widget.questionResponseItemModel
                              .questionnaireResponseModel.responseStatus ==
                          QuestionnaireResponseStatus.in_progress
                  ? () {
                      _removeAnswerFiller(answerFiller);
                    }
                  : null,
            ),
          )
        : _answerFillers.values;
  }

  @override
  Widget build(BuildContext context) {
    final isRepeating =
        widget.questionResponseItemModel.questionnaireItemModel.isRepeating;
    final hasMoreThanOneAnswer = _answerFillers.length > 1;

    final decoratedAnswerFillers =
        _decorateAnswerFillers(context, isRepeating, hasMoreThanOneAnswer);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!widget.questionResponseItemModel.isAskedButDeclined)
          ...decoratedAnswerFillers,
        if (isRepeating &&
            widget.questionResponseItemModel.questionnaireResponseModel
                    .responseStatus ==
                QuestionnaireResponseStatus.in_progress)
          widget.questionnaireTheme.buildAddRepetition(
            context,
            widget.questionResponseItemModel,
            (widget.questionResponseItemModel.latestAnswerModel.isNotEmpty)
                ? () {
                    setState(() {
                      final newAnswerModel =
                          widget.questionResponseItemModel.addAnswerModel();
                      _addAnswerFiller(newAnswerModel);
                    });
                  }
                : null,
          ),
      ],
    );
  }
}
