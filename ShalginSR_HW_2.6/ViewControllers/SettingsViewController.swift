//
//  ViewController.swift
//  ShalginSR_HW_2.6
//
//  Created by Станислав on 06.11.2021.
//

import UIKit

class SettingsViewController: UIViewController {

    // MARK: - IB Outlets
    @IBOutlet var redLabel: UILabel!
    @IBOutlet var greenLabel: UILabel!
    @IBOutlet var blueLabel: UILabel!

    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!

    @IBOutlet var redTextField: UITextField!
    @IBOutlet var greenTextField: UITextField!
    @IBOutlet var blueTextField: UITextField!

    @IBOutlet var colorView: UIView!
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorView.layer.cornerRadius = 15
        
        setUIColor()
        setValue(for: redLabel, greenLabel, blueLabel)
    }
    
    // MARK: - IB Actions
    @IBAction func slidersAction(_ sender: UISlider) {
        setUIColor()
        
        switch sender {
        case redSlider: redLabel.text = string(from: redSlider)
        case greenSlider: greenLabel.text = string(from: greenSlider)
        default: blueLabel.text = string(from: blueSlider)
        }
    }
    
    // MARK: - Private Methods
    private func setUIColor() {
        colorView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
    }
    
    private func setValue(for labels: UILabel...) {
        labels.forEach { label in
            switch label {
            case redLabel:
                redLabel.text = string(from: redSlider)
            case greenLabel:
                greenLabel.text = string(from: greenSlider)
            default:
                blueLabel.text = string(from: blueSlider)
            }
        }
    }
    
    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
}
