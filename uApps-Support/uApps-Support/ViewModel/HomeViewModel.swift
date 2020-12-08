//
//  HomeViewModel.swift
//  uApps-Support
//
//  Created by Matthew Jagiela on 8/13/20.
//

import Foundation

public class HomeViewModel: ObservableObject {
    
    @Published var feedbackData =  [FeedbackData]()
    let db = DatabaseReader()
    init() {
        db.fetchUTimeRecords { (result) in
            switch result {
            case .success(let feedback):
                self.feedbackData = feedback
            default:
                print("error")
            }
        }
    }
    
    func refreshList() {
        db.fetchUTimeRecords { result in
            switch result {
            case .success(let feedback):
                self.feedbackData = feedback
            case .failure(let error):
                print("Error fetching timers: \(error)")
            }
        }
    }
    
}
