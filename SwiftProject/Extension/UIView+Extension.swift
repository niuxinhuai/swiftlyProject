//
//  UIView+Extension.swift
//  Durian
//
//  Created by 牛新怀 on 2018/2/10.
//  Copyright © 2018年 ZhiMiABC. All rights reserved.
//

import Foundation

struct RuntimeKey {
    static let zm_playgroundKey = UnsafeRawPointer.init(bitPattern: "zm_playgroundKey".hashValue)
    static let zm_animatorKey = UnsafeRawPointer.init(bitPattern: "zm_animatorKey".hashValue)
    static let zm_snapBehavior = UnsafeRawPointer.init(bitPattern: "zm_snapBehaviorKey".hashValue)
    static let zm_attachmentBehavior = UnsafeRawPointer.init(bitPattern: "zm_attachmentBehaviorKey".hashValue)
    static let zm_panGesture = UnsafeRawPointer.init(bitPattern: "zm_panGestureKey".hashValue)
    static let zm_centerPoint = UnsafeRawPointer.init(bitPattern: "zm_centerPointKey".hashValue)
    static let zm_damping = UnsafeRawPointer.init(bitPattern: "zm_dampingKey".hashValue)
}
extension UIView {
    func signleDragable() -> Void {
        signleDraggableInView(view: self.superview, damping: CGFloat(0.4))
    }
    
    func signleDraggableInView(view: UIView!, damping: CGFloat) -> Void {
        if (view) != nil {
            removeAllDraggable()
            zm_playground = view
            zm_damping = damping
            signleAnimator()
            signleAddPanGesture()
        }
    }
    
    private func removeAllDraggable() -> Void {
        if (zm_panGesture) != nil {
            self.removeGestureRecognizer(zm_panGesture!)
        }
        zm_panGesture = nil
        zm_playground = nil
        zm_animator = nil
        zm_snapBehavior = nil
        zm_attachmentBehavior = nil
        zm_centerPoint = CGPoint.zero
    }
    
    private func signleAnimator() -> Void {
        zm_animator = UIDynamicAnimator.init(referenceView: zm_playground!)
        signleUpdateSnapPoint()
    }
    
    private func signleUpdateSnapPoint() -> Void {
        zm_centerPoint = self.convert(CGPoint.init(x: self.bounds.size.width/2, y: self.bounds.size.height/2), to: zm_playground!)
        zm_snapBehavior = UISnapBehavior.init(item: self, snapTo: zm_centerPoint!)
        zm_snapBehavior?.damping = zm_damping!
    }
    
    private func signleAddPanGesture() -> Void {
        zm_panGesture = UIPanGestureRecognizer.init(target: self, action: #selector(signlePanGesture(pan:)))
        self.addGestureRecognizer(zm_panGesture!)
    }
    
    @objc func signlePanGesture(pan: UIPanGestureRecognizer) -> Void {
        let panLocation = pan.location(in: zm_playground)
        if pan.state == .began {
            signleUpdateSnapPoint()
            let offSet = UIOffsetMake(panLocation.x - (zm_centerPoint?.x)!, panLocation.y - (zm_centerPoint?.y)!)
            zm_animator?.removeAllBehaviors()
            zm_attachmentBehavior = UIAttachmentBehavior.init(item: self, offsetFromCenter: offSet, attachedToAnchor: panLocation)
            zm_animator?.addBehavior(zm_attachmentBehavior!)
        } else if pan.state == .changed {
            zm_attachmentBehavior?.anchorPoint = panLocation
        } else if (pan.state == .ended) || (pan.state == .cancelled) || (pan.state == .failed) {
            zm_animator?.addBehavior(zm_snapBehavior!)
            zm_animator?.removeBehavior(zm_attachmentBehavior!)
        }
    }

    private var zm_playground: UIView? {
        set{
            objc_setAssociatedObject(self, RuntimeKey.zm_playgroundKey!, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get{
            return objc_getAssociatedObject(self, RuntimeKey.zm_playgroundKey!) as? UIView
        }
    }
    
    private var zm_animator: UIDynamicAnimator? {
        set{
            objc_setAssociatedObject(self, RuntimeKey.zm_animatorKey!, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get{
            return objc_getAssociatedObject(self, RuntimeKey.zm_animatorKey!) as? UIDynamicAnimator
        }
    }
    
    private var zm_snapBehavior: UISnapBehavior? {
        set{
            objc_setAssociatedObject(self, RuntimeKey.zm_snapBehavior!, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get{
            return objc_getAssociatedObject(self, RuntimeKey.zm_snapBehavior!) as? UISnapBehavior
        }
    }
    
    private var zm_attachmentBehavior: UIAttachmentBehavior? {
        set{
            objc_setAssociatedObject(self, RuntimeKey.zm_attachmentBehavior!, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get{
            return objc_getAssociatedObject(self, RuntimeKey.zm_attachmentBehavior!) as? UIAttachmentBehavior
        }
    }
    
    private var zm_panGesture: UIPanGestureRecognizer? {
        set{
            objc_setAssociatedObject(self, RuntimeKey.zm_panGesture!, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get{
            return objc_getAssociatedObject(self, RuntimeKey.zm_panGesture!) as? UIPanGestureRecognizer
        }
    }
    
    private var zm_centerPoint: CGPoint? {
        set{
            objc_setAssociatedObject(self, RuntimeKey.zm_centerPoint!, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get{
            return objc_getAssociatedObject(self, RuntimeKey.zm_centerPoint!) as? CGPoint
        }
    }
    
    private var zm_damping: CGFloat? {
        set{
            objc_setAssociatedObject(self, RuntimeKey.zm_damping!, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get{
            return objc_getAssociatedObject(self, RuntimeKey.zm_damping!) as? CGFloat
        }
    }
}
