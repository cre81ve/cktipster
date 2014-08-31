//
//  ViewController.swift
//  tipster
//
//  Created by CK on 8/27/14.
//  Copyright (c) 2014 Chaitanya Kannali. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UIPickerViewDelegate {
    
  
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var billAmountField: UITextField!
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    @IBOutlet weak var tippedButton: UIButton!
    @IBOutlet weak var numOfPeople: UIPickerView!
    
    @IBOutlet weak var soFarTipped: UILabel!
    
    
    var tipAmount = 0.00
    
    @IBAction func onTippedConfirm(sender: AnyObject) {
        
        var defaults = NSUserDefaults.standardUserDefaults()
        var soFar = defaults.doubleForKey("so_far_tipped")
        if(soFar > 0.00) {
            soFar = soFar + tipAmount;
            defaults.setDouble(soFar, forKey: "so_far_tipped")
        }else {
            soFar = tipAmount
            defaults.setDouble(soFar, forKey: "so_far_tipped")

        }
        defaults.synchronize()
        
        renderSoFar()

        
    }
    
  
    @IBOutlet weak var perEach: UILabel!
    var peopleArray=["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15"]

    var currentNumberOfPeople=0
    @IBAction func onClear(sender: AnyObject) {
        billAmountField.text = ""
        reCalculate();
    }
    // returns the number of 'columns' to display.
    func numberOfComponentsInPickerView(pickerView: UIPickerView!) -> Int {
        return 1
    }
    
    // returns the # of rows in each component..
    func pickerView(pickerView: UIPickerView!, numberOfRowsInComponent component: Int) -> Int {
        return peopleArray.count
    }
    
    func pickerView(pickerView: UIPickerView!, titleForRow row: Int, forComponent component: Int) -> String! {
        return peopleArray[row]
    }
    
    func pickerView(pickerView: UIPickerView!, didSelectRow row: Int, inComponent component: Int) {
        currentNumberOfPeople = row
        reCalculate()
    }
    
  

    
    
    
    @IBAction func onEditingChanged(sender: AnyObject) {
        reCalculate()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        reset()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
           }


    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
        
    }
    
    /*
     Method to re calculate tip and other values.
    */
    func reCalculate() {
        var totalVal=0.0
        if billAmountField.text == "" {
            view.endEditing(true)
            tipLabel.text="$0.00"
            totalLabel.text="$0.00"
        }
        else {
            var tipPercentages = [0.18,0.2,0.22]
            var tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
            var billEntered:NSString = billAmountField.text
            var dblBillEntered = billEntered.doubleValue
            var tip = dblBillEntered * tipPercentage
            totalVal = dblBillEntered+tip
            totalLabel.text = String(format: "$%.2f", totalVal)
            tipLabel.text = String(format: "$%.2f", tip)
            var defaults = NSUserDefaults.standardUserDefaults()
            tipAmount = tip
            defaults.setDouble(dblBillEntered, forKey: "last_bill_selected")
            defaults.synchronize()
        }
        var per=totalVal/Double(currentNumberOfPeople+1)
        perEach.text = String(format: "$%.2f", per);
        
        
    }
    
    func reset() {
        // Do any additional setup after loading the view, typically from a nib.
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        var defaults = NSUserDefaults.standardUserDefaults()
        var row = defaults.integerForKey("default_tip_selected")
        println("Row selected is \(row)")
        tipControl.selectedSegmentIndex = row
        var dsh = defaults.integerForKey("default_share_selected")
        numOfPeople.reloadAllComponents()
        numOfPeople.selectRow(dsh-1 , inComponent:0 , animated:true)
        currentNumberOfPeople = dsh - 1
        var lbs = defaults.doubleForKey("last_bill_selected")
        if(lbs > 0 ){
            billAmountField.text = String (format: "%.2f", lbs);
        }
        
        reCalculate()
        renderSoFar()


    }
    
    
    func renderSoFar() {
        var defaults = NSUserDefaults.standardUserDefaults()
        var soFar = defaults.doubleForKey("so_far_tipped")
        if(soFar > 0.00) {
            soFarTipped.text = String (format: "$%.2f" ,soFar);
        }else {
            soFarTipped.text = "$0.00";
        }
    }
}

