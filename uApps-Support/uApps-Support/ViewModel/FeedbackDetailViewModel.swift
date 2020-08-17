//
//  FeedbackDetailViewModel.swift
//  uApps-Support
//
//  Created by Matthew Jagiela on 8/16/20.
//

import Foundation

public class FeedbackDetailViewModel: ObservableObject {
    @Published var feedback: FeedbackData
    
    init(feedback: FeedbackData) {
        self.feedback = feedback
    }
    
    func markClosed() {
        let DBHandler = DatabaseReader()
        DBHandler.changeRecordStatus(recordID: feedback.recordID, closed: feedback.isOpen)
    }
}
