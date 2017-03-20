//
//  RegexUtilities.m
//  TaiPing
//
//  Created by evafan2003 on 12-1-9.
//  Copyright (c) 2012年 BBDTEK. All rights reserved.
//

#import "RegexUtilities.h"

@implementation RegexUtilities

+ (BOOL)isValidateEmail:(NSString *) candidate {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"; 
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex]; 
	
    return [emailTest evaluateWithObject:candidate];
}

+ (BOOL)isValidateIdCode:(NSString *) candidate {
    NSString *idCodeRegex = @"((1[1-5])|(2[1-3])|(3[1-7])|(4[1-6])| (5[0-4])|(6[1-5])|71|(8[12])|91)\\d{4}"; 
    NSPredicate *idCodeTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", idCodeRegex]; 
	
    return [idCodeTest evaluateWithObject:candidate];
}

//手机号码校验
+ (BOOL)isValidatePhone:(NSString *) candidate {
//    NSString *phoneRegex = @"(13[0-9]|15[0|3|6|7|8|9]|18[2|3|6|7|8|9])\\d{8}"; 
//    NSString *phoneRegex=@"(\\d{11,11})";
    NSString *phoneRegex=@"(13[0-9]|14[0-9]|15[0-9]|18[0-9])\\d{8}";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
	
    return [phoneTest evaluateWithObject:candidate];
}

+ (BOOL)isValidateNmuber:(NSString *)candidate stratIndex:(NSInteger) start endIndex:(NSInteger)end

{
//    NSString *numberRegex = @"\\w{6,16}";
    NSString *numberRegex =[NSString stringWithFormat:@"\\w{%ld,%ld}",(long)start,(long)end];
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", numberRegex];
    return [emailTest evaluateWithObject:candidate];
    
    
    }

//chek the post code number is valid or not
+ (BOOL)isValidateNmuber:(NSString *)candidate length:(NSInteger) length

{
    //    NSString *numberRegex = @"\\w{6,16}";
    NSString *numberRegex =[NSString stringWithFormat:@"\\d{%ld}",(long)length];
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", numberRegex];
    return [emailTest evaluateWithObject:candidate];
    
    
}

+ (BOOL)isValidateKitLite:(NSString *)candidate{
    
//    @"//^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$//"   15位
//    @"//^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{4}$//"  18位
//    
//    
//    信用卡:
//    @"(5[1–5]\\d{14})|(4\\d{12}(\\d{3})?)|(3[47]\\d{13})|(6011\\d{14})"
    NSString *phoneRegex = @"(\\d{18,18}|\\d{15,15}|\\d{17,17}x)"; 
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex]; 
	
    return [phoneTest evaluateWithObject:candidate];

}

//+ (NSDate *)makeBirthDate:(NSString *)birthDay{
//	NSDateFormatter *df = [[NSDateFormatter alloc] init];
//	[df setDateFormat:@"yyyy-MM-dd"];
//	NSLocale *locale = 
//    [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
//	[df setLocale:locale];	
//	NSDate *date = [df dateFromString: birthDay];
//    [df release],[locale release];
//	return date;
//}

//check the ID Card Number is valid or not
+ (BOOL)isValidateIDCardNumber:(NSString *)idCardNumber{
    NSString *idCardNumberRegex = @"(\\d{18,18}|\\d{15,15}|\\d{17,17}x)"; 
    NSPredicate *idCardNumberTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", idCardNumberRegex]; 
    return [idCardNumberTest evaluateWithObject:idCardNumber];
}
#pragma mark --isValidateBirthDay  Uncomplete  
//check the birthday is valid or not
+ (BOOL)isValidateBirthDay:(NSString *)birthDay{
    NSRange yearRange=NSMakeRange(0, 4);
    NSRange monthRange=NSMakeRange(4, 2);
    NSRange dayRange=NSMakeRange(6, 2);
    
    NSString *year=[birthDay substringWithRange:yearRange];
    NSString *month=[birthDay substringWithRange:monthRange];
    NSString *day=[birthDay substringWithRange:dayRange];
    
    NSString *newBirthDay=[NSString stringWithFormat:@"%@-%@-%@",year,month,day];
    NSString *birthDayRegex=@"(([0-9]{3}[1-9]|[0-9]{2}[1-9][0-9]{1}|[0-9]{1}[1-9][0-9]{2}|[1-9][0-9]{3})-(((0[13578]|1[02])-(0[1-9]|[12][0-9]|3[01]))|((0[469]|11)-(0[1-9]|[12][0-9]|30))|(02-(0[1-9]|[1][0-9]|2[0-8]))))|((([0-9]{2})(0[48]|[2468][048]|[13579][26])|((0[48]|[2468][048]|[3579][26])00))-02-29)";
    NSPredicate *birthDayTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", birthDayRegex]; 
    return [birthDayTest evaluateWithObject:newBirthDay];
}
//check the AreaCode is valid or not 
+ (BOOL)isValidateAreaCode:(NSString *)areaCode{
//TO do something
    NSString *idCardNumberRegex = @"(\\d{3,3}|\\d{4,4})"; 
    NSPredicate *idCardNumberTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", idCardNumberRegex]; 
    return [idCardNumberTest evaluateWithObject:areaCode];
}

//check is number
+ (BOOL)isValidateNumber:(NSString *)numberCode{
    //TO do something
    NSString *numberRegex = @"([1-9][0-9]*||[0-9][0-9]+)"; 
    NSPredicate *idCardNumberTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", numberRegex]; 
    return [idCardNumberTest evaluateWithObject:numberCode];
}
//check the telePhone Number is valid or not
+ (BOOL)isValidateTelephoneNumber:(NSString *)telephoneNumber withAreaCode:(NSString *)areaCode{
//to do something
    
    NSString * fullTelephoneNumber=[NSString stringWithFormat:@"%@-%@",areaCode,telephoneNumber];
     NSString *telePhoneNumberRegex=@"(\\d{3,3}-(\\d{7,7}||\\d{8,8}||\\d{9,9}||\\d{10,10}||\\d{11,11}||\\d{12,12}||\\d{13,13})||\\d{4,4}-(\\d{7,7}||\\d{8,8}||\\d{9,9}||\\d{10,10}||\\d{11,11}||\\d{12,12}||\\d{13,13}))";
     NSPredicate *telePhoneNumberTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", telePhoneNumberRegex]; 
    return [telePhoneNumberTest evaluateWithObject:fullTelephoneNumber];
}
+ (BOOL)isValidateTelephoneNumber:(NSString *)telephoneNumber{
    //电话号码正则表达式（支持手机号码，3-4位区号，7-8位直播号码，1－4位分机号）
    NSString *teleRegr1 = @"((\\d{11})|^((\\d{7,8})|(\\d{4}|\\d{3})-(\\d{7,8})|(\\d{4}|\\d{3})-(\\d{7,8})-(\\d{4}|\\d{3}|\\d{2}|\\d{1})|(\\d{7,8})-(\\d{4}|\\d{3}|\\d{2}|\\d{1}))$)";
//    NSString *teleRegr2 = @"((\\d{11})|^((\\d{7,8})|(\\d{4}|\\d{3})-(\\d{7,8})|(\\d{4}|\\d{3})-(\\d{7,8})-(\\d{4}|\\d{3}|\\d{2}|\\d{1})|(\\d{7,8})-(\\d{4}|\\d{3}|\\d{2}|\\d{1}))$)";
//    NSArray *tele = [telephoneNumber componentsSeparatedByString:NSLocalizedString(@"-", nil)];
//    if (tele.count == 2) {
        NSPredicate *telePhoneNumberTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", teleRegr1];
        return [telePhoneNumberTest evaluateWithObject:telephoneNumber];
//    }
//    if (tele.count == 3) {
//        NSPredicate *telePhoneNumberTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", teleRegr2];
//        return [telePhoneNumberTest evaluateWithObject:telephoneNumber];
//    }
    return  NO;
}
+ (BOOL)isValidateFeiZi:(NSString *)candidate{
    NSString *idCardNumberRegex = @"([a-zA-Z\\d\\u4e00-\\u9fa5]+)";
//    DLog(@"candidate:%@",candidate);
    NSPredicate *idCardNumberTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", idCardNumberRegex];
//    DLog(@"**** :%d",[idCardNumberTest evaluateWithObject:candidate]);
    return [idCardNumberTest evaluateWithObject:candidate];
}
+ (BOOL)isZiMu:(NSString *)ziMu{
    NSString *nameZi = @"([A-Za-z]+)";
    NSPredicate *nameMu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", nameZi];
    return [nameMu evaluateWithObject:ziMu];
}
+ (BOOL)isZiMuHun:(NSString *)hanName{
    NSString *chinaName =@"(^[\\u4e00-\\u9fa5][A-Za-z]+||[A-Za-z]+[\\u4e00-\\u9fa5]$||[\\u4e00-\\u9fa5]{2,2}[A-Za-z]+||[\\u4e00-\\u9fa5][A-Za-z]*[\\u4e00-\\u9fa5][A-Za-z]*||[A-Za-z]+[\\u4e00-\\u9fa5][A-Za-z]+[\\u4e00-\\u9fa5][A-Za-z]+)";
    NSPredicate *nameString = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",chinaName];
    return ([nameString evaluateWithObject:hanName]);
}

+ (BOOL)isHanZi:(NSString *)hanName
{
    NSLog(@"hanName :%@",hanName);
    NSString *chinaName =@"([\\u4e00-\\u9fa5]+)";
    NSPredicate *nameString = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",chinaName];
    NSLog(@"%d",[nameString evaluateWithObject:hanName]);
    return ([nameString evaluateWithObject:hanName]);
}
//判断帐号
+ (BOOL)isBankAccount:(NSString *)bankAccount{
    
    NSString *bank = @"(\\d{21}||\\d{20}||\\d{19}||\\d{18}||\\d{17}||\\d{16}||\\d{15}||\\d{14})||\\d{13}||\\d{12}";
    NSPredicate *bankString = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",bank];
    return ([bankString evaluateWithObject:bankAccount]);
}
+ (BOOL)isRongAccount:(NSString *)bankAccount{
    NSString *bank = @"(\\d{20}||\\d{19}||\\d{18}||\\d{17}||\\d{16})";
    NSPredicate *bankString = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",bank];
    return ([bankString evaluateWithObject:bankAccount]);
}

//职能出入数字和点号
+ (BOOL)isShuZiAndDian:(NSString *)string{
    NSString *moneyRegex = @"([0-9.]+)"; 
    NSPredicate *moneyTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", moneyRegex]; 
    
    return [moneyTest evaluateWithObject:string];
    
}


@end
