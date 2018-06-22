//
//  ViewController.swift
//  GeolocationApp
//
//  Created by KP on 16/06/2018.
//  Copyright © 2018 KP. All rights reserved.
//

// Reference: https://jayeshkawli.ghost.io/ios-communication-from-javascript-to-swift/

import UIKit

class WebViewViewController: UIViewController {
    
    // Outlet
    @IBOutlet weak var locationWebView: UIWebView!
    @IBOutlet weak var locationLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = Bundle.main.path(forResource: "webview_js_send_native", ofType: "html")
        let url = URL(fileURLWithPath: path!)
        let req = URLRequest(url: url)
        locationWebView.delegate = self
        locationWebView.loadRequest(req)
    }
    
    @IBAction func callJSAction(_ sender: UIButton) {
        if let result = locationWebView.stringByEvaluatingJavaScript(from: "receiveEventFromSwift()") {
            locationLabel.text = result
            print("result \(result)")
        }
    }
}

extension WebViewViewController: UIWebViewDelegate {
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        print("request \(request)\n\n\n")
        if let schema = request.url?.scheme, let host = request.url?.host {
            if schema == "customscheme" {
                print("we got a custom scheme request: \"\(schema)\" and host name: \"\(host)\"")
                if request.url?.query != nil {
                    print("\nQuery Data: \(request.url!.query!)")
                    locationLabel.text = request.url?.query!
                }
                
                return false
            }
        }
        return true
    }
}

