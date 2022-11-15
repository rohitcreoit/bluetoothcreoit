import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'bluetoothcreoit_method_channel.dart';

abstract class BluetoothcreoitPlatform extends PlatformInterface {
  /// Constructs a BluetoothcreoitPlatform.
  BluetoothcreoitPlatform() : super(token: _token);

  static final Object _token = Object();

  static BluetoothcreoitPlatform _instance = MethodChannelBluetoothcreoit();

  /// The default instance of [BluetoothcreoitPlatform] to use.
  ///
  /// Defaults to [MethodChannelBluetoothcreoit].
  static BluetoothcreoitPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [BluetoothcreoitPlatform] when
  /// they register themselves.
  static set instance(BluetoothcreoitPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
