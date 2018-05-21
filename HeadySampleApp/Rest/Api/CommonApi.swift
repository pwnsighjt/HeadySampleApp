//
//  HeadySampleApp
//
//  Created by mac on 19/05/18.
//  Copyright © 2018 Heady. All rights reserved.
//


import Foundation

class CommonApi: BaseApi {
       
    func getProductList(onSuccess:@escaping ((AnyObject) -> Void), onError:@escaping ((AnyObject) -> Void)){
        NativeNetworkManager.sharedInstance.GET(urlString:urlEncodedString(dict: nil, restUrl: NetworkConfigConstants.kProductList), parameters: nil, headers: getDefaultHeaders(), responseType: RESPONSE_HANDLER_TYPE.JSON_RESPONSE_HANDLER, success: { (response) in
            onSuccess(response as AnyObject)
        }) { (error) in
            onError(error as AnyObject)
        }
    }
}
