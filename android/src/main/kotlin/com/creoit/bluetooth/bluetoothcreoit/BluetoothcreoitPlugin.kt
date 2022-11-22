package com.creoit.bluetooth.bluetoothcreoit

import android.Manifest
import android.app.Activity
import android.bluetooth.BluetoothAdapter
import android.bluetooth.BluetoothDevice
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import androidx.core.app.ActivityCompat
import androidx.core.app.ActivityCompat.startActivityForResult
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.lang.ref.WeakReference
import java.lang.reflect.Method



class BluetoothcreoitPlugin : FlutterPlugin, MethodCallHandler, ActivityAware {

    private val activity get() = activityReference.get()

    private var activityReference = WeakReference<Activity>(null)
    private var contextReference = WeakReference<Context>(null)
    private lateinit var channel: MethodChannel
    lateinit var bluetoothAdapter: BluetoothAdapter
    private val requestEnableBluetooth = 1
    private val requestDiscoverBluetooth = 2

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "bluetoothcreoit")
        channel.setMethodCallHandler(this)
        contextReference = WeakReference(flutterPluginBinding.applicationContext)
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        bluetoothAdapter = BluetoothAdapter.getDefaultAdapter();
        if (call.method == "isEnabled") {
            result.success(bluetoothAdapter.isEnabled());
        } else if (call.method == "requestEnable") {
            activity ?: return
            if (ActivityCompat.checkSelfPermission(
                    activity!!, Manifest.permission.BLUETOOTH_CONNECT
                ) != PackageManager.PERMISSION_GRANTED
            ) {
                result.error("400","Not Accepted","Permission is Not Accepted")
                return
            }
            if (!bluetoothAdapter.isEnabled) {
                val intent = Intent(BluetoothAdapter.ACTION_REQUEST_ENABLE)
                if (activity != null) {
                    startActivityForResult(activity!!, intent, requestEnableBluetooth, null)
                }
            } else {
                result.success(true)
            }

        } else if (call.method == "requestDisable") {
            if (bluetoothAdapter.isEnabled) {
                if (ActivityCompat.checkSelfPermission(
                        activity!!, Manifest.permission.BLUETOOTH_CONNECT
                    ) != PackageManager.PERMISSION_GRANTED
                ) {
                    result.error("400","Not Accepted","Permission is Not Accepted")
                    return
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
                    startActivityForResult(activity!!, intent, requestDiscoverBluetooth, null)
                }
            }

        } else if (call.method == "getConnectedDevice") {
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

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
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

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activityReference = WeakReference(binding.activity)
    }

    override fun onDetachedFromActivityForConfigChanges() {
        activityReference.clear()
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        activityReference = WeakReference(binding.activity)
    }

    override fun onDetachedFromActivity() {
        activityReference.clear()
    }

}
