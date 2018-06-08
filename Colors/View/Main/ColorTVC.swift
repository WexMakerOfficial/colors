//
//  ColorTVC.swift
//  Colors
//
//  Created by Sergey Prikhodko on 6/8/18.
//  Copyright © 2018 Sergey Prikhodko. All rights reserved.
//

import UIKit

class ColorTVC: UITableViewCell {

    @IBOutlet weak var colorNameLabel: UILabel!
    weak var viewModel: ColorTVCViewModel! {
        didSet {
            colorNameLabel.text = viewModel.colorTitle
            colorNameLabel.tintColor = UIColor(rgb: viewModel.textColorHex)
            heightAnchor.constraint(equalToConstant: CGFloat(viewModel.heigth))
            backgroundColor = UIColor(rgb: viewModel.backgroundColorHex)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
