//
//  AppDelegate.swift
//  Money
//
//  Created by 최영우 on 7/25/23.
//

import UIKit
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
            // Override point for customization after application launch.
            if #available(iOS 11.0, *) {
                        // 경고창 배지 사운드를 사용하는 알림 환경 정보를 생성하고, 사용자 동의여부 창을 실행
                        let notiCenter =  UNUserNotificationCenter.current()
                        notiCenter.requestAuthorization(options: [.alert, .badge, .sound]) { (didAllow, e) in }
                        notiCenter.delegate = self // 이 코드는 사용자가 알림을 클릭하여 들어온 이벤트를 전달받기 위한 델리게이트 패턴구조
                        // 즉, 알림 센터와 관련하여 뭔가 사건이 발생하면 나(앱 델리게이트) 한테 알려줘 이런 의미임
                        /* 클로저 매개변수 설명
                         사용자가 메시지 창의 알림 동의 여부를 true / false
                         오류 발생시 사용하는 오류 발생 타입의 매개변수 e
                         */
                    } else {
                        // 경고창, 배지, 사운드를 사용하는 알림 환경 정보를 생성하고, 이를 애플리케이션에 저장.
                        let setting = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
                        application.registerUserNotificationSettings(setting) // 생성된 정보 애플리케이션에 등록
                    }
            return true
        }
    
    @available(iOS 10.0, *)
          func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
              if notification.request.identifier == "wakeup" { // 로컬 알림 등록시 입력한 식별 아이디를 읽어오는 속성
                  let userInfo = notification.request.content.userInfo // 유저가 커스텀으로 정의한 정보를 읽어오는 역할
                  print(userInfo["name"]!) // 딕셔너리 값을 출력
              }
              // 알림 배너 띄워주기
              completionHandler([.alert, .badge, .sound])
          }
    
    @available(iOS 10.0, *)
        func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
            /*
             앞에서와 비슷하지만, 이 메소드는 실제로 사용자가 알림 메시지를 클릭 했을 경우에 실행된다는 차이를 가짐.
             이떄 알림 메시지에 대한 정보는 모두 위 메소드의 두번쨰 인자값인 response 매개변수에 담겨 전달됩니다.
             */
            
            if response.notification.request.identifier == "wakeup" {
                let userInfo = response.notification.request.content.userInfo
                print(userInfo["name"]!)
            }
            completionHandler()
        }


}
