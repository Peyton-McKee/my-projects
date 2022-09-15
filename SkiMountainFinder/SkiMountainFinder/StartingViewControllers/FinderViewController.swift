//
//  ViewController.swift
//  SkiMountainFinder
//
//  Created by Peyton McKee on 12/8/21.
//

import UIKit
import WebKit

class FinderViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    //    @IBOutlet var startDatePicker: UIDatePicker!
    
    @IBOutlet weak var imageView : UIImageView!
    
    @IBOutlet var datePicker: UIPickerView!
    var dates : [Date] = []
    static var selectedDate : Date?
    static var dateInt: Int = 0
    
    @IBOutlet var distanceToTravelPickerView: UIPickerView!
    let distances = [50, 100, 200, 300]
    static var selectedDistance : Int = 50
    
    @IBOutlet var startingLocationButton: UIButton!
    
    @IBOutlet var findButton: UIButton!
    
    let calendar = Calendar(identifier: .gregorian)
    
    //private var resolver : RedirectResolver!
    override func viewDidLoad() {
        super.viewDidLoad()
        setVariables()
        configureDatePicker()
        distanceToTravelPickerView.delegate = self
        distanceToTravelPickerView.dataSource = self
        datePicker.delegate = self
        datePicker.dataSource = self
        assignDateSelectedRow()
        assignDistanceSelectedRow()
        imageView.contentMode = .scaleToFill
        imageView.image = images.first
        animateImageView(imageView: imageView)
    }
    func assignDistanceSelectedRow()
    {
        for row in 0 ..< distanceToTravelPickerView.numberOfRows(inComponent: 0)
        {
            if(distances[row] == FinderViewController.selectedDistance)
            {
                distanceToTravelPickerView.selectRow(row, inComponent: 0, animated: false)
            }
        }
    }
    func assignDateSelectedRow()
    {
        guard let selectedDate = FinderViewController.selectedDate else{
            return
        }
        for row in 0 ..< datePicker.numberOfRows(inComponent: 0)
        {
            if selectedDate.formatted(date: .abbreviated, time: .omitted) == dates[row].formatted(date: .abbreviated, time: .omitted)
            {
                datePicker.selectRow(row, inComponent: 0, animated: false)
            }
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        startingLocationButton.setTitle(MapViewController.startingLocation.title, for: .normal)
    }
    
    func setVariables(){
        if let selectedDistance = MapViewController.selectedDistance{
            FinderViewController.selectedDistance = selectedDistance
        }
        if let selectedDate = MapViewController.selectedDate{
            FinderViewController.selectedDate = selectedDate
        }
    }
    func configureDatePicker(){
        if(calendar.component(.hour, from: Date.now) < 18)
        {
            dates.append(Date.now)
        }
        for date in 0 ..< 7
        {
            if(dates.isEmpty)
            {
                dates.append(Date.init(timeInterval: 86400, since: Date.now))
            }
            else{
                dates.append(Date.init(timeInterval: 86400, since: dates[date]))
            }
        }
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(pickerView == distanceToTravelPickerView)
        {
            return distances.count
        }
        else
        {
            return 7
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(pickerView == distanceToTravelPickerView)
        {
            return distances[row].description
        }
        else
        {
            return dates[row].formatted(date: .abbreviated, time: .omitted)
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(pickerView == distanceToTravelPickerView)
        {
            FinderViewController.selectedDistance = distances[row]
        }
        else
        {
            if(calendar.component(.hour, from: Date.now) > 18)
            {
                if(dates[row].timeIntervalSinceNow < 172800)
                {
                    FinderViewController.selectedDate = dates[row]
                    FinderViewController.dateInt = 1
                }
                else if(dates[row].timeIntervalSinceNow < 259200)
                {
                    FinderViewController.selectedDate = dates[row]
                    
                    FinderViewController.dateInt = 3
                }
                else if(dates[row].timeIntervalSinceNow < 345600)
                {
                    FinderViewController.selectedDate = dates[row]
                    
                    FinderViewController.dateInt = 5
                }
                else if(dates[row].timeIntervalSinceNow < 432000)
                {
                    FinderViewController.selectedDate = dates[row]
                    
                    FinderViewController.dateInt = 7
                }
                else if(dates[row].timeIntervalSinceNow < 518400)
                {
                    FinderViewController.selectedDate = dates[row]
                    
                    FinderViewController.dateInt = 9
                }
                else
                {
                    FinderViewController.selectedDate = dates[row]
                    
                    FinderViewController.dateInt = 11
                }
            }
            else{
                if(calendar.isDateInToday(dates[row]))
                {
                    FinderViewController.selectedDate = dates[row]
                    
                    FinderViewController.dateInt = 0
                }
                else if(dates[row].timeIntervalSinceNow < 172800)
                {
                    FinderViewController.selectedDate = dates[row]
                    
                    FinderViewController.dateInt = 2
                }
                else if(dates[row].timeIntervalSinceNow < 259200)
                {
                    FinderViewController.selectedDate = dates[row]
                    
                    FinderViewController.dateInt = 4
                }
                else if(dates[row].timeIntervalSinceNow < 345600)
                {
                    FinderViewController.selectedDate = dates[row]
                    
                    FinderViewController.dateInt = 6
                }
                else if(dates[row].timeIntervalSinceNow < 432000)
                {
                    FinderViewController.selectedDate = dates[row]
                    
                    FinderViewController.dateInt = 8
                }
                else if(dates[row].timeIntervalSinceNow < 518400)
                {
                    FinderViewController.selectedDate = dates[row]
                    
                    FinderViewController.dateInt = 10
                }
                else
                {
                    FinderViewController.selectedDate = dates[row]
                    
                    FinderViewController.dateInt = 12
                }
            }
        }
    }
    @IBAction func saveButtonPressed(sender: UIButton){
        if(shouldPerformSegue(withIdentifier: "fromFinderViewController", sender: self) == true)
        {
            performSegue(withIdentifier: "fromFinderViewController", sender: self)
        }
        else{
            findButton.setTitle("Please Select a Starting Location!", for: .normal)
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if(identifier == "fromFinderViewController")
        {
            if(MapViewController.startingLocation.title == "Enter Location")
            {
                return false
            }
            else{
                return true
            }
        }
        return true
    }
    
}
