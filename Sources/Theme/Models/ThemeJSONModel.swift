//
//  ThemeJSONStructure.swift
//  Theme
//
//  Created by Praveen Prabhakar on 16/09/22.
//

import Foundation
import SwiftUI

struct ThemeJSONModel: Codable {
    struct FontModel: Codable {
        var size: CGFloat?
        /// Based on ``Font/Weight``
        var weight: String?
        /// Based on ``Font/TextStyle``
        var styleName: String?
    }

    struct ColorModel: Codable {
        var light: String
        var dark: String?
    }

    struct UserStyleModel: Codable {
        var forgroundColor: String?
        var font: String?
        var background: BackgroundModel?
    }

    struct BackgroundModel: Codable {
        var color: String?
        var ignoringSafeArea: Bool?
        var gradient: GradientModel?
        var border: BorderModel?
    }

    struct GradientModel: Codable {
        var colors: [String]
        var locations: [CGFloat]?
    }

    struct BorderModel: Codable {
        var radius: [CGFloat]?
        var thickness: CGFloat?
        var color: String?
    }

    var colors: [String: String]?
    var fonts: [String: FontModel]?
    var styles: [String: UserStyleModel]?
}

enum Alignment: String, Codable {
    case left, center, right
}
