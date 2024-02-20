///Users/sudipthapa/Documents/IOS App Development/Thapa_Icebreaker_S24/Thapa_Icebreaker_S24/Thapa_Icebreaker_S24App.swift
//  Thapa_Icebreaker_S24App.swift
//  Thapa_Icebreaker_S24
//
//  Created by Sudip Thapa on 2/6/24.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct Thapa_Icebreaker_S24App: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
