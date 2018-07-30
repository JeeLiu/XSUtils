//
//  WaterView.h
//  Test--OC
//
//  Created by Input on 2017/12/20.
//  Copyright © 2017年 Input. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WaterView : UIView
@property (nonatomic, assign) IBInspectable CGFloat percent;
@property (nonatomic, assign) IBInspectable BOOL isCircle;
@property (nonatomic, strong) IBInspectable UIColor *waterColor;
@end
