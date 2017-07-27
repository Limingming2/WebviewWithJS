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
}


