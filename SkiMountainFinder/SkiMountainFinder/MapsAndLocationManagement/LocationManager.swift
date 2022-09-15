//
//  locationManager.swift
//  SkiMountainFinder
//
//  Created by Peyton McKee on 12/10/21.
//
import CoreLocation
import Foundation
import MapKit
import WebKit

struct Location{
    var title: String
    var coordinates: CLLocationCoordinate2D?
}

struct ActualLocation {
    var selectedItem: MKMapItem
    
    var rating: Double
    
    var weather: ActualWeather
    
    var link: URL?
    
    var trailNumber: String?
    
    var baseDepth: String?
    
    var liftNumber: String?
    
    var newSnow : String?
    
    var name : String {
        let name = selectedItem.name!
        return name
    }
    var locality : String {
        let locality = selectedItem.placemark.locality!
        return locality
    }
    var  administrativeArea: String {
        let administrativeArea = selectedItem.placemark.administrativeArea!
        return administrativeArea
    }
    
    var ratingString : String {
        var ratingString = ""
        if(Int(rating) == 0)
        {
            ratingString = "No Rating Found"
        }
        for _ in 0 ..< Int(rating)
        {
            ratingString += "⭐️"
        }
        return ratingString
    }
}


class LocationManager: NSObject, CLLocationManagerDelegate{
    static let shared = SkiMountainFinder.LocationManager()
    
    let manager = CLLocationManager()
    
    var completion: ((CLLocation)-> Void)?
    
    public func getUserLocation(completion: @escaping ((CLLocation)-> Void)) {
        self.completion = completion
        manager.requestWhenInUseAuthorization()
        manager.delegate = self
        manager.startUpdatingLocation()
    }
    
    public func resolveLocationName(with location: CLLocation, completion: @escaping ((String?) -> Void))
    {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location, preferredLocale: .current){ placemarks, error in
            guard let place = placemarks?.first, error == nil else{
                completion(nil)
                return
            }
            print(place)
            
            var name = ""
            
            if let locality = place.locality{
                name += locality
            }
            if let adminRegion = place.administrativeArea{
                name += ", \(adminRegion)"
            }
            completion(name)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else{
            return
        }
        completion?(location)
        manager.stopUpdatingLocation()
    }
    
    public func findLocations(with query: String, completion: @escaping (([Location]) -> Void)){
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(query){ places, error in
            guard let places = places, error == nil else{
                completion([])
                return
            }
            let models: [Location] = places.compactMap({place in
                var name = ""
                if let locationName = place.name {
                    name += locationName
                }
                if let adminRegion = place.administrativeArea {
                    name += ", \(adminRegion)"
                }
                if let locality = place.locality {
                    name += ", \(locality)"
                }
                if let country = place.country {
                    name += ", \(country)"
                }
                
                print("\n\(place)\n\n")
                
                let result = Location(
                    title: name,
                    coordinates: place.location?.coordinate)
                return result
            })
            completion(models)
        }
    }
}

