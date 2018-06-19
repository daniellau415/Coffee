//
//  CoffeePhoto.swift
//  Coffee
//
//  Created by Daniel Lau on 6/18/18.
//  Copyright © 2018 Daniel Lau. All rights reserved.
//

import Foundation


struct CoffeePhoto: Codable {
    let response : PhotoResponse
}

struct PhotoResponse : Codable {
    let photos : Photo
}

struct Photo : Codable {
    let items : [Item]
}

struct Item : Codable {
    let prefix : String
    let suffix : String
}
