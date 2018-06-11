//
//  ColorTVCViewModel.swift
//  Colors
//
//  Created by Sergey Prikhodko on 6/8/18.
//  Copyright © 2018 Sergey Prikhodko. All rights reserved.
//

import Foundation

class ColorTVCViewModel {
    //MARK: var
    var colorTitle: String
    var heigth: Float = 40
    var backgroundColorHex: Int = 0xFF737373
    var textColorHex: Int = 0xFF737373
    //MARL: init
    init(with color: Color) {
        self.colorTitle = color.title
        if color.selected {
            self.backgroundColorHex = Int(stringToHex(color.colorString))
            self.heigth = 160
        } else {
            self.textColorHex = Int(stringToHex(color.colorString))
        }
    }
    //MARK: private funcs
    private func stringToHex (_ source: String) -> UInt32 {
        var cString:String = source.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        if (cString.count != 8) {
            return 0
        }
        var rgbValue: UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        return rgbValue
    }
}
