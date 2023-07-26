//
//  PushSettingVC.swift
//  SchoolFoodAlarm
//
//  Created by 최영우 on 7/27/23.
//

import Foundation
import UIKit


class PushSettingVC : UIViewController {
    var radioButton1: UIButton!
        var radioButton2: UIButton!

        override func viewDidLoad() {
            super.viewDidLoad()
            setupRadioButtons()
        }

        func setupRadioButtons() {
            let radioButtonSize: CGFloat = 20.0
            let radioButtonSpacing: CGFloat = 30.0
            let radioButtonOriginY: CGFloat = 100.0

            radioButton1 = createRadioButton(originY: radioButtonOriginY)
            radioButton2 = createRadioButton(originY: radioButtonOriginY + radioButtonSpacing)

            view.addSubview(radioButton1)
            view.addSubview(radioButton2)

            radioButton1.addTarget(self, action: #selector(radioButtonTapped), for: .touchUpInside)
            radioButton2.addTarget(self, action: #selector(radioButtonTapped), for: .touchUpInside)
        }

        func createRadioButton(originY: CGFloat) -> UIButton {
            let radioButton = UIButton(type: .custom)
            radioButton.frame = CGRect(x: 50.0, y: originY, width: 20.0, height: 20.0)
            radioButton.setImage(UIImage(named: "radio_unchecked"), for: .normal)
            radioButton.setImage(UIImage(named: "radio_checked"), for: .selected)
            radioButton.isSelected = false // Initial state is unchecked
            return radioButton
        }

        @objc func radioButtonTapped(sender: UIButton) {
            radioButton1.isSelected = (sender == radioButton1)
            radioButton2.isSelected = (sender == radioButton2)
        }
}
