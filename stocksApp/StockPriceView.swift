//
//  StockPriceView.swift
//  stocksApp
//
//  Created by Robert Kim on 4/23/17.
//  Copyright © 2017 Octopus. All rights reserved.
//

import UIKit

class StockPriceView: UIView {

    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var statsLabel: UILabel!
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeSubviews()
    }
    
    func initializeSubviews() {
        let view = Bundle.main.loadNibNamed("StockPrice", owner: self, options: nil)?[0] as! UIView
        self.addSubview(view)
        view.frame = self.bounds
    }


}
