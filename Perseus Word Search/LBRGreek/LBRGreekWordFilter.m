//
//  LBRGreekWordFilter
//  VerbiGreciMacOSX
//
//  Created by Claudio Capobianco on 24/05/12.
//  Copyright (c) 2012 Librum. All rights reserved.
//

#import "LBRGreekWordFilter.h"

//FIXME TODO: make these arrays as a dynamic input

// FilterIn: leave words with these attributes
// FilterOut: remove words with these attributes
NSArray* posFilterInArray;

NSArray* lemmaFilterInArray;

NSArray* verbFilterInArray;

NSArray* featuresFilterInArray;
NSArray* featuresFilterOutArray;

NSArray* dialectsFilterInArray;
NSArray* dialectsFilterOutArray;

@implementation LBRGreekWordFilter

#pragma mark -
#pragma mark Initialize
+(void)initialize {
    posFilterInArray = [[NSArray alloc]initWithObjects:@"verb",@"part", nil];
    //lemmaFilterInArray = [[NSArray alloc]initWithObjects:@"ὁράω", nil];
    
    featuresFilterOutArray = [[NSArray alloc]initWithObjects:@"rare",@"apocope",@"late", nil];
    dialectsFilterOutArray = [[NSArray alloc]initWithObjects:@"poetic", nil];

}

#pragma mark -
#pragma mark Filter pos
+(BOOL) filterParticiple:(NSDictionary*) word {
    BOOL ret = true;
    NSString* pos = [word objectForKey:@"pos"];
    
    if ([pos isEqualToString:@"part"]) {
        ret = false;
        NSString* c = [word objectForKey:@"gcase"];
        NSString* number = [word objectForKey:@"number"];
        
        // select only nominative, singular
        if ([c isEqualToString:@"nom"] && [number isEqualToString:@"sg"]) {
            ret = true;
        }
    }
    return ret;
}

+(BOOL)  filterVerb:(NSDictionary*) word {
    BOOL ret = true;
    
//    NSString* pos = [word objectForKey:@"pos"];
//    if ([pos isEqualToString:@"verb"]) {
//        ret = false;
//        NSString* mood = [word objectForKey:@"mood"];
//        NSString* tense = [word objectForKey:@"tense"];
//        NSString* number = [word objectForKey:@"number"];
//        NSString* person = [word objectForKey:@"person"];
//        
//        if ([mood isEqualToString:@"ind"] && [tense isEqualToString:@"pres"]
//            && [number  isEqualToString:@"sg"] && [person  isEqualToString:@"1st"]) {
//            ret = true;
//        }
//    }
    return ret;
}

+(BOOL)  filterPos:(NSDictionary*) word {
    BOOL ret = true;
    if (posFilterInArray != nil) {
        ret = false;
        NSString* pos = [word objectForKey:@"pos"];
        if ([posFilterInArray containsObject:pos]) {
            if ([self filterVerb:word] && [self filterParticiple:word]) {
                ret = true;
            }
        }
    }
    return ret;
}

#pragma mark Filter lemma
+(BOOL)  filterLemma:(NSDictionary*) word {
    BOOL ret = true;
    if (lemmaFilterInArray != nil) {
        ret = false;
        NSString* lemma = [word objectForKey:@"lemma"];
        if ([lemmaFilterInArray containsObject:lemma]) {
            ret = true;
        }
    }
    return ret;
}

#pragma mark Filter form
+(BOOL)contains:(NSString*)subStr inString:(NSString*)str {
    BOOL retBool = false;
    if ([str rangeOfString:subStr].length > 0) {
        retBool = true;
    }
    return retBool;
}

//FIXME check these condition for validity
// Now we're removing all words with a strange form
+(BOOL)  filterForm:(NSDictionary*) word {
    BOOL ret = true;
    NSString* form = [word objectForKey:@"form"];
    
    if (([self contains:@"*" inString:form] == true)
        || ([self contains:@"'" inString:form] == true)
        || ([self contains:@"_" inString:form] == true)
        || ([self contains:@"^" inString:form] == true)
        || ([self contains:@"/" inString:form] == true)) {
        
        ret = false;
        
        /* Another possibility: select only form == lemma */
        /* NSString* lemma = [word objectForKey:@"lemma"];
           if ([form isEqualToString:@lemma])
           {
              ret = true;
           }*/
    }
    return ret;
}

#pragma mark More filters
+(BOOL)  filterDialect:(NSDictionary*) word {
    BOOL ret = true;
    
    if (dialectsFilterInArray != nil) {
        ret = false;
        NSMutableArray* dialects = [word objectForKey:@"dialects"];
        for (NSString* s in dialects) {
            if ([dialectsFilterInArray containsObject:s]) {
                ret = true;
            }
        }
    } else if (dialectsFilterOutArray != nil) {
        NSMutableArray* dialects = [word objectForKey:@"dialects"];
        for (NSString* s in dialects) {
            if ([dialectsFilterOutArray containsObject:s]) {
                ret = false;
            }
        }
    }

    //    if (ret == false) {
        //        if ([[dialects objectAtIndex:0] isEqualToString:@""]) {
        //            ret = true;
        //        }
        //    }
    
    return ret;
}

+(BOOL)  filterFeature:(NSDictionary*) word {
    BOOL ret = true;
    if (featuresFilterInArray != nil) {
        NSMutableArray* feature = [word objectForKey:@"features"];
        ret = false;
        for (NSString* s in feature) {
            if ([featuresFilterInArray containsObject:s]) {
                ret = true;
            }
        }
    } else if (featuresFilterOutArray != nil) {
        NSMutableArray* feature = [word objectForKey:@"features"];

        for (NSString* s in feature) {
            if ([featuresFilterOutArray containsObject:s]) {
                ret = false;
            }
        }
    }
    
    return ret;
}


#pragma mark -
#pragma mark Filter word
+(BOOL)  filterWord:(NSDictionary*) word {
    BOOL ret = false;
    
    if ([self filterPos:word]) {
        if ([self filterLemma:word ]) {
            if ([self filterForm:word] && [self filterDialect:word]
                && [self filterFeature:word]) {
                ret = true;
            }
        }
    }
    return ret;
}

@end
