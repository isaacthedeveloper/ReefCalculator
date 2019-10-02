//
//  CalculatorViewController.swift
//  ReefDoser
//
//  Created by Isaac Ballas on 2019-09-10.
//  Copyright © 2019 Isaacballas. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController, UITextFieldDelegate {
    var chosenProduct: ProductName!
    var directionsVC: DirectionsViewController?
    static let identifier = "ShowDetail"
    var result = Double()
    // MARK: - Outlets
    @IBOutlet weak var waterVolumeTextField: UITextField!
    @IBOutlet weak var waterUnitSegmentedControl: UISegmentedControl!
    @IBOutlet weak var currentLevelLabel: UILabel!
    @IBOutlet weak var targetLevelLabel: UILabel!
    @IBOutlet weak var currentLevelTextField: UITextField!
    @IBOutlet weak var targetLevelTextField: UITextField!
    @IBOutlet weak var calculateButton: UIButton!
    @IBOutlet weak var transparentView: UIView!
    // Gesture Recognizer to dismiss the keyboard on swipe or on tap.
    // TODO: - Move this into an extension - nvm, keep it and show you can do it both ways.
    @IBOutlet weak var calculatorView: UIView! {
        didSet {
            let swipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeKeyboard))
            swipe.direction = .down
            calculatorView.addGestureRecognizer(swipe)
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(swipeKeyboard))
            calculatorView.addGestureRecognizer(tap)
        }
    }
    
    @objc func swipeKeyboard() {
        view.endEditing(true)
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareField()
        if let product = chosenProduct { title = product.name }
        
        waterUnitSegmentedControl.setTitle("Gallons", forSegmentAt: 0)
        waterUnitSegmentedControl.setTitle("Liters", forSegmentAt: 1)
        // selected option color
        waterUnitSegmentedControl.selectedSegmentTintColor = UIColor.systemBlue
        waterUnitSegmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        // color of other options
        waterUnitSegmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
        // Alkalinity is not measures in PPM, convert the label to reflect this.
        if chosenProduct.productCategory == .alkalinity {
            convertLabelTodKH()
        }
    }
    
    @IBAction func calculateButtonTapped(_ sender: UIButton) {
        if chosenProduct.productCategory == .phosphate || chosenProduct.productCategory == .trace {
            configureProducts()
            performSegue(withIdentifier: "ShowDetail", sender: sender)
        } else {
            checkDataInput()
            configureProducts()
            performSegue(withIdentifier: "ShowDetail", sender: sender)
        }
    }
    
    @IBAction func textFieldChanged(_ sender: UITextField) {
        // TODO: - Fix This - It should not be empty. It should check for the change in characters.
    }
    
    func checkDataInput() {
        let current = currentLevelTextField.text!
        let target  = targetLevelTextField.text!
        let volume  = waterVolumeTextField.text!
        if volume.isEmpty || current.isEmpty || target.isEmpty {
            fillInFieldsAlert()
        } else if current > target {
            targetIsGreaterThanCurrent()
        }
    }
    
    // MARK: - Label UI Helpers
    func convertLabelTodKH() {
        currentLevelLabel.text = "Current dKh"
        targetLevelLabel.text = "Target dKh"
    }
    
    // MARK: - Field UI Helpers
    func prepareField() {
        if chosenProduct.productCategory == .phosphate || chosenProduct.productCategory == .trace {
            currentLevelLabel.isHidden = true
            targetLevelLabel.isHidden = true
            currentLevelTextField.isHidden = true
            targetLevelTextField.isHidden = true
        } else {
        waterVolumeTextField.layer.cornerRadius = 40.0
        currentLevelTextField.layer.cornerRadius = 20.0
        targetLevelTextField.layer.cornerRadius = 20.0
        calculateButton.layer.cornerRadius = 40
    }
    }
    
    func hideFields() {
        currentLevelLabel.isHidden = true
        currentLevelTextField.isHidden = true
        targetLevelLabel.isHidden = true
        targetLevelTextField.isHidden = true
    }
    
    // MARK: - Product Switch Statment
    // TODO: - instead of convertToLiter try using the unit converter.
    func configureProducts() {
        var volume  = Double(waterVolumeTextField.text!) ?? 0
        let current = Double(currentLevelTextField.text!) ?? 0
        let target  = Double(targetLevelTextField.text!) ?? 0
        let ratio    = chosenProduct.productRatio
        let waterInGallons = Measurement(value: volume, unit: UnitVolume.gallons)
        let waterInLiters = waterInGallons.converted(to: .liters)
        
        let convertToLiter = 3.785
        
        if waterUnitSegmentedControl.selectedSegmentIndex == 1 {
            volume = volume / convertToLiter
            
        }

        
        self.resignFirstResponder()
        
        switch chosenProduct.name {
        case aquaForestKHPlus.name, brightwellAlk.name, brightwellReefCodeB.name, brightwellNanoCodeB.name, redseaReefFoundationB.name, esvp1.name, esvp2.name:
            // this is the result if a user used gallons, but the total result should be divided by liter
            result = calculateLiquidAlk(with: ratio, from: current, to: target, volume: volume)
            
        case seachemReefCarb.name:
            result = 10 * (target - current) * volume
            
        case seachemReefFusion2.name:
            result = (10 / ratio) * (target - current) * volume
            
        case aquaForestKHBuffer.name:
            result = 10 * ((target - current) / 1) * ratio * volume
            
        case brightwellAlkP.name, brightwellReefCodeBP.name, redseaReefFoundationBP.name:
            result = calculatePowderAlk(with: ratio, from: current, to: target, volume: volume)
            
        case seachemReefBuilder.name, seachemReefBuffer.name:
            result = 10 * (target - current) * ratio * volume
            
        // CALCIUM
        case aquaForestCAPlus.name, redseaReefFoundationA.name:
            result = calculateCalLiq(with: ratio, from: current, to: target, volume: volume)
            
        case aquaForestCAP.name, bwCalcionPow.name, bwReefCodeAPow.name, fpCalChlo.name, tlfCa.name, esvbc2.name, kentTurbo.name, redseaReefFoundationAPow.name:
            result = calculateLiquidAlk(with: ratio, from: current, to: target, volume: volume)
            
        case bwNanoCodeA.name, kentTech.name, bwReefCodeALiq.name, bwCalcionLiq.name, seachemReefFusion1L.name:
            result = calculateCalcium(with: ratio, from: current, to: target, volume: volume)
        case seachemReefAdv.name, seachemReefComp.name:
            result = calculateSeaChemCal(with: ratio, from: current, to: target, volume: volume)
        // Magnesium
        case aquaforestMgP.name, bwMgLiq.name, bwMgP.name, kentTechM.name, esvmg.name, rsmgpw.name, rsmgpw.name:
            result = calculateMagnesium(with: ratio, from: current, to: target, volume: volume)
        // Phosphate
        case brightwellPhosphate.name, redseaNoPox.name, aquaforestPhosphateMinus.name:
            result = ratio * volume
        // Trace element
        case afFluorine.name, afIodium.name, afIron.name, afKilum.name, afMicroE.name, afStrontium.name:
            result = ratio * volume
            
        default:
            break
        }
    }
    
    // MARK:- Calculation Methods
    
    /// Calculate liquid alkalinity products
    ///
    /// - Parameters:
    ///   - ratio: meq/L that will be raised by adding 1ml per gallon of water.
    ///   - currentLevel: current alkalinity level.
    ///   - targetLevel: target alkalinity level.
    ///   - volume: total water volume.
    /// - Returns: the calculated dose needed for the parameters.
    func calculateLiquidAlk(with ratio: Double,  from currentLevel: Double, to targetLevel: Double, volume: Double) -> Double {
        let result = (10 * (1/ratio) * (targetLevel - currentLevel) * volume)
        return result
    }
    
    func calculatePowderAlk(with ratio: Double, from currentLevel: Double, to targetLevel: Double, volume: Double) -> Double {
        let result = 10 * (( targetLevel - currentLevel) / ratio) * volume
        return result
    }
    
    func calculateSeaChemAlk(with ratio: Double, from currentLevel: Double, to targetLevel: Double, volume: Double) -> Double {
        let result = 10 * (targetLevel - currentLevel) * ratio * volume
        return result
    }
    
    func calculateCalLiq(with ratio: Double, from currentLevel: Double, to targetLevel: Double, volume: Double) -> Double {
        let result = (1 / (ratio * 10)) * (targetLevel - currentLevel) * volume
        return result
    }
    
    func calculateCalcium(with ratio: Double, from currentLevel: Double, to targetLevel: Double, volume: Double) -> Double {
        let result = (10 / ratio) * (targetLevel - currentLevel) * volume
        return result
    }
    
    func calculateSeaChemCal(with ratio: Double, from currentLevel: Double, to targetLevel: Double, volume: Double) -> Double {
        let result = ratio * (targetLevel - currentLevel) * volume
        return result
    }
    
    func calculateMagnesium(with ratio: Double, from currentLevel: Double, to targetLevel: Double, volume: Double) -> Double {
        let result = 10 * (targetLevel - currentLevel) * volume / ratio
        return result
    }
    
    
    // MARK: - Alert Methods
    func fillInFieldsAlert() {
        let alertController = UIAlertController(title: "Warning", message: "Please fill in all fields", preferredStyle: .alert)
        let alert           = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(alert)
        present(alertController, animated: true, completion: nil)
    }
    
    func targetIsGreaterThanCurrent() {
        let alertController = UIAlertController(title: "Warning", message: "The current value must not be larger than the target value.", preferredStyle: .alert)
        let alert           = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(alert)
        present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == CalculatorViewController.identifier {
            let directionsVC = segue.destination as! DirectionsViewController
            directionsVC.chosenProduct = chosenProduct
            directionsVC.results = result
        }
    }
}








