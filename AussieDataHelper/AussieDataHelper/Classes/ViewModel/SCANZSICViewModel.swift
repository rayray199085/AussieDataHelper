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
            for data in group{
                guard let text = data.unparsedText else{
                    continue
                }
                data.height = self.updateRowHeight(name: text)
            }
            self.anzsicCodeArray = group
            self.prevKeywords = keywords
            completion(true)
        }
    }
    func updateRowHeight(name: String)->CGFloat{
        let margin: CGFloat = 3
        let labelHeight: CGFloat = 17
        var height = (margin + labelHeight) * 3
        let viewSize = CGSize(width: UIScreen.main.bounds.width - 2 * margin, height: CGFloat(MAXFLOAT))
        height += margin
        height += NSAttributedString(string: name, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)])
            .boundingRect(with: viewSize, options: [.usesLineFragmentOrigin], context: nil)
            .height
        height += margin * 3
        return height
    }
}
