//
//  TimeRangeControl.swift
//  stocks
//
//  Created by Robert Kim on 4/20/17.
//  Copyright © 2017 Octopus. All rights reserved.
//

import UIKit

protocol TimeRangeControlDelegate {
    func selectedChanged(range: TimeRangeEnum)
}

class TimeRangeControl: UIControl {
    
    var items = [
        ["1Д": TimeRangeEnum.today],
        ["5Д": TimeRangeEnum.fiveDays],
        ["1М": TimeRangeEnum.month],
        ["3М": TimeRangeEnum.threeMonth],
        ["6М": TimeRangeEnum.sixMonth],
        ["1Г": TimeRangeEnum.year]
    ]
    
    var labels = [UILabel]()
    var delegate: TimeRangeControlDelegate?
    
    
    var selectedIndex = 0 {
        didSet {
            selectedChanged()
        }
    }
    
    @IBInspectable public var standartColor: UIColor = UIColor.white
    @IBInspectable public var selectedColor: UIColor = UIColor(hex: StockEnum.mainColor.rawValue)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLabels()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)!
        setupLabels()
    }
    
    
    func setupLabels(){
        
        let labelWidth = self.frame.width / 6
       
        for (index,item) in items.enumerated() {
            
            let label = UILabel(frame: CGRect(x: CGFloat(index) * labelWidth , y: 0, width: labelWidth, height: self.frame.height))
            label.text = item.first?.key
            label.font = UIFont(name: "AvenirNext-Regular", size: 18)
            label.textAlignment = .center
            label.textColor = standartColor
            labels.append(label)
            self.addSubview(label)
            
        }
        
        selectedChanged()
        
    }
    
    func selectedChanged(){
        
        delegate?.selectedChanged(range: (items[selectedIndex].first?.value)!)
        
        for label in labels {
            label.alpha = 0.6
            
        }
        
        let label = labels[selectedIndex]
       
        label.alpha = 1.0
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let location = touch.location(in: self)
        
        for (index, label) in labels.enumerated() {
            if label.frame.contains(location) {
                self.selectedIndex = index
                sendActions(for: .valueChanged)
                return false
            }
        }
        
        return false
    }
    
}
