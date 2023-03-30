//
//  AppStorageObserver.swift
//  AppStorageExperiment
//
//  Created by Paul Calnan on 3/30/23.
//

import Combine
import SwiftUI

/// An `AppStorageObserver` observes and publishes changes to an `AppStorage`
/// value associated with a key.
///
final class AppStorageObserver<Value>: ObservableObject {

    /// We dynamically create an AppStorage instance instead of using the
    /// property wrapper syntax.
    ///
    private let storage: AppStorage<Value>

    /// AppStorage changes will trigger sends on an ObservableObject's
    /// objectWillChange publisher. We subscribe to those, compactMap (to allow
    /// the use of weak self) to the app storage's value, and re-publish it.
    ///
    lazy private(set) var publisher: AnyPublisher<Value, Never> = {
        objectWillChange
            .compactMap { [weak self] _ in
                self?.storage.wrappedValue
            }
            .eraseToAnyPublisher()
    }()

    // MARK: - Initializers

    init(for key: AppStorageKey<Value>) where Value == Bool {
        storage = AppStorage(key: key)
    }

    init(for key: AppStorageKey<Value>) where Value == Int {
        storage = AppStorage(key: key)
    }

    init(for key: AppStorageKey<Value>) where Value == Double {
        storage = AppStorage(key: key)
    }

    init(for key: AppStorageKey<Value>) where Value == String {
        storage = AppStorage(key: key)
    }

    init(for key: AppStorageKey<Value>) where Value == URL {
        storage = AppStorage(key: key)
    }

    init(for key: AppStorageKey<Value>) where Value == Data {
        storage = AppStorage(key: key)
    }

    init(for key: AppStorageKey<Value>) where Value: RawRepresentable, Value.RawValue == Int {
        storage = AppStorage(key: key)
    }

    init(for key: AppStorageKey<Value>) where Value: RawRepresentable, Value.RawValue == String {
        storage = AppStorage(key: key)
    }
}
