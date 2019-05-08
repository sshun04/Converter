//
//  AreaConversionViewController.swift
//  Converter
//
//  Created by 庄司隼介 on 2019/05/08.
//  Copyright © 2019 庄司隼介. All rights reserved.
//

import Foundation
import UIKit

class AreaConversionViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func onBurger() {
        (tabBarController as! TabBarController).sidebar.showInViewController(self, animated: true)
    }
    
}
