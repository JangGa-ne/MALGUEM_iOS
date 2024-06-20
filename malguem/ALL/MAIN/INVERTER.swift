//
//  INVERTER.swift
//  malguem
//
//  Created by 부산광역시교육청 on 2021/04/30.
//

import UIKit
import Alamofire

class INVERTER_TC: UITableViewCell {
    
    @IBOutlet weak var INV_ON_OFF: UIImageView!
    @IBOutlet weak var INV_NUM: UILabel!
    @IBOutlet weak var G_TOTAL: UILabel!
    @IBOutlet weak var T_TOTAL: UILabel!
    @IBOutlet weak var N_POWER: UILabel!
}

class INVERTER: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 13.0, *) { return .darkContent } else { return .default }
    }
    
    var P_CODE: String = ""
    
    var OBJ_INVERTER: [INVERTER_DATA] = []
    var I_POSITION: Int = 0
    
    var PICKER_VIEW = UIPickerView()
    
    @IBOutlet weak var KAKAO_TALK: UIButton!
    
    @IBOutlet weak var ERROR: UILabel!
    @IBOutlet weak var N_POWER: UILabel!
    @IBOutlet weak var UNIT: UILabel!
    @IBOutlet weak var ROUND_VIEW: RoundView!
    @IBOutlet weak var PERCENT: UILabel!
    
    @IBOutlet weak var SELECT_INV: UITextField!
    
    @IBOutlet weak var INV_BG: UIView!
    @IBOutlet weak var INV_CNT: UILabel!
    @IBOutlet weak var INV_VOLTAGE: UILabel!
    @IBOutlet weak var INV_VOLUME: UILabel!
    @IBOutlet weak var T_TOTAL_BG: UIView!
    @IBOutlet weak var T_TOTAL: UILabel!
    @IBOutlet weak var Y_TOTAL_BG: UIView!
    @IBOutlet weak var Y_TOTAL: UILabel!
    @IBOutlet weak var G_TOTAL_BG: UIView!
    @IBOutlet weak var G_TOTAL: UILabel!
    @IBOutlet weak var CO2_BG: UIView!
    @IBOutlet weak var CO2: UILabel!
    
    @IBOutlet weak var TABLE_VIEW_BG: UIView!
    @IBOutlet weak var TABLE_VIEW: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIViewController.APPDELEGATE.INVERTER_VC = self
        
        SETTING_KAKAO(KAKAO_TALK)
        
        ROUND_VIEW.LINE = 40.0
        ROUND_VIEW.RADIUS = 3.0
        ROUND_VIEW.BG_LAYER.strokeColor = UIColor.white.cgColor
        
        RADIUS(SELECT_INV, CORNER: 10.0, CLIP: true)
        RADIUS(INV_BG, CORNER: 10.0, CLIP: true)
        RADIUS(T_TOTAL_BG, CORNER: 5.0, CLIP: true)
        RADIUS(Y_TOTAL_BG, CORNER: 5.0, CLIP: true)
        RADIUS(G_TOTAL_BG, CORNER: 5.0, CLIP: true)
        RADIUS(CO2_BG, CORNER: 5.0, CLIP: true)
        RADIUS(TABLE_VIEW_BG, CORNER: 10.0, CLIP: true)
        
/// 인버터명
        SELECT_INV.text = "인버터 #1"
        PLACEHOLDER(TF: SELECT_INV, PH: "인버터명")
        TOOL_BAR_DONE(TF: SELECT_INV, TV: UITextView(), SB: UISearchBar())
        SELECT_INV.PADDING_LEFT(X: 10.0)
        SELECT_INV.inputView = PICKER_VIEW
/// 피커뷰
        PICKER_VIEW.delegate = self
        PICKER_VIEW.dataSource = self
/// 테이블뷰
        TABLE_VIEW.delegate = self
        TABLE_VIEW.dataSource = self
        TABLE_VIEW.separatorStyle = .none
    }
    
    override func viewWillAppear(_ animated: Bool) {
        BACK_GESTURE(false)
    }
    
//MARK: 네트워크 연결 확인 및 데이터 불러오기 (인버터현황)
    @objc func NETWORK_CHECK() {
        
        if NW_CHECK() {
//            present(UIViewController.IC_ALERT, animated: true, completion: nil)
            GET_POST_DATA(NAME: "인버터현황")
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
            "plant_code": P_CODE
        ]
        
        let MANAGER = Alamofire.SessionManager.default
        MANAGER.session.configuration.timeoutIntervalForRequest = 10.0
        MANAGER.request(POST_URL().BASE + "light/m_inv_info.php", method: .post, parameters: PARAMETERS).responseJSON { response in
            
            print("\n[\(NAME)]")
            for (KEY, VALUE) in PARAMETERS { print("KEY: \(KEY)", "VALUE: \(VALUE)") }
//            print(response)
            
            switch response.result {
            case .success(_):
/// 데이터 삭제
                self.OBJ_INVERTER.removeAll()
                
                guard let DATA_ARRAY = response.result.value as? Array<Any> else {
                    print("FAILURE: \(response.result.error.debugDescription)")
                    UIViewController.IC_ALERT.dismiss(animated: true, completion: nil)
                    self.SET_UP(); self.TABLE_VIEW.reloadData()
                    return
                }
                
                for (_, DATA) in DATA_ARRAY.enumerated() {
                    
                    let DATA_DICT = DATA as? [String: Any]
                    let APPEND_VALUE = INVERTER_DATA()
                    
                    APPEND_VALUE.SET_ALITVE(ALITVE: DATA_DICT?["alive"] as Any)
                    APPEND_VALUE.SET_BG_NAME(BG_NAME: DATA_DICT?["bg_name"] as Any)
                    APPEND_VALUE.SET_BG_NO(BG_NO: DATA_DICT?["bg_no"] as Any)
                    APPEND_VALUE.SET_C_CODE(C_CODE: DATA_DICT?["c_code"] as Any)
                    APPEND_VALUE.SET_C_NAME(C_NAME: DATA_DICT?["c_name"] as Any)
                    APPEND_VALUE.SET_DISPLAY(DISPLAY: DATA_DICT?["display"] as Any)
                    APPEND_VALUE.SET_GEN_CHECK(GEN_CHECK: DATA_DICT?["gen_check"] as Any)
                    APPEND_VALUE.SET_GEN_NOW(GEN_NOW: DATA_DICT?["gen_now"] as Any)
                    APPEND_VALUE.SET_GEN_POWER(GEN_POWER: DATA_DICT?["gen_power"] as Any)
                    APPEND_VALUE.SET_IDX(IDX: DATA_DICT?["idx"] as Any)
                    APPEND_VALUE.SET_IMG_SET(IMG_SET: DATA_DICT?["img_set"] as Any)
                    APPEND_VALUE.SET_INPUT_ID(INPUT_ID: DATA_DICT?["input_id"] as Any)
                    APPEND_VALUE.SET_INV_CAPACITY(INV_CAPACITY: DATA_DICT?["inv_capacity"] as Any)
                    APPEND_VALUE.SET_INV_NUM(INV_NUM: DATA_DICT?["inv_num"] as Any)
                    APPEND_VALUE.SET_INV_TYPE(INV_TYPE: DATA_DICT?["inv_type"] as Any)
                    APPEND_VALUE.SET_IP(IP: DATA_DICT?["ip"] as Any)
                    APPEND_VALUE.SET_LAST_UPDATE(LAST_UPDATE: DATA_DICT?["last_update"] as Any)
                    APPEND_VALUE.SET_MAC(MAC: DATA_DICT?["mac"] as Any)
                    APPEND_VALUE.SET_MB_ID(MB_ID: DATA_DICT?["mb_id"] as Any)
                    APPEND_VALUE.SET_OUT_CHECK(OUT_CHECK: DATA_DICT?["out_check"] as Any)
                    APPEND_VALUE.SET_OWNER(OWNER: DATA_DICT?["owner"] as Any)
                    APPEND_VALUE.SET_P_ADDRESS(P_ADDRESS: DATA_DICT?["plant_address"] as Any)
                    APPEND_VALUE.SET_P_CODE(P_CODE: DATA_DICT?["plant_code"] as Any)
                    APPEND_VALUE.SET_P_NAME(P_NAME: DATA_DICT?["plant_name"] as Any)
                    APPEND_VALUE.SET_P_ORDER(P_ORDER: DATA_DICT?["plant_order"] as Any)
                    APPEND_VALUE.SET_PROT_CHECK(PROT_CHECK: DATA_DICT?["prot_check"] as Any)
                    APPEND_VALUE.SET_PV_A(PV_A: DATA_DICT?["pv_a"] as Any)
                    APPEND_VALUE.SET_PV_V(PV_V: DATA_DICT?["pv_v"] as Any)
                    APPEND_VALUE.SET_R_A(R_A: DATA_DICT?["r_a"] as Any)
                    APPEND_VALUE.SET_RS_V(RS_V: DATA_DICT?["rs_v"] as Any)
                    APPEND_VALUE.SET_S_A(S_A: DATA_DICT?["s_a"] as Any)
                    APPEND_VALUE.SET_SET_VOLT(SET_VOLT: DATA_DICT?["set_volt"] as Any)
                    APPEND_VALUE.SET_ST_V(ST_V: DATA_DICT?["st_v"] as Any)
                    APPEND_VALUE.SET_T_A(T_A: DATA_DICT?["t_a"] as Any)
                    APPEND_VALUE.SET_THREE_GEN(THREE_GEN: DATA_DICT?["three_gen"] as Any)
                    APPEND_VALUE.SET_TOTAL_GEN(TOTAL_GEN: DATA_DICT?["total_gen"] as Any)
                    APPEND_VALUE.SET_TR_V(TR_V: DATA_DICT?["tr_v"] as Any)
                    APPEND_VALUE.SET_YESTER_GEN(YESTER_GEN: DATA_DICT?["yester_gen"] as Any)
/// 데이터 추가
                    self.OBJ_INVERTER.append(APPEND_VALUE)
                }
                UIViewController.IC_ALERT.dismiss(animated: true, completion: nil)
                self.SET_UP(); self.TABLE_VIEW.reloadData()
            case .failure(let ERROR):
/// TIMEOUT
                if ERROR._code == NSURLErrorTimedOut { self.VIEW_NOTICE("E: 서버 연결 실패 (408)") }
                if ERROR._code == NSURLErrorNetworkConnectionLost { self.VIEW_NOTICE("E: 네트워크 연결 실패 (000)"); self.NETWORK_CHECK() }
                
                self.ALAMOFIRE_ERROR(ERROR: response.result.error as? AFError)
            }
        }
    }
    
    func SET_UP() {
        
        if OBJ_INVERTER.count != 0 {
            
            let DATA = OBJ_INVERTER[I_POSITION]
            
            let ERROR = "\(DATA.OUT_CHECK)\(DATA.GEN_CHECK)\(DATA.PROT_CHECK)"
            if ERROR == "000" {
                self.ERROR.isHidden = true
                ROUND_VIEW.ON_OFF = true
                ROUND_VIEW.ERROR = false
            } else {
                self.ERROR.isHidden = false
                if DATA.PROT_CHECK != "0" { self.ERROR.text = "E: 프로텍션" }
                if DATA.GEN_CHECK != "0" { self.ERROR.text = "E: 발전" }
                if DATA.OUT_CHECK != "0" { self.ERROR.text = "E: 미개통" }
                ROUND_VIEW.ON_OFF = true
                ROUND_VIEW.ERROR = true
            }
/// 인버터 현재 발전량
            let MAX = Double(DATA.INV_CAPACITY) ?? 0.0
            let NOW = Double(DATA.GEN_NOW) ?? 0.0
            
            if NOW == 0.0 {
                ROUND_VIEW.RANGE = 100
                ROUND_VIEW.CURRENT_VALUE = 0
                N_POWER.text = "-"
                UNIT.text = ""
                PERCENT.text = "-"
            } else {
                print((MAX/10), (NOW/10))
                ROUND_VIEW.RANGE = CGFloat(MAX/10)
                ROUND_VIEW.CURRENT_VALUE = CGFloat(NOW/10)
                N_POWER.text = "\(NOW/10)"
                PERCENT.text = "\(floor(NOW/MAX*100))%".replacingOccurrences(of: ".0", with: "")
            }
/// 단위
            if N_POWER.text == "-" {
                UNIT.text = ""
            } else if NOW >= 0 || NOW < 1000 {
                UNIT.text = "kW"
            } else if NOW >= 1000 || NOW < 1000000 {
                UNIT.text = "MW"
            } else if NOW >= 1000000 || NOW < 1000000000 {
                UNIT.text = "GW"
            }
            
/// 인버터명
            SELECT_INV.text = "인버터 #\(DATA.INV_NUM)"
/// 암페어
            if DATA.PV_A == "" || DATA.PV_A == "0" { INV_CNT.text = "-" } else { INV_CNT.text = "\(DATA.PV_A) A" }
/// 전압
            if DATA.TR_V == "" || DATA.TR_V == "0" { INV_VOLTAGE.text = "-" } else { INV_VOLTAGE.text = "\(DATA.TR_V) V" }
/// 설비용량
            let INV_CAP = Double(DATA.INV_CAPACITY) ?? 0.0
            if INV_CAP == 0.0 { INV_VOLUME.text = "-" } else { INV_VOLUME.text = UNIT_DATA(UNIT: INV_CAP/10) }
            
//            var T_TOTAL: Double = 0.0
//            for DATA in OBJ_INVERTER { T_TOTAL += Double(DATA.TOTAL_GEN) ?? 0.0 }
//            var Y_TOTAL: Double = 0.0
//            for DATA in OBJ_INVERTER { Y_TOTAL += Double(DATA.YESTER_GEN) ?? 0.0 }
//            var Y2_TOTAL: Double = 0.0
//            for DATA in OBJ_INVERTER { Y2_TOTAL += Double(DATA.THREE_GEN) ?? 0.0 }
            let T_TOTAL = Double(DATA.TOTAL_GEN) ?? 0.0
            let Y_TOTAL = Double(DATA.YESTER_GEN) ?? 0.0
            let Y2_TOTAL = Double(DATA.THREE_GEN) ?? 0.0
/// 금일 발전량
            let TODAY = T_TOTAL - Y_TOTAL
            if TODAY == 0.0 { self.T_TOTAL.text = "-" } else { self.T_TOTAL.text = UNIT_DATA(UNIT: TODAY) }
/// 전일 발전량
            let YESTERDAY = Y_TOTAL - Y2_TOTAL
            if YESTERDAY == 0.0 { self.Y_TOTAL.text = "-" } else { self.Y_TOTAL.text = UNIT_DATA(UNIT: YESTERDAY) }
/// 누적 발전량
            if T_TOTAL == 0.0 { self.G_TOTAL.text = "-" } else { self.G_TOTAL.text = UNIT_DATA(UNIT: T_TOTAL) }
/// CO2 저감량
            self.CO2.text = "-"
        } else {
/// 데이터 없음
            ROUND_VIEW.ON_OFF = false
            ROUND_VIEW.RANGE = 100
            ROUND_VIEW.CURRENT_VALUE = 0
            N_POWER.text = "-"
            UNIT.text = ""
            PERCENT.text = "-"
            SELECT_INV.text = "-"
            INV_CNT.text = "-"; INV_VOLTAGE.text = "-"; INV_VOLUME.text = "-"
            T_TOTAL.text = "-"; Y_TOTAL.text = "-"; G_TOTAL.text = "-"; CO2.text = "-"
        }
    }
}

extension INVERTER: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if OBJ_INVERTER.count == 0 { return 0 } else { return OBJ_INVERTER.count }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "인버터 #\(OBJ_INVERTER[row].INV_NUM)"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        I_POSITION = row; SET_UP()
        SELECT_INV.text = "인버터 #\(OBJ_INVERTER[row].INV_NUM)"
    }
}

extension INVERTER: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if OBJ_INVERTER.count == 0 { return 0 } else { return OBJ_INVERTER.count }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let DATA = OBJ_INVERTER[indexPath.item]
        let CELL = tableView.dequeueReusableCell(withIdentifier: "INVERTER_TC", for: indexPath) as! INVERTER_TC
        
        let T_TOTAL = Double(DATA.TOTAL_GEN) ?? 0.0
        let Y_TOTAL = Double(DATA.YESTER_GEN) ?? 0.0
        
/// 에러 확인
        let ERROR = "\(DATA.OUT_CHECK)\(DATA.GEN_CHECK)\(DATA.PROT_CHECK)"
        if ERROR == "000" {
            CELL.INV_ON_OFF.image = UIImage(named: "on.png")
        } else {
            CELL.INV_ON_OFF.image = UIImage(named: "error.png")
        }
/// 인버터 번호
        CELL.INV_NUM.text = "#\(DATA.INV_NUM)"
/// 누적 발전량
        if T_TOTAL == 0.0 { CELL.G_TOTAL.text = "-" } else { CELL.G_TOTAL.text = UNIT_DATA(UNIT: T_TOTAL) }
/// 금일 발전량
        let TODAY = T_TOTAL - Y_TOTAL
        if TODAY == 0.0 { CELL.T_TOTAL.text = "-" } else { CELL.T_TOTAL.text = UNIT_DATA(UNIT: TODAY) }
/// 현재 발전량
        let NOW = Double(DATA.GEN_NOW) ?? 0.0
        if NOW == 0.0 { CELL.N_POWER.text = "-" } else { CELL.N_POWER.text = UNIT_DATA(UNIT: NOW/10) }
        
        return CELL
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        SELECT_INV.resignFirstResponder()
    }
}
