library persian_number_utility;
import 'package:entekhab_utils_plugin/common/enums/number_word_language.dart';
import 'package:entekhab_utils_plugin/constant/constant.dart';

/**
 * @Author: Milad Jalali
 * @Date: 2023/17/12
 */

class NumberUtils {
  ///convert number to string , like: 1000 to 'one thousand' or 'هزار'
  static String toWord(String number, NumberWordLanguage lang) {
    String _words = "";
    String _result = "";
    number = changeDigit(number, NumberWordLanguage.English);
    number = extractNumber(number, NumberWordLanguage.English);
    if (!isNumeric(number)) {
      return "";
    }
    if (number == "") {
      return '';
    }
    switch (lang) {
      case NumberWordLanguage.English:
        _words = _toWordEn(number);
        break;
      case NumberWordLanguage.Farsi:
        _words = _toWordFa(number);
        break;
    }
    _result = _words.replaceAll("^\\s+", "").replaceAll("\\b\\s{2,}\\b", " ");
    return _result.trim();
  }

  /// Converts a string like 'هزار' to 1000
  static int toNumber(String word) {
    List<String> words = word.split(" و");
    int finalValue = 0;
    int tempValue = 0;
    for (var word in words) {
      List<String> temps = word.split(" ");
      for (var item in temps) {
        if (numsMap.containsKey(item)) {
          tempValue += numsMap[item] ?? 0;
        } else if (tensMap.containsKey(item)) {
          tempValue += tensMap[item] ?? 0;
        } else if (thousandsMap.containsKey(item)) {
          tempValue += thousandsMap[item] ?? 0;
        } else if (millionsMap.containsKey(item)) {
          if (tempValue == 0) {
            tempValue += millionsMap[item]!;
          } else {
            tempValue *= millionsMap[item]!;
          }
          finalValue += tempValue;
          tempValue = 0;
        } else {
          throw Exception("Not correct format / Wrong language!");
        }
      }
    }
    finalValue += tempValue;
    return finalValue;
  }

  ///string is numeric or not
  static bool isNumeric(String? s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  ///convert 123456789 to 123,456,789
  static String seRagham(String number, {String separator = ","}) {
    String str = "";
    var numberSplit = number.split('.');
    number = numberSplit[0].replaceAll(separator, '');
    for (var i = number.length; i > 0;) {
      if (i > 3) {
        str = separator + number.substring(i - 3, i) + str;
      } else {
        str = number.substring(0, i) + str;
      }
      i = i - 3;
    }
    if (numberSplit.length > 1) {
      str += '.${numberSplit[1]}';
    }
    return str;
  }

  ///convert 123456789 to ۱۲۳۴۵۶۷۸۹  Or  ۱۲۳۴۵۶۷۸۹ to 123456789
  static String changeDigit(String number, NumberWordLanguage toDigit) {
    var persianNumbers = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];
    var arabicNumbers = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
    var enNumbers = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "."];

    if (toDigit == NumberWordLanguage.English) {
      for (var i = 0; i < 10; i++) {
        number = number.replaceAll(RegExp(persianNumbers[i]), enNumbers[i]).replaceAll(RegExp(arabicNumbers[i]), enNumbers[i]);
      }
    } else {
      for (var i = 0; i < 10; i++) {
        number = number.replaceAll(RegExp(enNumbers[i]), persianNumbers[i]).replaceAll(RegExp(enNumbers[i]), arabicNumbers[i]);
      }
    }
    return number;
  }

  ///extract number from string; abc123456789xyz to ۱۲۳۴۵۶۷۸۹  Or  ابپ۱۲۳۴۵۶۷۸۹ن to 123456789
  static String extractNumber(String inputString, NumberWordLanguage toDigit) {
    String number = "";
    inputString = changeDigit(inputString, NumberWordLanguage.English);
    number = inputString.replaceAll(RegExp(r'[^0-9]'), ''); // '23'
    return changeDigit(number, toDigit);
  }

  /// بدست اوردن نام ماه شمسی
  static String getPersianMonthLetter(String monthNumber) {
    monthNumber = changeDigit(monthNumber, NumberWordLanguage.English);
    String outputText = "";
    if (monthNumber.startsWith('0')) {
      monthNumber = monthNumber.replaceAll("0", "");
    }
    switch (monthNumber) {
      case "1":
        {
          outputText = "فروردین";
          break;
        }
      case "2":
        {
          outputText = "اردیبهشت";
          break;
        }
      case "3":
        {
          outputText = "خرداد";
          break;
        }
      case "4":
        {
          outputText = "تیر";
          break;
        }
      case "5":
        {
          outputText = "مرداد";
          break;
        }
      case "6":
        {
          outputText = "شهریور";
          break;
        }

      case "7":
        {
          outputText = "مهر";
          break;
        }
      case "8":
        {
          outputText = "ابان";
          break;
        }
      case "9":
        {
          outputText = "اذر";
          break;
        }

      case "10":
        {
          outputText = "دی";
          break;
        }
      case "11":
        {
          outputText = "بهمن";
          break;
        }
      case "12":
        {
          outputText = "اسفند";
          break;
        }
    }
    return outputText;
  }

  /// بدست اوردن نام روز
  static String getPersianDayLetter(String dayNumber) {
    dayNumber = changeDigit(dayNumber, NumberWordLanguage.English);
    String outputText = "";
    if (dayNumber.startsWith('0')) dayNumber = dayNumber.replaceAll("0", "");
    switch (dayNumber) {
      case "1":
        {
          outputText = "دوشنبه";
          break;
        }
      case "2":
        {
          outputText = "سه شنبه";
          break;
        }
      case "3":
        {
          outputText = "چهارشنبه";
          break;
        }
      case "4":
        {
          outputText = "پنج شنبه";
          break;
        }
      case "5":
        {
          outputText = "جمعه";
          break;
        }
      case "6":
        {
          outputText = "شنبه";
          break;
        }
      case "7":
        {
          outputText = "یکشنبه";
          break;
        }
    }
    return outputText;
  }

  static String getBankNameFromCardNumber(String cartNumber) {
    if (cartNumber.length < 6) {
      return '-';
    }
    cartNumber = cartNumber.substring(0, 6);

    switch (cartNumber) {
      case '603769':
        return 'بانک صادرات ایران';

      case '636214':
        return 'بانک آینده';

      case '627381':
        return 'بانک انصار';

      case '505785':
        return 'بانک ایران زمین';

      case '622106':
      case '627884':
      case '639194':
        return 'بانک پارسیان';

      case '502229':
      case '639347':
        return 'بانک پاسارگاد';

      case '627760':
        return 'پست بانک ایران';

      case '585983':
      case '627353':
        return 'بانک تجارت';

      case '502908':
        return 'بانک توسعه تعاون';

      case '504172':
        return 'بانک رسالت';

      case '207177':
      case '627648':
        return 'بانک توسعه صادرات';

      case '636949':
        return 'بانک حکمت ایرانیان';

      case '585947':
        return 'بانک خاورمیانه';

      case '627412':
        return 'بانک اقتصاد نوین';

      case '502938':
        return 'بانک دی';

      case '589463':
        return 'بانک رفاه کارگران';

      case '621986':
        return 'بانک سامان';

      case '589210':
        return 'بانک سپه';

      case '639607':
        return 'بانک سرمایه';

      case '639346':
        return 'بانک سینا';

      case '504706':
      case '502806':
        return 'بانک شهر';

      case '627961':
        return 'بانک صنعت و معدن';

      case '639599':
        return 'بانک قوامین';

      case '627488':
      case '502910':
        return 'بانک کارآفرین';

      case '639217':
      case '603770':
        return 'بانک کشاورزی';

      case '505416':
        return 'بانک گردشگری';

      case '636795':
        return 'بانک مرکزی';

      case '628023':
        return 'بانک مسکن';

      case '991975':
      case '610433':
        return 'بانک ملت';

      case '603799':
        return 'بانک ملی ایران';

      case '606373':
        return 'بانک قرض الحسنه مهر ایران';

      case '505801':
        return 'موسسه کوثر';

      case '606256':
        return 'موسسه اعتباری ملل';

      case '628157':
        return 'موسسه اعتباری توسعه';

      case '639370':
        return 'بانک مهر اقتصاد';

      default:
        return '-';
    }
  }

  /// جداسازی چهار رقم اعداد (استفاده معمول برای خوانا کردن شماره کارت)
  static String charRagham(String inputNumber, {String separator = "-"}) {
    String outputString = "";
    var numberSplit = inputNumber.split('.');
    inputNumber = numberSplit[0].replaceAll(separator, '');
    for (var i = inputNumber.length; i > 0;) {
      if (i > 4) {
        outputString = separator + inputNumber.substring(i - 4, i) + outputString;
      } else {
        outputString = inputNumber.substring(0, i) + outputString;
      }
      i = i - 4;
    }
    return outputString;
  }

  /// تبدیل حروف عربی و ... به حروف استاندارد فارسی
  static String fixPersianChars(String inputString) {
    return inputString
        .replaceAll("ﮎ", "ک")
        .replaceAll("ﮏ", "ک")
        .replaceAll("ﮐ", "ک")
        .replaceAll("ﮑ", "ک")
        .replaceAll("ك", "ک")
        .replaceAll("ي", "ی")
        .replaceAll(" ", " ")
        .replaceAll("ھ", "ه")
        .replaceAll("ئ", "ی");
  }


  static String _toWordFa(String inputNumber) {
    int number = int.parse(inputNumber);
    if (number == 0) {
      return "صفر";
    }
    String fullNumber = inputNumber;
    for (var i = 0; i < 15 - fullNumber.length; i++) {
      inputNumber = "0$inputNumber";
    }
    fullNumber = inputNumber;

    int trillion = int.parse(fullNumber.substring(0, 3));
    int billions = int.parse(fullNumber.substring(3, 6));
    int millions = int.parse(fullNumber.substring(6, 9));
    int hundredThousands = int.parse(fullNumber.substring(9, 12));
    int thousands = int.parse(fullNumber.substring(12, 15));

    String tradtrillion;

    switch (trillion) {
      case 0:
        tradtrillion = "";
        break;
      case 1:
        tradtrillion = "${_convertLessThanOneThousandFa(trillion)} تریلیون ";
        break;
      default:
        tradtrillion = "${_convertLessThanOneThousandFa(trillion)} تریلیون و";
    }
    String result = tradtrillion;

    String tradBillions;

    switch (billions) {
      case 0:
        tradBillions = "";
        break;
      default:
        tradBillions = "${_convertLessThanOneThousandFa(billions)} میلیارد و";
    }
    result += tradBillions;

    String tradMillions;

    switch (millions) {
      case 0:
        tradMillions = "";
        break;
      default:
        tradMillions = "${_convertLessThanOneThousandFa(millions)} میلیون و";
    }
    result = result + tradMillions;

    String tradHundredThousands;
    switch (hundredThousands) {
      case 0:
        tradHundredThousands = "";
        break;
      case 1:
        tradHundredThousands = "هزار و";
        break;
      default:
        tradHundredThousands = "${_convertLessThanOneThousandFa(hundredThousands)} هزار و";
    }
    result = result + tradHundredThousands;

    String tradThousand;
    tradThousand = _convertLessThanOneThousandFa(thousands);
    result = result + tradThousand;

    if (result.endsWith(" و")) {
      result = result.substring(0, result.length - 2);
    }

    return result;
  }

  static String _convertLessThanOneThousandFa(int number) {
    String soFar;
    if (number % 100 < 20) {
      soFar = numNames[number % 100];
      number = number ~/ 100;
    } else {
      soFar = numNames[number % 10];
      number = number ~/ 10;
      soFar = tensNames[number % 10] + soFar;
      number = number ~/ 10;
    }
    if (number == 0) {
      if (soFar.endsWith(" و")) {
        soFar = soFar.substring(0, soFar.length - 2);
      }
      return soFar;
    }
    var str = "";
    str = (thousandsNames[number] + soFar);
    if (str.endsWith(" و") || str.endsWith("و ")) {
      str = str.substring(0, str.length - 2);
    }
    return str;
  }

  static String _toWordEn(String inputNumber) {
    int number = int.parse(inputNumber);
    if (number == 0) {
      return "zero";
    }
    String fullNumber = inputNumber;
    for (var i = 0; i < 15 - fullNumber.length; i++) {
      inputNumber = "0$inputNumber";
    }
    fullNumber = inputNumber;
    int trillion = int.parse(fullNumber.substring(0, 3));
    int billions = int.parse(fullNumber.substring(3, 6));
    int millions = int.parse(fullNumber.substring(6, 9));
    int hundredThousands = int.parse(fullNumber.substring(9, 12));
    int thousands = int.parse(fullNumber.substring(12, 15));

    String tradtrillion;

    switch (trillion) {
      case 0:
        tradtrillion = "";
        break;
      case 1:
        tradtrillion = "${_convertLessThanOneThousand(trillion)} Trillion ";
        break;
      default:
        tradtrillion = "${_convertLessThanOneThousand(trillion)} Trillion ";
    }
    String result = tradtrillion;

    String tradBillions;

    switch (billions) {
      case 0:
        tradBillions = "";
        break;
      case 1:
        tradBillions = "${_convertLessThanOneThousand(billions)} billion ";
        break;
      default:
        tradBillions = "${_convertLessThanOneThousand(billions)} billion ";
    }
    result += tradBillions;

    String tradMillions;

    switch (millions) {
      case 0:
        tradMillions = "";
        break;
      case 1:
        tradMillions = "${_convertLessThanOneThousand(millions)} million ";
        break;
      default:
        tradMillions = "${_convertLessThanOneThousand(millions)} million ";
    }
    result = result + tradMillions;

    String tradHundredThousands;
    switch (hundredThousands) {
      case 0:
        tradHundredThousands = "";
        break;
      case 1:
        tradHundredThousands = "one thousand ";
        break;
      default:
        tradHundredThousands = "${_convertLessThanOneThousand(hundredThousands)} thousand ";
    }
    result = result + tradHundredThousands;

    String tradThousand;
    tradThousand = _convertLessThanOneThousand(thousands);
    result = result + tradThousand;
    return result;
  }

  static String _convertLessThanOneThousand(int number) {
    List<String> tensNames = ["", " ten", " twenty", " thirty", " forty", " fifty", " sixty", " seventy", " eighty", " ninety"];

    List<String> numNames = [
      "",
      " one",
      " two",
      " three",
      " four",
      " five",
      " six",
      " seven",
      " eight",
      " nine",
      " ten",
      " eleven",
      " twelve",
      " thirteen",
      " fourteen",
      " fifteen",
      " sixteen",
      " seventeen",
      " eighteen",
      " nineteen"
    ];
    String soFar;
    if (number % 100 < 20) {
      soFar = numNames[number % 100];
      number = number ~/ 100;
    } else {
      soFar = numNames[number % 10];
      number = number ~/ 10;
      soFar = tensNames[number % 10] + soFar;
      number = number ~/ 10;
    }
    if (number == 0) {
      return soFar;
    }
    return "${numNames[number]} hundred$soFar";
  }
}