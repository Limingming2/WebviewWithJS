//
//  Configuration.swift
//  WebViewWithJSDemo
//
//  Created by 李明明 on 16/1/9.
//  Copyright © 2016年 李明明. All rights reserved.
//

import UIKit
import WebKit

class Configuration: WKWebViewConfiguration {
    override init() {
        super.init()
        preferences = WKPreferences()
        preferences.javaScriptCanOpenWindowsAutomatically = true
        preferences.javaScriptEnabled = true
        userContentController = WKUserContentController()
        let model = WkBridgeModel()
        userContentController.addScriptMessageHandler(model, name: "ioswindow")
    }
}
