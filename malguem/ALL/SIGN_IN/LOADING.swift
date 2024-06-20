//
//  LOADING.swift
//  malguem
//
//  Created by 장 제현 on 2021/04/20.
//

import UIKit
import Alamofire


class LOADING: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var PUSH: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
/// 네트워크 연결 확인 (로그인)
        NETWORK_CHECK(PUSH: PUSH)
    }
    
//MARK: 네트워크 연결 확인 및 데이터 불러오기 (로그인)
    @objc func NETWORK_CHECK(PUSH: Bool) {
        
        if NW_CHECK() {
/// 로그인 확인
            if UserDefaults.standard.string(forKey: "mb_id") ?? "" == "" {
                CONTROLLER_VC(IDENTIFIER: "SIGN_IN", MT_STYLE: .crossDissolve, ANIMATED: true)
            } else {
                GET_LOGIN_DATA(NAME: "로그인", MB_ID: UserDefaults.standard.string(forKey: "mb_id") ?? "", UPDATE: false)
            }
        } else {
            VIEW_NOTICE("N: 네트워크 상태를 확인해 주세요")
            DispatchQueue.main.async {
                let ALERT = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
                ALERT.addAction(UIAlertAction(title: "새로고침", style: .default) { (_) in self.NETWORK_CHECK(PUSH: PUSH) })
                self.present(ALERT, animated: true, completion: nil)
            }
        }
    }
}
