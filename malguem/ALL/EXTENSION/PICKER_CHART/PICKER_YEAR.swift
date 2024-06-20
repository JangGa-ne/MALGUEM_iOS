//
//  PICKER_YEAR.swift
//  malguem
//
//  Created by 부산광역시교육청 on 2021/05/04.
//

import UIKit

/// 연도별
class PICKER_YEAR: UIPickerView {
    
    var YEARS: [Int] = []
    var YEAR = Calendar.current.component(.year, from: Date()) {
        didSet { selectRow(YEARS.firstIndex(of: YEAR)!, inComponent: 0, animated: true) }
    }
    
    var SELECT_YEAR: ((_ YEAR: Int) -> Void)?
    
    override init(frame: CGRect) { super.init(frame: frame); self.SETUP() }
    required init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder); self.SETUP() }
    
    func SETUP() {
        
        delegate = self
        dataSource = self
        
        var YEARS: [Int] = []
        if YEARS.count == 0 {
            var YEAR = Calendar(identifier: .gregorian).component(.year, from: Date())
            for i in 1 ..< 10000 { YEARS.append(i); YEAR += 1 }
        }
        self.YEARS = YEARS
        
        let C_YEAR = Calendar(identifier: .gregorian).component(.year, from: Date())
        selectRow(C_YEAR-1, inComponent: 0, animated: false)
    }
}

extension PICKER_YEAR: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return YEARS.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if YEARS.count > row { SELETE(); return "\(YEARS[row])년" } else { return "" }
    }
    
    func SELETE() {
        
        let YEAR = YEARS[selectedRow(inComponent: 0)]
        
        if let BLOCK = SELECT_YEAR { BLOCK(YEAR) }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let YEAR = YEARS[selectedRow(inComponent: 0)]
        
        if let BLOCK = SELECT_YEAR { BLOCK(YEAR) }
        self.YEAR = YEAR
    }
}
