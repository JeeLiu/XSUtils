//
//  XSCountDownButton.h
//  DM
//
//  Created by jeeliu on 15/8/26.
//  Copyright © 2015年 jeeliu. All rights reserved.
//

#import <UIKit/UIKit.h>


//UIButton type要 设置成UIButtonTypeCustom 否则会闪动

@class XSCountDownButton;

typedef NSString* (^DidCountChangedBlock)(XSCountDownButton *countDownButton,int second);
typedef NSString* (^DidCountFinishedBlock)(XSCountDownButton *countDownButton,int second);

typedef void (^TouchUpInsideBlock)(XSCountDownButton *countDownButton,NSInteger tag);

@interface XSCountDownButton : UIButton

- (void)addToucheHandler:(TouchUpInsideBlock)touchHandler;

- (void)didChanged:(DidCountChangedBlock)didChangedBlock;
- (void)didFinished:(DidCountFinishedBlock)didFinishedBlock;

- (void)startCountWithDispatchSecond:(int)second;
- (void)startCountWithSecond:(int)second;
- (void)stopCount;

@end
