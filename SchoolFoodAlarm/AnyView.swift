//
//  AnyView.swift
//  SchoolFoodAlarm
//
//  Created by 최영우 on 7/27/23.
//

import Foundation
import UIKit

struct AnyView: View {

    var body: some View {
        // ...
        }
        .onAppear() {
            // Setting push notification
            PushNotificationHelper.shared.setAuthorization()
    }
}
