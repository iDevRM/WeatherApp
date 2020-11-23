//
//  WeatherData.swift
//  WeatherApp
//
//  Created by Ricardo Martinez on 11/19/20.
//

import UIKit

struct WeatherDataForCell: Decodable {
    let hourly : [Weather]
    let daily  : [Daily]
}

struct Weather: Decodable {
    let temp: Double
    let weather: [ID]
}

struct ID: Decodable {
    let id: Int
}

let date = Date()

struct CellArray {
    var hour       : String 
    let id         : Int
    let temp       : Double
    
    static var array: [CellArray] = []
 }





struct Main: Decodable {
    let temp: Double
}



struct Hourly: Decodable {
    let temp: Double
}

struct Daily: Decodable {
    let temp: Max
}
struct Max: Decodable {
    let max: Double
}
