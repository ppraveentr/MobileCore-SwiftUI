//
//  ThemeStructure.swift
//  Theme
//
//  Created by Praveen Prabhakar on 16/09/22.
//

import Foundation
import SwiftUI

struct ThemeStructure: Codable {
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
        var forgroundColor: ColorStyle?
        var font: String?
    }

    var colors: [String: String]?
    var fonts: [String: FontStyle]?
    var styles: [String: UserStyle]?
}
