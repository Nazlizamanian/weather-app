//
//  WeatherData.swift
//  ios-final-weatherapp-nazlizamanian
//
//  Created by Nazli  on 19/06/24.
//
import Foundation
// reprsenets the data that will be decoded from our json response
//weatherData.current.is
struct WeatherData: Decodable {
    struct Current: Decodable {
        let temperature2m: Double
        let isDay: Int? 
        let weatherCode: Int

        enum CodingKeys: String, CodingKey { // to map or strcuts proprties to <-> key names in json data
            case temperature2m = "temperature_2m"
            case isDay = "is_day"
            case weatherCode = "weather_code"
        }
    }
    

    struct Hourly: Decodable {
        let temperature2m: [Double]
        let isDay: [Int]
        let time: [String]

        enum CodingKeys: String, CodingKey {
            case temperature2m = "temperature_2m"
            case isDay = "is_day"
            case time
        }
    }

    struct Daily: Decodable {
        let time: [String]
        let weatherCode: [Int]
        let temperature2mMax: [Double]
        let temperature2mMin: [Double]

        enum CodingKeys: String, CodingKey {
            case time
            case weatherCode = "weather_code"
            case temperature2mMax = "temperature_2m_max"
            case temperature2mMin = "temperature_2m_min"
        }
    }

    let current: Current
    let hourly: Hourly
    let daily: Daily
}
