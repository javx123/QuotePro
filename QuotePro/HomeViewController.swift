//
//  HomeViewController.swift
//  QuotePro
//
//  Created by Javier Xing on 2017-12-06.
//  Copyright © 2017 Javier Xing. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, AddEntryProtocol {
    @IBOutlet weak var tableView: UITableView!
    var savedEntries:[Quote] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
//    Mark: TableView Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return savedEntries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier:String = "entryCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? SavedEntryTableViewCell
            else{
                fatalError("The dequeued cell is not an instance of NewsTableViewCell.")
        }
        let savedEntry = savedEntries[indexPath.row]
        
        cell.quoteImage.image = savedEntry.entryPhoto?.image
        cell.quoteLabel.text = savedEntry.quote
        cell.authorLabel.text = savedEntry.author
        
        return cell

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140.0
    }
    
//    Mark: Custom Protocol
    func saveEntry(quote: Quote) {
        savedEntries.append(quote)
        
        let indexPath = IndexPath(row: (savedEntries.count - 1), section: 0)
        tableView.insertRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
    }
    
    
//    Mark: Segue Method
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addEntry" {
            let navController  = segue.destination as? UINavigationController
            let controller = navController?.viewControllers.first as? ViewController
            controller?.delegate = self
        }
    }
    

//    Mark: Share Online 
    @IBAction func sendQuoteOnline(_ sender: UITapGestureRecognizer) {
        print("Share Quote")
        
        guard let indexPath = self.tableView.indexPathForRow(at: sender.location(in: self.tableView))
            else{return}
        let selectedQuote = savedEntries[indexPath.row]
        
        if let objects = Bundle.main.loadNibNamed("QuoteView", owner: nil, options: [:]){
            let quoteView = objects.first as? QuoteView

            quoteView?.frame = self.tableView.frame

            
            quoteView?.setupWithQuote(quote: selectedQuote)
            
            let image = self.snapShot(view: quoteView!)
            
            let shareVC: UIActivityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
            
            self.present(shareVC, animated: true, completion: nil)
            
        }
    }

    
//    Mark: Image from View
    func snapShot(view:UIView) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, true, 0)
        view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }

}
