class BluetoothDevice {
  final String? name;

  final String address;

  final bool isConnected;

  const BluetoothDevice({
    this.name,
    required this.address,
    this.isConnected = false,
  });

  factory BluetoothDevice.fromMap(Map map) {
    return BluetoothDevice(
      name: map["name"],
      address: map["address"]!,
      isConnected: map["isConnected"] ?? false,
    );
  }

  Map<String, dynamic> toMap() => {
        "name": this.name,
        "address": this.address,
        "isConnected": this.isConnected,
      };
}
