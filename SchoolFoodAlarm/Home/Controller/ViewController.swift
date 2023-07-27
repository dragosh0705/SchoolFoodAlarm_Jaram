import Foundation
import UIKit
import Alamofire
import SideMenu

class ViewController : UIViewController {
    
    var SelectedFoodNameString : String?
    
    private var BackgroundView: UIView = {
        var view = UIView()
        view.backgroundColor = .systemBlue
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()
    
    
    private var AppName : UILabel = {
        var label = UILabel()
        label.text = "학식하면"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize:30)
        label.backgroundColor = .systemBlue
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
        FoodText.borderStyle = .bezel
        FoodText.placeholder = "메뉴 입력"
        FoodText.translatesAutoresizingMaskIntoConstraints = false
        
        return FoodText
    }()
    
    private var StoreButton : UIButton = {
        var button = UIButton()
        button.setTitle("저장", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.gray, for: .highlighted)
        button.backgroundColor = .orange
        button.addTarget(self, action: #selector(foodSelectedDidChange), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private var TimeSelectButton: UIButton = {
        var button = UIButton()
        button.setTitle("Push 설정", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.gray, for: .highlighted)
        button.backgroundColor = .systemBlue
        //button.addTarget(self, action: #selector(goPushSettingVC()), for: .touchUpInside) // 여기서부터 시작하기
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    
    override func viewDidLoad() {
        let safeArea = view.safeAreaLayoutGuide
        super.viewDidLoad()
        self.view.addSubview(BackgroundView)
        self.view.addSubview(AppName)
        self.view.addSubview(FoodLabel)
        self.view.addSubview(FoodSelectTextField)
        self.view.addSubview(StoreButton)
        self.view.addSubview(TimeSelectButton)
        
        NSLayoutConstraint.activate([
            BackgroundView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            BackgroundView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            BackgroundView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            BackgroundView.bottomAnchor.constraint(equalTo: AppName.bottomAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            AppName.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 15),
            AppName.centerXAnchor.constraint(equalTo : self.view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            FoodLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 140),
            FoodLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            FoodSelectTextField.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 170),
            FoodSelectTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            FoodSelectTextField.widthAnchor.constraint(equalToConstant: 300),
            FoodSelectTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            StoreButton.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 240),
            StoreButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            StoreButton.heightAnchor.constraint(equalToConstant: 50),
            StoreButton.widthAnchor.constraint(equalToConstant: 300)
        ])
        
        NSLayoutConstraint.activate([
            TimeSelectButton.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 310),
            TimeSelectButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 30)
        ])
        
        
        hideKeyboardWhenTappedAround() // 화면 탭 시 키보드 숨기기
        
    }
    
    @objc private func foodSelectedDidChange() {
        SelectedFoodNameString = FoodSelectTextField.text
        //print(SelectedFoodNameString!) //정상적으로 SelectedFoodNameString에 저장 됨
        crawling(Text: SelectedFoodNameString!)
    }
    
    /*
    @objc private func goPushSettingVC() { // PushSettingVC 파일로 넘어가기
        performSegue(withIdentifier: "PushSettingVC", sender: nil)
    }
     */
    
    
    
    
    
    
    
    
    //휴아봇 학식 데이터 크롤링
    func crawling(Text: String) {
        let url = "https://prod.backend.hyuabot.app/rest/cafeteria/campus/2/restaurant/13/" // 창의인재원식당, 나머지 식당은 방학이라 메뉴 데이터 없음

        AF.request(url).responseString(encoding: .utf8) { response in
            switch response.result {
            case .success(let html):
                if html.contains(Text) {
                    print("Food Found: \(Text)")
                } else {
                    print("Food Not Found")
                }

            case .failure(let error):
                print("Error fetching data: \(error.localizedDescription)")
            }
        }
    }

}


