//
//  WeatherCollectionViewCell.swift
//  WeatherApp
//
//  Created by Ricardo Martinez on 11/19/20.
//

import UIKit

class WeatherCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var topLabel:    UILabel!
    @IBOutlet weak var imageView:   UIImageView!
    @IBOutlet weak var bottomLabel: UILabel!
    
    func updateCell(weatherData: WeatherData) {
        topLabel.text    = weatherData.date
        imageView.image  = weatherData.image
        bottomLabel.text = "\(weatherData.temperature!) °F"
    }
    
}
