//
//  NSRefreshHeader.swift
//  SwiftProject
//
//  Created by 牛新怀 on 2017/12/25.
//  Copyright © 2017年 牛新怀. All rights reserved.
//

import UIKit
import MJRefresh
class NSRefreshHeader: MJRefreshHeader  {

    override func prepare() {
        super.prepare()
        addSubview(loadingView)

    }
    
    override func placeSubviews() {
        super.placeSubviews()
        loadingView.center = CGPoint.init(x: self.mj_w/2, y: self.mj_h/2)

    }
    
    override var state: MJRefreshState {
        didSet {
            switch (state) {
            case .idle:
                loadingView.stopAnimation()
                break
            case .pulling:
                break
            case .refreshing:
                loadingView.startAnimation()
                break
            default:
                break
            }
        }
    }
    
    override func scrollViewContentOffsetDidChange(_ change: [AnyHashable : Any]!) {
        super.scrollViewContentOffsetDidChange(change)
        loadingView.alpha = ((self.scrollView.mj_offsetY * -1)-64)/54
    }
    
    lazy var loadingView : WCLLoadingView = {
        let object = WCLLoadingView.init(frame: CGRect.init(x: 0, y: 0, width: 40, height: 40))
        return object
    }()
}
