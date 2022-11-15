
import 'bluetoothcreoit_platform_interface.dart';

class Bluetoothcreoit {
  Future<String?> getPlatformVersion() {
    return BluetoothcreoitPlatform.instance.getPlatformVersion();
  }
}
