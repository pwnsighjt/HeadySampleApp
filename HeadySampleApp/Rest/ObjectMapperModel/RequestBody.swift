//
//  HeadySampleApp
//
//  Created by mac on 19/05/18.
//  Copyright © 2018 Heady. All rights reserved.
//

import Foundation
import ObjectMapper

class RequestBody {
    
    class ClientInfo:Mappable {
        var phone = ""
        var activationCode = ""
        //        var device = DeviceInfo //TODO:- Need to implement func for Device info
        //        var sim = SimInfo //TODO:- Need to implement func for Sim info
        var referrerId = ""
        var referrerCode = ""
        var appVersion = ""
        
        
        init(){
            
        }
        // Convert Json string to class object
        func getObjectFromString(jsonString: String)->ClientInfo{
            var clientInfo:ClientInfo?
            let data = jsonString.data(using: String.Encoding.utf8)!
            do {
                if let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? NSDictionary {
                    let mapper = Mapper<ClientInfo>()
                    if let testObject = mapper.map(JSON: jsonResult as! [String : Any]){
                        clientInfo = testObject
                    }
                }
            } catch let error as NSError {
                AppConstant.kLogString(error.localizedDescription)
            }
            return clientInfo!
        }
        
        required init?(map: Map){
        }
        
        func mapping(map: Map){
            phone               <- map["phone"]
            activationCode      <- map["activationCode"]
            referrerId          <- map["referrerId"]
            referrerCode        <- map["referrerCode"]
            appVersion          <- map["appVersion"]
        }
    }
}

