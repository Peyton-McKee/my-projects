//
//  WeatherRatingCalculator.swift
//  SkiMountainFinder
//
//  Created by Peyton McKee on 1/12/22.
//

import Foundation

func calcWeatherRating(precipitation : String, temp: String, windSpeed: String) -> Int
{
    var rating: Int = 5
    let temp = Int(temp.components(separatedBy: " ")[0])!
    
    if(precipitation.lowercased().contains("rain"))
    {
        rating -= 2
    }
    
    if(temp < 0)
    {
        rating -= 2
    }
    else if (temp < 15 || temp > 40)
    {
        rating -= 1
    }
    
    if(windSpeed.count <= 6)
    {
        if(Int(windSpeed.components(separatedBy: " ")[0])! > 25)
        {
            rating -= 2
        }
        else if (Int(windSpeed.components(separatedBy: " ")[0])! > 15)
        {
            rating -= 1
        }
    }
    else{
        let secondWind = windSpeed.components(separatedBy: " to ")[1]
        let secondWindSpeed = secondWind.components(separatedBy: " ")
        if(Int(windSpeed.components(separatedBy: " to ")[0])! > 25 || Int(secondWindSpeed[0])! > 25)
        {
            rating -= 2
        }
        else if (Int(windSpeed.components(separatedBy: " to ")[0])! > 15 || Int(secondWindSpeed[0])! > 15)
        {
            rating -= 1
        }
    }
    return rating
}
