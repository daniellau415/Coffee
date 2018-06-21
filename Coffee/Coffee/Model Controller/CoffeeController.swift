//
//  CoffeeController.swift
//  Coffee
//
//  Created by Daniel Lau on 6/18/18.
//  Copyright © 2018 Daniel Lau. All rights reserved.
//

import Foundation
import CoreLocation

class CoffeeController {
    
    static let shared = CoffeeController()
    
    //SOURCE OF TRUTH
    
    var coffeevenues : [CoffeeVenue] = []

    func searchCoffee(with location: CLLocationCoordinate2D, completion: @escaping([CoffeeVenue]?) -> Void) {

        let coffeeURL = URL(string: "https://api.foursquare.com/v2/venues/search?ll=\(location.latitude),\(location.longitude)&v=20180618&&categoryId=4bf58dd8d48988d1e0931735&query=coffee&limit=3&radius=5000&client_id=HPSDD5GDWPLXUZVAS5WOQT35O1STA0WWAGAY5RTAC1PTKZWW&client_secret=NXOFPSLOSBZOPYKTZTTJZZ3RJTNKNJ3QTNO501WRL152H2L0")!

        let dataTask = URLSession.shared.dataTask(with: coffeeURL) { (data, response, error) in
            if let data = data {
                let jsonDecoder = JSONDecoder()
                jsonDecoder.dateDecodingStrategy = .iso8601
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                do {
                    let decodedData = try jsonDecoder.decode(CoffeeDictionary.self, from: data)
                    let coffee = decodedData.response.venues.compactMap({$0})
                    self.coffeevenues = coffee
                    completion(coffee)
                } catch let error {
                    print("error", error.localizedDescription)
                    completion(nil)
                    return
                }
            }
        }
        dataTask.resume()
    }
}
