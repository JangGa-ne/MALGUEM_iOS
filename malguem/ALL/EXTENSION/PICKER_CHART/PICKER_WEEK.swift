//
//  PICKER_WEEK.swift
//  malguem
//
//  Created by 부산광역시교육청 on 2021/05/04.
//

import UIKit

/// 일별
class PICKER_WEEK: UIPickerView {
    
    var YEARS: [Int] = []
    var YEAR = Calendar.current.component(.year, from: Date()) {
        didSet { selectRow(YEARS.firstIndex(of: YEAR)!, inComponent: 0, animated: true) }
    }
    
    var WEEKS: [Int] = []
    var WEEK = Calendar.current.component(.weekOfYear, from: Date()) {
        didSet { selectRow(WEEK-1, inComponent: 1, animated: true) }
    }
    
    var SELECT_WEEK: ((_ YEAR: Int, _ WEEK: Int) -> Void)?
    
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
        
        var WEEKS: [Int] = []
        if WEEKS.count == 0 {
            var WEEK = Calendar(identifier: .gregorian).component(.weekOfYear, from: Date())
            for i in 1 ... 52 { WEEKS.append(i); WEEK += 1 }
        }
        self.WEEKS = WEEKS
        
        let C_YEAR = Calendar(identifier: .gregorian).component(.year, from: Date())
        selectRow(C_YEAR-1, inComponent: 0, animated: false)
        let C_WEEK = Calendar(identifier: .gregorian).component(.weekOfYear, from: Date())
        selectRow(C_WEEK-1, inComponent: 1, animated: false)
    }
}

extension PICKER_WEEK: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if component == 0 {
            return YEARS.count
        } else if component == 1 {
            return WEEKS.count
        } else {
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if component == 0 {
            if YEARS.count > row { SELETE(); return "\(YEARS[row])년" } else { return "" }
        } else if component == 1 {
            if WEEKS.count > row { SELETE(); return "\(WEEKS[row])주" } else { return "" }
        } else {
            return ""
        }
    }
    
    func SELETE() {
        
        let YEAR = YEARS[selectedRow(inComponent: 0)]
        let WEEK = selectedRow(inComponent: 1)+1
        
        if let BLOCK = SELECT_WEEK { BLOCK(YEAR, WEEK) }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let YEAR = YEARS[selectedRow(inComponent: 0)]
        let WEEK = selectedRow(inComponent: 1)+1
        
        if let BLOCK = SELECT_WEEK { BLOCK(YEAR, WEEK) }
        self.YEAR = YEAR; self.WEEK = WEEK
    }
}
