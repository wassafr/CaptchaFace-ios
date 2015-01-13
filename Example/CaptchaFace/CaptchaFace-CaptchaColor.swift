//
//  CaptchaColor.swift
//  CaptchaFace
//
//  Created by Dorothée DOUBLET on 13/01/2015.
//  Copyright (c) 2015 Peter Schaeffer. All rights reserved.
//

import Foundation

extension UIColor
{
    class func CaptchaColor(hex: Int, alpha: Double = 1.0) -> UIColor
    {
        let red = Double((hex & 0xFF0000) >> 16) / 255.0
        let green = Double((hex & 0xFF00) >> 8) / 255.0
        let blue = Double((hex & 0xFF)) / 255.0
        var color: UIColor = UIColor( red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha:CGFloat(alpha) )
        return color
    }
}