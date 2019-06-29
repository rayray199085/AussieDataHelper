//
//  SCDefinitionsViewController.swift
//  AussieDataHelper
//
//  Created by Stephen Cao on 26/6/19.
//  Copyright © 2019 Stephencao Cao. All rights reserved.
//

import UIKit
import SVProgressHUD
class SCDefinitionsViewController: UIViewController {
    private let displayView = SCDefinitionDisplayView.displayView()
    private let viewModel = SCDefinitionsViewModel()
    private let definitionsMaskView = SCDefinitionsMaskView.maskView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        displayView.viewModel = viewModel
    }
    @objc private func clickSearchButton(){
        displayView.textField.resignFirstResponder()
        if !displayView.shouldPullUp{
            if displayView.textField.text == ""{
                resetDisplayContent()
                SVProgressHUD.showInfo(withStatus: "Keywords cannot be empty.")
                return
            }
            if displayView.textField.text == viewModel.prevKeywords{
                return
            }
            else{
                // prepare a new search
                resetDisplayContent()
            }
        }
        SVProgressHUD.show()
        viewModel.loadDefinitionsData(shouldPullUp: displayView.shouldPullUp,keywords: displayView.textField.text, currentPage: displayView.currentPage) { [weak self](isSuccess) in
            self?.displayView.tableView.reloadData()
            if self?.displayView.shouldPullUp == false{
             self?.displayView.tableView.scroll(to: UITableView.scrollsTo.top, animated: true)
            }else{
                self?.displayView.shouldPullUp = false
            }
            SVProgressHUD.dismiss()
        }
    }
    func resetDisplayContent(){
        displayView.currentPage = 1
        viewModel.definitionsData = nil
        displayView.tableView.reloadData()
        viewModel.prevKeywords?.removeAll()
    }
}
private extension SCDefinitionsViewController{
    func setupUI(){
        view.addSubview(displayView)
        displayView.delegate = self
        
        tabBarController?.view.addSubview(definitionsMaskView)
        definitionsMaskView.isHidden = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.search, target: self, action: #selector(clickSearchButton))
        navigationController?.navigationBar.tintColor = HelperCommon.govGreenColor
    }
}
extension SCDefinitionsViewController: SCDefinitionDisplayViewDelegate{
    func didSelectedCell(view: SCDefinitionDisplayView, definitionText: String?) {
        definitionsMaskView.textView.text = definitionText
        definitionsMaskView.textView.scrollRangeToVisible(NSMakeRange(0, 0))
        definitionsMaskView.isHidden = false
    }
    
    func didScrollToBottom(view: SCDefinitionDisplayView) {
        if displayView.currentPage > viewModel.definitionsData?.totalPages ?? 0{
            SVProgressHUD.showInfo(withStatus: "This is the last page.")
            displayView.shouldPullUp = false
            return
        }
        clickSearchButton()
    }
    
    func didClickKeyboardSearchKey(view: SCDefinitionDisplayView) {
        clickSearchButton()
    }
}
