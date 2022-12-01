//
//  WeatherModel.swift
//  Clima
//
//  Created by Babayev Kamran on 01.12.22.
//

import Foundation

struct WeatherModel {
    let conditionID: Int
    let cityName: String
    let temperature: String
    let minTemperature: Double
    let maxTemperature: Double
    let feelsLikeTemp: Double
    let windSpeed: Double
    let weatherDescription: String
    
    var conditionName: String {
        switch conditionID {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "smoke"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud"
        default:
            return "thermometer.medium.slash"
        }
    }
}
