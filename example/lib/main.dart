import 'package:bluetoothcreoit/model/device.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:bluetoothcreoit/bluetoothcreoit.dart';
import 'package:permission_handler/permission_handler.dart';

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
    var value = await askPermission();
    if (value == true) {
      await _bluetoothcreoitPlugin.enableBluetooth();
      var device = await _bluetoothcreoitPlugin.getConnectedDevice();
      print(device);
      setState(() {
        btDevices = device;
      });
    }
  }

  Future<bool?> askPermission() async {
    PermissionStatus status = await Permission.bluetooth.request();
    if (status.isDenied == true) {
      askPermission();
    } else {
      await Permission.bluetoothConnect.request();
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Bluetooth App'),
        ),
        body: buildBody(),
      ),
    );
  }

  buildBody(){
    if(btDevices.length == 0){
      return CircularProgressIndicator();
    }else{
      return ListView.builder(
        itemCount: btDevices.length
      ,itemBuilder: (_,index){
        return ListTile(
          title: Text(btDevices[index].name ?? ""),
          subtitle: Text(btDevices[index].address),
        );
      });
    }

  }
}
