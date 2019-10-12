//
//  CardViewController.swift
//  ReefDoser
//
//  Created by Isaac Ballas on 2019-10-03.
//  Copyright © 2019 Isaacballas. All rights reserved.
//

import UIKit

final class CardViewController: UIViewController {
    var chosenProduct: ProductName!
    var results = Double()
    // Default card view state
    var cardViewState: CardViewState = .normal
    // to store the card view top constraint value before the dragging starts, default is 30pt from safe area top
    var cardPanStartingTopConstraint: CGFloat = 30.0
    // Store the image
    var backingImage: UIImage?
    let keyWindow               = UIApplication.shared.connectedScenes
        .filter({$0.activationState == .foregroundActive})
        .map({$0 as? UIWindowScene})
        .compactMap({$0})
        .first?.windows
        .filter({$0.isKeyWindow}).first
    
    @IBOutlet weak var mlgrLabel: UILabel!
    @IBOutlet weak var ozLabel:   UILabel!
    @IBOutlet weak var tspLabel:  UILabel!
    @IBOutlet weak var backingImageView: UIImageView!
    @IBOutlet weak var dimmerView:       UIView!
    @IBOutlet weak var cardView:         UIView!
    @IBOutlet weak var cardViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var indicatorBar:     UIView!
    @IBOutlet weak var mlGrImage:        UIImageView!
    @IBOutlet weak var ozImage:          UIImageView!
    @IBOutlet weak var tspImage:         UIImageView!
    
    enum CardViewState {
        case expanded
        case normal
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        configureLabel(for: results)
        // Update the backing image view
        backingImageView.image = backingImage
        // Round the corners
        cardView.clipsToBounds = true
        cardView.layer.cornerRadius = 10.0
        cardView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        indicatorBar.clipsToBounds = true
        indicatorBar.layer.cornerRadius = 3.0
        // Hide the card view at the bottom
        if let safeAreaHeight = keyWindow?.safeAreaLayoutGuide.layoutFrame.size.height, let bottomPadding = keyWindow?.safeAreaInsets.bottom {
            cardViewTopConstraint.constant = safeAreaHeight + bottomPadding
        }
        // Set dimmer view to transparent
        dimmerView.alpha = 0.0
        
        let dimmerTap = UITapGestureRecognizer(target: self, action: #selector(dimmerViewTapped(_:)))
        dimmerView.addGestureRecognizer(dimmerTap)
        dimmerView.isUserInteractionEnabled = true
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(viewPanned(_:)))
        // iOS causes delay so get rid of it.
        panGesture.delaysTouchesBegan = false
        panGesture.delaysTouchesEnded = false
        self.view.addGestureRecognizer(panGesture)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showCard()
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
            mlgrLabel.text = "\(String(format: "%.2f", inML)) ml"
            mlGrImage.image   = UIImage(named: "Ml")
            ozLabel.text   = "\(String(format: "%.2f", inFlOz)) fluid oz"
            ozImage.image     = UIImage(named: "Ounce")
            tspLabel.text  = "\(String(format: "%.2f", inTsp)) teaspoons"
            tspImage.image    = UIImage(named: "Teaspoon")
        } else if chosenProduct.productType == .powder {
            mlgrLabel.text = "\(String(format: "%.2f", grams)) grams"
            mlGrImage.image   = UIImage(named: "Gram")
            ozLabel.text   = "\(String(format: "%.2f", oz)) ounces"
            ozImage.image     = UIImage(named: "Ounce")
            
            tspLabel.text  = "\(String(format: "%.2f", tsp)) teaspoons"
            tspImage.image    = UIImage(named: "Teaspoon")
        }
    }
    // MARK: - Gesture Recognizer
    @IBAction func dimmerViewTapped(_ tapRecognizer: UITapGestureRecognizer) {
        hideCardAndGoBack()
    }
    
    @IBAction func viewPanned(_ panRecognizer: UIPanGestureRecognizer) {
        // how much has user dragged
        let translation = panRecognizer.translation(in: self.view)
        // How fast the user dragged? need to see in case they do it very quickly.
        let velocity = panRecognizer.velocity(in: self.view)
        switch panRecognizer.state {
        case .began:
            cardPanStartingTopConstraint = cardViewTopConstraint.constant
        case .changed :
            if self.cardPanStartingTopConstraint + translation.y > 30.0 {
                self.cardViewTopConstraint.constant = self.cardPanStartingTopConstraint + translation.y
            }
            // change the dimmer view alpha based on how much user has dragged
            dimmerView.alpha = dimAlphaWithCardTopConstraint(value: self.cardViewTopConstraint.constant)
        case .ended :
            // if the user drags down very quick
            if velocity.y > 1500.0 {
                // hide the card and dismiss curent vc
                hideCardAndGoBack()
                return
            }
            if let safeAreaHeight = keyWindow?.safeAreaLayoutGuide.layoutFrame.size.height,
                let bottomPadding = keyWindow?.safeAreaInsets.bottom {
                
                if self.cardViewTopConstraint.constant < (safeAreaHeight + bottomPadding) * 0.25 {
                    // show the card at expanded state
                    showCard(atState: .expanded)
                } else if self.cardViewTopConstraint.constant < (safeAreaHeight) - 70 {
                    // show the card at normal state
                    showCard(atState: .normal)
                } else {
                    // hide the card and dismiss current view controller
                    hideCardAndGoBack()
                }
            }
        default:
            break
        }
    }
    
    private func dimAlphaWithCardTopConstraint(value: CGFloat) -> CGFloat {
        let fullDimAlpha : CGFloat = 0.7
        // ensure safe area height and safe area bottom padding is not nil
        guard let safeAreaHeight = keyWindow?.safeAreaLayoutGuide.layoutFrame.size.height,
            let bottomPadding = keyWindow?.safeAreaInsets.bottom else {
                return fullDimAlpha
        }
        // when card view top constraint value is equal to this,
        // the dimmer view alpha is dimmest (0.7)
        let fullDimPosition = (safeAreaHeight + bottomPadding) / 2.0
        // when card view top constraint value is equal to this,
        // the dimmer view alpha is lightest (0.0)
        let noDimPosition = safeAreaHeight + bottomPadding
        // if card view top constraint is lesser than fullDimPosition
        // it is dimmest
        if value < fullDimPosition {
            return fullDimAlpha
        }
        // if card view top constraint is more than noDimPosition
        // it is dimmest
        if value > noDimPosition {
            return 0.0
        }
        // else return an alpha value in between 0.0 and 0.7 based on the top constraint value
        return fullDimAlpha * 1 - ((value - fullDimPosition) / fullDimPosition)
    }
    
    // MARK: - Animations
    // default to show card at normal state, if showCard() is called without parameter
    private func showCard(atState: CardViewState = .normal) {
        // ensure there's no pending layout changes before animation runs
        self.view.layoutIfNeeded()
        // set the new top constraint value for card view
        // card view won't move up just yet, we need to call layoutIfNeeded()
        // to tell the app to refresh the frame/position of card view
        if let safeAreaHeight = keyWindow?.safeAreaLayoutGuide.layoutFrame.size.height,
            let bottomPadding = keyWindow?.safeAreaInsets.bottom {
            if atState == .expanded {
                // if state is expanded, top constraint is 30pt away from safe area top
                cardViewTopConstraint.constant = 30.0
            } else {
                cardViewTopConstraint.constant = (safeAreaHeight + bottomPadding) / 2.0
            }
            cardPanStartingTopConstraint = cardViewTopConstraint.constant
        }
        // move card up from bottom
        // create a new property animator
        let showCard = UIViewPropertyAnimator(duration: 0.25, curve: .easeIn, animations: {
            self.view.layoutIfNeeded()
        })
        // show dimmer view
        // this will animate the dimmerView alpha together with the card move up animation
        showCard.addAnimations {
            self.dimmerView.alpha = 0.7
        }
        // run the animation
        showCard.startAnimation()
    }
    
    private func hideCardAndGoBack() {
        // ensure there's no pending layout changes before animation runs
        self.view.layoutIfNeeded()
        // set the new top constraint value for card view
        // card view won't move down just yet, we need to call layoutIfNeeded()
        // to tell the app to refresh the frame/position of card view
        if let safeAreaHeight = keyWindow?.safeAreaLayoutGuide.layoutFrame.size.height,
            let bottomPadding = keyWindow?.safeAreaInsets.bottom {
            // move the card view to bottom of screen
            cardViewTopConstraint.constant = safeAreaHeight + bottomPadding
        }
        
        // move card down to bottom
        // create a new property animator
        let hideCard = UIViewPropertyAnimator(duration: 0.25, curve: .easeIn, animations: {
            self.view.layoutIfNeeded()
        })
        
        // hide dimmer view
        // this will animate the dimmerView alpha together with the card move down animation
        hideCard.addAnimations {
            self.dimmerView.alpha = 0.0
        }
        
        // when the animation completes, (position == .end means the animation has ended)
        // dismiss this view controller (if there is a presenting view controller)
        hideCard.addCompletion({ position in
            if position == .end {
                if(self.presentingViewController != nil) {
                    self.dismiss(animated: false, completion: nil)
                }
            }
        })
        // run the animation
        hideCard.startAnimation()
    }
    
    
    
}
