//
//  AS_RECEIPT_SV.swift
//  malguem
//
//  Created by 부산광역시교육청 on 2021/05/06.
//

import UIKit
import Alamofire

class AS_RECEIPT_SV: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func BACK_VC(_ sender: UIButton) { dismiss(animated: true, completion: nil) }
    
    var P_POSITION: Int = 0
    var S_POSITION: Int = 0
    let SERVICE: [String] = ["고장 접수", "서비스 문의", "원격 관리", "모니터링 장비 문의", "유지 보수 접수"]
    
    var PICKER_PLANT = UIPickerView()
    var PICKER_SERVICE = UIPickerView()
    
    @IBOutlet weak var AS_BG: UIView!
    @IBOutlet weak var P_NAME: UITextField!
    @IBOutlet weak var AS_NAME: UITextField!
    @IBOutlet weak var SUBMIT: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
/// 키보드 설정
        NotificationCenter.default.addObserver(self, selector: #selector(KEYBOARD_SHOW(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(KEYBOARD_HIDE(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        RADIUS(AS_BG, CORNER: 10.0, CLIP: true)
/// 발전소명
        RADIUS(P_NAME, CORNER: 5.0, CLIP: true)
        P_NAME.PADDING_LEFT(X: 10.0)
        PLACEHOLDER(TF: P_NAME, PH: "발전소명")
        TOOL_BAR_DONE(TF: P_NAME, TV: UITextView(), SB: UISearchBar())
        PICKER_PLANT.delegate = self
        PICKER_PLANT.dataSource = self
        P_NAME.inputView = PICKER_PLANT
/// 서비스 유형
        RADIUS(AS_NAME, CORNER: 5.0, CLIP: true)
        AS_NAME.PADDING_LEFT(X: 10.0)
        PLACEHOLDER(TF: AS_NAME, PH: "서비스명")
        TOOL_BAR_DONE(TF: AS_NAME, TV: UITextView(), SB: UISearchBar())
        PICKER_SERVICE.delegate = self
        PICKER_SERVICE.dataSource = self
        AS_NAME.inputView = PICKER_SERVICE
/// 신청
        SUBMIT.addTarget(self, action: #selector(SUBMIT(_:)), for: .touchUpInside)
    }
    
    @objc func SUBMIT(_ sender: UIButton) {
        
        if P_NAME.text == "" || AS_NAME.text == "" {
            VIEW_NOTICE("N: 미입력한 항목이 있습니다")
        } else {
            PUT_POST_DATA(NAME: "AS신청")
        }
    }
    
    func PUT_POST_DATA(NAME: String) {
        
        let PARAMETERS: Parameters = [
            "mb_id": UserDefaults.standard.string(forKey: "mb_id") ?? "",
            "plant_code": UIViewController.APPDELEGATE.OBJ_PLANT[P_POSITION].P_CODE,
            "reg_content": SERVICE[S_POSITION]
        ]
        
        let MANAGER = Alamofire.SessionManager.default
        MANAGER.session.configuration.timeoutIntervalForRequest = 10.0
        MANAGER.upload(multipartFormData: { multipartFormData in
            
            print("\n[\(NAME)]")
            for (KEY, VALUE) in PARAMETERS {
                print("KEY: \(KEY)", "VALUE: \(VALUE)")
                multipartFormData.append("\(VALUE)".data(using: .utf8)!, withName: KEY as String)
            }
        }, to: POST_URL().BASE + "light/as_insert.php") { (result) in
            
            switch result {
            case .success(let upload, _, _):
                
                upload.responseJSON { response in
                    
//                    print(response)
                    
                    guard let DATA_DICT = response.result.value as? [String: Any] else {
                        print("FAILURE: \(response.result.error.debugDescription)")
                        return
                    }
                    
                    if DATA_DICT["result"] as? String ?? "" == "success" {
                        self.VIEW_NOTICE("\(self.SERVICE[self.S_POSITION]) 접수 (성공)")
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                            self.dismiss(animated: true, completion: {
                                UIViewController.APPDELEGATE.AS_RECEIPT_VC?.NETWORK_CHECK()
                            })
                        }
                    } else {
                        self.VIEW_NOTICE("\(self.SERVICE[self.S_POSITION]) 접수 (실패)")
                    }
                }
            case .failure(let encodingError):
        
                print(encodingError)
                break
            }
        }
    }
}

extension AS_RECEIPT_SV: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView == PICKER_PLANT {
            if UIViewController.APPDELEGATE.OBJ_PLANT.count == 0 {
                return 0
            } else {
                return UIViewController.APPDELEGATE.OBJ_PLANT.count
            }
        } else if pickerView == PICKER_SERVICE {
            if SERVICE.count == 0 { return 0 } else { return SERVICE.count }
        } else {
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView == PICKER_PLANT {
            return UIViewController.APPDELEGATE.OBJ_PLANT[row].P_NAME
        } else if pickerView == PICKER_SERVICE {
            return SERVICE[row]
        } else {
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView == PICKER_PLANT {
            P_POSITION = row
            P_NAME.text = UIViewController.APPDELEGATE.OBJ_PLANT[row].P_NAME
        } else if pickerView == PICKER_SERVICE {
            S_POSITION = row
            AS_NAME.text = SERVICE[row]
        }
    }
}
