//
//  ContentView.swift
//  AppStorageExperiment
//
//  Created by Paul Calnan on 3/30/23.
//

import SwiftUI

let sharedPreferenceKey = AppStorageKey(
    name: "sharedPreference",
    defaultValue: PreferenceValue(name: "preference", value: 0)
)

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
// https://useyourloaf.com/blog/scenestorage-for-custom-types/
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

extension PreferenceValue: RawRepresentable {
    init?(rawValue: String) {
        do {
            self = try JSONDecoder().decode(PreferenceValue.self, from: Data(rawValue.utf8))
        }
        catch {
            return nil
        }
    }

    var rawValue: String {
        do {
            return try String(decoding: JSONEncoder().encode(self), as: UTF8.self)
        }
        catch {
            return "{}"
        }
    }
}

struct IncrementView: View {
    @AppStorage(key: sharedPreferenceKey)
    var sharedPreference

    var body: some View {
        VStack {
            Text("Value: \(sharedPreference.rawValue)")

            Button("Increment", action: {
                sharedPreference.value += 1
            })
        }
        .padding()
        .background(.green)
    }
}

struct DecrementView: View {
    @AppStorage(key: sharedPreferenceKey)
    var sharedPreference

    var body: some View {
        VStack {
            Text("Value: \(sharedPreference.rawValue)")

            Button("Decrement", action: {
                sharedPreference.value -= 1
            })
        }
        .padding()
        .background(.red)
    }
}

struct ContentView: View {
    var body: some View {
        VStack {
            IncrementView()
            DecrementView()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
