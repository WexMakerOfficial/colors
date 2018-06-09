//
//  Color.swift
//  Colors
//
//  Created by Sergey Prikhodko on 6/8/18.
//  Copyright © 2018 Sergey Prikhodko. All rights reserved.
//

import Foundation

class Color {
    var title: String!
    var colorString: String!
    var selected: Bool!
    
    required init(with title: String) {
        self.title = title
        self.selected = false
        self.colorString = "#FFC36EE1"
    }
}
