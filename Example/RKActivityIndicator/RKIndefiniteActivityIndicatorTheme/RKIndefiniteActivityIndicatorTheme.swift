//
//  RKIndefiniteActivityIndicatorTheme.swift
//  Pods
//
//  Created by Radhakrishna Pai on 10/10/16.
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
import RKActivityIndicator

open class RKIndefiniteActivityIndicatorTheme: RKActivityIndicatorThemeProtocol {

    /**
     Array of `UIImage` objects which are used for the loading indicator animation.
     */
    public var imageSet: [UIImage] = [UIImage]()

    /**
     Initialiser for the loading indicator
     */
    public required init() {

        for var i in 0...200 {
            if let filepath = Bundle.main.path(forResource: "loader" + "\(i)",
                                                ofType:"png") {
                if let image = UIImage(contentsOfFile: filepath) {
                    imageSet.append(image)
                }
            }
            i += 1
        }
    }
}