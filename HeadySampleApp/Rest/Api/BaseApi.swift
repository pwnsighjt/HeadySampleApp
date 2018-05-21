//
//  HeadySampleApp
//
//  Created by mac on 19/05/18.
//  Copyright © 2018 Heady. All rights reserved.
//

import Foundation

class BaseApi: NSObject {
    
    func toString(object: AnyObject?) -> String?{
        return String(format: "%@", object as! NSString)
    }
    
    func urlEncode(object: AnyObject?) -> String?{
        let string: String = toString(object: object)!
        return string.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)
    }
    
    func urlEncodedString(dict: NSDictionary?, restUrl: String?, baseUrl:String? = nil) -> String{
        
        let parts: NSMutableArray = []
        if(dict != nil)
        {
            for (key,value) in dict!{
                let part = String(format: "%@=%@", urlEncode(object: key as AnyObject)!,urlEncode(object: value as AnyObject)!)
                parts.add(part)
            }
        }
        
        let queryString: NSString = (parts.componentsJoined(by: "&") as NSString)
        var urlString: NSString = ""
        
        if(baseUrl != nil){
            if(queryString.length > 0){
                urlString = NSString(format: "%@%@?%@",baseUrl!,restUrl!,queryString )
            }
            else{
                urlString = NSString(format: "%@%@",baseUrl!,restUrl! )
            }
        }else{
            if(queryString.length > 0){
                urlString = NSString(format: "%@%@?%@",NetworkConfigConstants.kNetworkBaseUrl,restUrl!,queryString )
            }
            else{
                urlString = NSString(format: "%@%@",NetworkConfigConstants.kNetworkBaseUrl,restUrl! )
            }
        }
        return  urlString as String
    }
    
    func getDefaultHeaders() -> NSDictionary{
        let headers: NSMutableDictionary = ["Content-Type":"application/json","Accept":"application/json","x-request-os":"ios"]
//        if let accessToken: NSString? = NetworkManager.sharedInstance.accessToken as! NSString {
//            let value: NSString = NSString(format: "bearer %@",accessToken!)
//            headers.setValue(value, forKey: NetworkConfigConstants.kAuthorization)
//        }
        return headers;
    }
}
