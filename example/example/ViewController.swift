//
//  ViewController.swift
//  example
//
//  Created by youjin on 11/10/2019.
//  Copyright © 2019 youjin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var buttonTAG = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func buttonPressed(_ sender: UIButton) {
        self.buttonTAG = sender.tag
        performSegue(withIdentifier: "mainTocontent", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! ContentViewController
        vc.typeNum = self.buttonTAG
    }
    
}

