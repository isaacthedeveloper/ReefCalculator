//
//  GraphingViewController.swift
//  ReefDoser
//
//  Created by Isaac Ballas on 2019-10-25.
//  Copyright © 2019 Isaacballas. All rights reserved.
//
import UIKit

class GraphingViewController: UIViewController {
    @IBOutlet weak var counterView: CounterView!
    @IBOutlet weak var counterLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        counterLabel.text = String(counterView.counter)
    }
    @IBAction func pushButtonPressed(_ button: PushButton) {
        if button.isAddButton {
            counterView.counter += 1
        } else {
            if counterView.counter > 0 {
                counterView.counter -= 1
            }
        }
        counterLabel.text = String(counterView.counter)
    }
}
