//
//  WeatherData.swift
//  WeatherApp
//
//  Created by Ricardo Martinez on 11/19/20.
//

import UIKit

struct WeatherDataForCell: Decodable {
    let current: Temp
    let hourly : [Hourly]
    let daily  : [Daily]
}
struct CellArray {
    static var array: [WeatherDataForCell] = []
 }

struct WeatherData: Decodable {
    let weather: [Weather]
    let main: Main
    let name: String
}
struct Weather: Decodable {
    let description: String
    let id: Int
}
struct Main: Decodable {
    let temp: Double
}

struct Temp: Decodable {
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
