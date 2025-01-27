//
//  DailyForecastView.swift
//  ios-final-weatherapp-nazlizamanian
//
//  Created by Nazli  on 14/01/25.
//

import SwiftUI

struct DailyForecastView: View {
    
    var daily: WeatherData.Daily
   
    var body: some View {
        VStack( spacing: 15) {
            HStack(){
                Image(systemName: "calendar")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width:20, height:20)
                    .foregroundColor(Color.white.opacity(0.6))
                Text("7-DAY FORECAST")
                    .font(.subheadline)
                    .foregroundColor(Color.white.opacity(0.6))
            }//HStack
            .padding(.top)
            
            ForEach(0..<7, id: \.self) { index in
                let day = Calculations.dayOfWeek(for: daily.time[index])

                HStack {
                    Text(day)
                        .fontWeight(.bold)
                        .font(.title2)
                      //  .frame(width: 135, alignment: .leading)
                    Spacer()
                    
                    Image(systemName: Calculations.weatherCondition(for: daily.weatherCode[index]))
                        
                    Spacer()
                    
                    Text("\(String(format: "%.0f", daily.temperature2mMin[index]))°")
                        .foregroundColor(Color.white.opacity(0.6))
                        .font(.title2)
                    
                    RoundedRectangle(cornerRadius: 16) //Our weather bar 
                        .fill(Calculations.temperatureColors(minTemp: daily.temperature2mMin[index], maxTemp: daily.temperature2mMax[index]))
                        .frame(width: 70, height: 6)

                    
                    Text("\(String(format: "%.0f", daily.temperature2mMax[index]))°")
                        .font(.title2)
                    }//HStack
                .padding(7)
                
            }//ForEach
           
            
        }//VStack
        
       // .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16))
        .background(Color.white.opacity(0.5))
        .cornerRadius(16)
        .padding()
    }
    
}
