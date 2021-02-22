//
//  CountriesPickerTableViewController.swift
//  VPN_Test_App
//
//  Created by Philip on 2/22/21.
//  Copyright © 2021 Philip. All rights reserved.
//

import UIKit

protocol CountriesPickerTableViewControllerDelegate: class {
    func countriesPickerTableViewController(_ menuViewController: CountriesPickerTableViewController, didSelectItem item: Country)
}

class CountriesPickerTableViewController: UITableViewController {

    var coutnries = [Country]()
    public weak var delegate: CountriesPickerTableViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coutnries.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        cell.textLabel?.text = coutnries[indexPath.row].countryName
        cell.imageView?.image = coutnries[indexPath.row].image
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.countriesPickerTableViewController(self, didSelectItem: coutnries[indexPath.row])
    }


}


