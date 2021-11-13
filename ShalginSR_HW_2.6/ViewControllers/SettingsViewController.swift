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
    var viewColor: UIColor!
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorView.layer.cornerRadius = 15
        
        colorView.backgroundColor = viewColor
        
        setSliders()
        setValue(for: redLabel, greenLabel, blueLabel)
        setValue(for: redTextField, greenTextField, blueTextField)
    }
    
    // MARK: - IB Actions
    @IBAction func slidersAction(_ sender: UISlider) {
        setUIColor(for: colorView)
        
        switch sender {
        case redSlider:
            setValue(for: redLabel)
            setValue(for: redTextField)
        case greenSlider:
            setValue(for: greenLabel)
            setValue(for: greenTextField)
        default:
            setValue(for: blueLabel)
            setValue(for: blueTextField)
        }
    }
    
    @IBAction func doneButtonPressed() {
        delegate?.setColor(colorView.backgroundColor ?? .red)
        dismiss(animated: true)
    }
}

// MARK: - Private Methods
extension SettingsViewController {
    
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
            case redLabel: label.text = string(from: redSlider)
            case greenLabel: label.text = string(from: greenSlider)
            default: label.text = string(from: blueSlider)
            }
        }
    }
    
    private func setValue(for textFields: UITextField...) {
        textFields.forEach { textField in
            switch textField {
            case redTextField: textField.text = string(from: redSlider)
            case greenTextField: textField.text = string(from: greenSlider)
            default: textField.text = string(from: blueSlider)
            }
        }
    }
    
    private func setSliders() {
        let ciColor = CIColor(color: viewColor)
        
        redSlider.value = Float(ciColor.red)
        greenSlider.value = Float(ciColor.green)
        blueSlider.value = Float(ciColor.blue)
    }
    
    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
    
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
    
    @objc private func didTapDone() {
        view.endEditing(true)
    }
}

// MARK: - UITextFieldsDelegate
extension SettingsViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
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
            
        case greenTextField:
            greenSlider.value = checkValueBelongingToRange(
                value: numberValue,
                range: greenSlider
            )
            greenLabel.text = string(from: greenSlider)
        default:
            blueSlider.value = checkValueBelongingToRange(
                value: numberValue,
                range: blueSlider
            )
            blueLabel.text = string(from: blueSlider)
        }
        
        setUIColor(for: colorView)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        textField.inputAccessoryView = keyboardToolbar
        
        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(didTapDone)
        )
        
        let flexBarButton = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        
        keyboardToolbar.items = [flexBarButton, doneButton]
    }
}
