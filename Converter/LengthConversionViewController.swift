//
//  LengthConversionViewController.swift
//  Converter
//
//  Created by 庄司隼介 on 2019/05/08.
//  Copyright © 2019 庄司隼介. All rights reserved.
//

import Foundation
import UIKit

class LengthConversionViewController: UIViewController{
    let formatter = MeasurementFormatter()
    
    @IBOutlet weak var textLabel: UILabel!
    
    let meters :Double = 5

    override func viewDidLoad() {
        super.viewDidLoad()
    
        let formattedUnit = NSMeasurement(doubleValue: meters, unit: UnitLength.meters).converting(to: UnitLength.feet)
        
        textLabel.text = formattedUnit.description
       
    }
    
    @IBAction func onBurger() {
        (tabBarController as! TabBarController).sidebar.showInViewController(self, animated: true)
    }

}
