//
//  LengthConversionViewController.swift
//  Converter
//
//  Created by 庄司隼介 on 2019/05/08.
//  Copyright © 2019 庄司隼介. All rights reserved.
//

import Foundation
import UIKit

class LengthConversionViewController : UIViewController,UIPickerViewDelegate,UIPickerViewDataSource{
    
    
    
    let formatter = MeasurementFormatter()
    
    let unitList = [
        "Meters","Feet","Kilometers"
    ]
    
    //   変換元と変換先の単位をIntで管理
   
    var inputUnit : UnitLength = UnitLength.meters
    var outputUnit : UnitLength = UnitLength.meters
    
    @IBOutlet  var inputField: UITextField!
    @IBOutlet  var outPutTextLabel: UILabel!
    @IBOutlet var convertButton:UIButton!
    @IBOutlet  var inputUnitPicker: UIPickerView!
    @IBOutlet  var outputUnitPicker: UIPickerView!
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        inputUnitPicker.delegate = self
        inputUnitPicker.dataSource = self
        inputUnitPicker.tag = 1
        
        outputUnitPicker.delegate = self
        outputUnitPicker.dataSource = self
       outputUnitPicker.tag = 2
        
    
        
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
        
        if (pickerView.tag == 1) {
        
            switch row {
            case 0 : inputUnit = UnitLength.meters
                break
            case 1 : inputUnit = UnitLength.feet
                break
            case 2 : inputUnit = UnitLength.kilometers
                break
            default:break
            }
        }else{
            
            switch row {
            case 0 : outputUnit = UnitLength.meters
                break
            case 1 : outputUnit = UnitLength.feet
                break
            case 2 : outputUnit = UnitLength.kilometers
                break
            default:break
        
            }}
        
    }
    
    
    
    @IBAction func onBurger() {
        (tabBarController as! TabBarController).sidebar.showInViewController(self, animated: true)
    }
    
    @IBAction func convert(){
    
        let inputValue : Double = atof(inputField.text!)
        
        let formattedValue = NSMeasurement(doubleValue: inputValue, unit: inputUnit).converting(to: outputUnit)
        outPutTextLabel.text = formattedValue.description
    }
}

