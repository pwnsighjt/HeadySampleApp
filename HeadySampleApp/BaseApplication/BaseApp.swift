//
//  HeadySampleApp
//
//  Created by mac on 19/05/18.
//  Copyright © 2018 Heady. All rights reserved.
//

import Foundation
import AFNetworking
import SwiftEventBus


class BaseApp : NSObject, UINavigationControllerDelegate {
    
    static let sharedInstance = BaseApp()
    internal static let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var jobManager:OperationQueue?
    var serverRequestInCompleteStatus:String?
    fileprivate var networkAlert:UIAlertController?


    
    //MARK: - Basic Init setup
    override init () {
        super.init()
        initJobManager()
    }
    
    func initJobManager() {
        jobManager = OperationQueue()
        jobManager?.maxConcurrentOperationCount = 50
        jobManager?.qualityOfService = QualityOfService.background
        
        AFNetworkReachabilityManager.shared().startMonitoring()
        SwiftEventBus.onMainThread(self, name: NSNotification.Name.AFNetworkingReachabilityDidChange.rawValue, handler: handleNetworkChangeEvent)
    }
    
    //MARK:- Check Network status
    func getNetworkStatus(_ notification: Foundation.Notification? = nil) -> Bool{
        var isConnected = false
        if(notification != nil){
            let status = notification!.userInfo!["AFNetworkingReachabilityNotificationStatusItem"] as? Int
            let testStatus = AFNetworkReachabilityStatus(rawValue: status!)
            if(testStatus == AFNetworkReachabilityStatus.unknown || testStatus == AFNetworkReachabilityStatus.notReachable){
                isConnected = false
            }else if(testStatus == AFNetworkReachabilityStatus.reachableViaWWAN || testStatus == AFNetworkReachabilityStatus.reachableViaWiFi){
                isConnected = true
            }
        }else  if( AFNetworkReachabilityManager.shared().isReachable){
            isConnected = true
        }
        return isConnected
    }
    
    // MARK:- Eventbus event handler
    func handleNetworkChangeEvent(_ notification: Foundation.Notification!) -> Void{
        let isConnected = self.getNetworkStatus(notification)
        if(isConnected){
            if(jobManager?.operations != nil && (jobManager?.operations.count)! > 0){
                jobManager?.cancelAllOperations()
            }
        }else{
//            showNetworkErrorAlert(getMessageForCode("dialog_no_network_reason", fileName: "Strings")!)
//            
//            hideActivityIndicator()
        }
    }
    
    
    //MARK: - Get Application current Build number
    func getApplicationVersion() -> String {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
    }
    
    func getApplicationBuildNumberStr() -> String {
        return Bundle.main.infoDictionary?["CFBundleVersion"] as! String
    }
    
    func convertDicToStr(_ dict: NSDictionary) -> String{
        do{
            if let data = try JSONSerialization.data(withJSONObject: dict, options: []) as? Data {
                if let json = NSString(data: data, encoding: String.Encoding.utf8.rawValue) {
                    return json as String
                }
            }
        } catch let error as NSError {
            AppConstant.klogString(error.localizedDescription)
        }
        
        return ""
    }
    
    
    
  
    
    //MARK:- Show network alert
    func showNetworkErrorAlert(_ errorMsg:String){
        let errorTitle = getMessageForCode("dialog_no_network_title", fileName: "Strings")
        if(networkAlert == nil){
            networkAlert = UIAlertController(title:errorTitle, message: errorMsg, preferredStyle: UIAlertControllerStyle.alert)
            AppConstant().appDelegate.window!.rootViewController!.present(networkAlert!, animated: true, completion: nil)
        }
    }
    
    //MARK:- load value from string file
    func getMessageForCode(_ constantName:String, fileName:String) -> String? {
        return NSLocalizedString(constantName, tableName: fileName, bundle: Bundle.main, value: "", comment: "")
    }
 
   
   
    //MARK:- check network releated error
    func IsCodeInNetworkError(_ code:Int)-> Bool{
        var isFound = false
        switch code {
        case Int(CFNetworkErrors.cfurlErrorNotConnectedToInternet.rawValue):
            isFound = true
            break
        case Int(CFNetworkErrors.cfurlErrorTimedOut.rawValue):
            isFound = true
            break
        case Int(CFNetworkErrors.cfurlErrorCancelled.rawValue):
            isFound = true
            break
        case Int(CFNetworkErrors.cfurlErrorNetworkConnectionLost.rawValue):
            isFound = true
            break
        case Int(CFNetworkErrors.cfurlErrorBadServerResponse.rawValue):
            isFound = true
            break
        case Int(CFNetworkErrors.cfurlErrorUserAuthenticationRequired.rawValue):
            isFound = true
            break
        case Int(CFNetworkErrors.cfurlErrorUserCancelledAuthentication.rawValue):
            isFound = true
            break
        case Int(CFNetworkErrors.cfurlErrorDataNotAllowed.rawValue):
            isFound = true
            break
        case Int(CFNetworkErrors.cfErrorHTTPAuthenticationTypeUnsupported.rawValue):
            isFound = true
            break
        case Int(CFNetworkErrors.cfErrorHTTPBadCredentials.rawValue):
            isFound = true
            break
        case Int(CFNetworkErrors.cfErrorHTTPConnectionLost.rawValue):
            isFound = true
            break
        case Int(CFNetworkErrors.cfErrorHTTPBadURL.rawValue):
            isFound = true
            break
        case Int(EPERM):        //       1      / Operation not permitted
            isFound = true
            break
        case Int(ENOENT):       //       2      / No such file or directory
            isFound = true
            break
        case Int(ESRCH):        //       3      / No such process
            isFound = true
            break
        case Int(EINTR):        //       4      / Interrupted system call
            isFound = true
            break
        case Int(EIO):          //       5      / Input/output error
            isFound = true
            break
        case Int(ENXIO):        //       6      / Device not configured /
            isFound = true
            break
        case Int(E2BIG):        //       7      / Argument list too long /
            isFound = true
            break
        case Int(ENOEXEC):      //      8       / Exec format error /
            isFound = true
            break
        case Int(EBADF):        //      9       /Bad file descriptor
            isFound = true
            break
        case Int(ECHILD):       //      10      / No child processes /
            isFound = true
            break
        case Int(EDEADLK):      //      11      / Resource deadlock avoided // 11 was EAGAIN /
            isFound = true
            break
        case Int(ENOMEM):       //      12      / Cannot allocate memory /
            isFound = true
            break
        case Int(EACCES):       //      13      / Permission denied /
            isFound = true
            break
        case Int(EFAULT):       //      14      / Bad address #H
            isFound = true
            break
        default:
            isFound = false
            break
        }
        return isFound
    }
    
    func isNullValue(_ value: AnyObject?) -> Bool{
        var nullValue: Bool = false
        //if (value!.isKind(of: NSNull) || value!.isEqual(to: "null")) {
        if value! is NSNull || value!.isEqual(to: "null"){
            nullValue = true
        }
        return nullValue
    }
    
    func removeOptionalString(_ convertText:String) -> String{
        
        var convertedString = convertText
        convertedString = convertedString.replacingOccurrences(of: "Optional(", with: "")
        convertedString = convertedString.replacingOccurrences(of: ")", with: "")
        
        return convertedString
    }
  }
