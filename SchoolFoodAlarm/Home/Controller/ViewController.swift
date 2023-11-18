import Foundation
import SwiftSoup
import UIKit
import Alamofire
import SideMenu


var MenuTableArr: [String] = []
var TodayTableArr : [String] = []

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
        view.backgroundColor = UIColor(red: 14/255, green: 74/255, blue: 132/255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    
    private var AppName : UILabel = {
        var label = UILabel()
        label.text = "학식하면"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize:30, weight: .heavy)
        label.backgroundColor = UIColor(red: 14/255, green: 74/255, blue: 132/255, alpha: 1)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private var FoodLabel : UILabel = {
        var label = UILabel()
        label.text = "알람 메뉴"
        label.font = UIFont.systemFont(ofSize:15, weight: .heavy)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private var FoodSelectTextField : UITextField = {
        var FoodText = UITextField()
        FoodText.placeholder = "  메뉴 입력"
        FoodText.layer.cornerRadius = 13
        FoodText.layer.borderWidth = 0.5
        FoodText.translatesAutoresizingMaskIntoConstraints = false
        
        return FoodText
    }()
    
    private var StoreButton : UIButton = {
        var button = UIButton()
        button.setTitle("저장", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .heavy)
        button.titleLabel?.layer.shadowColor = UIColor.black.cgColor
        button.titleLabel?.layer.masksToBounds = false
        button.titleLabel?.layer.shadowOffset = CGSize(width: 0, height: 4)
        button.titleLabel?.layer.shadowRadius = 5
        button.titleLabel?.layer.shadowOpacity = 0.3
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.gray, for: .highlighted)
        button.backgroundColor = UIColor(red: 100/255, green: 160/255, blue: 200/255, alpha: 1)
        button.layer.cornerRadius = 13
        button.addTarget(self, action: #selector(foodSelectedDidChange), for: .touchUpInside)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.masksToBounds = false
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        button.layer.shadowRadius = 5
        button.layer.shadowOpacity = 0.3
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
    
    private var StoredFoodInfoLabel : UILabel = {
        var label = UILabel()
        label.text = "선택한 메뉴"
        label.font = UIFont.systemFont(ofSize:15, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private var TodayFoodInfoLabel : UILabel = {
        var label = UILabel()
        label.text = "오늘의 메뉴"
        label.font = UIFont.systemFont(ofSize:15, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private var tableView1 : UITableView = {
        let tableview = UITableView()
        return tableview
    }()
    
    private var tableView2 : UITableView = {
        let tableview = UITableView()
        return tableview
    }()
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            MenuTableArr.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            print(MenuTableArr)
        }
        if editingStyle == .insert {
            
        }
    }
        
    private func setConstraint() {
        self.view.addSubview(tableView1)
        tableView1.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView1.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 450),
            tableView1.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -100), // 바닥에서 위로 50만큼
            tableView1.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 200),
            tableView1.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20) // 오른쪽에서 왼쪽으로 20만큼
        ])
        
        tableView1.isScrollEnabled = true
    }
    
    private func setConstraint2() {
        self.view.addSubview(tableView2)
        tableView2.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            tableView2.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 450),
            tableView2.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -100), // 바닥에서 위로 50만큼
            tableView2.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            tableView2.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -200) // 오른쪽에서 왼쪽으로 20만큼
        ])
        
        tableView2.isScrollEnabled = true
    }
    
    override func viewDidLoad() {
        let safeArea = view.safeAreaLayoutGuide
        super.viewDidLoad()
        crawling()
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
        scrollView.addSubview(StoredFoodInfoLabel)
        scrollView.addSubview(TodayFoodInfoLabel)
        // scrollView.addSubview(TimeSelectButton)
        tableView1.delegate = self
        tableView1.dataSource = self
        
        
        tableView2.delegate = self
        tableView2.dataSource = self
        
        
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
            StoredFoodInfoLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 350),
            StoredFoodInfoLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 260),
        ])
        
        NSLayoutConstraint.activate([
            TodayFoodInfoLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 350),
            TodayFoodInfoLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 60),
        ])
        
        
        
        /*
         NSLayoutConstraint.activate([
         TimeSelectButton.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 310),
         TimeSelectButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
         ])
         */
        
        
        tableView1.register(MenuTableViewCell.self, forCellReuseIdentifier: "MenuTableViewCell")
        setConstraint()
        
        tableView2.register(TodayTableViewCell.self, forCellReuseIdentifier: "TodayTableViewCell")
        setConstraint2()
        
        
        
        
        
        
        
        hideKeyboardWhenTappedAround() // 화면 탭 시 키보드 숨기기
        
    }
    
    @objc private func foodSelectedDidChange()  {
        SelectedFoodNameString = FoodSelectTextField.text
        MenuTableArr.append(SelectedFoodNameString!)
        tableView1.reloadData()
        crawling()
    
        //pushNotification(title: "학식 알림", body: "저장된 음식과 같은 메뉴가 나옵니다!", seconds: 2, identifier: "MenuAlarm")
    }
    
    
    
    
    
    @objc private func goPushSettingVC() {
        let pushSettingVC = PushSettingVC()
        self.present(pushSettingVC, animated: true, completion: nil)
    }
        
    @objc private func crawling() {
        
        struct FoodDataContainer {
            var container: [FoodData]
            init(container: [FoodData]) {
                self.container = container
            }
            var emptycontainer : [String] = []
            
            mutating func load(_ res: Restaurant) async {
                let myUrl = URL(string: "https://www.hanyang.ac.kr/web/www/" + res.rawValue)!
                let html = try? String(contentsOf: myUrl, encoding: .utf8)
                
                
                var menus: [String] = []
                
                let cal = Calendar(identifier: .gregorian)
                let now = Date()
                let comps = cal.dateComponents([.weekday], from: now)
                let today = FoodDataDate(rawValue: comps.weekday!)
                
                if html == nil {
                    emptycontainer.append("학식 없음")
                }
                
                if html != nil {
                    let doc : Document = try! SwiftSoup.parse(html!)
                
                    
                    if FoodDataDate(rawValue: 1) == today || FoodDataDate(rawValue: 7) == today  {
                        let menu1 = try! doc.select("#messhall1 > div:nth-child(2) > div > div > div > ul > li > a > h3")
                        menus.append(try! menu1.text())
                        var menustr = ""
                        for i in menus {
                            menustr += i
                        }
                        TodayTableArr.removeAll()
                        TodayTableArr.append(contentsOf: menustr.split(separator: " ").map { String($0) })
                        
                    }
                    
                    
                    
                    if FoodDataDate(rawValue: 2) == today {
                        let menu1 = try! doc.select("#_foodView_WAR_foodportlet_tab_2 > div.box.tables-board-wrap > table > tbody > tr:nth-child(2) > td:nth-child(\(2) > ul > li:nth-child(\(1)")
                        let menu2 = try! doc.select("#_foodView_WAR_foodportlet_tab_2 > div.box.tables-board-wrap > table > tbody > tr:nth-child(2) > td:nth-child(\(2) > ul > li:nth-child(\(2)")
                        menus.append(try! menu1.text())
                        menus.append(try! menu2.text())
                        self.container.append(.init(date: .init(rawValue: 2)!, type: .special, menu: menus))
                    }
                    
                    if FoodDataDate(rawValue: 3) == today {
                        let menu1 = try! doc.select("#_foodView_WAR_foodportlet_tab_2 > div.box.tables-board-wrap > table > tbody > tr:nth-child(2) > td:nth-child(\(3) > ul > li:nth-child(\(1)")
                        let menu2 = try! doc.select("#_foodView_WAR_foodportlet_tab_2 > div.box.tables-board-wrap > table > tbody > tr:nth-child(2) > td:nth-child(\(4) > ul > li:nth-child(\(2)")
                        menus.append(try! menu1.text())
                        menus.append(try! menu2.text())
                        self.container.append(.init(date: .init(rawValue: 3)!, type: .special, menu: menus))
                    }
                    
                    if FoodDataDate(rawValue: 4) == today {
                        let menu1 = try! doc.select("#_foodView_WAR_foodportlet_tab_2 > div.box.tables-board-wrap > table > tbody > tr:nth-child(2) > td:nth-child(\(4) > ul > li:nth-child(\(1)")
                        let menu2 = try! doc.select("#_foodView_WAR_foodportlet_tab_2 > div.box.tables-board-wrap > table > tbody > tr:nth-child(2) > td:nth-child(\(4) > ul > li:nth-child(\(2)")
                        menus.append(try! menu1.text())
                        menus.append(try! menu2.text())
                        self.container.append(.init(date: .init(rawValue: 4)!, type: .special, menu: menus))
                    }
                    
                    if FoodDataDate(rawValue: 5) == today {
                        let menu1 = try! doc.select("#_foodView_WAR_foodportlet_tab_2 > div.box.tables-board-wrap > table > tbody > tr:nth-child(2) > td:nth-child(\(5) > ul > li:nth-child(\(1)")
                        let menu2 = try! doc.select("#_foodView_WAR_foodportlet_tab_2 > div.box.tables-board-wrap > table > tbody > tr:nth-child(2) > td:nth-child(\(5) > ul > li:nth-child(\(2)")
                        menus.append(try! menu1.text())
                        menus.append(try! menu2.text())
                        self.container.append(.init(date: .init(rawValue: 5)!, type: .special, menu: menus))
                    }
                    
                    if FoodDataDate(rawValue: 6) == today {
                        let menu1 = try! doc.select("#_foodView_WAR_foodportlet_tab_2 > div.box.tables-board-wrap > table > tbody > tr:nth-child(2) > td:nth-child(\(6) > ul > li:nth-child(\(1)")
                        let menu2 = try! doc.select("#_foodView_WAR_foodportlet_tab_2 > div.box.tables-board-wrap > table > tbody > tr:nth-child(2) > td:nth-child(\(6) > ul > li:nth-child(\(2)")
                        menus.append(try! menu1.text())
                        menus.append(try! menu2.text())
                        self.container.append(.init(date: .init(rawValue: 6)!, type: .special, menu: menus))
                    }
                    
                }
            }
        }
        print(TodayTableArr)
        tableView2.reloadData()

        struct FoodData: Codable {
            let date: FoodDataDate
            let type: FoodDataType
            let menu: [String]
            
            init(from decoder: Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                self.date = try container.decode(FoodDataDate.self, forKey: .date)
                self.type = try container.decode(FoodDataType.self, forKey: .type)
                self.menu = try container.decode([String].self, forKey: .menu)
            }
            
            init(date: FoodDataDate, type: FoodDataType, menu: [String]) {
                self.date = date
                self.type = type
                self.menu = menu
            }
        }

        enum Restaurant: String, Codable {
            case res12 = "re12"
            case res13 = "re13"
        }

        enum FoodDataDate: Int, Codable {
            case mon = 2
            case tue = 3
            case wed = 4
            case thr = 5
            case fri = 6
            
            func stringfy() -> String {
                var date = "오늘의"
                switch(self) {
                    
                case .mon:
                    date = "월요일"
                case .tue:
                    date = "화요일"
                case .wed:
                    date = "수요일"
                case .thr:
                    date = "목요일"
                case .fri:
                    date = "금요일"
                }
                
                return "\(date) 식단"
            }
        }

        enum FoodDataType: Codable {
            case special
            
            func stringfy() -> String {
                switch(self) {
                    
                case .special:
                    return "[특식]"
                }
            }
        }

        var container = FoodDataContainer.init(container: [])
        Task {
            await container.load(.res13)
        }
        
        
        
        /*
         //휴아봇 학식 데이터 크롤링
         @objc private func crawling() {
         let url = "https://prod.backend.hyuabot.app/rest/cafeteria/campus/2/restaurant/13/" // 창의인재원식당, 나머지 식당은 방학이라 메뉴 데이터 없음
         
         var exist : [String] = []
         
         AF.request(url).responseString(encoding: .utf8) { [self] response in
         switch response.result {
         case .success(let html):
         date.calendar = Calendar.current
         date.hour = 11
         date.minute = 10
         for i in MenuTable {
         if html.contains(i) {
         exist.append(i)
         if exist.count != 0 {
         print("Food Found: \(exist)")
         let content = UNMutableNotificationContent()
         content.title = "학식 알림"
         content.body = "\(exist) 메뉴가 나옵니다!"
         content.sound = .default
         content.badge = 1
         let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
         let request = UNNotificationRequest(identifier: "MenuAlarm", content: content, trigger: trigger)
         UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
         }
         }
         if exist.count == 0 {
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
         */
    }
}



extension ViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tableView1 {
            return MenuTableArr.count
        } else if tableView == tableView2 {
            return TodayTableArr.count
        } else {
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tableView1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell", for: indexPath) as? MenuTableViewCell else {
                return UITableViewCell()
            }
            let menuname = MenuTableArr[indexPath.row % MenuTableArr.count]
            cell.configure(menuname: menuname) // 메뉴명 설정
            return cell
        } else if tableView == tableView2 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TodayTableViewCell", for: indexPath) as? TodayTableViewCell else {
                return UITableViewCell()
            }
            let menuname = TodayTableArr[indexPath.row % TodayTableArr.count]
            cell.configure(menuname: menuname) // 메뉴명 설정
            return cell
        } else {
            return UITableViewCell()
        }
    }
}


extension String {
    func contains(_ strings: [String]) -> Bool {
        strings.contains { contains($0) }
    }
}
