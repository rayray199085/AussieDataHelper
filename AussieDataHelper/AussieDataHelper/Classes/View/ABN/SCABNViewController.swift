//
//  SCABNViewController.swift
//  AussieDataHelper
//
//  Created by Stephen Cao on 26/6/19.
//  Copyright © 2019 Stephencao Cao. All rights reserved.
//

import UIKit

class SCABNViewController: UIViewController {
    private let displayView = SCABNDisplayView.displayView()
    private let nameSearchView = SCABNNameSearchView.nameSearchView()
    
    private let viewModel = SCABNLookupViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    @objc private func clickNameSearch(){
        displayView.abnTextField.resignFirstResponder()
        let from = nameSearchView.frame.origin.x == -UIScreen.screenWidth() ? -UIScreen.screenWidth() / 2 : UIScreen.screenWidth() / 2
        let to = nameSearchView.frame.origin.x == -UIScreen.screenWidth() ? UIScreen.screenWidth() / 2 : -UIScreen.screenWidth() / 2
        nameSearchView.resignNameSearchViewFirstResponder()
        navigationItem.leftBarButtonItem?.isEnabled = false
        nameSearchView.addPopHorizontalAnimation(fromValue: from, toValue: to, springBounciness: 8, springSpeed: 8, delay: 0) { [weak self](_, _) in
            self?.navigationItem.leftBarButtonItem?.isEnabled = true
        }
    }
}
extension SCABNViewController: SCABNDisplayViewDelegate{
    func didClickSegmentControl(view: SCABNDisplayView, index: Int) {
        navigationItem.title = index == 0 ? "ABN" : "ACN"
    }
}
private extension SCABNViewController{
    func setupUI(){
        view.addSubview(displayView)
        displayView.viewModel = viewModel
        displayView.delegate = self
        
        
        nameSearchView.frame.origin.x = -UIScreen.screenWidth()
        view.addSubview(nameSearchView)
        nameSearchView.viewModel = viewModel
        
        setupNavigationBarButton()
    }
    func setupNavigationBarButton(){
        let btn = UIButton.imageButton(withNormalImageName: "magnifier_normal", andWithHighlightedImageName: "magnifier_highlighted")
        btn.setTitle("Name", for: [])
        btn.setTitleColor(UIColor.darkGray, for: [])
        btn.setTitleColor(HelperCommon.govGreenColor, for: .highlighted)
        btn.addTarget(self, action: #selector(clickNameSearch), for: UIControl.Event.touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btn)
    }
}
