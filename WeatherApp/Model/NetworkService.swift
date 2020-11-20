//
//  NetworkService.swift
//  WeatherApp
//
//  Created by Ricardo Martinez on 11/20/20.
//

import Foundation


struct NetworkService {
    let URL_Weather = "https://pro.openweathermap.org/data/2.5/forecast/hourly?appid=0f087dcd4dda0e949be5313b2b84ed7f"
    
    func fetchWeather(lat: Double, long: Double) {
        let urlString = "\(URL_Weather)&lat=\(lat)&lon=\(long)"
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String) {
        //1.Create a URL
        if let url = URL(string: urlString) {
            //2.Create a URLSession
            let session = URLSession(configuration: .default)
            //3.Give session a task
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                
                if let safeData = data {
                    parseJSON(weatherData: safeData)
                }
            }
            
            //4.Start task
            task.resume()
            
        }
    }
    
    func parseJSON(weatherData: Data) {
        let decoder  = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            print(decodedData.main.temp)
        } catch {
            print(error)
        }
        
    }
}
