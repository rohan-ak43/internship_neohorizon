//
//  ContentView.swift
//  DynamicIslandDemoProject
//
import SwiftUI
import OneSignalFramework
struct ContentView: View {
    @State private var notificationPermissionStatus = "Unknown"
    @State private var oneSignalUserId = "Not Available"
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Header
                VStack(spacing: 8) {
                    Image(systemName: "bell.badge.fill")
                        .font(.system(size: 60))
                        .foregroundColor(.blue)
                    Text("Dynamic Island Demo")
                        .font(.title)
                        .fontWeight(.bold)       
                    Text("OneSignal Live Activities")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(.top, 40) 
                Spacer()     
                // Status Information
                VStack(alignment: .leading, spacing: 16) {
                    StatusRow(
                        title: "Notification Permission",
                        value: notificationPermissionStatus,
                        icon: "checkmark.shield.fill"
                    )
                    StatusRow(
                        title: "OneSignal User ID",
                        value: oneSignalUserId,
                        icon: "person.fill"
                    )
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                .padding(.horizontal)
                Spacer() 
                // Action Buttons
                VStack(spacing: 12) {
                    Button(action: checkPermissionStatus) {
                        HStack {
                            Image(systemName: "arrow.clockwise")
                            Text("Refresh Status")
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                    Button(action: openSettings) {
                        HStack {
                            Image(systemName: "gearshape.fill")
                            Text("Open Settings")
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(.systemGray5))
                        .foregroundColor(.primary)
                        .cornerRadius(10)
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 40)
            }
            .navigationBarHidden(true)
        }
        .onAppear {
            checkPermissionStatus()
        }
    } 
    private func checkPermissionStatus() {
        // Check notification permission status
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            DispatchQueue.main.async {
                switch settings.authorizationStatus {
                case .authorized:
                    notificationPermissionStatus = "Authorized"
                case .denied:
                    notificationPermissionStatus = "Denied"
                case .notDetermined:
                    notificationPermissionStatus = "Not Determined"
                case .provisional:
                    notificationPermissionStatus = "Provisional"
                case .ephemeral:
                    notificationPermissionStatus = "Ephemeral"
                @unknown default:
                    notificationPermissionStatus = "Unknown"
                }
            }
        }
        // Get OneSignal User ID (if available)
        if let userId = OneSignal.User.pushSubscription.id {
            oneSignalUserId = userId
        } else {
            oneSignalUserId = "Not Available"
        }
    }
    private func openSettings() {
        if let settingsUrl = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(settingsUrl)
        }
    }
}
struct StatusRow: View {
    let title: String
    let value: String
    let icon: String
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.blue)
                .frame(width: 30)
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text(value)
                    .font(.body)
                    .fontWeight(.medium)
            }
            Spacer()
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
```
### A1.5 BUILD CONFIGURATION
#### A1.5.1 Project.pbxproj (Xcode Project Settings - Key Sections)
```
/* Build Configuration */
buildSettings = {
    ASSETCATALOG_COMPILER_APPICON_NAME = AppIcon;
    CODE_SIGN_STYLE = Automatic;
    DEVELOPMENT_TEAM = YOUR_TEAM_ID;
    ENABLE_PREVIEWS = YES;
    INFOPLIST_FILE = DynamicIslandDemoProject/Info.plist;
    IPHONEOS_DEPLOYMENT_TARGET = 16.1;
    LD_RUNPATH_SEARCH_PATHS = (
        "$(inherited)",
        "@executable_path/Frameworks",
    );
    PRODUCT_BUNDLE_IDENTIFIER = com.neohorizon.DynamicIslandDemoProject;
    PRODUCT_NAME = "$(TARGET_NAME)";
    SWIFT_VERSION = 5.0;
    TARGETED_DEVICE_FAMILY = "1,2";
};
