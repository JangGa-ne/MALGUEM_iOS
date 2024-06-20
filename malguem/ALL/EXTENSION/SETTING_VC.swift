//
//  SETTING_VC.swift
//  APT
//
//  Created by 장 제현 on 2021/04/15.
//

import UIKit

//MARK: 뷰컨트롤러 이동
extension UIViewController {
    
    func CONTROLLER_VC(IDENTIFIER: String, MT_STYLE: UIModalTransitionStyle, ANIMATED: Bool) {
        
        let VC = self.storyboard?.instantiateViewController(withIdentifier: IDENTIFIER)
        VC!.modalTransitionStyle = MT_STYLE
        navigationController?.pushViewController(VC!, animated: ANIMATED)
    }
    
    func CONTROLLER_TBC(IDENTIFIER: String, MT_STYLE: UIModalTransitionStyle, INDEX: Int, ANIMATED: Bool) {
        
        let TBC = self.storyboard?.instantiateViewController(withIdentifier: IDENTIFIER) as! UITabBarController
        TBC.modalTransitionStyle = MT_STYLE
        TBC.selectedIndex = INDEX
        navigationController?.pushViewController(TBC, animated: ANIMATED)
    }
}
