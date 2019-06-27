//
//  SCABNDisplayView.swift
//  AussieDataHelper
//
//  Created by Stephen Cao on 26/6/19.
//  Copyright © 2019 Stephencao Cao. All rights reserved.
//

import UIKit
import SVProgressHUD

class SCABNDisplayView: UIView {
    var viewModel: SCABNLookupViewModel?
        
    @IBOutlet weak var abnTextField: UITextField!
    
    @IBOutlet weak var entityName: SCTextView!
    @IBOutlet weak var abnStatus: SCTextView!
    @IBOutlet weak var entityType: SCTextView!
    
    @IBOutlet weak var entityTypeCode: SCTextView!
    @IBOutlet weak var gst: SCTextView!
  
    @IBOutlet weak var postCode: SCTextView!
    @IBOutlet weak var stateCode: SCTextView!
    @IBOutlet weak var addressDate: SCTextView!
    @IBOutlet weak var firstBusinessName: SCTextView!
    @IBOutlet weak var businessNames: SCTextView!
    
    @IBOutlet weak var abnLabel: UILabel!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBAction func segmentControlValueChange(_ sender: Any) {
        abnLabel.text = segmentControl.selectedSegmentIndex == 0 ? "ABN:" : "ACN:"
    }
    @IBOutlet weak var lookupButton: UIButton!
    
    class func displayView()->SCABNDisplayView{
        let nib = UINib(nibName: "SCABNDisplayView", bundle: nil)
        let v = nib.instantiate(withOwner: self, options: nil)[0] as! SCABNDisplayView
        v.frame = UIScreen.main.bounds
        return v
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        abnTextField.returnKeyType = .search
        abnTextField.delegate = self
    }
    
    @IBAction func clickLookupButton(_ sender: Any) {
        abnTextField.resignFirstResponder()
        if !abnTextField.hasText{
            return
        }
        let type: SCLookupType = segmentControl.selectedSegmentIndex == 0 ? .ABN : .ACN
        guard let code = abnTextField.text else{
            return
        }
       
        SVProgressHUD.show()
        viewModel?.loadABNData(type: type, code: code, completion: { [weak self](isSuccess) in
            self?.setupContent()
            SVProgressHUD.dismiss()
        })
    }
    
}
private extension SCABNDisplayView{
    func setupUI(){
        lookupButton.layer.borderColor = UIColor.lightGray.cgColor
    }
    func setupContent(){
        entityName.text = viewModel?.lookupData?.EntityName
        abnStatus.text = viewModel?.lookupData?.AbnStatus
        entityType.text = viewModel?.lookupData?.EntityTypeName
        entityTypeCode.text = viewModel?.lookupData?.EntityTypeCode
        gst.text = viewModel?.lookupData?.Gst
        stateCode.text = viewModel?.lookupData?.AddressState
        postCode.text = viewModel?.lookupData?.AddressPostcode
        addressDate.text = viewModel?.lookupData?.AddressDate
        
    }
}
extension SCABNDisplayView: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        abnTextField.resignFirstResponder()
        return false
    }
}
