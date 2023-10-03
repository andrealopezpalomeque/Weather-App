//
//  WeatherManager.swift
//  Weather App
//
//  Created by Andrea Victoria López Palomeque on 26/09/2023.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(weather: WeatherModel)
}

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=68b7c156eea87dffc9705b2fdb989281&&units=metric"
    
    var delegate : WeatherManagerDelegate?
    
    func fetchWeather(cityName: String){
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(urlString: urlString)
    }
    
    //function that performs the networking that fetches the live data from openWeather
    func performRequest(urlString: String){
        //1. create url
        if let url = URL(string: urlString){
            //2. create URLSession
            let session = URLSession(configuration: .default)
            //3. GIVE the session a TASK -> create a task that retrieves the contents of the specified URL, then calls a handler upon completion
            
            //closure format -> anonymous function
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    if let weather = self.parseJSON(weatherData: safeData){
                        self.delegate?.didUpdateWeather(weather: weather)
                    }
                }
            }
            
        //4. START the task -> you need to call resume()
            task.resume()
        }
    }
    
    
    //function that pass the weather into a swift object
    func parseJSON(weatherData: Data)-> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            return weather
            
           
        }  catch{
            print(error)
            return nil
        }
    }
    

}
