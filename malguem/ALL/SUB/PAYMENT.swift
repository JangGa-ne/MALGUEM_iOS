//
//  PAYMENT.swift
//  malguem
//
//  Created by 부산광역시교육청 on 2021/05/07.
//

import UIKit
import Alamofire

class PAYMENT_VC: UICollectionViewCell {
    
    @IBOutlet weak var DELETE: UIButton!
    
    @IBOutlet weak var BC_NAME: UILabel!
    @IBOutlet weak var MB_NAME: UILabel!
    @IBOutlet weak var NUMBER: UILabel!
    @IBOutlet weak var C_DATE: UILabel!
}

class PAYMENT: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 13.0, *) { return .darkContent } else { return .default }
    }
    
    @IBAction func BACK_VC(_ sender: UIButton) { navigationController?.popViewController(animated: true) }
    
    var PAY_AMOUNT: Int = 0
    var INIT_AMOUNT: Int = 0
    
    var P_POSITION: Int = 0
    var POSITION: Int = 0
    
    @IBOutlet weak var NAVI_TITLE: UILabel!
    @IBOutlet weak var KAKAO_TALK: UIButton!
    @IBOutlet weak var SCROLL_VIEW: UIScrollView!
    
    @IBOutlet weak var PAY_BG: UIView!
    @IBOutlet weak var RG_PAY: UILabel!
    @IBOutlet weak var MN_PAY: UILabel!
    
    @IBOutlet weak var S1_BG: UIView!
    @IBOutlet weak var COLLECTION_VIEW: UICollectionView!
    
    @IBOutlet weak var S2_BG: UIView!
    @IBOutlet weak var AG_IMAGE_1: UIImageView!
    @IBOutlet weak var AG_1: UIButton!
    @IBOutlet weak var AG_IMAGE_2: UIImageView!
    @IBOutlet weak var AG_2: UIButton!
    
    @IBOutlet weak var SUBMIT: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NAVI_TITLE.alpha = 0.0
        SETTING_KAKAO(KAKAO_TALK)
        
        for DATA in UIViewController.APPDELEGATE.OBJ_PLANT {
            PAY_AMOUNT += Int(DATA.PAY_AMOUNT) ?? 0
            INIT_AMOUNT += Int(DATA.INIT_AMOUNT) ?? 0
        }
        
        RG_PAY.text = COMMA(NUM: PAY_AMOUNT)
        MN_PAY.text = COMMA(NUM: INIT_AMOUNT)
/// 스크롤뷰
        SCROLL_VIEW.delegate = self
        
        RADIUS(PAY_BG, CORNER: 10.0, CLIP: true)
        RADIUS(S1_BG, CORNER: 10.0, CLIP: true)
        RADIUS(S2_BG, CORNER: 10.0, CLIP: true)
        
/// 컬렉션뷰
        let LAYER = UICollectionViewFlowLayout()
        LAYER.scrollDirection = .horizontal
        LAYER.minimumLineSpacing = 40.0
        LAYER.sectionInset.left = 20.0
        LAYER.sectionInset.right = 20.0
        COLLECTION_VIEW.setCollectionViewLayout(LAYER, animated: false)
        COLLECTION_VIEW.delegate = self
        COLLECTION_VIEW.dataSource = self
        
/// 약관동의
        AG_1.addTarget(self, action: #selector(AGREE_1(_:)), for: .touchUpInside)
        AG_2.addTarget(self, action: #selector(AGREE_2(_:)), for: .touchUpInside)
        
/// 결제
        SUBMIT.addTarget(self, action: #selector(SUBMIT(_:)), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        BACK_GESTURE(true)
        COLLECTION_VIEW.reloadData()
    }
    
    @objc func AGREE_1(_ sender: UIButton) {
        
        let ALERT = UIAlertController(title: "개인정보 수집 및 이용동의", message: "• 수집 및 이용목적 : 효성CMS 자동이체를 통한 요금수납 \n • 수집항목 : 성명, 성별, 생년월일, 연락처, 졀제서명, 졀제자명, 계좌번호, 카드번호, 유효기간, 휴대/유선전화번호 \n • 보유 및 이용기간 : 수집/이용 동의일부터 자동이체 종료일(해지일)까지 \n • 신청자는 개인정보의 수집 및 이용을 거부할 수 있습니다. \n • 단, 거부시 자동이체 신청이 처리되지 않습니다.", preferredStyle: .actionSheet)
        ALERT.addAction(UIAlertAction(title: "동의함", style: .default, handler: { _ in
            self.AG_IMAGE_1.image = UIImage(named: "check_on.png")
        }))
        ALERT.addAction(UIAlertAction(title: "동의안함", style: .cancel , handler: { _ in
            self.AG_IMAGE_1.image = UIImage(named: "check_off.png")
        }))
        
        present(ALERT, animated: true, completion: nil)
    }
    
    @objc func AGREE_2(_ sender: UIButton) {
        
        let ALERT = UIAlertController(title: "개인정보 제3자 제공동의", message: "• 개인정보를 제공받는 자 : 효성에프엠에스(주), 금융기관(하단 신청가능은행 참조), 통신사(SKT, KT, LGU+, CJ헬로비전), 카드사(BC, 국민, 외환, 삼성, 신한, 롯데, 하나SK, 현대 등), 결제대행사(KG이니시스, KCP), 효성ITX 등 \n • 개인정보를 제공받는 자의 이용 목적 : 자동이체서비스 제공 및 자동이체 동의 사실 통지, 고객센터 운영 • 제공하는 개인정보의 항목 : 성명, 성별, 생년월일, 연락처, 졀제서명, 졀제자명, 계좌번호, 카드번호, 유효기간, 휴대/유선전화번호 \n • 개인정보를 제공받는자의 개인정보 보유 및 이용기간 : 동의일부터 자동이체의 종료일(해지일)까지 \n • 단, 관계 법령에 의거 일정기간 동안 보관 \n • 신청자는 개인정보에 대해 수납업체가 제 3자에 제공하는 것을 거부할 수 있습니다. \n • 단, 거부 시 자동이체 신청이 처리됙지 않습니다.", preferredStyle: .actionSheet)
        ALERT.addAction(UIAlertAction(title: "동의함", style: .default, handler: { _ in
            self.AG_IMAGE_2.image = UIImage(named: "check_on.png")
        }))
        ALERT.addAction(UIAlertAction(title: "동의안함", style: .cancel , handler: { _ in
            self.AG_IMAGE_2.image = UIImage(named: "check_off.png")
        }))
        
        present(ALERT, animated: true, completion: nil)
    }
    
    @objc func SUBMIT(_ sender: UIButton) {
        
        let OBJ_PAY_INFO = UIViewController.APPDELEGATE.OBJ_PAY_INFO
        
        if OBJ_PAY_INFO.count == POSITION {
            VIEW_NOTICE("N: 잘못된 선택")
        } else if OBJ_PAY_INFO.count == 0 {
            VIEW_NOTICE("N: 결제수단을 등록해 주세요")
        } else if AG_IMAGE_1.image != UIImage(named: "check_on.png") || AG_IMAGE_2.image != UIImage(named: "check_on.png") {
            VIEW_NOTICE("N: 미동의 항목이 있습니다")
        } else {
            
            let PAY_INFO = OBJ_PAY_INFO[POSITION]
            let TYPE = PAY_INFO.value(forKey: "type") as? String ?? ""
            let B_NAME = PAY_INFO.value(forKey: "b_name") as? String ?? ""
            let C_NAME = PAY_INFO.value(forKey: "c_name") as? String ?? ""
            let MB_NAME = PAY_INFO.value(forKey: "mb_name") as? String ?? ""
            
            let ALERT = UIAlertController(title: "\(B_NAME)\(C_NAME) (\(MB_NAME))", message: "결제 정보가 맞나요?", preferredStyle: .alert)
            ALERT.addAction(UIAlertAction(title: "결제하기", style: .default, handler: { _ in
                self.PUSH_POST_DATA(NAME: "결제수단등록", TYPE: TYPE)
//                print(UIViewController.APPDELEGATE.OBJ_PAY_INFO)
            }))
            ALERT.addAction(UIAlertAction(title: "취소", style: .destructive, handler: nil))
            present(ALERT, animated: true, completion: nil)
        }
    }
    
    func PUSH_POST_DATA(NAME: String, TYPE: String) {
        
        let DATA = UIViewController.APPDELEGATE.OBJ_PLANT[P_POSITION]
        let OBJECT = UIViewController.APPDELEGATE.OBJ_PAY_INFO[POSITION]
        var PARAMETERS: Parameters = [
            "mb_id": UserDefaults.standard.string(forKey: "mb_id") ?? "",
            "payment_type": TYPE,
            "pay_amount": DATA.PAY_AMOUNT,
            "init_amount": DATA.INIT_AMOUNT
        ]
        
        if TYPE == "bank" {
            PARAMETERS["pay_name"] = OBJECT.value(forKey: "mb_name") as? String ?? ""
            PARAMETERS["pay_dob"] = OBJECT.value(forKey: "birth") as? String ?? ""
            PARAMETERS["pay_company"] = OBJECT.value(forKey: "b_name") as? String ?? ""
            PARAMETERS["pay_account"] = OBJECT.value(forKey: "b_num") as? String ?? ""
            PARAMETERS["pay_password"] = OBJECT.value(forKey: "b_pw") as? String ?? ""
        } else {
            PARAMETERS["pay_name"] = OBJECT.value(forKey: "mb_name") as? String ?? ""
            PARAMETERS["pay_dob"] = OBJECT.value(forKey: "birth") as? String ?? ""
            PARAMETERS["pay_company"] = OBJECT.value(forKey: "c_name") as? String ?? ""
            let C_NUM1 = OBJECT.value(forKey: "c_num1") as? String ?? ""
            let C_NUM2 = OBJECT.value(forKey: "c_num2") as? String ?? ""
            let C_NUM3 = OBJECT.value(forKey: "c_num3") as? String ?? ""
            let C_NUM4 = OBJECT.value(forKey: "c_num4") as? String ?? ""
            PARAMETERS["pay_account"] = "\(C_NUM1) \(C_NUM2) \(C_NUM3) \(C_NUM4)"
            PARAMETERS["pay_expday"] = OBJECT.value(forKey: "c_date") as? String ?? ""
            PARAMETERS["pay_code"] = OBJECT.value(forKey: "c_cvc") as? String ?? ""
            PARAMETERS["pay_password"] = OBJECT.value(forKey: "c_pw") as? String ?? ""
        }
        
        let MANAGER = Alamofire.SessionManager.default
        MANAGER.session.configuration.timeoutIntervalForRequest = 10.0
        MANAGER.upload(multipartFormData: { multipartFormData in
            
            print("[\(NAME)]")
            for (KEY, VALUE) in PARAMETERS {
                print("KEY: \(KEY)", "VALUE: \(VALUE)")
                multipartFormData.append("\(VALUE)".data(using: .utf8)!, withName: KEY as String)
            }
/// 서명
            multipartFormData.append(OBJECT.value(forKey: "signature") as? Data ?? Data(), withName: "pay_sign", fileName: "imagesign.jpg", mimeType: "image/jpg")
        }, to: POST_URL().BASE + "member/m_payment_insert.php") { (result) in
            
            switch result {
            case .success(let upload, _, _):
                
                upload.responseJSON { response in
                    
                    print(response)
                    
                    guard let DATA_DICT = response.result.value as? [String: Any] else {
                        print("FAILURE: \(response.result.error.debugDescription)")
                        return
                    }
                    
                    if DATA_DICT["result"] as? String ?? "" == "success" {
                        self.VIEW_NOTICE("T: 결제 등록 완료")
                    } else {
                        self.VIEW_NOTICE("F: 결제 등록 실패")
                    }
                }
            case .failure(let encodingError):
        
                print(encodingError)
                break
            }
        }
    }
}
 
extension PAYMENT: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let OFFSET_Y = scrollView.contentOffset.y
        if OFFSET_Y >= 0 { NAVI_TITLE.alpha = OFFSET_Y/20 } else { NAVI_TITLE.alpha = 0.0 }
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        if scrollView == COLLECTION_VIEW {
            
            // 진동 이벤트
            UIImpactFeedbackGenerator().impactOccurred()
            
            POSITION = Int(targetContentOffset.pointee.x / COLLECTION_VIEW.frame.width)
        }
    }
}

extension PAYMENT: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if UIViewController.APPDELEGATE.OBJ_PAY_INFO.count == 0 { return 1 } else { return 2 }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if UIViewController.APPDELEGATE.OBJ_PAY_INFO.count != 0 && section == 0 {
            if UIViewController.APPDELEGATE.OBJ_PAY_INFO.count == 0 {
                return 0
            } else {
                return UIViewController.APPDELEGATE.OBJ_PAY_INFO.count
            }
        } else {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if UIViewController.APPDELEGATE.OBJ_PAY_INFO.count != 0 && indexPath.section == 0 {
            
            let DATA = UIViewController.APPDELEGATE.OBJ_PAY_INFO[indexPath.item]
            let CELL = collectionView.dequeueReusableCell(withReuseIdentifier: "PAYMENT_VC", for: indexPath) as! PAYMENT_VC
            
            let TYPE = DATA.value(forKey: "type") as? String ?? ""
            if TYPE == "bank" {
                CELL.backgroundColor = UIColor(red: 22/255, green: 70/255, blue: 85/255, alpha: 1.0)
            } else {
                CELL.backgroundColor = UIColor(red: 43/255, green: 63/255, blue: 107/255, alpha: 1.0)
            }
            
            CELL.DELETE.tag = indexPath.item
            CELL.DELETE.addTarget(self, action: #selector(DELETE(_:)), for: .touchUpInside)
            
            RADIUS(CELL, CORNER: 15.0, CLIP: true)
/// 은행명 또는 카드사명
            let B_NAME = DATA.value(forKey: "b_name") as? String ?? ""
            let C_NAME = DATA.value(forKey: "c_name") as? String ?? ""
            if TYPE == "bank" { CELL.BC_NAME.text = B_NAME } else { CELL.BC_NAME.text = C_NAME }
/// 이름
            CELL.MB_NAME.text = DATA.value(forKey: "mb_name") as? String ?? ""
/// 계좌번호 또는 카드번호
            let B_NUM = DATA.value(forKey: "b_num") as? String ?? ""
            let C_NUM1 = DATA.value(forKey: "c_num1") as? String ?? ""
            let C_NUM3 = DATA.value(forKey: "c_num3") as? String ?? ""
            let C_NUM4 = DATA.value(forKey: "c_num4") as? String ?? ""
            if B_NUM != "" {
                CELL.NUMBER.text = B_NUM
            } else {
                CELL.NUMBER.text = "\(C_NUM1) **** \(C_NUM3) \(C_NUM4)"
            }
            if TYPE == "bank" {
                CELL.C_DATE.isHidden = true
            } else {
                CELL.C_DATE.isHidden = false
                CELL.C_DATE.text = "유효기간 \(DATA.value(forKey: "c_date") as? String ?? "")"
            }
            
            return CELL
        } else {
            
            let CELL = collectionView.dequeueReusableCell(withReuseIdentifier: "PAYMENT_VC_A", for: indexPath) as! PAYMENT_VC
            
            RADIUS(CELL, CORNER: 15.0, CLIP: true)
            
            return CELL
        }
    }
    
    @objc func DELETE(_ sender: UIButton) {
        
        let OBJECT = UIViewController.APPDELEGATE.OBJ_PAY_INFO[sender.tag]
        
        var TYPE: String = OBJECT.value(forKey: "type") as? String ?? ""
        if TYPE == "bank" { TYPE = "계좌" } else { TYPE = "카드" }
        
        let ALERT = UIAlertController(title: "", message: "해당 \(TYPE)을(를) 삭제하시겠습니까?", preferredStyle: .alert)
        
        ALERT.addAction(UIAlertAction(title: "예", style: .default, handler: { _ in
            if UIViewController.APPDELEGATE.PAY_INFO_DELETE(OBJECT: OBJECT, POSITION: sender.tag) {
                self.VIEW_NOTICE("T: 삭제 되었습니다")
                DispatchQueue.main.async { self.COLLECTION_VIEW.reloadData() }
            } else {
                self.VIEW_NOTICE("F: 삭제 실패하였습니다")
            }
        }))
        ALERT.addAction(UIAlertAction(title: "아니오", style: .destructive, handler: nil))
        
        present(ALERT, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if UIViewController.APPDELEGATE.OBJ_PAY_INFO.count == 0 || indexPath.section == 1 {
            
            CONTROLLER_VC(IDENTIFIER: "PAYMENT_ADD", MT_STYLE: .crossDissolve, ANIMATED: true)
        }
    }
}

extension PAYMENT: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: COLLECTION_VIEW.frame.size.width - 40.0, height: COLLECTION_VIEW.frame.size.height)
    }
}
