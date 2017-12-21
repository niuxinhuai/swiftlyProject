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
    var webImageListArray : Array<Any>!
    var imgStr = String()
    
    
    convenience init(url: String?){
        self.init()
        // 拿到传递过来的url需要进行编码才可以使用
        let encodeUrl = String.encode(url)
        let urlStr = String.init("https://promotion-dev.beichoo.com/beichoo_app/article/index.html?user_id=&token=&article_id=\(String(describing: encodeUrl!))")
        self.request = URLRequest.init(url: URL.init(string: urlStr)!)
    }
    
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
    
    override var canResignFirstResponder: Bool{
        return false
    }
    
    override var canBecomeFirstResponder: Bool{
        return true
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if (action == #selector(point) ||
            action == #selector(share) ||
            action == #selector(copyAction)) {
            return true
        }
        return false
    }
    
    func Menu() -> Void {
        let menu = UIMenuController.shared
        let item = UIMenuItem.init(title: "划重点", action: #selector(point))
        let shareItem = UIMenuItem.init(title: "分享", action: #selector(share))
        let copyItem = UIMenuItem.init(title: "拷贝", action: #selector(copyAction))
        
        menu.menuItems = [item,shareItem,copyItem]
        menu.arrowDirection = .default
        menu.setTargetRect(articleWeb.bounds, in: articleWeb)
        menu.setMenuVisible(true, animated: true)
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 30 {
            self.title = articleWeb.title
        }else{
            self.title = ""
        }
    }
    
    @objc func point() {
        articleWeb.evaluateJavaScript("get_selection()", completionHandler: nil)
    }
    
    @objc func share() {
        articleWeb.evaluateJavaScript("get_selection_txt()", completionHandler: nil)
    }
    
    @objc func copyAction() {
        articleWeb.evaluateJavaScript("window.getSelection().toString()") { (object, error) in
            print(object!)
        }
    }
    
    @objc func itemClick() {
        print("点击了")
    }
    
    private lazy var articleWeb : WKWebView = {
        let webView = WKWebView.init(frame: view.bounds, configuration: configutation)
        webView.allowsBackForwardNavigationGestures = true
        webView.navigationDelegate = self
        webView.uiDelegate = self
        webView.scrollView.delegate = self
        return webView
    }()
    
    private lazy var configutation: WKWebViewConfiguration = {
       let config = WKWebViewConfiguration()
        config.userContentController.addUserScript(String.userScript())
        config.userContentController.add(WeakScriptMessageDelegate.init(delegate: self), name: "webViewApp")
        return config
    }()
    
    private lazy var progressView : UIProgressView = {
        let pp = UIProgressView.init(frame: CGRect.init(x: 0, y: 64, width: view.frame.size.width, height: 2))
        pp.tintColor = UIColor.blue
        pp.backgroundColor = UIColor.lightGray
        pp.transform = CGAffineTransform.init(scaleX: 1, y: 1)
        return pp
    }()
    
    deinit {
        articleWeb.removeObserver(self, forKeyPath: "estimatedProgress")
    }
}

extension ArticleDetialViewController: WKUIDelegate,WKNavigationDelegate,SDPhotoBrowserDelegate{
    
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
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if (navigationAction.request.url?.scheme == "image-preview") {
            let miu = String.init(describing: "image-preview:")
            
            let preview = String.init(describing: navigationAction.request.url!.absoluteString)
            
            let path = preview.suffix(from:(miu.index(miu.startIndex, offsetBy: 14)))
            imgStr = String(path)
            self.previewPicture()
        }
        decisionHandler(.allow)
    }
    
    func previewPicture() -> Void {
        var currentIndex: Int = 0
        for section in 0..<webImageListArray.count{
            let path = String(describing: webImageListArray![section])
            if path == imgStr{
                currentIndex = section
            }
            
        }
        let photoBrowserd = SDPhotoBrowserd()
        photoBrowserd.imageCount = webImageListArray.count
        photoBrowserd.currentImageIndex = currentIndex
        photoBrowserd.sourceImagesContainerView = view
        photoBrowserd.delegate = self
        photoBrowserd.show()
        
        
    }
    
    func photoBrowser(_ browser: SDPhotoBrowserd!, highQualityImageURLFor index: Int) -> URL! {
        return NSURL.init(string: String.init(describing: webImageListArray[index]))! as URL
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        print("错误信息\(error)")
    }
}

extension ArticleDetialViewController: WKScriptMessageHandler{
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print(message.body)
        let dic = message.body as! Dictionary<String, Any>
        if (dic["success"] != nil) {
            print("有值啦...")
            articleWeb.evaluateJavaScript("getImages()", completionHandler: { (object, error) in
                let str = String.init(describing: object!)
                self.webImageListArray = str.components(separatedBy: "+")
                
            })
            articleWeb.evaluateJavaScript("registerImageClickAction();", completionHandler: nil)
        }
    }
}

