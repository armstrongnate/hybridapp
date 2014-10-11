//
//  ViewController.swift
//  WebView
//
//  Created by Nate Armstrong on 6/15/14.
//  Copyright (c) 2014 Nate Armstrong. All rights reserved.
//

import UIKit

enum SegueType: String {
  case Push = "push"
  case Modal = "modal"
  case Dismiss = "dismiss"
}

class ViewController: UIViewController, UIWebViewDelegate {

  var webView: UIWebView?
  var url: String

  init(url: String) {
    self.url = url
    super.init(nibName: nil, bundle: nil)
    tabBarItem.image = UIImage(named: "home.png")
    tabBarItem.title = "Demo"
  }

  override func viewDidLoad() {
    view.backgroundColor = UIColor.whiteColor()
    title = "Demo"
    webView = UIWebView(frame: view.frame)
    if webView {
      let request = NSURLRequest(URL: NSURL(string: url))
      webView!.loadRequest(request)
      webView!.delegate = self
      view.addSubview(webView)
    }
  }

  func webView(webView: UIWebView!,
      shouldStartLoadWithRequest request: NSURLRequest!,
      navigationType: UIWebViewNavigationType) -> Bool {
    let href = request.URL.relativePath
    if let segue = segueOfLink(href) {
      performSegueWithType(SegueType.fromRaw(segue)!, andURL: request.URL.absoluteString)
      return false
    }

    return true
  }

  func segueOfLink(link: NSString) -> NSString? {
    let segue: String = webView!.stringByEvaluatingJavaScriptFromString("segueOfLink('\(link)')")
    return segue.bridgeToObjectiveC().length > 0 ? segue : nil
  }

  func performSegueWithType(type: SegueType, andURL url: String) {
    let vc = ViewController(url: url)
    switch type {
      case .Push:
        navigationController.pushViewController(vc, animated: true)
      case .Modal:
        presentViewController(vc, animated: true, completion: nil)
      case .Dismiss:
        dismissModalViewControllerAnimated(true)
    }
  }

}

