//
//  TodayTableViewCell.swift
//  SchoolFoodAlarm
//
//  Created by 최영우 on 2023. 11. 19..
//

import Foundation
import UIKit

class TodayTableViewCell: UITableViewCell {
    private let MenuLabel: UILabel = {
        var label = UILabel()
        label.text = TodayTableArr[0]
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private func setConstraint() {
        contentView.addSubview(MenuLabel)
        
        NSLayoutConstraint.activate([
            MenuLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            MenuLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            MenuLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConstraint()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(menuname: String) {
        MenuLabel.text = menuname
    }
}
