//
//  QuoteView.swift
//  QuotePro
//
//  Created by Javier Xing on 2017-12-06.
//  Copyright © 2017 Javier Xing. All rights reserved.
//

import UIKit

class QuoteView: UIView {
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var quoteImage: UIImageView!
    
    func setupWithQuote(quote: Quote){
        quoteLabel.text = quote.quote
        authorLabel.text = quote.author
        quoteImage.image = quote.entryPhoto?.image
    }

}
