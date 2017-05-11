//
//  CountDownControl.h
//  XSUtils
//
//  Created by liuzhiliang on 2017/5/11.
//  Copyright © 2017年 yy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XSCountDownControl : NSObject

+ (void)startCountingDown:(NSInteger)time block:(void (^) (NSInteger remain))block;

@end
