//
//  ViewController.swift
//  Converter
//
//  Created by 庄司隼介 on 2019/05/02.
//  Copyright © 2019 庄司隼介. All rights reserved.
//

import UIKit



class ViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    
    @IBOutlet var textField : UITextField!
    @IBOutlet var pickerView1 :UIPickerView!
    @IBOutlet var pickerView2 :UIPickerView!
    
    @IBOutlet var textLabel :UILabel!
    @IBOutlet var convertButton:UIButton!
    private var defaultPick = 0
    private var resultPick = 0
    
    
    let formatter = NumberFormatter()
    
    let dataList = [
        "数字" , "漢数字" , "Alphabet"
    ]

    var toUnit = 0
    var fromUnit = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView1.delegate = self
        pickerView1.dataSource = self
        pickerView1.tag = 1
        
        
        
        textField.placeholder = "12345"
    
        textField.keyboardType = UIKeyboardType.numbersAndPunctuation
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        
        
        textLabel.layer.borderWidth = 1
        textLabel.layer.borderColor = UIColor.gray.cgColor
        
    
        
        formatter.numberStyle = .spellOut
        
        
        pickerView2.delegate = self
        pickerView2.dataSource = self
        pickerView2.tag = 2
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(textFieldDidChange),
                                                         name: UITextField.textDidChangeNotification,
                                                         object: textField)
        
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
            case 0: textField.placeholder = "12345"
                    textField.keyboardType = UIKeyboardType.numbersAndPunctuation
                break
            case 1: textField.placeholder = "一万二千三百四十五"
                    textField.keyboardType = UIKeyboardType.default
                break
            case 2: textField.placeholder = "twelve thousand three hundred forty-five"
                    textField.keyboardType = UIKeyboardType.alphabet
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
        
        if !textField.hasText {
            return
        }
        
        if toUnit == fromUnit {
            textLabel.text = textField.text
            return
        }
    
        if fromUnit == 1 && textField.text?.contains("京") ?? false {
            return
        }
        
        if fromUnit == 2 && textField.text?.contains("quadrillion") ?? false {
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
        
        guard let text  = textField.text else {
            return
        }
         let defaultUnit = Int(text)
           let formattedWord = formatter.string(from:NSNumber(value: defaultUnit!))!
             textLabel.text = String(formattedWord)
      
       
    }
    
    func convertToNumber() {
   
        let defaultNuber = textField.text
        let convertedNumber = formatter.number(from: defaultNuber!)
        textLabel.text = convertedNumber?.stringValue
    }
    
    func convertAlphaBetsToKanji(){
//        First of all, convert to number
        formatter.locale = Locale(identifier: "en_US")
        let defaultNuber = textField.text
        let convertedNumber = formatter.number(from: defaultNuber!)
        
//        convert to Kanji
        formatter.locale = Locale(identifier: "ja_JP")
        let formattedWord = formatter.string(from:convertedNumber!)!
        textLabel.text = String(formattedWord)
        
        
        
        
        
    }
    
    func convertKanjiToAlphaBets() {
//        First of all, convert to number

        formatter.locale = Locale(identifier: "ja_JP")
        let defaultNuber = textField.text
        let convertedNumber = formatter.number(from: defaultNuber!)
        
//        convert to Alphabet
        formatter.locale = Locale(identifier: "en_US")
        let formattedWord = formatter.string(from:convertedNumber!)!
        textLabel.text = String(formattedWord)
    }
    
    
    
    
    
}

