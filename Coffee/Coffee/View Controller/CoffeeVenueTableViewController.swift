//
//  CoffeeVenueTableViewController.swift
//  Coffee
//
//  Created by Daniel Lau on 6/18/18.
//  Copyright © 2018 Daniel Lau. All rights reserved.
//

import UIKit
import CoreLocation

class CoffeeVenueTableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Properties
    let locationManager = CLLocationManager()
    
    //MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        locationManager.delegate = self
        currentlocation()
        self.becomeFirstResponder()
    }
    
    @IBAction func testFetchButton(_ sender: Any) {
        fetchesCoffee()
    }
   
    func fetchesCoffee() {
        guard let coordinate = locationManager.location?.coordinate else { return }
        CoffeeController.shared.searchCoffee(with: coordinate) { (coffee) in
            DispatchQueue.main.async {
                guard let coffee = coffee else { return }
                CoffeeController.shared.coffeevenues = coffee
                
                self.tableView.reloadData()
            }
        }
    }
}

extension CoffeeVenueTableViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CoffeeController.shared.coffeevenues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "coffeeCell") as! CoffeeVenueTableViewCell
        
        let coffee = CoffeeController.shared.coffeevenues[indexPath.row]
        cell.coffeevenue = coffee
        CoffeePhotoController.shared.searchCoffePhotoLink(with: coffee.id) { (photo) in
            if let photo = photo {
                guard let suffix = photo.first?.suffix else { return }
                CoffeePhotoController.shared.dataToPhoto(with: suffix, completion: { (images) in
                    DispatchQueue.main.async {
                        if let image = images {
                            cell.coffeeImageView.image = image
                        }
                    }
                    
                })
            }
        }
        return cell
    }
}

extension CoffeeVenueTableViewController: CLLocationManagerDelegate {
    
    //MARK: - Shake Gesture
    override var canBecomeFirstResponder: Bool {
        get {
            return true
        }
    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            fetchesCoffee()
        }
    }
    //MARK: - Fetches Current location
    func currentlocation() {
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
}
