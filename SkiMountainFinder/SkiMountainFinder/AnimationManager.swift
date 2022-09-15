//
//  ImageRotationManager.swift
//  SkiMountainFinder
//
//  Created by Peyton McKee on 1/12/22.
//

import Foundation
import UIKit

var images = animatedImages(for: "SkiImages")
var index = 0

func animateImageView(imageView : UIImageView) {
            CATransaction.begin()
            CATransaction.setAnimationDuration(4)
            CATransaction.setCompletionBlock {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                    animateImageView(imageView: imageView)
                        })
                }
            let transition = CATransition()
                               transition.type = CATransitionType.fade
            /*
            transition.type = kCATransitionPush
            transition.subtype = kCATransitionFromRight
            */
            imageView.layer.add(transition, forKey: kCATransition)
            imageView.image = images[index]

            CATransaction.commit()

            index = index < images.count - 1 ? index + 1 : 0
    }

func animatedImages(for name: String) -> [UIImage] {
    var i = 0
    var images = [UIImage]()
    while let image = UIImage(named: "\(name)/\(i)") {
        images.append(image)
        i += 1
    }
    return images
}
