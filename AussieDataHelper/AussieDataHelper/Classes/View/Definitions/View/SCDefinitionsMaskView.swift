//
//  SCDefinitionsMaskView.swift
//  AussieDataHelper
//
//  Created by Stephen Cao on 29/6/19.
//  Copyright © 2019 Stephencao Cao. All rights reserved.
//

import UIKit

class SCDefinitionsMaskView: UIView {
    
    @IBAction func definitionsMaskButton(_ sender: Any) {
       isHidden = true
    }
    @IBOutlet weak var textView: UITextView!
    
    class func maskView()->SCDefinitionsMaskView{
        let nib = UINib(nibName: "SCDefinitionsMaskView", bundle: nil)
        let v = nib.instantiate(withOwner: self, options: nil)[0] as! SCDefinitionsMaskView
        v.frame = UIScreen.main.bounds
        return v
    }
}
