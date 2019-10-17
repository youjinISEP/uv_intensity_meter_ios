//
//  MeasurementViewController.swift
//  UV_INTENCITY_METER
//
//  Created by youjin on 29/09/2019.
//  Copyright © 2019 youjin. All rights reserved.
//

import UIKit

class MeasurementViewController: UIViewController, UITextFieldDelegate {

    //initialize interface variables
    @IBOutlet weak var backgroundView: UIView!
    
    @IBOutlet weak var energyTextField: UITextField!
    @IBOutlet weak var timeText: UILabel!
    
    @IBOutlet weak var initialButton: UIButton!
    @IBOutlet weak var calculateButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    var gaugeValue:Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //add a view to divide section
        view.addSubview(backgroundView)
        
        //add a gauge view
        let gauge = GaugeView(frame : CGRect(x:40, y:40, width: 300, height: 300))
        gauge.backgroundColor = .clear
        backgroundView.addSubview(gauge)
        
        DispatchQueue.main.asyncAfter(deadline:  .now() + 1){
            UIView.animate(withDuration: 1){
                gauge.value = 25
                self.gaugeValue = gauge.value
                
            }
        }
        
        //define style of buttons
        initialButton.layer.borderWidth = 0.5
        initialButton.layer.borderColor = UIColor.white.cgColor
        initialButton.layer.cornerRadius = 5
        
        calculateButton.layer.borderWidth = 0.5
        calculateButton.layer.borderColor = UIColor.white.cgColor
        calculateButton.layer.cornerRadius = 5
        
        resetButton.layer.borderWidth = 0.5
        resetButton.layer.borderColor = UIColor.white.cgColor
        resetButton.layer.cornerRadius = 5
        
        //define textField characteristics
        energyTextField.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
       
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        self.view.frame.origin.y = -150
        
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        self.view.frame.origin.y = 0
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        energyTextField.resignFirstResponder()
        return true
    }
    
    @IBAction func detectSensorType(_ sender: Any) {
    }
    
    @IBAction func calculateTime(_ sender: Any) {
        if energyTextField.text == nil{
            let alert = UIAlertController(title: "Error", message: "Empty value. Please insert number", preferredStyle: .alert)
            self.present(alert, animated: true, completion: nil)
        }else if gaugeValue == 0{
            let alert = UIAlertController(title: "Error", message: "Couldn't divide by 0", preferredStyle: .alert)
            self.present(alert, animated: true, completion: nil)
        }else{
            let energyValue: Double? = Double(energyTextField.text!)
            timeText.text = String(format:"%1.1f", Double(energyValue!)/gaugeValue)
        }
        
        //timeText.text = uvTextField.text/self.gaugeValue
    }
    
    @IBAction func resetValue(_ sender: Any) {
        energyTextField.text = nil
        timeText.text = "0.0"
    }
}
