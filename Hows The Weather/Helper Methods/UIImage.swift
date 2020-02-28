//
//  UIImage.swift
//  Traveller
//
//  Created by Anthony on 30/10/19.
//  Copyright © 2019 EmeraldApps. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {

        /// puts image the right way up
        func fixOrientation() -> UIImage {

            if ( self.imageOrientation == UIImage.Orientation.up ) {
                return self;
            }

            /// We need to calculate the proper transformation to make the image upright.
            /// We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
            var transform: CGAffineTransform = CGAffineTransform.identity

            if ( self.imageOrientation == UIImage.Orientation.down || self.imageOrientation == UIImage.Orientation.downMirrored ) {
                transform = transform.translatedBy(x: self.size.width, y: self.size.height)
                transform = transform.rotated(by: CGFloat(Double.pi))
            }

            if ( self.imageOrientation == UIImage.Orientation.left || self.imageOrientation == UIImage.Orientation.leftMirrored ) {
                transform = transform.translatedBy(x: self.size.width, y: 0)
                transform = transform.rotated(by: CGFloat(Double.pi / 2.0))
            }

            if ( self.imageOrientation == UIImage.Orientation.right || self.imageOrientation == UIImage.Orientation.rightMirrored ) {
                transform = transform.translatedBy(x: 0, y: self.size.height);
                transform = transform.rotated(by: CGFloat(-Double.pi / 2.0));
            }

            if ( self.imageOrientation == UIImage.Orientation.upMirrored || self.imageOrientation == UIImage.Orientation.downMirrored ) {
                transform = transform.translatedBy(x: self.size.width, y: 0)
                transform = transform.scaledBy(x: -1, y: 1)
            }

            if ( self.imageOrientation == UIImage.Orientation.leftMirrored || self.imageOrientation == UIImage.Orientation.rightMirrored ) {
                transform = transform.translatedBy(x: self.size.height, y: 0);
                transform = transform.scaledBy(x: -1, y: 1);
            }

            // Now we draw the underlying CGImage into a new context, applying the transform
            // calculated above.
            let ctx: CGContext = CGContext(data: nil, width: Int(self.size.width), height: Int(self.size.height),
                                           bitsPerComponent: self.cgImage!.bitsPerComponent, bytesPerRow: 0,
                                           space: self.cgImage!.colorSpace!,
                                           bitmapInfo: self.cgImage!.bitmapInfo.rawValue)!;

            ctx.concatenate(transform)

            if ( self.imageOrientation == UIImage.Orientation.left ||
                self.imageOrientation == UIImage.Orientation.leftMirrored ||
                self.imageOrientation == UIImage.Orientation.right ||
                self.imageOrientation == UIImage.Orientation.rightMirrored ) {
                ctx.draw(self.cgImage!, in: CGRect(x: 0,y: 0,width: self.size.height,height: self.size.width))
            } else {
                ctx.draw(self.cgImage!, in: CGRect(x: 0,y: 0,width: self.size.width,height: self.size.height))
            }

            // And now we just create a new UIImage from the drawing context and return it
            return UIImage(cgImage: ctx.makeImage()!)
        }
    
        func rotate(radians: Float) -> UIImage? {
            var newSize = CGRect(origin: CGPoint.zero, size: self.size).applying(CGAffineTransform(rotationAngle: CGFloat(radians))).size
            // Trim off the extremely small float value to prevent core graphics from rounding it up
            newSize.width = floor(newSize.width)
            newSize.height = floor(newSize.height)

            UIGraphicsBeginImageContextWithOptions(newSize, false, self.scale)
            let context = UIGraphicsGetCurrentContext()!

            // Move origin to middle
            context.translateBy(x: newSize.width/2, y: newSize.height/2)
            // Rotate around middle
            context.rotate(by: CGFloat(radians))
            // Draw the image at its center
            self.draw(in: CGRect(x: -self.size.width/2, y: -self.size.height/2, width: self.size.width, height: self.size.height))

            let newImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()

            return newImage
        }


        func resized(to size: CGSize) -> UIImage {
            return UIGraphicsImageRenderer(size: size).image { _ in
                draw(in: CGRect(origin: .zero, size: size))
            }
        }


    

}
