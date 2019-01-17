//
//  CustomImageView.swift
//  MyContacts
//
//  Created by GLB-311-PC on 15/01/19.
//  Copyright © 2019 Globussoft. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class CustomImageView: UIImageView
{
    override func layoutSubviews() {
        super.layoutSubviews()
        updateCircle()
    }
    
    @IBInspectable var circleMake:Bool = false {
        didSet {
            updateCircle()
        }
    }
    
    @IBInspectable var borderColor:UIColor = UIColor.black {
        didSet {
            updateBordercolor()
        }
    }
    
    func updateCircle() {
        layer.cornerRadius = circleMake ?  frame.size.height/2 : 0
    }
    
    func updateBordercolor() {
        layer.borderColor = borderColor.cgColor
        layer.borderWidth=1
    }
}

