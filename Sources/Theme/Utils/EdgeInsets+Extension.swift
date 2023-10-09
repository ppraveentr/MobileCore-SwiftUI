//
//  EdgeInsets+Extension.swift
//  Theme
//
//  Created by Praveen Prabhakar on 19/05/23.
//

import SwiftUI

public extension EdgeInsets {
	static var zeroInsets: EdgeInsets {
		EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
	}

	static var padding: EdgeInsets {
		EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 20)
	}

	static var paddingContentView: EdgeInsets {
		EdgeInsets(top: 15, leading: 20, bottom: 0, trailing: 20)
	}

	static var padding16: EdgeInsets {
		.init(16)
	}

	static var paddingRegular: EdgeInsets {
		EdgeInsets(top: 12, leading: 24, bottom: 12, trailing: 24)
	}

	static var paddingTop15: EdgeInsets {
		.init(top: 15)
	}

	init(top: CGFloat = 0, left: CGFloat = 0, bottom: CGFloat = 0, right: CGFloat = 0) {
		self.init(top: top, leading: left, bottom: bottom, trailing: right)
	}

	init(_ all: CGFloat = 0) {
		self.init(top: all, leading: all, bottom: all, trailing: all)
	}
}
