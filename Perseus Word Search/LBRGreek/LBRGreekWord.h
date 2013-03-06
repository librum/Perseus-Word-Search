//
//  LBRGreekWord.h
//  VerbiGreci
//
//  Created by Claudio Capobianco on 07/04/12.
//  Copyright (c) 2012 Librum. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LBRGreekWord : NSObject

+(NSString*)getVerbMood:(NSDictionary*)word;

+(NSAttributedString*) analysis:(NSDictionary*)word;

+ (NSMutableDictionary*)addDialect:(NSString*)dialect toWord:(NSMutableDictionary*)word;
+ (NSMutableDictionary*)addFeature:(NSString*)feature toWord:(NSMutableDictionary*)word;

@end
