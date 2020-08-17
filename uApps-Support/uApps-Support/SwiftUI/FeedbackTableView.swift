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
                Text("No Data").navigationTitle("Feedback").padding(.top, 5).navigationBarItems(trailing: Button(action: {
                    self.viewModel.refreshList()
                }, label: {
                    Text("Refresh")
                }))
            } else {
                ScrollView {
                    ForEach(self.viewModel.feedbackData, id: \.self) { feedback in
                        FeedbackCell(feedbackData: feedback).navigationTitle("Feedback").padding(.top, 5).navigationBarItems(trailing: Button(action: {
                            self.viewModel.refreshList()
                        }, label: {
                            Text("Refresh")
                        }))
                        Divider()
                    }
                }.padding(.top, 10)
            }
        }
    }
}


struct FeedbackCell: View {
    var feedbackData: FeedbackData
    
    var body: some View {
        NavigationLink(
            destination: FeedbackDetailView(),
            label: {
                VStack {
                    Text(feedbackData.bugName).font(.headline).foregroundColor(Color(UIColor.label)).padding(.bottom, 10)
                    Text("Type: \(feedbackData.type)").foregroundColor(Color(UIColor.label))
                    HStack {
                        if feedbackData.didCrash{
                            Text("Crash").foregroundColor(.red)
                            Divider().frame(height: 20)
                        } else { EmptyView() }
                        Text(feedbackData.version)
                    }
                }
            })
    }
}

struct RequestTableView_Previews: PreviewProvider {
    static var previews: some View {
        FeedbackTableView()
    }
}
