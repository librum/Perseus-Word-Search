//
//  LBRGreekWord.m
//  VerbiGreci
//
//  Created by Claudio Capobianco on 07/04/12.
//  Copyright (c) 2012 Librum. All rights reserved.
//

#import "LBRGreekWord.h"

//NSDictionary* translationDictionary = nil;
NSDictionary* lemmaText = nil;
NSDictionary* formText = nil;
NSDictionary* titleText = nil;
NSDictionary* bodyText = nil;


@implementation LBRGreekWord

#pragma mark -
#pragma mark Initialization


+(void)initializeTextAttributes {
    
    NSFont *font = nil;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    font = [NSFont fontWithName:@"ilRocci-unicode" size:40.0];
    [paragraphStyle setAlignment:NSCenterTextAlignment];
    formText = [NSDictionary dictionaryWithObjectsAndKeys:
                font, NSFontAttributeName,
                paragraphStyle, NSParagraphStyleAttributeName,
                nil];
    
    font = [NSFont fontWithName:@"ilRocci-unicode" size:32.0];
    [paragraphStyle setAlignment:NSCenterTextAlignment];
    lemmaText = [NSDictionary dictionaryWithObjectsAndKeys:
                 font, NSFontAttributeName,
                 paragraphStyle, NSParagraphStyleAttributeName,
                 nil];
   
    font = [NSFont fontWithName:@"ilRocci-unicode" size:24.0];
    titleText = [NSDictionary dictionaryWithObjectsAndKeys:
                 font, NSFontAttributeName,
                 [NSNumber numberWithDouble:-3.0], NSStrokeWidthAttributeName,
                 nil];
    
    bodyText = [NSDictionary dictionaryWithObjectsAndKeys:
                font, NSFontAttributeName,
                nil];
    

}

+(void)initialize {
//    [self initializeTransDictionary];
    [self initializeTextAttributes];
}

#pragma mark -
#pragma mark Add array elements
+(NSMutableDictionary*)addDialect:(NSString *)dialect toWord:(NSMutableDictionary *)word
{
    NSMutableArray* dialects = [word objectForKey:@"dialects"];
    if (dialects == nil) {
        dialects = [[NSMutableArray alloc]initWithObjects:dialect, nil];
    } else {
        [dialects addObject:dialect];
    }
    [word setObject:dialects forKey:@"dialects" ];
    return word;
}

+(NSMutableDictionary*)addFeature:(NSString *)feature toWord:(NSMutableDictionary *)word
{
    NSMutableArray* features = [word objectForKey:@"features"];
    if (features == nil) {
        features = [[NSMutableArray alloc]initWithObjects:feature, nil];
    } else {
        [features addObject:feature];
    }
    [word setObject:features forKey:@"features"];
    return word;
}

#pragma mark -
#pragma mark Get composite elements

+(NSString*)getVerbMood:(NSDictionary*)word {
    NSString* str = @"";
    NSString* pos = [word objectForKey:@"pos"];
    if ([pos length]>0) {
        if ([pos compare:@"verb"] == NSOrderedSame) {
            NSString* mood = [word objectForKey:@"mood"];
            if (mood != nil) {
                str =  mood;
            }
        } else if ([pos compare:@"part"] == NSOrderedSame) {
            str = pos;
        }
    }
    return str;
}

+(NSString*)getPerson:(NSDictionary*)word {
    NSString* dictName = @"PerseusDict";
    NSString* person = NSLocalizedStringFromTable([word objectForKey:@"person"],dictName,@"person in analysis");
    NSString* number = NSLocalizedStringFromTable([word objectForKey:@"number"],dictName,@"number in analysis");;
    return [NSString stringWithFormat:@"%@ %@",person, number];
}


#pragma mark -
#pragma mark Get descriptions
+(void)addLineToAttributeString:(NSMutableAttributedString*)string withTitle:(NSString*)title withBody:(NSString*)body {
    NSString* dictName = @"PerseusDict";
    NSString* locTitle = NSLocalizedStringFromTable(title,dictName,@"");
    NSString* locBody = NSLocalizedStringFromTable(body,dictName,@"");
    NSAttributedString* posTitle = [[NSAttributedString alloc] initWithString:locTitle attributes:titleText];
    NSAttributedString* attrBody = [[NSAttributedString alloc] initWithString:locBody attributes:bodyText];
    
    
    NSAttributedString* titleBodySepText = [[NSAttributedString alloc]initWithString:@": " attributes:titleText];
    NSAttributedString* endLineText = [[NSAttributedString alloc]initWithString:@"\n" attributes:bodyText];
    [string appendAttributedString:posTitle];
    [string appendAttributedString:titleBodySepText];
    [string appendAttributedString:attrBody];
    [string appendAttributedString:endLineText];
}


+(NSAttributedString*)analysis:(NSDictionary*)word {
    NSMutableAttributedString* str = [[NSMutableAttributedString alloc]init];
    NSAttributedString* endLineText = [[NSAttributedString alloc]initWithString:@"\n" attributes:lemmaText];
    
    [str appendAttributedString:[self formTitle:[word objectForKey:@"form"]]];
    [str appendAttributedString:endLineText];
    
    endLineText = [[NSAttributedString alloc]initWithString:@"\n" attributes:formText];
    [str appendAttributedString:[self lemmaTitle:[word objectForKey:@"lemma"]]];
    [str appendAttributedString:endLineText];
    [str appendAttributedString:endLineText];
    
    [str appendAttributedString:[self analysisBody:word]];
    
    return str;
}


+(NSAttributedString*)formTitle:(NSString*)form {
    return [[NSAttributedString alloc] initWithString:form attributes:formText];
}

+(NSAttributedString*)lemmaTitle:(NSString*)lemma {
    NSMutableAttributedString* attrStr;
    NSString* dictName = @"InfoPlist";
    NSString* prefix = NSLocalizedStringFromTable(@"from",dictName,@"'from' before lemma in analysis");
    NSMutableString* str = [NSMutableString stringWithString:prefix];
    [str appendString:@" "];
    [str appendString:lemma];
    
    attrStr = [[NSMutableAttributedString alloc] initWithString:str attributes:lemmaText];
    
    NSRange range = NSMakeRange(0, [prefix length]);
    [attrStr beginEditing];
    [attrStr addAttribute:NSForegroundColorAttributeName
                    value:[NSColor grayColor]
                    range:range];
    [attrStr endEditing];
    
    return attrStr;
}

+(NSAttributedString*)analysisBody:(NSDictionary*)word {
    NSMutableAttributedString* str = [[NSMutableAttributedString alloc]init];
    
    NSString* pos = [word objectForKey:@"pos"];
    NSString* mood = [word objectForKey:@"mood"];
    NSString* tense = [word objectForKey:@"tense"];
    NSString* voice = [word objectForKey:@"voice"];
    //NSString* person = [word objectForKey:@"person"];
    NSString* number = [word objectForKey:@"number"];
    NSString* gender = [word objectForKey:@"gender"];
    NSString* gcase = [word objectForKey:@"gcase"];
    
   if ([pos length]>0) {
        if ([pos compare:@"verb"] == NSOrderedSame) {
            if ([mood compare:@"inf"] == NSOrderedSame) {
                [self addLineToAttributeString:str withTitle:@"Mood" withBody:mood];
                [self addLineToAttributeString:str withTitle:@"Tense" withBody:tense];
                [self addLineToAttributeString:str withTitle:@"Voice" withBody:voice];
            } else if (mood == nil) {
                [self addLineToAttributeString:str withTitle:@"Tense" withBody:tense];
                [self addLineToAttributeString:str withTitle:@"Voice" withBody:voice];
            } else {
                [self addLineToAttributeString:str withTitle:@"Mood" withBody:mood];
                [self addLineToAttributeString:str withTitle:@"Tense" withBody:tense];
                [self addLineToAttributeString:str withTitle:@"Person" withBody:[self getPerson:word]];
                //[self addLineToAttributeString:str withTitle:@"Number" withBody:number];
                [self addLineToAttributeString:str withTitle:@"Voice" withBody:voice];
            }
        } else if ([pos compare:@"part"] == NSOrderedSame) {
            [self addLineToAttributeString:str withTitle:@"Pos" withBody:pos];
            [self addLineToAttributeString:str withTitle:@"Tense" withBody:tense];
            [self addLineToAttributeString:str withTitle:@"Number" withBody:number];
            [self addLineToAttributeString:str withTitle:@"Gender" withBody:gender];
            [self addLineToAttributeString:str withTitle:@"Voice" withBody:voice];
        } else {
            [self addLineToAttributeString:str withTitle:@"Pos" withBody:pos];
            [self addLineToAttributeString:str withTitle:@"Tense" withBody:tense];
            [self addLineToAttributeString:str withTitle:@"Mood" withBody:mood];
            [self addLineToAttributeString:str withTitle:@"Person" withBody:[self getPerson:word]];
            //[self addLineToAttributeString:str withTitle:@"Number" withBody:number];
            [self addLineToAttributeString:str withTitle:@"Gender" withBody:gender];
            [self addLineToAttributeString:str withTitle:@"Case" withBody:gcase];
            [self addLineToAttributeString:str withTitle:@"Voice" withBody:voice];
        }
    }
    return str;
}



@end
