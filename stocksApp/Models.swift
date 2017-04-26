//
//  Models.swift
//  stocksApp
//
//  Created by Robert Kim on 4/23/17.
//  Copyright © 2017 Octopus. All rights reserved.
//

import Foundation
import Alamofire
import SocketIO

enum StockEnum: String{
    case mainColor = "80C783"
    case url = "http://10.27.115.137:3000"
}

enum TimeRangeEnum: String {
    case today = "stocksForToday"
    case fiveDays = "stocksForFiveDays"
    case month = "stocksForMonth"
    case threeMonth = "stocksForThreeMonths"
    case sixMonth = "stocksForSixMonths"
    case year = "stocksForYear"
}


class Socket: NSObject {
    

    lazy var socket: SocketIOClient = SocketIOClient(socketURL: URL(string: StockEnum.url.rawValue )!,config: [.forcePolling(true)])
        
    func onStocksOf(_ symbol: String, completion: @escaping (Any) -> ()){
        
        socket.on("connect") {data, ack in
            self.socket.emit("getRealTimeStocks", ["symbol": symbol])
            
            self.socket.on("realTimeStocksInfo/\(symbol)/\(self.socket.sid!)") {data, ack in
                completion(data)
            }
        }
        
        socket.on("error") {data, ack in
            print("error occured")
        }
        
        socket.connect()
    }
    
}

struct StocksModel {
    
    
    static func searchCompany(_ text: String, _ completion: @escaping ([String]) -> () ){
        
        let sessionManager = Alamofire.SessionManager.default
        
        sessionManager.session.getTasksWithCompletionHandler { dataTasks, uploadTasks, downloadTasks in
            dataTasks.forEach { $0.cancel() }
            uploadTasks.forEach { $0.cancel() }
            downloadTasks.forEach { $0.cancel() }
            
        }
        
        Alamofire.request("\(StockEnum.url.rawValue)/searchCompany/\(text)").responseJSON { response in
            
            if let data = response.result.value as? NSArray{
                
                let result = data.map{ return $0 as! String }
                
                completion(result)
                
            } else {
                print("no result value")
            }
            
        }

    }
    
    
    static func stocksFor(_ range: TimeRangeEnum, symbol: String, _ completion: @escaping ([CGFloat],[CGFloat: String]) -> Void ) {
        
        Alamofire.request("\(StockEnum.url.rawValue)/\(range.rawValue)/\(symbol)").responseJSON { response in
            
            if let data = response.result.value as? NSArray{
                
                var dates: [CGFloat: String] = [:]
                
                let points = data.map { (snap) -> CGFloat in
                    
                    let val =  (snap as! NSString).components(separatedBy: "/")
                    
                    let point = CGFloat((val[1] as NSString).doubleValue)
                    
                    dates[point] = val[0]
                    
                    return point
                }
                
                completion(points, dates)
                
            } else {
                print("no result value")
            }
            
        }
        
    }
    
}
