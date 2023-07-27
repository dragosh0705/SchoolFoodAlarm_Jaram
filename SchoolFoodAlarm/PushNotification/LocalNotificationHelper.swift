//
//  LocalNotificationHelper.swift
//  SchoolFoodAlarm
//
//  Created by 최영우 on 7/27/23.
//

import Foundation
import UIKit

class LocalNotificationHelper {
    static let shared = LocalNotificationHelper()
    
    private init() { }
    
    func setAuthorization() {
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound] // 필요한 알림 권한을 설정
        UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: { _, _ in }
        )
    }
}
