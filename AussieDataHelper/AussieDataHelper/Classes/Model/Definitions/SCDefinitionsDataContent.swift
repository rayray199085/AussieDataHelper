//
//  SCDefinitionsDataContent.swift
//  AussieDataHelper
//
//  Created by Stephen Cao on 29/6/19.
//  Copyright © 2019 Stephencao Cao. All rights reserved.
//

import UIKit

class SCDefinitionsDataContent: NSObject {
    @objc var content: SCDefinitionsContentItem?
    
    override var description: String{
        return yy_modelDescription()
    }
}
