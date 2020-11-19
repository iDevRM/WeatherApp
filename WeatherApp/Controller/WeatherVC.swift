//
//  WeatherVC.swift
//  WeatherApp
//
//  Created by Ricardo Martinez on 11/19/20.
//

import UIKit

class WeatherVC: UIViewController {
    @IBOutlet weak var todaysDateLabel:       UILabel!
    @IBOutlet weak var locationLabel:         UILabel!
    @IBOutlet weak var weatherLabel:          UILabel!
    @IBOutlet weak var imageView:             UIImageView!
    @IBOutlet weak var todayAndWeeklyControl: UISegmentedControl!
    @IBOutlet weak var collectionVIew:        UICollectionView!
    @IBOutlet weak var refreshButton:         UIButton!
    @IBOutlet weak var temperatureLabel:      UILabel!
    
    
    let dateFormatter = DateFormatter()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionVIew.delegate   = self
        collectionVIew.dataSource = self
        
        setTime()
        
    }
    
    @IBAction func refreshButtonTapped(_ sender: UIButton) {
        
    }
    
   
    
    func setTime() {
        dateFormatter.dateStyle = .medium
        todaysDateLabel.text = dateFormatter.string(from: Date())
    }
    
}

extension WeatherVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "weatherCell", for: indexPath) as? WeatherCollectionViewCell {
            cell.updateCell(weatherData: WeatherData.array[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
    
    
}
