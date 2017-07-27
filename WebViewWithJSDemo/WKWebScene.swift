//
//  WKWebScene.swift
//  WebViewWithJSDemo
//
//  Created by 李明明 on 16/1/9.
//  Copyright © 2016年 李明明. All rights reserved.
//

import UIKit
import WebKit


// WKWebview 会减少系统内存，相比UIWebview会节省资源
class WKWebScene: UIViewController, WKNavigationDelegate,WKScriptMessageHandler {
    var web: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let config = Configuration()
        config.userContentController.add(self, name: "ioswindow")
        web = WKWebView(frame: CGRect.zero, configuration: config)
        web.navigationDelegate = self
        let request = URLRequest(url: URL(fileURLWithPath: urlStr!))
        web.load(request)
        web.translatesAutoresizingMaskIntoConstraints = false
        let contraints = addConstraint()
        view.addSubview(web)
        NSLayoutConstraint.activate(contraints)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    // MARK: - WKScriptMessageHandler
    func pop() {
        navigationController?.popViewController(animated: true)
    }
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print(message.body)
        if message.body is String {
            let str = message.body as! String
            if str == "pop" {
                pop()
            }
        }
    }

    
    // MARK: - webview delegate
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        let style = String(format: "myfunction('%@')", NSStringFromClass(webView.classForCoder))
        webView.evaluateJavaScript(style, completionHandler: nil)
        webView.evaluateJavaScript("document.body.style.zoom=2", completionHandler: nil)
    }
    // MARK: - constraint
    func addConstraint()->[NSLayoutConstraint] {
        let top = NSLayoutConstraint(item: web, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 0)
        let left = NSLayoutConstraint(item: web, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant: 0)
        let bottom = NSLayoutConstraint(item: web, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 0)
        let right = NSLayoutConstraint(item: web, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1.0, constant: 0)
        return [top, left, bottom, right]
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
