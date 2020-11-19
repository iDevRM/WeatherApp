//
//  WeatherData.swift
//  WeatherApp
//
//  Created by Ricardo Martinez on 11/19/20.
//

import UIKit

struct WeatherData {
   let date:        String?
   let location:    String?
   let description: String?
   let temperature: String?
   let image:       UIImage?
    
    static var array: [WeatherData] = [WeatherData(date: "10:00", location: nil, description: nil, temperature: "75", image: WeatherImages.sunny ),WeatherData(date: "10:00", location: nil, description: nil, temperature: "75", image: WeatherImages.sunny ),WeatherData(date: "10:00", location: nil, description: nil, temperature: "75", image: WeatherImages.sunny ),WeatherData(date: "10:00", location: nil, description: nil, temperature: "75", image: WeatherImages.sunny ),WeatherData(date: "10:00", location: nil, description: nil, temperature: "75", image: WeatherImages.sunny )]
}
