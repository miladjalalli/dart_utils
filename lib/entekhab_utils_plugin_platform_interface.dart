import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'entekhab_utils_plugin_method_channel.dart';

abstract class EntekhabUtilsPluginPlatform extends PlatformInterface {
  /// Constructs a EntekhabUtilsPluginPlatform.
  EntekhabUtilsPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static EntekhabUtilsPluginPlatform _instance = MethodChannelEntekhabUtilsPlugin();

  /// The default instance of [EntekhabUtilsPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelEntekhabUtilsPlugin].
  static EntekhabUtilsPluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [EntekhabUtilsPluginPlatform] when
  /// they register themselves.
  static set instance(EntekhabUtilsPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
