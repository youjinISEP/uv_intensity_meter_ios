//
//  ViewController.swift
//  GaugeExample
//
//  Created by youjin on 11/09/2019.
//  Copyright © 2019 youjin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
        let test = GaugeView(frame : CGRect(x:40, y:40, width: 256, height: 256))
        test.backgroundColor = .clear
        view.addSubview(test)
    }


}

