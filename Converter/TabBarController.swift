//
//  TabBarController.swift
//  Converter
//
//  Created by 庄司隼介 on 2019/05/07.
//  Copyright © 2019 庄司隼介. All rights reserved.
//

import Foundation
import UIKit

class TabBarController: UITabBarController,UITabBarControllerDelegate{
    var sidebar:FrostedSidebar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        tabBar.isHidden  = true
        
        moreNavigationController.navigationBar.isHidden = true
        
        sidebar = FrostedSidebar(itemImages:[
           UIImage(named:"gear" )!,
           UIImage(named: "globe")!,
           UIImage(named: "profile")!
            ]
        ,
        colors:
            [
                UIColor(red: 240/255, green: 159/255, blue: 254/255, alpha: 1),
                UIColor(red: 255/255, green: 137/255, blue: 167/255, alpha: 1),
                UIColor(red: 126/255, green: 242/255, blue: 195/255, alpha: 1),],
        selectionStyle: .single)
        
        sidebar.actionForIndex = [
            0: {self.sidebar.dismissAnimated(true, completion: { finished in self.selectedIndex = 0}) },
            1: {self.sidebar.dismissAnimated(true, completion: { finished in self.selectedIndex = 1}) },
            2: {self.sidebar.dismissAnimated(true, completion: { finished in self.selectedIndex = 2}) },
            3: {self.sidebar.dismissAnimated(true, completion: { finished in self.selectedIndex = 3}) }
        ]
    }
    
}
