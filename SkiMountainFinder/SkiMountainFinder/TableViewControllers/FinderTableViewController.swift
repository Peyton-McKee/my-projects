//
//  FinderTableViewController.swift
//  SkiMountainFinder
//
//  Created by Andrea McKee on 12/24/21.
//


import UIKit
import MapKit
import WebKit

class FinderTableViewController: UITableViewController, WKNavigationDelegate {
    var matchingItems: [MKMapItem?] = []
    var selectedItem = [MKMapItem?]()
    static var mapView: MKMapView? = { let mapView = MKMapView()
        return mapView
    }()
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let webView = WKWebView()
    
    var locations : [ActualLocation] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.startAnimating()
        webView.navigationDelegate = self
        updateSearchResultsForSearchController(searchText: "Ski Area")
        self.title = "Nearby Mountains"
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
            self.matchingItems = []
            self.locations = []
            self.selectedItem = []
            for item in response.mapItems{
                if(((item.placemark.location?.distance(from: CLLocation(latitude: MapViewController.startingLocation.coordinates!.latitude, longitude: MapViewController.startingLocation.coordinates!.longitude)))!)/1609.344 <= Double(FinderViewController.selectedDistance)){
                    self.matchingItems.append(item)
                }
            }
            guard (self.matchingItems.count != 0) else
            {
                DispatchQueue.main.async{
                    self.title = "No Nearby Ski Resorts"
                    self.tableView.reloadData()
                }
                return
            }
            self.selectedItem = self.matchingItems.reversed()
            let nameString = self.selectedItem[self.selectedItem.count - 1]!.name!.components(separatedBy: " ")
            var name = ""
            for i in 0 ..< nameString.count{
                if(i == nameString.count-1)
                {
                    name += "\(nameString[i])"
                }
                else
                {
                    name += "\(nameString[i])+"
                }
            }
            print(name)
            guard let name = URL(string: "https://www.google.com/search?q=\(name)") else {
                return
            }
            self.webView.load(URLRequest(url: name))
        }
    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CustomTableViewCell?
        if(matchingItems.count == 0){
            cell?.mountainLabel.text = "No ski resorts in region"
            return cell!
        }
        
        let name = locations[indexPath.row].name
        let locality = locations[indexPath.row].locality
        let administrativeArea = locations[indexPath.row].administrativeArea
        let weatherDescription = locations[indexPath.row].weather.description
        let weatherRating = locations[indexPath.row].weather.ratingString
        let mountainRating = locations[indexPath.row].ratingString
        let mountainViewTapGestureRecognizer = CustomTap(target: self, action: #selector(self.presentWebsite(sender:)))
        mountainViewTapGestureRecognizer.customTag = typeGesture.mountain.rawValue
        mountainViewTapGestureRecognizer.link = locations[indexPath.row].link
        mountainViewTapGestureRecognizer.title = name
        
        let weatherViewTapGestureRecognizer = CustomTap(target: self, action: #selector(self.presentWebsite(sender:)))
        weatherViewTapGestureRecognizer.customTag = typeGesture.weather.rawValue
        weatherViewTapGestureRecognizer.link = URL(string: "https://forecast.weather.gov/MapClick.php?lat=\(locations[indexPath.row].selectedItem.placemark.coordinate.latitude)&lon=\(locations[indexPath.row].selectedItem.placemark.coordinate.longitude)#.YgBorS-B0uQ")
        weatherViewTapGestureRecognizer.title = name
        
        if locations[indexPath.row].link != nil{
            cell?.mountainLabel.textColor = .blue
        }
        let baseDepth = locations[indexPath.row].baseDepth ?? "Unkown"
        let numLifts = locations[indexPath.row].liftNumber ?? "Unkown"
        let numSnow = locations[indexPath.row].newSnow ?? "Unkown"
        let numTrails = locations[indexPath.row].trailNumber ?? "Unknown"
        cell?.baseDepthLabel.text =  " \(baseDepth)\" Base Depth\n"
        cell?.liftLabel.text =   "\(numLifts) Lifts Open\n"
        cell?.newSnowLabel.text =  "\(numSnow)\" of New Snow\n"
        cell?.trailsOpenLabel.text =  "\(numTrails) Open Trails\n"
        cell?.mountainLabel.text = "\(name), \(locality), \(administrativeArea)"
        cell?.weatherLabel.text = weatherDescription
        cell?.weatherRatingLabel.text = weatherRating
        cell?.mountainRatingLabel.text = mountainRating
        cell?.weatherView.addGestureRecognizer(weatherViewTapGestureRecognizer)
        cell?.mountainView.addGestureRecognizer(mountainViewTapGestureRecognizer)
        return cell!
    }
    @objc func presentWebsite(sender: Any) {
        // important to cast your sender to your cuatom class so you can extract your special setting.
        let tag = sender as? CustomTap
        switch tag?.customTag {
        case typeGesture.mountain.rawValue:
            let url = tag?.link
            guard let url = url else{return}
            let vc = WebViewController(url: url, title: (tag?.title)!)
            let navvc = UINavigationController(rootViewController: vc)
            present(navvc, animated: true)
        case typeGesture.weather.rawValue:
            let url = tag?.link
            guard let url = url else{return}
            let vc = WebViewController(url: url, title: (tag?.title)!)
            let navvc = UINavigationController(rootViewController: vc)
            present(navvc, animated: true)
        default:
            break
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let url = locations[indexPath.row].link
        guard let url = url else{return}
        let vc = WebViewController(url: url, title: "\(locations[indexPath.row].name)")
        let navvc = UINavigationController(rootViewController: vc)
        present(navvc, animated: true)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        guard self.selectedItem.count > 0 else {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
            return
        }
        getGoogleData(webView: webView, completion: { (result) in
            switch result{
            case .success(let result):
                getData(from: "https://api.weather.gov/points/\(self.selectedItem[self.selectedItem.count-1]!.placemark.coordinate.latitude),\(self.selectedItem[self.selectedItem.count-1]!.placemark.coordinate.longitude)", completion: { (response) in
                    switch response {
                    case .success(let response) :
                        DispatchQueue.main.async {
                            getWebsiteData(webView: webView, completion: { value in
                                switch value{
                                case .success(let value):
                                    let info = value.components(separatedBy: ",")
                                    var trailNumbers: String?
                                    var lifts: String?
                                    var baseDepth : String?
                                    var newSnow: String?
                                    if !info[0].isEmpty
                                    {
                                        print("info 0: " + info[0])
                                        for component in info[0].components(separatedBy: " ")
                                        {
                                            if Int(component) != nil
                                            {
                                                trailNumbers = component
                                                print("trailNumbers: " + trailNumbers!)

                                            }
                                        }
                                    }
                                    if !info[1].isEmpty
                                    {
                                        print("info 1: " + info[1])
                                        for component in info[1].components(separatedBy: " ")
                                        {
                                            if Int(component) != nil
                                            {
                                                lifts = component
                                                print("lifts: " + lifts!)
                                            }
                                        }
                                    }
                                    if !info[2].isEmpty
                                    {
                                        print("info 2: " + info[2])
                                        baseDepth = info[2]
                                        print("LOOK HERE for Base depth: " + baseDepth!)
                                    }
                                    if !info[3].isEmpty
                                    {
                                        print("Info Three: " + info[3])
                                        for character in info[3]
                                        {
                                            if Int("\(character)") != nil
                                            {
                                                newSnow = "\(character)"
                                                print("Look here for new Snow: " + newSnow!)
                                            }
                                        }
                                    }
                                    
                                    if let rating = Double(result.components(separatedBy: " ")[0]), let link = URL(string: result.components(separatedBy: " ")[1]) {
                                        self.locations.append(ActualLocation(selectedItem: self.selectedItem[self.selectedItem.count-1]!, rating: rating, weather: response, link: link, trailNumber: trailNumbers, baseDepth: baseDepth, liftNumber: lifts, newSnow: newSnow))
                                    }
                                    else if let rating = Double(result.components(separatedBy: " ")[0])
                                    {
                                        self.locations.append(ActualLocation(selectedItem: self.selectedItem[self.selectedItem.count-1]!, rating: rating, weather: response, trailNumber: trailNumbers, baseDepth: baseDepth, liftNumber: lifts, newSnow: newSnow))
                                    }
                                    
                                    self.locations.sort{
                                        $0.rating + Double($0.weather.ratingNumber) > $1.rating + Double($1.weather.ratingNumber)
                                    }
                                    
                                    self.tableView.reloadData()
                                    self.selectedItem.remove(at: self.selectedItem.count-1)
                                    if(self.selectedItem.count-1 > 0){
                                        print(self.selectedItem.count - 1)
                                        let nameString = self.selectedItem[self.selectedItem.count - 1]!.name!.components(separatedBy: " ")
                                        var name = ""
                                        for i in 0 ..< nameString.count{
                                            if(i == nameString.count-1)
                                            {
                                                name += "\(nameString[i])"
                                            }
                                            else
                                            {
                                                name += "\(nameString[i])+"
                                            }
                                        }
                                        guard let name = URL(string: "https://www.google.com/search?q=\(name)") else{
                                            return
                                        }
                                        self.webView.load(URLRequest(url: name))
                                    }
                                    
                                case .failure(let error) :
                                    do {
                                        print("failed to get website data \(error)")
                                        
                                        self.locations.sort{
                                            $0.rating + Double($0.weather.ratingNumber) > $1.rating + Double($1.weather.ratingNumber)
                                        }
                                        
                                        self.tableView.reloadData()
                                        self.selectedItem.remove(at: self.selectedItem.count-1)
                                        if(self.selectedItem.count-1 > 0){
                                            print(self.selectedItem.count - 1)
                                            let nameString = self.selectedItem[self.selectedItem.count - 1]!.name!.components(separatedBy: " ")
                                            var name = ""
                                            for i in 0 ..< nameString.count{
                                                if(i == nameString.count-1)
                                                {
                                                    name += "\(nameString[i])"
                                                }
                                                else
                                                {
                                                    name += "\(nameString[i])+"
                                                }
                                            }
                                            guard let name = URL(string: "https://www.google.com/search?q=\(name)") else{
                                                return
                                            }
                                            self.webView.load(URLRequest(url: name))
                                        }
                                        
                                    }
                                    
                                }
                            })
                        }
                    case .failure(let error) :
                        print("Failed to get data \(error)")
                    }
                })
            case .failure(let error):
                print("failed to get rating \(error)")
            }
        })
    }
    
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
