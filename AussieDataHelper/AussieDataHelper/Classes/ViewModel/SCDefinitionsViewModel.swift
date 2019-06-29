//
//  SCDefinitionsViewModel.swift
//  AussieDataHelper
//
//  Created by Stephen Cao on 29/6/19.
//  Copyright © 2019 Stephencao Cao. All rights reserved.
//

import Foundation

class SCDefinitionsViewModel{
    var definitionsData: SCDefinitionsData?
    var prevKeywords: String?
    
    func loadDefinitionsData(shouldPullUp: Bool, keywords: String?, currentPage: Int, completion:@escaping (_ isSuccess: Bool)->()){
        guard let keywords = keywords else{
            completion(false)
            return
        }
        SCNetworkManager.shared.getDefinitionsData(keywords: keywords, currentPage: currentPage) { (dict, isSuccess) in
            if !isSuccess{
                completion(false)
                return
            }
            guard let dict = dict,
                  let definitionsData = SCDefinitionsData.yy_model(with: dict) else{
                return
            }
            if shouldPullUp{
                self.definitionsData?.content! += definitionsData.content ?? []
            }else{
                self.definitionsData = definitionsData
                self.prevKeywords = keywords
            }
            completion(true)
        }
    }
}
