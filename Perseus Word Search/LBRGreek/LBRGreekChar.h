//
//  LBRGreekChar.h
//  VerbiGreci
//
//  Created by Claudio Capobianco on 12/04/12.
//  Copyright (c) 2012 Librum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LBRGreekTypes.h"
#import "fontsetSortOrder.h"

@interface LBRGreekChar : NSObject

+(void)initialize;

// Compose
+(unichar)composeCharFromLetter:(unichar)plainLetter withSign:(LBRLetterSign)sign;
// Decompose
+(void)decomposeChar:(unichar)signChar toLetter:(unichar*)plainLetter toSign:(LBRLetterSign*)sign;

// Descriptions
+(NSString*)getLetterDescriptionByChar:(unichar)c;
+(NSString*)getLetterDescriptionByStr:(NSString*)str;
+(NSString*)getSignDescriptionBySign:(LBRLetterSign)sign;

// Boolean
+(BOOL)isGreekChar:(unichar)c;
+(BOOL)isPlain:(unichar)c;
+(BOOL)hasVariants:(unichar)c;
/* STUBS
 +(BOOL)isAlphaVariant:(unichar)c;
 +(BOOL)isEpsilonVariant:(unichar)c;
 +(BOOL)isEtaVariant:(unichar)c;
 +(BOOL)isIotaVariant:(unichar)c;
 +(BOOL)isOmicronVariant:(unichar)c;
 +(BOOL)isUpsilonVariant:(unichar)c;
 +(BOOL)isOmegaVariant:(unichar)c;
 +(BOOL)isRhoVariant:(unichar)c;
 */

// Conversion
+(unichar)toPlain:(unichar)c;

+(unichar)toUpperCase:(unichar)c;
+(unichar)toLowerCase:(unichar)c;

+(enum fontsetSortOrder) sortOrder:(unichar)c;

+(BOOL)isPhilological:(unichar)c;
+(BOOL)isPolytonic:(unichar)c;

+(unichar)asciiLetter2plainGreek:(unichar)c;




@end
