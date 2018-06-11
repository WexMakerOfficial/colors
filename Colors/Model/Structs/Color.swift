//
//  Color.swift
//  Colors
//
//  Created by Sergey Prikhodko on 6/8/18.
//  Copyright © 2018 Sergey Prikhodko. All rights reserved.
//

import Foundation

class Color {
    //MARK: var
    var title: String
    var colorString: String
    var selected: Bool
    //MARK: init
    init(_ title: String, selected: Bool, colorString: String) {
        self.title = title
        self.selected = selected
        self.colorString = colorString
    }
    
    convenience init(_ title: String) {
        self.init(title, selected: false, colorString: "#FFC36EE1")
    }
    
     convenience init() {
        self.init("defaulte", selected: false, colorString: "#FFC36EE1")
    }
}
