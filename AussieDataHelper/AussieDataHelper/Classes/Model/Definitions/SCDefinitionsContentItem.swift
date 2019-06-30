//
//  SCDefinitionsContentItem.swift
//  AussieDataHelper
//
//  Created by Stephen Cao on 29/6/19.
//  Copyright © 2019 Stephencao Cao. All rights reserved.
//

import UIKit

class SCDefinitionsContentItem: NSObject {
    @objc var name: String?
    @objc var domain: String?
    @objc var status: String?
    @objc var definition: String?
    @objc var usage: [String]?
    @objc var type: String?
    
    override var description: String{
        return yy_modelDescription()
    }
}
