//
//  weather.swift
//  SkiMountainFinder
//
//  Created by Peyton McKee on 12/10/21.
//

import Foundation

struct PreferredWeather{
    var temp: Int
    var windSpeed: Int
    var precipitation: Int
}

struct ActualWeather : CustomStringConvertible{
    let temp: String
    let windSpeed: String
    let precipitation: String
    var description: String{
        return "\(temp)⁰F,\n\(tempEmoji)\n\n \(precipitation), \n\(precipitationEmoji)\n\n \(windSpeed) winds\n\(windSpeedEmoji)\n\n"
    }
    var ratingString : String {
        var stars = ""
        for _ in 0 ..< ratingNumber
        {
            stars += "⭐️"
        }
        return stars
    }
    var ratingNumber : Int{
        var count = 0
        for _ in 0 ..< calcWeatherRating(precipitation: precipitation, temp: temp, windSpeed: windSpeed)
        {
            count += 1
        }
        return count
    }
    var tempEmoji: String{
        let temp = (Int(temp.components(separatedBy: " - ")[0])! + Int(temp.components(separatedBy: " - ")[1])!)/2
        if(temp < 0)
        {
            return "🥶"
        }
        else if(temp < 15)
        {
            return "❄️"
        }
        else if(temp < 34)
        {
            return "👍"
        }
        else if (temp < 45)
        {
            return "🥵"
        }
        else
        {
            return "🔥"
        }
    }
    var windSpeedEmoji: String{
        if(windSpeed.count <= 6)
        {
            if(Int(windSpeed.components(separatedBy: " ")[0])! > 25)
            {
                return "🌪"
            }
            else if (Int(windSpeed.components(separatedBy: " ")[0])! > 15)
            {
                return "💨"
            }
        }
        else{
            let secondWind = windSpeed.components(separatedBy: " to ")[1]
            let secondWindSpeed = secondWind.components(separatedBy: " ")
            if(Int(windSpeed.components(separatedBy: " to ")[0])! > 25 || Int(secondWindSpeed[0])! > 25)
            {
                return "🌪"
            }
            else if (Int(windSpeed.components(separatedBy: " to ")[0])! > 15 || Int(secondWindSpeed[0])! > 15)
            {
                return "💨"
            }
        }
        return "🌬"
    }
    var precipitationEmoji: String{
        
        if(precipitation.lowercased().contains("storm"))
        {
            return "⛈"
        }
        else if(precipitation.lowercased().contains("rain"))
        {
            return "🌧"
        }
        else if (precipitation.lowercased().contains("snow"))
        {
            return "🌨"
        }
        else if(precipitation.lowercased().contains("cloud"))
        {
            return "🌥"
        }
        else if (precipitation.lowercased().contains("haze"))
        {
            return "🌫"
        }
        else
        {
            return "☀️"
        }
    }
}

struct Weather: Codable{
    let properties: Property
}

struct Property: Codable{
    let forecast: String
}

struct Properties: Codable{
    let properties : Period
}

struct Period: Codable{
    let periods: [Values]
}

struct Values: Codable
{
    let temperature : Int
    let windSpeed: String
    let shortForecast: String
}
