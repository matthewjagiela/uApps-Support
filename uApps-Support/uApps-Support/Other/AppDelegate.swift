//
//  AppDelegate.swift
//  uApps-Support
//
//  Created by Matthew Jagiela on 8/13/20.
//

import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        print("launched")
        var db = DatabaseReader()
        db.fetchUTimeRecords { result in
            switch result {
            case .success(let feedback):
                print(feedback)
            case .failure(let error):
                print(error)
            }
        }
        return true
    }

}
