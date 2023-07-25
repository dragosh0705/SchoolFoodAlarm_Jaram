//
//  ViewController.swift
//  Money
//
//  Created by 최영우 on 7/25/23.
//

import Foundation
import UIKit

class ViewController : UIViewController {
    
    private var AppName : UILabel = {
        var label = UILabel()
        label.text = "학식하면"
        label.font = UIFont.systemFont(ofSize:30)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private var FoodLabel : UILabel = {
        var label = UILabel()
        label.text = "알람 메뉴"
        label.font = UIFont.systemFont(ofSize:15)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private var FoodSelect : UITextField = {
        var FoodText = UITextField()
        FoodText.frame = CGRect(x: 20, y: 100, width: 100, height: 40)
        FoodText.borderStyle = .bezel
        FoodText.placeholder = "메뉴 입력"
        FoodText.translatesAutoresizingMaskIntoConstraints = false
        
        return FoodText
    }()
    
    override func viewDidLoad() {
        let safeArea = view.safeAreaLayoutGuide
        super.viewDidLoad()
        self.view.addSubview(AppName)
        self.view.addSubview(FoodLabel)
        self.view.addSubview(FoodSelect)
        
        NSLayoutConstraint.activate([
            AppName.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 20),
            AppName.leadingAnchor.constraint(equalTo : safeArea.leadingAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            FoodLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 80),
            FoodLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            FoodSelect.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 100),
            FoodSelect.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20)
        ])
    }
}
