//
//  MapViewController.swift
//  SkiMountainFinder
//
//  Created by Peyton McKee on 12/10/21.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, UITextFieldDelegate {
    
    var location = Location(title: "", coordinates: CLLocationCoordinate2D())
    static var currentLocation = "Earth"
    static var startingLocation = Location(title: "Enter Location", coordinates: CLLocationCoordinate2D.init(latitude: 0, longitude: 0))
    private let map: MKMapView = { let map = MKMapView()
        return map
    }()
    
    static var selectedDate : Date?
    static var selectedDistance : Int?
    
    let searchTextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(map)
        view.addSubview(searchTextField)
        customizeTextField()
        LocationManager.shared.getUserLocation{ [weak self] location in
            DispatchQueue.main.async{
                guard let strongSelf = self else{
                    return
                }
                strongSelf.addMapPin(with: location)
            }
            self?.searchTextField.delegate = self
            RecommenderTableViewController.mapView = self?.map
            MapViewController.selectedDate = FinderViewController.selectedDate
            MapViewController.selectedDistance = FinderViewController.selectedDistance
        }
        
        
        // Do any additional setup after loading the view.
    }
    func customizeTextField()
    {
        searchTextField.backgroundColor = .white
        searchTextField.placeholder = "Enter Starting Location Here"
    }
    override func viewDidLayoutSubviews(){
        super.viewDidLayoutSubviews()
        map.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: view.bounds.width, height: view.bounds.height - view.bounds.height/10))
        searchTextField.frame = CGRect(origin: CGPoint(x: 0, y: view.bounds.maxY - ((map.frame.height/10) * 2)), size: CGSize(width: map.frame.width, height: map.frame.height/10))
    }
    
    func addMapPin(with location: CLLocation)
    {
        let pin = MKPointAnnotation()
        
        pin.coordinate = location.coordinate
        
        map.setRegion(MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(
            latitudeDelta: 0.7, longitudeDelta: 0.7)),
                      animated: true)
        map.addAnnotation(pin)
        
        LocationManager.shared.resolveLocationName(with: location) { [weak self] locationName in
            if let myLocation = locationName{
                MapViewController.currentLocation = myLocation
                self?.title = MapViewController.currentLocation
                let theLocation: Location = Location(title: myLocation, coordinates: location.coordinate)
                MapViewController.startingLocation.title = theLocation.title
                MapViewController.startingLocation.coordinates = theLocation.coordinates
                print(MapViewController.startingLocation.title)
            }
        }
    }
    //    func searchViewController(_ vc: SearchViewController, didSelectLocationWith coordinates: CLLocationCoordinate2D?) {
    //        guard let coordinates = coordinates else{
    //            return
    //        }
    //
    //        map.removeAnnotations(map.annotations)
    //
    //        let pin = MKPointAnnotation()
    //        pin.coordinate = coordinates
    //        map.addAnnotation(pin)
    //
    //        map.setRegion(MKCoordinateRegion(center: coordinates, span: MKCoordinateSpan(
    //                latitudeDelta: 0.7,
    //                longitudeDelta: 0.7)
    //            ),
    //            animated: true)
    //        self.title = MapViewController.currentLocation
    //    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        if let text = searchTextField.text, !text.isEmpty{
            LocationManager.shared.findLocations(with: text){ [weak self] locations in
                DispatchQueue.main.async {
                    if(!locations.isEmpty)
                    {
                        self?.location = locations[0]
                        let coordinate = self?.location.coordinates
                        let locationName = self?.location.title.components(separatedBy: ",")
                        guard let locationName = locationName else{return}
                        
                        let locationTitle = "\(locationName[0]), \(locationName[1])"
                        MapViewController.currentLocation = locationTitle
                        self?.addMapPin(with: CLLocation(latitude: coordinate!.latitude, longitude: coordinate!.longitude))
                        MapViewController.startingLocation = Location(title: locationTitle, coordinates: coordinate)
                    }
                }
            }
        }
        
        
        return true
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
