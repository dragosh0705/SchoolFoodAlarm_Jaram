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
        label.font = UIFont.systemFont(ofSize:35)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override func viewDidLoad() {
        let safeArea = view.safeAreaLayoutGuide
        super.viewDidLoad()
        self.view.addSubview(AppName)
        
        NSLayoutConstraint.activate([
            AppName.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 20),
            AppName.leadingAnchor.constraint(equalTo : safeArea.leadingAnchor, constant: 16)
        ])
    }
}
