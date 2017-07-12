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
    typealias Pixel = (r: CGFloat, g:CGFloat, b:CGFloat, a:CGFloat)

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
                if pixel1.isEqualToColor(color2: pixel2, withTolerance: 0.5) {
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

    func compare2(to image2: UIImage) -> UIImage {
        let rawData1 = self.getRawDataForImage(image: self)
        let rawData2 = self.getRawDataForImage(image: image2)

        let convertedImage = self.cgImage!

        let cgContext = CGContext.init(data: nil,
                                       width: convertedImage.width,
                                       height: convertedImage.height,
                                       bitsPerComponent: convertedImage.bitsPerComponent,
                                       bytesPerRow: convertedImage.bytesPerRow,
                                       space: convertedImage.colorSpace!,
                                       bitmapInfo: convertedImage.bitmapInfo.rawValue)

        var byteIndex: Int = 0
        var row: Int = 0
        
        for _ in 0..<Int32(self.size.width * self.size.height) {
            let alpha1 = CGFloat(rawData1[byteIndex + 3] / 255)
            let alpha2 = CGFloat(rawData2[byteIndex + 3] / 255)

            let red1 = CGFloat(rawData1[byteIndex] / 255)
            let red2 = CGFloat(rawData2[byteIndex] / 255)

            let green1 = CGFloat(rawData1[byteIndex + 1] / 255)
            let green2 = CGFloat(rawData2[byteIndex + 1] / 255)

            let blue1 = CGFloat(rawData1[byteIndex + 2] / 255)
            let blue2 = CGFloat(rawData2[byteIndex + 2] / 255)

            let color1 = UIColor(red: red1, green: green1, blue: blue1, alpha: alpha1)
            let color2 = UIColor(red: red2, green: green2, blue: blue2, alpha: alpha2)

            let bezierPath = UIBezierPath(rect: CGRect(x:byteIndex / 4 % Int(size.width), y: row, width: 1, height: 1))
            cgContext?.saveGState()
            if color1.isEqualToColor(color2: color2, withTolerance: 0.5) {
                cgContext?.addPath(bezierPath.cgPath)
                cgContext?.setFillColor(color1.average(color2: color2).cgColor)
                cgContext?.fillPath()
            } else if color1.isEqualToColor(color2: UIColor.white, withTolerance: 0.1) {
                cgContext?.addPath(bezierPath.cgPath)
                cgContext?.setFillColor(UIColor.blue.cgColor)
                cgContext?.fillPath()
            } else if color2.isEqualToColor(color2: UIColor.white, withTolerance: 0.1) {
                cgContext?.addPath(bezierPath.cgPath)
                cgContext?.setFillColor(UIColor.red.cgColor)
                cgContext?.fillPath()
            } else {
                cgContext?.addPath(bezierPath.cgPath)
                cgContext?.setFillColor(UIColor.white.cgColor)
                cgContext?.fillPath()
            }
            cgContext?.restoreGState()

            byteIndex += 4
            row = Int(floor(Double(byteIndex / Int(size.width) / 4)))
        }

        let outputImage = cgContext!.makeImage()!
        return UIImage(cgImage: outputImage, scale: 1.0, orientation: .downMirrored)
    }

    func compare3(to image2: UIImage) -> UIImage {
        let rawData1 = self.getRawDataForImage(image: self)
        let rawData2 = self.getRawDataForImage(image: image2)

        let convertedImage = self.cgImage!

        let cgContext = CGContext.init(data: nil,
                                       width: convertedImage.width,
                                       height: convertedImage.height,
                                       bitsPerComponent: convertedImage.bitsPerComponent,
                                       bytesPerRow: convertedImage.bytesPerRow,
                                       space: convertedImage.colorSpace!,
                                       bitmapInfo: convertedImage.bitmapInfo.rawValue)

        var byteIndex: Int = 0
        var row: Int = 0

        let whitePixel: Pixel = (r: 1, g:1, b:1, a:1)

        for _ in 0..<Int32(self.size.width * self.size.height) {
            let alpha1 = CGFloat(rawData1[byteIndex + 3]) / 255.0
            let alpha2 = CGFloat(rawData2[byteIndex + 3]) / 255.0

            let red1 = CGFloat(rawData1[byteIndex]) / 255.0
            let red2 = CGFloat(rawData2[byteIndex]) / 255.0

            let green1 = CGFloat(rawData1[byteIndex + 1]) / 255.0
            let green2 = CGFloat(rawData2[byteIndex + 1]) / 255.0

            let blue1 = CGFloat(rawData1[byteIndex + 2]) / 255.0
            let blue2 = CGFloat(rawData2[byteIndex + 2]) / 255.0

            let pixelTuple1: Pixel = (r: red1, g: green1, b:blue1, a:alpha1)
            let pixelTuple2: Pixel = (r: red2, g: green2, b:blue2, a:alpha2)

            let bezierPath = UIBezierPath(rect: CGRect(x:byteIndex / 4 % Int(size.width), y: row, width: 1, height: 1))
            cgContext?.saveGState()
            if isPixelEqualToPixel(pixel1: pixelTuple1, pixel2: pixelTuple2, withTolerance: 0.4) {
                cgContext?.addPath(bezierPath.cgPath)
                cgContext?.setFillColor(averageColorForPixels(pixel1: pixelTuple1, pixel2: pixelTuple2).cgColor)
                cgContext?.fillPath()
            } else if isPixelEqualToPixel(pixel1: pixelTuple1, pixel2: whitePixel, withTolerance: 0.2) {
                cgContext?.addPath(bezierPath.cgPath)
                cgContext?.setFillColor(UIColor.blue.cgColor)
                cgContext?.fillPath()
            } else if isPixelEqualToPixel(pixel1: pixelTuple2, pixel2: whitePixel, withTolerance: 0.2) {
                cgContext?.addPath(bezierPath.cgPath)
                cgContext?.setFillColor(UIColor.red.cgColor)
                cgContext?.fillPath()
            } else {
                cgContext?.addPath(bezierPath.cgPath)
                cgContext?.setFillColor(UIColor.white.cgColor)
                cgContext?.fillPath()
            }
            cgContext?.restoreGState()

            byteIndex += 4
            row = Int(floor(Double(byteIndex / Int(size.width) / 4)))
        }

        let outputImage = cgContext!.makeImage()!
        return UIImage(cgImage: outputImage, scale: 1.0, orientation: .downMirrored)
    }

    func getRawDataForImage(image: UIImage) -> Array<CUnsignedChar> {
        let imageRef = image.cgImage!
        let width = imageRef.width
        let height = imageRef.height
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let rawData = calloc(height * width * 4, MemoryLayout<CUnsignedChar>.size)!
        let bytesPerPixel = 4
        let bitsPerComponent = imageRef.bitsPerComponent
        let bytesPerRow = bytesPerPixel * width

        let context = CGContext.init(data: rawData, width: width, height: height, bitsPerComponent: bitsPerComponent, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)!
        context.draw(imageRef, in: CGRect(x: 0, y: 0, width: width, height: height))

        let ptr = rawData.bindMemory(to: CUnsignedChar.self, capacity: Int(image.size.width * image.size.height * 4))
        let buffer = UnsafeBufferPointer(start: ptr, count: Int(image.size.width * image.size.height * 4))
        return Array(buffer)
    }

    func isPixelEqualToPixel(pixel1: Pixel, pixel2: Pixel, withTolerance tolerance: CGFloat) -> Bool {
        let deltaR = fabs(pixel1.r - pixel2.r)
        let deltaG = fabs(pixel1.g - pixel2.g)
        let deltaB = fabs(pixel1.b - pixel2.b)

        let deltaA = fabs(pixel1.a - pixel2.a)

        return deltaR <= tolerance &&
            deltaG <= tolerance &&
            deltaB <= tolerance &&
            deltaA <= tolerance

    }

    func averageColorForPixels(pixel1: Pixel, pixel2: Pixel) -> UIColor {
        return UIColor(red: CGFloat((pixel1.r + pixel2.r) / 2),
                                   green: CGFloat((pixel1.g + pixel2.g) / 2),
                                   blue: CGFloat((pixel1.b + pixel2.b) / 2),
                                   alpha: CGFloat((pixel1.a + pixel2.a) / 2))
    }

}
