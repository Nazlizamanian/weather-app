//
//  WeatherModel.swift
//  ios-final-weatherapp-nazlizamanian
//
//  Created by Nazli  on 19/06/24.
//
import Foundation
import Observation

@Observable //any changes to its properties will auto trigger updates to the views that are observering this class

class WeatherModel {
    private var baseUrl = "https://api.open-meteo.com/v1/forecast"
    
    var isLoading = false
    var weatherData: WeatherData? //can be nil
    
    //takes in a lat & long constrcuts the URL reqieured to fetch weather data
    func setCoordinates(latitude: Double, longitude: Double) async {
        let url = "\(baseUrl)?latitude=\(latitude)&longitude=\(longitude)&current=temperature_2m,is_day,weather_code&hourly=temperature_2m,is_day&daily=weather_code,temperature_2m_max,temperature_2m_min&timezone=auto&forecast_hours=24"
        
        await getData(url: url) //fetches data from url async
    }
    
    //Performs the HTTP req t othe weather api, aka network requests therefore marked w/ await
    func getData(url: String) async {
        guard let apiUrl = URL(string: url) else { return }
        isLoading = true
        
        do {
            let (data, _) = try await URLSession.shared.data(from: apiUrl) // returns a raw data which we pass on to jsondecoder
            let decodedData = try JSONDecoder().decode(WeatherData.self, from: data)
            self.weatherData = decodedData //decodes json response into our weatherData
        } catch {
            print("Error fetching weather data: \(error)")
        }
        
        isLoading = false
    }
}
