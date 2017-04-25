//
//  ViewController.swift
//  stocks
//
//  Created by Robert Kim on 4/18/17.
//  Copyright © 2017 Octopus. All rights reserved.
//

import UIKit

class CompanyViewController: UIViewController, UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var containerView: UIView!
    var priceLabel: UILabel!
    var sharesLabel: UILabel!
    var graphicView: UIView!
    var newsTableView: UITableView!
    var statsTableView: UITableView!
    var ordersTableView: UITableView!
    var mainScrollView: UIScrollView!
    var ordersLabel: UILabel!
    var statsLabel: UILabel!
    var newsLabel: UILabel!
    var newsArray = [News]()
    var statsArray = [String]()
    var ordersArray = [Order]()
    var tradeView: UIView!
    var buyButton: UIButton!
    var sellButton: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("red")
        loading()
        downloadElements()

    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mainScrollView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        containerView.bounds = CGRect(x: 0,y: 0, width: mainScrollView.contentSize.width, height:mainScrollView.contentSize.height)
        print(containerView.bounds)
        
    }
    
    func downloadElements () {
        for item in 1...4 {
            let itemText = "\(item) news is breaking"
            newsArray.append(News(text: itemText.uppercased(), date: "23 February"))

        }
        for order in 1...4{
            ordersArray.append(Order(text: "\(order)", date: "\(order*2)", price: "\(order*3)", shares: "\(order*4)"))
        }
    }

    func loading() {
        //Mark: NEED FOR SCROLL VIEW
        self.mainScrollView = UIScrollView()
        self.mainScrollView.delegate = self
        self.mainScrollView.contentSize = CGSize(width: self.view.bounds.width, height: 1888)
        self.mainScrollView.bounces = false

        
        containerView = UIView()
        self.mainScrollView.addSubview(containerView)
        view.addSubview(mainScrollView)
        

        let width = view.bounds.width
        priceLabel = UILabel(frame: CGRect(x: 0, y: 0, width:width, height: (self.view.frame.height-(navigationController?.navigationBar.frame.height)!)*0.2))
        priceLabel.text = "$1023.3"
        priceLabel.textColor = .black
        priceLabel.textAlignment = .center
        priceLabel.font = UIFont(name: "Avenir Next Medium", size: 64)
        sharesLabel = UILabel(frame: CGRect(x: 0, y: priceLabel.frame.maxY, width: width, height: (self.view.frame.height-(navigationController?.navigationBar.frame.height)!)*0.1))
        sharesLabel.text="shares"
        sharesLabel.textColor = .black
        sharesLabel.textAlignment = .center
        sharesLabel.font = UIFont(name: "Avenir Next Medium", size: 32)
        
        graphicView = UIView(frame: CGRect(x: 0, y: sharesLabel.frame.maxY, width: width, height: (self.view.frame.height-(navigationController?.navigationBar.frame.height)!)*0.55))
        graphicView.backgroundColor = .green
        
        
        tradeView = UIView(frame: CGRect(x: 0, y: graphicView.frame.maxY, width: width, height: (self.view.frame.height-(navigationController?.navigationBar.frame.height)!)*0.15))
        print((self.view.frame.height-(navigationController?.navigationBar.frame.height)!)*0.15)
        buyButton = UIButton(frame: CGRect(x: 40, y:tradeView.frame.height*0.15, width: 120, height: 64))
        sellButton = UIButton(frame: CGRect(x: self.view.frame.width/2+40, y: tradeView.frame.height*0.15, width: 120, height: 64))
        buyButton.backgroundColor = UIColor(hex: StockEnum.mainColor.rawValue)
        buyButton.layer.cornerRadius = 4
        sellButton.backgroundColor = UIColor(hex: StockEnum.mainColor.rawValue)
        sellButton.layer.cornerRadius = 4
        buyButton.setTitle("BUY", for: .normal)
        sellButton.setTitle("SELL", for: .normal)
        tradeView.addSubview(buyButton)
        tradeView.addSubview(sellButton)
        
        
        

        newsTableView = UITableView(frame: CGRect(x: 0, y: tradeView.frame.maxY+48, width: width, height: 400))
        newsTableView.delegate = self
        newsTableView.dataSource = self
        newsTableView.register(NewsTableViewCell.self, forCellReuseIdentifier: "news")
        newsTableView.tag = 1
        newsTableView.backgroundColor = .black
        newsTableView.rowHeight = 100
        newsLabel = UILabel(frame: CGRect(x: 10, y: newsTableView.frame.minY-32, width: self.view.bounds.width, height: 24))
        newsLabel.text = "News"
        newsLabel.font = UIFont(name: "Avenir Next Medium", size: 24)
        


        

        statsTableView = UITableView(frame: CGRect(x: 0, y: newsTableView.frame.maxY+48.0, width: width, height: 250))
        statsTableView.delegate = self
        statsTableView.dataSource = self
        statsTableView.register(StatsTableViewCell.self, forCellReuseIdentifier: "stat")
        statsTableView.tag = 2
        statsTableView.rowHeight = 50
        
        statsLabel = UILabel(frame: CGRect(x: 10, y: statsTableView.frame.minY-32, width: self.view.bounds.width, height: 24))
        statsLabel.text = "Statistics"
        statsLabel.font = UIFont(name: "Avenir Next Medium", size: 24)
        
        


        ordersTableView = UITableView(frame: CGRect(x: 0, y: statsTableView.frame.maxY+48.0, width: width, height: 400))
        ordersTableView.delegate = self
        ordersTableView.dataSource = self
        ordersTableView.register(OrdersTableViewCell.self, forCellReuseIdentifier: "order")
        ordersTableView.tag = 3
        ordersTableView.rowHeight = 100
        ordersLabel = UILabel(frame: CGRect(x: 10, y: ordersTableView.frame.minY-32, width: self.view.frame.width, height: 24))
        ordersLabel.text = "Orders"
        ordersLabel.font = UIFont(name: "Avenir Next Medium", size: 24)
        

        
        mainScrollView.addSubview(priceLabel)
        mainScrollView.addSubview(sharesLabel)
        mainScrollView.addSubview(graphicView)
        mainScrollView.addSubview(newsTableView)
        mainScrollView.addSubview(statsTableView)
        mainScrollView.addSubview(ordersTableView)
        mainScrollView.addSubview(ordersLabel)
        mainScrollView.addSubview(statsLabel)
        mainScrollView.addSubview(newsLabel)
        mainScrollView.addSubview(tradeView)
        print(newsTableView.rowHeight)
        print(self.view.frame.width)
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch tableView.tag {
        case 1:
            return 4
        case 2:
            return 5
        case 3:
            return 4
        default:
            print("default")
            return newsArray.count
        }

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        switch tableView.tag {
            
        case 1:
            
            let  cell = tableView.dequeueReusableCell(withIdentifier: "news") as! NewsTableViewCell
//            cell.newsLabel.text = newsArray[indexPath.row].text
            cell.dateLabel.text = newsArray[indexPath.row].date
        return cell
        case 2:
           let  cell = tableView.dequeueReusableCell(withIdentifier: "stat") as! StatsTableViewCell
           switch indexPath.row {
           case 0:
            cell.firstLabel.text = "OPEN"
            cell.secondLabel.text = "VOLUME"
           case 1:
            cell.firstLabel.text = "HIGH"
            cell.secondLabel.text = "AVG VOl"
           case 2:
            cell.firstLabel.text = "LOW"
            cell.secondLabel.text = "MKT CAP"
           case 3:
            cell.firstLabel.text = "1Y HIGH"
            cell.secondLabel.text = "RATIO"
           default:
            cell.firstLabel.text = "1Y LOW"
            cell.secondLabel.text = "D/Y"
           }
           return cell
        case 3:
           let  cell = tableView.dequeueReusableCell(withIdentifier: "order") as! OrdersTableViewCell
           cell.dateLabel.text = ordersArray[indexPath.row].date
           cell.priceLabel.text = ordersArray[indexPath.row].price
           cell.sharesLabel.text = ordersArray[indexPath.row].shares
           return cell
        default:
            print("default")
            let cell = tableView.dequeueReusableCell(withIdentifier: "news")!
            return cell
            
        }

        

        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You selected cell #\(indexPath.row)!")
    }
    


}


struct News {
    var text: String!
    var date: String!
}

struct Stat{
    var open: Double!
    var high: Double!
    var low: Double!
    var volume: Double!
    var avgvol: Double!
    var mktcap: Double!
    var ratio: Double!
    var yield: Double!
    var ftkh: Double!
    var ftkl: Double!
}

struct Order {
    var text: String!
    var date: String!
    var price: String!
    var shares: String!
}



