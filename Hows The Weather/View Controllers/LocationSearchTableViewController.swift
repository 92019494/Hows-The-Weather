//
//  LocationSearchTableViewController.swift
//  Hows The Weather
//
//  Created by Anthony on 14/02/20.
//  Copyright © 2020 EmeraldApps. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class LocationSearchTableViewController: UITableViewController {

    private var places: [MKMapItem]? {
        didSet {
            tableView.reloadData()
        }
    }

    private var localSearch: MKLocalSearch? {
        willSet {
            /// stops current search before when set
            places = nil
            localSearch?.cancel()
        }
    }

    private var foregroundRestorationObserver: NSObjectProtocol?
    private var suggestionController: SuggestionsTableViewController!
    private var searchController: UISearchController!
    private var locationManager = LocationManager()
    private var boundingRegion: MKCoordinateRegion?
    var delegate: LocationSearchDelegate?
    var cellReuseID = "resultCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()

        initializeSuggestionTableViewController()
        setBoundingRegion()
        addForegroundObserver()
        
    }
   
    func initializeSuggestionTableViewController(){
        suggestionController = SuggestionsTableViewController()
        suggestionController.tableView.delegate = self
        
        searchController = UISearchController(searchResultsController: suggestionController)
        searchController.searchResultsUpdater = suggestionController
    }
    
    
    func addForegroundObserver(){
        foregroundRestorationObserver = NotificationCenter.default.addObserver(forName: Constants.foregroundNotificationName, object: nil, queue: nil, using: { [weak self] (_) in
            // Get a new location when returning from Settings to enable location services.
            self?.locationManager.requestLocation()
        })
    }
    
    func setBoundingRegion(){
        if let userLocation = locationManager.currentLocation {
            let region = MKCoordinateRegion(center: userLocation.coordinate, latitudinalMeters: 12_000, longitudinalMeters: 12_000)
            self.suggestionController.searchCompleter.region = region
            self.boundingRegion = region
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
       
        setupNavigationItem()
        setupSearchController()
        
        /// Search is presenting a view controller, and needs the presentation context to be defined by a controller in the presented view controller hierarchy.
        definesPresentationContext = true
    }
    
    func setupNavigationItem(){
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func setupSearchController(){
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Enter the name of the place"
    }

    func customiseSearchBar(sc: UISearchController){
        sc.searchBar.backgroundColor = UIColor.green
        sc.searchBar.searchTextField.backgroundColor = UIColor.red
        sc.searchBar.tintColor = UIColor.white
    }
    

    
    /// - Parameter suggestedCompletion: A search completion provided by `MKLocalSearchCompleter` when tapping on a search completion table row
    private func search(for suggestedCompletion: MKLocalSearchCompletion) {
        
        let searchRequest = MKLocalSearch.Request(completion: suggestedCompletion)
        search(using: searchRequest)
    }
    
    /// - Parameter queryString: A search string from the text the user entered into `UISearchBar`
    private func search(for queryString: String?) {
        
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = queryString
        search(using: searchRequest)
    }
    
    /// - Tag: SearchRequest
    private func search(using searchRequest: MKLocalSearch.Request) {
        
        if let region = boundingRegion {
            searchRequest.region = region
        }
        
        localSearch = MKLocalSearch(request: searchRequest)
        localSearch?.start { [weak self] (response, error) in
            guard let this = self else {return}
            guard error == nil else {
                Alert.showBasicAlert(vc: this, title: "Search Error", message: "Unable to find any places")
                return
            }
            this.places = response?.mapItems
            this.boundingRegion = response?.boundingRegion
        }
    }
}

extension LocationSearchTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseID, for: indexPath)
        
        if let mapItem = places?[indexPath.row] {
            cell.textLabel?.text = mapItem.name
            cell.detailTextLabel?.text = mapItem.placemark.formattedAddress
        }
        return cell
    }
}


extension LocationSearchTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        if tableView == suggestionController.tableView, let suggestion = suggestionController.completerResults?[indexPath.row] {
            searchController.isActive = false
            searchController.searchBar.text = suggestion.title
            search(for: suggestion)
        }
        
        if let placemark = places?[indexPath.row].placemark{
            let clPlacemark = CLPlacemark(placemark: placemark)
            delegate?.passLocation(placemark: clPlacemark)
            navigationController?.popViewController(animated: true)
            
        }
        
    }
}

extension LocationSearchTableViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        dismiss(animated: true, completion: nil)
        search(for: searchBar.text)
    }
}

extension LocationSearchTableViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("updated location")
    }
}
