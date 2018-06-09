//
//  MainVC.swift
//  Colors
//
//  Created by Sergey Prikhodko on 07.06.2018.
//  Copyright © 2018 Sergey Prikhodko. All rights reserved.
//

import UIKit

class MainVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let xibName = "ColorTVC"
    let reuseIdentifier = "colorCell"
    
    weak var viewModel: MainVCViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: xibName, bundle: nil), forCellReuseIdentifier: reuseIdentifier)
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }


    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.updateColors {
            tableView.reloadData()
            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }
    
}

extension MainVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfColors()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(viewModel.cellHeight(indexPath.section))
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as? ColorTVC
        if cell == nil {
            cell = UINib(nibName: xibName, bundle: nil).instantiate(withOwner: nil, options: nil).first as? ColorTVC
        }
        cell?.viewModel = viewModel.cellViewModel(index: indexPath.section)
        return cell!
    }
    
    // Set the spacing between sections
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    // Make the background color show through
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectCell(indexPath.section) {
            [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.tableView.reloadSections([indexPath.section], with: .automatic)
        }
    }
}
