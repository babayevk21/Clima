//
//  WeatherManager.swift
//  Clima
//
//  Created by Babayev Kamran on 30.11.22.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=f3f3aa1951f2082a0defb2236fae33ce&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        print(urlString)
        performRequest(with: urlString)
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        let url = URL(string: urlString)
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url!) { data, responce, error in
            if let error = error {
                delegate?.didFailWithError(error: error)
                return
            }
            
            if let safeData = data {
                if let weather = parseJSON(safeData) {
                    delegate?.didUpdateWeather(self, weather: weather)
                }
            }
        }
        task.resume()
    }
    
func parseJSON(_ weatherData: Data) -> WeatherModel? {
    let decoder = JSONDecoder()
    
    do {
        let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
        
        let id = decodedData.weather.first?.id
        let city =  decodedData.name
        let temp = String(format: "%.0f", decodedData.main.temp)
        let minTemp = decodedData.main.temp_min
        let maxTemp = decodedData.main.temp_max
        let feelsLike = decodedData.main.feels_like
        let windSpeed = decodedData.wind.speed
        let description = decodedData.weather.first?.description
        
        print(city)

        let weather = WeatherModel(conditionID: id!, cityName: city, temperature: temp, minTemperature: minTemp, maxTemperature: maxTemp, feelsLikeTemp: feelsLike, windSpeed: windSpeed, weatherDescription: description!)
        return weather
        
    } catch {
        delegate?.didFailWithError(error: error)
        print(error)
        return nil
    }
}
}
