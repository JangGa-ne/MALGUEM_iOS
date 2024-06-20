//
//  PAYMENT_ADD.swift
//  malguem
//
//  Created by 부산광역시교육청 on 2021/05/07.
//

import UIKit

class PAYMENT_ADD: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 13.0, *) { return .darkContent } else { return .default }
    }
    
    @IBAction func BACK_VC(_ sender: UIButton) { navigationController?.popViewController(animated: true) }
    
    let BANKS: [String] = ["KB국민", "KEB하나", "신한은행", "우리은행", "NH농협", "IBK기업", "KDB산업", "한국씨티", "SC제일", "BNK부산", "DGB대구", "BNK경남", "SH수협", "광주은행", "전북은행", "제주은행", "우체국", "새마을금고", "신협", "카카오뱅크"]
    let CARDS: [String] = ["KB국민카드", "현대카드", "신한카드", "삼성카드", "롯데카드", "우리카드", "하나카드", "BC카드", "NH농협카드", "시티카드", "카카오뱅크"]
    
    var TYPE: String = ""
    var IMG_DATA: Data = Data()
    var B_POSITION: Int = 0
    var C_POSITION: Int = 0
    var PICKER_BANK = UIPickerView()
    var PICKER_CARD = UIPickerView()
    
    @IBOutlet weak var NAVI_TITLE: UILabel!
    @IBOutlet weak var KAKAO_TALK: UIButton!
    @IBOutlet weak var SCROLL_VIEW: UIScrollView!
    
    @IBOutlet weak var S1_BG: UIView!
    @IBOutlet weak var BANK: UIButton!
    
    @IBOutlet weak var S2_BG: UIView!
    @IBOutlet weak var B_MB_NAME: UITextField!
    @IBOutlet weak var B_BIRTH: UITextField!
    @IBOutlet weak var B_NAME: UITextField!
    @IBOutlet weak var B_NUM: UITextField!
    @IBOutlet weak var B_PW: UITextField!
    @IBOutlet weak var B_SIGN: UIButton!
    
    @IBOutlet weak var S3_BG: UIView!
    @IBOutlet weak var CARD: UIButton!
    
    @IBOutlet weak var S4_BG: UIView!
    @IBOutlet weak var C_MB_NAME: UITextField!
    @IBOutlet weak var C_BIRTH: UITextField!
    @IBOutlet weak var C_NAME: UITextField!
    @IBOutlet weak var C_NUM1: UITextField!
    @IBOutlet weak var C_NUM2: UITextField!
    @IBOutlet weak var C_NUM3: UITextField!
    @IBOutlet weak var C_NUM4: UITextField!
    @IBOutlet weak var C_MM: UITextField!
    @IBOutlet weak var C_YY: UITextField!
    @IBOutlet weak var C_CVC: UITextField!
    @IBOutlet weak var C_PW: UITextField!
    @IBOutlet weak var C_SIGN: UIButton!
    
    @IBOutlet weak var ADD: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
/// 키보드 설정
        NotificationCenter.default.addObserver(self, selector: #selector(KEYBOARD_SHOW(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(KEYBOARD_HIDE(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        UIViewController.APPDELEGATE.PAYMENT_ADD_VC = self
        
        NAVI_TITLE.alpha = 0.0
        SETTING_KAKAO(KAKAO_TALK)
        
/// 스크롤뷰
        SCROLL_VIEW.delegate = self
        
        RADIUS(S1_BG, CORNER: 10.0, CLIP: true)
        RADIUS(S2_BG, CORNER: 10.0, CLIP: true)
        RADIUS(S3_BG, CORNER: 10.0, CLIP: true)
        RADIUS(S4_BG, CORNER: 10.0, CLIP: true)
        
        RADIUS(B_SIGN, CORNER: 5.0, CLIP: true)
        RADIUS(C_SIGN, CORNER: 5.0, CLIP: true)
        
        S2_BG.isHidden = true
        S4_BG.isHidden = true
        
        BANK.addTarget(self, action: #selector(BANK(_:)), for: .touchUpInside)
        CARD.addTarget(self, action: #selector(CARD(_:)), for: .touchUpInside)
        
        PLACEHOLDER(TF: B_MB_NAME, PH: "성명")
        PLACEHOLDER(TF: B_BIRTH, PH: "명의자의 생년월일 6자리")
        PLACEHOLDER(TF: B_NUM, PH: "본인명의 계좌번호")
        PLACEHOLDER(TF: B_PW, PH: "계좌 비밀번호 4자리")
        
        PLACEHOLDER(TF: C_MB_NAME, PH: "성명")
        PLACEHOLDER(TF: C_BIRTH, PH: "명의자의 생년월일 6자리")
        PLACEHOLDER(TF: C_MM, PH: "MM")
        PLACEHOLDER(TF: C_YY, PH: "YY")
        PLACEHOLDER(TF: C_CVC, PH: "카드 뒷면 3자리")
        PLACEHOLDER(TF: C_PW, PH: "카드 비밀번호 앞 2자리")
        
        let TF: [UITextField] = [B_MB_NAME, B_BIRTH, B_NAME, B_NUM, B_PW, C_MB_NAME, C_BIRTH, C_NAME, C_NUM1, C_NUM2, C_NUM3, C_NUM4, C_MM, C_YY, C_CVC, C_PW]
        
        for i in 0 ..< TF.count { TOOL_BAR_DONE(TF: TF[i], TV: UITextView(), SB: UISearchBar()) }
       
//MARK: 글자수 제한
/// 은행계좌
        B_BIRTH.tag = 6
        B_PW.tag = 4
/// 신용카드
        C_BIRTH.tag = 6
        C_NUM1.tag = 4
        C_NUM2.tag = 4
        C_NUM3.tag = 4
        C_NUM4.tag = 4
        C_MM.tag = 2
        C_YY.tag = 2
        C_CVC.tag = 3
        C_PW.tag = 2
        
        let TF2: [UITextField] = [B_BIRTH, B_PW, C_BIRTH, C_NUM1, C_NUM2, C_NUM3, C_NUM4, C_MM, C_YY, C_CVC, C_PW]
        for i in 0 ..< TF2.count {
            TF2[i].addTarget(self, action: #selector(MAX_TEXT(_:)), for: .editingChanged)
        }
        
/// 은행명
        PICKER_BANK.delegate = self
        PICKER_BANK.dataSource = self
        B_NAME.inputView = PICKER_BANK
/// 카드사명
        PICKER_CARD.delegate = self
        PICKER_CARD.dataSource = self
        C_NAME.inputView = PICKER_CARD
        
/// 서명
        B_SIGN.addTarget(self, action: #selector(PAYMENT_SIGN_VC(_:)), for: .touchUpInside)
        C_SIGN.addTarget(self, action: #selector(PAYMENT_SIGN_VC(_:)), for: .touchUpInside)
/// 등록
        ADD.addTarget(self, action: #selector(ADD(_:)), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        BACK_GESTURE(true)
    }
    
    @objc func BANK(_ sender: UIButton) {
        
        S2_BG.isHidden = false
        S4_BG.isHidden = true
        TYPE = "bank"
        C_MB_NAME.text = ""
        C_BIRTH.text = ""
        C_NAME.text = "KB국민카드"
        C_NUM1.text = ""
        C_NUM2.text = ""
        C_NUM3.text = ""
        C_NUM4.text = ""
        C_MM.text = ""
        C_YY.text = ""
        C_CVC.text = ""
        C_PW.text = ""
        IMG_DATA.removeAll()
        C_SIGN.setBackgroundImage(.none, for: .normal)
    }
    
    @objc func CARD(_ sender: UIButton) {
        
        S2_BG.isHidden = true
        S4_BG.isHidden = false
        TYPE = "card"
        B_MB_NAME.text = ""
        B_BIRTH.text = ""
        B_NAME.text = "KB국민"
        B_NUM.text = ""
        B_PW.text = ""
        IMG_DATA.removeAll()
        B_SIGN.setBackgroundImage(.none, for: .normal)
    }
    
    let TRANSITION = SETTING_SUB_VC()
    @objc func PAYMENT_SIGN_VC(_ sender: UIButton) {
        
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "PAYMENT_SIGN") as! PAYMENT_SIGN
        VC.modalPresentationStyle = .overCurrentContext
        VC.transitioningDelegate = self
        VC.TYPE = TYPE
        present(VC, animated: true, completion: nil)
    }
    
    @objc func ADD(_ sender: UIButton) {
        
        print("\(B_MB_NAME.text!)\(C_MB_NAME.text!)")
        
        let TF1: [UITextField] = [B_MB_NAME, B_BIRTH, B_NAME, B_NUM, B_PW]
        let TF2: [UITextField] = [C_MB_NAME, C_BIRTH, C_NAME, C_NUM1, C_NUM2, C_NUM3, C_NUM4, C_MM, C_YY, C_CVC, C_PW]
        
        var CHECK: Bool = false
        if TYPE == "bank" {
            for i in 0 ..< TF1.count { CHECK = false; if TF1[i].text != "" { CHECK = true } }
        } else {
            for i in 0 ..< TF2.count { CHECK = false; if TF2[i].text != "" { CHECK = true } }
        }
        
        if CHECK {
            
            var CHECK2: Bool = false
            for DATA in UIViewController.APPDELEGATE.OBJ_PAY_INFO {
                
                let C_NUM1 = DATA.value(forKey: "c_num1") as? String ?? ""
                let C_NUM2 = DATA.value(forKey: "c_num2") as? String ?? ""
                let C_NUM3 = DATA.value(forKey: "c_num3") as? String ?? ""
                let C_NUM4 = DATA.value(forKey: "c_num4") as? String ?? ""
                if C_NUM1 == self.C_NUM1.text! && C_NUM2 == self.C_NUM2.text! && C_NUM3 == self.C_NUM3.text! && C_NUM4 == self.C_NUM4.text! {
                    CHECK2 = true
                }
            }
            
            if !CHECK2 || TYPE == "bank" {
                
                if IMG_DATA != Data() {
                    
                    if UIViewController.APPDELEGATE.PAY_INFO_SAVE(TYPE: TYPE, B_NAME: B_NAME.text!, B_NUM: B_NUM.text!, BIRTH: "\(B_BIRTH.text!)\(C_BIRTH.text!)", C_CVC: C_CVC.text!, C_DATE: "\(C_MM.text!)/\(C_YY.text!)", C_NAME: C_NAME.text!, C_NUM1: C_NUM1.text!, C_NUM2: C_NUM2.text!, C_NUM3: C_NUM3.text!, C_NUM4: C_NUM4.text!, MB_NAME: "\(B_MB_NAME.text!)\(C_MB_NAME.text!)", PASSWORD: "\(B_PW.text!)\(C_PW.text!)", SIGNATURE: IMG_DATA) {
                        VIEW_NOTICE("T: 결제 수단 등록 완료")
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            self.navigationController?.popViewController(animated: true)
                        }
                    } else {
                        VIEW_NOTICE("F: 결제 수단 등록 실패")
                    }
                } else {
                    VIEW_NOTICE("F: 서명란이 비어 있음")
                }
            } else {
                VIEW_NOTICE("F: 이미 등록된 결제수단")
            }
        } else {
            VIEW_NOTICE("N: 미입력된 항목이 있습니다")
        }
    }
}

extension PAYMENT_ADD: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let OFFSET_Y = scrollView.contentOffset.y
        if OFFSET_Y >= 0 { NAVI_TITLE.alpha = OFFSET_Y/20 } else { NAVI_TITLE.alpha = 0.0 }
    }
}

extension PAYMENT_ADD: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == PICKER_BANK { return BANKS.count } else { return CARDS.count }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == PICKER_BANK { return BANKS[row] } else { return CARDS[row] }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == PICKER_BANK { B_POSITION = row; B_NAME.text = BANKS[row] } else { C_POSITION = row; C_NAME.text = CARDS[row] }
    }
}
