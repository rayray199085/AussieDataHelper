//
//  SCAreaCodesViewController.swift
//  AussieDataHelper
//
//  Created by Stephen Cao on 26/6/19.
//  Copyright © 2019 Stephencao Cao. All rights reserved.
//

import UIKit
import WebKit
import SVProgressHUD

class SCAreaCodesViewController: UIViewController {

    private var webView: WKWebView!
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.scrollView.bounces = false
        webView.navigationDelegate = self
        webView.allowsBackForwardNavigationGestures = true
//        webView.isOpaque = false
//        webView.backgroundColor = HelperCommonValues.SCBaseViewBackgroundColor
        view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        loadWebView()
    }
}
private extension SCAreaCodesViewController{
    func loadWebView(){
        let urlString = "https://www.australia.gov.au/about-australia/facts-and-figures/telephone-country-and-area-codes"
        guard let url = URL(string: urlString) else{
            return
        }
        webView.load(URLRequest(url: url))
    }
}
extension SCAreaCodesViewController: WKNavigationDelegate{
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        SVProgressHUD.show()
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        SVProgressHUD.dismiss()
    }
}
