//
//  AS_RECEIPT.swift
//  malguem
//
//  Created by 부산광역시교육청 on 2021/04/30.
//

import UIKit
import Alamofire

class AS_RECEIPT_TC: UITableViewCell {
    
    @IBOutlet weak var DATETIME: UILabel!
    
    @IBOutlet weak var AS_BG: UIView!
    @IBOutlet weak var P_NAME: UILabel!
    @IBOutlet weak var AS_NAME: UILabel!
    @IBOutlet weak var AS_LEVEL: UILabel!
}

class AS_RECEIPT: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var OBJ_AS: [AS_DATA] = []
    
    @IBOutlet weak var NAVI_TITLE: UILabel!
    @IBOutlet weak var KAKAO_TALK: UIButton!
    @IBOutlet weak var TABLE_VIEW: UITableView!
    @IBOutlet weak var SERVICE_VC: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIViewController.APPDELEGATE.AS_RECEIPT_VC = self
        
        NAVI_TITLE.alpha = 0.0
        SETTING_KAKAO(KAKAO_TALK)
        
/// 테이블뷰
        TABLE_VIEW.delegate = self
        TABLE_VIEW.dataSource = self
        TABLE_VIEW.separatorStyle = .none
/// AS 접수
        SERVICE_VC.addTarget(self, action: #selector(SERVICE_VC(_:)), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        BACK_GESTURE(false)
    }
    
//MARK: 네트워크 연결 확인 및 데이터 불러오기 (AS현황)
    @objc func NETWORK_CHECK() {
        
        if NW_CHECK() {
//            present(UIViewController.IC_ALERT, animated: true, completion: nil)
            GET_POST_DATA(NAME: "AS현황")
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
            "mb_id": UserDefaults.standard.string(forKey: "mb_id") ?? ""
        ]
        
        let MANAGER = Alamofire.SessionManager.default
        MANAGER.session.configuration.timeoutIntervalForRequest = 10.0
        MANAGER.request(POST_URL().BASE + "light/as_list.php", method: .post, parameters: PARAMETERS).responseJSON { response in
            
            print("\n[\(NAME)]")
            for (KEY, VALUE) in PARAMETERS { print("KEY: \(KEY)", "VALUE: \(VALUE)") }
//            print(response)
            
            switch response.result {
            case .success(_):
/// 데이터 삭제
                self.OBJ_AS.removeAll()
                
                guard let DATA_ARRAY = response.result.value as? Array<Any> else {
                    print("FAILURE: \(response.result.error.debugDescription)")
                    UIViewController.IC_ALERT.dismiss(animated: true, completion: nil)
                    self.TABLE_VIEW.reloadData()
                    return
                }
                
                for (_, DATA) in DATA_ARRAY.enumerated() {
                    
                    let DATA_DICT = DATA as? [String: Any]
                    let APPEND_VALUE = AS_DATA()
                    
                    APPEND_VALUE.SET_AS_CALL(AS_CALL: DATA_DICT?["as_call"] as Any)
                    APPEND_VALUE.SET_AS_NAME(AS_NAME: DATA_DICT?["as_name"] as Any)
                    APPEND_VALUE.SET_C_CODE(C_CODE: DATA_DICT?["c_code"] as Any)
                    APPEND_VALUE.SET_C_NAME(C_NAME: DATA_DICT?["c_name"] as Any)
                    APPEND_VALUE.SET_DATETIME(DATETIME: DATA_DICT?["datetime"] as Any)
                    APPEND_VALUE.SET_DISPLAY(DISPLAY: DATA_DICT?["display"] as Any)
                    APPEND_VALUE.SET_EX_CONTENT(EX_CONTENT: DATA_DICT?["ex_content"] as Any)
                    APPEND_VALUE.SET_EX_DATE(EX_DATE: DATA_DICT?["ex_date"] as Any)
                    APPEND_VALUE.SET_FIN_CONTENT(FIN_CONTENT: DATA_DICT?["fin_content"] as Any)
                    APPEND_VALUE.SET_FIN_DATE(FIN_DATE: DATA_DICT?["fin_date"] as Any)
                    APPEND_VALUE.SET_IDX(IDX: DATA_DICT?["idx"] as Any)
                    APPEND_VALUE.SET_MB_ID(MB_ID: DATA_DICT?["mb_id"] as Any)
                    APPEND_VALUE.SET_P_CODE(P_CODE: DATA_DICT?["plant_code"] as Any)
                    APPEND_VALUE.SET_P_NAME(P_NAME: DATA_DICT?["plant_name"] as Any)
                    APPEND_VALUE.SET_REG_CONTENT(REG_CONTENT: DATA_DICT?["reg_content"] as Any)
                    APPEND_VALUE.SET_REG_DATE(REG_DATE: DATA_DICT?["reg_date"] as Any)
                    APPEND_VALUE.SET_REG_STEP(REG_STEP: DATA_DICT?["reg_step"] as Any)
                    APPEND_VALUE.SET_SET_CONTENT(SET_CONTENT: DATA_DICT?["set_content"] as Any)
                    APPEND_VALUE.SET_SET_DATE(SET_DATE: DATA_DICT?["set_date"] as Any)
/// 데이터 추가
                    self.OBJ_AS.append(APPEND_VALUE)
                }
                UIViewController.IC_ALERT.dismiss(animated: true, completion: nil)
                self.OBJ_AS.reverse()
                self.TABLE_VIEW.reloadData()
            case .failure(let ERROR):
/// TIMEOUT
                if ERROR._code == NSURLErrorTimedOut { self.VIEW_NOTICE("E: 서버 연결 실패 (408)") }
                if ERROR._code == NSURLErrorNetworkConnectionLost { self.VIEW_NOTICE("E: 네트워크 연결 실패 (000)"); self.NETWORK_CHECK() }
                
                self.ALAMOFIRE_ERROR(ERROR: response.result.error as? AFError)
            }
        }
    }
    
    let TRANSITION = SETTING_SUB_VC()
    @objc func SERVICE_VC(_ sender: UIButton) {
        
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "AS_RECEIPT_SV") as! AS_RECEIPT_SV
        VC.modalPresentationStyle = .overCurrentContext
        VC.transitioningDelegate = self
        present(VC, animated: true, completion: nil)
    }
}

extension AS_RECEIPT: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let OFFSET_Y = scrollView.contentOffset.y
        if OFFSET_Y >= 0 { NAVI_TITLE.alpha = OFFSET_Y/20 } else { NAVI_TITLE.alpha = 0.0 }
    }
}

extension AS_RECEIPT: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if OBJ_AS.count == 0 { return 0 } else { return OBJ_AS.count }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let DATA = OBJ_AS[indexPath.item]
        let CELL = tableView.dequeueReusableCell(withIdentifier: "AS_RECEIPT_TC", for: indexPath) as! AS_RECEIPT_TC
        
        if DATA.DATETIME == "" || DATA.DATETIME == "0000-00-00 00:00:00" {
            
            CELL.DATETIME.text = "날짜 데이터 없음"
        } else {
            
            let DF = DateFormatter()
            DF.locale = Locale(identifier: "ko_kr")
            DF.dateFormat = "yyyy-MM-dd HH:mm:ss"
            
            let DATETIME = DF.date(from: DATA.DATETIME)
            DF.dateFormat = "yyyy.MM.dd E요일 HH:mm"
            
            CELL.DATETIME.text = DF.string(from: DATETIME ?? Date())
        }
        
        RADIUS(CELL.AS_BG, CORNER: 10.0, CLIP: true)
        
        if DATA.P_NAME == "" { CELL.P_NAME.text = "-" } else { CELL.P_NAME.text = DATA.P_NAME }
        if DATA.REG_CONTENT == "" { CELL.AS_NAME.text = "-" } else { CELL.AS_NAME.text = DATA.REG_CONTENT }
        
        if DATA.REG_STEP == "0" {
            CELL.AS_LEVEL.text = "접수대기"
        } else if DATA.REG_STEP == "1" {
            CELL.AS_LEVEL.text = "접수완료"
        } else if DATA.REG_STEP == "2" {
            CELL.AS_LEVEL.text = "배정완료"
        } else if DATA.REG_STEP == "3" {
            CELL.AS_LEVEL.text = "진행중"
        } else if DATA.REG_STEP == "4" {
            CELL.AS_LEVEL.text = "처리완료"
        } else {
            CELL.AS_LEVEL.text = "-"
        }
        
        return CELL
    }
}
