//
//  BridgeModel.swift
//  WebViewWithJSDemo
//
//  Created by 李明明 on 16/1/9.
//  Copyright © 2016年 李明明. All rights reserved.
//

import UIKit
import JavaScriptCore
import WebKit
// MARK: - UIWebView's Model
@objc protocol JSProtocol: JSExport {
    func push();
    func pop();
}
@objc class BridgeModel: NSObject, JSProtocol {
    func push() {
        NSNotificationCenter.defaultCenter().postNotificationName(pushNoti, object: nil)
    }
    func pop() {
        NSNotificationCenter.defaultCenter().postNotificationName(popNoti, object: nil)
    }
}
// MARK: - WKWebView's Model
class WkBridgeModel:NSObject, WKScriptMessageHandler {
    func userContentController(userContentController: WKUserContentController, didReceiveScriptMessage message: WKScriptMessage) {
        print(message.body)
        if message.body is String {
            let str = message.body as! String
            if str == "pop" {
                NSNotificationCenter.defaultCenter().postNotificationName(popNoti, object: nil)
            }
        }
    }
}


