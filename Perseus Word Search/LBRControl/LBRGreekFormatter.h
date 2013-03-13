//
//  LBRGreekFormatter.h
//  Perseus Word Search
//
//  Created by Claudio Capobianco on 12/03/13.
//  Copyright (c) 2013 Librum. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LBRGreekFormatter : NSFormatter
- (NSString *)stringForObjectValue:(id)anObject;
- (BOOL)getObjectValue:(id *)anObject forString:(NSString *)string errorDescription:(NSString **)error;
@end
