//
//  SETTING_COREDATA.swift
//  malguem
//
//  Created by 부산광역시교육청 on 2021/05/10.
//

import UIKit
import CoreData

extension AppDelegate {
    
    func COREDATA_FETCH(ENTITY_NAME: String) -> [NSManagedObject] {
        
        let CONTEXT = PERSISTENT_CONTAINER.viewContext
        let FETCH_REQUEST = NSFetchRequest<NSManagedObject>(entityName: ENTITY_NAME)
        let RESULT = try! CONTEXT.fetch(FETCH_REQUEST)
        
        return RESULT
    }
    
    func PAY_INFO_SAVE(TYPE: String, B_NAME: String, B_NUM: String, BIRTH: String, C_CVC: String, C_DATE: String, C_NAME: String, C_NUM1: String, C_NUM2: String, C_NUM3: String, C_NUM4: String, MB_NAME: String, PASSWORD: String, SIGNATURE: Data) -> Bool {
        
        let CONTEXT = PERSISTENT_CONTAINER.viewContext
        let OBJECT = NSEntityDescription.insertNewObject(forEntityName: "PAY_INFO", into: CONTEXT)
        
        OBJECT.setValue(TYPE, forKey: "type")
        OBJECT.setValue(B_NAME, forKey: "b_name")
        OBJECT.setValue(B_NUM, forKey: "b_num")
        OBJECT.setValue(BIRTH, forKey: "birth")
        OBJECT.setValue(C_CVC, forKey: "c_cvc")
        OBJECT.setValue(C_DATE, forKey: "c_date")
        OBJECT.setValue(C_NAME, forKey: "c_name")
        OBJECT.setValue(C_NUM1, forKey: "c_num1")
        OBJECT.setValue(C_NUM2, forKey: "c_num2")
        OBJECT.setValue(C_NUM3, forKey: "c_num3")
        OBJECT.setValue(C_NUM4, forKey: "c_num4")
        OBJECT.setValue(MB_NAME, forKey: "mb_name")
        OBJECT.setValue(PASSWORD, forKey: "password")
        OBJECT.setValue(SIGNATURE, forKey: "signature")
/// 데이터 추가
        OBJ_PAY_INFO.append(OBJECT)
        
        do { try CONTEXT.save(); return true } catch { CONTEXT.rollback(); return false }
    }
    
    func PAY_INFO_DELETE(OBJECT: NSManagedObject, POSITION: Int) -> Bool {
        
        let CONTEXT = PERSISTENT_CONTAINER.viewContext
/// 데이터 삭제
        CONTEXT.delete(OBJECT)
        OBJ_PAY_INFO.remove(at: POSITION)
        
        do { try CONTEXT.save(); return true } catch { CONTEXT.rollback(); return false }
    }
}
