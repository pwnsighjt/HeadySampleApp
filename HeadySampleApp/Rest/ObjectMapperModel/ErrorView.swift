//
//  HeadySampleApp
//
//  Created by mac on 19/05/18.
//  Copyright © 2018 Heady. All rights reserved.
//

import Foundation

class ErrorView {
    
    var statusCode:Int?
    var type,message:String?
    
    func toString() -> String {
        let dictError:NSDictionary = ["statusCode":statusCode!,"type":type!,"message":message!]//
        let dict:NSDictionary = ["ErrorView":dictError]
        return dict.debugDescription
    }
}
