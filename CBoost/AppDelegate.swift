//
//  AppDelegate.swift
//  CBoost
//
//  Created by Tatsuya Moriguchi on 11/7/21.
//  Copyright © 2021 Tatsuya Moriguchi. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
                print("Chartboost SDK Version ", Chartboost.getSDKVersion() ?? "")
        
        Chartboost.addDataUseConsent(.CCPA(.optInSale))
        Chartboost.addDataUseConsent(.GDPR(.behavioral))

        Chartboost.setLoggingLevel(.info)

        Chartboost.start(withAppId: "51ddea8317ba47f056000006",
                         appSignature: "c5f5cad159d649fdd407659337b9ca5a842434b7") { (success) in
                            let vc = self.window?.rootViewController as? ViewController
                            vc?.log(message: success ? "Chartboost initialized successfully!" : "Chartboost failed to initialize.")
        }

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

