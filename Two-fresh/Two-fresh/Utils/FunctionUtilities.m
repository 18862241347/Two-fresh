//
//  FunctionUtilities.m
//  GlobalUtil
//
//  Created by 谢传波 on 14-11-7.
//  Copyright (c) 2014年 Sage. All rights reserved.
//

#import "FunctionUtilities.h"
#import <AVFoundation/AVFoundation.h>

@implementation FunctionUtilities

//NSDictionary或NSArray转换为NSData
+(NSData *)toJSONData:(id)theData
{
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:theData options:NSJSONWritingPrettyPrinted error:&error];
    
    if ([jsonData length] > 0 && error == nil)
    {
        return jsonData;
    }
    else
    {
        return nil;
    }
    
}

//NSDictionary或NSArray转换为NSString
+(NSString *)toJSONString:(id)theData
{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:theData options:NSJSONWritingPrettyPrinted error:&error];
    
    if ([jsonData length] > 0 && error == nil)
    {
        NSString *jsonStr_ = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        return jsonStr_;
    }
    else
    {
        return nil;
    }
}
+(NSString *)JSONString:(NSString*)aString
{
    NSMutableString *s = [NSMutableString stringWithString:aString];
    [s replaceOccurrencesOfString:@"\"" withString:@"\\\"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"/" withString:@"\\/" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\n" withString:@"\\n" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\b" withString:@"\\b" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\f" withString:@"\\f" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\r" withString:@"\\r" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\t" withString:@"\\t" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    return [NSString stringWithString:s];
}

//formart时间戳格式("yyyy-MM-dd HH-mm-ss")
+(NSString *)dateStringWithDate:(NSDate *)date_ formart:(NSString *)formart
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formart];
    NSString *dataStr_ = [dateFormatter stringFromDate:date_];
    return dataStr_;
}
+(NSString*)currentTime
{
    NSDate *currentDate_ = [NSDate date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
    NSString *dataStr_ = [dateFormatter stringFromDate:currentDate_];
    
    return dataStr_;
}
//formart时间戳格式("yyyy-MM-dd HH-mm-ss")
+(NSDate *)dateWithNSString:(NSString*)string formart:(NSString *)formart
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formart];
    NSDate *date = [dateFormatter dateFromString:string];
    
    return date;
}

//根据日期计算几个月前的日期
+(NSDate *)dateOfPreviousMonth:(NSInteger)previousMonthCount WithDate:(NSDate *)fromDate
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *comps = nil;
    
    comps = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:fromDate];
    
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    
    [adcomps setYear:0];
    
    [adcomps setMonth:-previousMonthCount];
    
    [adcomps setDay:0];
    
    NSDate *resultDate_ = [calendar dateByAddingComponents:adcomps toDate:fromDate options:0];
    
    return resultDate_;
}

//DateStr格式(2014-05-23)
+ (XLDateCompareResult)compareDateWith:(NSString *)comparingDateStr withDate:(NSString *)standardDateStr
{
    NSString *comparingDateYearStr = [comparingDateStr substringWithRange:NSMakeRange(0, 4)];
    NSString *comparingDateMonthStr = [comparingDateStr substringWithRange:NSMakeRange(5, 2)];
    NSString *comparingDateDayStr = [comparingDateStr substringWithRange:NSMakeRange(8, 2)];
    
    NSString *standardDateYearStr = [standardDateStr substringWithRange:NSMakeRange(0, 4)];
    NSString *standardDateMonthStr = [standardDateStr substringWithRange:NSMakeRange(5, 2)];
    NSString *standardDateDayStr = [standardDateStr substringWithRange:NSMakeRange(8, 2)];
    
    XLDateCompareResult compareResult = XLDateOrderedSame;
    //年份比较
    if ([comparingDateYearStr intValue]<[standardDateYearStr intValue])
    {
        compareResult = XLDateOrderedAscending;
    }
    else if ([comparingDateYearStr intValue]>[standardDateYearStr intValue])
    {
        compareResult = XLDateOrderedDescending;
    }
    else
    {
        //年份相同，月比较
        if ([comparingDateMonthStr intValue]<[standardDateMonthStr intValue])
        {
            compareResult = XLDateOrderedAscending;
        }
        else if ([comparingDateMonthStr intValue]>[standardDateMonthStr intValue])
        {
            compareResult = XLDateOrderedDescending;
        }
        else
        {
            //年份相同，月相同，比较日期
            if ([comparingDateDayStr intValue]<[standardDateDayStr intValue])
            {
                compareResult = XLDateOrderedAscending;
            }
            else if ([comparingDateDayStr intValue]>[standardDateDayStr intValue])
            {
                compareResult = XLDateOrderedDescending;
            }
            
        }
        
    }
    
    return compareResult;
}

//TimeStr格式(12:23:43)
//comparingTimeStr是需要比较的时间参数,  standardTimeStr是作为比较标准的时间参数
+ (XLDateCompareResult)compareTimeWith:(NSString *)comparingTimeStr withTime:(NSString *)standardTimeStr
{
    
    XLDateCompareResult compareResult = XLDateOrderedSame;
    
    /*
    NSInteger comparingHourNum_ = [[comparingTimeStr substringToIndex:2] integerValue];
    NSInteger comparingMinuteNum_ = [[comparingTimeStr substringFromIndex:3] integerValue];
    
    NSInteger comparingSecondNum_ = [[comparingTimeStr substringFromIndex:3] integerValue];
    
    XLDateCompareResult compareResult = XLDateOrderedSame;
    
    NSString *timeStr_ = [dairyDetailDic_ objectForKey:@"time"];
    
    
    NSDate *addRecordDate_ = [dic objectForKey:@"time"];
    NSString *addRecordTimeStr_ = [FunctionUtilities dateStringWithDate:addRecordDate_ formart:@"HH:mm"];
    NSInteger addRecordHourNum_ = [[addRecordTimeStr_ substringToIndex:2] integerValue];
    NSInteger addRecordMinuteNum_ = [[addRecordTimeStr_ substringFromIndex:3] integerValue];
    
    if (addRecordHourNum_ < hourNum_)
    {
        NSMutableDictionary *dic_ = [NSMutableDictionary dictionary];
        [dic_ setObject:addRecordTimeStr_ forKey:@"time"];
        
        NSString *contextStr_ = [dic objectForKey:@"context"];
        [dic_ setObject:contextStr_ forKey:@"amount"];
        
        [dairyDetailData_ insertObject:dic_ atIndex:j];
        [dairyDic_ setObject:dairyDetailData_ forKey:@"item"];
        isInserted = YES;
        break;
    }
    else
    {
        if (addRecordMinuteNum_ < minuteNum_)
        {
            NSMutableDictionary *dic_ = [NSMutableDictionary dictionary];
            [dic_ setObject:addRecordTimeStr_ forKey:@"time"];
            
            NSString *contextStr_ = [dic objectForKey:@"context"];
            [dic_ setObject:contextStr_ forKey:@"amount"];
            
            [dairyDetailData_ insertObject:dic_ atIndex:j];
            [dairyDic_ setObject:dairyDetailData_ forKey:@"item"];
            isInserted = YES;
            break;
        }
    }
    */
    
    return compareResult;

}

//随机数字字符混合类型字符串函数
+(NSString *)getRandomString:(NSInteger)stringLength
{
    NSMutableString *randomString_ = [NSMutableString string];
    NSString *baseString_ = @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    for (int i=0; i<stringLength; i++)
    {
        NSInteger count_ = arc4random()%(baseString_.length);
        NSString *subStr_ = [baseString_ substringWithRange:NSMakeRange(count_, 1)];
        [randomString_ appendString:subStr_];
    }
    
    return randomString_;
    
    /*
    char data[stringLength];
    for (int x=0;x<stringLength;data[x++] = (char)('A' + (arc4random_uniform(26))));
    
    return [[NSString alloc] initWithBytes:data length:stringLength encoding:NSUTF8StringEncoding];
     */
    
}

//随机数字类型字符串函数
+(NSString *)getRandomNumberString:(NSInteger)stringLength
{
    NSMutableString *randomString_ = [NSMutableString string];
    NSString *baseString_ = @"0123456789";
    for (int i=0; i<stringLength; i++)
    {
        NSInteger count_ = arc4random()%(baseString_.length);
        NSString *subStr_ = [baseString_ substringWithRange:NSMakeRange(count_, 1)];
        [randomString_ appendString:subStr_];
    }
    
    return randomString_;
}

//随机字符类型字符串函数
+(NSString *)getRandomCharacterString:(NSInteger)stringLength
{
    NSMutableString *randomString_ = [NSMutableString string];
    NSString *baseString_ = @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
    for (int i=0; i<stringLength; i++)
    {
        NSInteger count_ = arc4random()%(baseString_.length);
        NSString *subStr_ = [baseString_ substringWithRange:NSMakeRange(count_, 1)];
        [randomString_ appendString:subStr_];
    }
    
    return randomString_;
}

//判断字符串是否是纯数字
+(BOOL)isPureNumber:(NSString *)string
{
    NSString *numberRegex = @"([0-9][0-9]*||[0-9][0-9]+)";
    NSPredicate *idCardNumberTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", numberRegex];
    
    BOOL isPureNum_ = [idCardNumberTest evaluateWithObject:string];
    
    return isPureNum_;
    
}

//date所在一周的日期
+(NSArray *)getDatesOfWeekWithDate:(NSDate *)date
{
    NSMutableArray *dateOfWeekArray_ = [NSMutableArray array];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *standardComp_ = [[NSCalendar currentCalendar] components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit fromDate:date];
    
    // 得到星期几
    // 1(星期天) 2(星期一) 3(星期二) 4(星期三) 5(星期四) 6(星期五) 7(星期六)
    NSInteger standardWeekDay = [standardComp_ weekday];
    NSInteger firstDiff = 0;
    if (standardWeekDay == 1)
    {
        firstDiff = 6;
    }
    else
    {
        firstDiff = standardWeekDay - 2;
    }
    
    //日期
    NSInteger standardDay_ = [standardComp_ day];
    
    NSDateComponents *dayComp = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSCalendarUnitHour fromDate:date];
    
    for (int i=0; i<7; i++)
    {
        [dayComp setDay:standardDay_ - firstDiff + i];
        NSDate *dateOfWeek= [calendar dateFromComponents:dayComp];
        NSString *dateOfWeekStr_ = [FunctionUtilities dateStringWithDate:dateOfWeek formart:@"yyyy-MM-dd"];
        [dateOfWeekArray_ addObject:dateOfWeekStr_];
    }
    
    return dateOfWeekArray_;
    
}

//date所在一个月的日期
+(NSArray *)getDatesOfMonthWithDate:(NSDate *)date
{
    NSMutableArray *dateOfMonthArray_ = [NSMutableArray array];
    
    //当前月的天数
    NSInteger daysOfMonth_ = [[NSCalendar currentCalendar] rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:date].length;
    
    for (int i=1; i <= daysOfMonth_; i++)
    {
        NSDateComponents *comps_ = [[NSCalendar currentCalendar] components:NSYearCalendarUnit | NSMonthCalendarUnit fromDate:date];
        [comps_ setDay:i];
        
        NSDate *dateOfMonth_ = [[NSCalendar currentCalendar] dateFromComponents:comps_];
        NSString *dateOfMonthStr_ = [FunctionUtilities dateStringWithDate:dateOfMonth_ formart:@"yyyy-MM-dd"];
        [dateOfMonthArray_ addObject:dateOfMonthStr_];
    }
    
    return dateOfMonthArray_;
    
}

//其实日期到结束日期间的所有日期
+(NSArray *)getDatesFromStartDate:(NSDate *)startDate_ ToEndDate:(NSDate *)endDate_
{
    NSMutableArray *datesArray_ = [NSMutableArray array];
    
    BOOL isContinue_ = YES;
    NSInteger addDay_ = 0;
    while (isContinue_)
    {
        NSDate *date_ = [NSDate dateWithTimeInterval:addDay_*24*60*60 sinceDate:startDate_];
        NSComparisonResult dateComparResult_ = [date_ compare:endDate_];
        if (dateComparResult_ == NSOrderedDescending)
        {
            isContinue_ = NO;
        }
        else
        {
            NSString *dateStr_ = [FunctionUtilities dateStringWithDate:date_ formart:@"yyyy-MM-dd"];
            [datesArray_ addObject:dateStr_];
            addDay_++;
        }
        
    }
    
    return datesArray_;
    
}

//获取wifi信号 method
+(NSString*) currentWifiSSID
{
    NSString *ssid = nil;
    NSArray *ifs = (__bridge  id)CNCopySupportedInterfaces();
    for (NSString *ifnam in ifs)
    {
        NSDictionary *info = (__bridge  id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
        ssid = [info objectForKey:@"SSID"];
        if (ssid)
            break;
    }
    
    
    return ssid;
    
}

//获取设备的UUID
+(NSString *)gen_uuid
{
    CFUUIDRef uuid_ref = CFUUIDCreate(NULL);
    CFStringRef uuid_string_ref= CFUUIDCreateString(NULL, uuid_ref);
    
    CFRelease(uuid_ref);
    NSString *uuid = [NSString stringWithString:(__bridge NSString*)uuid_string_ref];
    
    CFRelease(uuid_string_ref);
    return uuid;
}

//当Label的行数为1时，根据字符串长度动态改变UILabel的宽度
+(void)changeLabelWidth:(UILabel *)label_ withString:(NSString *)str_
{
    CGRect labelRect_ = label_.frame;
    UIFont *font = label_.font;
    CGSize size = CGSizeMake(MAXFLOAT,labelRect_.size.height);
    CGRect rect = [str_ boundingRectWithSize:size options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)  attributes:[NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName] context:nil];
    
    labelRect_.size.width = rect.size.width;
    label_.frame = labelRect_;
}

//当Label的宽度一定时，根据字符串长度动态改变UILabel的高度
+(void)changeLabelHeight:(UILabel *)label_ withString:(NSString *)str_
{
    label_.numberOfLines = 0;
    CGRect labelRect_ = label_.frame;
    UIFont *font = label_.font;
    NSDictionary *attributesDic_ = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];
    CGSize size = CGSizeMake(labelRect_.size.width, MAXFLOAT);
    CGRect rect = [str_ boundingRectWithSize:size options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)  attributes:attributesDic_ context:nil];
    
    labelRect_.size.height = rect.size.height;
    label_.frame = labelRect_;
}

//当Label的行数为1时，根据字符串长度动态改变UILabel的宽度
+(CGFloat)widthLabel:(UILabel *)label_ withString:(NSString *)str_
{
    
    CGRect labelRect_ = label_.frame;
    UIFont *font = label_.font;
    CGSize size = CGSizeMake(MAXFLOAT,labelRect_.size.height);
    CGRect rect = [str_ boundingRectWithSize:size options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)  attributes:[NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName] context:nil];
    
    return rect.size.width;
}

//当Label的宽度一定时，根据字符串长度动态改变UILabel的高度
+(CGFloat)heightLabel:(UILabel *)label_ withString:(NSString *)str_
{
    CGRect labelRect_ = label_.frame;
    UIFont *font = label_.font;
    CGSize size = CGSizeMake(labelRect_.size.width,MAXFLOAT);
    CGRect rect = [str_ boundingRectWithSize:size options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)  attributes:[NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName] context:nil];
    
    return rect.size.height;
}

//对图片尺寸进行压缩--
+ (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
    
}

//替换掉Json字符串中的换行符
+(NSString *)ReplacingNewLineAndWhitespaceCharactersFromJson:(NSString *)jsonStr_
{
    NSScanner *scanner = [[NSScanner alloc] initWithString:jsonStr_];
    [scanner setCharactersToBeSkipped:nil];
    NSMutableString *result = [[NSMutableString alloc] init];
    
    NSString *temp;
    NSCharacterSet*newLineAndWhitespaceCharacters = [ NSCharacterSet newlineCharacterSet];
    // 扫描
    while (![scanner isAtEnd])
    {
        temp = nil;
        [scanner scanUpToCharactersFromSet:newLineAndWhitespaceCharacters intoString:&temp];
        if (temp) [result appendString:temp];
        
        // 替换换行符
        if ([scanner scanCharactersFromSet:newLineAndWhitespaceCharacters intoString:NULL]) {
            if (result.length > 0 && ![scanner isAtEnd]) // Dont append space to beginning or end of result
                [result appendString:@"|"];
        }
    }
    return result;
}

//按照比例生成缩略图
+ (UIImage *)generatePhotoThumbnail:(UIImage *)image widthScale:(CGFloat)scale_w heightScale:(CGFloat)scale_h
{
    CGSize newSize = CGSizeMake(image.size.width*scale_w, image.size.height*scale_h);
    
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

//判断字符串是否为空
+ (BOOL)isBlankString:(NSString *)string
{
    if (string == nil || string == NULL)
    {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]])
    {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

//判断字符串是否为空
+ (BOOL)isBlankArray:(NSArray *)array
{
    if (array == nil || array == NULL)
    {
        return YES;
    }
    if ([array isKindOfClass:[NSNull class]])
    {
        return YES;
    }
    if ([array count] == 0)
    {
        return YES;
    }
    
    return NO;
}

//判断NSDictionary是否为空
+ (BOOL)isBlankDictionary:(NSDictionary *)dic
{
    if (dic == nil || dic == NULL)
    {
        return YES;
    }
    if ([dic isKindOfClass:[NSNull class]])
    {
        return YES;
    }
    if ([[dic allKeys] count] == 0)
    {
        return YES;
    }
    
    return NO;
}

/*MD5加密*/
+(NSString *)md5HexDigest:(NSString *)str
{
    const char *original_str = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, (int)strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
    {
        [hash appendFormat:@"%02X", result[i]];
    }
    NSString * mdfiveString = [hash lowercaseString];
    
//    NSLog(@"Encryption %@ Result = %@",str,mdfiveString);
    return mdfiveString;
}

/*
 +(long long) os_time
 {
 long long value_All ;
 
 NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
 [formatter setDateFormat:@"MM-dd-HH-mm-ss.SSS-HHMM"];
 NSString*locationString=[formatter stringFromDate: [NSDate date]];
 NSArray*timeArray=[locationString componentsSeparatedByString:@"-"];
 float value_D=   [[timeArray objectAtIndex:1]floatValue];
 float value_h=  [ [timeArray objectAtIndex:2]floatValue];
 float value_m= [ [timeArray objectAtIndex:3]floatValue];
 float value_s=  [ [timeArray objectAtIndex:4]floatValue];
 //时区偏移量。
 //float value_f=  [ [timeArray objectAtIndex:5]floatValue];
 value_All= (long long)((value_D*24*60*60+value_h*60*60+value_m*60+value_s)*1000);
 
 //value_All= (int)([[NSDate date] timeIntervalSince1970]);
 
 return  value_All ;
 }
 */

+ (BOOL)isCannontUseCamera {
    
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
        NSLog(@"相机权限受限");
        return YES;
    }
    return NO;
}
+ (CGSize)returnText:(NSString *)string font:(UIFont*)fsize weight:(CGFloat)weight
{
    
    NSString *value = string;
    NSString*Str=@"";
    
    if ((NSNull *)value == [NSNull null]) {
        Str=@"";
    }else
    {
        Str=string;
        
    }
    
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:fsize.pointSize]};
    CGSize size = [Str boundingRectWithSize:CGSizeMake(weight, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
    return size;
}
+(NSString *)readHtml5Data:(NSString *)htmlStr_
{
    
    NSString *htmlString_ = [NSString stringWithFormat:@"<html><head><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0, user-scalable=no\"><style>img{max-width: 100%@; width:auto; height:auto;}</style></head><body>%@</body></html>", @"%", htmlStr_];
    
    //    NSString *htmlString_ = [NSString stringWithFormat:@"<html><head><meta name=\"viewport\" content=\"width=device-width, user-scalable=yes\"></head><body>%@</body></html>", htmlStr_];
    
    return htmlString_;
    
}
+ (NSData*) base64Decode:(NSString *)string
{
    unsigned long ixtext, lentext;
    unsigned char ch, inbuf[4], outbuf[4];
    short i, ixinbuf;
    Boolean flignore, flendtext = false;
    const unsigned char *tempcstring;
    NSMutableData *theData;
    
    if (string == nil) {
        return [NSData data];
    }
    
    ixtext = 0;
    
    tempcstring = (const unsigned char *)[string UTF8String];
    
    lentext = [string length];
    
    theData = [NSMutableData dataWithCapacity: lentext];
    
    ixinbuf = 0;
    
    while (true) {
        if (ixtext >= lentext){
            break;
        }
        
        ch = tempcstring [ixtext++];
        
        flignore = false;
        
        if ((ch >= 'A') && (ch <= 'Z')) {
            ch = ch - 'A';
        } else if ((ch >= 'a') && (ch <= 'z')) {
            ch = ch - 'a' + 26;
        } else if ((ch >= '0') && (ch <= '9')) {
            ch = ch - '0' + 52;
        } else if (ch == '+') {
            ch = 62;
        } else if (ch == '=') {
            flendtext = true;
        } else if (ch == '/') {
            ch = 63;
        } else {
            flignore = true;
        }
        
        if (!flignore) {
            short ctcharsinbuf = 3;
            Boolean flbreak = false;
            
            if (flendtext) {
                if (ixinbuf == 0) {
                    break;
                }
                
                if ((ixinbuf == 1) || (ixinbuf == 2)) {
                    ctcharsinbuf = 1;
                } else {
                    ctcharsinbuf = 2;
                }
                
                ixinbuf = 3;
                
                flbreak = true;
            }
            
            inbuf [ixinbuf++] = ch;
            
            if (ixinbuf == 4) {
                ixinbuf = 0;
                
                outbuf[0] = (inbuf[0] << 2) | ((inbuf[1] & 0x30) >> 4);
                outbuf[1] = ((inbuf[1] & 0x0F) << 4) | ((inbuf[2] & 0x3C) >> 2);
                outbuf[2] = ((inbuf[2] & 0x03) << 6) | (inbuf[3] & 0x3F);
                
                for (i = 0; i < ctcharsinbuf; i++) {
                    [theData appendBytes: &outbuf[i] length: 1];
                }
            }
            
            if (flbreak) {
                break;
            }
        }
    }
    
    return theData;
}
+ (NSString*) base64Encode:(NSData *)data
{
    static char base64EncodingTable[64] = {
        'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P',
        'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f',
        'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v',
        'w', 'x', 'y', 'z', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '+', '/'
    };
    int length = [data length];
    unsigned long ixtext, lentext;
    long ctremaining;
    unsigned char input[3], output[4];
    short i, charsonline = 0, ctcopy;
    const unsigned char *raw;
    NSMutableString *result;
    
    lentext = [data length];
    if (lentext < 1)
        return @"";
    result = [NSMutableString stringWithCapacity: lentext];
    raw = [data bytes];
    ixtext = 0;
    
    while (true) {
        ctremaining = lentext - ixtext;
        if (ctremaining <= 0)
            break;
        for (i = 0; i < 3; i++) {
            unsigned long ix = ixtext + i;
            if (ix < lentext)
                input[i] = raw[ix];
            else
                input[i] = 0;
        }
        output[0] = (input[0] & 0xFC) >> 2;
        output[1] = ((input[0] & 0x03) << 4) | ((input[1] & 0xF0) >> 4);
        output[2] = ((input[1] & 0x0F) << 2) | ((input[2] & 0xC0) >> 6);
        output[3] = input[2] & 0x3F;
        ctcopy = 4;
        switch (ctremaining) {
            case 1:
                ctcopy = 2;
                break;
            case 2:
                ctcopy = 3;
                break;
        }
        
        for (i = 0; i < ctcopy; i++)
            [result appendString: [NSString stringWithFormat: @"%c", base64EncodingTable[output[i]]]];
        
        for (i = ctcopy; i < 4; i++)
            [result appendString: @"="];
        
        ixtext += 3;
        charsonline += 4;
        
        if ((length > 0) && (charsonline >= length))
            charsonline = 0;
    }
    return result;
}



@end


