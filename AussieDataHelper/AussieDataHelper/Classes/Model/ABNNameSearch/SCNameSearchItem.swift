//
//  SCNameSearchItem.swift
//  AussieDataHelper
//
//  Created by Stephen Cao on 28/6/19.
//  Copyright © 2019 Stephencao Cao. All rights reserved.
//

import UIKit

class SCNameSearchItem: NSObject {
    @objc var Abn: String?
    @objc var AbnStatus: String?
    @objc var IsCurrent: Int = 0
    @objc var Name: String?
    @objc var NameType: String?
    @objc var Postcode: String?
    @objc var Score: Int = 0
    @objc var State: String?
}
