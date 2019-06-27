//
//  SCNetworkManager+extension.swift
//  WowLittleHelper
//
//  Created by Stephen Cao on 15/5/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import Foundation
import Alamofire
import SVProgressHUD

enum SCLookupType {
    case ABN
    case ACN
}
extension SCNetworkManager{
    func getABNData(type: SCLookupType, lookupCode: String, completion: @escaping (_ dict: [String: Any]?,_ isSuccess: Bool)->()){
        var urlString: String
        var params = [String: Any]()
        if type == .ABN{
            urlString = "https://abr.business.gov.au/json/AbnDetails.aspx"
            params["abn"] = lookupCode
        }else{
            urlString = "https://abr.business.gov.au/json/AcnDetails.aspx"
            params["acn"] = lookupCode
        }
        params["callback"] = "callback"
        params["guid"] = HelperCommon.ABNGUID
        requestForResponseString(urlString: urlString, method: HTTPMethod.get, params: params) { (res, isSuccess, _, _) in
            guard var res = res as? String else{
                completion(nil, false)
                return
            }
            if res.hasPrefix("callback(") && res.hasSuffix(")"){
                res.removeFirst("callback(".count)
                res.removeLast()
            }
            guard let data = res.data(using: String.Encoding.utf8),
                let dict = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else{
                    completion(nil, false)
                return
            }
            completion(dict, isSuccess)
        }
    }
}


