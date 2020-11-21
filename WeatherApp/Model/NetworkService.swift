//
//  NetworkService.swift
//  WeatherApp
//
//  Created by Ricardo Martinez on 11/20/20.
//

import Foundation


struct NetworkService {
    let URL_WeatherForCell = "https://api.openweathermap.org/data/2.5/onecall?units=imperial&appid=0f087dcd4dda0e949be5313b2b84ed7f"
    let URL_Weather = "https://api.openweathermap.org/data/2.5/weather?appid=0f087dcd4dda0e949be5313b2b84ed7f&units=imperial"
    
    var removed = false
    
    func fetchWeatherForCell(lat: Double, long: Double) {
        let urlString = "\(URL_WeatherForCell)&lat=\(lat)&lon=\(long)"
        performRequest(urlString: urlString)
    }
    
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
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherDataForCell.self, from: weatherData)
            CellArray.array.append(CellArray(hour: "10:00", id: decodedData.hourly[0].weather[1].id, temp: decodedData.hourly[0].temp))
        } catch {
            print(error)
        }
        
    }
}
