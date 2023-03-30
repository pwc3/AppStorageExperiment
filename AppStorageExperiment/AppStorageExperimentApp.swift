//
//  AppStorageExperimentApp.swift
//  AppStorageExperiment
//
//  Created by Paul Calnan on 3/30/23.
//

import SwiftUI

@main
struct AppStorageExperimentApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self)
    var appDelegate

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
