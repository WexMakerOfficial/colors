//
//  MainVC.swift
//  Colors
//
//  Created by Sergey Prikhodko on 07.06.2018.
//  Copyright © 2018 Sergey Prikhodko. All rights reserved.
//

import UIKit

class MainVC: UIViewController {

    weak var viewModel: MainVCViewModel! {
        didSet {
            viewModel.updateColors {
                
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}

extension MainVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfColors()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
