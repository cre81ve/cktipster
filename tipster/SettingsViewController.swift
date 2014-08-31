//
//  SettingsViewController.swift
//  tipster
//
//  Created by CK on 8/27/14.
//  Copyright (c) 2014 Chaitanya Kannali. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController , UIPickerViewDelegate{
    
    @IBOutlet weak var settingsTipLabel: UILabel!
    
    @IBOutlet weak var defaultTipPicker: UIPickerView!
    
    @IBOutlet weak var resetSoFar: UIButton!
    @IBOutlet weak var defaultShares: UITextField!
    
    var tipsSelected=["18%","20%","22%"]
    
    @IBAction func resetSoFarTipsToZero(sender: AnyObject) {
        var defaults = NSUserDefaults.standardUserDefaults()

        var soFar = defaults.doubleForKey("so_far_tipped")
        defaults.setDouble(0.00, forKey: "so_far_tipped")
            
    

    }
    // returns the number of 'columns' to display.
     func numberOfComponentsInPickerView(pickerView: UIPickerView!) -> Int {
        return 1
    }
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    @IBAction func onDefaultShareChange(sender: AnyObject) {
        var defaults = NSUserDefaults.standardUserDefaults()
        var ds:NSString = defaultShares.text
        var dsint = ds.integerValue
        if(dsint > 15) {defaultShares.text = "1"}
        defaults.setInteger(dsint, forKey: "default_share_selected")
        defaults.synchronize()

    }
    // returns the # of rows in each component..
     func pickerView(pickerView: UIPickerView!, numberOfRowsInComponent component: Int) -> Int {
        return tipsSelected.count
    }
    
     func pickerView(pickerView: UIPickerView!, titleForRow row: Int, forComponent component: Int) -> String! {
        return tipsSelected[row]
    }
    
    func pickerView(pickerView: UIPickerView!, didSelectRow row: Int, inComponent component: Int) {
//        var itemSelected = tipsSelected[row];
//        println("Selected \(itemSelected)")
        
        println("Row selected in settings \(row)")
        var defaults = NSUserDefaults.standardUserDefaults()

        defaults.setInteger(row, forKey: "default_tip_selected")
        defaults.synchronize()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        var defaults = NSUserDefaults.standardUserDefaults()
        var defaultTip:Int?=defaults.integerForKey("default_tip_selected")
         var defaultShare:Int?=defaults.integerForKey("default_share_selected")
        if(defaultTip != nil) {
            defaultTipPicker.reloadAllComponents()
            defaultTipPicker.selectRow(defaultTip! , inComponent:0 , animated:true)
        }
        
        if(defaultShare != nil) {
            var enteredVal = defaultShare!
            if(enteredVal > 15) {
                defaultShares.text = "1"
            } else {
            defaultShares.text = String(enteredVal)
            }
            
        }
        else {
            defaultShares.text = "1"
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}



