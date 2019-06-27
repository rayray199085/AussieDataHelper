//
//  SCABNLookupViewModel.swift
//  AussieDataHelper
//
//  Created by Stephen Cao on 26/6/19.
//  Copyright © 2019 Stephencao Cao. All rights reserved.
//

import UIKit

class SCABNLookupViewModel: NSObject {
    var lookupData: SCLookupData?
    
    func loadABNData(type: SCLookupType, code: String ,completion: @escaping (_ isSuccess: Bool)->()){
        SCNetworkManager.shared.getABNData(type: type, lookupCode: code) { (dict, isSuccess) in
            if !isSuccess{
                completion(false)
                return
            }
            guard let dict = dict,
                  let data = SCLookupData.yy_model(with: dict) else{
                completion(false)
                return
            }
            self.lookupData = data
            completion(isSuccess)
        }
    }
}
