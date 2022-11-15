import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bluetoothcreoit/bluetoothcreoit_method_channel.dart';

void main() {
  MethodChannelBluetoothcreoit platform = MethodChannelBluetoothcreoit();
  const MethodChannel channel = MethodChannel('bluetoothcreoit');

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
