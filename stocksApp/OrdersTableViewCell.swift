//
//  OrdersTableViewCell.swift
//  stocks
//
//  Created by Ербол Каршыга on 4/22/17.
//  Copyright © 2017 Octopus. All rights reserved.
//

import UIKit

class OrdersTableViewCell: UITableViewCell {

    var textLabe: UILabel!

    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var marketLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var sharesLabel: UILabel!

 
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
