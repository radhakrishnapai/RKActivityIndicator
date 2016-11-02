//
//  RKActivityIndicator.swift
//  Pods
//
//  Created by Radhakrishna Pai on 10/05/2016.
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

import UIKit
import Foundation

/**
 enum that is used to define the type of loading indicator.
 */
public enum RKActivityIndicatorType {
    case definite
    case indefinite
}

public class RKActivityIndicator: UIView {

    /**
     Used to display the loading indicator image.
     */
    var imageView: UIImageView? = nil

    /**
     The array of images that are used for animation. Use more images for smooth animation.
     */
    var images: [UIImage]? = nil

    /**
     The index of the current image shown.
     */
    var currentImageIndex = 0

    /**
     Animation duration for the indicator. Use smaller values for faster animation.
     */
    public var animationDuration: TimeInterval = 0 {
        didSet {
            precondition(self.type == RKActivityIndicatorType.indefinite,
                         "Cannot use this with indefinite type."
                + "Use RKActivityIndicatorType.definite instead!")
        }
    }

    /**
     The type of the indicator. It can be definite or indefinite.
    */
    var type: RKActivityIndicatorType

    /**
     The current progress percentage for definite loading indicator type.
     */
    var progressPercentage: Double = 0

    /**
     The delegate for the `RKIndefiniteIndicatorDelegate` protocol.
    */
    weak var indefinteIndicatorDelegate: RKIndefiniteIndicatorDelegate?


    /**
     The delegate for the `RKDefiniteIndicatorDelegate` protocol.
    */
    weak var definiteIndicatorDelegate: RKDefiniteIndicatorDelegate?

    /**
     Designated initialiser for the RKActivityIndicator class.
     - Parameter type: The indicator type. It expects a value from the
     enum `RKActivityIndicatorType`.
     - Parameter theme: Any object that conforms to the protocol `RKActivityIndicatorThemeProtocol`.
    */
    public init<T: RKActivityIndicatorThemeProtocol>(type: RKActivityIndicatorType, theme: T) {
        self.type = type
        self.images = theme.imageSet
        super.init(frame: CGRect.zero)

        switch self.type {
        case RKActivityIndicatorType.definite:
            definiteIndicatorDelegate = self
            break
        case RKActivityIndicatorType.indefinite:
            indefinteIndicatorDelegate = self
            break
        }
    }

    /**
     Designated initialiser for the RKActivityIndicator class.
     - Parameter type: The indicator type. It expects a value from
     the enum `RKActivityIndicatorType`.
     */
    public init(type: RKActivityIndicatorType) {
        assertionFailure("Parameter theme: is required. You can create your own theme that conforms"
        + " to the protocol `RKActivityIndicatorThemeProtocol`. Alternatively you can download"
        + " the default theme at our site <URL>")
        self.type = type
        super.init(frame: CGRect.zero)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /**
    Function to initialise and position the imageView.
    The image view is sized according to the `size` parameter value and positioned at center
    of its parent view.
    - Parameter size: The size of the image view.
    */
    func initialiseImageViewWithSize(size: CGSize) {
        imageView = UIImageView()
        self.addSubview(imageView!)
        imageView?.center = self.center
        imageView?.translatesAutoresizingMaskIntoConstraints = false
        let widthConstraint = NSLayoutConstraint(item: imageView!,
                                                 attribute: NSLayoutAttribute.width,
                                                 relatedBy: NSLayoutRelation.equal,
                                                 toItem: nil,
                                                 attribute: NSLayoutAttribute.notAnAttribute,
                                                 multiplier: 1.0,
                                                 constant: size.width)
        widthConstraint.priority = 800
        let heightConstraint = NSLayoutConstraint(item: imageView!,
                                                  attribute: NSLayoutAttribute.height,
                                                  relatedBy: NSLayoutRelation.equal,
                                                  toItem: nil,
                                                  attribute: NSLayoutAttribute.notAnAttribute,
                                                  multiplier: 1.0,
                                                  constant: size.height)
        let horizontalConstraint = NSLayoutConstraint(item: imageView!,
                                                      attribute: NSLayoutAttribute.centerX,
                                                      relatedBy: NSLayoutRelation.equal,
                                                      toItem: self,
                                                      attribute: NSLayoutAttribute.centerX,
                                                      multiplier: 1.0, constant: 0)
        let verticalConstraint = NSLayoutConstraint(item: imageView!,
                                                    attribute: NSLayoutAttribute.centerY,
                                                    relatedBy: NSLayoutRelation.equal,
                                                    toItem: self,
                                                    attribute: NSLayoutAttribute.centerY,
                                                    multiplier: 1.0,
                                                    constant: 0)
        self.addConstraints([horizontalConstraint,
                             verticalConstraint,
                             widthConstraint,
                             heightConstraint])
    }

    /**
     Function to add constraints to loading indicator.
     The image view is sized according to the `size` parameter value
     and positioned at center of its parent view.
     - Parameter view: The instance of parent view.
     */
    func positionLoadingIndicatorWithParentView(view: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        let loadingIndicatorView = self
        let views = ["loadingIndicatorView":loadingIndicatorView]
        let horizontalConstraints = NSLayoutConstraint.constraints(
                                        withVisualFormat: "|[loadingIndicatorView]|",
                                        options:NSLayoutFormatOptions.directionLeadingToTrailing,
                                        metrics: nil,
                                        views: views)
        let verticalConstraints = NSLayoutConstraint.constraints(
                                        withVisualFormat: "V:|[loadingIndicatorView]|",
                                        options:NSLayoutFormatOptions.directionLeadingToTrailing,
                                        metrics: nil,
                                        views: views)
        view.addConstraints(horizontalConstraints)
        view.addConstraints(verticalConstraints)
    }

    // MARK: Stop Loading Indicator Animation

    /**
     Function to stop the loading indicator animation.
     - Parameter view: The view in which the indicator must be stopped.
     */
    public func stopAnimatingInView(view: UIView) {
        currentImageIndex = 0
        imageView?.removeFromSuperview()
        imageView = nil
        self.removeFromSuperview()
        view.isUserInteractionEnabled = true
    }
}

// MARK: RKDefiniteIndicatorDelegate

extension RKActivityIndicator: RKDefiniteIndicatorDelegate {
    /**
     Function to show progress indicator.
     - Parameter progress: The progress in percentage.
     - Parameter view: The view in which the indicator must be shown.
     */
    public func showProgress(progress: Double, view: UIView) {
        precondition(self.type == RKActivityIndicatorType.definite,
        "Cannot use this with indefinite type. Use RKActivityIndicatorType.definite instead!")

        self.progressPercentage = progress

        if let images = self.images {
            if images.count > 0 {
                if self.imageView == nil {
                    self.initialiseImageViewWithSize(size: images[0].size)
                    view.addSubview(self)
                    self.positionLoadingIndicatorWithParentView(view: view)
                    view.isUserInteractionEnabled = false
                }

                if self.imageView!.layer.animationKeys() == nil {
                    var index = self.currentImageIndex

                    // Calculate current index based on progress percentage and image count
                    self.currentImageIndex = Int((progress * Double(images.count-1)) / 100.0)

                    // Check to see if the index is valid
                    if self.currentImageIndex < images.count {

                        // Animate all the images during progress
                        var imagesArray = [UIImage]()
                        while index <= self.currentImageIndex {
                            imagesArray.append((self.images?[index])!)
                            index += 1
                        }
                        self.imageView?.image = self.images?[self.currentImageIndex]
                        self.imageView?.animationImages = imagesArray
                        self.imageView?.animationRepeatCount = 1
                        self.imageView?.startAnimating(completionBlock: { (status) in
                            if self.progressPercentage > progress {
                                self.showProgress(progress: self.progressPercentage, view: view)
                            }
                        })
                    }
                }
            }
        }
    }
}

// MARK: RKIndefiniteIndicatorDelegate

extension RKActivityIndicator: RKIndefiniteIndicatorDelegate {
    /**
     Function to start indefinite loading indicator animation.
     - Parameter view: The view in which the indicator must be shown.
     */
    public func startAnimatingInView(view: UIView) {
        precondition(self.type == RKActivityIndicatorType.indefinite,
        "Cannot use this with indefinite type. Use RKActivityIndicatorType.definite instead!")

        view.addSubview(self)
        self.positionLoadingIndicatorWithParentView(view: view)

        if let images = images {
            if images.count > 0 {
                self.initialiseImageViewWithSize(size: images[0].size)

                imageView?.animationImages = images
                imageView?.animationDuration = animationDuration
                imageView?.startAnimating()
            }
        }

        view.isUserInteractionEnabled = false
    }
}
