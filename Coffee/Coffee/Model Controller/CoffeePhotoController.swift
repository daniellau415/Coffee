//
//  CoffeePhotoController.swift
//  Coffee
//
//  Created by Daniel Lau on 6/18/18.
//  Copyright © 2018 Daniel Lau. All rights reserved.
//

import UIKit

class CoffeePhotoController {
    
    static let shared = CoffeePhotoController()
    
    var items : [Item] = []

    func searchCoffePhotoLink(with searchID: String, completion: @escaping([Item]?) -> Void ) {
        let queries = [
            "v" : "20180618",
            //            "client_id" : "HPSDD5GDWPLXUZVAS5WOQT35O1STA0WWAGAY5RTAC1PTKZWW",
            //            "client_secret" : "NXOFPSLOSBZOPYKTZTTJZZ3RJTNKNJ3QTNO501WRL152H2L0",
            "client_id" : "QQBSD4K1LFOV132B4PEV04QDJC3RAL2KVGV1E05KPLZT2KNW",
            "client_secret" : "KB1Z4RF0DIKYM1Z4IHOOZBS0RSGGYGVV45XIFYPE4ORKYKYJ",
            
            ]
        let baseURL = URL(string: "https://api.foursquare.com/v2/venues/\(searchID)/photos?")!
        
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        
        let queryItems = queries.compactMap({ URLQueryItem(name: $0.key, value: $0.value )})
        components?.queryItems = queryItems
        
        guard let requestURL = components?.url else { completion(nil); return }
  
        let dataTask = URLSession.shared.dataTask(with: requestURL) { (data, response, error) in
            if let data = data {
                let jsonDecoder = JSONDecoder()
                do {
                    let decodedData = try jsonDecoder.decode(CoffeePhoto.self, from: data)
                    let arrayOfItems = decodedData.response.photos.items.compactMap({$0})
                    self.items = arrayOfItems
                    completion(arrayOfItems)
                } catch let error {
                    print("error decoding photo", error)
                    completion(nil)
                    return
                }
            }
        }
        dataTask.resume()
    }
    
    func dataToPhoto(with suffixURL: String, completion: @escaping(UIImage?) -> Void) {
        let photoURL = URL(string: "https://igx.4sqi.net/img/general/200x200")!
        let url = photoURL.appendingPathComponent(suffixURL)
        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                let image = UIImage(data: data)
                completion(image)
            }
            if let error = error {
                print(error)
                completion(nil)
                return
            }
        }
        dataTask.resume()
    }
}
