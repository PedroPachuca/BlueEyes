//
//  BluetoothTableViewCell.swift
//  BlueSniff
//
//  Created by Pedro Pachuca on 12/2/15.
//  Copyright © 2015 Pedro Pachuca. All rights reserved.
//

import UIKit

class BluetoothTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var RSSILabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
