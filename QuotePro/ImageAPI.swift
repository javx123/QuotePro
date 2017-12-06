//
//  LoremPixelAPI.swift
//  QuotePro
//
//  Created by Javier Xing on 2017-12-06.
//  Copyright © 2017 Javier Xing. All rights reserved.
//

import UIKit

class ImageAPI {
    
    class func generateImage(completion:@escaping (_ photo: Photo) -> Void){
        let imageURL = URL(string: "http://lorempixel.com/300/200")!

        
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
            let image : UIImage =  UIImage(data: data!)!
            let photo = Photo(image: image)
            
            completion(photo)

        }
        
        task.resume()
        session.finishTasksAndInvalidate()
    }
    
    
}

