import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'bluetoothcreoit_platform_interface.dart';

/// An implementation of [BluetoothcreoitPlatform] that uses method channels.
class MethodChannelBluetoothcreoit extends BluetoothcreoitPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('bluetoothcreoit');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
