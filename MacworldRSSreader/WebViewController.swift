//
//  WebViewController.swift
//  MacworldRSSreader
//
//  Created by Pavel Osipenko on 20/08/16.
//  Copyright © 2016 P.Osipenko. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate  {
  
  var linkURL: String!
  
  var webView: WKWebView?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Create our preferences on how the web page should be loaded
    let preferences = WKPreferences()
    preferences.javaScriptEnabled = false
    
    // Create a configuration for our preferences
    let configuration = WKWebViewConfiguration()
    configuration.preferences = preferences
    
    // Now instantiate the web view
    webView = WKWebView(frame: view.bounds, configuration: configuration)
    
    if let theWebView = webView {
      // Load a web page into our web view
      let url = NSURL(string: linkURL)
      let urlRequest = NSURLRequest(URL: url!)
      theWebView.loadRequest(urlRequest)
      theWebView.navigationDelegate = self
      view.addSubview(theWebView)
    }
  }
  
  // Start the network activity indicator when the web view is loading
  func webView(webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
    UIApplication.sharedApplication().networkActivityIndicatorVisible = true
  }
  
  // Stop the network activity indicator when the loading finishes
  func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
  }

}
