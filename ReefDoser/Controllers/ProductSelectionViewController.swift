//
//  ProductSelectionViewController.swift
//  ReefDoser
//
//  Created by Isaac Ballas on 2019-08-30.
//  Copyright © 2019 Isaacballas. All rights reserved.
//

import UIKit

final class ProductSelectionViewController: UITableViewController, UINavigationControllerDelegate {
    var products = [ProductName]()
    var parameter = String()
    static let identifier = "ProductCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "\(parameter) Additives"
        navigationItem.largeTitleDisplayMode = .never
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductSelectionViewController.identifier, for: indexPath)
        cell.textLabel?.text = products[indexPath.row].name
        cell.detailTextLabel?.text = products[indexPath.row].productType.rawValue
        return cell
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? CalculatorViewController else { fatalError("ERROR DID NOT PERFROM THE CORRECT SEGUE") }
        if segue.identifier == "goToCalculator" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let chosenProduct = products[indexPath.row] as ProductName
                destinationVC.chosenProduct = chosenProduct
            }
        }
    }
}

