//
//  FeedbackDetailView.swift
//  uApps-Support
//
//  Created by Matthew Jagiela on 8/15/20.
//

import SwiftUI

struct FeedbackDetailView: View {
    @ObservedObject var viewModel: FeedbackDetailViewModel = FeedbackDetailViewModel(feedback: FeedbackData(bugName: "Test Name", type: "Test Type", didCrash: true, details: "Test Details", emailAddress: "matthew.jagiela", version: "5")) //TODO: Remove =
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    NameView(feedback: self.viewModel.feedback)
                    
                }
            }
        }
    }
}

struct FeedbackDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FeedbackDetailView()
    }
}

struct NameView: View {
    var feedback: FeedbackData
    var body: some View {
        HStack {
            Text("Name: ").font(.title).fontWeight(.bold)
            Text(feedback.bugName).font(.title3).padding(.top, 3.5)
            Spacer()
        }.padding([.horizontal, .bottom])
    }
}
