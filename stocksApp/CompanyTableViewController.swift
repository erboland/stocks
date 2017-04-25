//
//  CompanyTableViewController.swift
//  stocksApp
//
//  Created by Ербол Каршыга on 4/25/17.
//  Copyright © 2017 Octopus. All rights reserved.
//

import UIKit

class CompanyTableViewController: UITableViewController, TimeRangeControlDelegate {

    let sections = [" News", " Statistics", " Orders"]
    var cell: UITableViewCell!
    
    var lineGraphView: LineGraphView!
    var timeRangeControl: TimeRangeControl!
    var stockPriceView: StockPriceView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stockPriceView = StockPriceView(frame: CGRect(x: 0, y: 8, width: view.frame.width, height: 100))
        
        lineGraphView = LineGraphView(frame: CGRect(x: 16, y: 108, width: view.frame.width - 32, height: 100))
        lineGraphView.lineWidth = 3
        lineGraphView.lineColor = UIColor.white
        lineGraphView.backgroundColor = UIColor.clear
        
        timeRangeControl = TimeRangeControl(frame: CGRect(x: 0, y: 216, width: view.frame.width, height: 40))
        timeRangeControl.delegate = self
        
        let wrapperView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 256))
        
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
       
        return 3
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sections[section]
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print(section)
        switch section {
        case 0:
            return 4
        case 1:
            return 5
        case 2:
            return 4
        default:
            fatalError("Errrooooooor")
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch indexPath.section {
        case 0:
            
            let  cell = tableView.dequeueReusableCell(withIdentifier: "News") as! NewsTableViewCell
//            cell.newsLabel.text = newsArray[indexPath.row].text
//            cell.dateLabel.text = newsArray[indexPath.row].date
            return cell
        case 1:
            let  cell = tableView.dequeueReusableCell(withIdentifier: "Stat") as! StatsTableViewCell
            switch indexPath.row {
            case 0:
                cell.firstLabel.text = "OPEN"
                cell.secondLabel.text = " VOLUME"
              
            case 1:
                cell.firstLabel.text = "HIGH"
                cell.secondLabel.text = " AVG VOl"
            case 2:
                cell.firstLabel.text = "LOW"
                cell.secondLabel.text = " MKT CAP"
            case 3:
                cell.firstLabel.text = "1Y HIGH"
                cell.secondLabel.text = " RATIO"
            default:
                cell.firstLabel.text = "1Y LOW"
                cell.secondLabel.text = " D/Y"
            }
            return cell
        case 2:
            let  cell = tableView.dequeueReusableCell(withIdentifier: "Order") as! OrdersTableViewCell
//            cell.dateLabel.text = ordersArray[indexPath.row].date
//            cell.priceLabel.text = ordersArray[indexPath.row].price
//            cell.sharesLabel.text = ordersArray[indexPath.row].shares
            return cell
        default:
            print("default")
            let cell = tableView.dequeueReusableCell(withIdentifier: "news")!
            return cell
        }

    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 70
        case 1:
            return 50
        case 2:
            return 70
        default:
            return 100
        }
    }
 
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let title = self.sections[section]
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 50))
        titleLabel.text = title
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont(name: "AvenirNext-Medium", size: 20)
        titleLabel.backgroundColor = UIColor.white
        
        return titleLabel
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
}
