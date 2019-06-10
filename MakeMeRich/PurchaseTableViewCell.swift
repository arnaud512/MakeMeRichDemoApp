//
//  PurchaseTableViewCell.swift
//  MakeMeRich
//
//  Created by Arnaud Dupuy on 10/06/2019.
//  Copyright © 2019 Arnaud Dupuy. All rights reserved.
//

import UIKit

class PurchaseTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var purchaseButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()

        purchaseButton.layer.cornerRadius = 15
    }
}
