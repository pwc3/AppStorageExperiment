//
//  AppDelegate.swift
//  AppStorageExperiment
//
//  Created by Paul Calnan on 3/30/23.
//

import Combine
import SwiftUI
import UIKit

final class AppDelegate: NSObject, UIApplicationDelegate {

    private var observer: AppStorageObserver<PreferenceValue>?
    private var cancellables = Set<AnyCancellable>()

    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        let observer = AppStorageObserver(for: sharedPreferenceKey)
        self.observer = observer

        observer
            .publisher
            .sink(receiveValue: {
                print("Received update to \(sharedPreferenceKey.name): \($0)")
            })
            .store(in: &cancellables)

        return true
    }
}
