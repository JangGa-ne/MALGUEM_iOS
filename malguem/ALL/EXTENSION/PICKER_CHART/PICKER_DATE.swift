//
//  PICKER_DATE.swift
//  malguem
//
//  Created by 부산광역시교육청 on 2021/05/04.
//

import UIKit

/// 시간별
class PICKER_DATE: UIPickerView {
    
    var YEARS: [Int] = []
    var YEAR = Calendar.current.component(.year, from: Date()) {
        didSet { selectRow(YEARS.firstIndex(of: YEAR)!, inComponent: 0, animated: true) }
    }
    
    var MONTHS: [Int] = []
    var MONTH = Calendar.current.component(.month, from: Date()) {
        didSet { selectRow(MONTH-1, inComponent: 1, animated: true) }
    }
    
    var DATES: [Int] = []
    var DATE = Calendar.current.component(.day, from: Date()) {
        didSet { selectRow(DATE-1, inComponent: 2, animated: true) }
    }
    
    var SELECT_DATE: ((_ YEAR: Int, _ MONTH: Int, _ DATE: Int) -> Void)?
    
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
        
        var MONTHS: [Int] = []
        if MONTHS.count == 0 {
            var MONTH = Calendar(identifier: .gregorian).component(.month, from: Date())
            for i in 1 ... 12 { MONTHS.append(i); MONTH += 1 }
        }
        self.MONTHS = MONTHS
        
        var DATES: [Int] = []
        if DATES.count == 0 {
            var DATE = Calendar(identifier: .gregorian).component(.day, from: Date())
            for i in 1 ... 31 { DATES.append(i); DATE += 1 }
        }
        self.DATES = DATES
        
        let C_YEAR = Calendar(identifier: .gregorian).component(.year, from: Date())
        selectRow(C_YEAR-1, inComponent: 0, animated: false)
        let C_MONTH = Calendar(identifier: .gregorian).component(.month, from: Date())
        selectRow(C_MONTH-1, inComponent: 1, animated: false)
        let C_DATE = Calendar(identifier: .gregorian).component(.day, from: Date())
        selectRow(C_DATE-1, inComponent: 2, animated: false)
    }
}

extension PICKER_DATE: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if component == 0 {
            return YEARS.count
        } else if component == 1 {
            return MONTHS.count
        } else if component == 2 {
            return DATES.count
        } else {
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if component == 0 {
            if YEARS.count > row { SELETE(); return "\(YEARS[row])년" } else { return "" }
        } else if component == 1 {
            if MONTHS.count > row { SELETE(); return "\(MONTHS[row])월" } else { return "" }
        } else if component == 2 {
            if DATES.count > row { SELETE(); return "\(DATES[row])일" } else { return "" }
        } else {
            return ""
        }
    }
    
    func SELETE() {
        
        let YEAR = YEARS[selectedRow(inComponent: 0)]
        let MONTH = selectedRow(inComponent: 1)+1
        let DATE = selectedRow(inComponent: 2)+1
        
        if let BLOCK = SELECT_DATE { BLOCK(YEAR, MONTH, DATE) }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let YEAR = YEARS[selectedRow(inComponent: 0)]
        let MONTH = selectedRow(inComponent: 1)+1
        let DATE = selectedRow(inComponent: 2)+1
        
        if let BLOCK = SELECT_DATE { BLOCK(YEAR, MONTH, DATE) }
        self.YEAR = YEAR; self.MONTH = MONTH; self.DATE = DATE
    }
}
