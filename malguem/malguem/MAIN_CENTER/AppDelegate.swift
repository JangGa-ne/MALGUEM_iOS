//
//  AppDelegate.swift
//  malguem
//
//  Created by 장 제현 on 2021/04/20.
//

import UIKit
import CoreData
import FirebaseMessaging

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
// MARK: COREDATA -------------------------------------------------------------
    
    lazy var PERSISTENT_CONTAINER: NSPersistentContainer = {
        
        let CONTAINER = NSPersistentContainer(name: "COREDATA")
        CONTAINER.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let ERROR = error as NSError? { fatalError("Unresolved error \(ERROR), \(ERROR.userInfo)") }
        })
        return CONTAINER
    }()
    
// 데이터 소스 역할을 할 배열 변수
    lazy var OBJ_PAY_INFO: [NSManagedObject] = { return COREDATA_FETCH(ENTITY_NAME: "PAY_INFO") }()
    
//MARK: FIREBASE --------------------------------------------------------------
    
    var GCM_KEY: String = "gcm.message_id"

//MARK: APPDELEGAETE ----------------------------------------------------------
    
    let APP_NAME: String = "MALGUEM"
    var SWIPE_GESTURE: Bool = false
    
/// 뷰컨틀롤러 연결 및 이동
    var WINDOW: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
    var STORYBOARD: UIStoryboard = UIStoryboard(name: "Main-malguem", bundle: nil)
    
/// 발전소 데이터
    var OBJ_PLANT: [PLANT_DATA] = []
    var P_POSITION: Int = 0
    
/// EXTENSION 연결
    var VIEWCONTROLLER = UIViewController()
    
    var NOTICE_VC: NOTICE?
    var INVERTER_VC: INVERTER?
    var MONITORING_VC: MONITORING?
    var CHART_VC: CHART?
    var AS_RECEIPT_VC: AS_RECEIPT?
    
    var PAYMENT_ADD_VC: PAYMENT_ADD?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
/// FIREBASE PUSH 설정
        SETTING_PUSH(application)
        
/// PUSH로 진입
        if let USER_INFO = launchOptions?[.remoteNotification] as? [String: Any] {
            
            print("PUSH로 진입 :", USER_INFO)
        } else {
            
            let VC = STORYBOARD.instantiateViewController(withIdentifier: "NAVI") as! UINavigationController
            WINDOW?.rootViewController = VC
            WINDOW?.makeKeyAndVisible()
        }
        
        return true
    }
}

extension AppDelegate {
    
    func applicationWillResignActive(_ application: UIApplication) {
        print("applicationWillResignActive")
        Messaging.messaging().isAutoInitEnabled = true
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        print("applicationDidEnterBackground")
        Messaging.messaging().isAutoInitEnabled = true
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        print("applicationWillEnterForeground")
        Messaging.messaging().isAutoInitEnabled = true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        print("applicationDidBecomeActive")
        Messaging.messaging().isAutoInitEnabled = true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        print("applicationWillTerminate")
        Messaging.messaging().isAutoInitEnabled = true
    }
    
    func applicationDidFinishLaunching(_ application: UIApplication) {
        print("applicationDidFinishLaunching")
        Messaging.messaging().isAutoInitEnabled = true
    }
}

