
import 'package:bluetoothcreoit/model/device.dart';

import 'bluetoothcreoit_platform_interface.dart';

class Bluetoothcreoit {

  Future<bool?> enableBluetooth() {
    return BluetoothcreoitPlatform.instance.requestEnable();

  }

  Future<bool?> disableBluetooth() {
    return BluetoothcreoitPlatform.instance.requestDisable();
  }

  Future<List<BluetoothDevice>> getConnectedDevice() {
    return BluetoothcreoitPlatform.instance.getConnectedDevices();
  }


}
