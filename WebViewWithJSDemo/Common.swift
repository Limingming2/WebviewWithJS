//
//  Common.swift
//  WebViewWithJSDemo
//
//  Created by 李明明 on 16/1/9.
//  Copyright © 2016年 李明明. All rights reserved.
//

import Foundation
import UIKit

public let urlStr = NSBundle.mainBundle().pathForResource("print", ofType: "html")?.stringByAddingPercentEncodingWithAllowedCharacters(.URLQueryAllowedCharacterSet())

public let pushNoti = "pushidentifier"

public let popNoti = "popidentifier"

public let jsPath = "documentView.webView.mainFrame.javaScriptContext"

public let pushIdentifier = "uiwebviewtowkwebview"