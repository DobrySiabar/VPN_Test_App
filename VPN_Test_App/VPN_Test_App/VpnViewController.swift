//
//  ViewController.swift
//  VPN_Test_App
//
//  Created by Philip on 2/22/21.
//  Copyright © 2021 Philip. All rights reserved.
//

import UIKit

class VpnViewController: UIViewController {
    
    var coutnries = [Country]()
    var isConnected = false
    var vpnCountry: Country?
    
    @IBOutlet weak var activityIndicatror: UIActivityIndicatorView!
    @IBOutlet weak var connectingLabel: UILabel!
    @IBOutlet weak var connectOutlet: UIButton!
    
    @IBAction func connectButton(_ sender: UIButton) {
        handleActivityIndicator()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        connectOutlet.setTitle("Connect", for: .normal)
        createModel()
        contentInvisibility(true)
        if let country = vpnCountry {
            self.title = country.countryName
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        contentInvisibility(true)
        if segue.identifier == "tableView" {
            if let countriesPickerTableViewController = segue.destination as? CountriesPickerTableViewController {
                countriesPickerTableViewController.delegate = self
                countriesPickerTableViewController.coutnries = coutnries
            }
        }
    }
    
    func createModel() {
        let country1 = Country(countryName: "USA", image: UIImage(named: "usa-flag"))
        let country2 = Country(countryName: "France", image: UIImage(named: "france-flag"))
        let country3 = Country(countryName: "Norway", image: UIImage(named: "norway-flag"))
        
        coutnries.append(country1)
        coutnries.append(country2)
        coutnries.append(country3)
        
        vpnCountry = country1
    }
    
    func handleActivityIndicator() {
        if isConnected == false {
            contentInvisibility(false)
            self.connectingLabel.text = " Connecting..."
            self.activityIndicatror.startAnimating()
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                self.activityIndicatror.isHidden = true
                self.connectingLabel.text = " Connected to \(self.vpnCountry!.countryName)"
            }
        } else {
            contentInvisibility(true)
        }
        
        
    }
    
    func contentInvisibility(_ visible : Bool) {
        let title: String
        if visible {
            title = "Connect"
        } else {
            title = "Disconnect"
        }
        isConnected = !visible
        connectOutlet.setTitle(title, for: .normal)
        activityIndicatror.isHidden = visible
        connectingLabel.isHidden = visible
        
    }
    
}

extension VpnViewController: CountriesPickerTableViewControllerDelegate {
    func countriesPickerTableViewController(_ countriesPickerTableViewController: CountriesPickerTableViewController, didSelectItem item: Country) {
        vpnCountry = item
        self.title = vpnCountry!.countryName
        navigationController?.popViewController(animated:true)
    }
}
