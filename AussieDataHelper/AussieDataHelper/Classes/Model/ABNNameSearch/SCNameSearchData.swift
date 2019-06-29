//
//  SCNameSearchData.swift
//  AussieDataHelper
//
//  Created by Stephen Cao on 28/6/19.
//  Copyright © 2019 Stephencao Cao. All rights reserved.
//

import UIKit

class SCNameSearchData: NSObject {
    @objc var Message: String?
    @objc var Names: [SCNameSearchItem]?
    
    @objc class func modelContainerPropertyGenericClass()->[String:AnyClass]{
        return ["Names": SCNameSearchItem.self]
    }
    
    override var description: String{
        return yy_modelDescription()
    }
}
