//
//  SearchViewController.swift
//  stocks
//
//  Created by Ербол Каршыга on 4/21/17.
//  Copyright © 2017 Octopus. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController {

    var results = [String]() {
        didSet{
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let textField = UITextField(frame: CGRect(x: 0, y: 0, width: 300, height: 40))
        self.navigationItem.titleView = textField
        textField.backgroundColor = UIColor.red
        
        textField.addTarget(self, action: #selector(textChanged(sender:)), for: .editingChanged )
        textField.becomeFirstResponder()
        
        // Do any additional setup after loading the view.
    }
    
    func textChanged(sender: UITextField){
        
        StocksModel.searchCompany(sender.text!) { data in
            self.results = data
        }
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as! SearchTableViewCell
        
        let text = results[indexPath.row].components(separatedBy: " | ")
        
        cell.nameLabel.text = text[0]
        cell.desLabel.text = text[1]
        
        return cell
    }

}
