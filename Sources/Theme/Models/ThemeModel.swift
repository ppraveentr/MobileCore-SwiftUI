//
//  ThemeModel.swift
//  Theme
//
//  Created by Praveen Prabhakar on 11/09/22.
//

import Core
import SwiftUI

public class ThemeModel {
    var colors = [String: ColorSchemeValue<Color>]()
    var fonts = [String: Font]()
    var styles = [String: UserStyle]()

    struct UserStyle {
        var forgroundColor: ColorSchemeValue<Color>?
        var backgroundColor: ColorSchemeValue<Color>?
        var font: ColorSchemeValue<Font>?
    }
}

/// Generate ``ThemeModel`` based on `json Data`
extension ThemeModel {
    static func generateModel(_ jsonData: Data) throws -> ThemeModel {
        let theme = try JSONDecoder().decode(ThemeStructure.self, from: jsonData)
        let model = ThemeModel()
            // Generate Colors
        theme.colors?.forEach { model.colors[$0] = Color.style($1) }
            // Generate Fonts
        theme.fonts?.forEach { model.fonts[$0] = Font.style($1) }
            // Generate Theme Style
        theme.styles?.forEach { model.styles[$0] = Self.style($1, model: model) }
        return model
    }

    /// Generate ``ThemeModel/UserStyle`` based on ``ThemeStructure.UserStyle``
    private static
    func style(_ style: ThemeStructure.UserStyle, model: ThemeModel) -> UserStyle? {
        let fgColor = model.colors[style.forgroundColor ?? ""]
        let bgLight = model.colors[style.background?.color ?? ""]
        var userStyleValue = UserStyle(forgroundColor: fgColor, backgroundColor: bgLight)
        if let font = model.fonts[style.font ?? ""] {
            userStyleValue.font = ColorSchemeValue(font, dark: nil)
        }
        return userStyleValue
    }
}

/// Generate ``Font`` based on ``ThemeStructure.FontStyle``
extension Font {
    static func style(_ style: ThemeStructure.FontStyle) -> Font? {
            /// Generate ``Font`` based on StyleName ``Font/TextStyle``
        if let styleName = style.styleName,
            let font = Font.fromStyleName(styleName: styleName) {
            return font
        }
            /// Generate ``Font`` based on ``Size: CGFloat`` and ``Font/Weight``
        if let size = style.size, let weight = style.weight {
            return .fromSize(size: size, weight: weight)
        }
        return nil
    }
}

/// Generate ``Color`` based on `hex color`
extension Color {
    static func style(_ name: String) -> ColorSchemeValue<Color>? {
        if name.hasPrefix("#") {
            let colorNames = name.components(separatedBy: ",,")
            guard let light = colorNames.first else {
                return nil
            }
            var colors = ColorSchemeValue<Color>(Color(hex: light))
            if let dark = colorNames.last {
                colors.dark = Color(hex: dark)
            }
            return colors
        }
        return nil
    }
}
