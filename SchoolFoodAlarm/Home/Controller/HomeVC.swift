//
//  HomeVC.swift
//  Money
//
//  Created by 최영우 on 7/25/23.
//

import Foundation
import UIKit

class HomeVC : UIViewController {
    
    private var AppName : UILabel = {
        var label = UILabel()
        label.text = "가계부"
        label.backgroundColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override func viewDidLoad() {
        let safeArea = view.safeAreaLayoutGuide
        super.viewDidLoad()
        self.view.addSubview(AppName)
        
        NSLayoutConstraint.activate([
            AppName.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 0),
            AppName.leadingAnchor.constraint(equalTo : safeArea.leadingAnchor, constant: 16)
        ])
    }
}
