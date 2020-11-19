//
//  WeatherData.swift
//  WeatherApp
//
//  Created by Ricardo Martinez on 11/19/20.
//

import UIKit

struct WeatherData: Codable {
   let date:        String?
   let location:    String?
   let description: String?
   let temperature: String?
   let image:       String?
    
   static var array: [WeatherData] = []
}
