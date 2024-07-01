//
//  AppExtension.swift
//  Jaydip_Practical
//
//  Created by Moksh Marakana on 01/07/24.
//

import Foundation
import UIKit

@IBDesignable extension UIView {
    @IBInspectable var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }

    @IBInspectable var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }

    @IBInspectable var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }

    @IBInspectable var maskToBound: Bool {
        get {
            return layer.masksToBounds
        }
        set {
            layer.masksToBounds = newValue
        }
    }
    @IBInspectable var shadowColor: UIColor? {
           set {
               layer.shadowColor = newValue!.cgColor
           }
           get {
               if let color = layer.shadowColor {
                   return UIColor(cgColor:color)
               }
               else {
                   return nil
               }
           }
       }
    
    @IBInspectable var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set {
              layer.cornerRadius = newValue
              layer.masksToBounds = (newValue > 0)
        }
    }
    @IBInspectable var borderWidth: CGFloat {
            get {
                return layer.borderWidth
            }
            set {
                layer.borderWidth = newValue
            }
        }
        
    @IBInspectable var borderColor: UIColor? {
            get {
                if let color = layer.borderColor {
                    return UIColor(cgColor: color)
                }
                return nil
            }
            set {
                if let color = newValue {
                    layer.borderColor = color.cgColor
                } else {
                    layer.borderColor = nil
                }
            }
        }
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = .zero
        layer.shadowRadius = 2
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    func set_gradient(dict:[String:Any])
    {
        self.layoutIfNeeded()
        for sublayer in self.layer.sublayers ?? [] {
            if sublayer.isKind(of: CAGradientLayer.self) {
                sublayer.removeFromSuperlayer()
            }
        }
        let top_color :UIColor = dict["Color1"] as! UIColor
        let botom_color :UIColor = dict["Color2"] as! UIColor
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        let topColor: CGColor = top_color.cgColor
        let bottomColor: CGColor = botom_color.cgColor
        gradientLayer.colors = [topColor, bottomColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
   
    
}
