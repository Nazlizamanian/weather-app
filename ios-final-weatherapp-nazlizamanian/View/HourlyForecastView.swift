//
//  HourlyForecastView.swift
//  ios-final-weatherapp-nazlizamanian
//
//  Created by Nazli  on 14/01/25.
//

import SwiftUI

struct HourlyForecastView: View{
    
    var hourly: WeatherData.Hourly
    
    //Source: ChatGPT function extraHour improved version
    private func extractHour(from timestamp: String) -> String {
        // Extract hour from timestamp string
        guard let index = timestamp.firstIndex(of: "T") else {
            return timestamp // Return original timestamp if "T" is not found
        }
        let hourSubstring = timestamp[index...]
        return String(hourSubstring.dropFirst()) // Remove "T" and return the hour part
    }
    
    var body: some View{
        VStack{
            ScrollView(.horizontal, showsIndicators: false){
                HStack(spacing: 20){
                    ForEach(0..<hourly.temperature2m.count, id: \.self){ index in //går igenom [] av temp .count O(1), dynamically adapts size of the array
                        let hour = extractHour(from: hourly.time[index])
                        let isDay = hourly.isDay[index] == 1 // retrives the value of that index position
                        
                        VStack{
                            Text(hour)
                                .font(.headline)
                            
                            Image(systemName: isDay ? "sun.max.fill": "moon.fill")
                                .foregroundColor(isDay ? .yellow : .white)
                            
                            Text("\(String(format: "%.0f", hourly.temperature2m[index])) °C")
                                .shadow(radius: 5)
                        }
                        .padding()
                    }
                    
                }//HStack
                .padding(.horizontal)
                
            }//ScrollView
            
        }//VStack
        .background(Color.white.opacity(0.5))
        .cornerRadius(16)
        .padding()
    }
}

