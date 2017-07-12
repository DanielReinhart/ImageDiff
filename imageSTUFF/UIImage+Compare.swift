//
//  UIImage+Compare.swift
//  imageSTUFF
//
//  Created by Daniel Reinhart on 7/11/17.
//  Copyright © 2017 Daniel Reinhart. All rights reserved.
//

import UIKit
import CoreGraphics
import QuartzCore

extension UIImage {
    func compare(to image2: UIImage) -> UIImage {
        let pixelArray1 = Image_Pixels.getRGBAsFrom(self, atX: 0, andY: 0, count: Int32(self.size.width * self.size.height)) as! [UIColor]
        let pixelArray2 = Image_Pixels.getRGBAsFrom(image2, atX: 0, andY: 0, count: Int32(image2.size.width * image2.size.height)) as! [UIColor]

        let convertedImage = self.cgImage!

        let cgContext = CGContext.init(data: nil,
                                       width: convertedImage.width,
                                       height: convertedImage.height,
                                       bitsPerComponent: convertedImage.bitsPerComponent,
                                       bytesPerRow: convertedImage.bytesPerRow,
                                       space: convertedImage.colorSpace!,
                                       bitmapInfo: convertedImage.bitmapInfo.rawValue)

        for row in 0..<Int(self.size.height) {
            for column in 0..<Int(self.size.width) {
                let pixel1 = pixelArray1[row * Int(self.size.width) + column]
                let pixel2 = pixelArray2[row * Int(self.size.width) + column]

                let bezierPath = UIBezierPath(rect: CGRect(x: column, y: row, width: 1, height: 1))
                cgContext?.saveGState()
                if pixel1.isEqualToColor(color2: pixel2, withTolerance: 0.0125) {
                    cgContext?.addPath(bezierPath.cgPath)
                    cgContext?.setFillColor(pixel1.average(color2: pixel2).cgColor)
                    cgContext?.fillPath()
                } else if pixel1.isEqualToColor(color2: UIColor.white, withTolerance: 0.1) {
                    cgContext?.addPath(bezierPath.cgPath)
                    cgContext?.setFillColor(UIColor.blue.cgColor)
                    cgContext?.fillPath()
                } else if pixel2.isEqualToColor(color2: UIColor.white, withTolerance: 0.1) {
                    cgContext?.addPath(bezierPath.cgPath)
                    cgContext?.setFillColor(UIColor.red.cgColor)
                    cgContext?.fillPath()
                } else {
                    cgContext?.addPath(bezierPath.cgPath)
                    cgContext?.setFillColor(UIColor.white.cgColor)
                    cgContext?.fillPath()
                }
                cgContext?.restoreGState()
            }
        }

        let outputImage = cgContext!.makeImage()!
        return UIImage(cgImage: outputImage, scale: 1.0, orientation: .downMirrored)
    }
}
