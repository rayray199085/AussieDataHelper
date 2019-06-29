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
    var nameSearchData: SCNameSearchData?
    
    var prevSearchName: String?
    var prevSearchNameMaxCount: Int = 10
    
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
    func loadNameSearchResult(name: String?, maxResultCount: Int, completion:@escaping (_ isSuccess: Bool)->()){
        guard let name = name else{
            completion(false)
            return 
        }
        SCNetworkManager.shared.getNameSearchResult(name: name, maxCount: maxResultCount) { (dict, isSuccess) in
            if !isSuccess{
                completion(false)
                return
            }
            guard let dict = dict,
                let data = SCNameSearchData.yy_model(with: dict) else{
                    completion(false)
                    return
            }
            self.nameSearchData = data
            self.prevSearchName = name
            self.prevSearchNameMaxCount = maxResultCount
            completion(isSuccess)
        }
    }
    func resetPrevSearchRecord(){
        prevSearchName?.removeAll()
        prevSearchNameMaxCount = 10
    }
}
