import 'package:bluetoothcreoit/model/device.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'bluetoothcreoit_platform_interface.dart';

class MethodChannelBluetoothcreoit extends BluetoothcreoitPlatform {
  @visibleForTesting
  final methodChannel = const MethodChannel('bluetoothcreoit');

  Future<bool?> get isEnabled async =>
      await methodChannel.invokeMethod('isEnabled');

  @override
  Future<bool?> requestEnable() async =>
      await methodChannel.invokeMethod('requestEnable');

  @override
  Future<bool?> requestDisable() async =>
      await methodChannel.invokeMethod('requestDisable');

  @override
  Future<List<BluetoothDevice>> getConnectedDevices() async {
    final List list = await (methodChannel.invokeMethod('getConnectedDevice'));
    return list.map((map) => BluetoothDevice.fromMap(map)).toList();
  }
}
