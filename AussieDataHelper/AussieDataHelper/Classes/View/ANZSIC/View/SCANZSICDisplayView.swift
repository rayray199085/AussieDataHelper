//
//  SCANZSICDisplayView.swift
//  AussieDataHelper
//
//  Created by Stephen Cao on 28/6/19.
//  Copyright © 2019 Stephencao Cao. All rights reserved.
//

import UIKit

private let reuseIdentifier = "anzsic_code_cell"
protocol SCANZSICDisplayViewDelegate: NSObjectProtocol{
    func didClickKeyboardSearchKey(view: SCANZSICDisplayView)
}
class SCANZSICDisplayView: UIView {
    var viewModel: SCANZSICViewModel?
    weak var delegate: SCANZSICDisplayViewDelegate?
    
    class func displayView()->SCANZSICDisplayView{
        let nib = UINib(nibName: "SCANZSICDisplayView", bundle: nil)
        let v = nib.instantiate(withOwner: self, options: nil)[0] as! SCANZSICDisplayView
        v.frame = UIScreen.main.bounds
        return v
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    
    @IBAction func clickClearTextFieldButton(_ sender: Any) {
        textField.text?.removeAll()
        textField.resignFirstResponder()
    }
}

private extension SCANZSICDisplayView{
    func setupUI(){
        textField.delegate = self
        textField.returnKeyType = .search
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "SCANZSICTableViewCell", bundle: nil), forCellReuseIdentifier: reuseIdentifier)
    }
}
extension SCANZSICDisplayView: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        delegate?.didClickKeyboardSearchKey(view: self)
        return false
    }
}
extension SCANZSICDisplayView: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.separatorStyle = (viewModel?.anzsicCodeArray?.count ?? 0) > 0 ? UITableViewCell.SeparatorStyle.singleLine : .none
        return viewModel?.anzsicCodeArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SCANZSICTableViewCell
        cell.anzsicCode = viewModel?.anzsicCodeArray?[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel?.anzsicCodeArray?[indexPath.row].height ?? 105
    }
}
