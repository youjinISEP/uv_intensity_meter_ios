//
//  AnalysisViewController.swift
//  UV_INTENCITY_METER
//
//  Created by youjin on 12/10/2019.
//  Copyright © 2019 youjin. All rights reserved.
//

import UIKit

class AnalysisViewController: UIViewController {

    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var calButton: UIButton!
    
    @IBOutlet weak var changePointButton: UIButton!
    @IBOutlet weak var p5Button: UIButton!
    @IBOutlet weak var p4Button: UIButton!
    @IBOutlet weak var p3Button: UIButton!
    @IBOutlet weak var p6Button: UIButton!
    @IBOutlet weak var p1Button: UIButton!
    @IBOutlet weak var p2Button: UIButton!
    @IBOutlet weak var p7Button: UIButton!
    @IBOutlet weak var p8Button: UIButton!
    @IBOutlet weak var p9Button: UIButton!
    
    @IBOutlet weak var uvLabel: UILabel!
    @IBOutlet weak var p1Label: UILabel!
    @IBOutlet weak var p2Label: UILabel!
    @IBOutlet weak var p3Label: UILabel!
    @IBOutlet weak var p4Label: UILabel!
    @IBOutlet weak var p5Label: UILabel!
    @IBOutlet weak var p6Label: UILabel!
    @IBOutlet weak var p7Label: UILabel!
    @IBOutlet weak var p8Label: UILabel!
    @IBOutlet weak var p9Label: UILabel!
    @IBOutlet weak var avgLabel: UILabel!
    @IBOutlet weak var uniLabel: UILabel!
    
    
    var titleTextField: UITextField?
    var filetitle: String?
    var database: OpaquePointer?
    var fiveList = [AnalysisPoint5Value]()
    var nineList = [AnalysisPoint9Value]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let date = Date()
        let calendar = Calendar.current
        
        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)
        let day = calendar.component(.day, from: date)
        let month = calendar.component(.month, from:date)
        let year = calendar.component(.year, from: date)
        
        print("\(year) / \(month) / \(day) / \(hour) / \(minute)")
    }
    
    
    
    @IBAction func saveToDB(_ sender: UIButton) {
        let alert = UIAlertController(title: "SAVE",
                                      message: "Enter a title of the file",
                                      preferredStyle: .alert)
        alert.addTextField(configurationHandler: titleTextField)
        let saveAction = UIAlertAction(title: "Save", style: .default, handler: self.saveHandler)
        let cancelAction = UIAlertAction(title: "Cancle", style: .cancel, handler: nil)
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    func titleTextField(textField: UITextField!){
        titleTextField = textField
    }
    
    func saveHandler(alert: UIAlertAction!){
        filetitle = self.titleTextField?.text
        let title = titleTextField!.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        if(title?.isEmpty)!{
            titleTextField!.layer.borderColor = UIColor.red.cgColor
            return
        }

        
        print(filetitle ?? 0)
    }
    
    @IBAction func resetContent(_ sender: UIButton) {
        uvLabel.text = "0.0"
        p1Label.text = "0.0"
        p2Label.text = "0.0"
        p3Label.text = "0.0"
        p4Label.text = "0.0"
        p5Label.text = "0.0"
        p6Label.text = "0.0"
        p7Label.text = "0.0"
        p8Label.text = "0.0"
        p9Label.text = "0.0"
        avgLabel.text = "0.0"
        uniLabel.text = "0.0"
    }
    
    @IBAction func calculateValue(_ sender: UIButton) {
    }
    
   

}
