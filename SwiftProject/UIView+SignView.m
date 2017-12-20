//
//  UIView+SignView.m
//  FFTableProject
//
//  Created by 牛新怀 on 2017/11/29.
//  Copyright © 2017年 牛新怀. All rights reserved.
//

#import "UIView+SignView.h"
#import <objc/runtime.h>
@implementation UIView (SignView)

- (void)ff_setCornerType:(UIRectCorner)cornerType
            cornerRadius:(CGFloat)radius{
    CGSize size = CGSizeMake(self.frame.size.width, radius);
    [self sign_cornerType:cornerType cornerSizeRadius:size];
}

- (void)ff_setCornerType:(UIRectCorner)cornerType
        cornerSizeRadius:(CGSize)resize{
    [self sign_cornerType:cornerType cornerSizeRadius:resize];
}

- (void)ff_setRoundedRect:(CGRect)rect
               CornerType:(UIRectCorner)cornerType
         cornerSizeRadius:(CGSize)resize{
    self.ff_bezierPath = [UIBezierPath bezierPathWithRoundedRect:rect
                                               byRoundingCorners:cornerType
                                                     cornerRadii:CGSizeMake(resize.width, resize.height)];
    self.ff_shapeLayer = [self get_shapeLayer];
    self.ff_shapeLayer.path = self.ff_bezierPath.CGPath;
    self.layer.mask = self.ff_shapeLayer;
}

- (void)sign_cornerType:(UIRectCorner)cornerType
       cornerSizeRadius:(CGSize)size{
    NSLog(@"width :%f   height : %f",self.frame.size.width,self.frame.size.height);
    self.ff_bezierPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)
                                               byRoundingCorners:cornerType
                                                     cornerRadii:CGSizeMake(size.width, size.height)];
    self.ff_shapeLayer = [self get_shapeLayer];
    self.ff_shapeLayer.path = self.ff_bezierPath.CGPath;
    self.layer.mask = self.ff_shapeLayer;
}

- (CAShapeLayer *)get_shapeLayer{
    CAShapeLayer * layers = [CAShapeLayer layer];
    layers.frame = self.bounds;
    return layers;
}

#pragma mark - Associated Object

- (void)setFf_shapeLayer:(id)object{
    objc_setAssociatedObject(self, @selector(ff_shapeLayer), object, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CAShapeLayer *)ff_shapeLayer{
    return objc_getAssociatedObject(self, @selector(ff_shapeLayer));
}

- (void)setFf_bezierPath:(id)object{
    objc_setAssociatedObject(self, @selector(ff_bezierPath), object, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIBezierPath *)ff_bezierPath{
    return objc_getAssociatedObject(self, @selector(ff_bezierPath));
}

@end
