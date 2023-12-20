import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:entekhab_utils_plugin/entekhab_utils_plugin_method_channel.dart';

void main() {
  MethodChannelEntekhabUtilsPlugin platform = MethodChannelEntekhabUtilsPlugin();
  const MethodChannel channel = MethodChannel('entekhab_utils_plugin');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
