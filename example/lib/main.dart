import 'package:bluetoothcreoit/model/device.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:bluetoothcreoit/bluetoothcreoit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _bluetoothcreoitPlugin = Bluetoothcreoit();

  List<BluetoothDevice> btDevices = [];

  @override
  void initState() {
    super.initState();
    connectBluetooth();
  }

  connectBluetooth() async {
    await _bluetoothcreoitPlugin.enableBluetooth();
    var device = await _bluetoothcreoitPlugin.getConnectedDevice();
    print(device);
    btDevices = device;
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Running on: $btDevices'),
        ),
      ),
    );
  }
}
