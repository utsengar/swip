//
//  ViewController.swift
//  Swip
//
//  Created by Utkarsh Sengar on 12/23/16.
//  Copyright © 2016 Area42. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var tenLabel: UILabel!
    @IBOutlet weak var twentyLabel: UILabel!
    @IBOutlet weak var twentyFiveLabel: UILabel!
    let defaults = UserDefaults.standard
    var currentTipValue = 0.0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        billField.becomeFirstResponder()
        drawToolbar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated) // No need for semicolon
        drawToolbar()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTap(_ sender: Any) {
        // view.endEditing(true)
    }

    @IBAction func calculateTip(_ sender: Any) {
        var originalText = billField.text?.replacingOccurrences(of: "$", with: "") ?? "0"
        if originalText == "" {
            originalText = "0"
        }
        let bill = Double(originalText) ?? 0
        let tip = bill * currentTipValue
        let total = bill + tip
        
        tipLabel.text = "$" + originalText + " @ " + String(currentTipValue * 100) + "% = " + String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
    }
    @IBAction func reeval(_ sender: Any) {
        calculateTip(sender)
    }
    
    func setGradientBackground() {
        let colorTop =  UIColor(red: 19.0/255.0, green: 205.0/255.0, blue: 138.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 8.0/255.0, green: 159.0/255.0, blue: 82.0/255.0, alpha: 1.0).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [ colorTop, colorBottom]
        gradientLayer.locations = [ 0.0, 0.5]
        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func tip1Tapped(_ val: UIBarButtonItem) {
        currentTipValue = defaults.double(forKey: "tip1");
        tenLabel.isHidden = false
        twentyLabel.isHidden = true
        twentyFiveLabel.isHidden = true
        calculateTip(val)
    }
    func tip2Tapped(_ val: UIBarButtonItem) {
        currentTipValue = defaults.double(forKey: "tip2");
        tenLabel.isHidden = true
        twentyLabel.isHidden = false
        twentyFiveLabel.isHidden = true
        calculateTip(val)
    }
    func tip3Tapped(_ val: UIBarButtonItem) {
        currentTipValue = defaults.double(forKey: "tip3");
        tenLabel.isHidden = true
        twentyLabel.isHidden = true
        twentyFiveLabel.isHidden = false
        calculateTip(val)
    }
    
    func drawToolbar(){
        currentTipValue = defaults.double(forKey: "tip1")
        twentyLabel.isHidden = true
        twentyFiveLabel.isHidden = true
        let textFieldAppearance = UITextField.appearance()
        textFieldAppearance.keyboardAppearance = .alert //.default//.light//.alert
        
        setGradientBackground()
        let numberToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 50))
        numberToolbar.barStyle = UIBarStyle.default
        numberToolbar.backgroundColor = UIColor.black
        let tip1Orig = defaults.double(forKey: "tip1")
        let tip1 = UIBarButtonItem(title: String(Int(tip1Orig * 100)) + "%", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.tip1Tapped(_:)))
        tip1.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor(red: 8.0/255.0, green: 159.0/255.0, blue: 82.0/255.0, alpha: 1.0)], for: UIControlState.normal)
        
        let tip2Orig = defaults.double(forKey: "tip2")
        let tip2 = UIBarButtonItem(title: String(Int(tip2Orig * 100)) + "%", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.tip2Tapped(_:)))
        tip2.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor(red: 8.0/255.0, green: 159.0/255.0, blue: 82.0/255.0, alpha: 1.0)], for: UIControlState.normal)
        
        let tip3Orig = defaults.double(forKey: "tip3")
        let tip3 = UIBarButtonItem(title: String(Int(tip3Orig * 100)) + "%", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.tip3Tapped(_:)))
        tip3.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor(red: 8.0/255.0, green: 159.0/255.0, blue: 82.0/255.0, alpha: 1.0)], for: UIControlState.normal)
        
        let first = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.fixedSpace, target: nil, action: nil)
        first.width = 30
        let last = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.fixedSpace, target: nil, action: nil)
        last.width = 30
        
        numberToolbar.items = [first,
                               tip1,
                               UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil),
                               tip2,
                               UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil),
                               tip3,
                               last]
        
        numberToolbar.sizeToFit()
        billField.inputAccessoryView = numberToolbar
    }
}
