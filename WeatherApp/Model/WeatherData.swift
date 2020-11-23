//
//  WeatherData.swift
//  WeatherApp
//
//  Created by Ricardo Martinez on 11/23/20.
//

import Foundation

struct WeatherData: Decodable {
    let weather: [IdAndDescription]
    let main: Temp
    let name: String

}


struct IdAndDescription: Decodable {
    let id: Int
    let description: String
}
struct Temp: Decodable {
    let temp: Double
}
struct WeatherDataArray {
    let cityName: String
    let description: String
    let temp: Double
    let id: Int
    
    
    static var array: [WeatherDataArray] = [WeatherDataArray(cityName: "", description: "", temp: 80.0, id: 800)]
}
