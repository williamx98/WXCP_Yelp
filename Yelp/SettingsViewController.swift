//
//  SettingsViewController.swift
//  Yelp
//
//  Created by Will Xu  on 9/18/18.
//  Copyright © 2018 Timothy Lee. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var locationField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationField.delegate = self
        self.locationField.text = YelpClient.sharedInstance.location
        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        YelpClient.sharedInstance.location = self.locationField.text
        self.locationField.endEditing(true)
        return true
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
