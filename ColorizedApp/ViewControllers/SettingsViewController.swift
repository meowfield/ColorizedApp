//
//  ViewController.swift
//  ColorizedApp
//
//  Created by Данис Гаязов on 24.6.24..
//

import UIKit
// MARK: - Protocols
protocol ColorDelegate {
    func sendColor(red: Float, green: Float, blue: Float)
}

// MARK: - Class Definition
final class SettingsViewController: UIViewController {
    
    // MARK: - Properties
    var delegate: ColorDelegate?
    
    var red: CGFloat = 0.0
    var green: CGFloat = 0.0
    var blue: CGFloat = 0.0
    
    // MARK: - IBOutlets
    @IBOutlet var redColorInfo: UILabel!
    @IBOutlet var greenColorInfo: UILabel!
    @IBOutlet var blueColorInfo: UILabel!
        
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    @IBOutlet var paletteView: UIView!
    @IBOutlet weak var textField: UITextField!
      
    @IBOutlet var redTextField: UITextField!
    @IBOutlet var greenTextField: UITextField!
    @IBOutlet var blueTextField: UITextField!
    
    // MARK: - IBActions
    @IBAction func updateColorSettingsAfterSlider(_ slider: UISlider) {
        switch slider {
        case redSlider:
            redColorInfo.text = String(format: "%.2f", slider.value)
            redTextField.text = String(format: "%.2f", slider.value)
            red = CGFloat(slider.value)
        case greenSlider:
            greenColorInfo.text = String(format: "%.2f", slider.value)
            greenTextField.text = String(format: "%.2f", slider.value)
            green = CGFloat(slider.value)
        default:
            blueColorInfo.text = String(format: "%.2f", slider.value)
            blueTextField.text = String(format: "%.2f", slider.value)
            blue = CGFloat(slider.value)
        }
        mixingColors()
    }
    
    @IBAction func updateColorSettingsAfterTextField(_ textfield: UITextField) {
        switch textfield {
        case redTextField:
            if let text = redTextField.text, let value = Float(text) {
                redSlider.setValue(value, animated: true)
                redColorInfo.text = String(format: "%.2f", value)
                red = CGFloat(value)
            } else {
                showAlert()
                { self.redTextField.text = "0.5" }
            }
        case greenTextField:
            if let text = greenTextField.text, let value = Float(text) {
                greenSlider.setValue(value, animated: true)
                greenColorInfo.text = String(format: "%.2f", value)
                green = CGFloat(value)
            } else {
                showAlert()
                { self.greenTextField.text = "0.5" }
            }
        default:
            if let text = blueTextField.text, let value = Float(text) {
                blueSlider.setValue(value, animated: true)
                blueColorInfo.text = String(format: "%.2f", value)
                blue = CGFloat(value)
            } else {
                showAlert()
                { self.blueTextField.text = "0.5" }
            }
        }
        mixingColors()
    }
    @IBAction func doneButtonTapped() {
        delegate?.sendColor(red: Float(red), green: Float(green), blue: Float(blue))
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        paletteView.layer.cornerRadius = 10
        mixingColors()
        getBasicColorState()
        navigationItem.hidesBackButton = true
        redTextField.delegate = self
        greenTextField.delegate = self
        blueTextField.delegate = self
    }
    
    // MARK: - Public Methods
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
        
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
        
    // MARK: - Private Methods
    private func getBasicColorState() {
        redSlider.value = Float(red)
        greenSlider.value = Float(green)
        blueSlider.value = Float(blue)
        redColorInfo.text = String(format: "%.2f", red)
        greenColorInfo.text = String(format: "%.2f", green)
        blueColorInfo.text = String(format: "%.2f", blue)
        redTextField.text = String(format: "%.2f", red)
        greenTextField.text = String(format: "%.2f", green)
        blueTextField.text = String(format: "%.2f", blue)
    }
    
    private func mixingColors() {
            paletteView.backgroundColor = UIColor(
                _colorLiteralRed: Float(red),
                green: Float(green),
                blue: Float(blue),
                alpha: 1.0
            )
        }
    
    private func showAlert(completion: (() -> Void)? = nil) {
        let alert = UIAlertController(
            title: "Hey!",
            message: "Please, use only numbers!",
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
    }
