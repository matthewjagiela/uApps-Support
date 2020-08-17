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
                    TypeView(feedback: self.viewModel.feedback)
                    TypeOfFeedback()
                    
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

struct TypeView: View {
    var feedback: FeedbackData
    var body: some View {
        VStack {
            HStack {
                Text("Type: ").font(.title2).fontWeight(.bold)
                Text(feedback.type).padding(.top, 2.5)
                Spacer()
            }
        }.padding([.horizontal, .bottom])
    }
}

struct TypeOfFeedback: View {
    var body: some View {
        VStack {
            HStack {
                Text("Bug Or Crash: ").fontWeight(.bold)
                Text("Crash")
                Spacer()
            }
        }.padding([.horizontal, .bottom])
    }
}
