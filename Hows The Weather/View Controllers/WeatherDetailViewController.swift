//
//  WeatherDetailViewController.swift
//  Hows The Weather
//
//  Created by Anthony on 13/02/20.
//  Copyright © 2020 EmeraldApps. All rights reserved.
//

import UIKit

class WeatherDetailViewController: UIViewController {

    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    var forecast: ForecastViewModel?
    var currentForecastCellID = "currentForecastCell"
    var dailyForecastCellID = "dailyForecastCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTodaysLabels()
   
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    func setUpTodaysLabels(){
        cityLabel.text = forecast?.name
        temperatureLabel.text = forecast?.temperatureWithoutSymbol
        descriptionLabel.text = forecast?.description
    }
    
    @IBAction func backButtonClicked(_ sender: Any) {
        navigationController?.popViewController(animated: false)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension WeatherDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return forecast!.data.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: dailyForecastCellID)
                as! DailyForecastTableViewCell
            
            cell.forecast = forecast!.data[indexPath.row]
            
            if indexPath.row == 0 {
                cell.dayLabel.text = "Today"
            } else {
                cell.dayLabel.text = forecast!.data[indexPath.row].currentDay
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: currentForecastCellID) as! CurrentForecastTableViewCell
            
            cell.forecast = forecast!
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 45
        } else {
            return 320
        }
    }
}
