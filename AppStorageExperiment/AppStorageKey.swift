//
//  AppStorageKey.swift
//  AppStorageExperiment
//
//  Created by Paul Calnan on 3/30/23.
//

import SwiftUI

struct AppStorageKey<Value> {
    var name: String
    var defaultValue: Value
}

extension AppStorage {
    init(key: AppStorageKey<Value>, store: UserDefaults? = nil) where Value == Bool {
        self.init(wrappedValue: key.defaultValue, key.name, store: store)
    }

    init(key: AppStorageKey<Value>, store: UserDefaults? = nil) where Value == Int {
        self.init(wrappedValue: key.defaultValue, key.name, store: store)
    }

    init(key: AppStorageKey<Value>, store: UserDefaults? = nil) where Value == Double {
        self.init(wrappedValue: key.defaultValue, key.name, store: store)
    }

    init(key: AppStorageKey<Value>, store: UserDefaults? = nil) where Value == String {
        self.init(wrappedValue: key.defaultValue, key.name, store: store)
    }

    init(key: AppStorageKey<Value>, store: UserDefaults? = nil) where Value == URL {
        self.init(wrappedValue: key.defaultValue, key.name, store: store)
    }

    init(key: AppStorageKey<Value>, store: UserDefaults? = nil) where Value == Data {
        self.init(wrappedValue: key.defaultValue, key.name, store: store)
    }

    init(key: AppStorageKey<Value>, store: UserDefaults? = nil) where Value: RawRepresentable, Value.RawValue == Int {
        self.init(wrappedValue: key.defaultValue, key.name, store: store)
    }

    init(key: AppStorageKey<Value>, store: UserDefaults? = nil) where Value: RawRepresentable, Value.RawValue == String {
        self.init(wrappedValue: key.defaultValue, key.name, store: store)
    }
}
