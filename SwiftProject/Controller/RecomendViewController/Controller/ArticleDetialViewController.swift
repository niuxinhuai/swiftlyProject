//
//  ArticleDetialViewController.swift
//  SwiftProject
//
//  Created by 牛新怀 on 2017/12/20.
//  Copyright © 2017年 牛新怀. All rights reserved.
//

import UIKit
import WebKit
class ArticleDetialViewController: BaseViewController,UIScrollViewDelegate {

    var request: URLRequest!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(self.articleWeb)
        view.addSubview(self.progressView)
        articleWeb.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        articleWeb.load(request)
        self.Menu()

        navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "message_pic")?.withRenderingMode(.alwaysOriginal),
                                                                 style: .plain,
                                                                 target: self,
                                                                 action: #selector(itemClick))

    }
    @objc func itemClick() {
        print("点击了")
    }
    private lazy var articleWeb : WKWebView = {
        let webView = WKWebView.init(frame: view.bounds)
        webView.allowsBackForwardNavigationGestures = true
        webView.navigationDelegate = self
        webView.uiDelegate = self
        webView.scrollView.delegate = self
        return webView
    }()
    
    private lazy var progressView : UIProgressView = {
        let pp = UIProgressView.init(frame: CGRect.init(x: 0, y: 64, width: view.frame.size.width, height: 2))
        pp.tintColor = UIColor.blue
        pp.backgroundColor = UIColor.lightGray
        pp.transform = CGAffineTransform.init(scaleX: 1, y: 1)
        return pp
    }()
    
    convenience init(url: String?){
        self.init()
        //https://promotion-dev.beichoo.com/beichoo_app/article/index.html
        let urlStr = String.init("https://promotion-dev.beichoo.com/beichoo_app/article/index.html?user_id=&token=&article_id=wx-http%3A%2F%2Fmp.weixin.qq.com%2Fs%3F__biz%3DMjM5OTA1MDUyMA%3D%3D%26mid%3D2655440220%26idx%3D1%26sn%3Dfa2cab627c1540cdfe883eb4379d9a4c%26scene%3D0")
        
        self.request = URLRequest.init(url: URL.init(string: urlStr)!)
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 30 {
            self.title = articleWeb.title
        }else{
            self.title = ""
        }
    }
    
    func Menu() -> Void {
        let menu = UIMenuController.shared
        let item = UIMenuItem.init(title: "划重点", action: #selector(point))
        let shareItem = UIMenuItem.init(title: "分享", action: #selector(share))
        
        menu.menuItems = [item,shareItem]
        menu.arrowDirection = .default
        menu.setTargetRect(articleWeb.bounds, in: articleWeb)
        menu.setMenuVisible(true, animated: true)
        
    }
    
    override var canResignFirstResponder: Bool{
        return false
    }
    
    override var canBecomeFirstResponder: Bool{
        return true
    }

    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if (action == #selector(point) || action == #selector(share)) {
            return true
        }
        return false
    }
    @objc func point() {
        articleWeb.evaluateJavaScript("get_selection()", completionHandler: nil)
    }
    
    @objc func share() {
        articleWeb.evaluateJavaScript("get_selection_txt()", completionHandler: nil)
    }
    deinit {
        articleWeb.removeObserver(self, forKeyPath: "estimatedProgress")
    }
}

extension ArticleDetialViewController: WKUIDelegate,WKNavigationDelegate{
    
    override func observeValue(forKeyPath keyPath: String?,
                               of object: Any?,
                               change: [NSKeyValueChangeKey : Any]?,
                               context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress"{
            progressView.isHidden = articleWeb.estimatedProgress >= 1
            progressView.setProgress(Float(articleWeb.estimatedProgress), animated: true)
        }
        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        progressView.setProgress(0.0, animated: true)
        navigationItem.title = title ?? (webView.title ?? webView.url?.host)
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        print("错误信息\(error)")
    }
    
    
    
}
