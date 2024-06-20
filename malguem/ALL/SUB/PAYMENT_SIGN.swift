//
//  PAYMENT_SIGN.swift
//  malguem
//
//  Created by 부산광역시교육청 on 2021/05/11.
//

import UIKit
import EPSignature

class PAYMENT_SIGN: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func BACK_VC(_ sender: UIButton) { dismiss(animated: true, completion: nil) }
    
    var TYPE: String = ""
    
    @IBOutlet weak var BG_VIEW: UIView!
    @IBOutlet weak var CLEAR: UIButton!
    @IBOutlet weak var DONE: UIButton!
    @IBOutlet weak var SIGN_VIEW: EPSignatureView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        RADIUS(BG_VIEW, CORNER: 10.0, CLIP: true)
        RADIUS(SIGN_VIEW, CORNER: 5.0, CLIP: true)
        SIGN_VIEW.backgroundColor = .GRAY_F1F1F1
        
        CLEAR.addTarget(self, action: #selector(CLEAR(_:)), for: .touchUpInside)
        DONE.addTarget(self, action: #selector(DONE(_:)), for: .touchUpInside)
    }
    
    @objc func CLEAR(_ sender: UIButton) {
        SIGN_VIEW.clear()
    }
    
    @objc func DONE(_ sender: UIButton) {
        
        if let SIGN = SIGN_VIEW.getSignatureAsImage() {
            
            let BVC = UIViewController.APPDELEGATE.PAYMENT_ADD_VC
            BVC?.IMG_DATA = SIGN.pngData() ?? Data()
            if TYPE == "bank" {
                BVC?.B_SIGN.setBackgroundImage(SIGN, for: .normal)
            } else {
                BVC?.C_SIGN.setBackgroundImage(SIGN, for: .normal)
            }
            dismiss(animated: true, completion: nil)
        } else {
            
            VIEW_NOTICE("N: 서명을 하지 않았습니다")
        }
    }
}
