//
//  PreferenceValue.swift
//  AppStorageExperiment
//
//  Created by Paul Calnan on 3/30/23.
//

import Foundation

struct PreferenceValue {
    var name: String
    var value: Int
    // NOTE: If you add new properties, you have to update the Codable implementation below
}

// If you use the default (compiler-synthesized) Codable implementation, our
// RawRepresentable implementation below will crash with a stack overflow.
// Evaluating the rawValue property recuses infinitely. Instead, we have to do
// manually implement Codable with CodingKeys.
//
// See https://useyourloaf.com/blog/scenestorage-for-custom-types/
//
extension PreferenceValue: Codable {
    enum CodingKeys: String, CodingKey {
        case name
        case value
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        value = try container.decode(Int.self, forKey: .value)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(value, forKey: .value)
    }
}
