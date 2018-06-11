//
//  ColorTVC.swift
//  Colors
//
//  Created by Sergey Prikhodko on 6/8/18.
//  Copyright © 2018 Sergey Prikhodko. All rights reserved.
//

import UIKit

class ColorTVC: UITableViewCell {
    //MARK: IBOutlet
    @IBOutlet weak var colorNameLabel: UILabel!
    //MARK: var
    weak var viewModel: ColorTVCViewModel! {
        didSet {
            colorNameLabel.text = viewModel.colorTitle
            colorNameLabel.textColor = UIColor(rgb: viewModel.textColorHex)
            backgroundColor = UIColor(rgb: viewModel.backgroundColorHex)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 8
        self.clipsToBounds = true
    }
}
