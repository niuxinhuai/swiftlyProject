//
//  HaveReadViewController.swift
//  SwiftProject
//
//  Created by 牛新怀 on 2017/12/13.
//  Copyright © 2017年 牛新怀. All rights reserved.
//

import UIKit
import SnapKit
import Alamofire

class HaveReadViewController: BaseViewController {

//    http://baobab.wdjcdn.com/1456665467509qingshu.mp4
    //下载文件的保存路径（
    var destination:DownloadRequest.DownloadFileDestination!
    //用于停止下载时，保存已下载的部分
    var cancelledData: Data?
    
    //下载请求对象
    var downloadRequest: DownloadRequest!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(stopBtn)
        stopBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(view.snp.centerX)
            make.width.equalTo(200)
            make.height.equalTo(30)
            make.top.equalTo(view.snp.top).offset(100)
        }
        view.addSubview(confinueBtn)
        confinueBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(view.snp.centerX)
            make.width.equalTo(200)
            make.height.equalTo(30)
            make.top.equalTo(view.snp.top).offset(200)
        }
        view.addSubview(progress)
        progress.snp.makeConstraints { (make) in
            make.centerX.equalTo(view.snp.centerX)
            make.width.equalTo(200)
            make.height.equalTo(5)
            make.top.equalTo(view.snp.top).offset(300)
        }
        view.addSubview(imageV)
        imageV.snp.makeConstraints { (make) in
            make.centerX.equalTo(view.snp.centerX)
            make.width.equalTo(200)
            make.height.equalTo(200)
            make.top.equalTo(view.snp.top).offset(400)
        }
        view.addSubview(countingLabel)
//        countingLabel.snp.makeConstraints { (make) in
//            make.left.equalTo(100)
//            make.width.equalTo(200)
//            make.height.equalTo(50)
//            make.top.equalTo(view.snp.top).offset(600)
//        }
        countingLabel.attributedFormatBlock = {(_ object) in
            let str = "\(Int(object))%"
            let attrStr = NSMutableAttributedString.init(string: str)
            let rangeStr = str as NSString
            
            let range = rangeStr.range(of: "%")
            attrStr.addAttribute(NSAttributedStringKey.font, value: UIFont.systemFont(ofSize: 30), range: range)
            attrStr.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.red, range: range)
            return attrStr
        }
        countingLabel.format = "%d"
        countingLabel.count(from: 0, to: 10239, withDuration: 2)
//        createFile()
        
        //设置下载路径。保存到用户文档目录，文件名不变，如果有同名文件则会覆盖
        self.destination = { _, response in
            let documentsURL = FileManager.default.urls(for: .documentDirectory,
                                                        in: .userDomainMask)[0]
            let fileURL = documentsURL.appendingPathComponent(response.suggestedFilename!)
            print(fileURL)
            
            //两个参数表示如果有同名文件则会覆盖，如果路径中文件夹不存在则会自动创建
            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        }
        
        for i in 0...3 {
            for n in 0...2 {
                print("当前走到\(i)第\(n)个")
                requestA(id: i, maxId: n)
            }
        }
        

        // Do any additional setup after loading the view.
    }
//    创建指定文件夹
    func createFile() -> Void {
        let directory: String = NSHomeDirectory() + "/Documents/zhimiFile/Files/33"
        let fileManager = FileManager.default
        try! fileManager.createDirectory(atPath: directory, withIntermediateDirectories: true, attributes: nil)
//        写入本地
        let str = "www123456.svg"
        
        let filePath: String = NSHomeDirectory() + "/Documents/zhimiFile/Files/33/\(str)"
        print(filePath)
//        let image = UIImage.init(named: "m8.jpg")
        try! str.write(toFile: filePath, atomically: true, encoding: String.Encoding.utf8)
//        let data: Data = UIImagePNGRepresentation(image!)!
//        try? data.write(to: URL.init(fileURLWithPath: filePath))
        
        
    }
    
    func requestA(id: Int, maxId: Int) -> Void {
//        let url = URLRequest.init(url: URL.init(string: "http://pwp.iwordnet.com/c 96033.svg")!)
        self.downloadRequest =  Alamofire.download("http://pwp.iwordnet.com/c 96033.svg", to: destination)
        
//        self.downloadRequest.downloadProgress(queue: DispatchQueue.main,
//                                              closure: downloadProgress) //下载进度
        self.downloadRequest.responseData { (response) in
            switch response.result {
            case .success( _):
                //self.image = UIImage(data: data)
                print("文件\(id)下载完毕\(maxId): \(response)")
            case .failure:
                print("失败\(id)原因\(maxId)： \(response.result.error!)")
            }
        } //下载停止响应
    }
    
    @objc func didSelectButtonClick(sender: UIButton){
        if sender.tag == 100 {
            print("停止下载")
            let urlsForDocDirectory = FileManager.default.urls(for: .documentDirectory, in:.userDomainMask)
            let docPath = urlsForDocDirectory[0]
            let file = docPath.appendingPathComponent("zhimiFile/Files/33/www123456.svg")
            if FileManager.default.fileExists(atPath: file.path) {
                if file.path.contains(".svg") {
                    print("存在.svg")
                }else {
                    print("不是.svg")
                }
                let data: Data = try! Data.init(contentsOf: file)
                //            imageV.image = UIImage.init(data: data)
                //            let readHandler = try! FileHandle.init(forReadingFrom: file)
                //            let data = readHandler.readDataToEndOfFile()
                let readStr = String.init(data: data, encoding: String.Encoding.utf8)
                print(readStr!)
            }else {
                print("不存在")
            }

            self.downloadRequest?.cancel()
//            self.stopBtn.isEnabled = false
//            self.confinueBtn.isEnabled = true
        }else {
           print("开始下载")
            if self.cancelledData != nil {
                self.downloadRequest = Alamofire.download(resumingWith: cancelledData!,
                                                          to: destination)
                self.downloadRequest.downloadProgress(queue: DispatchQueue.main,
                                                      closure: downloadProgress) //下载进度
                self.downloadRequest.responseData(completionHandler: downloadResponse) //下载停止响应
            }else {
                //页面加载完毕就自动开始下载
                let url = URLRequest.init(url: URL.init(string: "http://baobab.wdjcdn.com/1456665467509qingshu.mp4")!)
//                self.downloadRequest = Alamofire.download("http://v.iseeyoo.cn/video/2010/10/25/2a9f0f4e-e035-11df-9117-001e0bbb2442_001.mp4", destination: self.destination)
//                self.downloadRequest = Alamofire.download(url, to: self.destination)
                self.downloadRequest =  Alamofire.download("http://v.iseeyoo.cn/video/2010/10/25/2a9f0f4e-e035-11df-9117-001e0bbb2442_001.mp4", to: destination)
                self.downloadRequest.downloadProgress(queue: DispatchQueue.main,
                                                      closure: downloadProgress) //下载进度
                self.downloadRequest.responseData(completionHandler: downloadResponse) //下载停止响应
            }
            
            
            
//
//            self.stopBtn.isEnabled = true
//            self.confinueBtn.isEnabled = false
        }
        
    }
    //下载过程中改变进度条
    
    func downloadProgress(progress: Progress) {
        //进度条更新
        self.progress.setProgress(Float(progress.fractionCompleted), animated:true)
        print("当前进度：\(Float(progress.fractionCompleted))")
    }
    
    
    //下载停止响应（不管成功或者失败）
    func downloadResponse(response: DownloadResponse<Data>) {
        switch response.result {
        case .success( _):
            //self.image = UIImage(data: data)
            print("文件下载完毕: \(response)")
        case .failure:
            self.cancelledData = response.resumeData //意外终止的话，把已下载的数据储存起来
        }
    }

    lazy var stopBtn : UIButton = {
        let object = UIButton()
        object.setTitle("停止下载", for: .normal)
        object.setTitleColor(UIColor.red, for: .normal)
        object.tag = 100
        object.addTarget(self, action: #selector(didSelectButtonClick(sender:)), for: .touchUpInside)
        return object
    }()
    
    lazy var confinueBtn : UIButton = {
        let object = UIButton()
        object.setTitle("开始下载", for: .normal)
        object.setTitleColor(UIColor.red, for: .normal)
        object.tag = 101
        object.addTarget(self, action: #selector(didSelectButtonClick(sender:)), for: .touchUpInside)
        return object
    }()
    
    lazy var progress : UIProgressView = {
        let object = UIProgressView()
//        object.transform = CGAffineTransform.init(scaleX: 50, y: 5)
        object.progressTintColor = UIColor.red
        object.trackTintColor = UIColor.lightGray
        return object
    }()
    
    lazy var imageV : UIImageView = {
        let object = UIImageView()
        return object
    }()

    lazy var countingLabel : UICountingLabel = {
        let object = UICountingLabel.init(frame: CGRect.init(x: 50, y: 200, width: 200, height: 100))
        object.font = UIFont.systemFont(ofSize: 18)
        object.textColor = UIColor.orange
        object.textAlignment = .center
 
        return object
    }()

    

    

    

    

}
