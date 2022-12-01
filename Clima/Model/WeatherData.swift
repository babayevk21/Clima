//
//  WeatherData.swift
//  Clima
//
//  Created by Babayev Kamran on 30.11.22.
//

import Foundation

struct WeatherData: Codable {
    let name: String
    let main: Main
    let wind: Wind
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
}

struct Wind: Codable {
    let speed: Double
}

struct Weather: Codable {
    let description: String
    let id: Int
}
