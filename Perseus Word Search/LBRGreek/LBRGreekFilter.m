//
//  LBRGreekFilter.m
//  RocciConverter
//
//  Created by Claudio Capobianco on 11/02/13.
//  Copyright (c) 2013 Librum. All rights reserved.
//

#import "LBRGreekFilter.h"
#import "LBRGreekString.h"
#import "unicodeFontset.h"

@implementation LBRGreekFilter


//+ (NSComparisonResult)compare:(NSString *)string with:(NSString*)key range:(NSRange)range
//{
//    if ([string characterAtIndex:[string length]-1] == UNICODE_SIGMA_FINAL)
//    {
//        NSRange finalRange = NSMakeRange([string length]-1, 1);
//        NSString* sigmaString = [LBRGreekString stringByChar:UNICODE_SIGMA];
//        NSString* string2 = [string stringByReplacingCharactersInRange:finalRange withString:sigmaString];
//        return [string2 compare:key options:0 range:NSMakeRange(0, [key length])];
//    }
//    
//    return [string compare:key options:0 range:NSMakeRange(0, [key length])];
//}

//+(NSString*)trimFinalCharacter:(NSString*)string {
//    // remove last character
//    return [string substringToIndex:[string length]-2];
//}

+(NSMutableArray*)filterFinalSigmaWithArray:(NSArray*)array field:(NSString*)field withString:(NSString*)searchText {
    NSString* key = [searchText stringByAppendingString:[LBRGreekString stringByChar:UNICODE_SIGMA]];
    NSArray* filteredArray1 = [LBRGreekFilter filterArray:array field:(NSString*)field forKey:key checkFinalSigma:NO];
    key = [searchText stringByAppendingString:[LBRGreekString stringByChar:UNICODE_SIGMA_FINAL]];
    NSArray* filteredArray2 = [LBRGreekFilter filterArray:array field:(NSString*)field forKey:key checkFinalSigma:NO];
    
    // Refresh filtered array
    NSMutableArray* filteredArray = [NSMutableArray arrayWithArray:filteredArray1] ;
    [filteredArray addObjectsFromArray:filteredArray2];
    return filteredArray;
}

+(BOOL)hasFinalSigma:(NSString*)str {
    return ([str characterAtIndex:[str length]-1] == UNICODE_SIGMA_FINAL);
}

+(NSArray*)filterArray:(NSArray*)array field:(NSString*)field forKey:(NSString*)searchText checkFinalSigma:(BOOL)checkFinalSigma
{
    NSUInteger len = [searchText length];
    if (len == 0) {
        return nil;
    }
    
    NSMutableArray* filteredArray = [[NSMutableArray alloc] init];
	
    NSString* key = [LBRGreekString toPlain:searchText];
    
    BOOL checkSigmaEnabled = [LBRGreekFilter hasFinalSigma:searchText] && checkFinalSigma;
    if ( checkSigmaEnabled ) {
        // if search text has a final sigma, make a first filtering removing it
        key = [key substringToIndex:[key length]-1];
    }


    for (NSDictionary *word in array)
    {
        NSComparisonResult result;
        NSString* plainWord = [word objectForKey:field];
        //result = [LBRGreekFilter compare:plainWord with:key range:NSMakeRange(0, [key length])];
        result = [plainWord compare:key options:0 range:NSMakeRange(0, [key length])];
        if (result == NSOrderedSame) {
            [filteredArray addObject:word];
        }
    }
    
    // Now search all words that have a sigma or final sigma
    if ( checkSigmaEnabled ) {
        filteredArray = [LBRGreekFilter filterFinalSigmaWithArray:filteredArray field:field withString:key];
    }
    return filteredArray;
}

+(NSArray*)filterArray:(NSArray*)array field:(NSString*)field forKey:(NSString*)searchText
{    
    return [LBRGreekFilter filterArray:array field:field forKey:searchText checkFinalSigma:YES];
}
@end
