//
//  SCNameSearchTableViewCell.swift
//  AussieDataHelper
//
//  Created by Stephen Cao on 28/6/19.
//  Copyright © 2019 Stephencao Cao. All rights reserved.
//

import UIKit

class SCNameSearchTableViewCell: UITableViewCell {
    var nameItem: SCNameSearchItem?{
        didSet{
            abnTextView.text = nameItem?.Abn
            abnStatusLabel.text = nameItem?.AbnStatus
            isCurrentLabel.text = nameItem?.IsCurrent == 1 ? "YES" : "NO"
            nameLabel.text = nameItem?.Name
            nameType.text = nameItem?.NameType
            postcodeLabel.text = nameItem?.Postcode
            scoreLabel.text = "\(nameItem?.Score ?? 0)"
            stateLabel.text = nameItem?.State
        }
    }
    func setTextViewScrollToTop(){
        abnTextView.scrollRangeToVisible(NSMakeRange(0, 0))
    }
    @IBOutlet weak var abnTextView: UITextView!{
        didSet{
            abnTextView.textContainerInset = UIEdgeInsets(top: 0, left: -5, bottom: 0, right: 0)
        }
    }
    @IBOutlet weak var abnStatusLabel: UILabel!
    @IBOutlet weak var isCurrentLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameType: UILabel!
    
    @IBOutlet weak var postcodeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
}
