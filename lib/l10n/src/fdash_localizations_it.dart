// ignore_for_file: avoid_escaping_inner_quotes, unnecessary_brace_in_string_interps, unnecessary_string_escapes, always_use_package_imports

import 'package:intl/intl.dart' as intl;
import 'fdash_localizations.g.dart';

/// The translations for English (`en`).
class FDashLocalizationsIt extends FDashLocalizations {
  FDashLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get validatorRequiredItem => 'Compilare questo campo obbligatorio.';

  @override
  String validatorMinLength(int minLength) {
    return intl.Intl.pluralLogic(
      minLength,
      locale: localeName,
      one: 'Inserire almeno un carattere.',
      other: 'Inserire almeno $minLength caratteri.',
    );
  }

  @override
  String validatorMaxLength(int maxLength) {
    return intl.Intl.pluralLogic(
      maxLength,
      locale: localeName,
      other: 'Inserire fino a $maxLength caratteri.',
    );
  }

  @override
  String get validatorUrl => 'Inserire un URL valido nel formato https://…';

  @override
  String get validatorRegExp => 'Immettere una risposta valida.';

  @override
  String validatorEntryFormat(String entryFormat) {
    return 'Inserire nel formato $entryFormat.';
  }

  @override
  String get validatorNan => 'Inserire un numero valido.';

  @override
  String validatorMinValue(String minValue) {
    return 'Inserire un numero pari o superiore a $minValue.';
  }

  @override
  String validatorMaxValue(String maxValue) {
    return 'Inserire un numero fino a $maxValue.';
  }

  @override
  String get dataAbsentReasonAskedDeclined => 'Scelgo di non rispondere.';

  @override
  String get narrativePageTitle => 'Narrativa';

  @override
  String get questionnaireGenericTitle => 'Sondaggio';

  @override
  String get questionnaireUnknownTitle => 'Senza titolo';

  @override
  String get questionnaireUnknownPublisher => 'Editore sconosciuto';

  @override
  String get validatorDate => 'Inserire una data valida.';

  @override
  String get validatorTime => 'Inserire un orario valido.';

  @override
  String get validatorDateTime => 'Inserire una data e un\'ora valide.';

  @override
  String validatorMinOccurs(int minOccurs) {
    return intl.Intl.pluralLogic(
      minOccurs,
      locale: localeName,
      one: 'Selezionare almeno un\'opzione.',
      other: 'Selezionare $minOccurs o altre opzioni.',
    );
  }

  @override
  String validatorMaxOccurs(int maxOccurs) {
    return intl.Intl.pluralLogic(
      maxOccurs,
      locale: localeName,
      one: 'Selezionare fino a un\'opzione.',
      other: 'Selezionare fino a $maxOccurs opzioni.',
    );
  }

  @override
  String validatorSingleSelectionOrSingleOpenString(Object openLabel) {
    return 'Selezionare un\'opzione o inserire un testo libero in \"$openLabel\".';
  }

  @override
  String validatorMaxSize(String maxSize) {
    return 'Selezionate un file sotto $maxSize.';
  }

  @override
  String validatorMimeTypes(String mimeTypes) {
    return 'Selezionare un file dei seguenti tipi: $mimeTypes.';
  }

  @override
  String get dataAbsentReasonAskedDeclinedInputLabel =>
      'Scelgo di non rispondere.';

  @override
  String get dataAbsentReasonAskedDeclinedOutput =>
      'Si è rifiutato di rispondere';

  @override
  String get dataAbsentReasonAsTextOutput => '[COME TESTO]';

  @override
  String get autoCompleteSearchTermInput => 'Inserisci il termine di ricerca…';

  @override
  String get responseStatusToCompleteButtonLabel => 'Completo';

  @override
  String get responseStatusToInProgressButtonLabel => 'Modificare';

  @override
  String get progressQuestionnaireLoading =>
      'Il sondaggio è in fase di caricamento…';

  @override
  String get handlingSaveButtonLabel => 'Risparmiare';

  @override
  String get handlingUploadButtonLabel => 'Caricare';

  @override
  String get handlingUploading => 'Caricamento del sondaggio…';

  @override
  String get loginStatusLoggingIn => 'Accesso…';

  @override
  String get loginStatusLoggedIn => 'Firmato in…';

  @override
  String get loginStatusLoggingOut => 'Esco…';

  @override
  String get loginStatusLoggedOut => 'Firmato fuori…';

  @override
  String get loginStatusUnknown => 'Non siete sicuri di cosa stia succedendo?';

  @override
  String get loginStatusError => 'Qualcosa è andato storto.';

  @override
  String get handlingSaved => 'Sondaggio salvato.';

  @override
  String get handlingUploaded => 'Sondaggio caricato.';

  @override
  String aggregationScore(Object score) {
    return 'Punteggio: $score';
  }

  @override
  String get aggregationTotalScoreTitle => 'Punteggio totale';

  @override
  String get fillerOpenCodingOtherLabel => 'Altro';

  @override
  String fillerAddAnotherItemLabel(Object itemLabel) {
    return 'Aggiungere un altro \"$itemLabel\"';
  }

  @override
  String get fillerExclusiveOptionLabel => '(esclusivo)';
}
