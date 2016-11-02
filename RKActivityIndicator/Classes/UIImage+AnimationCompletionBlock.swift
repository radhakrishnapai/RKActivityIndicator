//
//  UIImage+AnimationCompletionBlock.swift
//  Pods
//
//  Created by Radhakrishna Pai on 14/10/16.
//  Copyright (c) 2016 Radhakrishna Pai <radhakrishnapai09@gmail.com>
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.


import Foundation

typealias CompletionBlock = (_ success: Bool) -> Void

extension UIImageView:CAAnimationDelegate {

    @nonobjc static var blockKey = "BLOCK_KEY"

    /**
     The closure which must be called after animation stops.
    */
    var completionBlock: CompletionBlock {
        get {
            let obj = objc_getAssociatedObject(self, &UIImageView.blockKey )
            if let object = obj as? CompletionBlock {
                return object
            } else {
                return { status in }
            }
        }

        set {
                objc_setAssociatedObject(self, &UIImageView.blockKey, newValue as Any,
                                         .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    /**
     Function to start UIImageView animation.
     - Parameter completionBlock: A closure of type `CompletionBlock`.
    */
    func startAnimating(completionBlock:@escaping CompletionBlock) {
        self.startAnimating(cgImages: getCGImagesArray(imagesArray: self.animationImages!),
                            completionBlock: completionBlock)
    }

    /**
     Function to start UIImageView animation.
     - Parameter cgImages: An array of `CGImage` objects.
     - Parameter completionBlock: A closure of type `CompletionBlock`.
     */
    private func startAnimating(cgImages: [CGImage], completionBlock: @escaping CompletionBlock) {
        self.completionBlock = completionBlock

        let animation = CAKeyframeAnimation()
        animation.keyPath = "contents"
        animation.values = cgImages
        animation.repeatCount = Float(self.animationRepeatCount)
        animation.duration = self.animationDuration
        animation.delegate = self

        let imageLayer = self.layer
        imageLayer.add(animation, forKey: "contents")
    }

    /**
     Function that generates an array of `CGImage` objects.
     - Parameter imagesArray: An array of `UIImage` objects.
     - Returns: An array of `CGImage` objects.
    */
    private func getCGImagesArray(imagesArray: [UIImage]) -> [CGImage] {
        var cgImages: [CGImage] = []
        autoreleasepool {
            for image in imagesArray {
                cgImages.append(image.cgImage!)
            }
        }
        return cgImages
    }

    /**
     Delegate function of the protocol `CAAnimationDelegate`.
     Function callback when a `CAAnimation` stops.
    */
    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        completionBlock(flag)
    }
}
