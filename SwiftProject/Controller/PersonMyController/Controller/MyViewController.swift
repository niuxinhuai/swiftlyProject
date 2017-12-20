//
//  MyViewController.swift
//  SwiftProject
//
//  Created by 牛新怀 on 2017/12/13.
//  Copyright © 2017年 牛新怀. All rights reserved.
//

import UIKit

class MyViewController: BaseViewController {
    var data = ["我的动态","我的关注","我的粉丝","我的合集","我的订阅","我的消息"]



    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.view.addSubview(self.tableView)
        // Do any additional setup after loading the view.
    }
    
    lazy var tableView:UITableView = {
        let mainTable = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height-49), style: UITableViewStyle.plain)
        mainTable.delegate = self;
        mainTable.dataSource = self;
        mainTable.separatorStyle = .none
        mainTable.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cellIdentifier")
        return mainTable
    }()

}

extension MyViewController: UITableViewDelegate,UITableViewDataSource{
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return data.count
        default:
            return 0
        }
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier",
                                                 for: indexPath)
        let label = UILabel()
        label.backgroundColor = UIColor.lightGray
        label.alpha = 0.2
        label.frame = CGRect.init(x: 0, y: cell.frame.size.height-0.5, width: cell.frame.size.width, height: 0.5)
        cell.addSubview(label)
        
        if indexPath.section == 2 {
            cell.textLabel?.text = data[indexPath.row]
        }
        
        return cell
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int{
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 80
        case 1:
            return 80
        case 2:
            return 56
        default:
            return 0
        }
    }
    
    
}
