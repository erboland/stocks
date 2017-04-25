//
//  AssetTableViewCell.swift
//  stocks
//
//  Created by Ербол Каршыга on 4/18/17.
//  Copyright © 2017 Octopus. All rights reserved.
//

import UIKit

class AssetTableViewCell: UITableViewCell {
    @IBOutlet weak var graphicView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        growthLabel.textColor = .red
    }
    @IBOutlet weak var growthLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var sharesLabel: UILabel!

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
