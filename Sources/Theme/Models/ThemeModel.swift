//
//  ThemeModel.swift
//  Theme
//
//  Created by Praveen Prabhakar on 11/09/22.
//

import Core
import SwiftUI

public class ThemeModel {
    var colors = [String: Color]()
    var fonts = [String: Font]()
    var styles = [String: UserStyle]()

    struct UserStyle {
        var forgroundColor: ColorSchemeValue<Color>?
        var backgroundColor: ColorSchemeValue<Color>?
        var font: ColorSchemeValue<Font>?

        init(fcLight: Color? = nil, fcDark: Color? = nil, font: Font? = nil) {
            if let fcLight = fcLight {
                self.forgroundColor = ColorSchemeValue(fcLight, dark: fcDark)
            }
            if let fLight = font {
                self.font = ColorSchemeValue(fLight, dark: nil)
            }
        }

        mutating func updateBackgroundColor(light: Color, dark: Color? = nil) {
            self.backgroundColor = ColorSchemeValue(light, dark: dark)
        }
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
        let (fcLight, fcDark) = (model.colors[style.forgroundColor?.light ?? ""],
                                 model.colors[style.forgroundColor?.dark ?? ""])
        let font = model.fonts[style.font ?? ""]
        var userStyleValue = UserStyle(fcLight: fcLight, fcDark: fcDark, font: font)
        if let bgLight = model.colors[style.background?.color?.light ?? ""],
           let bgDark = model.colors[style.background?.color?.dark ?? ""] {
            userStyleValue.updateBackgroundColor(light: bgLight, dark: bgDark)
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
    static func style(_ name: String) -> Color? {
        if name.hasPrefix("#") {
            return Color(hex: name)
        }
        return nil
    }
}
