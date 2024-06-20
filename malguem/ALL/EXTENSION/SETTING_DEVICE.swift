//
//  SETTING_DEVICE.swift
//  malguem
//
//  Created by 부산광역시교육청 on 2021/05/06.
//

import UIKit

//MARK: 디바이스 확인
extension UIViewController {
    
    func GET_DEVICE_IDENTIFIER() -> String {
        
        var SYSTEM_INFO = utsname()
        uname(&SYSTEM_INFO)
        let MACHINE_MIRROR = Mirror(reflecting: SYSTEM_INFO.machine)
        let IDENTIFIER = MACHINE_MIRROR.children.reduce("") { identifier, element in
            guard let VALUE = element.value as? Int8, VALUE != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(VALUE)))
        }
        
        return IDENTIFIER
    }
    
    func DEVICE_RATIO() -> String {
        
        let MODEL = UIDevice.current.model
        
        switch MODEL {
        case "iPhone":
            return IPHONE()
        default:
            print("\(MODEL) 지원하지 않음")
            return IPHONE()
        }
    }
    
    func IPHONE() -> String {
        
        let IDENTIFIER = GET_DEVICE_IDENTIFIER()
        
        switch IDENTIFIER {
        
        // iPhone
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "Ratio 16:9"         // iPhone 4
        case "iPhone4,1":                               return "Ratio 16:9"         // iPhone 4s
        case "iPhone5,1", "iPhone5,2":                  return "Ratio 16:9"         // iPhone 5
        case "iPhone5,3", "iPhone5,4":                  return "Ratio 16:9"         // iPhone 5c
        case "iPhone6,1", "iPhone6,2":                  return "Ratio 16:9"         // iPhone 5s
        case "iPhone7,2":                               return "Ratio 16:9"         // iPhone 6
        case "iPhone7,1":                               return "Ratio 16:9"         // iPhone 6 Plus
        case "iPhone8,1":                               return "Ratio 16:9"         // iPhone 6s
        case "iPhone8,2":                               return "Ratio 16:9"         // iPhone 6s Plus
        case "iPhone8,4":                               return "Ratio 16:9"         // iPhone SE
        case "iPhone9,1", "iPhone9,3":                  return "Ratio 16:9"         // iPhone 7
        case "iPhone9,2", "iPhone9,4":                  return "Ratio 16:9"         // iPhone 7 Plus
        case "iPhone10,1", "iPhone10,4":                return "Ratio 16:9"         // iPhone 8
        case "iPhone10,2", "iPhone10,5":                return "Ratio 16:9"         // iPhone 8 Plus
        
        case "iPhone10,3", "iPhone10,6":                return "Ratio 18:9"         // iPhone X
        case "iPhone11,2":                              return "Ratio 18:9"         // iPhone XS
        case "iPhone11,4", "iPhone11,6":                return "Ratio 18:9"         // iPhone XS Max
        case "iPhone11,8":                              return "Ratio 18:9"         // iPhone XR
        case "iPhone12,1":                              return "Ratio 18:9"         // iPhone 11
        case "iPhone12,3":                              return "Ratio 18:9"         // iPhone 11 Pro
        case "iPhone12,5":                              return "Ratio 18:9"         // iPhone 11 Pro Max
        // NEW
        case "iPhone13,1":                              return "Ratio 18:9"         // iPhone 12 Mini
        case "iPhone13,2":                              return "Ratio 18:9"         // iPhone 12
        case "iPhone13,3":                              return "Ratio 18:9"         // iPhone 12 Pro
        case "iPhone13,4":                              return "Ratio 18:9"         // iPhone 12 Pro Max
        
        case "iPhone12,8":                              return "Ratio 16:9"         // iPhone SE (2nd generation)
        
        // iPod
        case "iPod1,1":                                 return "Ratio 16:9"         // iPod 1st
        case "iPod2,1":                                 return "Ratio 16:9"         // iPod 2nd
        case "iPod3,1":                                 return "Ratio 16:9"         // iPod 3rd
        case "iPod4,1":                                 return "Ratio 16:9"         // iPod 4th
        case "iPod5,1":                                 return "Ratio 16:9"         // iPod 5th
        case "iPod7,1":                                 return "Ratio 16:9"         // iPod 6th
        case "iPod9,1":                                 return "Ratio 16:9"         // iPod 7th
            
        default: return "Ratio 18:9" }
    }
}
