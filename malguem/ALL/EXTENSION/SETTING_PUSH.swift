//
//  SETTING_PUSH.swift
//  malguem
//
//  Created by 부산광역시교육청 on 2021/05/06.
//

import UIKit
import FirebaseCore
import FirebaseMessaging
import UserNotifications

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func SETTING_PUSH(_ application: UIApplication) {
        
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        
        if #available(iOS 10.0, *) {

            UNUserNotificationCenter.current().delegate = self
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound], completionHandler: {granted, error in
                if let error = error { print("USERNOTIFICAIONS ERROR: \(error.localizedDescription)") }
            })
        } else {
            
            let SETTINGS: UIUserNotificationSettings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(SETTINGS)
        }
        application.registerForRemoteNotifications()
    }
    
/// 알림 받음
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        let USERINFO = notification.request.content.userInfo
        
        Messaging.messaging().appDidReceiveMessage(USERINFO)
        
        if let MSG_ID = USERINFO[GCM_KEY] { print("알림 받음 MSG_ID: \(MSG_ID)") }
        
        print("알림 받음 userNotificationCenter", USERINFO)
        
        completionHandler([.alert, .sound, .badge])
    }
    
/// 알림 누름
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        let USERINFO = response.notification.request.content.userInfo
        
        Messaging.messaging().appDidReceiveMessage(USERINFO)
        
        if let MSG_ID = USERINFO[GCM_KEY] { print("알림 누름 MSG_ID: \(MSG_ID)") }
        
        print("알림 누름 userNotificationCenter", USERINFO)
        
        completionHandler()
    }
    
/// 알림 받음
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        Messaging.messaging().appDidReceiveMessage(userInfo)
        
        if let MSG_ID = userInfo[GCM_KEY] { print("알림 누름 MSG_ID: \(MSG_ID)") }
        
        // 전체 메시지를 인쇄하십시오.
        print("알림 받음 application", userInfo)
        
        completionHandler(.newData)
    }
}

extension AppDelegate: MessagingDelegate {
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        
        print("FIREBASE TOKEN: \(fcmToken ?? "")")
        
        UserDefaults.standard.setValue("\(fcmToken ?? "")", forKey: "gcm_id")
        UserDefaults.standard.synchronize()
        
        let DATADICT: [String: Any] = ["token": fcmToken ?? ""]
        NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: DATADICT)
    }
}
