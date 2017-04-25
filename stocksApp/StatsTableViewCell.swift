//
//  StatsTableViewCell.swift
//  stocks
//
//  Created by Ербол Каршыга on 4/22/17.
//  Copyright © 2017 Octopus. All rights reserved.
//

import UIKit

class StatsTableViewCell: UITableViewCell {

    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var firstNumber: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var secondNumber: UILabel!


    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
