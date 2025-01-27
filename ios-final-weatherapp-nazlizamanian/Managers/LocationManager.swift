//
//  LocationManager.swift
//  ios-final-weatherapp-nazlizamanian
//
//  Created by Nazli  on 19/06/24.
//
import Foundation
import CoreLocation
import Observation

/*
 Sources used:
 Location: https://pixelkind.github.io/iOS-development/chapter6/location/
 
 https://www.youtube.com/watch?v=6bKWCS2Aw6s
 */

@Observable
class LocationManager: NSObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager() //isntance of CLL thats responsbile for managaning getting locat
    private let geocoder = CLGeocoder() //used for converting lat & long into human readable address
    
    var location: CLLocation?
    var address: CLPlacemark? //represents human redable description of geo location
    var onLocationUpdate: ((CLLocation) -> Void)? //optional to return nothing notifies the view 
    
    override init() { //our init func that init and sets to it self
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization() 
    }
    
    func requestLocation() { //checks if the app has been autohrized
        if locationManager.authorizationStatus == .notDetermined { //user has not been asked yet drf request
            locationManager.requestWhenInUseAuthorization()
            
        } else {//permission granted -> request location
            locationManager.requestLocation()
        }
    }
    
    func reverseGeocodeLocation(_ location: CLLocation) {
        Task {
            let placemarks = try? await geocoder.reverseGeocodeLocation(location)
            address = placemarks?.last //kmr svara med en [] o vi vill ha den sista.
            /*if let address = address {
                saveLocationName(address)
            }*/
        }
    }
    
   /* //Dont neeed thes anymore no widget
    func saveLocationName(_ placemark: CLPlacemark) {
        let locationName = placemark.locality ?? "Unknown"
        let userDefaults = UserDefaults(suiteName: "group.doc.sharing")
        userDefaults?.set(locationName, forKey: "locationName")
    }
    */
    
    //If autorhiztine is changed its triggered  if not deined req loc
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if locationManager.authorizationStatus != .denied {
            locationManager.requestLocation()
        }
    }
    
    //triggered when new location closure invoke passing new CLLocation to weatherView
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.last
        if let location = location {
            reverseGeocodeLocation(location)
            onLocationUpdate?(location) //calls the model.setC triggers await & updates our weather view
            
        }
    }
    
    //Fallback error
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error \(error)")
    }
}
