//
//  CustomButton.swift
//  MyContacts
//
//  Created by Khusboo Suhasini Preety on 14/01/19.
//  Copyright © 2019 Globussoft. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class CustomButton: UIButton
{
    override func layoutSubviews() {
        super.layoutSubviews()
        
        updateCircle()
    }
    
    @IBInspectable var borderColor:UIColor = UIColor.black {
        didSet {
            updateBorder()
        }
    }
    
    @IBInspectable var cornerRadius: Bool = false {
        didSet {
            updateCornerRadius()
        }
    }
    @IBInspectable var circleMake:Bool = false {
        didSet {
            updateCircle()
        }
    }
    func updateCircle() {
        layer.cornerRadius = circleMake ?  frame.size.height/2 : 0
    }
    
    func updateBorder() {
        layer.borderColor = borderColor.cgColor
        layer.borderWidth=1
    }
    
    func updateCornerRadius() {
        layer.cornerRadius = cornerRadius ?  5 : 0
    }
}
