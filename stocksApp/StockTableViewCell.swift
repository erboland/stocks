//
//  StockTableViewCell.swift
//  stocksApp
//
//  Created by Ербол Каршыга on 4/23/17.
//  Copyright © 2017 Octopus. All rights reserved.
//

import UIKit

class StockTableViewCell: UITableViewCell {

   
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var sharesLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var growthLabel: UILabel!
    
    
    var symbol: String! {
        didSet {
            nameLabel.text = symbol
            
            getRealTimeStock(symbol)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func getRealTimeStock(_ symbol: String){
        
        print("get real time")
        
        Socket().onStocksOf(symbol) { snap in
            if let data = snap as? NSArray {
                
                
                if let arr = data[0] as? NSArray, let stock = arr[0] as? NSDictionary  {
                    
                    guard let price = stock.object(forKey: "price") as? String else {return}
                    guard let inc = stock.object(forKey: "incNumber") as? String else {return}
                    
                    
                    self.growthLabel.text = inc
                    
                    if inc.components(separatedBy: " ")[0] != "+" {
                        self.growthLabel.textColor = UIColor(hex: StockEnum.mainColor.rawValue)
                    } else {
                        self.growthLabel.textColor = UIColor.red
                    }
                    
                    self.priceLabel.text = "$\(price)"
                    
                    
                    
                } else {
                     print("not dictionary")
                }
                
            } else {
                print("not array")
            }
        }
    }

    
}
