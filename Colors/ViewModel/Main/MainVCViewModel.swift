//
//  MainVCViewModel.swift
//  Colors
//
//  Created by Sergey Prikhodko on 6/8/18.
//  Copyright © 2018 Sergey Prikhodko. All rights reserved.
//

import Foundation

class MainVCViewModel {
    //MARK: var
    weak var colorManager: ColorManager!
    private var cellsArray = [ColorTVCViewModel]()
    private var colorsArray: [Color]!
    //MARK: init
    required init(with colorManager: ColorManager) {
        self.colorManager = colorManager
    }
    //MARK: funcs
    func updateColors (completion: () -> Void) {
        cellsArray.removeAll()
        colorManager.getColors { [unowned self] (colors) in
            self.colorsArray = colors
            for color in colors {
                self.cellsArray.append(ColorTVCViewModel(with: color))
            }
            completion()
        }
    }
    
    func numberOfColors () -> Int {
        return cellsArray.count
    }
    
    func cellViewModel(index: Int) -> ColorTVCViewModel? {
        guard index < cellsArray.count else { return nil }
        return cellsArray[index]
    }
    
    func cellHeight(_ index: Int) -> Float {
        guard index < cellsArray.count else { return 44 }
        return cellsArray[index].heigth
    }
    
    func selectCell (_ index: Int, completeon: () -> Void) {
        guard index < cellsArray.count else { return }
        colorsArray[index].selected = !colorsArray[index].selected
        cellsArray[index] = ColorTVCViewModel(with: colorsArray[index])
        completeon()
    }
}
