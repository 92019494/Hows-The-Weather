//
//  HomeViewController.swift
//  Hows The Weather
//
//  Created by Anthony on 14/02/20.
//  Copyright © 2020 EmeraldApps. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

/// function for presented view controller to pass back location details
protocol LocationSearchDelegate {
    func passLocation(placemark: CLPlacemark)
}

class HomeViewController: UIViewController {

    var cities = [String]()
    var forecasts = [ForecastViewModel]()
    var detailSegue = "toDetail"
    var locationSearchSegue = "toLocationSearch"
    var locationSearchVCID = "locationSearchVC"
    var clickedForecast: ForecastViewModel?
    var defaults = UserDefaults.standard
    var locationManager = CLLocationManager()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(applicationWentIntoBackground), name: UIApplication.willResignActiveNotification, object: nil)
        
            setInitialForecasts()
            fetchForecasts()
            setupNavBarButtons()
            setUpRightBarButtons()
            checkLocationServices()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIApplication.willResignActiveNotification, object: nil)
    }
    
    func setInitialForecasts(){
        if defaults.value(forKey: Constants.citiesKey) != nil {
            cities = defaults.value(forKey: Constants.citiesKey) as! [String]
            print(cities)
        }
        
    }
    
    func fetchForecasts(){
     
        forecasts = [ForecastViewModel]()
        for city in cities {
        /// api replaces " " with "-" for city parameter
        /// need to ensure city string is capitalized
        var city = city.replacingOccurrences(of: " ", with: "-")
        city = city.capitalized
        Service.shared.fetchWeatherByCity(city: city) { [weak self] (forecast, err) in
            guard let this = self else {return}
            DispatchQueue.main.async {
                guard let forecast = forecast else  { return }
                this.forecasts.append(ForecastViewModel(forecast: forecast))
                this.tableView.reloadData()
            }
            
            
        }
        }
    }
    
    @objc func applicationWentIntoBackground(){
        print("app went to background")
        defaults.set(cities, forKey: Constants.citiesKey)
    }
    
    func setupNavBarButtons(){
 
        self.editButtonItem.action = #selector(toggleEditing)
        self.navigationItem.rightBarButtonItems = [self.editButtonItem]
    }
    
    @objc func toggleEditing(){
        if tableView.isEditing {
            tableView.isEditing = false
            editButtonItem.title = "Edit"
        } else {
            tableView.isEditing = true
            editButtonItem.title = "Done"
        }
    }
    
    
    @IBAction func addLocationClicked(_ sender: Any) {

        performSegue(withIdentifier: locationSearchSegue, sender: self)
    }
    
       // MARK: - Location
       func setupLocationManager() {
           let this = self
           locationManager.delegate = (this as CLLocationManagerDelegate)
           locationManager.desiredAccuracy = kCLLocationAccuracyBest
           locationManager.distanceFilter = 20.0
       }
       
       func checkLocationAuthorization() {
           switch CLLocationManager.authorizationStatus() {
           case .authorizedWhenInUse:
               startUpdatingUserLocation()
           case .denied:
               // Show alert instructing them how to turn on permissions
               Alert.presentLocationAlert(vc: self)
               break
           case .notDetermined:
               locationManager.requestWhenInUseAuthorization()
           case .restricted:
               // Show an alert letting them know what's up
               break
           case .authorizedAlways:
               break
           @unknown default:
               // show alert saying our app is currently being updated
               fatalError()
           }
       }
       
       func startUpdatingUserLocation() {
           locationManager.startUpdatingLocation()
    
       }
       
       func checkLocationServices() {
            checkLocationAuthorization()
           if CLLocationManager.locationServicesEnabled() {
               setupLocationManager()
               checkLocationAuthorization()
           } else {
            Alert.showBasicAlert(vc: self, title: "Locations Services Are Disabled", message: "Please Enable Them")
        }
       }
        
//    func presentLocationSearchVC (){
//        let sb = UIStoryboard(name: "Main", bundle: nil)
//        let vc = sb.instantiateViewController(identifier: locationSearchVCID) as! LocationSearchTableViewController
//        vc.delegate = self
//        navigationController?.pushViewController(vc, animated: true)
//
//    }

    
    func addCityToUserDefaults(city:String){
        if defaults.value(forKey: Constants.citiesKey) != nil {
            var arr = defaults.value(forKey: Constants.citiesKey) as! [String]
            if arr.contains(city) {
                return
            }
            arr.append(city)
            cities.append(city)
            defaults.set(arr, forKey: Constants.citiesKey)
        } else {
            defaults.set([String](), forKey: Constants.citiesKey)
        }
        
    }
    
    func removeCityFromUserDefaults(city:String){
        if defaults.value(forKey: Constants.citiesKey) != nil {
            var arr = defaults.value(forKey: Constants.citiesKey) as! [String]
            if arr.contains(city) {
                arr.removeAll { $0 == city }
                cities = arr
                
            }
            defaults.set(arr, forKey: Constants.citiesKey)
        }
        
    }
    func removeForecast(forecast:ForecastViewModel){
        forecasts.removeAll { $0.name == forecast.name }
        print(forecast.name, " removed")
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case detailSegue:
            let vc = segue.destination as! WeatherDetailViewController
            vc.forecast = clickedForecast
            
        case locationSearchSegue:
            let vc = segue.destination as! LocationSearchTableViewController
            vc.delegate = self
            
        default:
            break
        }
    }

}

extension HomeViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            return forecasts.count
        } else {
            return 1
        }
        
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell") as! WeatherTableViewCell
            cell.forecast = forecasts[indexPath.row]
            return cell
        } else {
            // need to change to add cell
            let cell = tableView.dequeueReusableCell(withIdentifier: "addLocationCell") as! AddLocationTableViewCell

            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if indexPath.section == 0 {
            clickedForecast = forecasts[indexPath.row]
            performSegue(withIdentifier: detailSegue, sender: self)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if indexPath.section == 0 {
//        return 90
//        } else {
            return UITableView.automaticDimension
        //}
    }

    
    // Override to support conditional editing of the table view.
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        if indexPath.section == 0 {
            return true
        } else {
            return false
        }
        
    }
    

//    
//    // Override to support editing the table view.
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            // Delete the row from the data source
//            tableView.deleteRows(at: [indexPath], with: .fade)
//            forecasts.remove(at: indexPath.row)
//            
//        } 
//    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self](action, view, completionHandler) in
            guard let this = self else {return}
                
            
            this.removeForecast(forecast: this.forecasts[indexPath.row])
            this.removeCityFromUserDefaults(city: this.cities[indexPath.row ])
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
                completionHandler(true)
        }
        deleteAction.backgroundColor = UIColor.red
        return UISwipeActionsConfiguration(actions: [deleteAction])

    }
    


    
    // Override to support rearranging the table view.
    func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }


    
    // Override to support conditional rearranging of the table view.
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        
        if indexPath.section == 0 {
            return true
        } else {
            return false
        }

    }
    
    
}

// MARK: - Location Delegate
extension HomeViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
        DispatchQueue.main.async { [weak self] in
            guard let this = self else {return}
            this.tableView.reloadData()
        }
        
    }
    
}

extension HomeViewController: LocationSearchDelegate {
    
    func checkIfPlaceAlreadyExists(){
        
    }
    // MARK: - Delegate Method
      func passLocation(placemark: CLPlacemark) {
          print("placemark passed:", placemark)
        guard let city = placemark.name else {return}
        if cities.contains(city){return}
        
        let formattedCity = city.replacingOccurrences(of: " ", with: "-")
       
        
        //guard let coordinate = placemark.location?.coordinate else {return}
        Service.shared.fetchWeatherByCity(city: formattedCity) { [weak self](forecast, err) in
            guard let this = self else {return}
            DispatchQueue.main.async {
                if err != nil {
                    Alert.showBasicAlert(vc: this, title: "Sorry", message: "We were unable to add that location")
                    return
                }
                guard let forecast = forecast else  { return }
                this.addCityToUserDefaults(city: city)
                this.forecasts.append(ForecastViewModel(forecast: forecast))
                this.tableView.reloadData()
            }
      }
    }
}
