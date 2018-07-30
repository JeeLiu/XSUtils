//
//  ViewController.m
//  XSUtils
//
//  Created by jeeliu on 14/6/16.
//  Copyright © 2015年 jeeliu All rights reserved.
//

#import "ViewController.h"
#import "NSString+XSBirthday.h"
#import "XSCountDownControl.h"
#import "WaterView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    WaterView *water = [[WaterView alloc] initWithFrame:CGRectMake(50, 50, 100, 100)];
    water.percent = 0.5;
    water.isCircle = YES;
    water.waterColor = [UIColor greenColor];
    
    [self.view addSubview:water];
    
    NSLog(@"== %@",[NSString astroForBirthday:@"1988-08-29"]);
    
    
    [XSCountDownControl startCountingDown:60 block:^(NSInteger remain) {
        if (remain <= 0) {
            NSLog(@"重新获取");
        } else {
            NSLog(@"重新获取(%@)", @(remain));
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
