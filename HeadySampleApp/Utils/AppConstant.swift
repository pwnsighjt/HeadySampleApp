//
//  HeadySampleApp
//
//  Created by mac on 19/05/18.
//  Copyright © 2018 Heady. All rights reserved.
//

import Foundation
import UIKit

class AppConstant: NSObject {
    
    internal let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    class func klogString(_ message: String,
                          function: String = #function,
                          file: String = #file,
                          line: Int = #line) {
        
        if(NetworkConfigConstants.DEFAULT_ENV != NetworkConfigConstants.Env.PRODUCTION.rawValue){
            print("Message \"\(message)\" (File: \(file), Function: \(function), Line: \(line))")
        }
    }
    
    class func kLogString(_ items: Any...){
        if(NetworkConfigConstants.DEFAULT_ENV != NetworkConfigConstants.Env.PRODUCTION.rawValue){
            print(items)
        }
    }
    
    class func klogInteger(_ logMessage: NSInteger, functionName: String = #function) {
        if(NetworkConfigConstants.DEFAULT_ENV != NetworkConfigConstants.Env.PRODUCTION.rawValue){
            print("\(functionName): \(logMessage)")
        }
    }
    class func klogNumber(_ logMessage: NSNumber, functionName: String = #function) {
        if(NetworkConfigConstants.DEFAULT_ENV != NetworkConfigConstants.Env.PRODUCTION.rawValue){
            print("\(functionName): \(logMessage)")
        }
    }
    
    class func getDeviceCurrentTimeMilliSeconds()-> CLong{
        return (CLong)(Date().timeIntervalSince1970*1000)
    }
    
    class func getDeviceCurrentTimeMilliSecondsForHttpRequest()-> CLong{
        return (CLong)(Date().timeIntervalSince1970)
    }
    
    internal static let userDefaultAppTokenKey = "APP_TOKEN_KEY"
    internal static let TimeOut = "TIMEOUT"
}
