//
//  BaseAPI.swift
//

import UIKit
import Alamofire
import SystemConfiguration

// Create block handler type
typealias CompletionHandler = (result: AnyObject?, success: Bool) -> Void

class BaseAPI: NSObject {
	
	// MARK: - API Call
    
    // Execute with all parametars
    static func plainExecute(method: HTTPMethod, encoding: ParameterEncoding, service: String?, urlParams:  String?, body: [String : AnyObject]?, header: [String : String]?, completion: CompletionHandler) {
        execute(method, encoding: encoding, service: service, urlParams: urlParams, body: body, header: header, completion: completion)
    }
    
    // Execute GET
    static func getExecute(service: String?, urlParams: String? = nil, header: [String : String]? = nil, completion: CompletionHandler) {
        execute(.GET, encoding: .URL, service: service, urlParams: urlParams, body: nil, header: header, completion: completion)
    }
    
    // Execute POST
    static func postExecute(encoding: ParameterEncoding, service: String?, urlParams:  String? = nil, body: [String : AnyObject]?, header: [String : String]?, completion: CompletionHandler) {
        execute(.POST, encoding: encoding, service: service, urlParams: urlParams, body: body, header: header, completion: completion)
    }
    
    // Execute API call
    private static func execute(method: HTTPMethod, encoding: ParameterEncoding, service: String?, urlParams:  String?, body: [String : AnyObject]?, header: [String : String]?, completion: CompletionHandler) {
        
        // Check for internet connection
        if !isConnectedToNetwork() {
            completion(result: nil, success: false)
            return
        }
        
        // Create URL
        let url = String(format: "%@%@%@", APIConstant.BASE_URL, service ?? "", urlParams ?? "")
        
        // Select http method
        var httpMethod = Method.GET
        switch method {
            case .OPTIONS:  httpMethod = Method.OPTIONS
            case .GET:      httpMethod = Method.GET
            case .HEAD:     httpMethod = Method.HEAD
            case .POST:     httpMethod = Method.POST
            case .PUT:      httpMethod = Method.PUT
            case .PATCH:    httpMethod = Method.PATCH
            case .DELETE:   httpMethod = Method.DELETE
            case .TRACE:    httpMethod = Method.TRACE
            case .CONNECT:  httpMethod = Method.CONNECT
        }
        
        // Alamofire async request
        Alamofire.request(httpMethod, url, parameters: body, encoding: encoding, headers: header).responseJSON { (response) -> Void in
            switch response.result {
                case .Success(let JSON):  completion(result: JSON,  success: true)
                case .Failure(let error): completion(result: error, success: false)
            }
        }
    }
	
	// MARK: - Downloading
	
    // Download file
    static func downloadFile(url: String) {
        
        // Encode and get the URL
        let encodedURL = url.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        let fileURL = NSURL(string: encodedURL)!
        
        // Document folder URL
        let documentsUrl =  NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first! as NSURL
        
        // Destination file url
        let destinationUrl = documentsUrl.URLByAppendingPathComponent(fileURL.lastPathComponent!)
        
        // Check if file is already downloaded
        if NSFileManager().fileExistsAtPath(destinationUrl.path!) {
			
            
        // The file is not downloaded
        } else {
            
            // Set data from URL
            if let dataFromUrl = NSData(contentsOfURL: fileURL) {
                
                // Success saving data locally
                if dataFromUrl.writeToURL(destinationUrl, atomically: true) {
                    print("File saved")
                    
                // Failed saving data
                } else {
                    print("Error saving data")
                }
            }
        }
    }
	
    // MARK: - Internet Checker
    
	// Check interner connection
	static func isConnectedToNetwork() -> Bool {
		var zeroAddress = sockaddr_in()
		zeroAddress.sin_len = UInt8(sizeofValue(zeroAddress))
		zeroAddress.sin_family = sa_family_t(AF_INET)
		let defaultRouteReachability = withUnsafePointer(&zeroAddress) {
			SCNetworkReachabilityCreateWithAddress(nil, UnsafePointer($0))
		}
		var flags = SCNetworkReachabilityFlags.ConnectionAutomatic
		if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
			return false
		}
		let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
		let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
		return (isReachable && !needsConnection)
	}
}