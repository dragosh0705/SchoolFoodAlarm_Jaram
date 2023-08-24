import Foundation
import UIKit
import Alamofire
import SideMenu

var MenuTable : [String] = []

class ViewController : UIViewController {
    
    var SelectedFoodNameString : String?
    
    var MinuteTime : Int = 0
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    
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
        FoodText.placeholder = "  메뉴 입력"
        FoodText.layer.cornerRadius = 13
        FoodText.layer.borderWidth = 1
        FoodText.translatesAutoresizingMaskIntoConstraints = false
        
        return FoodText
    }()
    
    private var StoreButton : UIButton = {
        var button = UIButton()
        button.setTitle("저장", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.gray, for: .highlighted)
        button.backgroundColor = .orange
        button.layer.cornerRadius = 13
        button.addTarget(self, action: #selector(foodSelectedDidChange), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private var TimeSelectButton: UIButton = {
        var button = UIButton()
        button.setTitle("Push 시간", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitleColor(.gray, for: .highlighted)
        button.addTarget(self, action: #selector(goPushSettingVC), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private var tableView : UITableView = {
        let tableview = UITableView()
        
        return tableview
    }()
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            MenuTable.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            print(MenuTable)
            
        } else if editingStyle == .insert {
            
        }
    }
    
    private func setConstraint() {
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 450),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -50), // -50으로 수정
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 200), // 20으로 수정
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20) // -20으로 수정
        ])
        
        tableView.isScrollEnabled = true
    }
    
    
    override func viewDidLoad() {
        let safeArea = view.safeAreaLayoutGuide
        super.viewDidLoad()
        
        view.addSubview(scrollView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
        
        
        scrollView.addSubview(BackgroundView)
        scrollView.addSubview(AppName)
        scrollView.addSubview(FoodLabel)
        scrollView.addSubview(FoodSelectTextField)
        scrollView.addSubview(StoreButton)
        scrollView.addSubview(TimeSelectButton)
        tableView.delegate = self
        tableView.dataSource = self
        
        
        NSLayoutConstraint.activate([
            BackgroundView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            BackgroundView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            BackgroundView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            BackgroundView.heightAnchor.constraint(equalToConstant: 60)
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
            TimeSelectButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
        
        
        tableView.register(MenuTableViewCell.self, forCellReuseIdentifier: "MenuTableViewCell")
        setConstraint()
        
        
        
        
        
        
        hideKeyboardWhenTappedAround() // 화면 탭 시 키보드 숨기기
        
    }
    
    @objc private func foodSelectedDidChange() {
        SelectedFoodNameString = FoodSelectTextField.text
        MenuTable.append(SelectedFoodNameString!)
        //print(SelectedFoodNameString!) //정상적으로 SelectedFoodNameString에 저장 됨
        tableView.reloadData()
        crawling()
        
        //pushNotification(title: "학식 알림", body: "저장된 음식과 같은 메뉴가 나옵니다!", seconds: 2, identifier: "MenuAlarm")
    }
    
    
    
    
    @objc private func goPushSettingVC() {
        let pushSettingVC = PushSettingVC()
        self.present(pushSettingVC, animated: true, completion: nil)
    }
    
    
    /*
     @objc private func NowTime() -> String {
     var time : String = ""
     var formatter_time = DateFormatter()
     formatter_time.dateFormat = "HH:mm"
     var current_time_string = formatter_time.string(from: Date())
     time = current_time_string
     //print("NowTime : \(time)")
     return time
     }
     */
    
    
    
    
    
    
    
    
    //휴아봇 학식 데이터 크롤링
      @objc private func crawling() {
          let url = "https://prod.backend.hyuabot.app/rest/cafeteria/campus/2/restaurant/13/" // 창의인재원식당, 나머지 식당은 방학이라 메뉴 데이터 없음
          
          
          AF.request(url).responseString(encoding: .utf8) { [self] response in
              switch response.result {
              case .success(let html):
                  date.calendar = Calendar.current
                  date.hour = 3
                  date.minute = 13
                  for i in MenuTable {
                      if html.contains(i) {
                          print("Food Found: \(i)")
                          let content = UNMutableNotificationContent()
                          content.title = "학식 알림"
                          content.body = "\(i) 메뉴가 나옵니다!"
                          content.sound = .default
                          content.badge = 1
                          let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
                          let request = UNNotificationRequest(identifier: "MenuAlarm", content: content, trigger: trigger)
                          UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
                          
                      } else {
                          print("Food Not Found")
                          let content = UNMutableNotificationContent()
                          content.title = "학식 알림"
                          content.body = "오늘은 관심 메뉴가 나오지 않습니다!"
                          content.sound = .default
                          content.badge = 1
                          let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
                          let request = UNNotificationRequest(identifier: "MenuAlarm", content: content, trigger: trigger)
                          UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
                      }
                  }
              case .failure(let error):
                  print("Error fetching data: \(error.localizedDescription)")
              }
          }
      }
  }



extension ViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MenuTable.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell", for: indexPath) as? MenuTableViewCell else {
            return UITableViewCell()
        }
        let menuname = MenuTable[indexPath.row % MenuTable.count]
        cell.configure(menuname: menuname) // 메뉴명 설정

        return cell
    }
}

extension String {
    func contains(_ strings: [String]) -> Bool {
        strings.contains { contains($0) }
    }
}
