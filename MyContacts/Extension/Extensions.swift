//
//  Extensions.swift
//  MyContacts
//
//  Created by GLB-311-PC on 12/01/19.
//  Copyright © 2019 Globussoft. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func setGradientBackgroundColor(colorOne:UIColor,colorTwo:UIColor){
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors=[colorOne.cgColor,colorTwo.cgColor]
        gradientLayer.locations=[0.0,1.0]
        gradientLayer.startPoint = CGPoint(x: 1.0, y:1.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.0)
        layer.insertSublayer(gradientLayer, at: 0)
 }

}

extension UIButton {
    func setMakeCircle(){
        self.layer.cornerRadius=self.frame.size.width/2
    }
}

extension UIImageView {
    func setMakeCircle(){
        self.layoutIfNeeded()
        self.layer.cornerRadius=self.frame.size.width/2
    }
}

extension UIColor {
    
    // Create a UIColor from RGB
    convenience init(red: Int, green: Int, blue: Int, a: CGFloat = 1.0) {
        
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: a
        )
    }
    
    // Create a UIColor from a hex value (E.g 0x000000)
    convenience init(hex: Int, a: CGFloat = 1.0) {
        self.init(
            red: (hex >> 16) & 0xFF,
            green: (hex >> 8) & 0xFF,
            blue: hex & 0xFF,
            a: a
        )
    }
    
}
