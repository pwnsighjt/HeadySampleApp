//
//  HeadySampleApp
//
//  Created by mac on 19/05/18.
//  Copyright © 2018 Heady. All rights reserved.
//

import Foundation
import UIKit

class AuthJob: BaseJob {
    

    var authSuccess:((Any?) -> Void)?
    var authFailure:((Any?) -> Void)?
    
    init(authSuccess:((Any?) -> Void)?,authFailure:((Any?) -> Void)?) {
        self.authSuccess = authSuccess
        self.authFailure = authFailure
    }

    override func main() {
        let commonApi = CommonApi()
        commonApi.getProductList(onSuccess: { (response) -> Void in
            print(response)
            self.authSuccess!(response)
        }) { (error) -> Void in
            print(error)
            self.authFailure!(error)
        }
      
    }
}
