//
//  CountDownControl.m
//  XSUtils
//
//  Created by liuzhiliang on 2017/5/11.
//  Copyright © 2017年 yy. All rights reserved.
//

#import "XSCountDownControl.h"

@implementation XSCountDownControl

+ (void)startCountingDown:(NSInteger)time block:(void (^) (NSInteger remain))block {
    __block NSInteger timeout = 0;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(timer, ^{
        if (!block) {
            return;
        }
        
        NSInteger remain = time - timeout;
        
        if (remain <= 0) {
            dispatch_source_cancel(timer);
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            block(remain);
            timeout++;
        });
    });
    dispatch_resume(timer);
}

@end
