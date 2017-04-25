
//  ViewController.swift
//  stocks
//
//  Created by Robert Kim on 4/18/17.
//  Copyright © 2017 Octopus. All rights reserved.
//

import UIKit

class PortfolioViewController: UIViewController, TimeRangeControlDelegate {
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
//        self.graphWrapper.layer.cornerRadius = 4
//        self.graphWrapper.backgroundColor = UIColor(hex: "EEEEEE")
//        
//        
//        self.lineGraphView.lineWidth = 2
//        self.lineGraphView.lineColor = UIColor(hex: StockEnum.mainColor.rawValue)
//        self.lineGraphView.backgroundColor = UIColor.clear
//        
//      
//        self.timeRangeControl.delegate = self
//        
//        Socket().onStocksOf("GOOG") { data in
//            print("data recied", data)
//        }
        
    }
    
    func selectedChanged(range: TimeRangeEnum) {
//        self.lineGraphView.showStocksFor(range, symbol: "GOOG")
    }

   
}

