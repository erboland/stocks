//
//  MainTableViewController.swift
//  stocks
//
//  Created by Ербол Каршыга on 4/18/17.
//  Copyright © 2017 Octopus. All rights reserved.
//

import UIKit

class MyStocksTableViewController: UITableViewController, TimeRangeControlDelegate{

    var stocks = [
        "GOOG",
        "AAPL",
        "TSLA",
        "YNDX",
        "YHOO"
    ]
    
    var lineGraphView: LineGraphView!
    var timeRangeControl: TimeRangeControl!
    var stockPriceView: StockPriceView!
    
    var companyName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationController?.navigationBar.barTintColor = UIColor(hex: StockEnum.mainColor.rawValue)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.backIndicatorImage = UIImage()
        
        let screen = UIScreen.main.bounds
        
        stockPriceView = StockPriceView(frame: CGRect(x: 0, y: screen.height - 200, width: view.frame.width, height: 100))
       
        lineGraphView = LineGraphView(frame: CGRect(x: 16, y: 108, width: view.frame.width - 32, height: 200))
        lineGraphView.lineWidth = 2
        lineGraphView.lineColor = UIColor.white
        lineGraphView.backgroundColor = UIColor.clear
        
        timeRangeControl = TimeRangeControl(frame: CGRect(x: 16 , y: 350, width: view.frame.width - 32, height: 40))
        timeRangeControl.delegate = self
        
        let wrapperView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: UIScreen.main.bounds.height - 64))
        
        wrapperView.backgroundColor = UIColor(hex: StockEnum.mainColor.rawValue)
        wrapperView.addSubview(stockPriceView)
        wrapperView.addSubview(lineGraphView)
        wrapperView.addSubview(timeRangeControl)
        
        
        Socket().onStocksOf("GOOGL") { data in
            print(data)
        }
        
        lineGraphView.showStocksFor(.today, symbol: "GOOGL")
        
        tableView.tableHeaderView = wrapperView
        
    }

    
    func selectedChanged(range: TimeRangeEnum) {
        self.lineGraphView.showStocksFor(range, symbol: "GOOGL")
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stocks.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Stock", for: indexPath) as? StockTableViewCell else {
            fatalError("stocksix")
        }
        
        cell.symbol = stocks[indexPath.row]
        cell.sharesLabel.text = "Акций \(indexPath.row)"
        cell.growthLabel.text = "\(indexPath.row)"

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print(stocks[indexPath.row])
        
        companyName = stocks[indexPath.row]
        self.performSegue(withIdentifier: "toCompany", sender: self)
    }
    
     //MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toCompany" {
            let des = segue.destination as! UINavigationController
            let controller = des.topViewController as! CompanyTableViewController
            
            print(companyName,123)
            
            controller.name = companyName
        }
        
    }
    

}

struct Stock {
    var stockName: String!
    var shares: Int!
    var growth: Int!
}
