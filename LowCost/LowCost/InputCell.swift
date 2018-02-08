//
//  InputCell.swift
//  LowCost
//
//  Created by SIRAJ V K on 07/02/18.
//  Copyright © 2018 SIRAJ V K. All rights reserved.
//

import UIKit

class InputCell: UITableViewCell {
    @IBOutlet weak var lblRow:UILabel?
    @IBOutlet weak var txtFieldInput:UITextField?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
