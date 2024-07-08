//
//  ViewController.swift
//  ColorizedApp
//
//  Created by Данис Гаязов on 24.6.24..
//

import UIKit


// MARK: - Class Definition
final class SettingsViewController: UIViewController {
    
    // MARK: - Properties
    var delegate: ColorDelegate?
    var color: UIColor!
    
    
    // MARK: - IBOutlets
    @IBOutlet var redColorInfo: UILabel!
    @IBOutlet var greenColorInfo: UILabel!
    @IBOutlet var blueColorInfo: UILabel!
        
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    @IBOutlet var paletteView: UIView!
      
    @IBOutlet var redTextField: UITextField!
    @IBOutlet var greenTextField: UITextField!
    @IBOutlet var blueTextField: UITextField!
    
    // MARK: - IBActions
    @IBAction func sliderAction(_ slider: UISlider) {
        switch slider {
        case redSlider:
            setValue(for: redTextField)
            setValue(for: redColorInfo)
        case greenSlider:
            setValue(for: greenTextField)
            setValue(for: greenColorInfo)
        default:
            setValue(for: blueTextField)
            setValue(for: blueColorInfo)
        }
        mixingColors()
    }    
    
    @IBAction func doneButtonTapped() {
        delegate?.sendColor(color: paletteView.backgroundColor ?? .black)
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        paletteView.layer.cornerRadius = 10
        getBasicColorState()
        mixingColors()
        
        navigationItem.hidesBackButton = true
    }
    
    // MARK: - Public Methods
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
                
    // MARK: - Private Methods
        
    private func string(from: UISlider) -> String {
        String(format: "%.2f", from.value)
    }
    
    private func setValue(for labels: UILabel...) {
        labels.forEach { label in
            switch label {
            case redColorInfo: label.text = string(from: redSlider)
            case greenColorInfo: label.text = string(from: greenSlider)
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
    
    private func setValue(for sliders: UISlider...) {
        let color = CIColor(color: color)
        sliders.forEach { slider in
            switch slider {
            case redSlider: slider.value = Float(color.red)
            case greenSlider: slider.value = Float(color.green)
            default: slider.value = Float(color.blue)
            }
        }
    }
    
    private func getBasicColorState() {
        setValue(for: redSlider, greenSlider, blueSlider)
        setValue(for: redColorInfo, greenColorInfo, blueColorInfo)
        setValue(for: redTextField, greenTextField, blueTextField)
    }
    
    private func mixingColors() {
        paletteView.backgroundColor = UIColor(red: CGFloat(redSlider.value), green: CGFloat(greenSlider.value), blue: CGFloat(blueSlider.value), alpha: 1.0)
    }
    
    private func showAlert(completion: (() -> Void)? = nil) {
        let alert = UIAlertController(
            title: "Hey!",
            message: "Please, use numbers from 0 to 1!",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { _ in
            completion?()
        }))
        present(alert, animated: true)
    }
}

// MARK: - Extensions: UITextFieldDelegate
extension SettingsViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else {
            showAlert() {
                textField.text = "0.50"
            }
            return
        }
        
        guard let value = Float(text), (0...1).contains(value) else {
            showAlert() {
                textField.text = "0.50"
            }
            return
        }
        
        switch textField {
        case redTextField:
            redSlider.setValue(value, animated: true)
            setValue(for: redColorInfo)
        case greenTextField:
            greenSlider.setValue(value, animated: true)
            setValue(for: greenColorInfo)
        default:
            blueSlider.setValue(value, animated: true)
            setValue(for: blueColorInfo)
        }
        mixingColors()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        textField.inputAccessoryView = keyboardToolbar
        
        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: textField,
            action: #selector(resignFirstResponder)
        )
        
        let flexBarButton = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        
        keyboardToolbar.items = [flexBarButton, doneButton]
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
