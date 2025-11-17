//
//  DynamicIslandDemoProjectApp.swift
//  DynamicIslandDemoProject
//
//  Created by Neohorizon Analytics on 17/06/25.

import SwiftUI
import OneSignalFramework
import OneSignalLiveActivities

@main
struct DynamicIslandDemoProjectApp: App {
    // Connect the SwiftUI app to the UIKit app delegate
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, 
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
      
        // Enable verbose logging for debugging (remove in production)
        OneSignal.Debug.setLogLevel(.LL_VERBOSE)
        // Initialize with your OneSignal App ID
        OneSignal.initialize("app_id", 
                           withLaunchOptions: launchOptions)
        
        // Request permission for push notifications
        OneSignal.Notifications.requestPermission({ accepted in
            print("User accepted notifications: \(accepted)")
            
            if accepted {
                self.setupLiveActivities()
            }
        }, fallbackToSettings: true)
        
        // Set up notification event handlers
        self.setupNotificationHandlers()
        
        return true
    }
    
    private func setupNotificationHandlers() {
        // Handle notifications when app is in foreground
        OneSignal.Notifications.addForegroundWillDisplayEventHandler { 
            (event: OSNotificationWillDisplayEvent) in
            print("Notification received in foreground: \(event.notification.title ?? "")")
            
            if let liveActivityData = event.notification.additionalData?["live_activity"] as? [String: Any] {
                print("Live Activity update received: \(liveActivityData)")
            }
            
            // Display the notification
            event.notification.display()
        }
        
        // Handle notification clicks
        OneSignal.Notifications.addClickEventHandler { 
            (event: OSNotificationClickEvent) in
            print("Notification clicked: \(event.notification.title ?? "")")
        }
    }
    
    private func setupLiveActivities() {
        print("Setting up OneSignal Live Activities...")
        
        // Initialize Live Activities
        OneSignalLiveActivities.setup()
        
        // Set up default Live Activity handler
        OneSignalLiveActivities.setupDefault { 
            (result: OSLiveActivitySetupResult) in
            switch result {
            case .success:
                print("OneSignal Live Activities setup completed successfully")
            case .failure(let error):
                print("OneSignal Live Activities setup failed: \(error)")
            }
        }
        
        print("OneSignal Live Activities setup initiated.")
    }
}
