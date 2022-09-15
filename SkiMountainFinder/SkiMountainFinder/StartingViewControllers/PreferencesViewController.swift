//
//  PreferencesViewController.swift
//  SkiMountainFinder
//
//  Created by Peyton McKee on 12/8/21.
//

import UIKit

class PreferencesViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    @IBOutlet var temperatureTypePickerView: UIPickerView!
    let temperatures = ["<-10", "0", "10", "20", "30", "40"]
    
    @IBOutlet var windSpeedTypePickerView: UIPickerView!
    let windSpeeds = ["5", "10", "15", "20", "Any"]
    
    @IBOutlet var precipitationTypePickerView: UIPickerView!
    let precipitations = ["Yes", "No"]
    
    var myPreference = PreferredWeather(temp: 3, windSpeed: 1, precipitation: 3)
    
    @IBOutlet var saveButton: UIButton!
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        temperatureTypePickerView.delegate = self
        temperatureTypePickerView.dataSource = self
        
        windSpeedTypePickerView.delegate = self
        windSpeedTypePickerView.dataSource = self
        
        precipitationTypePickerView.delegate = self
        precipitationTypePickerView.dataSource = self
        
        imageView.contentMode = .scaleToFill
        imageView.image = images.first
        animateImageView(imageView: imageView)
        // Do any additional setup after loading the view.
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(pickerView == temperatureTypePickerView)
        {
            return temperatures.count
        }
        else if(pickerView == windSpeedTypePickerView)
        {
            return windSpeeds.count
        }
        else if(pickerView == precipitationTypePickerView)
        {
            return precipitations.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(pickerView == temperatureTypePickerView)
        {
            return temperatures[row]
        }
        else if(pickerView == windSpeedTypePickerView)
        {
            return windSpeeds[row]
        }
        else if(pickerView == precipitationTypePickerView)
        {
            return precipitations[row]
        }
        return ""
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(pickerView == temperatureTypePickerView)
        {
            if(temperatures[row] == "<-10")
            {
                myPreference.temp = 0
            }
            else if(temperatures[row] == "0")
            {
                myPreference.temp = 1
            }
            else if(temperatures[row] == "10")
            {
                myPreference.temp = 2
            }
            else if(temperatures[row] == "20")
            {
                myPreference.temp = 3
            }
            else if(temperatures[row] == "30")
            {
                myPreference.temp = 4
            }
            else if(temperatures[row] == "40")
            {
                myPreference.temp = 5
            }
            
        }
        else if(pickerView == windSpeedTypePickerView)
        {
            if(windSpeeds[row] == "5")
            {
                myPreference.windSpeed = 0
            }
            else if(windSpeeds[row] == "10")
            {
                myPreference.windSpeed = 1
            }
            else if(windSpeeds[row] == "15")
            {
                myPreference.windSpeed = 2
            }
            else if(windSpeeds[row] == "20")
            {
                myPreference.windSpeed = 3
            }
            else if(windSpeeds[row] == "Any")
            {
                myPreference.windSpeed = 4
            }
        }
        else if(pickerView == precipitationTypePickerView)
        {
            if(precipitations[row] == "yes")
            {
                myPreference.precipitation = 0
            }
            else if(precipitations[row] == "no")
            {
                myPreference.precipitation = 1
            }
        }
        
    }
    
}
