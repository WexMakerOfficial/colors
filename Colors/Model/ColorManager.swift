//
//  ColorManager.swift
//  Colors
//
//  Created by Sergey Prikhodko on 6/8/18.
//  Copyright © 2018 Sergey Prikhodko. All rights reserved.
//

import Foundation
import SWXMLHash

class ColorManager {
    //MARK: public func
    func getColors (completion: ([Color]) -> Void) {
        if let file = Bundle.main.path(forResource: "colors", ofType: "xml"), let xmlData = try? Data(contentsOf: URL(fileURLWithPath: file)) {
            completion(loadFormXML(xmlData))
        }
    }
    //MARK: private func
    private func loadFormXML (_ xmlData: Data) -> [Color] {
        let xml = SWXMLHash.config { (config) in
            config.shouldProcessLazily = false
        }.parse(xmlData)
        var colors = [Color]()
        for xmlColor in xml["colors"]["color"].all {
            let color = Color()
            if let name = xmlColor.element?.attribute(by: "name") {
                color.title = name.text
            }
            if let colorValue = xmlColor.element?.attribute(by: "color") {
                color.colorString = colorValue.text
            }
            colors.append(color)
        }
        return colors
    }
}
