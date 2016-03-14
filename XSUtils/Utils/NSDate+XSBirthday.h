//
//  NSDate+XSBirthday.h
//  XSUtils
//
//  Created by jeeliu on 14/6/16.
//  Copyright © 2015年 jeeliu All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (XSBirthday)

//根据生日得到年龄
- (NSString *)ageForBirthday;

//根据生日得到星座
- (NSString *)constellationForBirthday;

//根据生日得到生肖
- (NSString *)zodiacForBirthday;

//得到生肖的算法
- (NSString *)getZodiacWithYear:(NSInteger)y;
//得到星座的算法
- (NSString *)getAstroWithMonth:(NSInteger)m day:(NSInteger)d;

// 农历
- (NSString*)chineseCalendar;

@end
