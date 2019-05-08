//
//  LengthConversionViewController.swift
//  Converter
//
//  Created by 庄司隼介 on 2019/05/08.
//  Copyright © 2019 庄司隼介. All rights reserved.
//

import Foundation
import UIKit

class LengthConversionViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource{

    
  
    let formatter = MeasurementFormatter()
    
    let unitList = [
        "Meters","Feet","Kilometer"
    ]
    
    @IBOutlet  var inputField: UITextField!
    @IBOutlet  var outPutTextLabel: UILabel!
    @IBOutlet var convertButton:UIButton!
    @IBOutlet  var inputUnitPicker: UIPickerView!
    @IBOutlet  var outputUnitPicker: UIPickerView!
    
    let meters :Double = 5

    override func viewDidLoad() {
        super.viewDidLoad()
        
        inputUnitPicker.delegate = self
        inputUnitPicker.dataSource = self
        inputUnitPicker.tag = 1

        outputUnitPicker.delegate = self
        outputUnitPicker.dataSource = self
        inputUnitPicker.tag = 2

        
  
        let formattedUnit = NSMeasurement(doubleValue: meters, unit: UnitLength.meters).converting(to: UnitLength.feet)

     outPutTextLabel.text = formattedUnit.description

    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return unitList.count
    }
    
    
    func pickerView(_ pickerView:UIPickerView,
                    titleForRow row :Int,
                    forComponent component:Int) -> String? {
        
        return unitList[row]
    }
    
    func pickerView(_ pickerView:UIPickerView,
                    didSelectRow row:Int,
                    inComponent componet:Int) {
        
        
        
    }
    
    
    
    @IBAction func onBurger() {
        (tabBarController as! TabBarController).sidebar.showInViewController(self, animated: true)
    }

    @IBAction func convert(_ sender: Any){
    
    }
}
