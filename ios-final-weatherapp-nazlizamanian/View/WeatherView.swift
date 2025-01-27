//
//  WeatherView.swift
//  ios-final-weatherapp-nazlizamanian
//
//  Created by Nazli  on 19/06/24.
//

import SwiftUI
import CoreLocation
import CoreLocationUI
import SpriteKit //Backrund more details -> Model -> Condition

struct WeatherView: View {
    @State private var model = WeatherModel()
    @State private var locationService = LocationManager()//init 

    var body: some View {
        ZStack {
            // Background
            VStack {
                if model.isLoading {
                    ProgressView()
                } else if let weatherData = model.weatherData {
                   
                   
                  
                  if weatherData.current.isDay == 1 { // Day time
                        
                        LinearGradient(gradient: Gradient(colors: [Color.blue, Color.cyan]), startPoint: .top, endPoint: .bottom)
                            .ignoresSafeArea()
                            .zIndex(0)
                    }
                    else { // Night time
                       
                        Image("night2")
                            .resizable()
                            .scaledToFill()
                            .ignoresSafeArea()
                            .zIndex(0)
                    }
                }
            }

            // Content
            VStack {
                if let weatherData = model.weatherData {
                    ScrollView {
                        Text("My Location")
                            .font(.largeTitle)
                            .fontWeight(.light)
                            .foregroundStyle(.white)
                            .shadow(radius: 5)
                            .padding(.top, 30)

                        if let city = locationService.address?.locality {
                            Text("\(city)")
                                .font(.headline)
                                .fontWeight(.bold)
                        } else {
                            Text("City unknown")
                        }

                        Spacer()

                        Text("\(String(format: "%.0f", weatherData.current.temperature2m)) °C")
                            .fontWeight(.light)
                            .font(.system(size: 45))

                        Text("H:\(String(format: "%.0f", weatherData.daily.temperature2mMax.first ?? 0)) ° L:\(String(format: "%.0f", weatherData.daily.temperature2mMin.first ?? 0)) °") // first returns Dobule? by default if value is nil use 0 default value
                            .foregroundStyle(.white)
                            .shadow(radius: 5)

                        HourlyForecastView(hourly: weatherData.hourly)
                        DailyForecastView(daily: weatherData.daily)
                    }
                } else {
                    Text("Failed to fetch weather data.")
                }
            }//VStack
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .zIndex(1)  // Make sure the content is on top of the background
        }
        .onAppear {
            locationService.onLocationUpdate = { location in
                Task {// wrapp in Task to not block the main thread making sure we run on background threads so UI is still responsive. 
                    //Must be await in order to wait for getData and getData is resposnbile for makking the network request which takes time and by marking it with await we ensure that setCoordinates doesnt proceed until getData has gotten data so UI updates only happen after that.
                    await model.setCoordinates(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                }
            }
            locationService.requestLocation()
        }
    }
}

#Preview {
    WeatherView()
}
