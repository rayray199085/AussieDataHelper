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
        SCNetworkManager.shared.getABNData(type: type, lookupCode: code) { (data, isSuccess) in
            if !isSuccess{
                completion(false)
                return
            }
            guard let data = data,
                  let lookupData = try? JSONDecoder().decode(SCLookupData.self, from: data) else{
                completion(false)
                return
            }
            
            self.lookupData = lookupData
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
            self.prevSearchName = name
            self.prevSearchNameMaxCount = maxResultCount
            for nameItem in data.Names ?? []{
                guard let name = nameItem.Name else{
                    continue
                }
                nameItem.height = self.updateRowHeight(name: name)
            }
            self.nameSearchData = data
            completion(isSuccess)
        }
    }
    func resetPrevSearchRecord(){
        prevSearchName?.removeAll()
        prevSearchNameMaxCount = 10
    }
    
    func updateRowHeight(name: String)->CGFloat{
        print(name)
        let margin: CGFloat = 3
        let labelWidth: CGFloat = 90
        let labelHeight: CGFloat = 17
        var height = (margin + labelHeight) * 7
        let viewSize = CGSize(width: UIScreen.main.bounds.width - 2 * margin - labelWidth, height: CGFloat(MAXFLOAT))
        height += margin
        height += NSAttributedString(string: name, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)])
            .boundingRect(with: viewSize, options: [.usesLineFragmentOrigin], context: nil)
            .height
        height += margin * 4
        return height
    }
}
