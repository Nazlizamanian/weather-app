//
//  Calculations.swift
//  ios-final-weatherapp-nazlizamanian
//
//  Created by Nazli  on 16/01/25.
//

import Foundation
import SpriteKit
import SwiftUI


//Logic used in DailyForecastView mmoved
struct Calculations {
    
    //Static in swift: behöver ej create instance and can be acccsseed directyl w/ needng to create instance
    static func temperatureColors(minTemp: Double, maxTemp: Double) -> LinearGradient {
        
        if minTemp <= 0 && maxTemp <= 10 {//Cold temperatures
            return LinearGradient( gradient: Gradient(colors: [Color.blue, Color.cyan]), startPoint: .leading, endPoint: .trailing )
        }
        else if minTemp > 0 && maxTemp <= 15 { // middle varm
            return LinearGradient(gradient: Gradient(colors: [Color.cyan, Color.yellow]), startPoint: .leading, endPoint: .trailing)
        }
        
        else if minTemp >= 10  && maxTemp >= 16 { //HOT
            return LinearGradient( gradient: Gradient(colors: [Color.orange, Color.red]), startPoint: .leading, endPoint: .trailing )
        }
        else { //otherwise cold
            return LinearGradient( gradient: Gradient(colors: [Color.white, Color.gray]), startPoint: .leading, endPoint: .trailing)
        }
    }

    
    /*
     Source for time conversions: 1. https://medium.com/@jpmtech/swiftui-format-dates-and-times-the-easy-way-fc896b25003b
     
     2. https://domo-support.domo.com/s/article/360058792094?language=en_US
     */
    static func dayOfWeek(for dateString: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd" // Expected input format

        // Parse the date from the input string
        guard let date = formatter.date(from: dateString) else {
            return "Unknown"
        }

        if Calendar.current.isDateInToday(date) {
            return "Today"
        }

        // Get the day of the week as a string
        formatter.dateFormat = "EEEE" // gives us the full name
        return formatter.string(from: date)
    }

    static func weatherCondition(for code: Int) -> String {
        switch code { //Based on our weathercode return weather symbol
        case 0: return "sun.max.fill"
            
        case 1...3: return "cloud.sun.fill"
            
        case 45...48: return "cloud.fog.fill"
            
        case 51...57, 61...67, 80...82: return "cloud.drizzle.fill"
            
        case 61, 63, 65: return "cloud.rain.fill"
            
        case 71...77, 85...86: return "snowflake"
            
        case 95,96,99: return "bolt.fill"
            
        default: return "questionmark"
        }
    }
    
    //Not using anymore
    /*
    static func backgroundScreen(for weatherCode: Int) ->SKScene { //För bakgrund beroende på weather code skickar antingen regn, snö
        switch weatherCode {
        case 0:
            return Cloudy()
        case 1...3:
            return Sunny()
        case 45...48:
            return Cloudy()

        case 61,63,65:
            return RainFall()
        case 71...77, 85...85:
            return SnowFall()
        default:
            return SKScene(size: UIScreen.main.bounds.size)
        }
    }*/
}
