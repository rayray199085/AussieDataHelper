//
//  SCDefinitionDisplayView.swift
//  AussieDataHelper
//
//  Created by Stephen Cao on 29/6/19.
//  Copyright © 2019 Stephencao Cao. All rights reserved.
//

import UIKit
protocol SCDefinitionDisplayViewDelegate: NSObjectProtocol {
    func didClickKeyboardSearchKey(view: SCDefinitionDisplayView)
    func didScrollToBottom(view: SCDefinitionDisplayView)
    func didSelectedCell(view: SCDefinitionDisplayView, definitionText: String?)
}
private let reuseIdentifier = "definitions_cell"
class SCDefinitionDisplayView: UIView {
    weak var delegate: SCDefinitionDisplayViewDelegate?
    var viewModel: SCDefinitionsViewModel?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    var currentPage = 1
    
    var shouldPullUp: Bool = false
    
    class func displayView()->SCDefinitionDisplayView{
        let nib = UINib(nibName: "SCDefinitionDisplayView", bundle: nil)
        let v = nib.instantiate(withOwner: self, options: nil)[0] as! SCDefinitionDisplayView
        v.frame = UIScreen.main.bounds
        return v
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        textField.delegate = self
        textField.returnKeyType = .search
        
        tableView.estimatedRowHeight = 140
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "SCDefinitionsTableViewCell", bundle: nil), forCellReuseIdentifier: reuseIdentifier)
    }
    
    @IBAction func clickClearTextFieldButton(_ sender: Any) {
        textField.text?.removeAll()
        textField.resignFirstResponder()
    }
    
}
extension SCDefinitionDisplayView: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        delegate?.didClickKeyboardSearchKey(view: self)
        return false
    }
}
extension SCDefinitionDisplayView: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.separatorStyle = (viewModel?.definitionsData?.content?.count ?? 0) > 0 ? UITableViewCell.SeparatorStyle.singleLine : .none
        return viewModel?.definitionsData?.content?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SCDefinitionsTableViewCell
        cell.cententItem = viewModel?.definitionsData?.content?[indexPath.row].content
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let row = indexPath.row
        // let currentSection == indexPath.section
        let section = tableView.numberOfSections - 1
        if row < 0 || section < 0{
            return
        }
        let rowCount = tableView.numberOfRows(inSection: section)
        // && currentSection == section
        if row == (rowCount - 1) && !shouldPullUp{
            shouldPullUp = true
            currentPage += 1
            delegate?.didScrollToBottom(view: self)
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectedCell(view: self, definitionText: viewModel?.definitionsData?.content?[indexPath.row].content?.definition)
    }
}
