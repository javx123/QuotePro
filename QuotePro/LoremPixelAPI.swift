//
//  LoremPixelAPI.swift
//  QuotePro
//
//  Created by Javier Xing on 2017-12-06.
//  Copyright © 2017 Javier Xing. All rights reserved.
//

import UIKit

class LoremPixelAPI {
    
    class func generateImage(completion:@escaping (_ randImagg: UIImage) -> Void){
        let imageURL = URL(string: "http://lorempixel.com/200/300")!

        
        let session = URLSession(configuration: URLSessionConfiguration.default, delegate: nil, delegateQueue: nil)
        
        let task = session.dataTask(with: imageURL) { (data, response, error) in
            
            
            if (error == nil ){
                // Success
                let statusCode = (response as! HTTPURLResponse).statusCode
                print("URL Session Task Succeeded: HTTP \(statusCode)")
            }
            else{
                // Failure
                print("URL Session Task Failed: %@", error!.localizedDescription);
            }
            
//            Image Creation
            let image =  UIImage(data: data!)
            
            completion(image!)

        }
        
        task.resume()
        session.finishTasksAndInvalidate()
    }
    
    
}

