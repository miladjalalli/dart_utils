/**
 * @Author: Milad Jalali
 * @Date: 2023/17/12
 */

/// Regex Util.
class RegexUtil {
  /// Regex of simple mobile.
  static const String regexMobileSimple = '^(?:[+0]9)?[0-9]{10}\$';

  /// Regex of telephone number.
  static const String regexTel = '^0\\d{2,3}[- ]?\\d{7,8}';

  /// Regex of email.
  static const String regexEmail =
      '^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*\$';

  /// Regex of url.
  static const String regexUrl = '[a-zA-Z]+://[^\\s]*';

  /// Regex of date which pattern is 'yyyy-MM-dd'.
  static const String regexDate =
      '^(?:(?!0000)[0-9]{4}-(?:(?:0[1-9]|1[0-2])-(?:0[1-9]|1[0-9]|2[0-8])|(?:0[13-9]|1[0-2])-(?:29|30)|(?:0[13578]|1[02])-31)|(?:[0-9]{2}(?:0[48]|[2468][048]|[13579][26])|(?:0[48]|[2468][048]|[13579][26])00)-02-29)\$';

  /// Regex of ip address.
  static const String regexIp =
      r'^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$';

  /// must contain letters and numbers, 6 ~ 18.
  static const String regexUsername =
      '^(?![0-9]+\$)(?![a-zA-Z]+\$)[0-9A-Za-z]{6,18}\$';

  /// must contain letters and numbers, can contain special characters 6 ~ 18.
  static const String regexUsername2 =
      '^(?![0-9]+\$)(?![a-zA-Z]+\$)[0-9A-Za-z\\W]{6,18}\$';

  /// must contain letters and numbers and special characters, 6 ~ 18.
  static const String regexUsername3 =
      '^(?![0-9]+\$)(?![a-zA-Z]+\$)(?![0-9a-zA-Z]+\$)(?![0-9\\W]+\$)(?![a-zA-Z\\W]+\$)[0-9A-Za-z\\W]{6,18}\$';

  /// Regex of Passport.
  static const String regexPassport =
      r'(^[EeKkGgDdSsPpHh]\d{8}$)|(^(([Ee][a-fA-F])|([DdSsPp][Ee])|([Kk][Jj])|([Mm][Aa])|(1[45]))\d{7}$)';

  /// Return whether input matches regex of telephone number.
  static bool isTel(String input) {
    return matches(regexTel, input);
  }

  /// Return whether input matches regex of email.
  static bool isEmail(String input) {
    return matches(regexEmail, input);
  }

  /// Return whether input matches regex of url.
  static bool isURL(String input) {
    return matches(regexUrl, input);
  }

  /// Return whether input matches regex of date which pattern is 'yyyy-MM-dd'.
  static bool isDate(String input) {
    return matches(regexDate, input);
  }

  /// Return whether input matches regex of ip address.
  static bool isIP(String input) {
    return matches(regexIp, input);
  }

  /// Return whether input matches regex of username.
  static bool isUserName(String input, {String regex = regexUsername}) {
    return matches(regex, input);
  }

  ///Return whether input matches regex of Passport.
  static bool isPassport(String input) {
    return matches(regexPassport, input);
  }

  static bool matches(String regex, String input) {
    if (input.isEmpty) return false;
    return RegExp(regex).hasMatch(input);
  }
}
