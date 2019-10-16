//
//  ParameterCell.swift
//  ReefDoser
//
//  Created by Isaac Ballas on 2019-08-29.
//  Copyright © 2019 Isaacballas. All rights reserved.
//


import UIKit
final class ParameterCell: UICollectionViewCell {
  static let identifier = "ParameterCell"
  let bgView            = UIView()
  let nameLabel         = UILabel()
  let symbolLabel       = UILabel()
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    self.layer.cornerRadius  = 10.0
    self.layer.borderWidth   = 1.0
    self.layer.borderColor   = UIColor.clear.cgColor
    self.layer.shadowColor   = UIColor.black.cgColor
    self.layer.shadowOffset  = CGSize(width: 1.0, height: 1.0)
    self.layer.shadowRadius  = 2.0
    self.layer.shadowOpacity = 1
    self.layer.masksToBounds = false
   
    let labelStackView = UIStackView()
    labelStackView.translatesAutoresizingMaskIntoConstraints = false
    labelStackView.axis = .vertical
    labelStackView.isBaselineRelativeArrangement = true
    labelStackView.spacing = 21.0
    self.addSubview(labelStackView)
    
    nameLabel.textColor = UIColor.white
    nameLabel.font      = UIFont.systemFont(ofSize: 34, weight: .regular)
    nameLabel.layer.masksToBounds = false
    nameLabel.translatesAutoresizingMaskIntoConstraints = false
    // Add Shadows
    nameLabel.layer.shadowColor   = UIColor.black.cgColor
    nameLabel.layer.shadowRadius  = 1.5
    nameLabel.layer.shadowOpacity = 1.0
    nameLabel.layer.shadowOffset  = CGSize(width: 2, height: 2)
    self.addSubview(nameLabel)
    
    symbolLabel.textColor       = UIColor.white
    symbolLabel.backgroundColor = UIColor.clear
    symbolLabel.font            = UIFont.systemFont(ofSize: 36, weight: .bold)
    symbolLabel.layer.masksToBounds = false
    symbolLabel.translatesAutoresizingMaskIntoConstraints = false
    // Add Shadows
    symbolLabel.layer.shadowColor   = UIColor.black.cgColor
    symbolLabel.layer.shadowRadius  = 3.0
    symbolLabel.layer.shadowOpacity = 1.0
    symbolLabel.layer.shadowOffset  = CGSize(width: 4, height: 4)
    self.addSubview(symbolLabel)
    
    setupConstraints()
  }
  
  func setupConstraints() {
    let constraints = [
      nameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
      nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 120),
      symbolLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25.0),
      symbolLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
    ]
    NSLayoutConstraint.activate(constraints)
  }
  
  var parameter: Parameter? {
    didSet {
      nameLabel.text   = parameter?.parameterName
      symbolLabel.text = parameter?.parameterSymbol
    }
  }
  
  override var isHighlighted: Bool {
    didSet {
      let duration  = isHighlighted ? 0.45 : 0.4
      let transform = isHighlighted ?
        CGAffineTransform(scaleX: 0.96, y: 0.96) : CGAffineTransform.identity
      let bgColor = isHighlighted ?
        UIColor(white: 1.0, alpha: 0.2) : UIColor(white: 1.0, alpha: 0.1)
      let animations = {
        self.transform = transform
        self.bgView.backgroundColor = bgColor
      }
      
      UIView.animate(withDuration: duration,
                     delay: 0,
                     usingSpringWithDamping: 1.0,
                     initialSpringVelocity: 0.0,
                     options: [.allowUserInteraction, .beginFromCurrentState],
                     animations: animations,
                     completion: nil)
    }
  }
}


