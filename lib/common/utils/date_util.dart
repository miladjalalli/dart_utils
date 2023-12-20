/**
 * @Author: Milad Jalali
 * @Date: 2023/17/12
 */

class DateUtils {


  toJalali(int y, int m, int d, {bool twoDigits = false}) {
    var sumMonthDay = [0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334];
    var jY = 0;
    if (y > 1600) {
      jY = 979;
      y -= 1600;
    } else {
      jY = 0;
      y -= 621;
    }
    var gy = (m > 2) ? y + 1 : y;
    var day = (365 * y) + ((gy + 3) ~/ 4) - ((gy + 99) ~/ 100) + ((gy + 399) ~/ 400) - 80 + d + sumMonthDay[m - 1];
    jY += 33 * (day.round() / 12053).floor();
    day %= 12053;
    jY += 4 * (day.round() / 1461).floor();
    day %= 1461;
    jY += ((day.round() - 1) / 365).floor();
    if (day > 365) day = ((day - 1).round() % 365);
    int jm;
    int jd;
    int days = day.toInt();
    if (days < 186) {
      jm = 1 + (days ~/ 31);
      jd = 1 + (days % 31);
    } else {
      jm = 7 + ((days - 186) ~/ 30);
      jd = 1 + (days - 186) % 30;
    }
    String persionDate;
    String monthString = twoDigits ? jm.toString().padLeft(2, '0') : jm.toString();
    String dayString = twoDigits ? jd.toString().padLeft(2, '0') : jd.toString();

    persionDate = "$jY/$monthString/$dayString";
    return persionDate;
  }

  jalaliToGregorian(int y, int m, int d, [String separator = "/"]) {
    int gY;
    if (y > 979) {
      gY = 1600;
      y -= 979;
    } else {
      gY = 621;
    }

    var days = (365 * y) + ((y / 33).floor() * 8) + (((y % 33) + 3) / 4) + 78 + d + (((m < 7) ? (m - 1) * 31 : (((m - 7) * 30) + 186)));
    gY += 400 * (days ~/ 146097);
    days %= 146097;
    if (days.floor() > 36524) {
      gY += 100 * (--days ~/ 36524);
      days %= 36524;
      if (days >= 365) days++;
    }
    gY += 4 * (days ~/ 1461);
    days %= 1461;
    gY += (days - 1) ~/ 365;

    if (days > 365) days = (days - 1) % 365;
    var gD = (days + 1).floor();
    var montDays = [0, 31, (((gY % 4 == 0) && (gY % 100 != 0)) || (gY % 400 == 0)) ? 29 : 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
    int i = 0;
    for (; i <= 12; i++) {
      if (gD <= montDays[i]) break;
      gD -= montDays[i];
    }
    String gregorianDate;
    gregorianDate = "$gY$separator$i$separator$gD";
    return gregorianDate;
  }

  ///نمایش اختلاف بین دو تاریخ به صورت خلاصه وار و متنی انگلیسی
  static String getStringDate(DateTime inputDatetime,
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
    systemDatetime ??= DateTime.now();

    final differenceInDays = systemDatetime.difference(inputDatetime).inDays;
    if (differenceInDays > days) {
      if (differenceInDays > 7 && differenceInDays < 14) {
        return lastWeekText;
      } else if (differenceInDays < 7 * weeks) {
        return aFewWeeksAgoText;
      } else if (differenceInDays >= 30 && differenceInDays < 60) {
        return lastMonthText;
      } else if (differenceInDays < 30 * months) {
        return aFewMonthsAgoText;
      } else if (differenceInDays >= 365 && differenceInDays < 730) {
        return lastYearText;
      } else {
        return someYearsAgoText;
      }
    } else {
      final differenceInSeconds = systemDatetime.difference(inputDatetime).inSeconds;
      if (differenceInSeconds < seconds) {
        return aFewSecondsAgoText;
      } else if (differenceInSeconds < 60 * minutes) {
        return aFewMinutesAgoText;
      } else if (differenceInSeconds < 3600 * hours) {
        return someHoursAgoText;
      } else if (differenceInSeconds >= 3600 * 24 && differenceInSeconds < 3600 * 24 * 2) {
        return yesterdayText;
      } else {
        return aFewDaysAgoText;
      }
    }
  }
}
