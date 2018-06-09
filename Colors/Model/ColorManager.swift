//
//  ColorManager.swift
//  Colors
//
//  Created by Sergey Prikhodko on 6/8/18.
//  Copyright © 2018 Sergey Prikhodko. All rights reserved.
//

import Foundation

class ColorManager {
    
    func getColors (completion: ([Color]) -> Void) {
        completion(loadFormXML())
    }
    
    //MARK: private
    
    private func loadFormXML () -> [Color] {
        var colors = [Color]()
        for _ in 0..<5 {
            colors.append(Color(with: "hz"))
        }
        return colors
    }
}
