//
//  SCDefinitionsTableViewCell.swift
//  AussieDataHelper
//
//  Created by Stephen Cao on 29/6/19.
//  Copyright © 2019 Stephencao Cao. All rights reserved.
//

import UIKit

class SCDefinitionsTableViewCell: UITableViewCell {
    var cententItem: SCDefinitionsContentItem?{
        didSet{
            nameLabel.text = cententItem?.name
            statusLabel.text = cententItem?.status
            var usages = ""
            for usageString in cententItem?.usage ?? []{
                usages += "\(usageString),"
            }
            if usages.last == ","{
                usages.removeLast()
            }
            usageLabel.text = usages
            typeLabel.text = cententItem?.type
        }
    }
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var usageLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    
}
