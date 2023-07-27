//
//  FoodSession.swift
//  SchoolFoodAlarm
//
//  Created by Yong Ha Kim on 7/27/23.
//

import Foundation

struct FoodData: Codable {
    let id: Int
    let name: String
    let menu: [FoodMenu]
    
    struct FoodMenu: Codable {
        let time: String
        let menu: [FoodItem]
    }
    
    struct FoodItem: Codable {
        let food: String
        let price: Int
    }
}

enum Restaurant {
    case res13
    // case res14
    // case res...
}

class FoodDataSession {
    public static let shared = FoodDataSession()
    private let API_URL = "https://prod.backend.hyuabot.app/rest/cafeteria/campus/2/"
    private let res13 = "restaurant/13/"

    private init() {

    }

    public func loadMenus(_ restaurant: Restaurant) -> FoodData? {
        var url = API_URL
        switch restaurant {
            case .res13:
            url += res13
            break
            default:
            return nil
        }
        AF.request(url).responseString(encoding: .utf8) { response in
            switch response.result {
            case .success(let json):
                let data = try? JSONDecoder().decode(FoodData.Self, from: json)
                print(data)
                return data;

            case .failure(let error):
                print("Error fetching data: \(error.localizedDescription)")
                return nil
            }
        }
        return nil
    }
}
