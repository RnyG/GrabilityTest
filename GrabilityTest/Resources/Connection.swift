//
//  Connection.swift
//  GrabilityTest
//
//  Created by Rhonny Gonzalez on 9/5/18.
//  Copyright © 2018 Rhonny Gonzalez. All rights reserved.
//

import UIKit

protocol ConnectDelegate {
    
    func successConnect(Data:[String : Any])
    func badConnect(Data:[String : Any])
    
}

class ConnectionClass: NSObject, NSURLConnectionDelegate {
    
    var session : URLSession?
    
    var delegate : ConnectDelegate?
    
    func create(Request: NSMutableURLRequest,Screen:String) {
        // set up the session
        let config = URLSessionConfiguration.default
        
        session = URLSession(configuration: config)
        
        guard let session = session else {
            return
        }
        
        // make the request
        let task = session.dataTask(with: Request  as URLRequest) {
            (data, response, error) in
            // check for any errors
            guard error == nil else {
                print(error as Any)
                self.delegate?.badConnect(Data: ["Error":error as Any,"Screen":Screen])
                return
            }
            
            // make sure we got data
            guard let responseData = data else {
                print("Error: did not receive data")
                self.delegate?.badConnect(Data: ["Error":"Did not receive data","Screen":Screen])
                return
            }
            
            let codeConnect = (response as! HTTPURLResponse).statusCode
            
            
            // parse the result as JSON, since that's what the API provides
            do {
                
                guard let dataFromServer = try JSONSerialization.jsonObject(with: responseData, options: .allowFragments) as? NSDictionary  else {
                    
                    self.delegate?.badConnect(Data: ["Code":codeConnect,"Error":"Did not receive data","Screen":Screen])
                    
                    return
                }
                
                if codeConnect != 200 {
                    
                    
                    self.delegate?.badConnect(Data: ["Code":codeConnect,"Result":dataFromServer,"Screen":Screen])
                    return
                }
                
                
                self.delegate?.successConnect(Data: ["Code":codeConnect,"Result":dataFromServer,"Screen":Screen])
                
            } catch  {
                
                print("error trying to convert data to JSON")
                self.delegate?.badConnect(Data: ["Code":codeConnect,"Error": "Error trying to convert data to JSON","Screen":Screen])
                return
            }
        }
        
        task.resume()
    }
}

extension ConnectionClass{
    
    
    func request1(bodyParams : [String : String],
                  url: String,
                  httpMeth : String,
                  isFromUrl : Bool,
                  headers : [String : String],
                  isObject : Bool) -> NSMutableURLRequest {
        
        let url:NSURL = NSURL(string:url)!
        
        let request = NSMutableURLRequest(url: url as URL)
        
        request.httpMethod = httpMeth
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        
        if !isFromUrl{
            
            
            if isObject{
                
                do {
                    
                    let data = try JSONSerialization.data(withJSONObject: bodyParams, options:[])
                    request.httpBody = data
                    
                } catch {
                    
                    print("JSON serialization failed:  \(error)")
                    
                }
                
            }else{
                
                let params = bodyParams as Dictionary<String, String>
                
                var bodyData = ""
                
                for (key,value) in params{
                    let scapedKey = key.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
                    let scapedValue = value.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
                    bodyData += "\(scapedKey)=\(scapedValue)&"
                }
                
                request.httpBody = bodyData.data(using: String.Encoding.utf8, allowLossyConversion: true)
            }
        }
        
        for (key,value) in headers{
            
            request.addValue("\(value)", forHTTPHeaderField: "\(key)")
            
        }
        
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return request
    }
    
    
}
