//
//  SCANZSICData.swift
//  AussieDataHelper
//
//  Created by Stephen Cao on 28/6/19.
//  Copyright © 2019 Stephencao Cao. All rights reserved.
//

import UIKit

class SCANZSICData: NSObject {
    @objc var code: String?
    @objc var parsedText: String?
    @objc var unparsedText: String?
    @objc var score: Double = 0
    @objc var rank: Int = 0
    
    override var description: String{
        return yy_modelDescription()
    }
}
