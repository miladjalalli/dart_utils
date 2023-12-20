import 'package:entekhab_utils_plugin/common/enums/number_word_language.dart';
import 'package:entekhab_utils_plugin/common/utils/date_util.dart';
import 'package:entekhab_utils_plugin/common/utils/number_utils.dart';
import 'package:entekhab_utils_plugin/entekhab_utils_plugin.dart';


/**
 * @Author: Milad Jalali
 * @Date: 2023/17/12
 */

extension DateTimeExtension on DateTime {
  ///نمایش اختلاف بین دو تاریخ به صورت خلاصه وار و متنی به زبان انگلیسی
  String getDifferenceDateString(
      {int seconds = 60,
      int minutes = 60,
      int hours = 24,
      int days = 7,
      int weeks = 4,
      int months = 12,
      DateTime? systemDatetime,
      String aFewSecondsAgoText = "moments ago",
      String aFewMinutesAgoText = "a few minutes ago",
      String someHoursAgoText = "hours ago",
      String yesterdayText = "yesterday",
      String aFewDaysAgoText = "A few days ago",
      String lastWeekText = "last week",
      String aFewWeeksAgoText = "A few weeks ago",
      String lastMonthText = "last month",
      String aFewMonthsAgoText = "a few months ago",
      String lastYearText = "last year",
      String someYearsAgoText = "A few years ago"}) {
    return DateUtils.getStringDate(this,
        seconds: seconds,
        minutes: minutes,
        hours: hours,
        days: days,
        weeks: weeks,
        months: months,
        systemDatetime: systemDatetime,
        aFewSecondsAgoText: aFewSecondsAgoText,
        aFewMinutesAgoText: aFewMinutesAgoText,
        someHoursAgoText: someHoursAgoText,
        yesterdayText: yesterdayText,
        aFewDaysAgoText: aFewDaysAgoText,
        lastWeekText: lastWeekText,
        aFewWeeksAgoText: aFewWeeksAgoText,
        lastMonthText: lastMonthText,
        aFewMonthsAgoText: aFewMonthsAgoText,
        lastYearText: lastYearText,
        someYearsAgoText: someYearsAgoText);
  }

  ///نمایش اختلاف بین دو تاریخ به صورت خلاصه وار و متنی به زبان فارسی
  String getDifferenceDateStringFa(
      {int seconds = 60,
      int minutes = 60,
      int hours = 24,
      int days = 7,
      int weeks = 4,
      int months = 12,
      DateTime? systemDatetime,
      String aFewSecondsAgoText = "لحظاتی پیش",
      String aFewMinutesAgoText = "دقایقی پیش",
      String someHoursAgoText = "ساعاتی پیش",
      String yesterdayText = "دیروز",
      String aFewDaysAgoText = "چند روز پیش",
      String lastWeekText = "هفته پیش",
      String aFewWeeksAgoText = "چند هفته پیش",
      String lastMonthText = "ماه پیش",
      String aFewMonthsAgoText = "چند ماه پیش",
      String lastYearText = "سال پیش",
      String someYearsAgoText = "چند سال پیش"}) {
    return DateUtils.getStringDate(this,
        seconds: seconds,
        minutes: minutes,
        hours: hours,
        days: days,
        weeks: weeks,
        months: months,
        systemDatetime: systemDatetime,
        aFewSecondsAgoText: aFewSecondsAgoText,
        aFewMinutesAgoText: aFewMinutesAgoText,
        someHoursAgoText: someHoursAgoText,
        yesterdayText: yesterdayText,
        aFewDaysAgoText: aFewDaysAgoText,
        lastWeekText: lastWeekText,
        aFewWeeksAgoText: aFewWeeksAgoText,
        lastMonthText: lastMonthText,
        aFewMonthsAgoText: aFewMonthsAgoText,
        lastYearText: lastYearText,
        someYearsAgoText: someYearsAgoText);
  }

  ///تبدیل تاریخ میلادی به نوشتاری شمسی
  String toPersianDateStr({
    bool strYear = false,
    bool strMonth = true,
    bool strDay = false,
    bool showDayStr = false,
    String seprator = " ",
    String monthString = " ",
  }) {
    var input = toPersianDate();
    var splitedStr = input.split("/");
    String outputString = "";

    outputString += showDayStr ? NumberUtils.getPersianDayLetter(weekday.toString()) + seprator : "";

    outputString += strDay ? splitedStr[2].toWord() : splitedStr[2];
    outputString += seprator;

    outputString += strMonth ? NumberUtils.getPersianMonthLetter(splitedStr[1]) + monthString : splitedStr[1];
    outputString += seprator;

    outputString += strYear ? splitedStr[0].toWord() : splitedStr[0];

    return outputString;
  }

  ///تبدیل تاریخ میلادی به تاریخ شمسی
  String toPersianDate(
      {NumberWordLanguage digitType = NumberWordLanguage.Farsi,
      bool twoDigits = true,
      bool showTime = false,
      String timeSeprator = " ",
      bool changeDirectionShowTimw = true,
      bool showTimeSecond = false}) {
    DateUtils persianDate = DateUtils();
    String time = "";
    if (showTime) {
      time = "${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}";
      if (showTimeSecond) {
        time = "$time:${second.toString().padLeft(2, '0')}";
      }
      if (changeDirectionShowTimw) {
        time = timeSeprator + time;
      } else {
        time = time + timeSeprator;
      }
    }

    if (changeDirectionShowTimw) {
      return NumberUtils.changeDigit(persianDate.toJalali(year, month, day, twoDigits: twoDigits).toString() + time, digitType);
    } else {
      return NumberUtils.changeDigit(time + persianDate.toJalali(year, month, day, twoDigits: twoDigits).toString(), digitType);
    }
  }

  ///دریافت نام روز هفته تاریخ میلادی.
  ///```dart
  ///DateTime(2023,12,1)..weekdayName() ; // Friday
  String? weekdayName() {
    const Map<int, String> weekdayName = {1: "Monday", 2: "Tuesday", 3: "Wednesday", 4: "Thursday", 5: "Friday", 6: "Saturday", 7: "Sunday"};
    return weekdayName[weekday];
  }

  ///تبدیل تاریخ میلادی به متن
  ///
  /// MM month index
  /// MMM month name
  /// dd day index
  /// ddd day name in week
  String formatDefault({String format = 'yyyy-MM-dd HH:mm:ss'}) {
    String formattedDate = format;
    formattedDate = formattedDate.replaceAll('yyyy', year.toString());
    formattedDate = formattedDate.replaceAll('MMM', _getMonthAbbreviation(month));
    formattedDate = formattedDate.replaceAll('MM', month.toString().padLeft(2, '0'));
    formattedDate = formattedDate.replaceAll('MM', month.toString().padLeft(2, '0'));
    formattedDate = formattedDate.replaceAll('ddd', weekdayName()!);
    formattedDate = formattedDate.replaceAll('dd', day.toString().padLeft(2, '0'));
    formattedDate = formattedDate.replaceAll('HH', hour.toString().padLeft(2, '0'));
    formattedDate = formattedDate.replaceAll('mm', minute.toString().padLeft(2, '0'));
    formattedDate = formattedDate.replaceAll('ss', second.toString().padLeft(2, '0'));
    return formattedDate;
  }

  String _getMonthAbbreviation(int month) {
    switch (month) {
      case 1:
        return 'Jan';
      case 2:
        return 'Feb';
      case 3:
        return 'Mar';
      case 4:
        return 'Apr';
      case 5:
        return 'May';
      case 6:
        return 'Jun';
      case 7:
        return 'Jul';
      case 8:
        return 'Aug';
      case 9:
        return 'Sep';
      case 10:
        return 'Oct';
      case 11:
        return 'Nov';
      case 12:
        return 'Dec';
      default:
        return '';
    }
  }
}
