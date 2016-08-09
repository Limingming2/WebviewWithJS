//
//  ViewController.swift
//  WebViewWithJSDemo
//
//  Created by 李明明 on 16/1/9.
//  Copyright © 2016年 李明明. All rights reserved.
//

import UIKit
import JavaScriptCore

class ViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet private var web: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let request = NSURLRequest(URL: NSURL(fileURLWithPath: urlStr!))
        web.loadRequest(request)
        print(urlStr)
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.push), name: pushNoti, object: nil)
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    // MARK: - noti
    func push() {
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            self.performSegueWithIdentifier(pushIdentifier, sender: nil)
        }
    }

    // MARK: - webviewdelegate
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        // 给js传参说明是uiwebview
        return true
    }
    func webViewDidFinishLoad(webView: UIWebView) {
        // 把含有要被调用的方法的类传给web
        let model = BridgeModel()
        let context = webView.valueForKeyPath(jsPath) as! JSContext
        context.setObject(model, forKeyedSubscript: "ioswindow")
        let style = String(format: "myfunction('%@')", NSStringFromClass(webView.classForCoder))
        webView.stringByEvaluatingJavaScriptFromString(style)
        webView.stringByEvaluatingJavaScriptFromString("document.body.style.zoom=0.5")
        
    }


}

