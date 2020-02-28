//
//  SuggestionsTableViewController.swift
//  Hows The Weather
//
//  Created by Anthony on 14/02/20.
//  Copyright © 2020 EmeraldApps. All rights reserved.
//

import UIKit
import MapKit

class SuggestionsTableViewController: UITableViewController {
    
    let searchCompleter = MKLocalSearchCompleter()
    var completerResults: [MKLocalSearchCompletion]?
    
    
    convenience init() {
        self.init(style: .plain)
        searchCompleter.delegate = self
        searchCompleter.pointOfInterestFilter =  MKPointOfInterestFilter.excludingAll
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(SuggestedCompletionTableViewCell.self, forCellReuseIdentifier: SuggestedCompletionTableViewCell.reuseID)
    }
}

extension SuggestionsTableViewController{
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return completerResults?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SuggestedCompletionTableViewCell.reuseID, for: indexPath)

        if let suggestion = completerResults?[indexPath.row] {
            cell.textLabel?.text = suggestion.title
            cell.detailTextLabel?.text = suggestion.subtitle
        }

        return cell
    }
}

extension SuggestionsTableViewController: MKLocalSearchCompleterDelegate {
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        // Overwrite the existing results, and then refresh the UI with the new results.

        completerResults = completer.results
        tableView.reloadData()
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {

        if let error = error as NSError? {
            print("MKLocalSearchCompleter encountered an error: \(error.localizedDescription)")
        }
    }
}

extension SuggestionsTableViewController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        searchCompleter.queryFragment = searchController.searchBar.text ?? ""
    }
}

private class SuggestedCompletionTableViewCell: UITableViewCell {
    
    static let reuseID = "SuggestedCompletionTableViewCellReuseID"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
