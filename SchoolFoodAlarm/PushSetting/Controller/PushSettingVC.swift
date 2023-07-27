//
//  PushSettingVC.swift
//  SchoolFoodAlarm
//
//  Created by 최영우 on 7/27/23.
//

import Foundation
import UIKit


class PushSettingVC : UIViewController {
    
    
    private var AlarmTimeSetting : UIDatePicker = {
        var alarm = UIDatePicker()
        
        alarm.translatesAutoresizingMaskIntoConstraints = false
        return alarm
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(AlarmTimeSetting)
        
        NSLayoutConstraint.activate([
            AlarmTimeSetting.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            AlarmTimeSetting.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
    }
}
