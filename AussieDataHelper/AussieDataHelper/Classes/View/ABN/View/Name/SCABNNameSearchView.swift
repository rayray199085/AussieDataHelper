//
//  SCABNNameSearchView.swift
//  AussieDataHelper
//
//  Created by Stephen Cao on 28/6/19.
//  Copyright © 2019 Stephencao Cao. All rights reserved.
//

import UIKit
import SVProgressHUD

private let reuseIdentifier = "name_search_cell"
class SCABNNameSearchView: UIView {
    var viewModel: SCABNLookupViewModel?
    
    @IBOutlet weak var messageTextView: SCTextView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var maxResultTextField: UITextField!
    @IBOutlet weak var nameSearchTextField: UITextField!
    @IBOutlet weak var lookupButton: UIButton!
    class func nameSearchView()->SCABNNameSearchView{
        let nib = UINib(nibName: "SCABNNameSearchView", bundle: nil)
        let v = nib.instantiate(withOwner: self, options: nil)[0] as! SCABNNameSearchView
        v.frame = UIScreen.main.bounds
        return v
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    @IBAction func clickLookupButton(_ sender: Any) {
        resignNameSearchViewFirstResponder()
        let maxResultCount = !maxResultTextField.hasText ? 10 : Int(maxResultTextField.text ?? "10") ?? 10
        if !nameSearchTextField.hasText{
            resetContent()
            viewModel?.resetPrevSearchRecord()
            messageTextView.text = "Search name cannot be empty."
            return
        }
        if nameSearchTextField.text == viewModel?.prevSearchName && maxResultCount == viewModel?.prevSearchNameMaxCount{
            return
        }
        SVProgressHUD.show()
        viewModel?.loadNameSearchResult(name: nameSearchTextField.text, maxResultCount: maxResultCount, completion: { [weak self](isSuccess) in
            self?.tableView.reloadData()
            self?.tableView.scroll(to: UITableView.scrollsTo.top, animated: true)
            self?.messageTextView.text = "Names returned : \(self?.viewModel?.nameSearchData?.Names?.count ?? 0)"
            SVProgressHUD.dismiss()
        })
        
    }
    func resignNameSearchViewFirstResponder(){
        nameSearchTextField.resignFirstResponder()
        maxResultTextField.resignFirstResponder()
    }
    
    func resetContent(){
        viewModel?.nameSearchData = nil
        maxResultTextField.text?.removeAll()
        tableView.reloadData()
    }
}
private extension SCABNNameSearchView{
    func setupUI(){
        layoutSubviews()
        lookupButton.layer.borderColor = UIColor.lightGray.cgColor
        nameSearchTextField.delegate = self
        nameSearchTextField.returnKeyType = .search
        
        maxResultTextField.keyboardType = .numberPad
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "SCNameSearchTableViewCell", bundle: nil), forCellReuseIdentifier: reuseIdentifier)
        tableView.separatorColor = UIColor.darkGray
        tableView.layer.borderColor = HelperCommon.frameColor
    }
}
extension SCABNNameSearchView: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        clickLookupButton(lookupButton as Any)
        nameSearchTextField.resignFirstResponder()
        return false
    }
}
extension SCABNNameSearchView: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let nameCount = viewModel?.nameSearchData?.Names?.count ?? 0
        tableView.separatorStyle = nameCount > 0 ? UITableViewCell.SeparatorStyle.singleLine : .none
        return nameCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SCNameSearchTableViewCell
        cell.nameItem = viewModel?.nameSearchData?.Names?[indexPath.row]
        cell.setTextViewScrollToTop()
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel?.nameSearchData?.Names?[indexPath.row].height ?? 166
    }
}

