//
//  Coffee.swift
//  Coffee
//
//  Created by Daniel Lau on 6/18/18.
//  Copyright © 2018 Daniel Lau. All rights reserved.
//

import Foundation

struct CoffeeDictionary : Codable {
    let response : Response
}

struct Response : Codable {
    let venues : [CoffeeVenue]
}

struct CoffeeVenue : Codable {
    let name : String
    let id : String
    let location : Location
}

struct Location : Codable {
    let address: String
    let lat: Double
    let lng : Double
    let distance : Int
    let city : String
    let state : String
}

