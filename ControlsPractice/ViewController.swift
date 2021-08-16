//
//  ViewController.swift
//  ControlsPractice
//
//  Created by Николай Никитин on 14.08.2021.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var button: UIButton!
    @IBOutlet var switches: [UISwitch]!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var textField: UITextField!
    
    var number = 128{
        didSet {
            if number < 0 {
                number = 255
            } else if 255 < number {
                number  = 0
            }
            updateUI()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        rotateSwitches()
    }
    func rotateSwitches(){
        for `switch` in switches {
            `switch`.layer.transform = CATransform3DMakeRotation(.pi / 2, 0, 0, 1)
        }
    }
    
    /// Updates number from  switches set
    func updateNumberFromSwitches(){
        var number = 0
        for `switch` in switches {
            number += `switch`.isOn ? `switch`.tag : 0
        }
        self.number = number
    }
    
    /// Updates switches from number
    func updateSwitches(){
        for `switch` in switches {
            `switch`.isOn = Int(number) & `switch`.tag != 0
        }
    }
    /// Updates all outlets to number
    func updateUI() {
        button.setTitle("\(number)", for: [])
        updateSwitches()
        slider.value = Float(number)
        textField.text = "\(number)"
        
    }

    @IBAction func buttonPressed() {
        number = Int((Int(number) + 1) % 256)
    }
    
    @IBAction func switchTogged(_ sender: UISwitch) {
        updateNumberFromSwitches()
    }
    
    @IBAction func sliderMoved() {
        number = Int(slider.value)
        
    }
    @IBAction func textFielEdited(_ sender: UITextField) {
        number = Int(textField.text ?? "") ?? 128
    }
    @IBAction func screenTapped(_ sender: UITapGestureRecognizer) {
        let location = sender.location (in: view)
        if location.x < view.bounds.midX {
            number -= 1
        } else {
            number += 1
        }
    }
}

