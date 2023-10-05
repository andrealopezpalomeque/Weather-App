//
//  ViewController.swift
//  Weather App
//
//  Created by Andrea Victoria López Palomeque on 17/09/2023.
//

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate, WeatherManagerDelegate {
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var searchTextField: UITextField!
    
    
    var weatherManager = WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        weatherManager.delegate = self
        searchTextField.delegate = self //the text field should report back to our viewcontroller
    }

    //pressed the search button:
    @IBAction func searchPressed(_ sender: Any) {
        searchTextField.endEditing(true)
        print(searchTextField.text!)
    }
    //pressed go in the keyboard:
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        print(searchTextField.text!)
        return true
    }
    
    //validation for what the user types
    //if it tries to search without typing: the placeholder tells the user to type something
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        //textField is a reference to the searchTextField
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Type smth to continue"
            return false
        }
    }
    
    
    //end editing the search text field
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        //use searchTextField.text to get the weather of that city
        if let city = searchTextField.text{
            weatherManager.fetchWeather(cityName: city)
        }
        
        searchTextField.text = ""
    }
    
    func didUpdateWeather(weather: WeatherModel) {
        DispatchQueue.main.async{
            self.temperatureLabel.text = weather.temperatureString
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            self.cityLabel.text = weather.cityName
        }
      
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

