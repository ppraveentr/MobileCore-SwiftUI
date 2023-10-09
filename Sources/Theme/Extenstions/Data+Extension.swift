//
//  Data+Extension.swift
//  Theme
//
//  Created by Praveen Prabhakar on 16/09/22.
//

import Foundation

public extension Data {
    static func contentOfFile(_ name: String, bundle: Bundle = Bundle.main) throws -> Data? {
        guard let url = bundle.url(forResource: name, withExtension: nil) else { return nil }
        return try Data(contentsOf: url)
    }
}
