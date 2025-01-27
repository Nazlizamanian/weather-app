//
//  ContentView.swift
//  ios-final-weatherapp-nazlizamanian
//
//  Created by Nazli  on 19/06/24.
//

import SwiftUI

struct ContentView: View {
    @State var data: WeatherData? = nil
    
    //@ObservedObject var weatherModel = WeatherModel()
    var body: some View {
        NavigationStack {
            WeatherView()
               
        }
        // .environmentObject(locationManger)
    }
}

#Preview {
    ContentView()
}
