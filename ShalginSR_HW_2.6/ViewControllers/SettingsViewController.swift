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
    
    //MARK: - Public Properties
    var delegate: SettingsViewControllerDelegate!
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        redTextField.delegate = self
        greenTextField.delegate = self
        blueTextField.delegate = self
        
        colorView.layer.cornerRadius = 15
        
        setUIColor(for: colorView)
        setValue(for: redLabel, greenLabel, blueLabel)
        setValue(for: redTextField, greenTextField, blueTextField)
    }
    
    // MARK: - IB Actions
    @IBAction func slidersAction(_ sender: UISlider) {
        setUIColor(for: colorView)
        
        switch sender {
        case redSlider:
            redLabel.text = string(from: redSlider)
            redTextField.text = string(from: redSlider)
        case greenSlider:
            greenLabel.text = string(from: greenSlider)
            greenTextField.text = string(from: greenSlider)
        default:
            blueLabel.text = string(from: blueSlider)
            blueTextField.text = string(from: blueSlider)
        }
    }
    
    @IBAction func doneButtonPressed() {
        view.endEditing(true)
        delegate.setViewColor(from: colorView)
        dismiss(animated: true)
    }
    
    // MARK: - Work With Outlets Private Methods
    private func setUIColor(for view: UIView) {
        view.backgroundColor = UIColor(
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

// MARK: - Extension: UI Text Fields Delegate
extension SettingsViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let inputValue = textField.text, !inputValue.isEmpty else {
            showAlert(with: "Text field is empty", and: "Please, set the value")
            return
        }
        guard let numberValue = Float(inputValue) else {
            showAlert(with: "Wrong format", and: "Please, use only numbers")
            return
        }
        
        switch textField {
        case redTextField:
            redSlider.value = checkValueBelongingToRange(
                value: numberValue,
                range: redSlider
            )
            redLabel.text = string(from: redSlider)
            setUIColor(for: colorView)
        case greenTextField:
            greenSlider.value = checkValueBelongingToRange(
                value: numberValue,
                range: greenSlider
            )
            greenLabel.text = string(from: greenSlider)
            setUIColor(for: colorView)
        default:
            blueSlider.value = checkValueBelongingToRange(
                value: numberValue,
                range: blueSlider
            )
            blueLabel.text = string(from: blueSlider)
            setUIColor(for: colorView)
        }
    }
}

// MARK: - Extension: Check Error Private Methods
extension SettingsViewController {
    private func checkValueBelongingToRange(
        value textField: Float,
        range slider: UISlider
    ) -> Float {
            if textField < slider.minimumValue {
                showAlert(with: "Range error", and: "Minimum value: 0.0")
                return slider.minimumValue
            } else if textField > slider.maximumValue {
                showAlert(with: "Range error", and: "Maximum value: 1.0")
                return slider.maximumValue
            } else {
                return textField
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
