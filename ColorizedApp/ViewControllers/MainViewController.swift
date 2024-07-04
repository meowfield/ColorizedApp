//
//  NavigatorViewController.swift
//  ColorizedApp
//
//  Created by Данис Гаязов on 3.7.24..
//

import UIKit

final class MainViewController: UIViewController {
    
    // MARK: - View Lifecycle
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let settingsVC = segue.destination as? SettingsViewController {
            if let backgroundColor = view.backgroundColor {
                var red: CGFloat = 0
                var green: CGFloat = 0.4
                var blue: CGFloat = 0.4
                var alpha: CGFloat = 0.4
                
                backgroundColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
                settingsVC.red = red
                settingsVC.green = green
                settingsVC.blue = blue
            }
            settingsVC.delegate = self
        }
    }
}

// MARK: - Extensions: ColorDelegate
extension MainViewController: ColorDelegate {
    func sendColor(red: Float, green: Float, blue: Float) {
        view.backgroundColor = UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: 1.0)
    }
}
