//
//  ForecastViewModel.swift
//  Hows The Weather
//
//  Created by Anthony on 13/02/20.
//  Copyright © 2020 EmeraldApps. All rights reserved.
//

import Foundation
import UIKit

struct ForecastViewModel {
    
    
    var name: String
    var description: String
    var currentTime: String
    var sunriseTime: String
    var sunsetTime: String
    var temperature: String
    var temperatureWithoutSymbol: String
    var chanceOfRain: String
    var humidity: String
    var wind: String
    var feelsLikeTemperature: String
    var precipitation: String
    var pressure: String
    var visibility: String
    var uvIndex: String
    var minTemperature: String
    var maxTemperature: String
    var iconName: String
    var data: [DataViewModel]
    
    
    
    init(forecast: Forecast) {
        let today = forecast.data[0]
        name = forecast.cityName
        description = today.weather.weatherDescription
        temperature = "\(today.temp.getString())°"
        temperatureWithoutSymbol = today.temp.getString()
        chanceOfRain = "\(String(today.pop))%"
        humidity = "\(String(today.rh))%"
        wind = "\(today.windCdir) \(today.windSpd.getString()) km/hr"
        feelsLikeTemperature = "\(today.appMaxTemp.getString())°"
        precipitation = "\(today.precip.getString()) mm"
        pressure = "\(today.pres.getString()) hPa"
        visibility = "\(today.vis.getString()) km"
        uvIndex = "\(today.uv.getString())"
        minTemperature = "\(today.minTemp.getString())°"
        maxTemperature = "\(today.maxTemp.getString())°"
        iconName = today.weather.icon
    
     
        
        let currentDate = Date(timeIntervalSince1970: TimeInterval(forecast.data[0].ts))
        currentTime = currentDate.toString()
        
        let sunriseDate = Date(timeIntervalSince1970: TimeInterval(forecast.data[0].sunriseTs))
        sunriseTime = sunriseDate.toString()
        
        let sunsetDate = Date(timeIntervalSince1970: TimeInterval(forecast.data[0].sunsetTs))
        sunsetTime = sunsetDate.toString()
        
        var dataViewModelArray = [DataViewModel]()
        for forecastData in forecast.data {
            dataViewModelArray.append(DataViewModel(data: forecastData))
        }
        data = dataViewModelArray
    }
}

struct DataViewModel {
    
    var currentDay: String
    var iconName: String
    var minTemperature: String
    var maxTemperature: String
    
    init(data: Data) {
        
        
        iconName = data.weather.icon
        minTemperature = "\(data.minTemp.getString())°"
        maxTemperature = "\(data.maxTemp.getString())°"
        
        let currentDate = Date(timeIntervalSince1970: TimeInterval(data.ts))
        currentDay = currentDate.getDayAsString()
        
    }
}
