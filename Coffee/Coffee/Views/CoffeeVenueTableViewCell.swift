//
//  CoffeeVenueTableViewCell.swift
//  Coffee
//
//  Created by Daniel Lau on 6/18/18.
//  Copyright © 2018 Daniel Lau. All rights reserved.
//

import UIKit

class CoffeeVenueTableViewCell: UITableViewCell {
    
    var coffeevenue: CoffeeVenue? {
        didSet {
            updateCell()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func updateCell() {
        guard let coffee = coffeevenue else { return }
        coffeeVenueLabel.text = coffee.name
        addressLabel.text = coffee.location.address
        distanceLabel.text = "The place is " + String(coffee.location.distance) + " meters away"
        cityLabel.text = coffee.location.city
        stateLabel.text = coffee.location.state
    }
    
    @IBOutlet weak var coffeeVenueLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var coffeeImageView: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    
    
}
