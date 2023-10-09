//
//  ThemeJSONStructure.swift
//  Theme
//
//  Created by Praveen Prabhakar on 16/09/22.
//

import Foundation
import SwiftUI

struct ThemeJSONStructure: Codable {
    struct FontStyle: Codable {
        var size: CGFloat?
        /// Based on ``Font/Weight``
        var weight: String?
        /// Based on ``Font/TextStyle``
        var styleName: String?
    }

    struct ColorStyle: Codable {
        var light: String
        var dark: String?
    }

    struct UserStyle: Codable {
        var forgroundColor: String?
        var font: String?
        var background: BackgroundStyle?
    }

    struct BackgroundStyle: Codable {
        var color: String?
        var ignoringSafeArea: Bool?
        var gradient: StyleGradient?
        var border: StyleBorder?
    }

    struct StyleGradient: Codable {
        var colors: [String]
        var locations: [CGFloat]?
    }

    struct StyleBorder: Codable {
        var radius: [CGFloat]?
        var thickness: Int?
        var color: String?

        var borderColor: Color? {
            color?.getColor()
        }
    }

    var colors: [String: String]?
    var fonts: [String: FontStyle]?
    var styles: [String: UserStyle]?
}

enum Alignment: String, Codable {
    case left, center, right
}
