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

//屏幕的宽度
private let KSCREEN_WIDTH:CGFloat  = UIScreen.main.bounds.width

//键盘的高宽比
private let BOARDRATIO:CGFloat = 224.0 / 275.0

//按键的高宽比
private let KEYRATIO:CGFloat = 86.0  / 63.0

//键盘的高
private let KEYBOARD_HEIGHT:CGFloat = KSCREEN_WIDTH * BOARDRATIO

//按键的宽
private let BTN_WIDTH:CGFloat = KSCREEN_WIDTH / 10.0 - 6.0

//按键的高
private let BTN_HEIGHT:CGFloat = BTN_WIDTH * KEYRATIO

//item的高
private let ITEM_HEIGHT:CGFloat = BTN_HEIGHT + 10.0

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
        view.addSubview(imageV)
        imageV.snp.makeConstraints { (make) in
            make.centerX.equalTo(view.snp.centerX)
            make.width.equalTo(200)
            make.height.equalTo(200)
            make.top.equalTo(view.snp.top).offset(400)
        }
        view.addSubview(countingLabel)
        
        view.addSubview(textfield)
        textfield.snp.makeConstraints { (make) in
            make.width.equalTo(50)
            make.height.equalTo(20)
            make.bottom.equalTo(view.snp.bottom).offset(-300)
            make.left.equalTo(50)
        }
        
//        textfield.becomeFirstResponder()
        
        
        view.addSubview(textfield1)
        textfield1.snp.makeConstraints { (make) in
            make.width.equalTo(50)
            make.height.equalTo(20)
            make.bottom.equalTo(view.snp.bottom).offset(-300)
            make.left.equalTo(200)
        }
        let keyBoards = ZMKeyBoardView()
        textfield1.inputView = keyBoards
        keyBoards.inputSource = textfield1
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
        
        view.addSubview(searchBar)
        searchBar.frame = CGRect.init(x: 44, y: 88, width: UIScreen.main.bounds.width - 60, height: 30)

//        view.addSubview(keyboardView)
        // Do any additional setup after loading the view.
    }
    
    lazy var keyboardView : ZMKeyBoardView = {
//        let object = ZMKeyBoardView.init(frame: CGRect.init(x: 0, y: 130, width: UIScreen.main.bounds.size.width, height: 240))
//        object.backgroundColor = UIColor.white
        let object = ZMKeyBoardView()
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

    lazy var textfield : UITextField = {
        let object = UITextField()
        object.returnKeyType = .done
        object.font = UIFont.systemFont(ofSize: 20)
        object.textColor = UIColor.black
        object.tag = 100
//        object.backgroundColor = UIColor.cyan
        object.addTarget(self, action: #selector(textfieldLengthDidChanged(textF:)), for: .editingChanged)
        return object
    }()
    
    lazy var textfield1 : UITextField = {
        let object = UITextField()
        object.returnKeyType = .done
        object.font = UIFont.systemFont(ofSize: 20)
        object.textColor = UIColor.black
        object.tag = 101

        object.backgroundColor = UIColor.green
        object.addTarget(self, action: #selector(textfieldLengthDidChanged(textF:)), for: .editingChanged)
        return object
    }()
    @objc func textfieldLengthDidChanged(textF: UITextField){
        
        if textF.tag == 100 {
//            textfield1.becomeFirstResponder()
        }else {
            
        }
        
        
    }
    
    lazy var searchBar : UISearchBar = {
        let object = UISearchBar()
//        object.delegate = self
        object.placeholder = "请输入要搜索的中英文"
        object.barStyle = .default
        object.backgroundImage = UIImage.init()
        object.barTintColor = UIColor.white
        object.tintColor = UIColor.red
        object.layer.cornerRadius = 15
        object.clipsToBounds = true
        object.backgroundColor = UIColor.cyan
        let textfield = object.value(forKey: "searchField") as! UITextField
        textfield.backgroundColor = UIColor.cyan
        textfield.returnKeyType = .search
//        textfield.layer.cornerRadius = 15
//        textfield.layer.masksToBounds = true
        textfield.inputView = self.keyboardView
        self.keyboardView.inputSource = textfield
        textfield.becomeFirstResponder()
        

        return object
    }()
}
