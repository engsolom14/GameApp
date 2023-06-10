//
//  GradientView.swift
//  Salamtak PatientApp
//
//  Created by Eslam on 18/03/2022.
//  Copyright © 2022 Es. All rights reserved.
//

import Foundation
import UIKit

//@IBDesignable
class GradientView: UIView {
    private let gradientLayer = CAGradientLayer()
    
    @IBInspectable var startColor: UIColor = #colorLiteral(red: 1, green: 0.6901960784, blue: 0.4274509804, alpha: 0.2609685431) {
        didSet {
            updateColors()
        }
    }
    
    @IBInspectable var endColor: UIColor = #colorLiteral(red: 0.9725490196, green: 0.6196078431, blue: 0.3176470588, alpha: 0.8154232202) {
        didSet {
            updateColors()
        }
    }
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGradient()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupGradient()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
    
    private func setupGradient() {
        layer.addSublayer(gradientLayer)
        updateColors()
    }
    
    private func updateColors() {
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
    }
}
