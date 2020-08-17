//
//  FeedbackDetailView.swift
//  uApps-Support
//
//  Created by Matthew Jagiela on 8/15/20.
//

import SwiftUI

struct FeedbackDetailView: View {
    @ObservedObject var viewModel: FeedbackDetailViewModel
    var body: some View {
        ScrollView {
            Divider()
            VStack {
                TypeView(feedback: self.viewModel.feedback)
                TypeOfFeedback(feedback: self.viewModel.feedback)
                VStack {
                    SUITextView(text: self.$viewModel.feedback.details).frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealWidth: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: 100, idealHeight: 500, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                }
                Button(action: {
                    self.viewModel.markClosed()
                }) {
                    Text("Mark Issue As Closed")
                }
                
                
            }.navigationTitle("\(self.viewModel.feedback.bugName)")
        }.padding(.top)
    }
}

struct FeedbackDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FeedbackDetailView(viewModel: FeedbackDetailViewModel(feedback: FeedbackData(bugName: "Test Name", type: "Interface", didCrash: true, details: "Details Go Here", emailAddress: "matthew.jagiela", version: "5", isOpen: true)))
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
    var feedback: FeedbackData
    var body: some View {
        VStack {
            HStack {
                Text("Bug Or Crash: ").fontWeight(.bold)
                Text(feedback.didCrash ? "Crash": "Bug").foregroundColor(.red)
                Spacer()
            }
        }.padding([.horizontal, .bottom])
    }
}

struct SUITextView: UIViewRepresentable {
    @Binding var text: String
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.isSelectable = false
        textView.isUserInteractionEnabled = true
        textView.textAlignment = .center
        textView.backgroundColor = .clear
        textView.textColor = UIColor.label
        textView.font = UIFont.preferredFont(forTextStyle: .subheadline)
        return textView
    }
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
    }
}
