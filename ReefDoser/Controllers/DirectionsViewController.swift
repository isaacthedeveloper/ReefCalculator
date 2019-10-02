//
//  DirectionsViewController.swift
//  ReefDoser
//
//  Created by Isaac Ballas on 2019-09-23.
//  Copyright © 2019 Isaacballas. All rights reserved.
//

import UIKit

class DirectionsViewController: UIViewController {
    var chosenProduct: ProductName!
    var results = Double()
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var mlgrLabel: UILabel!
    @IBOutlet weak var ozLabel: UILabel!
    @IBOutlet weak var tspLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        print(results)
        configureLabel(for: results)
        popupView.layer.cornerRadius = 10
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(close))
        gestureRecognizer.cancelsTouchesInView = false
        gestureRecognizer.delegate = self
        view.addGestureRecognizer(gestureRecognizer)
    }
    // MARK: - Actions
    @IBAction func close() {
        dismiss(animated: true, completion: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        modalPresentationStyle = .custom
        transitioningDelegate = self
    }
    
    public func configureLabel(for results: Double) {
        // Liquid
        let inML = (results/10)
        let inFlOz = ((results * 0.033814)/10)
        let inTsp = ((results/5)/10)
        // Powder
        let grams = (results / 10)
        let tsp = (results/4.6)/10
        let oz = (results/28.35)/10

        if chosenProduct.productType == .liquid {
            //mlGrLabel.text = String(roundedMl)
            mlgrLabel.text = "\(String(format: "%.2f", inML)) ml"
            ozLabel.text = "\(String(format: "%.2f", inFlOz)) fluid oz"
            tspLabel.text = "\(String(format: "%.2f", inTsp)) teaspoons"
        } else if chosenProduct.productType == .powder {
            mlgrLabel.text = "\(String(format: "%.2f", grams)) grams"
            ozLabel.text = "\(String(format: "%.2f", oz)) ounces"
            tspLabel.text = "\(String(format: "%.2f", tsp)) teaspoons"
        }
    }

}

extension DirectionsViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return DimmingPresentationViewController(presentedViewController: presented, presenting: presenting)
    }
}

extension DirectionsViewController: UIGestureRecognizerDelegate {
    // TODO: - do this for all tap gesture
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return (touch.view === self.view)
    }
}
