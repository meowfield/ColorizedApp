//
//  ViewController.swift
//  ColorizedApp
//
//  Created by Данис Гаязов on 24.6.24..
//

import UIKit

final class ViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet var redColorInfo: UILabel!
    @IBOutlet var greenColorInfo: UILabel!
    @IBOutlet var blueColorInfo: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    @IBOutlet var paletteView: UIView!
  
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        paletteView.layer.cornerRadius = 10
        mixingColors()
    }
    
    // MARK: - IBActions
    @IBAction func redSliderAction() {
        redColorInfo.text = String(format: "%.2f", redSlider.value)
        mixingColors()
    }
        
    @IBAction func greenSliderAction() {
        greenColorInfo.text = String(format: "%.2f", greenSlider.value)
        mixingColors()
    }
    
    @IBAction func blueSliderAction() {
        blueColorInfo.text = String(format: "%.2f", blueSlider.value)
        mixingColors()
    }
    
    // MARK: - Private Methods
    private func mixingColors() {
        paletteView.backgroundColor = UIColor(
            _colorLiteralRed: redSlider.value,
            green: greenSlider.value,
            blue: blueSlider.value,
            alpha: 1.0
        )
    }
    
}

