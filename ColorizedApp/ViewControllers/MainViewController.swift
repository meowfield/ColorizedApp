//
//  NavigatorViewController.swift
//  ColorizedApp
//
//  Created by Данис Гаязов on 3.7.24..
//

import UIKit
// MARK: - Protocols
protocol ColorDelegate {
    func sendColor(color: UIColor)
}

final class MainViewController: UIViewController {
    
    // MARK: - View Lifecycle
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let settingsVC = segue.destination as? SettingsViewController {
            settingsVC.color = view.backgroundColor
            settingsVC.delegate = self
        }
    }
}

// MARK: - Extensions: ColorDelegate
extension MainViewController: ColorDelegate {
    func sendColor(color: UIColor) {
        view.backgroundColor = color
    }
}
