//
//  WeatherManager.swift
//  Weather App
//
//  Created by Andrea Victoria López Palomeque on 26/09/2023.
//

import Foundation

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=68b7c156eea87dffc9705b2fdb989281&&units=metric"
    
    func fetchWeather(cityName: String){
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String){
        //1. create url
        if let url = URL(string: urlString){
            //2. create URLSession
            let session = URLSession(configuration: .default)
            //3. GIVE the session a task
            
            
            
            //closure format
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                  
                }
            }
            
        //4. START the task ->
            task.resume()
        }
        
        func parseJSON(weatherData: Data){
            
        }
    }
}
