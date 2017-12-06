//
//  ForismaticAPI.swift
//  QuotePro
//
//  Created by Javier Xing on 2017-12-06.
//  Copyright © 2017 Javier Xing. All rights reserved.
//

import UIKit

class ForismaticAPI {
    
    class func getRandQuote(completion: @escaping (_ author: String,_ quote: String) -> Void) {
        var apiURL = URL(string: "http://api.forismatic.com/api/1.0/")!
        let parameters = ["method":"getQuote",
                          "format":"json",
                          "lang":"en",]
        apiURL = apiURL.appendingQueryParameters(parameters)
        
        var request = URLRequest(url: apiURL)
        request.httpMethod = "GET"
        
        let session = URLSession(configuration: URLSessionConfiguration.default , delegate: nil, delegateQueue: nil)
    
        let task = session.dataTask(with: request) { (data, response, err) in
            if (err == nil ){
                // Success
                let statusCode = (response as! HTTPURLResponse).statusCode
                print("URL Session Task Succeeded: HTTP \(statusCode)")
            }
            else{
                // Failure
                print("URL Session Task Failed: %@", err!.localizedDescription);
            }
            
//            JSON Parsing
            var json: Any?
            do{
                json = try JSONSerialization.jsonObject(with: data!)
            }
            catch{
                 print(#line, error.localizedDescription)
            }
            
            guard let quoteInfo = json as? [String: Any] else {return}
            
//            print(quoteInfo)
            let quote = quoteInfo["quoteText"] as? String
            let author = quoteInfo["quoteAuthor"] as? String
            
            completion(quote!, author!)
            
        }
        task.resume()
        session.finishTasksAndInvalidate()
    }

}


protocol URLQueryParameterStringConvertible {
    var queryParameters: String {get}
}


extension Dictionary: URLQueryParameterStringConvertible {
    var queryParameters: String {
        var parts:[String] = []
        for (key,value) in self{
            let part = String(format: "%@=%@",
                              String(describing: key).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!,
                              String(describing: value).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
            parts.append(part as String)
        }
        return parts.joined(separator: "&")
    }
}

extension URL {
    func appendingQueryParameters(_ parameterDictionary : Dictionary<String,String>) -> URL{
        let urlString: String = String(format: "%@?%@", self.absoluteString, parameterDictionary.queryParameters)
        return URL(string: urlString)!
    }
}
    
    
    
    
    
    
    

