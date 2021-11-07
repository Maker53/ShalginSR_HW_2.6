//
//  MainViewController.swift
//  ShalginSR_HW_2.6
//
//  Created by Станислав on 06.11.2021.
//

import UIKit

protocol SettingsViewControllerDelegate {
    func setViewColor(from colorView: UIView)
}

class MainViewController: UIViewController {

    //MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navigationVC = segue.destination as? UINavigationController else { return }
        guard let settingsVC = navigationVC.topViewController as? SettingsViewController else { return }
        settingsVC.delegate = self
    }
}

// MARK: - SettingsViewControllerDelegate
extension MainViewController: SettingsViewControllerDelegate {
    func setViewColor(from colorView: UIView) {
        view.backgroundColor = colorView.backgroundColor 
    }
}
