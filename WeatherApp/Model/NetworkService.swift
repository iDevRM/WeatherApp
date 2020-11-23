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
    
    let date = Date()
    let calendar = Calendar.current
    
    
    
    
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
                    if url.description.contains("onecall") && WeatherVC.dailyWeather == false {
                        parseJSONForHourlyCell(weatherData: safeData)
                    } else if url.description.contains("onecall") && WeatherVC.dailyWeather != false{
                        parseJSONForDailyCell(weatherData: safeData)
                    } else {
                        parseJSON(weatherData: safeData)
                    }
                }
            }
            
            //4.Start task
            task.resume()
            
        }
    }
    
    func parseJSONForHourlyCell(weatherData: Data) {
        let decoder = JSONDecoder()
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        func correctHour(_ num: Int) -> Int {
            if num  > 12 {
                return num - 12
            } else {
                return num
            }
        }
        do {
            let decodedData = try decoder.decode(WeatherDataForCell.self, from: weatherData)
            HourlyCellArray.array.removeAll()
            HourlyCellArray.array.append(HourlyCellArray(hour: "\(correctHour(hour + 1)):\(minutes)", id: decodedData.hourly[1].weather[0].id, temp: decodedData.hourly[1].temp))
            HourlyCellArray.array.append(HourlyCellArray(hour: "\(correctHour(hour + 2)):\(minutes)", id: decodedData.hourly[2].weather[0].id, temp: decodedData.hourly[2].temp))
            HourlyCellArray.array.append(HourlyCellArray(hour: "\(correctHour(hour + 3)):\(minutes)", id: decodedData.hourly[3].weather[0].id, temp: decodedData.hourly[3].temp))
            HourlyCellArray.array.append(HourlyCellArray(hour: "\(correctHour(hour + 4)):\(minutes)", id: decodedData.hourly[4].weather[0].id, temp: decodedData.hourly[4].temp))
            HourlyCellArray.array.append(HourlyCellArray(hour: "\(correctHour(hour + 5)):\(minutes)", id: decodedData.hourly[5].weather[0].id, temp: decodedData.hourly[5].temp))
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
    func parseJSONForDailyCell(weatherData: Data) {
        let decoder = JSONDecoder()
        let day = calendar.component(.weekday, from: date)
        
        func returnWeekday(_ day: Int) -> String {
            var x = 0
            if day > 7 {
                x = day - 7
            } else {
                x = day
            }
            
            switch x {
            case 1:
                return "Sun"
            case 2:
                return "Mon"
            case 3:
                return "Tue"
            case 4:
                return "Wed"
            case 5:
                return "Thu"
            case 6:
                return "Fri"
            default:
                return "Sat"
            }
        }
        
        do {
            let decodedData = try decoder.decode(WeatherDataForCell.self, from: weatherData)
            DailyCellArray.array.removeAll()
            DailyCellArray.array.append(DailyCellArray(day: returnWeekday(day + 1), id: decodedData.daily[1].weather[0].id, temp: decodedData.daily[1].temp.max))
            DailyCellArray.array.append(DailyCellArray(day: returnWeekday(day + 2), id: decodedData.daily[2].weather[0].id, temp: decodedData.daily[2].temp.max))
            DailyCellArray.array.append(DailyCellArray(day: returnWeekday(day + 3), id: decodedData.daily[3].weather[0].id, temp: decodedData.daily[3].temp.max))
            DailyCellArray.array.append(DailyCellArray(day: returnWeekday(day + 4), id: decodedData.daily[4].weather[0].id, temp: decodedData.daily[4].temp.max))
            DailyCellArray.array.append(DailyCellArray(day: returnWeekday(day + 5), id: decodedData.daily[5].weather[0].id, temp: decodedData.daily[5].temp.max))
        } catch {
            print(error)
        }
    }
}

