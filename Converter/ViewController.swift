//
//  ViewController.swift
//  Converter
//
//  Created by 庄司隼介 on 2019/05/02.
//  Copyright © 2019 庄司隼介. All rights reserved.
//

import UIKit



class ViewController: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onBurger() {
        (tabBarController as! TabBarController).sidebar.showInViewController(self, animated: true)
    }
}

