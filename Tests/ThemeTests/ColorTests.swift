//
//  ColorTests.swift
//  UnitTest
//
//  Created by Praveen Prabhakar on 03/09/22.
//

import SwiftUI
import XCTest

final class ColorTests: XCTestCase {
    func testHexColor() throws {
        XCTAssertNotNil(Color(hex: "#EE4B2B"), "Should generate valid color from hex string")
    }
}
