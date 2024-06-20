//
//  NOTICE.swift
//  malguem
//
//  Created by 부산광역시교육청 on 2021/04/30.
//

import UIKit
import Alamofire
import FirebaseMessaging

class NOTICE_TC: UITableViewCell {
    
    @IBOutlet weak var DATETIME: UILabel!
    @IBOutlet weak var RD_CHECK: UILabel!
    
    @IBOutlet weak var NOTICE_BG: UIView!
    @IBOutlet weak var TITLE: UILabel!
    @IBOutlet weak var CONTENT: UILabel!
}

class NOTICE: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var OBJ_NOTICE: [NOTICE_DATA] = []
    
    @IBOutlet weak var NAVI_TITLE: UILabel!
    @IBOutlet weak var KAKAO_TALK: UIButton!
    @IBOutlet weak var TABLE_VIEW: UITableView!
    @IBOutlet weak var SWITCH: UISwitch!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIViewController.APPDELEGATE.NOTICE_VC = self
        
        NAVI_TITLE.alpha = 0.0
        SETTING_KAKAO(KAKAO_TALK)
        
/// 테이블뷰
        TABLE_VIEW.delegate = self
        TABLE_VIEW.dataSource = self
        TABLE_VIEW.separatorStyle = .none
/// 알림 설정
        SWITCH.isOn = UserDefaults.standard.bool(forKey: "push")
        SWITCH.addTarget(self, action: #selector(SWITCH(_:)), for: .valueChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        BACK_GESTURE(false)
    }
    
    //MARK: 네트워크 연결 확인 및 데이터 불러오기 (알림)
    @objc func NETWORK_CHECK(UPDATE: Bool) {
        
        if NW_CHECK() {
//            if !UPDATE { present(UIViewController.IC_ALERT, animated: true, completion: nil) }
            GET_POST_DATA(NAME: "알림", UPDATE: UPDATE)
        } else {
            VIEW_NOTICE("F: 네트워크 상태를 확인해 주세요")
            DispatchQueue.main.async {
                let ALERT = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
                ALERT.addAction(UIAlertAction(title: "새로고침", style: .default) { (_) in self.NETWORK_CHECK(UPDATE: UPDATE) })
                self.present(ALERT, animated: true, completion: nil)
            }
        }
    }
    
    func GET_POST_DATA(NAME: String, UPDATE: Bool) {
        
        let PARAMETERS: Parameters = [
            "mb_id": UserDefaults.standard.string(forKey: "mb_id") ?? ""
        ]
        
        let MANAGER = Alamofire.SessionManager.default
        MANAGER.session.configuration.timeoutIntervalForRequest = 10.0
        MANAGER.request(POST_URL().BASE + "light/message_list.php", method: .post, parameters: PARAMETERS).responseJSON { response in
            
            print("\n[\(NAME)]")
            for (KEY, VALUE) in PARAMETERS { print("KEY: \(KEY)", "VALUE: \(VALUE)") }
//            print(response)
            
            switch response.result {
            case .success(_):
/// 데이터 삭제
                self.OBJ_NOTICE.removeAll()
                
                guard let DATA_ARRAY = response.result.value as? Array<Any> else {
                    print("FAILURE: \(response.result.error.debugDescription)")
                    UIViewController.IC_ALERT.dismiss(animated: true, completion: nil)
                    self.TABLE_VIEW.reloadData()
                    return
                }
                
                for (_, DATA) in DATA_ARRAY.enumerated() {
                    
                    let DATA_DICT = DATA as? [String: Any]
                    let APPEND_VALUE = NOTICE_DATA()
                    
                    APPEND_VALUE.SET_C_CODE(C_CODE: DATA_DICT?["c_code"] as Any)
                    APPEND_VALUE.SET_C_NAME(C_NAME: DATA_DICT?["c_name"] as Any)
                    APPEND_VALUE.SET_DST(DST: DATA_DICT?["dst"] as Any)
                    APPEND_VALUE.SET_DST_NAME(DST_NAME: DATA_DICT?["dst_name"] as Any)
                    APPEND_VALUE.SET_DST_PLANT(DST_PLANT: DATA_DICT?["dst_plant"] as Any)
                    APPEND_VALUE.SET_FRM(FRM: DATA_DICT?["frm"] as Any)
                    APPEND_VALUE.SET_GCM_KEY(GCM_KEY: DATA_DICT?["gcm_key"] as Any)
                    APPEND_VALUE.SET_HTML_CONTENT(HTML_CONTENT: DATA_DICT?["html_content"] as Any)
                    APPEND_VALUE.SET_K_NAME(K_NAME: DATA_DICT?["k_button_name"] as Any)
                    APPEND_VALUE.SET_K_TYPE(K_TYPE: DATA_DICT?["k_button_type"] as Any)
                    APPEND_VALUE.SET_K_URL(K_URL: DATA_DICT?["k_button_url"] as Any)
                    APPEND_VALUE.SET_K_URL2(K_URL2: DATA_DICT?["k_button_url2"] as Any)
                    APPEND_VALUE.SET_K_NEXT(K_NEXT: DATA_DICT?["k_next_type"] as Any)
                    APPEND_VALUE.SET_LOGO(LOGO: DATA_DICT?["logo"] as Any)
                    APPEND_VALUE.SET_M_GROUP(M_GROUP: DATA_DICT?["m_group"] as Any)
                    APPEND_VALUE.SET_ME_LENGTH(ME_LENGTH: DATA_DICT?["me_length"] as Any)
                    APPEND_VALUE.SET_ME_SORT(ME_SORT: DATA_DICT?["me_sort"] as Any)
                    APPEND_VALUE.SET_MES_ID(MES_ID: DATA_DICT?["mes_id"] as Any)
                    APPEND_VALUE.SET_MMS_FILE_1(MMS_FILE_1: DATA_DICT?["mms_file_1"] as Any)
                    APPEND_VALUE.SET_MMS_FILE_2(MMS_FILE_2: DATA_DICT?["mms_file_2"] as Any)
                    APPEND_VALUE.SET_MMS_FILE_3(MMS_FILE_3: DATA_DICT?["mms_file_3"] as Any)
                    APPEND_VALUE.SET_MMS_FILE_4(MMS_FILE_4: DATA_DICT?["mms_file_4"] as Any)
                    APPEND_VALUE.SET_MMS_FILE_CNT(MMS_FILE_CNT: DATA_DICT?["mms_file_cnt"] as Any)
                    APPEND_VALUE.SET_PAR_IMG(PAR_IMG: DATA_DICT?["par_img"] as Any)
                    APPEND_VALUE.SET_P_CODE(P_CODE: DATA_DICT?["plant_code"] as Any)
                    APPEND_VALUE.SET_READ_CHECK(READ_CHECK: DATA_DICT?["read_check"] as Any)
                    APPEND_VALUE.SET_READ_MES(READ_MES: DATA_DICT?["read_mes"] as Any)
                    APPEND_VALUE.SET_RESULT(RESULT: DATA_DICT?["result"] as Any)
                    APPEND_VALUE.SET_SEND_TIME(SEND_TIME: DATA_DICT?["send_time"] as Any)
                    APPEND_VALUE.SET_SEND_TYPE(SEND_TYPE: DATA_DICT?["send_type"] as Any)
                    APPEND_VALUE.SET_SENDER_ID(SENDER_ID: DATA_DICT?["sender_id"] as Any)
                    APPEND_VALUE.SET_SENDER_IP(SENDER_IP: DATA_DICT?["sender_ip"] as Any)
                    APPEND_VALUE.SET_SENDER_KEY(SENDER_KEY: DATA_DICT?["sender_key"] as Any)
                    APPEND_VALUE.SET_SUB(SUB: DATA_DICT?["sub"] as Any)
                    APPEND_VALUE.SET_TEXT(TEXT: DATA_DICT?["text"] as Any)
                    APPEND_VALUE.SET_TEXT2(TEXT2: DATA_DICT?["text2"] as Any)
                    APPEND_VALUE.SET_WR_SCRAP(WR_SCRAP: DATA_DICT?["wr_scrap"] as Any)
                    APPEND_VALUE.SET_WR_SHARE(WR_SHARE: DATA_DICT?["wr_share"] as Any)
                    /// 데이터 추가
                    self.OBJ_NOTICE.append(APPEND_VALUE)
                }
                UIViewController.IC_ALERT.dismiss(animated: true, completion: nil)
                self.TABLE_VIEW.reloadData()
            case .failure(let ERROR):
                
/// TIMEOUT
                if ERROR._code == NSURLErrorTimedOut { self.VIEW_NOTICE("E: 서버 연결 실패 (408)") }
                if ERROR._code == NSURLErrorNetworkConnectionLost { self.VIEW_NOTICE("E: 네트워크 연결 실패 (000)"); self.NETWORK_CHECK(UPDATE: UPDATE) }
                
                self.ALAMOFIRE_ERROR(ERROR: response.result.error as? AFError)
            }
        }
    }
    
    @objc func SWITCH(_ sender: UISwitch) {
        
        SWITCH.isOn = sender.isOn
        UserDefaults.standard.setValue(sender.isOn, forKey: "push")
        UserDefaults.standard.synchronize()
        
        if sender.isOn {
            Messaging.messaging().subscribe(toTopic: "MAIN")
        } else {
            Messaging.messaging().unsubscribe(fromTopic: "MAIN")
        }
    }
}

extension NOTICE: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let OFFSET_Y = scrollView.contentOffset.y
        if OFFSET_Y >= 0 { NAVI_TITLE.alpha = OFFSET_Y/20 } else { NAVI_TITLE.alpha = 0.0 }
    }
}

extension NOTICE: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if OBJ_NOTICE.count == 0 { return 0 } else { return OBJ_NOTICE.count }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let DATA = OBJ_NOTICE[indexPath.item]
        let CELL = tableView.dequeueReusableCell(withIdentifier: "NOTICE_TC", for: indexPath) as! NOTICE_TC
        
        if DATA.SEND_TIME == "" || DATA.SEND_TIME == "0000-00-00 00:00:00" {
            
            CELL.DATETIME.text = "날짜 데이터 없음"
        } else {
            
            let DF = DateFormatter()
            DF.locale = Locale(identifier: "ko_kr")
            DF.dateFormat = "yyyy-MM-dd HH:mm:ss"
            
            let DATETIME = DF.date(from: DATA.SEND_TIME)
            DF.dateFormat = "yyyy.MM.dd E요일 HH:mm"
            
            CELL.DATETIME.text = DF.string(from: DATETIME ?? Date())
        }
        if DATA.READ_MES != "Y" { CELL.RD_CHECK.text = "읽지않음" } else { CELL.RD_CHECK.text = "읽음" }
        
        RADIUS(CELL.NOTICE_BG, CORNER: 10.0, CLIP: true)
        
        if DATA.SUB == "" { CELL.TITLE.text = "-" } else { CELL.TITLE.text = DATA.SUB }
        if DATA.TEXT == "" { CELL.CONTENT.text = "-" } else { CELL.CONTENT.text = DATA.TEXT }
        
        return CELL
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let DATA = OBJ_NOTICE[indexPath.item]
        if DATA.READ_MES != "Y" { PUT_POST_DATA(NAME: "알림(읽음)", MES_ID: DATA.MES_ID, IDX_PATH: indexPath) }
    }
    
    func PUT_POST_DATA(NAME: String, MES_ID: String, IDX_PATH: IndexPath) {
        
        let PARAMETERS: Parameters = [
            "mb_id": UserDefaults.standard.string(forKey: "mb_id") ?? "",
            "mes_id": MES_ID
        ]
        
        let MANAGER = Alamofire.SessionManager.default
        MANAGER.session.configuration.timeoutIntervalForRequest = 10.0
        MANAGER.upload(multipartFormData: { multipartFormData in
            
            print("\n[\(NAME)]")
            for (KEY, VALUE) in PARAMETERS {
                print("KEY: \(KEY)", "VALUE: \(VALUE)")
                multipartFormData.append("\(VALUE)".data(using: .utf8)!, withName: KEY as String)
            }
        }, to: POST_URL().BASE + "light/message_read.php") { (result) in
            
            switch result {
            case .success(let upload, _, _):
                
                upload.responseJSON { response in
                    
//                    print(response)
/// 새로고침
                    self.NETWORK_CHECK(UPDATE: true)
                }
            case .failure(let encodingError):
        
                print(encodingError)
                break
            }
        }
    }
}
