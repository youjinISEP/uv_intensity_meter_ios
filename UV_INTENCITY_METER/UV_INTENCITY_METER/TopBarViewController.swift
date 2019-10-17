//
//  TopBarViewController.swift
//  UV_INTENCITY_METER
//
//  Created by youjin on 15/10/2019.
//  Copyright © 2019 youjin. All rights reserved.
//

import UIKit

class TopBarViewController: UIViewController {

    @IBOutlet weak var uvButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        uvButton.layer.backgroundColor = UIColor.green.cgColor
        uvButton.layer.cornerRadius = 15

    }
    

    
}
