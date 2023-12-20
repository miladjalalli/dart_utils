import 'package:entekhab_utils_plugin/common/enums/number_word_language.dart';
import 'package:entekhab_utils_plugin/common/extensions/date_extension.dart';
import 'package:entekhab_utils_plugin/common/utils/number_utils.dart';
import 'package:entekhab_utils_plugin/constant/constant.dart';
import 'package:entekhab_utils_plugin/entekhab_utils_plugin.dart';

/**
 * @Author: Milad Jalali
 * @Date: 2023/17/12
 */

extension StringExtension on String {
  ///convert 123456789 to ۱۲۳۴۵۶۷۸۹
  String toPersianDigit() {
    return NumberUtils.changeDigit(this, NumberWordLanguage.Farsi);
  }

  ///convert ۱۲۳۴۵۶۷۸۹ to 123456789
  String toEnglishDigit() {
    return NumberUtils.changeDigit(this, NumberWordLanguage.English);
  }

  ///extract number from string; abc123456789xyz to ۱۲۳۴۵۶۷۸۹  Or  ابپ۱۲۳۴۵۶۷۸۹ن to 123456789
  String extractNumber({NumberWordLanguage toDigit = NumberWordLanguage.Farsi}) {
    return NumberUtils.extractNumber(this, toDigit);
  }

  ///convert 123456789 to 123,456,789
  String seRagham({String separator = ","}) {
    return NumberUtils.seRagham(this, separator: separator);
  }

  /// convert 6037991123456789 to 6037-9911-2345-6789
  String charRagham({String separator = "-"}) {
    return NumberUtils.charRagham(this, separator: separator);
  }

  ///convert number to string , like: 1000 to 'one thousand' or 'هزار'
  String toWord({NumberWordLanguage lang = NumberWordLanguage.Farsi}) {
    return NumberUtils.toWord(this, lang);
  }

  ///convert string to number , like: هزار to 1000
  int toNumber() {
    return NumberUtils.toNumber(this);
  }

  ///string is numeric or not
  bool isNumeric() {
    return NumberUtils.isNumeric(this);
  }

  ///تبدیل تاریخ از متن به تاریخ شمسی
  String toPersianDate({NumberWordLanguage digitType = NumberWordLanguage.Farsi}) {
    try {
      var inputStr = replaceAll("/", "-");
      var splitedStr = inputStr.split("-");
      if (splitedStr[2].length == 1) {
        splitedStr[2] = "0${splitedStr[2]}";
      }
      if (splitedStr[1].length == 1) {
        splitedStr[1] = "0${splitedStr[1]}";
      }
      var changedToDate = DateTime.parse(splitedStr.join("-"));
      return changedToDate.toPersianDate(digitType: digitType);
    } catch (e) {
      return "0000/00/00";
    }
  }

  //صحیح بودن کد ملی ایرانیان
  bool isValidIranianNationalCode() {
    return NationalCode.isValidNationalCode(this);
  }

  //صحیح بودن شماره کارت بانکی
  bool isValidBankCardNumber() {
    return BankValidator.verifyCardNumber(this);
  }

  //صحیح بودن شماره موبایل ایرانیان
  bool isValidIranianMobileNumber() {
    return RegexValidators.isValidIranianMobileNumber(this);
  }

  //صحیح بودن کد پستی ایرانیان
  bool isValidIranianPostalCode() {
    return RegexValidators.isValidIranianPostalCode(this);
  }

  //تبدیل به تومان - Convert price to Toman
  String beToman() {
    var strNumber = NumberUtils.extractNumber(this, NumberWordLanguage.English);
    var convertedNumber = int.parse(strNumber);
    return (convertedNumber / 10).toString().replaceAll('.0', '');
  }

  //تبدیل به ریال - Convert price to Rial
  String beRial() {
    var strNumber = NumberUtils.extractNumber(this, NumberWordLanguage.English);
    var convertedNumber = int.parse(strNumber);
    return (convertedNumber * 10).toString();
  }

  //گرفتن نام بانک از روی شماره کارت،
  // اعتبار سنجی شماره کارت در این متد انجام نمیشود
  //حداقل رقم وارد شده 6 عدد میباشد
  String getBankNameFromCardNumber() {
    return NumberUtils.getBankNameFromCardNumber(this);
  }

  /// تبدیل حروف عربی و ... به حروف استاندارد فارسی
  String fixPersianChars() {
    return NumberUtils.fixPersianChars(this);
  }

  // ------------------------------------------

  ///اولین کاراکتر رشته را به "حروف بزرگ" و بقیه را به "حروف کوچک" تبدیل می کند.
  ///```dart
  ///'justkawal'.capitalize; // Justkawal
  ///'JUSTKAWAL'.capitalize; // Justkawal
  ///```
  String? get capitalize {
    String? result;
    if (isNotEmpty) {
      result = this[0].toUpperCase();
      if (length > 1) {
        result += substring(1).toLowerCase();
      }
    }
    return result;
  }

  ///اولین کاراکتر رشته را به حروف کوچک تبدیل می کند.
  ///```dart
  ///'Justkawal'.lowerFirst; // justkawal
  ///'JUSTKAWAL'.lowerFirst; // jUSTKAWAL
  ///```
  String? get lowerFirst {
    String? result;
    if (isNotEmpty) {
      result = this[0].toLowerCase();
      if (length > 1) {
        result += substring(1);
      }
    }
    return result;
  }

  ///اولین کاراکتر رشته را به حروف بزرگ تبدیل می کند.
  ///```dart
  ///'justkawal'.upperFirst; // Justkawal
  ///'jUSTKAWAL'.upperFirst; // JUSTKAWAL
  ///```
  String get upperFirst {
    var result = '';
    if (isNotEmpty) {
      result = this[0].toUpperCase();
      if (length > 1) {
        result += substring(1);
      }
    }
    return result;
  }

  ///"فهرست کلمات" را برمی گرداند
  ///```dart
  ///'kàwàl vu'.words; // ['kàwàl', 'vu']
  ///```
  List<String?> words([RegExp? pattern]) {
    if (pattern == null) {
      var list = <String?>[];
      reUnicodeWord.allMatches(this).forEach((match) {
        list.add(match[0]);
      });
      return list;
    }
    return pattern.allMatches(this).map((match) => '${match[0]}').toList();
  }

  // ------------------------------------------

  ///رشته را به 'camelCase' تبدیل می کند و آن را برمی گرداند.
  ///```dart
  ///'___just__kawal__'.camelCase; // justKawal
  ///'  just  Kawal  '.camelCase; // justKawal
  ///'-----just--Kawal--'.camelCase; // justKawal
  ///```
  String get camelCase {
    if (isEmpty) {
      return '';
    }
    var wordList = words();
    var leftSide = wordList.first!.toLowerCase();
    if (wordList.length == 1) {
      return leftSide;
    }
    var rightSide = wordList.skip(1).reduce((value, element) => value! + element!.capitalize!)!;
    return leftSide + rightSide;
  }

  ///رشته را به 'kebabCase' تبدیل می کند.
  ///```dart
  ///'___hello__world__'.kebabCase(); // hello-world
  ///'  hello  World  '.kebabCase(); // hello-world
  ///'-----hello--world--'.kebabCase(); // hello-world
  ///```
  String kebabCase({String separator = '-'}) {
    return _reuseCase(separator);
  }

  ///رشته را به حروف کوچک تبدیل می کند.
  ///```dart
  ///'___hello__world__'.lowerCase(); // hello world
  ///'  hello  World  '.lowerCase(); // hello world
  ///'-----hello--world--'.lowerCase(); // hello world
  ///```
  String lowerCase({String separator = ' '}) {
    return _reuseCase(separator);
  }

  ///رشته را به 'snakeCase' تبدیل می کند.
  ///```dart
  ///'___hello__world__'.snakeCase(); // hello_world
  ///'  helloWorld  '.snakeCase(); // hello_world
  ///'-----hello--world--'.snakeCase(); // hello_world
  ///```
  String snakeCase({String separator = '_'}) {
    return _reuseCase(separator);
  }

  ///A helper function for reusing the same functionality of `snakeCase`, `lowerCase` and `kebabCase`.
  String _reuseCase(String separator) {
    return words().map((word) => word!.toLowerCase()).toList().join(separator);
  }

  ///رشته را به 'nameCase' تبدیل می کند و آن را برمی گرداند.
  ///```dart
  ///'___kaWaljeet__sInGH__'.nameCase(); // Kawaljeet Singh
  ///'  justKawal  '.nameCase(); // Just Kawal
  ///'-----kawaljeet--singh--'.nameCase(); // Kawaljeet Singh
  ///```
  String nameCase({String separator = ' '}) {
    return words().map((word) => word!.capitalize).toList().join(separator);
  }
}
