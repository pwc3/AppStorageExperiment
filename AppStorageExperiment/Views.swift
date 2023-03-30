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
