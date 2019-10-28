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
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var graphView: GraphView!
    @IBOutlet weak var average: UILabel!
    @IBOutlet weak var max: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    var isGraphShowing = false
    
    @IBAction func counterViewTap(_ gesture: UITapGestureRecognizer?) {
        if (isGraphShowing) {
            // Hide the graph
            UIView.transition(from: graphView, to: counterView, duration: 1.0, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
        } else {
            // Show the graph
            UIView.transition(from: counterView, to: graphView, duration: 1.0, options: [.transitionFlipFromRight, .showHideTransitionViews], completion: nil)
        }
        isGraphShowing = !isGraphShowing
    }
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
        
        if isGraphShowing {
            counterViewTap(nil)
        }
    }
}
