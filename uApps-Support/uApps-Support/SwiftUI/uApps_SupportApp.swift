//
//  uApps_SupportApp.swift
//  uApps-Support
//
//  Created by Matthew Jagiela on 8/13/20.
//

import SwiftUI

@main
struct uApps_SupportApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            FeedbackTableView()
        }
    }
}
