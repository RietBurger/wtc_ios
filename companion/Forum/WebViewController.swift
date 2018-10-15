//
//  WebViewController.swift
//  Forum
//
//  Created by Lance CHANT on 2018/10/07.
//  Copyright © 2018 Jeanette Henriette BURGER. All rights reserved.
//

import UIKit
import WebKit


class WebViewController: UIViewController, WKNavigationDelegate {
    var LoggedIn = false

    @IBOutlet weak var webview: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let url = URL(string: "https://api.intra.42.fr/oauth/authorize?client_id=b654f310dbf2bada79b1ed5cb10d6b19ece7fc5649ad79ca9e4dbfc349fd082c&redirect_uri=http%3A%2F%2FRush00&response_type=code");
        let request = URLRequest(url: url!);
        webview.load(request);
        webview.navigationDelegate = self;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        if navigationAction.navigationType == WKNavigationType.linkActivated {
            print("link \((webview.url?.absoluteString)!)")
            
            decisionHandler(WKNavigationActionPolicy.cancel)
            return
        }
        var link: String = (webview.url?.absoluteString)!;
        if (link.contains("http://rush00"))
        {
            let str  = (webview.url?.absoluteString)!;
            let array = str.components(separatedBy: "=");
            print(array)
            code = array[array.count - 1];
            let apiCall = ApiController();
            apiCall.getAccessToken();
            let HomeViewPage:ViewController = self.storyboard?.instantiateViewController(withIdentifier: "Home") as! ViewController;
            self.navigationController?.pushViewController(HomeViewPage, animated: true);
        }
        link = "";
        decisionHandler(WKNavigationActionPolicy.allow)
    }

}
