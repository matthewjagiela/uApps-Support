//
//  RequestTableView.swift
//  uApps-Support
//
//  Created by Matthew Jagiela on 8/13/20.
//

import SwiftUI

struct FeedbackTableView: View {
    @ObservedObject var viewModel = HomeViewModel()
    var body: some View {
        NavigationView {
            if viewModel.feedbackData.count == 0 {
                Text("No Data")
            } else {
                ScrollView {
                    ForEach(self.viewModel.feedbackData, id: \.self) { feedback in
                        FeedbackCell(feedbackName: feedback.bugName, feedbackType: feedback.type, feedbackVersion: feedback.version, crash: feedback.didCrash).navigationTitle("Feedback").padding(.top, 5)
                        Divider()
                    }
                }.padding(.top, 10)
            }
        }
    }
}


struct FeedbackCell: View {
    var feedbackName: String
    var feedbackType: String
    var feedbackVersion: String
    var crash: Bool
    
    var body: some View {
        VStack {
            Text(feedbackName).font(.headline)
            Divider()
            Text("Type: \(feedbackType)")
            HStack {
                if crash {
                    Text("Crash").foregroundColor(.red)
                    Divider().frame(height: 20)
                } else { EmptyView() }
                Text(feedbackVersion)
            }
            Divider()
        }
    }
}

struct RequestTableView_Previews: PreviewProvider {
    static var previews: some View {
        FeedbackTableView()
    }
}
