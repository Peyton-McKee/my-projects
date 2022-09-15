//
//  APIFinder.swift
//  SkiMountainFinder
//
//  Created by Peyton McKee on 12/20/21.
//

import Foundation
import UIKit


enum DownloadError : Error{
    case JSONDecoderError
}

func getData(from url: String, completion: @escaping (Result<ActualWeather, Error>) -> Void) {
    
    let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: {data, response, error in
        guard let data = data, error == nil else{
            print("Something went wrong")
            return
        }
        var result: Weather?
        do{
            result = try JSONDecoder().decode(Weather.self, from: data)
        }
        catch{
            print("failed to convert - \(error.localizedDescription)")
        }
        guard let json = result else{
            return
        }
        getData2(from: json.properties.forecast) { (result) in
            switch result{
            case .success(let result) :
                do {
                    completion(.success(result))
                }
            case .failure(let error):
                do {
                    completion(.failure(error))
                }
            }
        }
    })
    task.resume()
}



func getData2(from url: String, completion: @escaping (Result<ActualWeather, Error>) -> Void){
    let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: {data, response, error in
        guard let data = data, error == nil else{
            print("Something went wrong")
            return
        }
        var result: Properties?
        do{
            result = try JSONDecoder().decode(Properties.self, from: data)
            guard let json = result else{
                return
            }
            if(FinderViewController.dateInt % 2 == 0)
            {
                let newWeather = ActualWeather(temp: "\(json.properties.periods[FinderViewController.dateInt + 1].temperature) - \(json.properties.periods[FinderViewController.dateInt].temperature)", windSpeed: json.properties.periods[FinderViewController.dateInt].windSpeed, precipitation: json.properties.periods[FinderViewController.dateInt].shortForecast)
                completion(.success(newWeather))
            }
            else{
                let newWeather = ActualWeather(temp: "\(json.properties.periods[FinderViewController.dateInt - 1].temperature) - \(json.properties.periods[FinderViewController.dateInt].temperature)", windSpeed: json.properties.periods[FinderViewController.dateInt].windSpeed, precipitation: json.properties.periods[FinderViewController.dateInt].shortForecast)
                completion(.success(newWeather))
            }
            /*DispatchQueue.main.async{
             print(FinderViewController.dateInt)
             
             RecommenderTableViewController.weathers.append(newWeather)
             print(RecommenderTableViewController.weathers.count)
             print(RecommenderTableViewController.weathers)
             }*/
        }
        catch{
            print("failed to convert - \(error.localizedDescription)")
            completion(.failure(error))
        }
        
        
    })
    task.resume()
}
/*
 actor WeatherDataHandler
 {
 static var weatherdata: String = ""
 func updateWeatherData(newWeather: ActualWeather)
 {
 WeatherDataHandler.weatherdata = newWeather.description
 }
 }
 actor WeatherTracker{
 static var weathers : [ActualWeather] = []
 func append(weather: ActualWeather)
 {
 WeatherTracker.weathers.append(weather)
 }
 }
 
 /*func awaitData(from url: String)
  {
  Task{
  print("test1")
  let newWeather = try await getAsyncData(from: url)
  
  await weatherTracker().append(weather: newWeather)
  }
  }*/
 func getAsyncData(from url: String) async throws -> ActualWeather {
 var newWeather : ActualWeather = ActualWeather(temp: 0, windSpeed: "", precipitation: "")
 do{
 let (data, _) = try await URLSession.shared.data(from: URL(string: url)!)
 guard let result = try? JSONDecoder().decode(Weather.self, from: data)
 else{
 throw DownloadError.JSONDecoderError
 }
 newWeather = try await getAsyncData2(from: result.properties.forecast)
 }
 catch{
 print("failed to convert - \(error.localizedDescription)")
 }
 return newWeather
 
 }
 
 func getAsyncData2(from url: String) async throws -> ActualWeather {
 var newWeather = ActualWeather(temp: 0, windSpeed: "", precipitation: "")
 do{
 let (data, _) = try await URLSession.shared.data(from: URL(string: url)!)
 guard let result = try? JSONDecoder().decode(Properties.self, from: data)
 else{
 throw DownloadError.JSONDecoderError
 }
 newWeather = await ActualWeather(temp: result.properties.periods[FinderViewController.dateInt].temperature, windSpeed: result.properties.periods[FinderViewController.dateInt].windSpeed, precipitation: result.properties.periods[FinderViewController.dateInt].shortForecast)
 return newWeather
 }
 catch{
 print("failed to convert - \(error.localizedDescription)")
 }
 return newWeather
 }
 */

