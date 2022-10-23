//
//  ContentView.swift
//  ExampleApp
//
//  Created by Praveen Prabhakar on 03/09/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            Form {
                NavigationContentView(title: "Dark/Light Mode Themes example") { ExTextView() }
            }
        }
        .navigationTitle("MobileCoreUI")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
