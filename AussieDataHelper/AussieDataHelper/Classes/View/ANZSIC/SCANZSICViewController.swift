//
//  SCANZSICViewController.swift
//  AussieDataHelper
//
//  Created by Stephen Cao on 26/6/19.
//  Copyright © 2019 Stephencao Cao. All rights reserved.
//

import UIKit
import SVProgressHUD

class SCANZSICViewController: UIViewController {
    private let displayView = SCANZSICDisplayView.displayView()
    private let viewModel = SCANZSICViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        displayView.viewModel = viewModel
    }
    @objc private func clickSearchButton(){
        displayView.textField.resignFirstResponder()
        if displayView.textField.text == ""{
            viewModel.anzsicCodeArray = nil
            displayView.tableView.reloadData()
            viewModel.prevKeywords?.removeAll()
            SVProgressHUD.showInfo(withStatus: "Keywords cannot be empty.")
            return
        }
        if displayView.textField.text == viewModel.prevKeywords{
            return
        }
        SVProgressHUD.show()
        viewModel.loadANZSICSearchResult(keywords: displayView.textField.text) { [weak self](isSuccess) in
            self?.displayView.tableView.reloadData()
            self?.displayView.tableView.scroll(to: UITableView.scrollsTo.top, animated: true)
            SVProgressHUD.dismiss()
        }
    }
}
private extension SCANZSICViewController{
    func setupUI(){
        view.addSubview(displayView)
        displayView.delegate = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.search, target: self, action: #selector(clickSearchButton))
        navigationController?.navigationBar.tintColor = HelperCommon.govGreenColor
    }
}
extension SCANZSICViewController: SCANZSICDisplayViewDelegate{
    func didClickKeyboardSearchKey(view: SCANZSICDisplayView) {
        clickSearchButton()
    }
}
