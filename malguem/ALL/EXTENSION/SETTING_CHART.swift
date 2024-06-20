//
//  SETTING_CHART.swift
//  malguem
//
//  Created by 부산광역시교육청 on 2021/05/03.
//

import UIKit
import Charts

//MARK: 차트 설정
extension CHART {
    
    func SETTING_CHART(VIEW: BarChartView) {
/// 차트 기본 설정
        VIEW.noDataText = ""
        VIEW.backgroundColor = .clear
        VIEW.chartDescription?.enabled = false
        VIEW.drawBarShadowEnabled = false
        VIEW.drawGridBackgroundEnabled = false
        VIEW.drawValueAboveBarEnabled = false
        VIEW.scaleXEnabled = false
        VIEW.scaleYEnabled = false
/// 차트 하단
        VIEW.xAxis.enabled = true
        VIEW.xAxis.labelFont = .systemFont(ofSize: 10, weight: .light)
        VIEW.xAxis.granularity = 1
        VIEW.xAxis.labelPosition = .bottom
        VIEW.xAxis.drawGridLinesEnabled = false
        VIEW.xAxis.labelTextColor = .black
/// 차트 횐쪽
        VIEW.leftAxis.enabled = true
        VIEW.leftAxis.labelFont = .systemFont(ofSize: 10, weight: .light)
        VIEW.leftAxis.valueFormatter = LEFT_VF()
        VIEW.leftAxis.spaceTop = 0.2
        VIEW.leftAxis.axisMinimum = 0
        VIEW.leftAxis.drawGridLinesEnabled = false
        VIEW.leftAxis.labelTextColor = .black
/// 차트 오른쪽
        VIEW.rightAxis.enabled = false
    }
}

//MARK: 차트 횐쪽
class LEFT_VF: NSObject, IValueFormatter, IAxisValueFormatter {
    
    public var UNIT = [" kW", " MW", " GW", " TW", " EW", " PW"]
    
    public var APPEND_TEXT: String?
    
    public init(APPEND_TEXT: String? = nil) {
        self.APPEND_TEXT = APPEND_TEXT
    }
    
    fileprivate func format(value: Double) -> String {
        
        var sig = value
        var length = 0
        let maxLength = UNIT.count - 1
        
        while sig >= 1000 && length < maxLength { sig /= 1000; length += 1 }
        var r = String(format: "%2.f", sig) + UNIT[length]
        if let APPEND_TEXT = APPEND_TEXT { r += APPEND_TEXT }
        
        return r
    }
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return format(value: value)
    }
    
    func stringForValue( _ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
        return format(value: value)
    }
}
