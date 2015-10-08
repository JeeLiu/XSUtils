//
//  NSString+XSBirthday.h
//  XSUtils
//
//  Created by jeeliu on 14/6/16.
//  Copyright © 2015年 jeeliu All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (XSBirthday)

//获取星座
// 例如 ：2010-01-09
+ (NSString *)astroForBirthday:(NSString *)birthday;

// 例如 ：2010-01-09
- (NSString *)astroString;

@end
