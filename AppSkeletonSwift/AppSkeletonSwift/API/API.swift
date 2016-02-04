//
//  API.swift
//

import UIKit

class API: BaseAPI {
    
    // Example GET
    static func exampleGet(completion: CompletionHandler) {
        
        // Configure header
        let header = [String : String]()
        
        // Execute API call
        getExecute(APIConstant.SERVICE_EXAMPLE, urlParams: nil, header: header, completion: completion)
        
        // Or execute with default parametars
        getExecute(APIConstant.SERVICE_EXAMPLE, completion: completion)
    }
    
    // Example POST
    static func examplePost(urlParams: String?, body: [String : AnyObject]?, completion: CompletionHandler) {
        
        // Configure header
        let header = [String : String]()

        // Execute API call
        postExecute(.URL, service: APIConstant.SERVICE_EXAMPLE, body: body, header: header, completion: completion)
        
        /*
        Or execute with url parametars
        URL params example (Some sort of ID)
        */
        postExecute(.URL, service: APIConstant.SERVICE_EXAMPLE, urlParams: urlParams, body: body, header: header, completion: completion)
    }
}