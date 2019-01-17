//
//  Gradient.swift
//  MyContacts
//
//  Created by GLB-311-PC on 12/01/19.
//  Copyright © 2019 Globussoft. All rights reserved.
//

import UIKit

@IBDesignable
final class GradientView: UIView {
    @IBInspectable var FirstColor: UIColor = UIColor.clear {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var SecondColor: UIColor = UIColor.clear {
        didSet {
            updateView()
        }
    }
    
    override class var layerClass: AnyClass {
        get {
            return CAGradientLayer.self
        }
    }
    
    func updateView() -> Void {
        
        let layer = self.layer as! CAGradientLayer
        layer.colors = [FirstColor.cgColor, SecondColor.cgColor]
    }
    
}
