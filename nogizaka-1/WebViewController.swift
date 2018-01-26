//
//  WebViewController.swift
//  nogizaka-1
//
//  Created by kentaro on 2018/01/16.
//  Copyright © 2018 kentaro kusumi. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var navItem: UINavigationItem!
    @IBOutlet weak var barButton: UIBarButtonItem!
    @IBAction func barButton(_ sender: UIBarButtonItem) {
        let storyboard: UIStoryboard = self.storyboard!
        let barViewControllers = storyboard.instantiateViewController(withIdentifier: "tabbarcon") as! UITabBarController
        if (fromwhere == "PickUp"){
            let nav = barViewControllers.viewControllers![0] as! UINavigationController
            barViewControllers.selectedViewController = nav
            present(barViewControllers, animated: true, completion: nil)
        }else{
            let nav = barViewControllers.viewControllers![1] as! UINavigationController
            barViewControllers.selectedViewController = nav
            present(barViewControllers, animated: true, completion: nil)
        }
        webView.removeObserver(self, forKeyPath: "estimatedProgress")
        webView.removeObserver(self, forKeyPath: "loading")
    }

    var showHtml = String()
    var fromwhere = String()
    var webView = WKWebView()
    var progressView = UIProgressView()


    override func viewDidLoad() {
        super.viewDidLoad()
        webView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height)
        webView.allowsBackForwardNavigationGestures = true
        
        webView.addObserver(self, forKeyPath:"estimatedProgress", options:.new, context:nil)
        webView.addObserver(self, forKeyPath:"loading", options:.new, context:nil)

        progressView = UIProgressView(frame: CGRect(x: 0, y:44, width: self.view.bounds.size.width, height: 10))
        progressView.progressViewStyle = .bar
        mainView.addSubview(progressView)
        
        self.view.layoutIfNeeded()
        let delegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        showHtml = delegate.webHTML
        fromwhere = delegate.fromwhere
        navItem.title = fromwhere
        let myURL = URL(string: showHtml)
        let myRequest = URLRequest(url: myURL!)
        mainView.addSubview(webView)
        webView.load(myRequest)
        
        // Do any additional setup after loading the view.
    }

    deinit{
        //消さないと、アプリが落ちる
        webView.removeObserver(self, forKeyPath: "estimatedProgress")
        webView.removeObserver(self, forKeyPath: "loading")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        switch keyPath {
        case "estimatedProgress"?:
            self.progressView.setProgress(Float(webView.estimatedProgress), animated: true)
        case "loading"?:
            UIApplication.shared.isNetworkActivityIndicatorVisible = webView.isLoading
            if webView.isLoading {
                self.progressView.setProgress(0.1, animated: true)
            }else{
                //読み込みが終わったら0に
                self.progressView.setProgress(0.0, animated: false)
            }
        default:
            break
        }
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
       
    }
}
