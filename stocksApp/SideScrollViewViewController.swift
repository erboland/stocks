//
//  SideScrollViewViewController.swift
//  stocks
//
//  Created by Ербол Каршыга on 4/21/17.
//  Copyright © 2017 Octopus. All rights reserved.
//

import UIKit

class SideScrollViewViewController: UIViewController {
    
    
    @IBOutlet weak var sideScrollView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let V1: UIViewController = (storyboard?.instantiateViewController(withIdentifier: "Profile"))!
        let V2: UIViewController = (storyboard?.instantiateViewController(withIdentifier: "Portfolio"))!
        let V3: UIViewController = (storyboard?.instantiateViewController(withIdentifier: "MyStocks"))!
        
        self.addChildViewController(V3)
        self.addChildViewController(V2)
        self.addChildViewController(V1)
        
        V1.didMove(toParentViewController: self)
        V2.didMove(toParentViewController: self)
        V3.didMove(toParentViewController: self)
        
        let screen = UIScreen.main.bounds
        
        V2.view.frame = CGRect(x: screen.width , y: 0, width: screen.width, height: screen.height - 64)
        
        V3.view.frame = CGRect(x: screen.width * 2 , y: 0, width: screen.width, height: screen.height - 64)
            
        self.sideScrollView.addSubview(V1.view)
        self.sideScrollView.addSubview(V2.view)
        self.sideScrollView.addSubview(V3.view)
        
        self.sideScrollView.contentSize = CGSize(width: self.view.frame.width * 3, height: screen.height - 64 )
        
        sideScrollView.contentOffset = CGPoint(x: self.view.frame.width, y: 0)
        
    }

}
