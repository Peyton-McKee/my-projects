//
//  RecommenderTableViewController.swift
//  SkiMountainFinder
//
//  Created by Peyton McKee on 12/8/21.
//

import UIKit
import MapKit

class RecommenderTableViewController: UITableViewController {
    var matchingItems: [MKMapItem?] = []
    var weathers : [ActualWeather] = []
    static var mapView: MKMapView? = { let mapView = MKMapView()
        return mapView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateSearchResultsForSearchController(searchText: SearchMountainViewController.searchText)
    }
    
    func updateSearchResultsForSearchController(searchText : String) {
        guard let mapView = RecommenderTableViewController.mapView else { return }
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchText
        request.region = mapView.region
        let search = MKLocalSearch(request: request)
        search.start { response, _ in
            guard let response = response else {
                return
            }
            self.matchingItems = response.mapItems
            self.weathers = []
            for selectedItem in self.matchingItems{
                guard let selectedItem = selectedItem else { return }
                print("test")
                getData(from: "https://api.weather.gov/points/\(selectedItem.placemark.coordinate.latitude),\(selectedItem.placemark.coordinate.longitude)", completion: { (result) in
                    switch result {
                    case .success(let result) :
                        DispatchQueue.main.async {
                            self.weathers.append(result)
                            self.tableView.reloadData()
                        }
                    case .failure(let error) :
                        print("Failed to get data \(error)")
                    }
                })
            }
        }
    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weathers.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CustomTableViewCell?
        guard let selectedItem = matchingItems[indexPath.row] else {
            return cell!
        }
        
        guard let locality = selectedItem.placemark.locality, let administrativeArea = selectedItem.placemark.administrativeArea, let name = selectedItem.placemark.name else {
            return cell!
        }
        cell?.mountainLabel.text = "\(name), \(locality), \(administrativeArea)"
        cell?.weatherLabel.text = weathers[indexPath.row].description
        cell?.weatherRatingLabel.text = weathers[indexPath.row].ratingString
        cell?.mountainRatingLabel.text = ""
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedItem = matchingItems[indexPath.row] else {
            return
        }
        print(selectedItem.placemark.coordinate.latitude)
        print(selectedItem.placemark.coordinate.longitude)
        let url = URL(string: "https://forecast.weather.gov/MapClick.php?lat=\(selectedItem.placemark.coordinate.latitude)&lon=\(selectedItem.placemark.coordinate.longitude)")
        guard let name = selectedItem.placemark.name else {
            let vc = WebViewController(url: url!, title: "National Weather Service")
            let navvc = UINavigationController(rootViewController: vc)
            present(navvc, animated: true)
            return
        }
        let vc = WebViewController(url: url!, title: "\(name)")
        let navvc = UINavigationController(rootViewController: vc)
        present(navvc, animated: true)
    }
    
    /*
     func awaitData(selectedItem: MKMapItem, cell: CustomTableViewCell?)
     {
     Task{
     await updateWeather(selectedItem: selectedItem, cell: cell)
     }
     }
     
     func updateWeather(selectedItem : MKMapItem, cell: CustomTableViewCell?) async {
     try? await WeatherTracker().append(weather: getAsyncData(from:  "https://api.weather.gov/points/\(selectedItem.placemark.coordinate.latitude),\(selectedItem.placemark.coordinate.longitude)"))
     
     await WeatherDataHandler().updateWeatherData(newWeather: WeatherTracker.weathers[WeatherTracker.weathers.count - 1])
     
     DispatchQueue.main.async{
     cell?.weatherLabel.text = "\(WeatherDataHandler.weatherdata)"
     }
     }*/
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
