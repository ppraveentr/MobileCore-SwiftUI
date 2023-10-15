//
//  ExampleApp.swift
//  ExampleApp
//
//  Created by Praveen Prabhakar on 03/09/22.
//

import Theme
import SwiftUI

@main
struct ExampleApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .task {
                    await ThemeLoader.setupApplicationTheme()
                }
        }
    }
}

struct ThemeLoader {
    static let themeName = "Theme.json"

    static func setupApplicationTheme() async {
        guard let themeModel = try? Data.contentOfFile(themeName) else { return }
        try? ThemesManager.setupApplicationTheme(themeModel)
    }
}
