//
//  AppDelegate.swift
//  PR36-ParseInsta
//
//  Created by Selcuk Baki on 4/5/21.
//

import UIKit
import Parse
import OneSignal


@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        let configuration = ParseClientConfiguration { ParseMutableClientConfiguration in
            ParseMutableClientConfiguration.applicationId = "oMkJ2Sald8U9PYqwWndmkKVmGp47dp0payKtC5eP"
            ParseMutableClientConfiguration.clientKey = "XwXM6njcYgetnXQxsCQSOvOl6c5arlC7elzQGPSE"
            ParseMutableClientConfiguration.server = "https://parseapi.back4app.com/"
            
        }
        Parse.initialize(with: configuration)
        let defaultACL = PFACL()
        defaultACL.hasPublicReadAccess = true
        defaultACL.hasPublicWriteAccess = true
        PFACL.setDefault(defaultACL, withAccessForCurrentUser: true)
        
        
        
        OneSignal.initWithLaunchOptions(launchOptions)
          OneSignal.setAppId("a56b40bb-124a-4190-9f23-41409eac3024")
        OneSignal.promptForPushNotifications(userResponse: { accepted in
          print("User accepted notifications: \(accepted)")
        })
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    

}

