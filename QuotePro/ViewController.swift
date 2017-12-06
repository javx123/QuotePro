//
//  ViewController.swift
//  QuotePro
//
//  Created by Javier Xing on 2017-12-06.
//  Copyright © 2017 Javier Xing. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        generateImage(self)
        generateQuote(self)

}
    
    @IBAction func generateQuote(_ sender: Any) {
        ForismaticAPI.getRandQuote { (quote, author) in
            OperationQueue.main.addOperation {
                self.authorLabel.text = author
                self.quoteLabel.text = quote
            }
        }
    }
    
    
    @IBAction func generateImage(_ sender: Any) {
        LoremPixelAPI.generateImage { (image) in
            OperationQueue.main.addOperation {
                self.imageView.image = image
            }
        }
    }
    
    
    

}
