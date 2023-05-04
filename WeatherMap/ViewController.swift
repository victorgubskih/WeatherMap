//
//  ViewController.swift
//  WeatherMap
//
//  Created by viktor on 01.05.2023.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var dataSourse: WeatherModel?
    let networkManager = NetworkManager()
    let hourlyFormatter = DateFormatter()
    let dailyFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        tableView.delegate = self
        tableView.dataSource = self
        
        hourlyFormatter.dateFormat = "HH:mm"
        hourlyFormatter.timeZone = TimeZone.current
        dailyFormatter.dateFormat = "YYYY MMM dd"
        dailyFormatter.timeZone = TimeZone.current
        
       
        networkManager.obtainWeather { [self] weatherData in
            self.dataSourse = WeatherModel(data: weatherData)
           
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "identifier", for: indexPath)
        
        let time = dataSourse?.daily[indexPath.section].hourly[indexPath.row].time ?? Date()
       
        cell.textLabel?.text = hourlyFormatter.string(from: time)
        cell.detailTextLabel?.text = dataSourse?.daily[indexPath.section].hourly[indexPath.row].temperature
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let day = dataSourse?.daily[section].time ?? Date()
        return dailyFormatter.string(from: day)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSourse?.daily.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSourse?.daily[section].hourly.count ?? 0
    }


}

