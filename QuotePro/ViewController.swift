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
    var quoteView: QuoteView?
    
    weak var delegate: AddEntryProtocol?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.isToolbarHidden = false
        
        
        generateImage()
        generateQuote()
        
            if let objects = Bundle.main.loadNibNamed("QuoteView", owner: nil, options: [:]){
                quoteView = objects.first as? QuoteView
                self.view.addSubview(quoteView!)
        }
        quoteView?.translatesAutoresizingMaskIntoConstraints = false

        quoteView?.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        quoteView?.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        quoteView?.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        quoteView?.heightAnchor.constraint(equalTo: view.heightAnchor, constant: 0).isActive = true
        
}
    
    override func viewWillAppear(_ animated: Bool) {
        let randImageButton = UIBarButtonItem(title: "Random Image", style: UIBarButtonItemStyle.plain, target: self, action: #selector(generateImage))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        
        let randQuoteButton = UIBarButtonItem(title: "Random Quote", style: UIBarButtonItemStyle.plain, target: self, action: #selector(generateQuote))
    
        self.toolbarItems = [randQuoteButton, flexibleSpace, randImageButton]
    }
    
    @objc func generateQuote() {
        QuoteAPI.getRandQuote { (quote) in
            OperationQueue.main.addOperation {
                self.currentQuote = quote
                self.currentQuote?.entryPhoto? = self.currentPhoto!
                self.refreshQuoteView()
            }
        }
    }

    @objc func generateImage() {
        ImageAPI.generateImage { (photo) in
            OperationQueue.main.addOperation {
                self.quoteView?.quoteImage.image = photo.image
                self.currentPhoto = photo
                
            }
        }
    }
    
    func refreshQuoteView(){
        self.currentQuote?.entryPhoto = self.currentPhoto
        self.quoteView?.setupWithQuote(quote: self.currentQuote!)
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
