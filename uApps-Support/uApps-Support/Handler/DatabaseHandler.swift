//
//  DatabaseHandler.swift
//  uApps-Support
//
//  Created by Matthew Jagiela on 8/13/20.
//

import Foundation
import CloudKit

struct FeedbackData: Hashable {
    var bugName: String
    var type: String
    var didCrash: Bool
    var details: String
    var emailAddress: String
    var version: String
    var isOpen: Bool
    var recordID: CKRecord.ID
    
}

enum Result {
    case success([FeedbackData])
    case failure(ErrorStatus)
}

enum ErrorStatus {
    case known(Error)
    case unknown
}

public class DatabaseReader {
    var uTimeContainer = CKContainer(identifier: "iCloud.com.uapps.uTime")
    
    func fetchUTimeRecords(completion: @escaping(Result) -> Void) {
        let pred = NSPredicate(value: true)
        let sort = NSSortDescriptor(key: "version", ascending: false)
        let query = CKQuery(recordType: "Bug", predicate: pred)
        query.sortDescriptors = [sort]
        
        let operation = CKQueryOperation(query: query)
        var newFeedback = [FeedbackData]()
        operation.recordFetchedBlock = { record in
            let feedbackAppend = FeedbackData(bugName: record["name"] as? String ?? "Not Applicable",
                                              type: record["type"] as? String ?? "Not Applicable",
                                              didCrash: (record["crash"] != nil),
                                              details: record["details"] as? String ?? "Not Applicable",
                                              emailAddress: record["email"] as? String ?? "Not Applicable",
                                              version: record["version"] as? String ?? "Not Applicable",
                                              isOpen: record["open"] != nil,
                                              recordID: record.recordID)
            newFeedback.append(feedbackAppend)
        }
        operation.queryCompletionBlock = { (cursor, error) in
            DispatchQueue.main.async {
                if error == nil {
                    self.registerUTimeAlerts()
                    completion(.success(newFeedback))
                } else {
                    if let errorPass = error {
                        completion(.failure(.known(errorPass)))
                    } else {
                        completion(.failure(.unknown))
                    }
                }
            }
        }
        uTimeContainer.publicCloudDatabase.add(operation)
    }
    
    func registerUTimeAlerts() {
        //clearAllSubs()
        let subscription = CKQuerySubscription(recordType: "Bug", predicate: NSPredicate(value: true), options: [.firesOnRecordCreation])
        let info = CKSubscription.NotificationInfo()
        info.alertLocalizationKey = "feedback_localized_alert"
        info.alertLocalizationArgs = ["name"]
        info.shouldBadge = true
        subscription.notificationInfo = info
        if !doesSubExist() {
            uTimeContainer.publicCloudDatabase.save(subscription) { (subscriptionSave, error) in
                if error != nil {
                    print("error saving notifications \(String(describing: error))")
                }
                UserDefaults.standard.setValue(subscriptionSave?.subscriptionID, forKey: "subscriptionID")
            }
        }
        
    }
    
    func clearAllSubs() {
        uTimeContainer.publicCloudDatabase.fetchAllSubscriptions { (subscriptions, error) in
            if error != nil {
                print("Error fetching subs")
            } else {
                for sub in subscriptions! {
                    self.uTimeContainer.publicCloudDatabase.delete(withSubscriptionID: sub.subscriptionID) { (_, error) in
                        print(error?.localizedDescription as Any)
                    }
                }
            }
        }
    }
    
    func doesSubExist() -> Bool {
        let subID = UserDefaults.standard.value(forKey: "subscriptionID") as? CKSubscription.ID
        guard subID != nil else { return false }
        return true
    }
}
