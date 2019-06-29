//
//  SCANZSICViewModel.swift
//  AussieDataHelper
//
//  Created by Stephen Cao on 28/6/19.
//  Copyright © 2019 Stephencao Cao. All rights reserved.
//

import Foundation

class SCANZSICViewModel{
    var anzsicCodeArray: [SCANZSICData]?
    var prevKeywords: String?
    
    func loadANZSICSearchResult(keywords: String?, completion:@escaping (_ isSuccess: Bool)->()){
        guard let keywords = keywords else{
            completion(false)
            return
        }
        SCNetworkManager.shared.getANZSICSearchResult(keywords: keywords) { (array, isSuccess) in
            if !isSuccess{
                completion(false)
                return
            }
            guard let array = array,
                  let group = NSArray.yy_modelArray(with: SCANZSICData.self, json: array) as? [SCANZSICData] else{
                completion(false)
                return
            }
            self.anzsicCodeArray = group
            self.prevKeywords = keywords
            completion(true)
        }
    }
}
