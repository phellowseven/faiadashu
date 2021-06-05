

import 'package:intl/intl.dart' as intl;
import 'fdash_localizations.g.dart';

/// The translations for Japanese (`ja`).
class FDashLocalizationsJa extends FDashLocalizations {
  FDashLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get validatorRequiredItem => 'この質問は完了する必要があります。';

  @override
  String validatorMinLength(int minLength) {
    return intl.Intl.pluralLogic(
      minLength,
      locale: localeName,
      one: '最低1文字入力してください',
      other: '最低$minLength文字入力してください。',
    );
  }

  @override
  String validatorMaxLength(int maxLength) {
    return intl.Intl.pluralLogic(
      maxLength,
      locale: localeName,
      other: '最大$maxLength文字まで入力できます。',
    );
  }

  @override
  String get validatorUrl => '有効なURLをフォーマット https://... で入力してください。';

  @override
  String get validatorRegExp => '有効な回答を入力してください。';

  @override
  String validatorEntryFormat(String entryFormat) {
    return 'フォーマット$entryFormatで入力してください。';
  }

  @override
  String get validatorDate => '有効な日付を入力してください。';

  @override
  String get validatorTime => '有効な時間を入力してください。';

  @override
  String get validatorDateTime => '有効な日付と時刻を入力してください。';

  @override
  String get validatorNan => '有効な数字を入力してください。';

  @override
  String validatorMinValue(String minValue) {
    return '$minValue以上の数値を入力してください。';
  }

  @override
  String validatorMaxValue(String maxValue) {
    return '$maxValueまでの数値を入力してください。';
  }

  @override
  String validatorMinOccurs(int minOccurs) {
    return intl.Intl.pluralLogic(
      minOccurs,
      locale: localeName,
      one: '少なくとも1つの選択肢を選ぶ',
      other: '$minOccurs以上の選択肢を選ぶ',
    );
  }

  @override
  String validatorMaxOccurs(int maxOccurs) {
    return intl.Intl.pluralLogic(
      maxOccurs,
      locale: localeName,
      one: '選択肢を1つまで選ぶ',
      other: '$maxOccurs選択肢を1つまで選ぶ',
    );
  }

  @override
  String get dataAbsentReasonAskedDeclinedInputLabel => '私は答えないことにしている。';

  @override
  String get dataAbsentReasonAskedDeclinedOutput => '回答を拒否した';

  @override
  String get dataAbsentReasonAsTextOutput => '[フリーテキスト]';

  @override
  String get narrativePageTitle => 'ナラティブ';

  @override
  String get questionnaireGenericTitle => '調査';

  @override
  String get questionnaireUnknownTitle => '無題';

  @override
  String get questionnaireUnknownPublisher => '出版社不明';

  @override
  String get autoCompleteSearchTermInput => '検索語を入力...';

  @override
  String get responseStatusToCompleteButtonLabel => '完成';

  @override
  String get responseStatusToInProgressButtonLabel => '修正';

  @override
  String get progressQuestionnaireLoading => 'アンケートの読み込み中...';

  @override
  String get handlingSaveButtonLabel => 'Save';

  @override
  String get handlingUploadButtonLabel => 'Upload';

  @override
  String get handlingUploading => 'Uploading survey…';

  @override
  String get loginStatusLoggingIn => 'Signing in…';

  @override
  String get loginStatusLoggedIn => 'Signed in…';

  @override
  String get loginStatusLoggingOut => 'Signing out…';

  @override
  String get loginStatusLoggedOut => 'Signed out…';

  @override
  String get loginStatusUnknown => 'Not sure what\'s going on?';

  @override
  String get loginStatusError => 'Something went wrong.';
}