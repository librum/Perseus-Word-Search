//
//  LBRGreekString.h
//  VerbiGreci
//
//  Created by Claudio Capobianco on 10/04/12.
//  Copyright (c) 2012 Librum. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LBRGreekString : NSObject

+(void)initialize;

+(BOOL) isPlain:(NSString*)str;
+(NSString*) toPlain:(NSString*)str;

+(BOOL) isAsciiLetters:(NSString*)str;
+(NSString*) toAsciiLetters:(NSString*)str;

+(BOOL) isPolytonic:(NSString*)str;
+(BOOL) isPhilological:(NSString*)str;

+(NSString*)asciiLetters2plainGreek:(NSString*)str;
+(NSString*)ascii2greek:(NSString*)str;

// Utils
+(NSString*) stringByChar:(unichar)c;
// If a character ends with sigma, convert it to final sigma
+(NSString*)convertFinalSigma:(NSString*)str ;

// Changing case
+(NSString*)toUppercase:(NSString*)str;
+(NSString*)toLowercase:(NSString*)str;


// Boolean
+(BOOL)isUppercase:(NSString*) str;
+(BOOL)isLowercase:(NSString*) str;

// Sort
struct sortContext_s { BOOL reverseOrder; BOOL isUnicode;};
NSInteger LBRGreekStringSort(id str1, id str2, void *context);

@end

