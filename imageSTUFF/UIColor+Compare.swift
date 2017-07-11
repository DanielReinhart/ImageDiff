//
//  UIColor+Compare.swift
//  imageSTUFF
//
//  Created by Daniel Reinhart on 7/11/17.
//  Copyright © 2017 Daniel Reinhart. All rights reserved.
//

import UIKit

extension UIColor {
    func isBlack() -> Bool {
        let ciPixel = CIColor(color: self)
        return !(ciPixel.red >= 250 && ciPixel.green >= 250 && ciPixel.blue >= 250)
    }

    func isEqualToColor(color2: UIColor, withTolerance tolerance: CGFloat) -> Bool {
        let ciColor1 = CIColor(color: self)
        let ciColor2 = CIColor(color: color2)

        let deltaR = fabs(ciColor1.red - ciColor2.red)
        let deltaG = fabs(ciColor1.green - ciColor2.green)
        let deltaB = fabs(ciColor1.blue - ciColor2.blue)

        let deltaA = fabs(ciColor1.alpha - ciColor2.alpha)

        return deltaR <= tolerance &&
               deltaG <= tolerance &&
               deltaB <= tolerance &&
               deltaA <= tolerance
    }

    func average(color2: UIColor) -> UIColor {
        let ciColor1 = CIColor(color: self)
        let ciColor2 = CIColor(color: color2)

        let averageColor = UIColor(red: (ciColor1.red + ciColor2.red) / 2,
                                            green: (ciColor1.green + ciColor2.green) / 2,
                                            blue: (ciColor1.blue + ciColor2.blue) / 2,
                                            alpha: (ciColor1.alpha + ciColor2.alpha) / 2)
        return averageColor
    }
}
