//
//  ViewController.swift
//  QuotePro
//
//  Created by Javier Xing on 2017-12-06.
//  Copyright © 2017 Javier Xing. All rights reserved.
//

import UIKit

protocol AddEntryProtocol: class {
    func saveEntry(quote: Quote)
}

class ViewController: UIViewController {

    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    var currentQuote: Quote?
    var currentPhoto: Photo?
    
    weak var delegate: AddEntryProtocol?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationController?.navigationBar.isTranslucent = false
        
        generateImage(self)
        generateQuote(self)

}
    
    @IBAction func generateQuote(_ sender: Any) {
        QuoteAPI.getRandQuote { (quote) in
            OperationQueue.main.addOperation {
                self.authorLabel.text = quote.author
                self.quoteLabel.text = quote.quote
                self.currentQuote = quote
            }
        }
    }
    
    
    @IBAction func generateImage(_ sender: Any) {
        ImageAPI.generateImage { (photo) in
            OperationQueue.main.addOperation {
                self.imageView.image = photo.image
                self.currentPhoto = photo
            }
        }
    }
    
    @IBAction func saveQuoteAndImage(_ sender: Any) {
        currentQuote?.entryPhoto = currentPhoto
        
        delegate?.saveEntry(quote: currentQuote!)
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func cancelEntry(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    

}
