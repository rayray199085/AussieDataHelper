//
//  SCANZSICTableViewCell.swift
//  AussieDataHelper
//
//  Created by Stephen Cao on 28/6/19.
//  Copyright © 2019 Stephencao Cao. All rights reserved.
//

import UIKit

class SCANZSICTableViewCell: UITableViewCell {
    var anzsicCode: SCANZSICData?{
        didSet{
            rankLabel.text = "\(anzsicCode?.rank ?? 0)"
            descriptionLabel.text = anzsicCode?.unparsedText
            codeLabel.text = anzsicCode?.code
        }
    }
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var codeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
}
