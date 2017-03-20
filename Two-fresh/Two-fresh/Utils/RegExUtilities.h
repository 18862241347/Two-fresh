//
//  RegexUtilities.h
//  TaiPing
//
//  Created by evafan2003 on 12-1-9.
//  Copyright (c) 2012年 BBDTEK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RegexUtilities : NSObject
+ (BOOL)isValidateEmail:(NSString *) candidate;

+ (BOOL)isValidateIdCode:(NSString *) candidate;

+ (BOOL)isValidatePhone:(NSString *) candidate;

+ (BOOL)isValidateNmuber:(NSString *)candidate stratIndex:(NSInteger) start endIndex:(NSInteger)end;

+ (BOOL)isValidateNmuber:(NSString *)candidate length:(NSInteger) length;

+ (BOOL)isValidateKitLite:(NSString *)candidate;

//+ (NSDate *)makeBirthDate:(NSString *)birthDay;
//check the ID Card Number is valid or not
+ (BOOL)isValidateIDCardNumber:(NSString *)idCardNumber;
//check the birthday is valid or not
+ (BOOL)isValidateBirthDay:(NSString *)birthDay;
//check the AreaCode is valid or not 
+ (BOOL)isValidateAreaCode:(NSString *)areaCode;
//check the telePhone Number is valid or not
+ (BOOL)isValidateTelephoneNumber:(NSString *)telephoneNumber withAreaCode:(NSString *)areaCode;

+ (BOOL)isValidateTelephoneNumber:(NSString *)telephoneNumber;

+ (BOOL)isValidateFeiZi:(NSString *)candidate;
+ (BOOL)isZiMu:(NSString *)ziMu;
+ (BOOL)isZiMuHun:(NSString *)hanName;
+ (BOOL)isHanZi:(NSString *)hanName;
+ (BOOL)isBankAccount:(NSString *)bankAccount;
+ (BOOL)isRongAccount:(NSString *)bankAccount;
+ (BOOL)isValidateNumber:(NSString *)numberCode;

+ (BOOL)isShuZiAndDian:(NSString *)string;
@end
