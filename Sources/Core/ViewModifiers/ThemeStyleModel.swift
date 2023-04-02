//
//  BAThemeModifier.swift
//  Core
//
//  Created by Praveen Prabhakar on 28/03/23.
//

import SwiftUI

public struct ThemeStyleModel: Codable {
	var textColor: String?
	var linkColor: String?
	var background: StyleBackground?
	var border: StyleBorder?
	var textFont: StyleFont?
	var alignment: Alignment?

	// Custom Values
	var font: Font? {
		textFont?.styleFont
	}

	var forgroundColor: Color? {
		textColor?.getColor()
	}

	var backgroundColor: Color? {
		background?.color?.getColor()
	}

	var textLinkColor: Color? {
		linkColor != nil ? linkColor?.getColor() : forgroundColor
	}
}

public extension ThemeStyleModel {
	struct StyleFont: Codable {
		var fontName = ""
		var fontSize = ""

		enum CodingKeys: String, CodingKey {
			case fontName = "font-name"
			case fontSize = "font-size"
		}

		var styleFont: Font {
			Font.custom(self.fontName, size: CGFloat((self.fontSize as NSString).floatValue))
		}
	}

	struct StyleBackground: Codable {
		var color: String?
		var ignoringSafeArea: Bool?
		var gradient: StyleGradient?

		struct StyleGradient: Codable {
			var colors: [String]
			var locations: [CGFloat]?
		}
	}

	struct StyleBorder: Codable {
		var radius: [Float]?
		var thickness: Int?
		var color: String?

		var borderColor: Color? {
			color?.getColor()
		}
	}

	enum Alignment: String, Codable {
		case left, center, right
	}
}
