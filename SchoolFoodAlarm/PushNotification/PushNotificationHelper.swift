//
//  PushNotificationHelper.swift
//  SchoolFoodAlarm
//
//  Created by 최영우 on 7/27/23.
//

import Foundation
import UIKit

func pushNotification(title: String, body: String, seconds: Double, identifier: String) {
    // 1️⃣ 알림 내용, 설정
    let notificationContent = UNMutableNotificationContent()
    notificationContent.title = title
    notificationContent.body = body

    // 2️⃣ 조건(시간, 반복)
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: seconds, repeats: false)

    // 3️⃣ 요청
    let request = UNNotificationRequest(identifier: identifier,
                                        content: notificationContent,
                                        trigger: trigger)

    // 4️⃣ 알림 등록
    UNUserNotificationCenter.current().add(request) { error in
        if let error = error {
            print("Notification Error: ", error)
        }
    }
}


