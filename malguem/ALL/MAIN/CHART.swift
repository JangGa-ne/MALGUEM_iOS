//
//  CHART.swift
//  malguem
//
//  Created by 부산광역시교육청 on 2021/04/30.
//

import UIKit
import Alamofire
import Charts

class CHART: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 13.0, *) { return .darkContent } else { return .default }
    }
    
    var P_CODE: String = ""
    var P_TYPE: String = ""
    var P_HOUR: String = ""
    var P_DATE: String = ""
    var P_MONTH: String = ""
    var P_YEAR: String = ""
    
    var OBJ_CHART: [CHART_DATA] = []
    
    @IBOutlet weak var KAKAO_TALK: UIButton!
    @IBOutlet weak var CHART_VIEW: BarChartView!
    @IBOutlet weak var NO_DATA: UILabel!
    
    @IBOutlet weak var SELECT_TITLE: UILabel!
    @IBOutlet weak var TIME: UIButton!
    @IBOutlet weak var DATE: UIButton!
    @IBOutlet weak var MONTH: UIButton!
    @IBOutlet weak var YEAR: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIViewController.APPDELEGATE.CHART_VC = self
        
        SETTING_KAKAO(KAKAO_TALK)
        
        P_TYPE = "hour"
        
        let DF = DateFormatter()
        DF.timeZone = TimeZone(identifier: "Asia/Seoul")
        DF.locale = Locale(identifier: "ko_kr")
        DF.dateFormat = "yyyy-MM-dd"
        P_HOUR = DF.string(from: Date())
        
/// 차트 기본 설정
        SETTING_CHART(VIEW: CHART_VIEW)
        
        RADIUS(TIME, CORNER: 10.0, CLIP: true)
        RADIUS(DATE, CORNER: 10.0, CLIP: true)
        RADIUS(MONTH, CORNER: 10.0, CLIP: true)
        RADIUS(YEAR, CORNER: 10.0, CLIP: true)
        
        TIME.tag = 0
        TIME.addTarget(self, action: #selector(TYPE(_:)), for: .touchUpInside)
        DATE.tag = 1
        DATE.addTarget(self, action: #selector(TYPE(_:)), for: .touchUpInside)
        MONTH.tag = 2
        MONTH.addTarget(self, action: #selector(TYPE(_:)), for: .touchUpInside)
        YEAR.tag = 3
        YEAR.addTarget(self, action: #selector(TYPE(_:)), for: .touchUpInside)
        
        DF.dateFormat = "yyyy. MM. dd."
        SELECT_TITLE.text = "시간별 데이터 ( \(DF.string(from: Date())) )"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        BACK_GESTURE(false)
    }
    
    @objc func TYPE(_ sender: UIButton) {
        
        if sender.tag == 0 {
/// 시간별
            let ALERT = UIAlertController( title: "시간별", message: "\n\n\n\n\n\n\n\n\n", preferredStyle: .actionSheet)
            
            let P_FRAME = CGRect(x: 0, y: 50, width: ALERT.view.bounds.width-10, height: 160)
            let P_HOUR = PICKER_DATE(frame: P_FRAME)
            P_HOUR.SELECT_DATE = { YEAR, MONTH, DATE in
                self.P_HOUR = String(format: "%04d-%02d-%02d", YEAR, MONTH, DATE)
                self.SELECT_TITLE.text = "시간별 데이터 ( \(String(format: "%04d. %02d. %02d.", YEAR, MONTH, DATE)) )"
            }
            ALERT.view.addSubview(P_HOUR)
            ALERT.addAction(UIAlertAction(title: "확인", style: .cancel, handler: { _ in
                self.P_TYPE = "hour"; self.P_DATE = ""; self.NETWORK_CHECK()
            }))
            
            present(ALERT, animated: true, completion: nil)
        } else if sender.tag == 1 {
/// 일별
            let ALERT = UIAlertController( title: "일별", message: "\n\n\n\n\n\n\n\n\n", preferredStyle: .actionSheet)
            
            let P_FRAME = CGRect(x: 0, y: 50, width: ALERT.view.bounds.width-10, height: 160)
            let P_DATE = PICKER_MONTH(frame: P_FRAME)
            P_DATE.SELECT_MONTH = { YEAR, MONTH in
                self.P_DATE = String(format: "%04d%02d", YEAR, MONTH)
                self.SELECT_TITLE.text = "일별 데이터 ( \(String(format: "%04d. %02d.", YEAR, MONTH)) )"
            }
            ALERT.view.addSubview(P_DATE)
            ALERT.addAction(UIAlertAction(title: "확인", style: .cancel, handler: { _ in
                self.P_TYPE = "day"; self.P_HOUR = ""; self.NETWORK_CHECK()
            }))
            
            present(ALERT, animated: true, completion: nil)
        } else if sender.tag == 2 {
/// 월별
            SELECT_TITLE.text = "월별 데이터"; P_TYPE = "month"; P_HOUR = ""; P_DATE = ""; NETWORK_CHECK()
        } else {
/// 연도별
            SELECT_TITLE.text = "연도별 데이터"; P_TYPE = "year"; P_HOUR = ""; P_DATE = ""; NETWORK_CHECK()
        }
    }
    
    //MARK: 네트워크 연결 확인 및 데이터 불러오기 (기간발전량)
    @objc func NETWORK_CHECK() {
        
        if NW_CHECK() {
//            present(UIViewController.IC_ALERT, animated: true, completion: nil)
            GET_POST_DATA(NAME: "기간발전량")
        } else {
            VIEW_NOTICE("F: 네트워크 상태를 확인해 주세요")
            DispatchQueue.main.async {
                let ALERT = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
                ALERT.addAction(UIAlertAction(title: "새로고침", style: .default) { (_) in self.NETWORK_CHECK() })
                self.present(ALERT, animated: true, completion: nil)
            }
        }
    }
    
    func GET_POST_DATA(NAME: String) {
        
        let PARAMETERS: Parameters = [
            "mb_id": UserDefaults.standard.string(forKey: "mb_id") ?? "",
            "plant_code": P_CODE,
            "type" : P_TYPE,
            "date_today" : P_HOUR,
            "monthly" : P_DATE,
            "target_year" : ""
        ]
        
        let MANAGER = Alamofire.SessionManager.default
        MANAGER.session.configuration.timeoutIntervalForRequest = 10.0
        MANAGER.request(POST_URL().BASE + "light/m_period_info.php", method: .post, parameters: PARAMETERS).responseJSON { response in
            
            print("\n[\(NAME)]")
            for (KEY, VALUE) in PARAMETERS { print("KEY: \(KEY)", "VALUE: \(VALUE)") }
//            print(response)
            
            switch response.result {
            case .success(_):
/// 데이터 삭제
                self.OBJ_CHART.removeAll()
                
                guard let DATA_ARRAY = response.result.value as? Array<Any> else {
                    print("FAILURE: \(response.result.error.debugDescription)")
                    UIViewController.IC_ALERT.dismiss(animated: true, completion: nil)
                    self.SETUP()
                    return
                }
                
                for (_, DATA) in DATA_ARRAY.enumerated() {
                    
                    let DATA_DICT = DATA as? [String: Any]
                    let APPEND_VALUE = CHART_DATA()
                    
                    APPEND_VALUE.SET_DATE_TODAY(DATE_TODAY: DATA_DICT?["date_today"] as Any)
                    APPEND_VALUE.SET_GEN_AMOUNT(GEN_AMOUNT: DATA_DICT?["gen_amount"] as Any)
                    APPEND_VALUE.SET_GEN_HOUR(GEN_HOUR: DATA_DICT?["gen_hour"] as Any)
                    APPEND_VALUE.SET_GEN_DAY(GEN_DAY: DATA_DICT?["date_today"] as Any)
                    APPEND_VALUE.SET_GEN_MONTH(GEN_MONTH: DATA_DICT?["gen_month"] as Any)
                    APPEND_VALUE.SET_GEN_YEAR(GEN_YEAR: DATA_DICT?["gen_year"] as Any)
/// 데이터 추가
                    self.OBJ_CHART.append(APPEND_VALUE)
                }
                UIViewController.IC_ALERT.dismiss(animated: true, completion: nil)
                self.SETUP()
            case .failure(let ERROR):
/// TIMEOUT
                if ERROR._code == NSURLErrorTimedOut { self.VIEW_NOTICE("E: 서버 연결 실패 (408)") }
                if ERROR._code == NSURLErrorNetworkConnectionLost { self.VIEW_NOTICE("E: 네트워크 연결 실패 (000)"); self.NETWORK_CHECK() }
                
                self.ALAMOFIRE_ERROR(ERROR: response.result.error as? AFError)
            }
        }
    }
    
    func SETUP() {
        
        if OBJ_CHART.count != 0 {
            
            NO_DATA.isHidden = true
            
            var BOTTOM_VF: [String] = []
            for DATA in OBJ_CHART {
                if P_TYPE == "hour" {
                    if DATA.GEN_HOUR != "" { BOTTOM_VF.append("\(DATA.GEN_HOUR)시") }
                } else if P_TYPE == "day" {
                    if DATA.GEN_DAY != "" {
                        let START = DATA.GEN_DAY.index(DATA.GEN_DAY.endIndex, offsetBy: -2)
                        print(START)
                        let END = DATA.GEN_DAY.index(before: DATA.GEN_DAY.endIndex)
                        BOTTOM_VF.append("\(DATA.GEN_DAY[START...END])일")
                    }
                } else if P_TYPE == "month" {
                    if DATA.GEN_MONTH != "" { BOTTOM_VF.append("\(DATA.GEN_MONTH)월") }
                } else if P_TYPE == "year" {
                    if DATA.GEN_YEAR != "" { BOTTOM_VF.append("\(DATA.GEN_YEAR)년") }
                }
            }
            CHART_VIEW.xAxis.valueFormatter = IndexAxisValueFormatter(values: BOTTOM_VF)
            
            var VALUE: [BarChartDataEntry] = []
            if OBJ_CHART.count > 1 {
                for i in 1 ... OBJ_CHART.count-1 {
                    let TOTAL_1 = Double(OBJ_CHART[i-1].GEN_AMOUNT) ?? 0.0
                    let TOTAL_2 = Double(OBJ_CHART[i].GEN_AMOUNT) ?? 0.0
                    VALUE.append(BarChartDataEntry(x: Double(i), y: TOTAL_2 - TOTAL_1))
                }
            }
            
            let TODAY = BarChartDataSet(entries: VALUE, label: "")
            if UIViewController.APPDELEGATE.APP_NAME.contains("SEORAK") {
                TODAY.setColor(.SEORAK_1)
            } else if UIViewController.APPDELEGATE.APP_NAME.contains("MALGUEM") {
                TODAY.setColor(.MALGUEM_1)
            }
            CHART_VIEW.legend.yOffset = -5.0
            
            let G_SPACE = 0.75
            let B_SPACE = 0.05
            let B_WIDTH = 0.20
            
            let APPEND_DATA = BarChartData(dataSet: TODAY)
            APPEND_DATA.setValueTextColor(.clear)
            APPEND_DATA.setValueFormatter(LEFT_VF())
            APPEND_DATA.barWidth = B_WIDTH
            APPEND_DATA.groupBars(fromX: 0, groupSpace: G_SPACE, barSpace: B_SPACE)
            
            CHART_VIEW.xAxis.axisMinimum = 1.00 - G_SPACE
            CHART_VIEW.xAxis.axisMaximum = APPEND_DATA.groupWidth(groupSpace: G_SPACE, barSpace: B_SPACE) * Double(OBJ_CHART.count-1) + G_SPACE
            CHART_VIEW.data = APPEND_DATA
/// 스크롤 제어
            CHART_VIEW.zoom(scaleX: 0, scaleY: 0, x: 0, y: 0)
            if OBJ_CHART.count > 15 {
                CHART_VIEW.zoom(scaleX: 3.50, scaleY: 1, x: 0, y: 0)
            } else if OBJ_CHART.count > 7 {
                CHART_VIEW.zoom(scaleX: 2.25, scaleY: 1, x: 0, y: 0)
            } else {
                CHART_VIEW.zoom(scaleX: 1.00, scaleY: 1, x: 0, y: 0)
            }
        } else {
            
            NO_DATA.isHidden = false
        }
    }
}
