//
//  WeatherVC.swift
//  WeatherApp
//
//  Created by Ricardo Martinez on 11/19/20.
//

import UIKit
import CoreLocation

class WeatherVC: UIViewController {
    @IBOutlet weak var todaysDateLabel:       UILabel!
    @IBOutlet weak var locationLabel:         UILabel!
    @IBOutlet weak var weatherLabel:          UILabel!
    @IBOutlet weak var imageView:             UIImageView!
    @IBOutlet weak var todayAndWeeklyControl: UISegmentedControl!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var refreshButton:         UIButton!
    @IBOutlet weak var temperatureLabel:      UILabel!
    
    
    let dateFormatter   = DateFormatter()
    let networkService  = NetworkService()
    let locationManager = CLLocationManager()
    
    static var dailyWeather = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        collectionView.delegate   = self
        collectionView.dataSource = self
        locationManager.delegate  = self
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()

        setTime()
    }
    
    @IBAction func segmentedControlTapped(_ sender: UISegmentedControl) {
        WeatherVC.dailyWeather = !WeatherVC.dailyWeather
        locationManager.requestLocation()
        collectionView.reloadData()
    }
    
    
    @IBAction func refreshButtonTapped(_ sender: UIButton) {
        locationManager.requestLocation()
        collectionView.reloadData()
    }
    
    func setTime() {
        dateFormatter.dateStyle = .medium
        todaysDateLabel.text = dateFormatter.string(from: Date())
    }
    
    func setAllLabels() {
        let temp = String(format: "%0.f", WeatherDataArray.array[0].temp)
        temperatureLabel.text = "\(temp)°F"
        locationLabel.text = WeatherDataArray.array[0].cityName
        weatherLabel.text = WeatherDataArray.array[0].description.capitalized
        
        switch WeatherDataArray.array[0].id {
        case 200...232:
            return imageView.image = WeatherImages.lighning
                case 300...321,500...531:
                    return imageView.image = WeatherImages.rainy
                case 600...622:
                    return imageView.image = WeatherImages.snow
                case 800:
                    return imageView.image = WeatherImages.sunny
                case 801...804:
                    return imageView.image = WeatherImages.sunAndCloud
                default:
                    return imageView.image = WeatherImages .cloudy
        }
    }
}
//MARK: - Collection View Data Source and Delegat methods

extension WeatherVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if WeatherVC.dailyWeather == false {
            return HourlyCellArray.array.count
        } else {
            return DailyCellArray.array.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "weatherCell", for: indexPath) as? WeatherCollectionViewCell {
            if WeatherVC.dailyWeather {
                cell.updateDailyCell(weatherData: DailyCellArray.array[indexPath.row])
            } else {
                cell.updateHourlyCell(weatherData: HourlyCellArray.array[indexPath.row])
            }
            return cell
        }
        return UICollectionViewCell()
    }
}

//MARK: - CLLocationManagerDelegate

extension WeatherVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        var long: Double {
            return locations[0].coordinate.longitude
        }
        var lat : Double {
            return locations[0].coordinate.latitude
        }
        networkService.fetchWeather(lat: lat, long: long)
        networkService.fetchWeatherForCell(lat: lat, long: long)
        setAllLabels()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
       
    }
}
