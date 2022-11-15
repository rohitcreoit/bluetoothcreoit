#import "BluetoothcreoitPlugin.h"
#if __has_include(<bluetoothcreoit/bluetoothcreoit-Swift.h>)
#import <bluetoothcreoit/bluetoothcreoit-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "bluetoothcreoit-Swift.h"
#endif

@implementation BluetoothcreoitPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftBluetoothcreoitPlugin registerWithRegistrar:registrar];
}
@end
