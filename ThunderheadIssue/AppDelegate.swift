//
//  AppDelegate.swift
//  ThunderheadIssue
//
//  Created by Pascal Huber on 25.10.19.
//  Copyright © 2019 Pascal Huber. All rights reserved.
//

import Thunderhead
import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupNotifications()
        setupThunderhead() // comment this out and remote Thunderhead import to get the correct behavior
        return true
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let deviceTokenString = deviceToken.reduce("") { $0 + String(format: "%02X", $1) }
        print("APNs device token: \(deviceTokenString)")
        print(UNUserNotificationCenter.current().delegate)
    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print(error)
    }

    fileprivate func setupNotifications() {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.delegate = self

        notificationCenter.requestAuthorization(options: [.badge, .alert, .sound]) { granted, _ in
            if granted {
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            }
        }
    }
    
    fileprivate func setupThunderhead() {
        One.startSessionWithSK("ONE-XXXXXXXXXX-1022",
        uri:"myAppsNameURI",
        apiKey:"f713d44a-8af0-4e79-ba7e-xxxxxxxxxxxxxxxx",
        sharedSecret:"bb8bacb2-ffc2-4c52-aaf4-xxxxxxxxxxxxxxxx",
        userId:"api@yourCompanyName",
        adminMode:false,
        hostName:"eu2.thunderhead.com")
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {}
