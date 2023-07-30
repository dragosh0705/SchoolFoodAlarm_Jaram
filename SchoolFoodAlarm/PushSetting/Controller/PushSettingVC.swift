//
//  PushSettingVC.swift
//  SchoolFoodAlarm
//
//  Created by 최영우 on 7/27/23.
//

import Foundation
import UIKit

var time: Int = 0 //global var

class PushSettingVC: UIViewController {
    
    var hour : Int = 0
    var minute : Int = 0

    private var timePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .time
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTimePicker()
    }

    private func setupTimePicker() {
        view.addSubview(timePicker)
        view.backgroundColor = .white

        NSLayoutConstraint.activate([
            timePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timePicker.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            // Add more constraints if needed to position the time picker on the screen.
        ])

        timePicker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
    }

    @objc private func datePickerValueChanged() {
        let selectedTime = timePicker.date

        // Get the hour and minute components from the selected time
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute], from: selectedTime)
        hour = components.hour!
        minute = components.minute!
        //print("Selected Time: \(hour):\(minute)")
        time = hour * 60 + minute
        
    }
}

