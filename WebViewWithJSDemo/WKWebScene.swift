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
class WKWebScene: UIViewController, WKNavigationDelegate {
    var web: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        web = WKWebView(frame: CGRectZero, configuration: Configuration())
        web.navigationDelegate = self
        let request = NSURLRequest(URL: NSURL(fileURLWithPath: urlStr!))
        web.loadRequest(request)
        web.translatesAutoresizingMaskIntoConstraints = false
        let contraints = addConstraint()
        view.addSubview(web)
        NSLayoutConstraint.activateConstraints(contraints)
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "pop", name: popNoti, object: nil)
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    // MARK: - noti
    func pop() {
        navigationController?.popViewControllerAnimated(true)
    }
    // MARK: - webview delegate
    func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
        let style = String(format: "myfunction('%@')", NSStringFromClass(webView.classForCoder))
        webView.evaluateJavaScript(style, completionHandler: nil)
        webView.evaluateJavaScript("document.body.style.zoom=2", completionHandler: nil)
    }
    // MARK: - constraint
    func addConstraint()->[NSLayoutConstraint] {
        let top = NSLayoutConstraint(item: web, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: 0)
        let left = NSLayoutConstraint(item: web, attribute: .Left, relatedBy: .Equal, toItem: view, attribute: .Left, multiplier: 1.0, constant: 0)
        let bottom = NSLayoutConstraint(item: web, attribute: .Bottom, relatedBy: .Equal, toItem: view, attribute: .Bottom, multiplier: 1.0, constant: 0)
        let right = NSLayoutConstraint(item: web, attribute: .Right, relatedBy: .Equal, toItem: view, attribute: .Right, multiplier: 1.0, constant: 0)
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
