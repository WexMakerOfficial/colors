//
//  Extensions.swift
//  Colors
//
//  Created by Sergey Prikhodko on 6/8/18.
//  Copyright © 2018 Sergey Prikhodko. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    convenience init?(red: Int, green: Int, blue: Int, alpha: Int) {
        guard red >= 0 && red <= 255 else {return nil}
        guard green >= 0 && green <= 255 else {return nil}
        guard blue >= 0 && blue <= 255 else {return nil}
        guard alpha >= 0 && alpha <= 255 else {return nil}
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: (CGFloat(alpha) / 255) * 100)
    }
    
    convenience init?(rgb: Int) {
        self.init(red:      (rgb >> 16) & 0xFF,
                  green:    (rgb >> 8) & 0xFF,
                  blue:     rgb & 0xFF,
                  alpha:    (rgb >> 24) & 0xFF
        )
    }
}
