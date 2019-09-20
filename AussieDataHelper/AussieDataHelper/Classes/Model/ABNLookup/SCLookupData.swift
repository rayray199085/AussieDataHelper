//
//  SCLookupData.swift
//  AussieDataHelper
//
//  Created by Stephen Cao on 26/6/19.
//  Copyright © 2019 Stephencao Cao. All rights reserved.
//

import UIKit

struct SCLookupData: Decodable {
    var Abn: String?
    var AbnStatus: String?
    var AddressDate: String?
    var AddressPostcode: String?
    var AddressState: String?
    var BusinessName: [String]?
    var EntityName: String?
    var EntityTypeCode: String?
    var EntityTypeName: String?
    var Gst: String?
    var Message: String?
}
