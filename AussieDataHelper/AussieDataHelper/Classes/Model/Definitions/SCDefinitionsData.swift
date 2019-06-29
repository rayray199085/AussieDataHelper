//
//  SCDefinitionsData.swift
//  AussieDataHelper
//
//  Created by Stephen Cao on 29/6/19.
//  Copyright © 2019 Stephencao Cao. All rights reserved.
//

import UIKit

class SCDefinitionsData: NSObject {
    @objc var content: [SCDefinitionsDataContent]?
    @objc var numberOfElements: Int = 0
    @objc var firstPage: Int = 0
    @objc var lastPage: Int = 0
    @objc var totalPages: Int = 0
    
    @objc class func modelContainerPropertyGenericClass()->[String:AnyClass]{
        return ["content": SCDefinitionsDataContent.self]
    }
    
    override var description: String{
        return yy_modelDescription()
    }
}
