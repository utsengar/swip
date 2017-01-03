//
//  SettingsViewController.swift
//  Swip
//
//  Created by Utkarsh Sengar on 1/2/17.
//  Copyright © 2017 Area42. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var tip1Field: UITextField!
    @IBOutlet weak var tip2Field: UITextField!
    @IBOutlet weak var tip3Field: UITextField!
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.white
        let tip1 = defaults.double(forKey: "tip1")
        tip1Field.text = String(tip1 * 100)
        
        let tip2 = defaults.double(forKey: "tip2")
        tip2Field.text = String(tip2 * 100)

        let tip3 = defaults.double(forKey: "tip3")
        tip3Field.text = String(tip3 * 100)

        setGradientBackground()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onChangeTip1(_ sender: Any) {
        if tip1Field.text != ""{
            defaults.set(Double(tip1Field.text!)!/100, forKey: "tip1")
            defaults.synchronize()
        }

    }
    
    @IBAction func onChangeTip2(_ sender: Any) {
        if tip2Field.text != "" {
            defaults.set(Double(tip2Field.text!)!/100, forKey: "tip2")
            defaults.synchronize()
        }
    }

    @IBAction func onChangeTip3(_ sender: Any) {
        if tip3Field.text != "" {
            defaults.set(Double(tip3Field.text!)!/100, forKey: "tip3")
            defaults.synchronize()
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func setGradientBackground() {
        let colorTop =  UIColor(red: 19.0/255.0, green: 205.0/255.0, blue: 138.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 8.0/255.0, green: 159.0/255.0, blue: 82.0/255.0, alpha: 1.0).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [ colorTop, colorBottom]
        gradientLayer.locations = [ 0.0, 0.5]
        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }

}
