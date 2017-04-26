//
//  TradeViewController.swift
//  stocks
//
//  Created by Robert Kim on 4/20/17.
//  Copyright © 2017 Octopus. All rights reserved.
//

import UIKit

class TradeViewController: UIViewController, NumbersKeyboardDelegate, UITextFieldDelegate {

   
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var marketPriceLabel: UILabel!
    @IBOutlet weak var estCostLabel: UILabel!
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var wrapHeight: NSLayoutConstraint!
    
    var marketPrice: Double! {
        didSet{
            marketPriceLabel.text = "$\(marketPrice!)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let view = UIView(frame: CGRect(x: 20, y: 0, width: 100, height: 40))
//        view.backgroundColor = UIColor.red
        
        UINavigationBar.appearance().backgroundColor = .white
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        
        self.navigationController?.navigationBar.topItem?.titleView = view
        self.navigationController?.navigationBar.backgroundColor = UIColor.white
        self.navigationController?.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: nil)
        
        marketPrice = 12.0
        
        numberTextField.becomeFirstResponder()
        numberTextField.tintColor = UIColor(hex: StockEnum.mainColor.rawValue)
        numberTextField.addTarget(self, action: #selector(textFieldDidChanged(textField:)), for: .editingChanged)
        numberTextField.delegate = self
        
        wrapHeight.constant = UIScreen.main.bounds.height * 0.4
        
        let keyboardView = NumbersKeyboardView(frame: CGRect(x: 0, y: 0, width: 0, height: UIScreen.main.bounds.height * 0.45))
        keyboardView.delegate = self
        
        actionButton.layer.cornerRadius = 4
        
        numberTextField.inputView = keyboardView

    }
    
    func textFieldDidChanged(textField: UITextField){
        if let text = textField.text as NSString? {
            let amount = text.doubleValue
            estCostLabel.text = "$\(amount * marketPrice)"
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        

        guard let text = numberTextField.text else { return true }
        let newLength = text.characters.count + string.characters.count - range.length
       
        return newLength <= 5
    }
    
    
    func keyWasTapped(character: String) {
        numberTextField.insertText(character)
    }
    

    func deleteKey(){
        numberTextField.deleteBackward()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
