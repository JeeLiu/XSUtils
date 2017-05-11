//
//  XSCountDownButton.m
//  DM
//
//  Created by jeeliu on 15/8/26.
//  Copyright © 2015年 jeeliu. All rights reserved.
//

#import "XSCountDownButton.h"

@interface XSCountDownButton () {
    DidCountChangedBlock    _didChangedBlock;
    DidCountFinishedBlock   _didFinishedBlock;
    TouchUpInsideBlock      _touchedBlock;
}

@property (assign) int second;
@property (assign) int totalSecond;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) dispatch_source_t dispatch_timer;

@end

@implementation XSCountDownButton

#pragma mark - add handler

- (void)addToucheHandler:(TouchUpInsideBlock)touchHandler {
    _touchedBlock = [touchHandler copy];
    [self addTarget:self action:@selector(touched:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)touched:(XSCountDownButton*)sender{
    if (_touchedBlock) {
        _touchedBlock(sender,sender.tag);
    }
}

#pragma mark - gcd
#define WEAKSELF typeof(self) __weak weakSelf = self;
#define STRONGSELF typeof(weakSelf) __strong strongSelf = weakSelf;

- (void)startCountWithDispatchSecond:(int)second {
    self.totalSecond = second;
    self.second = second;
    
    WEAKSELF
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    self.dispatch_timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_dispatch_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_dispatch_timer, ^{
        STRONGSELF
        if( self.second <= 0 ){ //倒计时结束，关闭
            dispatch_source_cancel(_dispatch_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                self.enabled = YES;
                
                self.second = self.totalSecond;
                if (strongSelf->_didFinishedBlock) {
                    [self setTitle:strongSelf->_didFinishedBlock(self,_totalSecond)forState:UIControlStateNormal];
                } else  {
                    
                    [self setTitle:@"获取验证码" forState:UIControlStateNormal];
                }
            });
        } else {
            
            int seconds = self.second % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                
                self.enabled = NO;
                
                if (strongSelf->_didChangedBlock) {
                    [self setTitle:strongSelf->_didChangedBlock(self,seconds) forState:UIControlStateNormal];
                } else {
                    NSString *title = [NSString stringWithFormat:@"%d秒",_second];
                    [self setTitle:title forState:UIControlStateNormal];
                }
            });
            self.second--;
            
        }
    });
    dispatch_resume(_dispatch_timer);
}


#pragma mark - block

- (void)didChanged:(DidCountChangedBlock)didChangedBlock{
    _didChangedBlock = [didChangedBlock copy];
}

- (void)didFinished:(DidCountFinishedBlock)didFinishedBlock{
    _didFinishedBlock = [didFinishedBlock copy];
}

#pragma mark - countdown

- (void)startCountWithSecond:(int)second{
    self.totalSecond = second;
    self.second = second;
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerStartCountDown:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
}

-(void)timerStartCountDown:(NSTimer *)theTimer {
    if (_second == 1) {
        [self stopCount];
    } else {
        _second--;
        if (_didChangedBlock) {
            [self setTitle:_didChangedBlock(self,_second) forState:UIControlStateNormal];
        } else {
            NSString *title = [NSString stringWithFormat:@"%d秒",_second];
            [self setTitle:title forState:UIControlStateNormal];
        }
    }
}

- (void)stopCount{
    if (_timer) {
        if ([_timer respondsToSelector:@selector(isValid)]) {
            if ([_timer isValid]) {
                [_timer invalidate];
                _second = _totalSecond;
                if (_didFinishedBlock) {
                    [self setTitle:_didFinishedBlock(self,_totalSecond)forState:UIControlStateNormal];
                } else  {
                    [self setTitle:@"获取验证码" forState:UIControlStateNormal];
                }
            }
        }
    }
    
    if (_dispatch_timer) {
        dispatch_source_cancel(_dispatch_timer);
        self.dispatch_timer = nil;
        _second = _totalSecond;
        if (_didFinishedBlock) {
            [self setTitle:_didFinishedBlock(self,_totalSecond)forState:UIControlStateNormal];
        } else  {
            [self setTitle:@"获取验证码" forState:UIControlStateNormal];
        }
    }
}

@end
