package com.creoit.bluetooth.bluetoothcreoit

import android.Manifest
import android.app.Activity
import android.bluetooth.BluetoothAdapter
import android.bluetooth.BluetoothDevice
import android.content.Intent
import android.content.pm.PackageManager
import androidx.annotation.NonNull
import androidx.core.app.ActivityCompat
import androidx.core.app.ActivityCompat.startActivityForResult
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.lang.reflect.Method


/** BluetoothcreoitPlugin */
class BluetoothcreoitPlugin : FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///ccx
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    lateinit var bluetoothAdapter: BluetoothAdapter
    val Request_Enable_Blutooth = 1
    val Request_Discoveable_Blutooth = 2
    private val activity: Activity? = null

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "bluetoothcreoit")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        bluetoothAdapter = BluetoothAdapter.getDefaultAdapter();
        if (call.method == "isEnabled") {
            result.success(bluetoothAdapter.isEnabled());
        } else if (call.method == "requestEnable") {
            if (!bluetoothAdapter.isEnabled) {
                val intent = Intent(BluetoothAdapter.ACTION_REQUEST_ENABLE)
                if (activity != null) {
                    startActivityForResult(activity, intent, Request_Enable_Blutooth, null)
                }
            } else {
                result.success(true)
            }

        } else if (call.method == "requestDisable") {
            if (bluetoothAdapter.isEnabled) {
                if (ActivityCompat.checkSelfPermission(
                        this@BluetoothcreoitPlugin,
                        Manifest.permission.BLUETOOTH_CONNECT
                    ) != PackageManager.PERMISSION_GRANTED
                ) {
                }
                bluetoothAdapter.disable()
                result.success(true);

            } else {
                result.success(false);
            }
        } else if (call.method == "getState") {
            result.success(bluetoothAdapter.getState())

        } else if (call.method == "startDiscovery") {
            if (!bluetoothAdapter.isDiscovering) {
                val intent = Intent(BluetoothAdapter.ACTION_REQUEST_DISCOVERABLE)
                if (activity != null) {
                    startActivityForResult(activity, intent, Request_Discoveable_Blutooth, null)
                }
            }

        }else if (call.method == "getConnectedDevice") {
            val list: List<Map<String, Any>> = ArrayList()
            for (device in bluetoothAdapter.bondedDevices) {
                val entry: MutableMap<String, Any> = HashMap()
                entry["address"] = device.address
                entry["name"] = device.name
                entry["type"] = device.type
                entry["isConnected"] = checkIsDeviceConnected(device)
                entry["bondState"] = BluetoothDevice.BOND_BONDED
                list.toMutableList().add(entry)
            }
            result.success(list)

        } else {
            result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    private fun checkIsDeviceConnected(device: BluetoothDevice): Boolean {
        return try {
            val method: Method
            method = device.javaClass.getMethod("isConnected")
            method.invoke(device) as Boolean
        } catch (ex: Exception) {
            false
        }
    }

}
