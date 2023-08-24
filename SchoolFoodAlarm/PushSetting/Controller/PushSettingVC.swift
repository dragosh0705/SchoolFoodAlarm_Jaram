//
//  PushSettingVC.swift
//  SchoolFoodAlarm
//
//  Created by 최영우 on 7/27/23.
//

import Foundation
import UIKit

var time: Int = 0 //global var
var picker = UIDatePicker()
var timeString : String = ""
var date = DateComponents()
var amPickerHoursInt : Int = 0
var amPickerMinutesInt : Int = 0

class PushSettingVC: UIViewController {
    
    private var timePicker: UIDatePicker = {
        picker.datePickerMode = .time
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    private var SaveButton: UIButton = {
        var button = UIButton()
        button.setTitle("저장", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitleColor(.gray, for: .highlighted)
        button.addTarget(self, action: #selector(SavingTime), for: .touchUpInside)
        
        
        button.translatesAutoresizingMaskIntoConstraints  = false
        return button
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(timePicker)
        view.addSubview(SaveButton)
        view.backgroundColor = .white
        
        NSLayoutConstraint.activate([
            timePicker.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            timePicker.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            SaveButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            SaveButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 450)
        ])
    }
    
    @objc private func SavingTime() {
        let SavedTime = timePicker.date
        let amPickerHours = DateFormatter()
        amPickerHours.dateFormat = "HH"
        // convert amPickerMinutes to Integer
        amPickerHoursInt = Int(amPickerHours.string(from: picker.date))!
        
        let amPickerMinutes = DateFormatter()
        amPickerMinutes.dateFormat = "mm"
        // convert amPickerMinutes to Integer
        amPickerMinutesInt = Int(amPickerMinutes.string(from: picker.date))!
        
        date.hour = amPickerHoursInt
        date.minute = amPickerMinutesInt

        
    }
    
   
    
    /*
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
     */
    
}

