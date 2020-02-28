//
//  Service.swift
//  Hows The Weather
//
//  Created by Anthony on 11/02/20.
//  Copyright © 2020 EmeraldApps. All rights reserved.
//

import Foundation

class Service {
    
    static let shared = Service()
    
    //http://api.weatherbit.io/v2.0/forecast/daily?
    
    // parameters
    //&key=Constants.apiKey
    //&lat={lat}&lon={lon}
    //&city={city}}&country={country}
    
    func fetchWeatherByCity(city:String, completion: @escaping (Forecast?, Error?) -> ()){
        let urlString = "https://api.weatherbit.io/v2.0/forecast/daily?city=\(city)&key=d1897b72d2b9429db21d9274431ceee2"
                guard let url = URL(string: urlString) else { return }
                URLSession.shared.dataTask(with: url) { (data, resp, err) in
                    if let err = err {
                        completion(nil, err)
                        print("Failed to fetch courses:", err)
                        return
                    }
                    guard let data = data else { return }

                    do {
                     let forecast = try JSONDecoder().decode(Forecast.self, from: data)
                        DispatchQueue.main.async {
                            completion(forecast, nil)
                        }
                    } catch let jsonErr {
                        print("Failed to decode:", jsonErr)
                        completion(nil, jsonErr)
                    }
                    }.resume()
    }
    
//    func fetchWeatherByCoordinate(city:String, completion: @escaping (Forecast?, Error?) -> ()){
//        let urlString = "https://api.weatherbit.io/v2.0/forecast/daily?city=\(city)&key=d1897b72d2b9429db21d9274431ceee2"
//                guard let url = URL(string: urlString) else { return }
//                URLSession.shared.dataTask(with: url) { (data, resp, err) in
//                    if let err = err {
//                        completion(nil, err)
//                        print("Failed to fetch courses:", err)
//                        return
//                    }
//                    guard let data = data else { return }
//
//                    do {
//                     let forecast = try JSONDecoder().decode(Forecast.self, from: data)
//                        DispatchQueue.main.async {
//                            completion(forecast, nil)
//                        }
//                    } catch let jsonErr {
//                        print("Failed to decode:", jsonErr)
//                    }
//                    }.resume()
//    }

}
