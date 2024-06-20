//
//  SETTING_LOGIN.swift
//  malguem
//
//  Created by 부산광역시교육청 on 2021/04/20.
//

import UIKit
import Alamofire

extension UIViewController {
    
    func GET_LOGIN_DATA(NAME: String, MB_ID: String, UPDATE: Bool) {
        
        let PARAMETERS: Parameters = [
            "mb_id": MB_ID,
            "gcm_id": UserDefaults.standard.string(forKey: "gcm_id") ?? "",
            "mb_platform": "iOS"
        ]
        
        let MANAGER = Alamofire.SessionManager.default
        MANAGER.session.configuration.timeoutIntervalForRequest = 10.0
        MANAGER.request(POST_URL().BASE + "member/m_login.php", method: .post, parameters: PARAMETERS).responseJSON { response in
            
            print("\n[\(NAME)]")
            for (KEY, VALUE) in PARAMETERS { print("KEY: \(KEY)", "VALUE: \(VALUE)") }
//            print(response)
            
            switch response.result {
            case .success(_):
/// 데이터 삭제
                UIViewController.APPDELEGATE.OBJ_PLANT.removeAll()
                
                guard let DATA_ARRAY = response.result.value as? Array<Any> else {
                    print("FAILURE: \(response.result.error.debugDescription)")
                    if UPDATE {
/// 데이터 새로고침
                        UIViewController.IC_ALERT.dismiss(animated: true, completion: nil)
                        UIViewController.APPDELEGATE.MONITORING_VC?.RF_IMAGE.ROTATE_360(ANIMATION: false)
                        UIViewController.APPDELEGATE.MONITORING_VC?.TABLE_VIEW.reloadData()
                    } else {
/// 로그인 실패
                        self.CONTROLLER_VC(IDENTIFIER: "SIGN_IN", MT_STYLE: .crossDissolve, ANIMATED: false)
                    }
                    return
                }
                
                for (_, DATA) in DATA_ARRAY.enumerated() {
                    
                    let DATA_DICT = DATA as? [String: Any]
                    let PLANT_DICT = DATA_DICT?["plant_data"] as? [String: Any]
                    let APPEND_VALUE = PLANT_DATA()
                    
                    APPEND_VALUE.SET_LGT(LGT: PLANT_DICT?["LGT"] as Any)
                    APPEND_VALUE.SET_PTY(PTY: PLANT_DICT?["PTY"] as Any)
                    APPEND_VALUE.SET_REH(REH: PLANT_DICT?["REH"] as Any)
                    APPEND_VALUE.SET_RN1(RN1: PLANT_DICT?["RN1"] as Any)
                    APPEND_VALUE.SET_SKY(SKY: PLANT_DICT?["SKY"] as Any)
                    APPEND_VALUE.SET_T1H(T1H: PLANT_DICT?["T1H"] as Any)
                    APPEND_VALUE.SET_UUU(UUU: PLANT_DICT?["UUU"] as Any)
                    APPEND_VALUE.SET_VEC(VEC: PLANT_DICT?["VEC"] as Any)
                    APPEND_VALUE.SET_VVV(VVV: PLANT_DICT?["VVV"] as Any)
                    APPEND_VALUE.SET_WSD(WSD: PLANT_DICT?["WSD"] as Any)
                    APPEND_VALUE.SET_AIR_TEM(AIR_TEM: PLANT_DICT?["air_tem"] as Any)
                    APPEND_VALUE.SET_AS_CALL(AS_CALL: PLANT_DICT?["as_call"] as Any)
                    APPEND_VALUE.SET_AS_NAME(AS_NAME: PLANT_DICT?["as_name"] as Any)
                    APPEND_VALUE.SET_BG_NAME(BG_NAME: PLANT_DICT?["bg_name"] as Any)
                    APPEND_VALUE.SET_BG_NO(BG_NO: PLANT_DICT?["bg_no"] as Any)
                    APPEND_VALUE.SET_C_CODE(C_CODE: PLANT_DICT?["c_code"] as Any)
                    APPEND_VALUE.SET_C_HOME(C_HOME: PLANT_DICT?["c_home"] as Any)
                    APPEND_VALUE.SET_C_NAME(C_NAME: PLANT_DICT?["c_name"] as Any)
                    APPEND_VALUE.SET_CHECKED_STRATION(CHECKED_STRATION: PLANT_DICT?["checked_stration"] as Any)
                    APPEND_VALUE.SET_DISPLAY(DISPLAY: PLANT_DICT?["display"] as Any)
                    APPEND_VALUE.SET_DUE_DATE(DUE_DATE: PLANT_DICT?["due_date"] as Any)
                    APPEND_VALUE.SET_GCM_ID(GCM_ID: PLANT_DICT?["gcm_id"] as Any)
                    APPEND_VALUE.SET_HORI_SUN(HORI_SUN: PLANT_DICT?["hori_sun"] as Any)
                    APPEND_VALUE.SET_IDX(IDX: PLANT_DICT?["idx"] as Any)
                    APPEND_VALUE.SET_INIT_AMOUNT(INIT_AMOUNT: PLANT_DICT?["init_amount"] as Any)
                    APPEND_VALUE.SET_INS_CAP(INS_CAP: PLANT_DICT?["installed_cap"] as Any)
                    APPEND_VALUE.SET_INS_DATE(INS_DATE: PLANT_DICT?["installed_date"] as Any)
                    APPEND_VALUE.SET_INV_CNT(INV_CNT: PLANT_DICT?["inv_cnt"] as Any)
                    APPEND_VALUE.SET_INV_COMPANY(INV_COMPANY: PLANT_DICT?["inverter_company"] as Any)
                    APPEND_VALUE.SET_INV_MODEL(INV_MODEL: PLANT_DICT?["inverter_model"] as Any)
                    APPEND_VALUE.SET_LAST_LOGIN(LAST_LOGIN: PLANT_DICT?["last_login"] as Any)
                    APPEND_VALUE.SET_LAT(LAT: PLANT_DICT?["lat"] as Any)
                    APPEND_VALUE.SET_LNG(LNG: PLANT_DICT?["lng"] as Any)
                    APPEND_VALUE.SET_MAC(MAC: PLANT_DICT?["mac"] as Any)
                    APPEND_VALUE.SET_MB_ADDRESS(MB_ADDRESS: PLANT_DICT?["mb_address"] as Any)
                    APPEND_VALUE.SET_MB_ID(MB_ID: PLANT_DICT?["mb_id"] as Any)
                    APPEND_VALUE.SET_MB_LEVEL(MB_LEVEL: PLANT_DICT?["mb_level"] as Any)
                    APPEND_VALUE.SET_MB_NAME(MB_NAME: PLANT_DICT?["mb_name"] as Any)
                    APPEND_VALUE.SET_MB_PW(MB_PW: PLANT_DICT?["mb_password"] as Any)
                    APPEND_VALUE.SET_MB_PLATFORM(MB_PLATFORM: PLANT_DICT?["mb_platform"] as Any)
                    APPEND_VALUE.SET_MEMO(MEMO: PLANT_DICT?["memo"] as Any)
                    APPEND_VALUE.SET_MODUL_TEM(MODUL_TEM: PLANT_DICT?["modul_tem"] as Any)
                    APPEND_VALUE.SET_PAY_AMOUNT(PAY_AMOUNT: PLANT_DICT?["pay_amount"] as Any)
                    APPEND_VALUE.SET_PAY_UPDATED(PAY_UPDATED: PLANT_DICT?["pay_updated"] as Any)
                    APPEND_VALUE.SET_P_ADDRESS(P_ADDRESS: PLANT_DICT?["plant_address"] as Any)
                    APPEND_VALUE.SET_P_CODE(P_CODE: PLANT_DICT?["plant_code"] as Any)
                    APPEND_VALUE.SET_P_NAME(P_NAME: PLANT_DICT?["plant_name"] as Any)
                    APPEND_VALUE.SET_P_ORDER(P_ORDER: PLANT_DICT?["plant_order"] as Any)
                    APPEND_VALUE.SET_PM10(PM10: PLANT_DICT?["pm10Value"] as Any)
                    APPEND_VALUE.SET_PM25(PM25: PLANT_DICT?["pm25Value"] as Any)
                    APPEND_VALUE.SET_REG_DATE(REG_DATE: PLANT_DICT?["reg_date"] as Any)
                    APPEND_VALUE.SET_SAFE_CALL(SAFE_CALL: PLANT_DICT?["safe_call"] as Any)
                    APPEND_VALUE.SET_SAFE_NAME(SAFE_NAME: PLANT_DICT?["safe_name"] as Any)
                    APPEND_VALUE.SET_SEND_STEP(SEND_STEP: PLANT_DICT?["send_step"] as Any)
                    APPEND_VALUE.SET_SUNRISE(SUNRISE: PLANT_DICT?["sunrise"] as Any)
                    APPEND_VALUE.SET_SUNSET(SUNSET: PLANT_DICT?["sunset"] as Any)
                    APPEND_VALUE.SET_TILT_SUN(TILT_SUN: PLANT_DICT?["tilt_sun"] as Any)
                    APPEND_VALUE.SET_UPDATE_TIME(UPDATE_TIME: PLANT_DICT?["update_time"] as Any)
                    APPEND_VALUE.SET_WEATHER_STATION(WEATHER_STATION: PLANT_DICT?["weather_station"] as Any)
                    APPEND_VALUE.SET_OBJ_GEN_DAILY(OBJ_GEN_DAILY: self.GET_GEN_DAILY_DATA(DATA_ARRAY: DATA_DICT?["gen_daily"] as? [Any] ?? []))
/// 데이터 추가
                    UIViewController.APPDELEGATE.OBJ_PLANT.append(APPEND_VALUE)
                }
                
                if UPDATE {
/// 데이터 새로고침
                    UIViewController.IC_ALERT.dismiss(animated: true, completion: nil)
                    UIViewController.APPDELEGATE.MONITORING_VC?.RF_IMAGE.ROTATE_360(ANIMATION: false)
                    UIViewController.APPDELEGATE.MONITORING_VC?.TABLE_VIEW.reloadData()
                } else {
/// 로그인 성공
                    UserDefaults.standard.setValue(MB_ID, forKey: "mb_id")
                    UserDefaults.standard.synchronize()
                    self.CONTROLLER_TBC(IDENTIFIER: "TBC", MT_STYLE: .crossDissolve, INDEX: 2, ANIMATED: true)
                }
            case .failure(let ERROR):
                
/// TIMEOUT
                if ERROR._code == NSURLErrorTimedOut { self.VIEW_NOTICE("E: 서버 연결 실패 (408)") }
                if ERROR._code == NSURLErrorNetworkConnectionLost { self.VIEW_NOTICE("E: 네트워크 연결 실패 (000)") }
                
                self.ALAMOFIRE_ERROR(ERROR: response.result.error as? AFError)
/// 로그인 실패
                self.CONTROLLER_VC(IDENTIFIER: "SIGN_IN", MT_STYLE: .crossDissolve, ANIMATED: false)
            }
        }
    }
    
    func GET_GEN_DAILY_DATA(DATA_ARRAY: [Any]) -> [GEN_DAILY] {
        
        var OBJ_GEN_DAILY: [GEN_DAILY] = []
        
        for (_, DATA) in DATA_ARRAY.enumerated() {
            
            let DATA_DICT = DATA as? [String: Any]
            let APPEND_VALUE = GEN_DAILY()
            
            APPEND_VALUE.SET_LGT(LGT: DATA_DICT?["LGT"] as Any)
            APPEND_VALUE.SET_PTY(PTY: DATA_DICT?["PTY"] as Any)
            APPEND_VALUE.SET_REH(REH: DATA_DICT?["REH"] as Any)
            APPEND_VALUE.SET_RN1(RN1: DATA_DICT?["RN1"] as Any)
            APPEND_VALUE.SET_SKY(SKY: DATA_DICT?["SKY"] as Any)
            APPEND_VALUE.SET_T1H(T1H: DATA_DICT?["T1H"] as Any)
            APPEND_VALUE.SET_UUU(UUU: DATA_DICT?["UUU"] as Any)
            APPEND_VALUE.SET_VEC(VEC: DATA_DICT?["VEC"] as Any)
            APPEND_VALUE.SET_VVV(VVV: DATA_DICT?["VVV"] as Any)
            APPEND_VALUE.SET_WSD(WSD: DATA_DICT?["WSD"] as Any)
            APPEND_VALUE.SET_DATE_TODAY(DATE_TODAY: DATA_DICT?["date_today"] as Any)
            APPEND_VALUE.SET_GEN_AMOUNT(GEN_AMOUNT: DATA_DICT?["gen_amount"] as Any)
            APPEND_VALUE.SET_GEN_CHECK(GEN_CHECK: DATA_DICT?["gen_check"] as Any)
            APPEND_VALUE.SET_GEN_NOW(GEN_NOW: DATA_DICT?["gen_now"] as Any)
            APPEND_VALUE.SET_OUT_CHECK(OUT_CHECK: DATA_DICT?["out_check"] as Any)
            APPEND_VALUE.SET_PM10(PM10: DATA_DICT?["pm10Value"] as Any)
            APPEND_VALUE.SET_PM25(PM25: DATA_DICT?["pm25Value"] as Any)
            APPEND_VALUE.SET_PROT_CHECK(PROT_CHECK: DATA_DICT?["prot_check"] as Any)
/// 데이터 추가
            OBJ_GEN_DAILY.append(APPEND_VALUE)
        }
        
        return OBJ_GEN_DAILY
    }
}
