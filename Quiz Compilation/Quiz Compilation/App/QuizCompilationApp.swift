//
//  Quiz_CompilationApp.swift
//  Quiz Compilation
//
//  Created by Мирсаит Сабирзянов on 14.02.2025.
//

import SwiftUI
import FirebaseCore

final class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        return true
    }
}

@main
struct Quiz_CompilationApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @AppStorage("isLoggedIn") var isLogin = false
    @ObservedObject var appViewModel = AppViewModel()
    
    init() {
        if isLogin {
            appViewModel.status = .main
        }
    }
    
    var body: some Scene {
        WindowGroup {
            RouterView()
                .environmentObject(appViewModel)
        }
    }
}
