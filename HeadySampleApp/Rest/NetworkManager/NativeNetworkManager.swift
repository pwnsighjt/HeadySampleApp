//
//  HeadySampleApp
//
//  Created by mac on 19/05/18.
//  Copyright © 2018 Heady. All rights reserved.
//

import Foundation
import UIKit
import AFNetworking

class NativeNetworkManager:NSObject{
    static let sharedInstance = NativeNetworkManager()
    var accessToken: String?

    func GET(urlString:String, parameters:AnyObject?, headers:AnyObject?, responseType:RESPONSE_HANDLER_TYPE,success: ((Any?) -> Void)?, failure: ((Any?) -> Void)?) -> Void {
        if( AFNetworkReachabilityManager.shared().isReachable){
            let request = NSMutableURLRequest(url: NSURL(string: urlString)! as URL)
            request.httpMethod = "GET"
            if(parameters != nil){
                let postString = BaseApp.sharedInstance.convertDicToStr((parameters as? NSDictionary)!)
                request.httpBody = postString.data(using: String.Encoding.utf8)
            }
            if(headers != nil){
                if let jsonResult = headers as? Dictionary<String, AnyObject> {
                    for (key,_) in jsonResult{
                        if let value = jsonResult[key] as? String {
                            request.setValue(value, forHTTPHeaderField: key)
                        }
                    }
                }
            }
            
            let sessionManager = getSessionManager(responseType: responseType)

            
            sessionManager?.get(urlString, parameters: parameters, progress: nil, success: { (dataTask, response) in
                    success!(response)
            }, failure: { (dataTask, error) in
                    failure!(error)
            })
            
        }else{
            //no connection
        }
    }
        
    func getSessionManager(responseType: RESPONSE_HANDLER_TYPE) ->AFHTTPSessionManager?{
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 300 // 5 min request timeout
        
        let sessionManager = AFHTTPSessionManager(sessionConfiguration: config)
        if(responseType == RESPONSE_HANDLER_TYPE.XML_RESPONSE_HANDLER){
            // handle here xml type response
            let serializer = AFXMLParserResponseSerializer()
            serializer.acceptableContentTypes = ["text/plain","text/html"]
            sessionManager.responseSerializer = serializer
        }else{
            // handle json type response
            let serializer = AFJSONResponseSerializer()
            serializer.acceptableContentTypes = ["application/json","application/soap+xml; charset=utf-8", "text/json", "text/javascript", "application/json-rpc", "text/plain", "text/html"]
            sessionManager.responseSerializer = serializer
            sessionManager.requestSerializer = AFJSONRequestSerializer()
        }
        return sessionManager
    }
}
