//
//  TapRecogonizer.swift
//  SkiMountainFinder
//
//  Created by Peyton McKee on 2/6/22.
//

import Foundation
import UIKit

enum typeGesture: String {
    case mountain = "mountain"
    case weather = "weather"
}

class CustomTap: UITapGestureRecognizer{
    var customTag: String?
    var link: URL?
    var title: String?
}
