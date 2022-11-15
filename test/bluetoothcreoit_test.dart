import 'package:flutter_test/flutter_test.dart';
import 'package:bluetoothcreoit/bluetoothcreoit.dart';
import 'package:bluetoothcreoit/bluetoothcreoit_platform_interface.dart';
import 'package:bluetoothcreoit/bluetoothcreoit_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockBluetoothcreoitPlatform
    with MockPlatformInterfaceMixin
    implements BluetoothcreoitPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final BluetoothcreoitPlatform initialPlatform = BluetoothcreoitPlatform.instance;

  test('$MethodChannelBluetoothcreoit is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelBluetoothcreoit>());
  });

  test('getPlatformVersion', () async {
    Bluetoothcreoit bluetoothcreoitPlugin = Bluetoothcreoit();
    MockBluetoothcreoitPlatform fakePlatform = MockBluetoothcreoitPlatform();
    BluetoothcreoitPlatform.instance = fakePlatform;

    expect(await bluetoothcreoitPlugin.getPlatformVersion(), '42');
  });
}
