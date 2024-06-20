//
//  MONITORING.swift
//  malguem
//
//  Created by 부산광역시교육청 on 2021/04/21.
//

import UIKit

class MONITORING_TC: UITableViewCell {
    
    @IBOutlet weak var WT_BG: UIView!
    @IBOutlet weak var WT_IMAGE: UIImageView!
    @IBOutlet weak var WT_TITLE: UILabel!
    @IBOutlet weak var PM_10: UILabel!
    @IBOutlet weak var PM_25: UILabel!
    
    @IBOutlet weak var NOW_BG: UIView!
    @IBOutlet weak var ON_OFF_IMAGE: UIImageView!
    @IBOutlet weak var ON_OFF: UILabel!
    @IBOutlet weak var ROUND_VIEW: RoundView!
    @IBOutlet weak var T_NOW: UILabel!
    @IBOutlet weak var T_TOTAL: UILabel!
    @IBOutlet weak var T_TIME: UILabel!
    
    @IBOutlet weak var WEEK_BG: UIView!
    @IBOutlet weak var WT_IMAGE_1: UIImageView!
    @IBOutlet weak var DATETIME_1: UILabel!
    @IBOutlet weak var TOTAL_1: UILabel!
    @IBOutlet weak var TIME_1: UILabel!
    @IBOutlet weak var WT_IMAGE_2: UIImageView!
    @IBOutlet weak var DATETIME_2: UILabel!
    @IBOutlet weak var TOTAL_2: UILabel!
    @IBOutlet weak var TIME_2: UILabel!
    @IBOutlet weak var WT_IMAGE_3: UIImageView!
    @IBOutlet weak var DATETIME_3: UILabel!
    @IBOutlet weak var TOTAL_3: UILabel!
    @IBOutlet weak var TIME_3: UILabel!
    @IBOutlet weak var WT_IMAGE_4: UIImageView!
    @IBOutlet weak var DATETIME_4: UILabel!
    @IBOutlet weak var TOTAL_4: UILabel!
    @IBOutlet weak var TIME_4: UILabel!
    @IBOutlet weak var WT_IMAGE_5: UIImageView!
    @IBOutlet weak var DATETIME_5: UILabel!
    @IBOutlet weak var TOTAL_5: UILabel!
    @IBOutlet weak var TIME_5: UILabel!
    
    @IBOutlet weak var PAY: UIButton!
    @IBOutlet weak var INFO: UIButton!
    @IBOutlet weak var LOGOUT: UIButton!
}

class MONITORING: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBOutlet weak var NAVI_TITLE: UILabel!
    @IBOutlet weak var KAKAO_TALK: UIButton!
    @IBOutlet weak var RF_IMAGE: UIImageView!
    @IBOutlet weak var REFRESH: UIButton!
    @IBOutlet weak var TABLE_VIEW: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIViewController.APPDELEGATE.MONITORING_VC = self
        
        NAVI_TITLE.alpha = 0.0
        SETTING_KAKAO(KAKAO_TALK)
        REFRESH.addTarget(self, action: #selector(REFRESH(_:)), for: .touchUpInside)
        
/// 테이블뷰
        TABLE_VIEW.delegate = self
        TABLE_VIEW.dataSource = self
        TABLE_VIEW.separatorStyle = .none
    }
    
    override func viewWillAppear(_ animated: Bool) {
        BACK_GESTURE(false)
    }
    
    @objc func REFRESH(_ sender: UIButton) {
        NETWORK_CHECK()
    }
    
//MARK: 네트워크 연결 확인 및 데이터 불러오기 (통합모니터링)
    @objc func NETWORK_CHECK() {
        
        RF_IMAGE.ROTATE_360(ANIMATION: true)
        
        if NW_CHECK() {
//            present(UIViewController.IC_ALERT, animated: true, completion: nil)
            GET_LOGIN_DATA(NAME: "새로고침", MB_ID: UserDefaults.standard.string(forKey: "mb_id") ?? "", UPDATE: true)
        } else {
            VIEW_NOTICE("F: 네트워크 상태를 확인해 주세요")
            DispatchQueue.main.async {
                let ALERT = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
                ALERT.addAction(UIAlertAction(title: "새로고침", style: .default) { (_) in self.NETWORK_CHECK() })
                self.present(ALERT, animated: true, completion: nil)
            }
        }
    }
}

extension MONITORING: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let OFFSET_Y = scrollView.contentOffset.y
        if OFFSET_Y >= 0 { NAVI_TITLE.alpha = OFFSET_Y/20 } else { NAVI_TITLE.alpha = 0.0 }
    }
}

extension MONITORING: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let P_POSITION = UIViewController.APPDELEGATE.P_POSITION
        let OBJ_PLANT = UIViewController.APPDELEGATE.OBJ_PLANT
        
//MARK: 날씨 정보
        if indexPath.item == 0 {
            
            let CELL = tableView.dequeueReusableCell(withIdentifier: "MONITORING_TC_T", for: indexPath) as! MONITORING_TC
            
            CELL.WT_BG.layer.cornerRadius = 10.0
            CELL.WT_BG.clipsToBounds = true
            
            if OBJ_PLANT.count != 0 {
                
                let DATA = OBJ_PLANT[P_POSITION]
/// 날씨
                CELL.WT_IMAGE.image = WT_IMAGE(DATA: DATA, POSITION: 0)
                CELL.WT_TITLE.text = WT_TITLE(IMAGE: CELL.WT_IMAGE.image!)
/// 미세먼지
                if DATA.PM10 == "" { CELL.PM_10.text = "-" } else { CELL.PM_10.text = "\(DATA.PM10)μm" }
                if DATA.PM25 == "" { CELL.PM_25.text = "-" } else { CELL.PM_25.text = "\(DATA.PM25)μm" }
            }
            
            return CELL
//MARK: 오늘 발전정보
        } else if indexPath.item == 1 {
            
            let CELL = tableView.dequeueReusableCell(withIdentifier: "MONITORING_TC", for: indexPath) as! MONITORING_TC
            
            CELL.NOW_BG.layer.cornerRadius = 10.0
            CELL.NOW_BG.clipsToBounds = true
            
            if OBJ_PLANT.count != 0 {
                
                CELL.ROUND_VIEW.LINE = 50.0
                CELL.ROUND_VIEW.RADIUS = 2.5
                CELL.ROUND_VIEW.BG_LAYER.strokeColor = UIColor.GRAY_F1F1F1.cgColor
                
                let DATA = OBJ_PLANT[P_POSITION]
                if DATA.OBJ_GEN_DAILY.count != 0 {
/// 발전소 전원 확인
                    if !(DATA.SUNRISE == "0000-00-00 00:00:00" || DATA.SUNSET == "0000-00-00 00:00:00") {
                        
                        let DATE_FORMATTER = DateFormatter()
                        DATE_FORMATTER.dateFormat = "yyyy-MM-dd HH:mm:ss"
                        
                        let SUNRISE = DATE_FORMATTER.date(from: DATA.SUNRISE) ?? Date()
                        let SUNSET = DATE_FORMATTER.date(from: DATA.SUNSET) ?? Date()
                        
                        DATE_FORMATTER.dateFormat = "HH:mm:ss"
                        let TODAY = DATE_FORMATTER.string(from: Date())
                        let TODAY_SUNRISE = DATE_FORMATTER.string(from: SUNRISE)
                        let TODAY_SUNSET = DATE_FORMATTER.string(from: SUNSET)
                        
                        print("SUNRISE: \(TODAY_SUNRISE) NOW: \(TODAY) SUNSET: \(TODAY_SUNSET)")
                        
                        if (TODAY < TODAY_SUNRISE) || (TODAY > TODAY_SUNSET) {
/// 발전소 활성 상태
                            CELL.ON_OFF_IMAGE.image = UIImage(named: "off.png")
                            CELL.ON_OFF.text = "OFF"
                            CELL.ROUND_VIEW.ON_OFF = false
                            CELL.ROUND_VIEW.ERROR = false
                        } else {
                            
                            let OBJ_GEN_DAILY = DATA.OBJ_GEN_DAILY[0]
                            let ERROR = "\(OBJ_GEN_DAILY.OUT_CHECK)\(OBJ_GEN_DAILY.GEN_CHECK)\(OBJ_GEN_DAILY.PROT_CHECK)"
                            if ERROR == "000" {
                                CELL.ON_OFF_IMAGE.image = UIImage(named: "on.png")
                                CELL.ON_OFF.text = "ON"
                                CELL.ROUND_VIEW.ON_OFF = true
                                CELL.ROUND_VIEW.ERROR = false
                            } else {
                                CELL.ON_OFF_IMAGE.image = UIImage(named: "error.png")
                                CELL.ON_OFF.text = "발전소 이상"
                                if OBJ_GEN_DAILY.PROT_CHECK != "0" { CELL.ON_OFF.text = "프로텍션 이상" }
                                if OBJ_GEN_DAILY.GEN_CHECK != "0" { CELL.ON_OFF.text = "발전 이상" }
                                if OBJ_GEN_DAILY.OUT_CHECK != "0" { CELL.ON_OFF.text = "미개통" }
                                CELL.ROUND_VIEW.ON_OFF = true
                                CELL.ROUND_VIEW.ERROR = true
                            }
                        }
                    }
                    
                    if DATA.UPDATE_TIME == "0000-00-00 00:00:00" {
                        CELL.ON_OFF_IMAGE.image = UIImage(named: "off.png")
                        CELL.ON_OFF.text = "OFF"
                    }
/// 현재 발전량
                    let MAX = Double(DATA.INS_CAP) ?? 0.0
                    let NOW = Double(DATA.OBJ_GEN_DAILY[0].GEN_NOW) ?? 0.0
                    
                    if NOW == 0.0 {
                        CELL.ROUND_VIEW.RANGE = 100
                        CELL.ROUND_VIEW.CURRENT_VALUE = 0
                        CELL.T_NOW.text = "-"
                    } else {
                        CELL.ROUND_VIEW.RANGE = CGFloat(MAX)
                        CELL.ROUND_VIEW.CURRENT_VALUE = CGFloat(NOW/10)
                        CELL.T_NOW.text = "현재: \(UNIT_DATA(UNIT: NOW/10))"
                    }
/// 발전량, 발전시간
                    if DATA.OBJ_GEN_DAILY.count <= 1 {
                        
                        CELL.T_TOTAL.text = "-"
                        CELL.T_TIME.text = "-"
                    } else {
                        
                        let T_TOTAL = Double(DATA.OBJ_GEN_DAILY[0].GEN_AMOUNT) ?? 0.0
                        let Y_TOTAL = Double(DATA.OBJ_GEN_DAILY[1].GEN_AMOUNT) ?? 0.0
                        
                        if T_TOTAL == 0.0 {
                            
                            CELL.T_TOTAL.text = "-"
                        } else {
                            
                            let TOTAL = T_TOTAL - Y_TOTAL
                            CELL.T_TOTAL.text = UNIT_DATA(UNIT: TOTAL)
                            
                            let TIME = floor((TOTAL/MAX)*100)/100
                            if "\(TIME)" == "nan" || "\(TIME)" == "inf" || "\(TIME)" == "0.0" { CELL.T_TIME.text = "-" } else { CELL.T_TIME.text = "\(TIME) 시간" }
                        }
                    }
                }
            }
            
            return CELL
//MARK: 일주일 발전정보
        } else if indexPath.item == 2 {
            
            let CELL = tableView.dequeueReusableCell(withIdentifier: "MONITORING_TC_2", for: indexPath) as! MONITORING_TC
            
            CELL.WEEK_BG.layer.cornerRadius = 10.0
            CELL.WEEK_BG.clipsToBounds = true
            
            let WT_IMAGES: [UIImageView] = [CELL.WT_IMAGE_1, CELL.WT_IMAGE_2, CELL.WT_IMAGE_3, CELL.WT_IMAGE_4, CELL.WT_IMAGE_5]    // 날씨이미지
            let WT_DATES: [UILabel] = [CELL.DATETIME_1, CELL.DATETIME_2, CELL.DATETIME_3, CELL.DATETIME_4, CELL.DATETIME_5]         // 날짜
            let T_TOTALS: [UILabel] = [CELL.TOTAL_1, CELL.TOTAL_2, CELL.TOTAL_3, CELL.TOTAL_4, CELL.TOTAL_5]                        // 발전량
            let T_TIMES: [UILabel] = [CELL.TIME_1, CELL.TIME_2, CELL.TIME_3, CELL.TIME_4, CELL.TIME_5]                              // 발전시간
            
            if OBJ_PLANT.count != 0 {
                
                let DATA = OBJ_PLANT[P_POSITION]
                
                for i in 1 ... 5 {
                    
                    if i >= DATA.OBJ_GEN_DAILY.count-1 {

                        for ii in 1 ... 5 {
                            
                            WT_IMAGES[ii-1].image = UIImage(named: "weather_01")
                            WT_DATES[ii-1].text = "--월--일"
                            T_TOTALS[ii-1].text = "-"
                            T_TIMES[ii-1].text = "-"
                        }
                        
                        break
                    } else {
                        
                        let GEN_DAILY = DATA.OBJ_GEN_DAILY[i]
/// 날씨
                        WT_IMAGES[i-1].image = WT_IMAGE(DATA: DATA, POSITION: i)
/// 날짜
                        if GEN_DAILY.DATE_TODAY == "0000-00-00" {
                            
                            WT_DATES[i-1].text = "--월--일"
                        } else {
                            
                            let DF = DateFormatter()
                            DF.dateFormat = "yyyy-MM-dd"
                            let TODAY = DF.date(from: GEN_DAILY.DATE_TODAY)!
                            DF.dateFormat = "MM월dd일"
                            let DATE = DF.string(from: TODAY)
                            
                            WT_DATES[i-1].text = DATE
                        }
                        
                        let MAX = Double(DATA.INS_CAP) ?? 0.0
                        let T_TOTAL = Double(DATA.OBJ_GEN_DAILY[i].GEN_AMOUNT) ?? 0.0
                        let Y_TOTAL = Double(DATA.OBJ_GEN_DAILY[i+1].GEN_AMOUNT) ?? 0.0
                        
                        if T_TOTAL == 0.0 {
                            
                            T_TOTALS[i-1].text = "-"
                        } else {
                            
                            let TOTAL = T_TOTAL - Y_TOTAL
                            T_TOTALS[i-1].text = UNIT_DATA(UNIT: TOTAL)
                            
                            let TIME = floor((TOTAL/MAX)*100)/100
                            if "\(TIME)" == "nan" || "\(TIME)" == "inf" || "\(TIME)" == "0.0" { T_TIMES[i-1].text = "-" } else { T_TIMES[i-1].text = "\(TIME) 시간" }
                        }
                    }
                }
            }
            
            return CELL
//MARK: 기타
        } else {
            
            let CELL = tableView.dequeueReusableCell(withIdentifier: "LOGOUT", for: indexPath) as! MONITORING_TC
            
//            if UserDefaults.standard.string(forKey: "mb_id") ?? "" == "01095330004" {
//                CELL.PAY.isHidden = true
//                CELL.INFO.isHidden = false
//            } else {
//                CELL.PAY.isHidden = false
//                CELL.INFO.isHidden = true
//            }
            if UserDefaults.standard.string(forKey: "mb_id") ?? "" == "01095330004" {
                CELL.PAY.isHidden = true
            } else {
                CELL.PAY.isHidden = false
            }
            CELL.INFO.isHidden = true
            
/// 결제정보등록
            CELL.PAY.layer.borderWidth = 2.0
            CELL.PAY.layer.borderColor = UIColor.systemBlue.cgColor
            CELL.PAY.layer.cornerRadius = 10.0
            CELL.PAY.clipsToBounds = true
            CELL.PAY.addTarget(self, action: #selector(PAY(_:)), for: .touchUpInside)
/// 고객정보
            CELL.INFO.layer.borderWidth = 2.0
            CELL.INFO.layer.borderColor = UIColor.systemBlue.cgColor
            CELL.INFO.layer.cornerRadius = 10.0
            CELL.INFO.clipsToBounds = true
            CELL.INFO.addTarget(self, action: #selector(INFO(_:)), for: .touchUpInside)
/// 로그아웃
            CELL.LOGOUT.layer.borderWidth = 2.0
            CELL.LOGOUT.layer.borderColor = UIColor.systemRed.cgColor
            CELL.LOGOUT.layer.cornerRadius = 10.0
            CELL.LOGOUT.clipsToBounds = true
            CELL.LOGOUT.addTarget(self, action: #selector(LOGOUT(_:)), for: .touchUpInside)
            
            return CELL
        }
    }
    
//MARK: 결제정보등록
    @objc func PAY(_ sender: UIButton) {
        CONTROLLER_VC(IDENTIFIER: "PAYMENT", MT_STYLE: .crossDissolve, ANIMATED: true)
    }
            
//MARK: 고객정보
    @objc func INFO(_ sender: UIButton) {
//        CONTROLLER_VC(IDENTIFIER: "INFOMATION", MT_STYLE: .crossDissolve, ANIMATED: true)
    }
    
//MARK: 로그아웃
    @objc func LOGOUT(_ sender: UIButton) {
        
        UINotificationFeedbackGenerator().notificationOccurred(.error)
        
        let ALERT = UIAlertController(title: "", message: "로그아웃 하시겠습니까?", preferredStyle: .alert)
        
        ALERT.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        ALERT.addAction(UIAlertAction(title: "로그아웃", style: .destructive, handler: { _ in
            
            UserDefaults.standard.removeObject(forKey: "mb_id")
            UserDefaults.standard.synchronize()
            UIViewController.APPDELEGATE.P_POSITION = 0
            
            self.CONTROLLER_VC(IDENTIFIER: "SIGN_IN", MT_STYLE: .crossDissolve, ANIMATED: true)
        }))
        
        present(ALERT, animated: true, completion: nil)
    }
}
