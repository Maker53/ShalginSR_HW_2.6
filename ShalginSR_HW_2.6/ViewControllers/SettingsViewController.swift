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
        setValue(for: redTextField, greenTextField, blueTextField)
    }
    
    // MARK: - IB Actions
    @IBAction func slidersAction(_ sender: UISlider) {
        setUIColor()
        
        switch sender {
        case redSlider:
            redLabel.text = string(from: redSlider)
            redTextField.text = redLabel.text
        case greenSlider:
            greenLabel.text = string(from: greenSlider)
            greenTextField.text = string(from: greenSlider)
        default:
            blueLabel.text = string(from: blueSlider)
            blueTextField.text = string(from: blueSlider)
        }
    }
    
    @IBAction func textFieldsAction(_ sender: UITextField) {
        switch sender {
        case redTextField:
            redSlider.value = checkValueBelongingToRange(
                value: redTextField,
                range: redSlider
            )
        case greenTextField:
            greenSlider.value = checkValueBelongingToRange(
                value: greenTextField,
                range: greenSlider
            )
        default:
            blueSlider.value = checkValueBelongingToRange(
                value: blueTextField,
                range: blueSlider
            )
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
    
    private func setValue(for textFields: UITextField...) {
        textFields.forEach { textField in
            switch textField {
            case redTextField:
                redTextField.text = string(from: redSlider)
            case greenTextField:
                greenTextField.text = string(from: greenSlider)
            default:
                blueTextField.text = string(from: blueSlider)
            }
        }
    }

    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
}

// MARK: - Extension
extension SettingsViewController {
    private func checkValueBelongingToRange(
        value textField: UITextField,
        range slider: UISlider
    ) -> Float {
        guard let inputValue = textField.text, !inputValue.isEmpty else {
            showAlert(with: "Text field is empty", and: "Please, set the value")
            return slider.minimumValue
        }
        
        if let value = Float(inputValue) {
            if value < slider.minimumValue {
                showAlert(with: "Range error", and: "Minimum value: 0.0")
                return slider.minimumValue
            } else if value > slider.maximumValue {
                showAlert(with: "Range error", and: "Maximum value: 1.0")
                return slider.maximumValue
            } else {
                return value
            }
        } else {
            showAlert(with: "Wrong format", and: "Please, use only numbers")
            return slider.minimumValue
        }
    }
    
    private func showAlert(with title: String, and message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(title: "OK", style: .default)
        
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
