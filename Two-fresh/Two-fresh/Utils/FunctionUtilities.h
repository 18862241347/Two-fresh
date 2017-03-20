//
//  FunctionUtilities.h
//  GlobalUtil
//
//  Created by 谢传波 on 14-11-7.
//  Copyright (c) 2014年 Sage. All rights reserved.
//

//功能操作


//日期(年、月、日)比较大小
typedef enum
{
    XLDateOrderedAscending = -1,  //前者比后者小
    XLDateOrderedSame = 0,  //前者与后者相等
    XLDateOrderedDescending = 1,  //前者比后者大
}XLDateCompareResult;

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <SystemConfiguration/CaptiveNetwork.h>
#import <CommonCrypto/CommonDigest.h>

@interface FunctionUtilities : NSObject

//NSDictionary或NSArray转换为NSData
+(NSData *)toJSONData:(id)theData;
//NSDictionary或NSArray转换为NSString
+(NSString *)toJSONString:(id)theData;
//把NSString转化成jsonStr
+(NSString *)JSONString:(NSString*)aString;
//获取某个时间字符串
//当前时间的之间戳("yyyyMMddHHmmss")
+(NSString*)currentTime;
//formart时间戳格式("yyyy-MM-dd HH-mm-ss")
+(NSString *)dateStringWithDate:(NSDate *)date_ formart:(NSString *)formart;
//时间戳转化为NSDate
//formart时间戳格式("yyyy-MM-dd HH-mm-ss")
+(NSDate *)dateWithNSString:(NSString*)string formart:(NSString *)formart;
//根据日期计算N个月前的日期
+(NSDate *)dateOfPreviousMonth:(NSInteger)previousMonthCount WithDate:(NSDate *)fromDate;

//日期对比, 判断是否过期等等

//DateStr格式(2014-05-23)
//comparingDateStr是需要比较的时间参数,  standardDateStr是作为比较标准的时间参数
+ (XLDateCompareResult)compareDateWith:(NSString *)comparingDateStr withDate:(NSString *)standardDateStr;

//TimeStr格式(12:23:43)
//comparingTimeStr是需要比较的时间参数,  standardTimeStr是作为比较标准的时间参数
+ (XLDateCompareResult)compareTimeWith:(NSString *)comparingTimeStr withTime:(NSString *)standardTimeStr;

//获取长度为stringLength的随机字符串,
//随机数字字符混合类型字符串函数
+(NSString *)getRandomString:(NSInteger)stringLength;
//随机数字类型字符串函数
+(NSString *)getRandomNumberString:(NSInteger)stringLength;
//随机字符类型字符串函数
+(NSString *)getRandomCharacterString:(NSInteger)stringLength;
//判断字符串是否是纯数字
+(BOOL)isPureNumber:(NSString *)string;

//date所在一周的日期
+(NSArray *)getDatesOfWeekWithDate:(NSDate *)date;
//date所在一个月的日期
+(NSArray *)getDatesOfMonthWithDate:(NSDate *)date;
//其实日期到结束日期间的所有日期
+(NSArray *)getDatesFromStartDate:(NSDate *)startDate_ ToEndDate:(NSDate *)endDate_;


//获取wifi信号 method
+(NSString*) currentWifiSSID;
//获取设备的UUID
+(NSString *)gen_uuid;

//当Label的行数为1时，根据字符串长度动态改变UILabel的宽度
+(void)changeLabelWidth:(UILabel *)label_ withString:(NSString *)str_;
//当Label的宽度一定时，根据字符串长度动态改变UILabel的高度
+(void)changeLabelHeight:(UILabel *)label_ withString:(NSString *)str_;

//当Label的行数为1时，根据字符串长度动态改变UILabel的宽度
+(CGFloat)widthLabel:(UILabel *)label_ withString:(NSString *)str_;

//当Label的宽度一定时，根据字符串长度动态改变UILabel的高度
+(CGFloat)heightLabel:(UILabel *)label_ withString:(NSString *)str_;

//对图片尺寸进行压缩--
+ (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;

//替换掉Json字符串中的换行符
+(NSString *)ReplacingNewLineAndWhitespaceCharactersFromJson:(NSString *)jsonStr_;

//按照比例生成缩略图
+ (UIImage *)generatePhotoThumbnail:(UIImage *)image widthScale:(CGFloat)scale_w heightScale:(CGFloat)scale_h;

//判断字符串是否为空
+ (BOOL)isBlankString:(NSString *)string;

//判断数组是否为空
+ (BOOL)isBlankArray:(NSArray *)array;

//判断NSDictionary是否为空
+ (BOOL)isBlankDictionary:(NSDictionary *)dic;

/*MD5加密*/
+(NSString *)md5HexDigest:(NSString *)str;

//+(long long) os_time;

/**
 *  获取相机权限
 */
+ (BOOL)isCannontUseCamera;

/**
 计算文本所占大小
 */
+ (CGSize)returnText:(NSString *)string font:(UIFont*)fsize weight:(CGFloat)weight;

///  根据返回的html格式的标签字符串生成可用的字符串
+(NSString *)readHtml5Data:(NSString *)htmlStr_;


/// data转base64
+ (NSString*) base64Encode:(NSData *)data;

/// string转Data
+ (NSData*) base64Decode:(NSString *)string;


/// 设置倒计时
+(void)setTimeout:(int)timeout_ countDownLabel:(UILabel*)countDownLabel;
@end
