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
struct Main: Decodable {
    let temp: Double
}

struct Hourly: Decodable {
    let temp: Double
}

struct Daily: Decodable {
    let temp: Max
    let weather: [ID]
}
struct Max: Decodable {
    let max: Double
}



struct HourlyCellArray {
    var hour       : String 
    var id         : Int
    var temp       : Double
    
    static var array: [HourlyCellArray] = []
 }


struct DailyCellArray {
    var day: String
    var id: Int
    var temp: Double
    
    static var array: [DailyCellArray] = []
}


