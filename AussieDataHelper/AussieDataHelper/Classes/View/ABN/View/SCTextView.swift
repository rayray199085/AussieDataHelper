//
//  SCTextView.swift
//  AussieDataHelper
//
//  Created by Stephen Cao on 26/6/19.
//  Copyright © 2019 Stephencao Cao. All rights reserved.
//

import UIKit

class SCTextView: UITextView {
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
}
private extension SCTextView{
    func setupUI(){
        layer.borderColor = HelperCommon.frameColor
        layer.borderWidth = 1
        layer.cornerRadius = 5
    }
}
