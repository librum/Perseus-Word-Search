//
//  LBRGreekFormatter.m
//  Perseus Word Search
//
//  Created by Claudio Capobianco on 12/03/13.
//  Copyright (c) 2013 Librum. All rights reserved.
//

#import "LBRGreekFormatter.h"
#import "LBRGreekString.h"


@implementation LBRGreekFormatter

- (NSString *)stringForObjectValue:(id)anObject {
    
    if (![anObject isKindOfClass:[NSString class]]) {
        return nil;
    }
    NSString* greek = [LBRGreekString asciiLetters2plainGreek:anObject];
    greek = [LBRGreekString convertFinalSigma:greek];
    
    return [NSString stringWithFormat:@"%@", greek];
}

- (BOOL)getObjectValue:(id *)obj forString:(NSString *)string errorDescription:(NSString  **)error {
    
    BOOL returnValue = YES;
    
    *obj = [NSString stringWithString:string];
    return returnValue;
}

@end
