//
//  LBRGreekString.m
//  VerbiGreci
//
//  Created by Claudio Capobianco on 10/04/12.
//  Copyright (c) 2012 Librum. All rights reserved.
//

#import "LBRGreekString.h"
#import "LBRGreekChar.h"
#import "unicodeFontset.h"
#import "LBRGreekCharset.h"

#pragma mark
NSCharacterSet *alphaVariantCharSet;
NSCharacterSet *epsilonVariantCharSet;
NSCharacterSet *etaVariantCharSet;
NSCharacterSet *iotaVariantCharSet;
NSCharacterSet *omicronVariantCharSet;
NSCharacterSet *upsilonVariantCharSet;
NSCharacterSet *omegaVariantCharSet;
NSCharacterSet *rhoVariantCharSet;
NSCharacterSet *plainGreekCharSet;
//NSCharacterSet *polytonicGreekCharSet;
//NSCharacterSet *philologicalGreekCharSet;
NSCharacterSet *asciiLetterGreekCharSet;

//NSCharacterSet *uppercaseGreekCharSet;

//NSDictionary* toUppercaseDictionary;
//NSDictionary* toLowercaselDictionary;

NSString* STR_SIGN_PSILI = @")";
NSString* STR_SIGN_DASIA = @"(";
NSString* STR_SIGN_VARIA = @"\\";
NSString* STR_SIGN_OXIA = @"/";
NSString* STR_SIGN_PERISPOMENI = @"=";
NSString* STR_SIGN_YPOGERGRAMMENI = @"|";

NSString* STR_SIGN_PSILI_VARIA = @")\\";
NSString* STR_SIGN_DASIA_VARIA = @"(\\";
NSString* STR_SIGN_PSILI_OXIA = @")/";
NSString* STR_SIGN_DASIA_OXIA = @"(/";
NSString* STR_SIGN_PSILI_PERISPOMENI = @")=";
NSString* STR_SIGN_DASIA_PERISPOMENI = @"(=";
NSString* STR_SIGN_PSILI_YPOGERGRAMMENI = @")|";
NSString* STR_SIGN_DASIA_YPOGERGRAMMENI = @"a/|";
NSString* STR_SIGN_VARIA_YPOGERGRAMMENI = @"a\\|";
NSString* STR_SIGN_OXIA_YPOGERGRAMMENI = @"a/|";
NSString* STR_SIGN_PERISPOMENI_YPOGERGRAMMENI = @"a=|";

NSString* STR_SIGN_PSILI_VARIA_YPOGERGRAMMENI = @")\\|";
NSString* STR_SIGN_DASIA_VARIA_YPOGERGRAMMENI = @"(\\|";
NSString* STR_SIGN_PSILI_OXIA_YPOGERGRAMMENI = @")/|";
NSString* STR_SIGN_DASIA_OXIA_YPOGERGRAMMENI = @"(/|";
NSString* STR_SIGN_PSILI_PERISPOMENI_YPOGERGRAMMENI = @")=|";
NSString* STR_SIGN_DASIA_PERISPOMENI_YPOGERGRAMMENI = @"(=|";

// TODO
//NSString* STR_SIGN_VRACHY = @"";
//NSString* STR_SIGN_MACRON = @"";
//NSString* STR_SIGN_MACRON_OXIA = @"";
//NSString* STR_SIGN_MACRON_PSILI = @"";
//NSString* STR_SIGN_MACRON_DASIA = @"";
//NSString* STR_SIGN_VRACHY_OXIA = @"";


@interface LBRGreekString()
+(NSString*) stringByReplacingAllCharactersInString:(NSString*)str fromCharacterSet:(NSCharacterSet*)chset withChar:(unichar)c;
@end


@implementation LBRGreekString

static NSString * const kCharSetType = @"bitmap";

#pragma mark
#pragma mark Initialization

+(void) initialize_charset {
    if (alphaVariantCharSet == nil) {
        NSLog(@"Creating charset...");
        
        alphaVariantCharSet = [LBRGreekCharset createAlphaVariantCharSet];
        epsilonVariantCharSet = [LBRGreekCharset createEpsilonVariantCharSet];
        etaVariantCharSet = [LBRGreekCharset createEtaVariantCharSet];
        iotaVariantCharSet = [LBRGreekCharset createIotaVariantCharSet];
        omicronVariantCharSet = [LBRGreekCharset createOmicronVariantCharSet]; 
        upsilonVariantCharSet = [LBRGreekCharset createUpsilonVariantCharSet];
        omegaVariantCharSet = [LBRGreekCharset createOmegaVariantCharSet]; 
        rhoVariantCharSet = [LBRGreekCharset createRhoVariantCharSet]; 
        
        plainGreekCharSet = [LBRGreekCharset createPlainGreekCharSet]; 
        //polytonicGreekCharSet = [LBRGreekCharset createPolytonicGreekCharSet];
        //philologicalGreekCharSet = [LBRGreekCharset createPhilologicalGreekCharSet];
        asciiLetterGreekCharSet = [LBRGreekCharset createAsciiLetterGreekCharSet]; 
        
    }
}

+(void) initialize
{
    [self initialize_charset];
    [LBRGreekChar initialize];
    return;
}

#pragma mark
#pragma mark String Utilities
+(NSString*) stringByChar:(unichar)c {
    unichar pc[] = {c,'\0'};
    return [NSString stringWithCharacters:pc length:1];
}

+(NSString*) stringByReplacingAllCharactersInString:(NSString*)str fromCharacterSet:(NSCharacterSet*)chset withChar:(unichar)c
{
    unichar pc[] = {c};
    NSString *rplStr = [NSString stringWithCharacters:pc length:1];
    BOOL quit = NO;
    NSRange letterRange;
    NSString* outStr = str;

    
    /* Check if replacing char is inside charset to avoid infinite loop */
    NSRange checkRange = [rplStr rangeOfCharacterFromSet:chset];
    if (checkRange.length > 0)
    {
        return outStr;
    }
    
    while (quit == NO) {
        letterRange = [outStr rangeOfCharacterFromSet:chset];
        if (letterRange.length>0)
        {
            outStr = [outStr stringByReplacingCharactersInRange:letterRange withString:rplStr];
        }
        else {
            quit = YES;
        }
    }
    return outStr;
}



+(NSString*)convertFinalSigma:(NSString*)str {
    NSString* retString = str;
    NSUInteger len = [retString length];
    if (len > 0) {
        retString = [retString stringByReplacingOccurrencesOfString:[LBRGreekString stringByChar:UNICODE_SIGMA_FINAL] withString:[LBRGreekString stringByChar:UNICODE_SIGMA]];
        NSString* lastLetterStr = [retString substringFromIndex:(len-1)];
        if ([lastLetterStr isEqualToString:[LBRGreekString stringByChar:UNICODE_SIGMA]]) {
            // replace the last sigma with final sigma
            retString = [retString substringToIndex:(len-1)];
            retString = [retString stringByAppendingString:[LBRGreekString stringByChar:UNICODE_SIGMA_FINAL]];
        }
        
    }
    return retString;
}

#pragma mark
#pragma mark Fontset check and replace

+(BOOL) isPlain:(NSString*)str
{
    BOOL ret = YES;
    
    for (NSUInteger i = 0; i < [str length]; i++) {
        unichar c = [str characterAtIndex:i];
        if ([LBRGreekChar isPlain:c] == false) {
            ret = NO;
            break;
        }
    }
    
    return ret;
}

+(NSString*) toPlain:(NSString*)str
{    
    NSString* outStr = str;
    outStr = [self stringByReplacingAllCharactersInString:outStr fromCharacterSet:alphaVariantCharSet withChar:UNICODE_ALPHA];
    outStr = [self stringByReplacingAllCharactersInString:outStr fromCharacterSet:epsilonVariantCharSet withChar:UNICODE_EPSILON];
    outStr = [self stringByReplacingAllCharactersInString:outStr fromCharacterSet:etaVariantCharSet withChar:UNICODE_ETA];
    outStr = [self stringByReplacingAllCharactersInString:outStr fromCharacterSet:iotaVariantCharSet withChar:UNICODE_IOTA];
    outStr = [self stringByReplacingAllCharactersInString:outStr fromCharacterSet:omicronVariantCharSet withChar:UNICODE_OMICRON];
    outStr = [self stringByReplacingAllCharactersInString:outStr fromCharacterSet:upsilonVariantCharSet withChar:UNICODE_UPSILON];
    outStr = [self stringByReplacingAllCharactersInString:outStr fromCharacterSet:omegaVariantCharSet withChar:UNICODE_OMEGA];
    outStr = [self stringByReplacingAllCharactersInString:outStr fromCharacterSet:rhoVariantCharSet withChar:UNICODE_RHO];
    
    return outStr;
    
    
}

+(BOOL) isAsciiLetters:(NSString*)str
{
    BOOL ret = NO;
    NSRange letterRange = [str rangeOfCharacterFromSet:asciiLetterGreekCharSet];
    
    if (letterRange.length > 0) {
        ret = YES;
    }
    
    return ret;
}

+(NSString*) toAsciiLetters:(NSString*)str
{
    NSString* outStr = str;
    outStr = [self stringByReplacingAllCharactersInString:outStr fromCharacterSet:alphaVariantCharSet withChar:'a'];
    outStr = [self stringByReplacingAllCharactersInString:outStr fromCharacterSet:epsilonVariantCharSet withChar:'e'];
    outStr = [self stringByReplacingAllCharactersInString:outStr fromCharacterSet:etaVariantCharSet withChar:'h'];
    outStr = [self stringByReplacingAllCharactersInString:outStr fromCharacterSet:iotaVariantCharSet withChar:'i'];
    outStr = [self stringByReplacingAllCharactersInString:outStr fromCharacterSet:omicronVariantCharSet withChar:'o'];
    outStr = [self stringByReplacingAllCharactersInString:outStr fromCharacterSet:upsilonVariantCharSet withChar:'u'];
    outStr = [self stringByReplacingAllCharactersInString:outStr fromCharacterSet:omegaVariantCharSet withChar:'w'];
    outStr = [self stringByReplacingAllCharactersInString:outStr fromCharacterSet:rhoVariantCharSet withChar:'r'];
    

    outStr = [outStr stringByReplacingOccurrencesOfString:[self stringByChar:UNICODE_ALPHA] withString:@"a"];
    outStr = [outStr stringByReplacingOccurrencesOfString:[self stringByChar:UNICODE_BETA] withString:@"b"];
    outStr = [outStr stringByReplacingOccurrencesOfString:[self stringByChar:UNICODE_GAMMA] withString:@"g"];
    outStr = [outStr stringByReplacingOccurrencesOfString:[self stringByChar:UNICODE_DELTA] withString:@"d"];
    outStr = [outStr stringByReplacingOccurrencesOfString:[self stringByChar:UNICODE_EPSILON] withString:@"e"];
    outStr = [outStr stringByReplacingOccurrencesOfString:[self stringByChar:UNICODE_ZETA] withString:@"z"];
    outStr = [outStr stringByReplacingOccurrencesOfString:[self stringByChar:UNICODE_ETA] withString:@"h"];
    outStr = [outStr stringByReplacingOccurrencesOfString:[self stringByChar:UNICODE_THETA] withString:@"q"];
    outStr = [outStr stringByReplacingOccurrencesOfString:[self stringByChar:UNICODE_IOTA] withString:@"i"];
    outStr = [outStr stringByReplacingOccurrencesOfString:[self stringByChar:UNICODE_KAPPA] withString:@"k"];
    outStr = [outStr stringByReplacingOccurrencesOfString:[self stringByChar:UNICODE_LAMBDA] withString:@"l"];
    outStr = [outStr stringByReplacingOccurrencesOfString:[self stringByChar:UNICODE_MI] withString:@"m"];
    outStr = [outStr stringByReplacingOccurrencesOfString:[self stringByChar:UNICODE_NI] withString:@"n"];
    outStr = [outStr stringByReplacingOccurrencesOfString:[self stringByChar:UNICODE_XI] withString:@"c"];
    outStr = [outStr stringByReplacingOccurrencesOfString:[self stringByChar:UNICODE_OMICRON] withString:@"o"];
    outStr = [outStr stringByReplacingOccurrencesOfString:[self stringByChar:UNICODE_PI] withString:@"p"];
    outStr = [outStr stringByReplacingOccurrencesOfString:[self stringByChar:UNICODE_RHO] withString:@"r"];
    outStr = [outStr stringByReplacingOccurrencesOfString:[self stringByChar:UNICODE_SIGMA_FINAL] withString:@"s"];
    outStr = [outStr stringByReplacingOccurrencesOfString:[self stringByChar:UNICODE_SIGMA] withString:@"s"];
    outStr = [outStr stringByReplacingOccurrencesOfString:[self stringByChar:UNICODE_TAU] withString:@"t"];
    outStr = [outStr stringByReplacingOccurrencesOfString:[self stringByChar:UNICODE_UPSILON] withString:@"u"];
    outStr = [outStr stringByReplacingOccurrencesOfString:[self stringByChar:UNICODE_PHI] withString:@"f"];
    outStr = [outStr stringByReplacingOccurrencesOfString:[self stringByChar:UNICODE_CHI] withString:@"x"];
    outStr = [outStr stringByReplacingOccurrencesOfString:[self stringByChar:UNICODE_PSI] withString:@"y"];
    outStr = [outStr stringByReplacingOccurrencesOfString:[self stringByChar:UNICODE_OMEGA] withString:@"w"];
    
    return outStr;
}



+(NSString*)asciiLetters2plainGreek:(NSString*)str {
    
    NSUInteger len = [str length];
    NSMutableString* mutStr = [NSMutableString stringWithCapacity:len];
    
    for (int idx = 0; idx < len; idx++)
    {
        unichar ch = [str characterAtIndex:idx];
        unichar newCh = [LBRGreekChar asciiLetter2plainGreek:ch];
        NSString* newChStr = [LBRGreekString stringByChar:newCh];
        [mutStr appendString:newChStr];
    }
    // Sigma final
    if (len > 0) {
        if ([mutStr characterAtIndex:len-1] == UNICODE_SIGMA) {
            [mutStr replaceCharactersInRange:NSMakeRange(len-1, 1) withString:[LBRGreekString stringByChar:UNICODE_SIGMA_FINAL]];
        }
    }
    return mutStr;
}

//+(NSString*)asciiLetters2plainGreek:(NSString*)str
//{
//    NSString* outStr = str;
//    
//    outStr = [outStr stringByReplacingOccurrencesOfString:[self stringByChar:'a'] withString:[self stringByChar:UNICODE_ALPHA]];
//    outStr = [outStr stringByReplacingOccurrencesOfString:[self stringByChar:'b'] withString:[self stringByChar:UNICODE_BETA]];
//    outStr = [outStr stringByReplacingOccurrencesOfString:[self stringByChar:'g'] withString:[self stringByChar:UNICODE_GAMMA]];
//    outStr = [outStr stringByReplacingOccurrencesOfString:[self stringByChar:'d'] withString:[self stringByChar:UNICODE_DELTA]];
//    outStr = [outStr stringByReplacingOccurrencesOfString:[self stringByChar:'e'] withString:[self stringByChar:UNICODE_EPSILON]];
//    outStr = [outStr stringByReplacingOccurrencesOfString:[self stringByChar:'z'] withString:[self stringByChar:UNICODE_ZETA]];
//    outStr = [outStr stringByReplacingOccurrencesOfString:[self stringByChar:'h'] withString:[self stringByChar:UNICODE_ETA]];
//    outStr = [outStr stringByReplacingOccurrencesOfString:[self stringByChar:'q'] withString:[self stringByChar:UNICODE_THETA]];
//    outStr = [outStr stringByReplacingOccurrencesOfString:[self stringByChar:'i'] withString:[self stringByChar:UNICODE_IOTA]];
//    outStr = [outStr stringByReplacingOccurrencesOfString:[self stringByChar:'k'] withString:[self stringByChar:UNICODE_KAPPA]];
//    outStr = [outStr stringByReplacingOccurrencesOfString:[self stringByChar:'l'] withString:[self stringByChar:UNICODE_LAMBDA]];
//    outStr = [outStr stringByReplacingOccurrencesOfString:[self stringByChar:'m'] withString:[self stringByChar:UNICODE_MI]];
//    outStr = [outStr stringByReplacingOccurrencesOfString:[self stringByChar:'n'] withString:[self stringByChar:UNICODE_NI]];
//    outStr = [outStr stringByReplacingOccurrencesOfString:[self stringByChar:'c'] withString:[self stringByChar:UNICODE_XI]];
//    outStr = [outStr stringByReplacingOccurrencesOfString:[self stringByChar:'o'] withString:[self stringByChar:UNICODE_OMICRON]];
//    outStr = [outStr stringByReplacingOccurrencesOfString:[self stringByChar:'p'] withString:[self stringByChar:UNICODE_PI]];
//    outStr = [outStr stringByReplacingOccurrencesOfString:[self stringByChar:'r'] withString:[self stringByChar:UNICODE_RHO]];
//    outStr = [outStr stringByReplacingOccurrencesOfString:[self stringByChar:'s'] withString:[self stringByChar:UNICODE_SIGMA]];
//    outStr = [outStr stringByReplacingOccurrencesOfString:[self stringByChar:'t'] withString:[self stringByChar:UNICODE_TAU]];
//    outStr = [outStr stringByReplacingOccurrencesOfString:[self stringByChar:'u'] withString:[self stringByChar:UNICODE_UPSILON]];
//    outStr = [outStr stringByReplacingOccurrencesOfString:[self stringByChar:'f'] withString:[self stringByChar:UNICODE_PHI]];
//    outStr = [outStr stringByReplacingOccurrencesOfString:[self stringByChar:'x'] withString:[self stringByChar:UNICODE_CHI]];
//    outStr = [outStr stringByReplacingOccurrencesOfString:[self stringByChar:'y'] withString:[self stringByChar:UNICODE_PSI]];
//    outStr = [outStr stringByReplacingOccurrencesOfString:[self stringByChar:'w'] withString:[self stringByChar:UNICODE_OMEGA]];
//
//    return outStr;
//}

+ (void)composeCharactersInString:(NSMutableString *)mutStr withAsciiSign:(NSString*)asciiSign toSign:(LBRLetterSign)sign {
    BOOL quit = NO;
    while (quit == NO) {
        NSRange range = [mutStr rangeOfString:asciiSign];
        if (range.location != NSNotFound) {
            if (range.location > 0) {
                range = NSMakeRange(range.location-1, range.length+1);
                unichar asciiCh = [mutStr characterAtIndex:range.location];
                unichar plainCh = [LBRGreekChar asciiLetter2plainGreek:asciiCh];
                if ((range.location > 0) && ([mutStr characterAtIndex:range.location-1]=='*')) {
                    plainCh = [LBRGreekChar toUpperCase:plainCh];
                    range = NSMakeRange(range.location-1, range.length+1);
                }
                unichar newCh = [LBRGreekChar composeCharFromLetter:plainCh withSign:sign];
                NSString* newChStr = [LBRGreekString stringByChar:newCh];
                [mutStr replaceCharactersInRange:range withString:newChStr];
            }
            else {
                NSLog(@"composeCharactersInString: warning: asciiSign at beginning of string: %@",mutStr);
                quit = YES;
            }
        }
        else {
            quit = YES;
        }
    }
}

+(void)removeCharactersFromString:(NSMutableString*)str inSet:(NSCharacterSet*)chSet {
    
    BOOL quit = NO;
    while (quit == NO) {
        NSRange range = [str rangeOfCharacterFromSet:chSet];
        if (range.location!=NSNotFound) {
            [str replaceCharactersInRange:range withString:@""];
        } else {
            quit = YES;
        }
    }
}


+(NSString*)ascii2greek:(NSString*)str
{
    NSMutableString* mutStr = [[NSMutableString alloc]initWithString:str];
    
    NSCharacterSet* beforeSet = [NSCharacterSet characterSetWithCharactersInString:@"^-_'+"];
    [LBRGreekString removeCharactersFromString:mutStr inSet:beforeSet];
    
    // replace composed chars
    [LBRGreekString composeCharactersInString:mutStr withAsciiSign:STR_SIGN_PSILI_VARIA_YPOGERGRAMMENI toSign:LBR_LETTER_SIGN_PSILI_VARIA_YPOGERGRAMMENI];
    [LBRGreekString composeCharactersInString:mutStr withAsciiSign:STR_SIGN_DASIA_VARIA_YPOGERGRAMMENI toSign:LBR_LETTER_SIGN_DASIA_VARIA_YPOGERGRAMMENI];
    [LBRGreekString composeCharactersInString:mutStr withAsciiSign:STR_SIGN_PSILI_OXIA_YPOGERGRAMMENI toSign:LBR_LETTER_SIGN_PSILI_OXIA_YPOGERGRAMMENI];
    [LBRGreekString composeCharactersInString:mutStr withAsciiSign:STR_SIGN_DASIA_OXIA_YPOGERGRAMMENI toSign:LBR_LETTER_SIGN_DASIA_OXIA_YPOGERGRAMMENI];
    [LBRGreekString composeCharactersInString:mutStr withAsciiSign:STR_SIGN_PSILI_PERISPOMENI_YPOGERGRAMMENI toSign:LBR_LETTER_SIGN_PSILI_PERISPOMENI_YPOGERGRAMMENI];
    [LBRGreekString composeCharactersInString:mutStr withAsciiSign:STR_SIGN_DASIA_PERISPOMENI_YPOGERGRAMMENI toSign:LBR_LETTER_SIGN_DASIA_PERISPOMENI_YPOGERGRAMMENI];
    
    [LBRGreekString composeCharactersInString:mutStr withAsciiSign:STR_SIGN_PSILI_VARIA toSign:LBR_LETTER_SIGN_PSILI_VARIA];
    [LBRGreekString composeCharactersInString:mutStr withAsciiSign:STR_SIGN_DASIA_VARIA toSign:LBR_LETTER_SIGN_DASIA_VARIA];
    [LBRGreekString composeCharactersInString:mutStr withAsciiSign:STR_SIGN_PSILI_OXIA toSign:LBR_LETTER_SIGN_PSILI_OXIA];
    [LBRGreekString composeCharactersInString:mutStr withAsciiSign:STR_SIGN_DASIA_OXIA toSign:LBR_LETTER_SIGN_DASIA_OXIA];
    [LBRGreekString composeCharactersInString:mutStr withAsciiSign:STR_SIGN_PSILI_PERISPOMENI toSign:LBR_LETTER_SIGN_PSILI_PERISPOMENI];
    [LBRGreekString composeCharactersInString:mutStr withAsciiSign:STR_SIGN_DASIA_PERISPOMENI toSign:LBR_LETTER_SIGN_DASIA_PERISPOMENI];
    [LBRGreekString composeCharactersInString:mutStr withAsciiSign:STR_SIGN_PSILI_YPOGERGRAMMENI toSign:LBR_LETTER_SIGN_PSILI_YPOGERGRAMMENI];
    [LBRGreekString composeCharactersInString:mutStr withAsciiSign:STR_SIGN_DASIA_YPOGERGRAMMENI toSign:LBR_LETTER_SIGN_DASIA_YPOGERGRAMMENI];
    [LBRGreekString composeCharactersInString:mutStr withAsciiSign:STR_SIGN_VARIA_YPOGERGRAMMENI toSign:LBR_LETTER_SIGN_VARIA_YPOGERGRAMMENI];
    [LBRGreekString composeCharactersInString:mutStr withAsciiSign:STR_SIGN_OXIA_YPOGERGRAMMENI toSign:LBR_LETTER_SIGN_OXIA_YPOGERGRAMMENI];
    [LBRGreekString composeCharactersInString:mutStr withAsciiSign:STR_SIGN_PERISPOMENI_YPOGERGRAMMENI toSign:LBR_LETTER_SIGN_PERISPOMENI_YPOGERGRAMMENI];
    
    [LBRGreekString composeCharactersInString:mutStr withAsciiSign:STR_SIGN_PSILI toSign:LBR_LETTER_SIGN_PSILI];
    [LBRGreekString composeCharactersInString:mutStr withAsciiSign:STR_SIGN_DASIA toSign:LBR_LETTER_SIGN_DASIA];
    [LBRGreekString composeCharactersInString:mutStr withAsciiSign:STR_SIGN_VARIA toSign:LBR_LETTER_SIGN_VARIA];
    [LBRGreekString composeCharactersInString:mutStr withAsciiSign:STR_SIGN_OXIA toSign:LBR_LETTER_SIGN_OXIA];
    [LBRGreekString composeCharactersInString:mutStr withAsciiSign:STR_SIGN_PERISPOMENI toSign:LBR_LETTER_SIGN_PERISPOMENI];
    [LBRGreekString composeCharactersInString:mutStr withAsciiSign:STR_SIGN_YPOGERGRAMMENI toSign:LBR_LETTER_SIGN_YPOGERGRAMMENI];
    
    // replace plain char
    [mutStr setString:[LBRGreekString asciiLetters2plainGreek:mutStr]];
    
    // clean
    NSCharacterSet*afterSet = [NSCharacterSet characterSetWithCharactersInString:@"*()\\/=|"];
    [LBRGreekString removeCharactersFromString:mutStr inSet:afterSet];
    return mutStr;
}


#pragma mark Changing case
+(NSString*)toUppercase:(NSString*)str
{
    NSUInteger len = [str length];
    NSMutableString* mutStr = [NSMutableString stringWithCapacity:len];
    
    for (int idx = 0; idx < len; idx++)
    {
        unichar ch = [str characterAtIndex:idx];
        unichar newCh = [LBRGreekChar toUpperCase:ch];
        NSString* newChStr = [LBRGreekString stringByChar:newCh];
        [mutStr appendString:newChStr];
    }
    return mutStr;
}

+(NSString*)toLowercase:(NSString*)str
{
    NSUInteger len = [str length];
    NSMutableString* mutStr = [NSMutableString stringWithCapacity:len];
    
    for (int idx = 0; idx < len; idx++)
    {
        unichar ch = [str characterAtIndex:idx];
        unichar newCh = [LBRGreekChar toLowerCase:ch];
        NSString* newChStr = [LBRGreekString stringByChar:newCh];
        [mutStr appendString:newChStr];
    }
    return mutStr;
}

+(BOOL)isUppercase:(NSString*) str
{
    BOOL retBool = false;
    NSString* strUp = [LBRGreekString toUppercase:str];
    if ([str compare:strUp] == NSOrderedSame)
    {
        retBool = true;
    }
    return retBool;
}

+(BOOL)isLowercase:(NSString*) str
{
    return ![self isUppercase:str];
}

+(BOOL)isPolytonic:(NSString *)str
{    
    for (int idx = 0; idx < [str length]; idx++)
    {
        unichar ch = [str characterAtIndex:idx];
        if ([LBRGreekChar isPolytonic:ch] == YES) {
            return YES;
        }
    }
    return NO;
}

+(BOOL)isPhilological:(NSString *)str
{
    for (int idx = 0; idx < [str length]; idx++)
    {
        unichar ch = [str characterAtIndex:idx];
        if ([LBRGreekChar isPhilological:ch] == YES) {
            return YES;
        }
    }
    return NO;
}

//+(unichar)getGoodChar:(NSString*)str atIndex:(NSUInteger)idxStart {
//    
//    NSUInteger len = [str length];
//
//    for (NSUInteger idx = idxStart; idx < len; idx++) {
//        unichar ch = [str characterAtIndex:idx];
//        enum fontsetSortOrder s = [LBRGreekIlRocciUtils sortOrderIlRocci:(ch)];
//        if (s != SORT_SKIP) {
//            return ch;
//        }
//    }
//    return '\0';
//}

+(NSString*)trimSortString:(NSString*)str {
    if ([LBRGreekChar sortOrder:[str characterAtIndex:0]] == SORT_SKIP) {
        return [str substringFromIndex:1];
    }
    return str;
}


NSInteger LBRGreekStringSort(id obj1, id obj2, void *context) {
    //struct sortContext_s* ctx = context;
    //BOOL isUnicode = ctx->isUnicode; // no more useful
    //BOOL isReverse = ctx->reverseOrder; //TODO: manage reverse ordering
    NSString* str1 = [LBRGreekString trimSortString:[obj1 objectForKey:@"strLemma"]];
    NSString* str2 = [LBRGreekString trimSortString:[obj2 objectForKey:@"strLemma"]];
    
    NSUInteger len1 = [str1 length];
    NSUInteger len2 = [str2 length];
    NSInteger defaultRet = NSOrderedSame;
    
    NSUInteger len = len1;
    if (len1 > len2) {
        len = len2;
    }
    
    for (NSUInteger idx = 0; idx < len; idx++) {
        unichar ch1 = [str1 characterAtIndex:idx];
        unichar ch2 = [str2 characterAtIndex:idx];
        enum fontsetSortOrder v1 = 0;
        enum fontsetSortOrder v2 = 0;
        v1 = [LBRGreekChar sortOrder:(ch1)];
        v2 = [LBRGreekChar sortOrder:(ch2)];
        if (v1 < v2) {
            return NSOrderedAscending;
        }
        else if (v1 > v2) {
            return NSOrderedDescending;
        }
        else {
            // nothing to do, check next character
        }
    }
    
    // check if a string is the prefix of the other one
    // in this case consider shorter string as smaller
    if (len1 < len2) {
        return NSOrderedAscending;
    } else if (len1 > len2) {
        return NSOrderedDescending;
    }
    
    // we arrive here only if the two srtings are identical
    return defaultRet;
}


NSInteger LBRGreekStringSortAttributed(id str1, id str2, void *context) {
    return LBRGreekStringSort([str1 string],[str2 string],context);
}


@end
