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
        
        init(from decoder: Decoder) throws {
            let container: KeyedDecodingContainer<FoodData.FoodItem.CodingKeys> = try decoder.container(keyedBy: FoodData.FoodItem.CodingKeys.self)
            self.food = try container.decode(String.self, forKey: .food)
            let price = try container.decode(String.self, forKey: .price)
            self.price = Int(price) ?? -1
        }
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
        }
        
        let request = URLRequest(url: URL(string: url)!)
        
        let sem: DispatchSemaphore = .init(value: 0)
        var foodData: FoodData? = nil
        print(url)
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            defer { sem.signal() }
            guard error == nil else {
                return
            }
            guard let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                return
            }
            do {
                foodData = try JSONDecoder().decode(FoodData.self, from: data)
            } catch (let error) {
                print(String(describing: error))
            }
        }
        dataTask.resume()
        sem.wait()
        return foodData
    }
}
