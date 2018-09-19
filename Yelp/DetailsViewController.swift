//
//  DetailsViewController.swift
//  Yelp
//
//  Created by Will Xu  on 9/19/18.
//  Copyright © 2018 Timothy Lee. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var ratingLabel: UIImageView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var categoriesLabel: UILabel!
    @IBOutlet weak var priceLabel: UITextField!
    
    var business: Business!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = business.name ?? ""
        if (business.imageURL != nil) {
            thumbImageView.setImageWith(business.imageURL!)
        }
        categoriesLabel.text = business.categories
        addressLabel.text = business.address
        ratingLabel.image = business.ratingImage
        distanceLabel.text = business.distance
        priceLabel.text = business.priceString
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
