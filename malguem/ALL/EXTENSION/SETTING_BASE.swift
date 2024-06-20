//
//  SETTING_BASE.swift
//  malguem
//
//  Created by 부산광역시교육청 on 2021/04/30.
//

import UIKit

extension UIViewController {
    
    static var APPDELEGATE = UIApplication.shared.delegate as! AppDelegate
    
//MARK: 카카오톡 문의
    func SETTING_KAKAO(_ BTN: UIButton) {
        
        BTN.layer.cornerRadius = 15.0
        BTN.clipsToBounds = true
        BTN.addTarget(self, action: #selector(KAKAO_TALK(_:)), for: .touchUpInside)
    }
    
    @objc func KAKAO_TALK(_ sender: UIButton) {
/// 야베스
        UIApplication.shared.open(URL(string: POST_URL().KAKAO_CHAT)!)
    }
    
    func RADIUS(_ VIEW: UIView, CORNER: CGFloat, CLIP: Bool) {
        
        VIEW.layer.cornerRadius = CORNER
        VIEW.clipsToBounds = CLIP
    }
    
/// 발전 계산
    func UNIT_DATA(UNIT: Double) -> String {
        
        var RETURN: String = "-"
        if UNIT > 0 && UNIT < 1000 {
            RETURN = "\(UNIT) kW"
        } else if UNIT >= 1000 && UNIT < 1000000 {
            RETURN = "\(floor(UNIT/100)/10) MW"
        } else if UNIT >= 1000000 && UNIT < 1000000000 {
            RETURN = "\(floor(UNIT/100000)/10) GW"
        } else if UNIT >= 1000000000 && UNIT < 1000000000000 {
            RETURN = "\(floor(UNIT/100000000)/10) GW"
        }
        return RETURN.replacingOccurrences(of: ".0", with: "")
    }
    
/// 콤마
    func COMMA(NUM: Int) -> String {
        
        let NF = NumberFormatter()
        NF.numberStyle = .decimal
        
        if NUM == 0 {
            return "-"
        } else {
            return "\(NF.string(from: NUM as NSNumber) ?? "-")원"
        }
    }
}

extension UITableViewCell {
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
    }
}

//MARK: 내비게이션 설정
extension UIViewController: UIGestureRecognizerDelegate {
    
    func BACK_GESTURE(_ BOOL: Bool) {
        UIViewController.APPDELEGATE.SWIPE_GESTURE = BOOL
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive event: UIEvent) -> Bool {
        return UIViewController.APPDELEGATE.SWIPE_GESTURE
    }
}

extension UIView {
    
/// 회전
    func ROTATE_360(ANIMATION: Bool) {
        
        let ROTATE = CABasicAnimation(keyPath: "transform.rotation.z")
        ROTATE.fromValue = 0.0
        ROTATE.toValue = Double.pi * 2
        ROTATE.duration = 1.0
        ROTATE.isCumulative = true
        ROTATE.repeatCount = HUGE
        if ANIMATION { layer.add(ROTATE, forKey: nil) } else { layer.removeAllAnimations() }
    }
}
