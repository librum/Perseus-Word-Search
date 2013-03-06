//
//  LBRGreekCharset.h
//  RocciConverter
//
//  Created by Claudio Capobianco on 30/01/13.
//  Copyright (c) 2013 Librum. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LBRGreekCharset : NSObject

+(NSCharacterSet*)createAlphaVariantCharSet;
+(NSCharacterSet*)createEpsilonVariantCharSet;
+(NSCharacterSet*)createEtaVariantCharSet;
+(NSCharacterSet*)createIotaVariantCharSet;
+(NSCharacterSet*)createOmicronVariantCharSet;
+(NSCharacterSet*)createUpsilonVariantCharSet;
+(NSCharacterSet*)createOmegaVariantCharSet;
+(NSCharacterSet*)createRhoVariantCharSet;

+(NSCharacterSet*)createPlainGreekCharSet;
//+(NSCharacterSet*)createPolytonicGreekCharSet;
//+(NSCharacterSet*)createPhilologicalGreekCharSet;
+(NSCharacterSet*)createAsciiLetterGreekCharSet;

@end
