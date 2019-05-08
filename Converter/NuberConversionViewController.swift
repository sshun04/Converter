//
//  NuberConversionViewController.swift
//  Converter
//
//  Created by 庄司隼介 on 2019/05/08.
//  Copyright © 2019 庄司隼介. All rights reserved.
//

import Foundation
import UIKit

class NumberConversionViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    
    @IBOutlet var inputTextField : UITextField!
    @IBOutlet var inputUnitPicker :UIPickerView!
    @IBOutlet var outputUnitPicker :UIPickerView!
    @IBOutlet var outputTextLabel :UILabel!
    @IBOutlet var convertButton:UIButton!
    
    let formatter = NumberFormatter()
    
    let dataList = [
        "数字" , "漢数字" , "Alphabet"
    ]
    
    var toUnit = 0
    var fromUnit = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
                inputUnitPicker.delegate = self
                inputUnitPicker.dataSource = self
                inputUnitPicker.tag = 1
        
        
        
        
                inputTextField.placeholder = "12345"
        
                inputTextField.keyboardType = UIKeyboardType.numbersAndPunctuation
                inputTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        
        
                outputTextLabel.layer.borderWidth = 1
                outputTextLabel.layer.borderColor = UIColor.gray.cgColor
        
                formatter.numberStyle = .spellOut
        
        
                outputUnitPicker.delegate = self
                outputUnitPicker.dataSource = self
                outputUnitPicker.tag = 2
        
                NotificationCenter.default.addObserver(self,
                                                       selector: #selector(textFieldDidChange),
                                                                 name: UITextField.textDidChangeNotification,
                                                                 object: inputTextField)
        
        // Do any additional setup after loading the view.
    }
  
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func textFieldDidChange(notification:NSNotification)  {
        
        let textField  = notification.object as! UITextField
        if fromUnit == 0{
            if let text = textField.text{
                if text.count > 16{
                    
                    textField.text = String(text.prefix(16))
                }
            }
            
        }
    }
    
    @IBAction func onBurger() {
        (tabBarController as! TabBarController).sidebar.showInViewController(self, animated: true)
    }
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataList.count
    }
    
    func pickerView(_ pickerView:UIPickerView,
                    titleForRow row :Int,
                    forComponent component:Int) -> String? {
        
        return dataList[row]
    }
    
    
    func pickerView(_ pickerView:UIPickerView,
                    didSelectRow row:Int,
                    inComponent componet:Int) {
        
        if (pickerView.tag == 1) {
            fromUnit = row
            switch fromUnit{
            case 0: inputTextField.placeholder = "12345"
            inputTextField.keyboardType = UIKeyboardType.numbersAndPunctuation
                break
            case 1: inputTextField.placeholder = "一万二千三百四十五"
            inputTextField.keyboardType = UIKeyboardType.default
                break
            case 2: inputTextField.placeholder = "twelve thousand three hundred forty-five"
            inputTextField.keyboardType = UIKeyboardType.alphabet
                break
            default:
                break
            }
            
        }else{
            toUnit  = row
        }
        
        
    }
    
    @IBAction func convert ()
    {
        
        if !inputTextField.hasText {
            return
        }
        
        if toUnit == fromUnit {
            outputTextLabel.text = inputTextField.text
            return
        }
        
        if fromUnit == 1 && inputTextField.text?.contains("京") ?? false {
            return
        }
        
        if fromUnit == 2 && inputTextField.text?.contains("quadrillion") ?? false {
            return
        }
        
        
        
        switch toUnit {
        case 0:
            switch self.fromUnit{
            case 1:
                formatter.locale = Locale(identifier: "ja_JP")
                convertToNumber()
                break
            case 2: formatter.locale = Locale(identifier: "en_US")
            convertToNumber()
                break
            default :break
            }
            
            break
            
            
        case 1:
            formatter.locale = Locale(identifier: "ja_JP")
            switch self.fromUnit{
            case 0: convertToWords()
                break
            case 2: convertAlphaBetsToKanji()
                break
            default :break
            }
            
            break
        case 2 :
            formatter.locale = Locale(identifier: "en_US")
            switch self.fromUnit{
            case 0: convertToWords()
                break
            case 1: convertKanjiToAlphaBets()
                break
            default :break
            }
            break
        default:
            break
        }
        
    }
    
    func convertToWords(){
        
        guard let text  = inputTextField.text else {
            return
        }
        let defaultUnit = Int(text)
        let formattedWord = formatter.string(from:NSNumber(value: defaultUnit!))!
        outputTextLabel.text = String(formattedWord)
        
        
    }
    
    func convertToNumber() {
        
        let defaultNuber = inputTextField.text
        let convertedNumber = formatter.number(from: defaultNuber!)
        outputTextLabel.text = convertedNumber?.stringValue
    }
    
    func convertAlphaBetsToKanji(){
        //        First of all, convert to number
        formatter.locale = Locale(identifier: "en_US")
        let defaultNuber = inputTextField.text
        let convertedNumber = formatter.number(from: defaultNuber!)
        
        //        convert to Kanji
        formatter.locale = Locale(identifier: "ja_JP")
        let formattedWord = formatter.string(from:convertedNumber!)!
        outputTextLabel.text = String(formattedWord)
        
        
        
        
        
    }
    
    func convertKanjiToAlphaBets() {
        //        First of all, convert to number
        
        formatter.locale = Locale(identifier: "ja_JP")
        let defaultNuber = inputTextField.text
        let convertedNumber = formatter.number(from: defaultNuber!)
        
        //        convert to Alphabet
        formatter.locale = Locale(identifier: "en_US")
        let formattedWord = formatter.string(from:convertedNumber!)!
        outputTextLabel.text = String(formattedWord)
    }
}
