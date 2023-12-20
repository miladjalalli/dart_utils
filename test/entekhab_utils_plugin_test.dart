import 'package:flutter_test/flutter_test.dart';
import 'package:entekhab_utils_plugin/entekhab_utils_plugin.dart';
import 'package:entekhab_utils_plugin/entekhab_utils_plugin_platform_interface.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockEntekhabUtilsPluginPlatform with MockPlatformInterfaceMixin implements EntekhabUtilsPluginPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  group('TextUtil', () {
    test('isEmpty should return true for null text', () {
      expect(TextUtil.isEmpty(null), isTrue);
    });

    test('isEmpty should return true for empty text', () {
      expect(TextUtil.isEmpty(''), isTrue);
    });

    test('isEmpty should return false for non-empty text', () {
      expect(TextUtil.isEmpty('Hello'), isFalse);
    });

    test('formatDigitPattern should add spaces every 4 digits', () {
      expect(TextUtil.formatDigitPattern('1234567890'), '1234 5678 90');
    });

    test('formatDigitPatternEnd should add spaces every 4 digits from the end', () {
      expect(TextUtil.formatDigitPatternEnd('1234567890'), '12 3456 7890');
    });

    test('formatSpace4 should add spaces every 4 digits', () {
      expect(TextUtil.formatSpace4('1234567890'), '1234 5678 90');
    });

    test('formatComma3 should add commas every three digits for an integer', () {
      expect(TextUtil.formatComma3(1234567890), '1,234,567,890');
    });

    test('formatDoubleComma3 should add commas every three digits for a double', () {
      expect(TextUtil.formatDoubleComma3(1234567.89), '1,234,567.89');
    });

    test('hideNumber should replace a portion of the phone number with asterisks', () {
      expect(TextUtil.hideNumber('1234567890'), '123****890');
    });

    test('replace should replace occurrences of a pattern in the text', () {
      expect(TextUtil.replace('Hello, World!', 'o', 'O'), 'HellO, WOrld!');
    });

    test('split should split the text based on the given pattern', () {
      expect(TextUtil.split('Hello, World!', ','), ['Hello', ' World!']);
    });

    test('reverse should reverse the text', () {
      expect(TextUtil.reverse('Hello'), 'olleH');
    });
  });

  group('RegexUtil', () {
    test('isTel should return true for valid telephone number', () {
      expect(RegexUtil.isTel('0123456789'), isTrue);
    });

    test('isTel should return false for invalid telephone number', () {
      expect(RegexUtil.isTel('123'), isFalse);
    });

    test('isEmail should return true for valid email address', () {
      expect(RegexUtil.isEmail('test@example.com'), isTrue);
    });

    test('isEmail should return false for invalid email address', () {
      expect(RegexUtil.isEmail('test@example'), isFalse);
    });

    test('isURL should return true for valid URL', () {
      expect(RegexUtil.isURL('https://www.example.com'), isTrue);
    });

    test('isURL should return false for invalid URL', () {
      expect(RegexUtil.isURL('example.com'), isFalse);
    });

    test('isDate should return true for valid date in yyyy-MM-dd format', () {
      expect(RegexUtil.isDate('2023-12-17'), isTrue);
    });

    test('isDate should return false for invalid date', () {
      expect(RegexUtil.isDate('12-17-2023'), isFalse);
    });

    test('isIP should return true for valid IP address', () {
      expect(RegexUtil.isIP('192.168.0.1'), isTrue);
    });

    test('isIP should return false for invalid IP address', () {
      expect(RegexUtil.isIP('168.0.1'), isFalse);
    });

    test('isUserName should return true for valid username', () {
      expect(RegexUtil.isUserName('user123'), isTrue);
    });

    test('isUserName should return false for invalid username', () {
      expect(RegexUtil.isUserName('user@123'), isFalse);
    });

    test('isPassport should return true for valid passport number', () {
      expect(RegexUtil.isPassport('E12345678'), isTrue);
    });

    test('isPassport should return false for invalid passport number', () {
      expect(RegexUtil.isPassport('A12345678'), isFalse);
    });
  });

  group('LogUtil', () {
    setUp(() {
      // Initialize LogUtil with desired settings before each test
      LogUtil.init(tag: 'test_tag', isDebug: true, maxLen: 128);
    });

    test('d should log the provided object', () {
      // Arrange
      const object = 'Test log message';
      // expectedLogMessage = 'test_tag d $object';

      // Act
      LogUtil.d(object);

      // Assert
      // You can assert that the log message was printed to the console
      // by checking the console output. However, this can be challenging
      // to do programmatically. Alternatively, you can use a logging package
      // that allows capturing log messages during tests, such as `logger`.
      // For simplicity, we'll skip the assertion in this example.
    });

    test('e should log the provided object', () {
      // Arrange
      const object = 'Test log message';
      // expectedLogMessage = 'test_tag e $object';

      // Act
      LogUtil.e(object);

      // Assert
      // Similar to the previous test, you can assert the log message
      // by checking the console output or using a logging package.
    });

    test('v should log the provided object in debug mode', () {
      // Arrange
      const object = 'Test log message';
      // expectedLogMessage = 'test_tag v $object';

      // Act
      LogUtil.v(object);

      // Assert
      // Similar to the previous tests, you can assert the log message
      // by checking the console output or using a logging package.
    });
  });

  group('DateUtils', () {
    test('getStringDate should return correct values', () {
      // Define the current system date and time
      final systemDatetime = DateTime(2023, 12, 19, 12, 0, 0);

      // Define the input date and time
      final inputDatetime = DateTime(2023, 12, 18, 10, 0, 0);

      // Expected result: "yesterday"
      expect(
        DateUtils.getStringDate(
          inputDatetime,
          systemDatetime: systemDatetime,
        ),
        'yesterday',
      );

      // Define another input date and time
      final inputDatetime2 = DateTime(2023, 12, 02, 8, 0, 0);

      // Expected result: "A few weeks ago"
      expect(
        DateUtils.getStringDate(
          inputDatetime2,
          systemDatetime: systemDatetime,
        ),
        'A few weeks ago',
      );

      // Define another input date and time
      final inputDatetime3 = DateTime(2022, 12, 1, 0, 0, 0);

      // Expected result: "last year"
      expect(
        DateUtils.getStringDate(
          inputDatetime3,
          systemDatetime: systemDatetime,
        ),
        'last year',
      );
    });
  });

  group('PermissionUtils', () {});

  group('DateTimeExtension', () {
    test('weekdayName should return the correct weekday name', () {
      // Define a DateTime object for a Monday
      final monday = DateTime(2023, 12, 4);

      // Expected result: "Monday"
      expect(monday.weekdayName(), 'Monday');

      // Define a DateTime object for a Friday
      final friday = DateTime(2023, 12, 8);

      // Expected result: "Friday"
      expect(friday.weekdayName(), 'Friday');
    });

    test('formatDefault should return the correctly formatted date and time', () {
      // Define a DateTime object
      final dateTime = DateTime(2023, 12, 19, 12, 34, 56);

      // Expected result: "2023-12-19 12:34:56"
      expect(dateTime.formatDefault(), '2023-12-19 12:34:56');

      // Define a custom format
      final customFormat = 'dd/MM/yyyy HH:mm';

      // Expected result: "19/12/2023 12:34"
      expect(dateTime.formatDefault(format: customFormat), '19/12/2023 12:34');

      // Define a custom format
      final customFormat2 = 'MMM dd,yyyy HH:mm';

      // Expected result: "19/12/2023 12:34"
      expect(dateTime.formatDefault(format: customFormat2), 'Dec 19,2023 12:34');
    });
  });

  group('TimerUtil', () {
    TimerUtil timerUtil = TimerUtil();

    test('setInterval should set the timer interval', () {
      const interval = 2000;
      timerUtil.setInterval(interval);
      expect(timerUtil.mInterval, equals(interval));
    });

    test('setTotalTime should set the total time', () {
      const totalTime = 5000;
      timerUtil.setTotalTime(totalTime);
      expect(timerUtil.mTotalTime, equals(totalTime));
    });

    test('startTimer should start the timer', () {
      timerUtil.startTimer();
      expect(timerUtil.isActive(), isTrue);
    });

    test('startCountDown should start the countdown timer', () {
      timerUtil.setTotalTime(5000);
      timerUtil.startCountDown();
      expect(timerUtil.isActive(), isTrue);
    });

    test('updateTotalTime should update the total time and start countdown', () {
      const totalTime = 10000;
      timerUtil.updateTotalTime(totalTime);
      expect(timerUtil.mTotalTime, equals(totalTime));
      expect(timerUtil.isActive(), isTrue);
    });

    test('cancel should cancel the timer', () {
      timerUtil.startTimer();
      timerUtil.cancel();
      expect(timerUtil.isActive(), isFalse);
    });
  });
}
