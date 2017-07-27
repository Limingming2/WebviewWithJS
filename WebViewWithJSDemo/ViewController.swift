//
//  ViewController.swift
//  WebViewWithJSDemo
//
//  Created by 李明明 on 16/1/9.
//  Copyright © 2016年 李明明. All rights reserved.
//

import UIKit
import JavaScriptCore

class ViewController: UIViewController, UIWebViewDelegate,JSProtocol {

    @IBOutlet fileprivate var web: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let request = URLRequest(url: URL(fileURLWithPath: urlStr!))
        web.loadRequest(request)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
//    MARK: - JSProtocol
    func push() {
        self.performSegue(withIdentifier: pushIdentifier, sender: nil)
    }

    // MARK: - webviewdelegate
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        // 给js传参说明是uiwebview
        return true
    }
    func webViewDidFinishLoad(_ webView: UIWebView) {
        // 把含有要被调用的方法的类传给web
        let context = webView.value(forKeyPath: jsPath) as! JSContext
        context.setObject(self, forKeyedSubscript: "ioswindow" as NSCopying & NSObjectProtocol)
        let style = String(format: "myfunction('%@')", NSStringFromClass(webView.classForCoder))
        webView.stringByEvaluatingJavaScript(from: style)
        webView.stringByEvaluatingJavaScript(from: "document.body.style.zoom=0.5")
        
    }


}

