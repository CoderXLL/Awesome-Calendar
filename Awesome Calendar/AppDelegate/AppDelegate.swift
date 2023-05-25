//
//  AppDelegate.swift
//  Awesome Calendar
//
//  Created by 肖乐乐 on 2023/5/15.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate, AppConfigurable {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        configureAppAppearance()
        return true
    }


}

