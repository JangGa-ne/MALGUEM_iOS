//
//  SETTING_WEATHER.swift
//  malguem
//
//  Created by 부산광역시교육청 on 2021/05/01.
//

import UIKit

extension UIViewController {
    
    func WT_IMAGE(DATA: PLANT_DATA, POSITION: Int) -> UIImage {
        
        var RAIN = 0
        var SKY = 0
        var LIGHT = Bool()
        var WIND = Bool()
        
        if POSITION != 0 {
            RAIN = Int(DATA.OBJ_GEN_DAILY[POSITION].PTY) ?? 0
            SKY = Int(DATA.OBJ_GEN_DAILY[POSITION].SKY) ?? 0
            LIGHT = DATA.OBJ_GEN_DAILY[POSITION].LGT == "1"
            WIND = DATA.OBJ_GEN_DAILY[POSITION].WSD == "1"
        } else {
            RAIN = Int(DATA.PTY) ?? 0
            SKY = Int(DATA.SKY) ?? 0
            LIGHT = DATA.LGT == "1"
            WIND = DATA.WSD == "1"
        }
        
        if POSITION == 0 {
            if !LIGHT {
                if RAIN == 0 {
                    if SKY == 1 { if WIND { return UIImage(named: "weather_06")! } else { return UIImage(named: "weather_01")! } }
                    if SKY == 3 { if WIND { return UIImage(named: "weather_07")! } else { return UIImage(named: "weather_02")! } }
                    if SKY == 4 { if WIND { return UIImage(named: "weather_07")! } else { return UIImage(named: "weather_14")! } }
                } else if RAIN == 1 || RAIN == 4 {
                    return UIImage(named: "weather_09")!
                } else if RAIN == 2 {
                    return UIImage(named: "weather_15")!
                } else if RAIN == 3 {
                    return UIImage(named: "weather_10")!
                }
            } else {
                return UIImage(named: "weather_08")!
            }
        } else {
            if !LIGHT {
                if RAIN == 0 {
                    if SKY == 1 { if WIND { return UIImage(named: "weather_06")! } else { return UIImage(named: "weather_01")! } }
                    if SKY == 3 { if WIND { return UIImage(named: "weather_07")! } else { return UIImage(named: "weather_02")! } }
                    if SKY == 4 { if WIND { return UIImage(named: "weather_07")! } else { return UIImage(named: "weather_14")! } }
                } else if RAIN == 1 || RAIN == 4 {
                    return UIImage(named: "weather_09")!
                } else if RAIN == 2 {
                    return UIImage(named: "weather_15")!
                } else if RAIN == 3 {
                    return UIImage(named: "weather_10")!
                }
            } else {
                return UIImage(named: "weather_08")!
            }
        }
        return UIImage(named: "weather_02")!
    }
    
    func WT_TITLE(IMAGE: UIImage) -> String {
        
        if IMAGE == UIImage(named: "weather_01") {
            return "매우맑음"
        } else if IMAGE == UIImage(named: "weather_02") {
            return "맑음"
        } else if IMAGE == UIImage(named: "weather_06") {
            return "태풍"
        } else if IMAGE == UIImage(named: "weather_07") {
            return "구름.바람"
        } else if IMAGE == UIImage(named: "weather_08") {
            return "비.번개"
        } else if IMAGE == UIImage(named: "weather_09") {
            return "소나기"
        } else if IMAGE == UIImage(named: "weather_10") {
            return "눈"
        } else if IMAGE == UIImage(named: "weather_14") {
            return "구름많음"
        } else if IMAGE == UIImage(named: "weather_15") {
            return "눈.비"
        } else {
            return "-"
        }
    }
}
