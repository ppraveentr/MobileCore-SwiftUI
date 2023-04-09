//
//  ThemesManager.swift
//  Themes
//
//  Created by Praveen Prabhakar on 03/09/22.
//

import Foundation
import SwiftUI

public class ThemesManager: ObservableObject {
    public static let shared = ThemesManager()
    @Published public private(set) var themeModel: ThemeModel?

    private init() { /* dummpy function */ }

/// Call this function to generate `ColorSchemeValue: ThemeModel`,
/// For `light` and `dark` style from Data dictionary ofType`ThemeDic`
///
/// - Parameters:
///   - jsonData: `ColorSchemeValue<Data>` of json  for `light` and `dark` style
    public static func loadThemeModel(_ jsonData: Data) throws {
        ThemesManager.shared.themeModel = try ThemeModel.generateModel(jsonData)
    }
}

/// Extentions to get 'ColorSchemeValue' based on style name
extension ThemesManager {
/// Call this function to get `ColorSchemeValue: Color`
/// Parameters:
///   - style: Name of the style to fetch
/// - Returns: `Color`
//    static func color(_ name: String) -> Color? {
//        Self.shared.themeModel?.colors[name]
//    }

/// Call this function to get `ColorSchemeValue: Font`
///
/// - Parameters:
///   - style: Name of the style to fetch
/// - Returns: `Font`
    static func font(_ name: String) -> Font? {
        Self.shared.themeModel?.fonts[name]
    }

/// Call this function to get `ColorSchemeValue: ThemeStyles`
///
/// - Parameters:
///   - style: Name of the style to fetch
/// - Returns: User defied style: `ThemeModel.UserStyle`
    static func style(_ name: String) -> ThemeModel.UserStyle? {
        Self.shared.themeModel?.styles[name]
    }
}
