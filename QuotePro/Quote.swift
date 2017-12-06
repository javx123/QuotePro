//
//  Quote.swift
//  QuotePro
//
//  Created by Javier Xing on 2017-12-06.
//  Copyright © 2017 Javier Xing. All rights reserved.
//

import Foundation

class Quote{
    var entryPhoto: Photo?
    var quote: String
    var author: String
    
    init(quote: String, author: String) {
        self.quote = quote
        self.author = author
    }
    
}

