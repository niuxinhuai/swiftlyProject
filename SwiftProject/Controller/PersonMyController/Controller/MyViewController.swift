//
//  MyViewController.swift
//  SwiftProject
//
//  Created by 牛新怀 on 2017/12/13.
//  Copyright © 2017年 牛新怀. All rights reserved.
//

import UIKit
class MyViewController: BaseViewController {
    var data:Array = PersonModel.data
    var imgNamedArray: Array = PersonModel.imgNamedArray
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(self.mainScroll)
        
        var array = [1,2,3,4,5]
        var min = [1,2]
        
        array.remove(at: 0)
        array.remove(at: 0)
        array.append(min[0])
        array.append(min[1])
        print(array)
        
        
    }
    
    override func configNavgationItem() {
        super.configNavgationItem()
        navigationItem.rightBarButtonItem = UIBarButtonItem.initNavBarbuttonItems(imageNamed: "btn_my_set_black",
                                                                                  target: self,
                                                                                  action: #selector(didSelectRightBarButtonItem))
    }
    
    
    
    @objc func didSelectRightBarButtonItem() {
        
    }
    
    @objc private func loadData() {
        perform(#selector(dismissRefresh), with: nil, afterDelay: 5)
    }
    
    @objc private func dismissRefresh() {
        tableView.mj_header.endRefreshing()
    }
    
    lazy var mainScroll : UIScrollView = {
        let object = UIScrollView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        object.bounces = false
        object.delegate = self
        object.backgroundColor = UIColor.cyan
        object.addSubview(self.tableView)
        return object
    }()

    
    
    lazy var tableView:UITableView = {
        let mainTable = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height - 49), style: UITableViewStyle.plain)
        mainTable.delegate = self;
        mainTable.dataSource = self;
        //mainTable.separatorStyle = .none
        mainTable.backgroundColor = UIColor.red
        mainTable.register(PersonUserTableViewCell.classForCoder(),
                           forCellReuseIdentifier: "userCell")
        mainTable.register(PersonMyTableViewCell.classForCoder(),
                           forCellReuseIdentifier: "myCells")
        mainTable.register(PersonTimeTableViewCell.classForCoder(),
                           forCellReuseIdentifier: "cellIdentifier")
        mainTable.mj_header = NSRefreshHeader{self.loadData()}
        
        return mainTable
    }()

}

extension MyViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let tempContentOffsetY = CGFloat(49)
        let tabOffsetY = scrollView.contentOffset.y
        print(tabOffsetY)
        if  tabOffsetY < tempContentOffsetY {
//            self.mainScroll.setContentOffset(CGPoint.zero, animated: false)
            
        }
        
    }
}


extension MyViewController: UITableViewDelegate,UITableViewDataSource, UIGestureRecognizerDelegate{
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
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "userCell",
                                                     for: indexPath) as! PersonUserTableViewCell
            return cell
            
        }

        if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "myCells",
                                                     for: indexPath) as! PersonMyTableViewCell
            cell.imageNamed = String(imgNamedArray[indexPath.row])
            cell.title = String(data[indexPath.row])
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier",
                                                 for: indexPath)
        
        return cell
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int{
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 96
        case 1:
            return 90
        case 2:
            return 56
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("点击了\(indexPath.section)区\(indexPath.row)行")
//        let vc = LoginViewController()
//// 主队列开启异步执行，防止present过慢，影响用户体验
//        DispatchQueue.main.async {
//            self.present(vc, animated: true, completion: nil)
//
//        }
        
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    
    
}
