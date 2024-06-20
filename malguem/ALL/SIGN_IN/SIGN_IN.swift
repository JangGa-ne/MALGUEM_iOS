//
//  SIGN_IN.swift
//  malguem
//
//  Created by 장 제현 on 2021/04/20.
//

import UIKit

class SIGN_IN: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 13.0, *) { return .darkContent } else { return .default }
    }
    
    @IBOutlet weak var MB_ID: UITextField!
    @IBOutlet weak var CALL: UIButton!
    @IBOutlet weak var LOGIN: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
/// 키보드 설정
        NotificationCenter.default.addObserver(self, selector: #selector(KEYBOARD_SHOW(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(KEYBOARD_HIDE(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
/// 아이디
        PLACEHOLDER(TF: MB_ID, PH: "아이디를 입력하세요")
        TOOL_BAR_DONE(TF: MB_ID, TV: UITextView(), SB: UISearchBar())
/// 문의 전화
        CALL.addTarget(self, action: #selector(CALL(_:)), for: .touchUpInside)
/// 로그인
        LOGIN.addTarget(self, action: #selector(LOGIN(_:)), for: .touchUpInside)
    }
    
    @objc func CALL(_ sender: UIButton) {
        UIApplication.shared.open(URL(string: "tel://" + "1522-1009")!)
    }
    
    @objc func LOGIN(_ sender: UIButton) {
        
        if MB_ID.text == "" {
            VIEW_NOTICE("N: 미입력한 항목이 있습니다")
        } else {
/// 네트워크 연결 확인 (로그인)
            NETWORK_CHECK()
        }
    }
    
//MARK: 네트워크 연결 확인 및 데이터 불러오기 (로그인)
    @objc func NETWORK_CHECK() {
        
        if NW_CHECK() {
            GET_LOGIN_DATA(NAME: "로그인", MB_ID: MB_ID.text!, UPDATE: false)
        } else {
            VIEW_NOTICE("N: 네트워크 상태를 확인해 주세요")
            DispatchQueue.main.async {
                let ALERT = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
                ALERT.addAction(UIAlertAction(title: "새로고침", style: .default) { (_) in self.NETWORK_CHECK() })
                self.present(ALERT, animated: true, completion: nil)
            }
        }
    }
}
