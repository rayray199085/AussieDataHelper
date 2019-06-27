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
    private let viewModel = SCABNLookupViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(displayView)
        displayView.viewModel = viewModel
    }
}
