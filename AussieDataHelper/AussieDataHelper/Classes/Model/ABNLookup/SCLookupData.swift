//
//  SCLookupData.swift
//  AussieDataHelper
//
//  Created by Stephen Cao on 26/6/19.
//  Copyright © 2019 Stephencao Cao. All rights reserved.
//

import UIKit

class SCLookupData: NSObject {

    @objc var Abn: String?
    @objc var AbnStatus: String?
    @objc var AddressDate: String?
    @objc var AddressPostcode: String?
    @objc var AddressState: String?
    @objc var BusinessName: [String]?
    @objc var EntityName: String?
    @objc var EntityTypeCode: String?
    @objc var EntityTypeName: String?
    @objc var Gst: String?
    @objc var Message: String?
    
    override var description: String{
        return yy_modelDescription()
    }
}
