//
//  RetryView.swift
//  NewsSwiftUI
//
//  Created by nikita9x on 04.08.2022.
//

import SwiftUI

struct RetryView: View {
    let text: String
    let retryAction: () -> ()
    
    var body: some View {
        VStack(spacing: 8) {
            Text(text)
                .font(.callout)
                .multilineTextAlignment(.center)
            
            Button(action: retryAction) {
                Text("try again")
            }
        }
    }
}

struct RetryView_Previews: PreviewProvider {
    static var previews: some View {
        RetryView(text: "an error occured") {
            
        }
    }
}
