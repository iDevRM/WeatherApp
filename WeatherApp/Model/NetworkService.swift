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
                    if url.description.contains("onecall") {
                        parseJSONForCell(weatherData: safeData)
                    } else {
                        parseJSON(weatherData: safeData)
                    }
                }
            }
            
            //4.Start task
            task.resume()
            
        }
    }
    
    func parseJSONForCell(weatherData: Data) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherDataForCell.self, from: weatherData)
            CellArray.array.removeAll()
            CellArray.array.append(CellArray(hour: "10:00", id: decodedData.hourly[1].weather[0].id, temp: decodedData.hourly[1].temp))
            CellArray.array.append(CellArray(hour: "12:00", id: decodedData.hourly[3].weather[0].id, temp: decodedData.hourly[3].temp))
            CellArray.array.append(CellArray(hour: "2:00", id: decodedData.hourly[5].weather[0].id, temp: decodedData.hourly[5].temp))
            CellArray.array.append(CellArray(hour: "4:00", id: decodedData.hourly[7].weather[0].id, temp: decodedData.hourly[7].temp))
            CellArray.array.append(CellArray(hour: "6:00", id: decodedData.hourly[9].weather[0].id, temp: decodedData.hourly[9].temp))
        } catch {
            print(error)
        }
        
    }
    
    func parseJSON(weatherData:Data) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            WeatherDataArray.array.removeAll()
            WeatherDataArray.array.append(WeatherDataArray(cityName: decodedData.name, description: decodedData.weather[0].description, temp: decodedData.main.temp, id: decodedData.weather[0].id))
        } catch {
            print(error)
        }
    }
}
