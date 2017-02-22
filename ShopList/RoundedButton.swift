//
//  RoundedButton.swift
//  ShopList
//  300907406
//  Created by Serhii Pianykh on 2017-02-21.
//  Copyright © 2017 Serhii Pianykh. All rights reserved.
//  Button extension which allows to control corner radius

import UIKit

private var rounded = false
private var cornerRadius = 5

extension UIButton {
    
    @IBInspectable var roundedButton : Bool {
        get {
            return rounded
        }
        
        set {
            rounded = newValue
            
            if rounded {
                self.layer.cornerRadius = CGFloat(cornerRadius)
            } else {
                self.layer.cornerRadius = CGFloat(cornerRadius)
            }
        }
        
    }
    
    @IBInspectable var radius: Int {
        get {
            return cornerRadius
        }
        
        set {
            cornerRadius = newValue
        }
    }
    
}
