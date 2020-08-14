//
//  DatabaseHandler.swift
//  uApps-Support
//
//  Created by Matthew Jagiela on 8/13/20.
//

import Foundation
import CloudKit

struct FeedbackData {
    var bugName: String
    var type: String
    var didCrash: Bool
    var details: String
    var emailAddress: String
    var version: String
    
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
            let feedbackAppend = FeedbackData(bugName: record["name"] as! String, type: record["type"] as! String, didCrash: (record["crash"] != nil), details: record["details"] as! String, emailAddress: record["email"] as! String, version: record["version"] as! String)
            newFeedback.append(feedbackAppend)
        }
        operation.queryCompletionBlock = { (cursor, error) in
            DispatchQueue.main.async {
                if error == nil {
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
}
