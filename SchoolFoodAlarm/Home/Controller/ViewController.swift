//
//  ViewController.swift
//  Money
//
//  Created by 최영우 on 7/25/23.
//

import Foundation
import UIKit
import SwiftSoup
import Alamofire

class ViewController : UIViewController {
    
    var SelectedFoodNameString : String?
    
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
    
    private var FoodSelectTextField : UITextField = {
        var FoodText = UITextField()
        FoodText.frame = CGRect(x: 20, y: 100, width: 100, height: 40)
        FoodText.borderStyle = .bezel
        FoodText.placeholder = "메뉴 입력"
        FoodText.translatesAutoresizingMaskIntoConstraints = false
        
        return FoodText
    }()
    
    private var StoreButton : UIButton = {
        var button = UIButton()
        button.setTitle("저장", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.setTitleColor(.gray, for: .highlighted)
        button.addTarget(self, action: #selector(foodSelectedDidChange), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    
    override func viewDidLoad() {
        let safeArea = view.safeAreaLayoutGuide
        super.viewDidLoad()
        self.view.addSubview(AppName)
        self.view.addSubview(FoodLabel)
        self.view.addSubview(FoodSelectTextField)
        self.view.addSubview(StoreButton)
        
        NSLayoutConstraint.activate([
            AppName.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 20),
            AppName.leadingAnchor.constraint(equalTo : safeArea.leadingAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            FoodLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 80),
            FoodLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            FoodSelectTextField.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 100),
            FoodSelectTextField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            StoreButton.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 130),
            StoreButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 80)
        ])
        
    }
    
    @objc private func foodSelectedDidChange() {
        SelectedFoodNameString = FoodSelectTextField.text
        //print(SelectedFoodNameString!) //정상적으로 SelectedFoodNameString에 저장 됨
        crawling(Text: SelectedFoodNameString!)
    }

    func crawling(Text: String) {
        let url = "https://prod.backend.hyuabot.app/rest/cafeteria/campus/2/restaurant/13/" // 창의인재원식당, 나머지 식당은 방학이라 메뉴 데이터 없음

        AF.request(url).responseString(encoding: .utf8) { response in
            switch response.result {
            case .success(let html):
                if html.contains(Text) {
                    print("Food Found: \(Text)")
                } else {
                    print("Food Not Found")
                    print(html)
                }

            case .failure(let error):
                print("Error fetching data: \(error.localizedDescription)")
            }
        }
    }

}
