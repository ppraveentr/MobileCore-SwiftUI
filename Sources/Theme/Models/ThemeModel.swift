//
//  ThemeModel.swift
//  Theme
//
//  Created by Praveen Prabhakar on 11/09/22.
//

import SwiftUI

public class ThemeModel {
    var colors = [String: Appearance<Color>]()
    var fonts = [String: Font]()
    var styles = [String: UserStyle]()

    struct UserStyle {
        var forground: Appearance<Color>?
        var background: StyleBackground?
        var font: Appearance<Font>?
        var border: StyleBorder?
    }

    struct StyleBorder {
        var radius: [CGFloat]?
        var thickness: CGFloat?
        var color: Appearance<Color>?

        static func create(_ borderStyle: ThemeJSONModel.BorderModel, model: ThemeModel) -> StyleBorder {
            let boderColor = model.colors[borderStyle.color ?? ""]
            return .init(radius: borderStyle.radius, thickness: borderStyle.thickness, color: boderColor)
        }
    }

    struct StyleBackground {
        var color: Appearance<Color>?
        var ignoringSafeArea: Bool?
        var gradient: ThemeJSONModel.GradientModel?

        static func create(_ style: ThemeJSONModel.UserStyleModel, model: ThemeModel) -> StyleBackground {
            let bgLight = model.colors[style.background?.color ?? ""]
            return .init(
                color: bgLight,
                ignoringSafeArea: style.background?.ignoringSafeArea,
                gradient: style.background?.gradient
            )
        }
    }
}

/// Generate ``ThemeModel`` based on `json Data`
extension ThemeModel {
    static func generateModel(_ jsonData: Data) throws -> ThemeModel {
        let theme = try JSONDecoder().decode(ThemeJSONModel.self, from: jsonData)
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
    func style(_ style: ThemeJSONModel.UserStyleModel, model: ThemeModel) -> UserStyle? {
            // Colors
        let fgColor = model.colors[style.forgroundColor ?? ""]
            // StyleBackground
        let styleBackground = StyleBackground.create(style, model: model)
            // User Style Setup
        var userStyleValue = UserStyle(forground: fgColor, background: styleBackground)
            // StyleBorder
        if let boder = style.background?.border {
            userStyleValue.border = StyleBorder.create(boder, model: model)
        }
            // Fonts
        if let font = model.fonts[style.font ?? ""] {
            userStyleValue.font = Appearance(font, dark: nil)
        }
        return userStyleValue
    }
}

/// Generate ``Font`` based on ``ThemeStructure.FontStyle``
extension Font {
    static func style(_ style: ThemeJSONModel.FontModel) -> Font? {
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
    static func style(_ name: String) -> Appearance<Color>? {
        if name.hasPrefix("#") {
            let colorNames = name.components(separatedBy: ",,")
            guard let light = colorNames.first else {
                return nil
            }
            var colors = Appearance<Color>(Color(hex: light))
            if let dark = colorNames.last {
                colors.dark = Color(hex: dark)
            }
            return colors
        }
        return nil
    }
}
