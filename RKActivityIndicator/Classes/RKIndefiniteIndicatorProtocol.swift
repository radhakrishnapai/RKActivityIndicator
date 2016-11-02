//
//  RKIndefiniteIndicatorProtocol.swift
//  Pods
//
//  Created by Radhakrishna Pai on 12/10/16.
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

protocol RKIndefiniteIndicatorDelegate: class {

    /**
     Animation duration for the indicator. Use smaller values for faster animation.
     */
    var animationDuration: TimeInterval { get set }

    /**
     Function to start indefinite loading indicator animation.
     - Parameter view: The view in which the indicator must be shown.
     */
    func startAnimatingInView(view: UIView)

    /**
     Function to stop the loading indicator animation.
     - Parameter view: The view in which the indicator must be stopped.
     */
    func stopAnimatingInView(view: UIView)
}
