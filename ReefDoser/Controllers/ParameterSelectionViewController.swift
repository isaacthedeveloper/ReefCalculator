//
//  ViewController.swift
//  ReefDoser
//
//  Created by Isaac Ballas on 2019-08-29.
//  Copyright © 2019 Isaacballas. All rights reserved.
//

import UIKit

final class ParameterSelectionViewController: UICollectionViewController {
    let productSegueIdentifier = "goToProductViewController"
    var flowLayout = ColumnFlowLayout()
    lazy var parameters = parameterData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareCollectionView()
    }
    
    // MARK: - UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return parameters.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ParameterCell.identifier, for: indexPath) as! ParameterCell
        cell.parameter = parameters[indexPath.item]
        cell.backgroundColor = UIColor.colorArray[indexPath.item]
        return cell
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let productViewController = segue.destination as? ProductSelectionViewController else {
            fatalError()
        }
        
        if segue.identifier == productSegueIdentifier {
            if let indexPaths = collectionView.indexPathsForSelectedItems {
                let indexPath = indexPaths[0]
                let products = parameters[indexPath.item] as Parameter
                let productNames = products.productName
                navigationItem.backBarButtonItem = UIBarButtonItem(title: "Parameters", style: .plain, target: nil, action: nil)
                productViewController.products = productNames
                productViewController.parameter = products.parameterName
            }
        }
    }
    
    // MARK: UI Helper Methods
    func prepareCollectionView() {
        guard let navController = self.navigationController else { return }
        // Customize navigation bar.
        self.title = "Parameters"
        navController.navigationBar.prefersLargeTitles  = true
        navController.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        // Set up the collection view.
        collectionView.autoresizingMask                 = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor                  = UIColor.appBackgroundColor
        collectionView.alwaysBounceVertical             = true
        collectionView.indicatorStyle                   = .black
    }
    
    
}




