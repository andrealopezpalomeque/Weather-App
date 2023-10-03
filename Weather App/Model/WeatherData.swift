//
//  WeatherData.swift
//  Weather App
//
//  Created by Andrea Victoria López Palomeque on 02/10/2023.
//

import Foundation

struct WeatherData: Codable  {
    let name: String
    let main: Main
    let weather: [Weather]
    
    
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let description: String
    let id: Int
}
