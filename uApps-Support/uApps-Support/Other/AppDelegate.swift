//
//  AppDelegate.swift
//  uApps-Support
//
//  Created by Matthew Jagiela on 8/13/20.
//

import UIKit
import UserNotifications

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { authorized, error in
            guard error == nil, authorized else {
                // not authorized...
                return
            }
            
            // subscription can be created now \o/
        }

        UIApplication.shared.registerForRemoteNotifications()
        
        return true
    }

}
