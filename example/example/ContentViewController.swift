//
//  ContentViewController.swift
//  example
//
//  Created by youjin on 11/10/2019.
//  Copyright © 2019 youjin. All rights reserved.
//

import UIKit

class ContentViewController: UITabBarController, UITabBarControllerDelegate {

    var typeNum = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        print("view load \(typeNum)")
        self.selectedIndex = typeNum
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print(tabBarController.selectedIndex)
        if tabBarController.selectedIndex == 0 {
            print("Go to HOME")
            self.presentingViewController?.dismiss(animated: true, completion: nil)
        }
    }
    
    
    

   

}
