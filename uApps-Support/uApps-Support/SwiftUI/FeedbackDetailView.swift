//
//  FeedbackDetailView.swift
//  uApps-Support
//
//  Created by Matthew Jagiela on 8/15/20.
//

import SwiftUI

struct FeedbackDetailView: View {
    @State var crashName =  ""
    var body: some View {
        Text(crashName)
    }
}

struct FeedbackDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FeedbackDetailView()
    }
}
