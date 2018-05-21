//
//  HeadySampleApp
//
//  Created by mac on 19/05/18.
//  Copyright © 2018 Heady. All rights reserved.
//

import UIKit
import Foundation

class NetworkConfigConstants : NSObject{

    enum Env: String {
        case PRODUCTION = ""
        case DEVELOPMENT = "dev-"
        case QA = "qa-"
        case STAGING = "stg-"
        case TRAINING = "training-"
    }

    static let DEFAULT_ENV = Env.DEVELOPMENT.rawValue
//    static let DEFAULT_ENV = Env.PRODUCTION.rawValue

    //****************** PRODUCTION ENV *******************
    internal static let kNetworkBaseUrl = "https://stark-spire-93433.herokuapp.com"
    //****************** PRODUCTION ENV *******************
    
    internal static let kAuthorization = "Authorization"
    internal static let kGrantType = "grant_type"
    internal static let kScope = "scope"
    internal static let kClientId = "client_id"
    internal static let kRestLogin = "/auth/login"
    internal static let kRestTeam = "/teams/_self"
    internal static let kRestLogout = "/auth/logout"
    
    //API
    internal static let kProductList = "/json"
    
    
    //Param name
    internal static let kUserEmailId = "email_id"
    internal static let kUserPassword = "pass"
    internal static let kUserType = "utype"
    


    
    
 }
