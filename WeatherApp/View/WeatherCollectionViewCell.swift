//
//  WeatherCollectionViewCell.swift
//  WeatherApp
//
//  Created by Ricardo Martinez on 11/19/20.
//

import UIKit

class WeatherCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var topLabel   : UILabel!
    @IBOutlet weak var imageView  : UIImageView!
    @IBOutlet weak var bottomLabel: UILabel!
    
    func updateHourlyCell(weatherData: HourlyCellArray) {
        let temp         = String(format: "%0.f", weatherData.temp)
        topLabel.text    = weatherData.hour
        bottomLabel.text = "\(temp) °F"
        
        switch weatherData.id {
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
    
    func updateDailyCell(weatherData: DailyCellArray) {
        let temp = String(format: "%0.f", weatherData.temp)
        topLabel.text    = weatherData.day
        bottomLabel.text = "\(temp) °F"
        
        switch weatherData.id {
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

