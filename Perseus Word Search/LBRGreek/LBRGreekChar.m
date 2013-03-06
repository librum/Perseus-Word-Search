//
//  LBRGreekChar.m
//  VerbiGreci
//
//  Created by Claudio Capobianco on 12/04/12.
//  Copyright (c) 2012 Librum. All rights reserved.
//

#import "LBRGreekChar.h"
#import "LBRGreekString.h"
//#import "ilRocciFontset.h"
// add unicode fontset for conversion
#import "unicodeFontset.h"
#import "fontsetSortOrder.h"

NSDictionary* letterDescriptionDictionary;
NSDictionary* signDescriptionlDictionary;

@implementation LBRGreekChar

+(void)initialize_descriptions {
    if (letterDescriptionDictionary == nil) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:26];
        
        [dict setObject:@"alpha" forKey:[LBRGreekString stringByChar:UNICODE_ALPHA]];
        [dict setObject:@"beta" forKey:[LBRGreekString stringByChar:UNICODE_BETA]];
        [dict setObject:@"gamma" forKey:[LBRGreekString stringByChar:UNICODE_GAMMA]];
        [dict setObject:@"delta" forKey:[LBRGreekString stringByChar:UNICODE_DELTA]];
        [dict setObject:@"epsilon" forKey:[LBRGreekString stringByChar:UNICODE_EPSILON]];
        [dict setObject:@"zeta" forKey:[LBRGreekString stringByChar:UNICODE_ZETA]];
        [dict setObject:@"eta" forKey:[LBRGreekString stringByChar:UNICODE_ETA]];
        [dict setObject:@"theta" forKey:[LBRGreekString stringByChar:UNICODE_THETA]];
        [dict setObject:@"iota" forKey:[LBRGreekString stringByChar:UNICODE_IOTA]];
        [dict setObject:@"kappa" forKey:[LBRGreekString stringByChar:UNICODE_KAPPA]];
        [dict setObject:@"lambda" forKey:[LBRGreekString stringByChar:UNICODE_LAMBDA]];
        [dict setObject:@"mi" forKey:[LBRGreekString stringByChar:UNICODE_MI]];
        [dict setObject:@"ni" forKey:[LBRGreekString stringByChar:UNICODE_NI]];
        [dict setObject:@"xi" forKey:[LBRGreekString stringByChar:UNICODE_XI]];
        [dict setObject:@"omicron" forKey:[LBRGreekString stringByChar:UNICODE_OMICRON]];
        [dict setObject:@"pi" forKey:[LBRGreekString stringByChar:UNICODE_PI]];
        [dict setObject:@"rho" forKey:[LBRGreekString stringByChar:UNICODE_RHO]];
        [dict setObject:@"sigma" forKey:[LBRGreekString stringByChar:UNICODE_SIGMA]];
        //[dict setObject:@"sigma f" forKey:[LBRGreekString stringByChar:UNICODE_SIGMA_FINAL]];
        [dict setObject:@"tau" forKey:[LBRGreekString stringByChar:UNICODE_TAU]];
        [dict setObject:@"upsilon" forKey:[LBRGreekString stringByChar:UNICODE_UPSILON]];
        [dict setObject:@"phi" forKey:[LBRGreekString stringByChar:UNICODE_PHI]];
        [dict setObject:@"chi" forKey:[LBRGreekString stringByChar:UNICODE_CHI]];
        [dict setObject:@"psi" forKey:[LBRGreekString stringByChar:UNICODE_PSI]];
        [dict setObject:@"omega" forKey:[LBRGreekString stringByChar:UNICODE_OMEGA]];
        [dict setObject:@"digamma" forKey:[LBRGreekString stringByChar:UNICODE_DIGAMMA]];
        letterDescriptionDictionary = [NSDictionary dictionaryWithDictionary:dict];
        
        [dict removeAllObjects];
        [dict setObject:@"spirito dolce" forKey:[NSString stringWithFormat:@"%d", LBR_LETTER_SIGN_PSILI]];
        [dict setObject:@"spirito aspro" forKey:[NSString stringWithFormat:@"%d", LBR_LETTER_SIGN_DASIA]];
        [dict setObject:@"spirito dolce e accento grave" forKey:[NSString stringWithFormat:@"%d", LBR_LETTER_SIGN_PSILI_VARIA]];
        [dict setObject:@"spirito aspro e accento grave" forKey:[NSString stringWithFormat:@"%d", LBR_LETTER_SIGN_DASIA_VARIA]];
        [dict setObject:@"spirito dolce e accento acuto" forKey:[NSString stringWithFormat:@"%d", LBR_LETTER_SIGN_PSILI_OXIA]];
        [dict setObject:@"spirito aspro e accento acuto" forKey:[NSString stringWithFormat:@"%d", LBR_LETTER_SIGN_DASIA_OXIA]];
        [dict setObject:@"spirito dolce e accento circonflesso" forKey:[NSString stringWithFormat:@"%d", LBR_LETTER_SIGN_PSILI_PERISPOMENI]];
        [dict setObject:@"spirito aspro e accento circonflesso" forKey:[NSString stringWithFormat:@"%d", LBR_LETTER_SIGN_DASIA_PERISPOMENI]];
        [dict setObject:@"accento grave" forKey:[NSString stringWithFormat:@"%d", LBR_LETTER_SIGN_VARIA]];
        [dict setObject:@"accento acuto" forKey:[NSString stringWithFormat:@"%d", LBR_LETTER_SIGN_OXIA]];
        [dict setObject:@"spirito dolce e iota sottoscritto" forKey:[NSString stringWithFormat:@"%d", LBR_LETTER_SIGN_PSILI_YPOGERGRAMMENI]];
        [dict setObject:@"spirito aspro e iota sottoscritto" forKey:[NSString stringWithFormat:@"%d", LBR_LETTER_SIGN_DASIA_YPOGERGRAMMENI]];
        [dict setObject:@"spirito dolce, accento grave e iota sottoscritto" forKey:[NSString stringWithFormat:@"%d", LBR_LETTER_SIGN_PSILI_VARIA_YPOGERGRAMMENI]];
        [dict setObject:@"spirito aspro, accento grave e iota sottoscritto" forKey:[NSString stringWithFormat:@"%d", LBR_LETTER_SIGN_DASIA_VARIA_YPOGERGRAMMENI]];
        [dict setObject:@"spirito dolce, accento acuto e iota sottoscritto" forKey:[NSString stringWithFormat:@"%d", LBR_LETTER_SIGN_PSILI_OXIA_YPOGERGRAMMENI]];
        [dict setObject:@"spirito aspro, accento acuto e iota sottoscritto" forKey:[NSString stringWithFormat:@"%d", LBR_LETTER_SIGN_DASIA_OXIA_YPOGERGRAMMENI]];
        [dict setObject:@"spirito dolce, accento circonflesso e iota sottoscritto" forKey:[NSString stringWithFormat:@"%d", LBR_LETTER_SIGN_PSILI_PERISPOMENI_YPOGERGRAMMENI]];
        [dict setObject:@"spirito aspro, accento circonflesso e iota sottoscritto" forKey:[NSString stringWithFormat:@"%d", LBR_LETTER_SIGN_DASIA_PERISPOMENI_YPOGERGRAMMENI]];
        [dict setObject:@"breve" forKey:[NSString stringWithFormat:@"%d", LBR_LETTER_SIGN_VRACHY]];
        [dict setObject:@"lunga" forKey:[NSString stringWithFormat:@"%d", LBR_LETTER_SIGN_MACRON]];
        [dict setObject:@"accento grave e iota sottoscritto" forKey:[NSString stringWithFormat:@"%d", LBR_LETTER_SIGN_VARIA_YPOGERGRAMMENI]];
        [dict setObject:@"iota sottoscritto" forKey:[NSString stringWithFormat:@"%d", LBR_LETTER_SIGN_YPOGERGRAMMENI]];
        [dict setObject:@"accento acuto e iota sottoscritto" forKey:[NSString stringWithFormat:@"%d", LBR_LETTER_SIGN_OXIA_YPOGERGRAMMENI]];
        [dict setObject:@"accento circonflesso" forKey:[NSString stringWithFormat:@"%d", LBR_LETTER_SIGN_PERISPOMENI]];
        [dict setObject:@"accento circonflesso e iota sottoscritto" forKey:[NSString stringWithFormat:@"%d", LBR_LETTER_SIGN_PERISPOMENI_YPOGERGRAMMENI]];
        signDescriptionlDictionary = [NSDictionary dictionaryWithDictionary:dict];
    }
}

+(void)initialize {
    [self initialize_descriptions];
}

#pragma mark Utils
+(unichar)toPlain:(unichar)c {
    unichar plainC = UNICODE_NONE;
    LBRLetterSign letterSign = LBR_LETTER_SIGN_NONE;
    [LBRGreekChar decomposeChar:c toLetter:&plainC toSign:&letterSign];
    return plainC;
}

+(BOOL)isPlain:(unichar)c {
    BOOL retBool = false;
    unichar plainC = UNICODE_NONE;
    LBRLetterSign letterSign = LBR_LETTER_SIGN_NONE;
    [LBRGreekChar decomposeChar:c toLetter:&plainC toSign:&letterSign];
    if (letterSign == LBR_LETTER_SIGN_NONE) {
        retBool = true;
    }
    return retBool;
}

+(BOOL)hasVariants:(unichar)c {
    BOOL retBool = false;
    unichar ch = [LBRGreekChar toLowerCase:c];
    switch (ch) {
        case UNICODE_ALPHA:
        case UNICODE_EPSILON:
        case UNICODE_ETA:
        case UNICODE_IOTA:
        case UNICODE_OMICRON:
        case UNICODE_UPSILON:
        case UNICODE_OMEGA:
        case UNICODE_RHO:
            retBool = true;
            break;
        default:
            break;
    }
    return retBool;
}

#pragma mark
#pragma mark Compose letter and sign
static unichar getAlphaWithSign(LBRLetterSign sign)
{
    unichar retChar = UNICODE_ALPHA;
    
    switch (sign) {
        case LBR_LETTER_SIGN_PSILI:
            retChar = UNICODE_ALPHA_PSILI;
            break;
        case LBR_LETTER_SIGN_DASIA:
            retChar = UNICODE_ALPHA_DASIA;
            break;
        case LBR_LETTER_SIGN_PSILI_VARIA:
            retChar = UNICODE_ALPHA_PSILI_VARIA;
            break;
        case LBR_LETTER_SIGN_DASIA_VARIA:
            retChar = UNICODE_ALPHA_DASIA_VARIA;
            break;
        case LBR_LETTER_SIGN_PSILI_OXIA:
            retChar = UNICODE_ALPHA_PSILI_OXIA;
            break;
        case LBR_LETTER_SIGN_DASIA_OXIA:
            retChar = UNICODE_ALPHA_DASIA_OXIA;
            break;
        case LBR_LETTER_SIGN_PSILI_PERISPOMENI:
            retChar = UNICODE_ALPHA_PSILI_PERISPOMENI;
            break;
        case LBR_LETTER_SIGN_DASIA_PERISPOMENI:
            retChar = UNICODE_ALPHA_DASIA_PERISPOMENI;
            break;
        case LBR_LETTER_SIGN_VARIA:
            retChar = UNICODE_ALPHA_VARIA;
            break;
        case LBR_LETTER_SIGN_OXIA:
            retChar = UNICODE_ALPHA_OXIA;
            break;
        case LBR_LETTER_SIGN_PSILI_YPOGERGRAMMENI:
            retChar = UNICODE_ALPHA_PSILI_YPOGERGRAMMENI;
            break;
        case LBR_LETTER_SIGN_DASIA_YPOGERGRAMMENI:
            retChar = UNICODE_ALPHA_DASIA_YPOGERGRAMMENI;
            break;
        case LBR_LETTER_SIGN_PSILI_VARIA_YPOGERGRAMMENI:
            retChar = UNICODE_ALPHA_PSILI_VARIA_YPOGERGRAMMENI;
            break;
        case LBR_LETTER_SIGN_DASIA_VARIA_YPOGERGRAMMENI:
            retChar = UNICODE_ALPHA_DASIA_VARIA_YPOGERGRAMMENI;
            break;
        case LBR_LETTER_SIGN_PSILI_OXIA_YPOGERGRAMMENI:
            retChar = UNICODE_ALPHA_PSILI_OXIA_YPOGERGRAMMENI;
            break;
        case LBR_LETTER_SIGN_DASIA_OXIA_YPOGERGRAMMENI:
            retChar = UNICODE_ALPHA_DASIA_OXIA_YPOGERGRAMMENI;
            break;
        case LBR_LETTER_SIGN_PSILI_PERISPOMENI_YPOGERGRAMMENI:
            retChar = UNICODE_ALPHA_PSILI_PERISPOMENI_YPOGERGRAMMENI;
            break;
        case LBR_LETTER_SIGN_DASIA_PERISPOMENI_YPOGERGRAMMENI:
            retChar = UNICODE_ALPHA_DASIA_PERISPOMENI_YPOGERGRAMMENI;
            break;
        case LBR_LETTER_SIGN_VRACHY:
            retChar = UNICODE_ALPHA_VRACHY;
            break;
        case LBR_LETTER_SIGN_MACRON:
            retChar = UNICODE_ALPHA_MACRON;
            break;
        case LBR_LETTER_SIGN_VARIA_YPOGERGRAMMENI:
            retChar = UNICODE_ALPHA_VARIA_YPOGERGRAMMENI;
            break;
        case LBR_LETTER_SIGN_YPOGERGRAMMENI:
            retChar = UNICODE_ALPHA_YPOGERGRAMMENI;
            break;
        case LBR_LETTER_SIGN_OXIA_YPOGERGRAMMENI:
            retChar = UNICODE_ALPHA_OXIA_YPOGERGRAMMENI;
            break;
        case LBR_LETTER_SIGN_PERISPOMENI:
            retChar = UNICODE_ALPHA_PERISPOMENI;
            break;
        case LBR_LETTER_SIGN_PERISPOMENI_YPOGERGRAMMENI:
            retChar = UNICODE_ALPHA_PERISPOMENI_YPOGERGRAMMENI;
            break;
        case LBR_LETTER_SIGN_MACRON_OXIA:
            retChar = UNICODE_ALPHA_MACRON_OXIA;
            break;
        case LBR_LETTER_SIGN_MACRON_PSILI:
            retChar = UNICODE_ALPHA_MACRON_PSILI;
            break;
        case LBR_LETTER_SIGN_MACRON_DASIA:
            retChar = UNICODE_ALPHA_MACRON_DASIA;
            break;
        case LBR_LETTER_SIGN_VRACHY_OXIA:
            retChar = UNICODE_ALPHA_VRACHY_OXIA;
            break;
        default:
            break;
    }
    
    return retChar;
}

static unichar getEpsilonWithSign(LBRLetterSign sign)
{
    unichar retChar = UNICODE_EPSILON;
    
    switch (sign) {
        case LBR_LETTER_SIGN_PSILI:
            retChar = UNICODE_EPSILON_PSILI;
            break;
        case LBR_LETTER_SIGN_DASIA:
            retChar = UNICODE_EPSILON_DASIA;
            break;
        case LBR_LETTER_SIGN_PSILI_VARIA:
            retChar = UNICODE_EPSILON_PSILI_VARIA;
            break;
        case LBR_LETTER_SIGN_DASIA_VARIA:
            retChar = UNICODE_EPSILON_DASIA_VARIA;
            break;
        case LBR_LETTER_SIGN_PSILI_OXIA:
            retChar = UNICODE_EPSILON_PSILI_OXIA;
            break;
        case LBR_LETTER_SIGN_DASIA_OXIA:
            retChar = UNICODE_EPSILON_DASIA_OXIA;
            break;
        case LBR_LETTER_SIGN_VARIA:
            retChar = UNICODE_EPSILON_VARIA;
            break;
        case LBR_LETTER_SIGN_OXIA:
            retChar = UNICODE_EPSILON_OXIA;
            break;
        default:
            break;
    }
    
    return retChar;
}

static unichar getEtaWithSign(LBRLetterSign sign)
{
    unichar retChar = UNICODE_ETA;
    
    switch (sign) {
        case LBR_LETTER_SIGN_PSILI:
            retChar = UNICODE_ETA_PSILI;
            break;
        case LBR_LETTER_SIGN_DASIA:
            retChar = UNICODE_ETA_DASIA;
            break;
        case LBR_LETTER_SIGN_PSILI_VARIA:
            retChar = UNICODE_ETA_PSILI_VARIA;
            break;
        case LBR_LETTER_SIGN_DASIA_VARIA:
            retChar = UNICODE_ETA_DASIA_VARIA;
            break;
        case LBR_LETTER_SIGN_PSILI_OXIA:
            retChar = UNICODE_ETA_PSILI_OXIA;
            break;
        case LBR_LETTER_SIGN_DASIA_OXIA:
            retChar = UNICODE_ETA_DASIA_OXIA;
            break;
        case LBR_LETTER_SIGN_PSILI_PERISPOMENI:
            retChar = UNICODE_ETA_PSILI_PERISPOMENI;
            break;
        case LBR_LETTER_SIGN_DASIA_PERISPOMENI:
            retChar = UNICODE_ETA_DASIA_PERISPOMENI;
            break;
        case LBR_LETTER_SIGN_VARIA:
            retChar = UNICODE_ETA_VARIA;
            break;
        case LBR_LETTER_SIGN_OXIA:
            retChar = UNICODE_ETA_OXIA;
            break;
        case LBR_LETTER_SIGN_PSILI_YPOGERGRAMMENI:
            retChar = UNICODE_ETA_PSILI_YPOGERGRAMMENI;
            break;
        case LBR_LETTER_SIGN_DASIA_YPOGERGRAMMENI:
            retChar = UNICODE_ETA_DASIA_YPOGERGRAMMENI;
            break;
        case LBR_LETTER_SIGN_PSILI_VARIA_YPOGERGRAMMENI:
            retChar = UNICODE_ETA_PSILI_VARIA_YPOGERGRAMMENI;
            break;
        case LBR_LETTER_SIGN_DASIA_VARIA_YPOGERGRAMMENI:
            retChar = UNICODE_ETA_DASIA_VARIA_YPOGERGRAMMENI;
            break;
        case LBR_LETTER_SIGN_PSILI_OXIA_YPOGERGRAMMENI:
            retChar = UNICODE_ETA_PSILI_OXIA_YPOGERGRAMMENI;
            break;
        case LBR_LETTER_SIGN_DASIA_OXIA_YPOGERGRAMMENI:
            retChar = UNICODE_ETA_DASIA_OXIA_YPOGERGRAMMENI;
            break;
        case LBR_LETTER_SIGN_PSILI_PERISPOMENI_YPOGERGRAMMENI:
            retChar = UNICODE_ETA_PSILI_PERISPOMENI_YPOGERGRAMMENI;
            break;
        case LBR_LETTER_SIGN_DASIA_PERISPOMENI_YPOGERGRAMMENI:
            retChar = UNICODE_ETA_DASIA_PERISPOMENI_YPOGERGRAMMENI;
            break;
        case LBR_LETTER_SIGN_VARIA_YPOGERGRAMMENI:
            retChar = UNICODE_ETA_VARIA_YPOGERGRAMMENI;
            break;
        case LBR_LETTER_SIGN_YPOGERGRAMMENI:
            retChar = UNICODE_ETA_YPOGERGRAMMENI;
            break;
        case LBR_LETTER_SIGN_OXIA_YPOGERGRAMMENI:
            retChar = UNICODE_ETA_OXIA_YPOGERGRAMMENI;
            break;
        case LBR_LETTER_SIGN_PERISPOMENI:
            retChar = UNICODE_ETA_PERISPOMENI;
            break;
        case LBR_LETTER_SIGN_PERISPOMENI_YPOGERGRAMMENI:
            retChar = UNICODE_ETA_PERISPOMENI_YPOGERGRAMMENI;
            break;
        default:
            break;
    }
    
    return retChar;
}
static unichar getOmicronWithSign(LBRLetterSign sign)
{
    unichar retChar = UNICODE_OMICRON;
    
    switch (sign) {
        case LBR_LETTER_SIGN_PSILI:
            retChar = UNICODE_OMICRON_PSILI;
            break;
        case LBR_LETTER_SIGN_DASIA:
            retChar = UNICODE_OMICRON_DASIA;
            break;
        case LBR_LETTER_SIGN_PSILI_VARIA:
            retChar = UNICODE_OMICRON_PSILI_VARIA;
            break;
        case LBR_LETTER_SIGN_DASIA_VARIA:
            retChar = UNICODE_OMICRON_DASIA_VARIA;
            break;
        case LBR_LETTER_SIGN_PSILI_OXIA:
            retChar = UNICODE_OMICRON_PSILI_OXIA;
            break;
        case LBR_LETTER_SIGN_DASIA_OXIA:
            retChar = UNICODE_OMICRON_DASIA_OXIA;
            break;
        case LBR_LETTER_SIGN_VARIA:
            retChar = UNICODE_OMICRON_VARIA;
            break;
        case LBR_LETTER_SIGN_OXIA:
            retChar = UNICODE_OMICRON_OXIA;
            break;
        default:
            break;
    }
    
    return retChar;
}

static unichar getIotaWithSign(LBRLetterSign sign)
{
    unichar retChar = UNICODE_IOTA;
    
    switch (sign) {
        case LBR_LETTER_SIGN_PSILI:
            retChar = UNICODE_IOTA_PSILI;
            break;
        case LBR_LETTER_SIGN_DASIA:
            retChar = UNICODE_IOTA_DASIA;
            break;
        case LBR_LETTER_SIGN_PSILI_VARIA:
            retChar = UNICODE_IOTA_PSILI_VARIA;
            break;
        case LBR_LETTER_SIGN_DASIA_VARIA:
            retChar = UNICODE_IOTA_DASIA_VARIA;
            break;
        case LBR_LETTER_SIGN_PSILI_OXIA:
            retChar = UNICODE_IOTA_PSILI_OXIA;
            break;
        case LBR_LETTER_SIGN_DASIA_OXIA:
            retChar = UNICODE_IOTA_DASIA_OXIA;
            break;
        case LBR_LETTER_SIGN_PSILI_PERISPOMENI:
            retChar = UNICODE_IOTA_PSILI_PERISPOMENI;
            break;
        case LBR_LETTER_SIGN_DASIA_PERISPOMENI:
            retChar = UNICODE_IOTA_DASIA_PERISPOMENI;
            break;
        case LBR_LETTER_SIGN_VARIA:
            retChar = UNICODE_IOTA_VARIA;
            break;
        case LBR_LETTER_SIGN_OXIA:
            retChar = UNICODE_IOTA_OXIA;
            break;
        case LBR_LETTER_SIGN_VRACHY:
            retChar = UNICODE_IOTA_VRACHY;
            break;
        case LBR_LETTER_SIGN_MACRON:
            retChar = UNICODE_IOTA_MACRON;
            break;
        case LBR_LETTER_SIGN_PERISPOMENI:
            retChar = UNICODE_IOTA_PERISPOMENI;
            break;
        default:
            break;
    }
    
    return retChar;
}
static unichar getUpsilonWithSign(LBRLetterSign sign)
{
    unichar retChar = UNICODE_UPSILON;
    
    switch (sign) {
        case LBR_LETTER_SIGN_PSILI:
            retChar = UNICODE_UPSILON_PSILI;
            break;
        case LBR_LETTER_SIGN_DASIA:
            retChar = UNICODE_UPSILON_DASIA;
            break;
        case LBR_LETTER_SIGN_PSILI_VARIA:
            retChar = UNICODE_UPSILON_PSILI_VARIA;
            break;
        case LBR_LETTER_SIGN_DASIA_VARIA:
            retChar = UNICODE_UPSILON_DASIA_VARIA;
            break;
        case LBR_LETTER_SIGN_PSILI_OXIA:
            retChar = UNICODE_UPSILON_PSILI_OXIA;
            break;
        case LBR_LETTER_SIGN_DASIA_OXIA:
            retChar = UNICODE_UPSILON_DASIA_OXIA;
            break;
        case LBR_LETTER_SIGN_PSILI_PERISPOMENI:
            retChar = UNICODE_UPSILON_PSILI_PERISPOMENI;
            break;
        case LBR_LETTER_SIGN_DASIA_PERISPOMENI:
            retChar = UNICODE_UPSILON_DASIA_PERISPOMENI;
            break;
        case LBR_LETTER_SIGN_VARIA:
            retChar = UNICODE_UPSILON_VARIA;
            break;
        case LBR_LETTER_SIGN_OXIA:
            retChar = UNICODE_UPSILON_OXIA;
            break;
        case LBR_LETTER_SIGN_VRACHY:
            retChar = UNICODE_UPSILON_VRACHY;
            break;
        case LBR_LETTER_SIGN_MACRON:
            retChar = UNICODE_UPSILON_MACRON;
            break;
        case LBR_LETTER_SIGN_PERISPOMENI:
            retChar = UNICODE_UPSILON_PERISPOMENI;
            break;
        default:
            break;
    }
    
    return retChar;
}
static unichar getOmegaWithSign(LBRLetterSign sign)
{
    unichar retChar = UNICODE_OMEGA;
    
    switch (sign) {
        case LBR_LETTER_SIGN_PSILI:
            retChar = UNICODE_OMEGA_PSILI;
            break;
        case LBR_LETTER_SIGN_DASIA:
            retChar = UNICODE_OMEGA_DASIA;
            break;
        case LBR_LETTER_SIGN_PSILI_VARIA:
            retChar = UNICODE_OMEGA_PSILI_VARIA;
            break;
        case LBR_LETTER_SIGN_DASIA_VARIA:
            retChar = UNICODE_OMEGA_DASIA_VARIA;
            break;
        case LBR_LETTER_SIGN_PSILI_OXIA:
            retChar = UNICODE_OMEGA_PSILI_OXIA;
            break;
        case LBR_LETTER_SIGN_DASIA_OXIA:
            retChar = UNICODE_OMEGA_DASIA_OXIA;
            break;
        case LBR_LETTER_SIGN_PSILI_PERISPOMENI:
            retChar = UNICODE_OMEGA_PSILI_PERISPOMENI;
            break;
        case LBR_LETTER_SIGN_DASIA_PERISPOMENI:
            retChar = UNICODE_OMEGA_DASIA_PERISPOMENI;
            break;
        case LBR_LETTER_SIGN_VARIA:
            retChar = UNICODE_OMEGA_VARIA;
            break;
        case LBR_LETTER_SIGN_OXIA:
            retChar = UNICODE_OMEGA_OXIA;
            break;
        case LBR_LETTER_SIGN_PSILI_YPOGERGRAMMENI:
            retChar = UNICODE_OMEGA_PSILI_YPOGERGRAMMENI;
            break;
        case LBR_LETTER_SIGN_DASIA_YPOGERGRAMMENI:
            retChar = UNICODE_OMEGA_DASIA_YPOGERGRAMMENI;
            break;
        case LBR_LETTER_SIGN_PSILI_VARIA_YPOGERGRAMMENI:
            retChar = UNICODE_OMEGA_PSILI_VARIA_YPOGERGRAMMENI;
            break;
        case LBR_LETTER_SIGN_DASIA_VARIA_YPOGERGRAMMENI:
            retChar = UNICODE_OMEGA_DASIA_VARIA_YPOGERGRAMMENI;
            break;
        case LBR_LETTER_SIGN_PSILI_OXIA_YPOGERGRAMMENI:
            retChar = UNICODE_OMEGA_PSILI_OXIA_YPOGERGRAMMENI;
            break;
        case LBR_LETTER_SIGN_DASIA_OXIA_YPOGERGRAMMENI:
            retChar = UNICODE_OMEGA_DASIA_OXIA_YPOGERGRAMMENI;
            break;
        case LBR_LETTER_SIGN_PSILI_PERISPOMENI_YPOGERGRAMMENI:
            retChar = UNICODE_OMEGA_PSILI_PERISPOMENI_YPOGERGRAMMENI;
            break;
        case LBR_LETTER_SIGN_DASIA_PERISPOMENI_YPOGERGRAMMENI:
            retChar = UNICODE_OMEGA_DASIA_PERISPOMENI_YPOGERGRAMMENI;
            break;
        case LBR_LETTER_SIGN_VARIA_YPOGERGRAMMENI:
            retChar = UNICODE_OMEGA_VARIA_YPOGERGRAMMENI;
            break;
        case LBR_LETTER_SIGN_YPOGERGRAMMENI:
            retChar = UNICODE_OMEGA_YPOGERGRAMMENI;
            break;
        case LBR_LETTER_SIGN_OXIA_YPOGERGRAMMENI:
            retChar = UNICODE_OMEGA_OXIA_YPOGERGRAMMENI;
            break;
        case LBR_LETTER_SIGN_PERISPOMENI:
            retChar = UNICODE_OMEGA_PERISPOMENI;
            break;
        case LBR_LETTER_SIGN_PERISPOMENI_YPOGERGRAMMENI:
            retChar = UNICODE_OMEGA_PERISPOMENI_YPOGERGRAMMENI;
            break;
        default:
            break;
    }
    
    return retChar;
}

static unichar getRhoWithSign(LBRLetterSign sign)
{
    unichar retChar = UNICODE_RHO;
    
    switch (sign) {
        case LBR_LETTER_SIGN_DASIA:
            retChar = UNICODE_RHO_DASIA;
            break;
        default:
            break;
    }
    
    return retChar;
}

static unichar getCapitalAlphaWithSign(LBRLetterSign sign)
{
    unichar ch = getAlphaWithSign(sign);
    return [LBRGreekChar toUpperCase:ch];
}

static unichar getCapitalEpsilonWithSign(LBRLetterSign sign)
{
    unichar ch = getEpsilonWithSign(sign);
    return [LBRGreekChar toUpperCase:ch];
}

static unichar getCapitalEtaWithSign(LBRLetterSign sign)
{
    unichar ch = getEtaWithSign(sign);
    return [LBRGreekChar toUpperCase:ch];
}

static unichar getCapitalOmicronWithSign(LBRLetterSign sign)
{
    unichar ch = getOmicronWithSign(sign);
    return [LBRGreekChar toUpperCase:ch];
}

static unichar getCapitalIotaWithSign(LBRLetterSign sign)
{
    unichar ch = getIotaWithSign(sign);
    return [LBRGreekChar toUpperCase:ch];
}

static unichar getCapitalUpsilonWithSign(LBRLetterSign sign)
{
    unichar ch = getUpsilonWithSign(sign);
    return [LBRGreekChar toUpperCase:ch];
}

static unichar getCapitalOmegaWithSign(LBRLetterSign sign)
{
    unichar ch = getOmegaWithSign(sign);
    return [LBRGreekChar toUpperCase:ch];
}

static unichar getCapitalRhoWithSign(LBRLetterSign sign)
{
    unichar ch = getRhoWithSign(sign);
    return [LBRGreekChar toUpperCase:ch];
}

#pragma mark Compose letter and sign
+(unichar)composeCharFromLetter:(unichar)plainLetter withSign:(LBRLetterSign)sign
{
    unichar retChar = plainLetter;
    switch (plainLetter) {
        case UNICODE_ALPHA:
            retChar = getAlphaWithSign(sign);
            break;
        case UNICODE_EPSILON:
            retChar = getEpsilonWithSign(sign);
            break;
        case UNICODE_ETA:
            retChar = getEtaWithSign(sign);
            break;
        case UNICODE_IOTA:
            retChar = getIotaWithSign(sign);
            break;
        case UNICODE_OMICRON:
            retChar = getOmicronWithSign(sign);
            break;
        case UNICODE_UPSILON:
            retChar = getUpsilonWithSign(sign);
            break;
        case UNICODE_OMEGA:
            retChar = getOmegaWithSign(sign);
            break;
        case UNICODE_RHO:
            retChar = getRhoWithSign(sign);
            break;
        case UNICODE_CAPITAL_ALPHA:
            retChar = getCapitalAlphaWithSign(sign);
            break;
        case UNICODE_CAPITAL_EPSILON:
            retChar = getCapitalEpsilonWithSign(sign);
            break;
        case UNICODE_CAPITAL_ETA:
            retChar = getCapitalEtaWithSign(sign);
            break;
        case UNICODE_CAPITAL_IOTA:
            retChar = getCapitalIotaWithSign(sign);
            break;
        case UNICODE_CAPITAL_OMICRON:
            retChar = getCapitalOmicronWithSign(sign);
            break;
        case UNICODE_CAPITAL_UPSILON:
            retChar = getCapitalUpsilonWithSign(sign);
            break;
        case UNICODE_CAPITAL_OMEGA:
            retChar = getCapitalOmegaWithSign(sign);
            break;
        case UNICODE_CAPITAL_RHO:
            retChar = getCapitalRhoWithSign(sign);
            break;
        default:
            break;
    }
    return retChar;
}

#pragma mark Decompose letter and symobol
// Regular expression:
// find: (UNICODE_CAPITAL_[A_Z]*_)([A-Z_]*) = 0x0...,
// replace: case \1\2: *plainLetter = \1\2; *sign = LBR_LETTER_SIGN_\2; break;
+(void)decomposeChar:(unichar)signChar toLetter:(unichar*)plainLetter toSign:(LBRLetterSign*)sign {
    *plainLetter = UNICODE_NONE;
    switch (signChar)
    {
        case UNICODE_ALPHA: *plainLetter = UNICODE_ALPHA; *sign = LBR_LETTER_SIGN_NONE; break;
        case UNICODE_ALPHA_PSILI: *plainLetter = UNICODE_ALPHA; *sign = LBR_LETTER_SIGN_PSILI; break;
        case UNICODE_ALPHA_DASIA: *plainLetter = UNICODE_ALPHA; *sign = LBR_LETTER_SIGN_DASIA; break;
        case UNICODE_ALPHA_PSILI_VARIA: *plainLetter = UNICODE_ALPHA; *sign = LBR_LETTER_SIGN_PSILI_VARIA; break;
        case UNICODE_ALPHA_DASIA_VARIA: *plainLetter = UNICODE_ALPHA; *sign = LBR_LETTER_SIGN_DASIA_VARIA; break;
        case UNICODE_ALPHA_PSILI_OXIA: *plainLetter = UNICODE_ALPHA; *sign = LBR_LETTER_SIGN_PSILI_OXIA; break;
        case UNICODE_ALPHA_DASIA_OXIA: *plainLetter = UNICODE_ALPHA; *sign = LBR_LETTER_SIGN_DASIA_OXIA; break;
        case UNICODE_ALPHA_PSILI_PERISPOMENI: *plainLetter = UNICODE_ALPHA; *sign = LBR_LETTER_SIGN_PSILI_PERISPOMENI; break;
        case UNICODE_ALPHA_DASIA_PERISPOMENI: *plainLetter = UNICODE_ALPHA; *sign = LBR_LETTER_SIGN_DASIA_PERISPOMENI; break;
        case UNICODE_ALPHA_VARIA: *plainLetter = UNICODE_ALPHA; *sign = LBR_LETTER_SIGN_VARIA; break;
        case UNICODE_ALPHA_OXIA: *plainLetter = UNICODE_ALPHA; *sign = LBR_LETTER_SIGN_OXIA; break;
        case UNICODE_ALPHA_PSILI_YPOGERGRAMMENI: *plainLetter = UNICODE_ALPHA; *sign = LBR_LETTER_SIGN_PSILI_YPOGERGRAMMENI; break;
        case UNICODE_ALPHA_DASIA_YPOGERGRAMMENI: *plainLetter = UNICODE_ALPHA; *sign = LBR_LETTER_SIGN_DASIA_YPOGERGRAMMENI; break;
        case UNICODE_ALPHA_PSILI_VARIA_YPOGERGRAMMENI: *plainLetter = UNICODE_ALPHA; *sign = LBR_LETTER_SIGN_PSILI_VARIA_YPOGERGRAMMENI; break;
        case UNICODE_ALPHA_DASIA_VARIA_YPOGERGRAMMENI: *plainLetter = UNICODE_ALPHA; *sign = LBR_LETTER_SIGN_DASIA_VARIA_YPOGERGRAMMENI; break;
        case UNICODE_ALPHA_PSILI_OXIA_YPOGERGRAMMENI: *plainLetter = UNICODE_ALPHA; *sign = LBR_LETTER_SIGN_PSILI_OXIA_YPOGERGRAMMENI; break;
        case UNICODE_ALPHA_DASIA_OXIA_YPOGERGRAMMENI: *plainLetter = UNICODE_ALPHA; *sign = LBR_LETTER_SIGN_DASIA_OXIA_YPOGERGRAMMENI; break;
        case UNICODE_ALPHA_PSILI_PERISPOMENI_YPOGERGRAMMENI: *plainLetter = UNICODE_ALPHA; *sign = LBR_LETTER_SIGN_PSILI_PERISPOMENI_YPOGERGRAMMENI; break;
        case UNICODE_ALPHA_DASIA_PERISPOMENI_YPOGERGRAMMENI: *plainLetter = UNICODE_ALPHA; *sign = LBR_LETTER_SIGN_DASIA_PERISPOMENI_YPOGERGRAMMENI; break;
        case UNICODE_ALPHA_VRACHY: *plainLetter = UNICODE_ALPHA; *sign = LBR_LETTER_SIGN_VRACHY; break;
        case UNICODE_ALPHA_MACRON: *plainLetter = UNICODE_ALPHA; *sign = LBR_LETTER_SIGN_MACRON; break;
        case UNICODE_ALPHA_VARIA_YPOGERGRAMMENI: *plainLetter = UNICODE_ALPHA; *sign = LBR_LETTER_SIGN_VARIA_YPOGERGRAMMENI; break;
        case UNICODE_ALPHA_YPOGERGRAMMENI: *plainLetter = UNICODE_ALPHA; *sign = LBR_LETTER_SIGN_YPOGERGRAMMENI; break;
        case UNICODE_ALPHA_OXIA_YPOGERGRAMMENI: *plainLetter = UNICODE_ALPHA; *sign = LBR_LETTER_SIGN_OXIA_YPOGERGRAMMENI; break;
        case UNICODE_ALPHA_PERISPOMENI: *plainLetter = UNICODE_ALPHA; *sign = LBR_LETTER_SIGN_PERISPOMENI; break;
        case UNICODE_ALPHA_PERISPOMENI_YPOGERGRAMMENI: *plainLetter = UNICODE_ALPHA; *sign = LBR_LETTER_SIGN_PERISPOMENI_YPOGERGRAMMENI; break;
        case UNICODE_ALPHA_MACRON_OXIA: *plainLetter = UNICODE_ALPHA; *sign = LBR_LETTER_SIGN_MACRON_OXIA; break;
        case UNICODE_ALPHA_MACRON_PSILI: *plainLetter = UNICODE_ALPHA; *sign = LBR_LETTER_SIGN_MACRON_PSILI; break;
        case UNICODE_ALPHA_MACRON_DASIA: *plainLetter = UNICODE_ALPHA; *sign = LBR_LETTER_SIGN_MACRON_DASIA; break;
        case UNICODE_ALPHA_VRACHY_OXIA: *plainLetter = UNICODE_ALPHA; *sign = LBR_LETTER_SIGN_VRACHY_OXIA; break;
            
        case UNICODE_EPSILON: *plainLetter = UNICODE_EPSILON; *sign = LBR_LETTER_SIGN_NONE; break;
        case UNICODE_EPSILON_PSILI: *plainLetter = UNICODE_EPSILON; *sign = LBR_LETTER_SIGN_PSILI; break;
        case UNICODE_EPSILON_DASIA: *plainLetter = UNICODE_EPSILON; *sign = LBR_LETTER_SIGN_DASIA; break;
        case UNICODE_EPSILON_PSILI_VARIA: *plainLetter = UNICODE_EPSILON; *sign = LBR_LETTER_SIGN_PSILI_VARIA; break;
        case UNICODE_EPSILON_DASIA_VARIA: *plainLetter = UNICODE_EPSILON; *sign = LBR_LETTER_SIGN_DASIA_VARIA; break;
        case UNICODE_EPSILON_PSILI_OXIA: *plainLetter = UNICODE_EPSILON; *sign = LBR_LETTER_SIGN_PSILI_OXIA; break;
        case UNICODE_EPSILON_DASIA_OXIA: *plainLetter = UNICODE_EPSILON; *sign = LBR_LETTER_SIGN_DASIA_OXIA; break;
        case UNICODE_EPSILON_VARIA: *plainLetter = UNICODE_EPSILON; *sign = LBR_LETTER_SIGN_VARIA; break;
        case UNICODE_EPSILON_OXIA: *plainLetter = UNICODE_EPSILON; *sign = LBR_LETTER_SIGN_OXIA; break;
            
        case UNICODE_ETA: *plainLetter = UNICODE_ETA; *sign = LBR_LETTER_SIGN_NONE; break;
        case UNICODE_ETA_PSILI: *plainLetter = UNICODE_ETA; *sign = LBR_LETTER_SIGN_PSILI; break;
        case UNICODE_ETA_DASIA: *plainLetter = UNICODE_ETA; *sign = LBR_LETTER_SIGN_DASIA; break;
        case UNICODE_ETA_PSILI_VARIA: *plainLetter = UNICODE_ETA; *sign = LBR_LETTER_SIGN_PSILI_VARIA; break;
        case UNICODE_ETA_DASIA_VARIA: *plainLetter = UNICODE_ETA; *sign = LBR_LETTER_SIGN_DASIA_VARIA; break;
        case UNICODE_ETA_PSILI_OXIA: *plainLetter = UNICODE_ETA; *sign = LBR_LETTER_SIGN_PSILI_OXIA; break;
        case UNICODE_ETA_DASIA_OXIA: *plainLetter = UNICODE_ETA; *sign = LBR_LETTER_SIGN_DASIA_OXIA; break;
        case UNICODE_ETA_PSILI_PERISPOMENI: *plainLetter = UNICODE_ETA; *sign = LBR_LETTER_SIGN_PSILI_PERISPOMENI; break;
        case UNICODE_ETA_DASIA_PERISPOMENI: *plainLetter = UNICODE_ETA; *sign = LBR_LETTER_SIGN_DASIA_PERISPOMENI; break;
        case UNICODE_ETA_VARIA: *plainLetter = UNICODE_ETA; *sign = LBR_LETTER_SIGN_VARIA; break;
        case UNICODE_ETA_OXIA: *plainLetter = UNICODE_ETA; *sign = LBR_LETTER_SIGN_OXIA; break;
        case UNICODE_ETA_PSILI_YPOGERGRAMMENI: *plainLetter = UNICODE_ETA; *sign = LBR_LETTER_SIGN_PSILI_YPOGERGRAMMENI; break;
        case UNICODE_ETA_DASIA_YPOGERGRAMMENI: *plainLetter = UNICODE_ETA; *sign = LBR_LETTER_SIGN_DASIA_YPOGERGRAMMENI; break;
        case UNICODE_ETA_PSILI_VARIA_YPOGERGRAMMENI: *plainLetter = UNICODE_ETA; *sign = LBR_LETTER_SIGN_PSILI_VARIA_YPOGERGRAMMENI; break;
        case UNICODE_ETA_DASIA_VARIA_YPOGERGRAMMENI: *plainLetter = UNICODE_ETA; *sign = LBR_LETTER_SIGN_DASIA_VARIA_YPOGERGRAMMENI; break;
        case UNICODE_ETA_PSILI_OXIA_YPOGERGRAMMENI: *plainLetter = UNICODE_ETA; *sign = LBR_LETTER_SIGN_PSILI_OXIA_YPOGERGRAMMENI; break;
        case UNICODE_ETA_DASIA_OXIA_YPOGERGRAMMENI: *plainLetter = UNICODE_ETA; *sign = LBR_LETTER_SIGN_DASIA_OXIA_YPOGERGRAMMENI; break;
        case UNICODE_ETA_PSILI_PERISPOMENI_YPOGERGRAMMENI: *plainLetter = UNICODE_ETA; *sign = LBR_LETTER_SIGN_PSILI_PERISPOMENI_YPOGERGRAMMENI; break;
        case UNICODE_ETA_DASIA_PERISPOMENI_YPOGERGRAMMENI: *plainLetter = UNICODE_ETA; *sign = LBR_LETTER_SIGN_DASIA_PERISPOMENI_YPOGERGRAMMENI; break;
        case UNICODE_ETA_VARIA_YPOGERGRAMMENI: *plainLetter = UNICODE_ETA; *sign = LBR_LETTER_SIGN_VARIA_YPOGERGRAMMENI; break;
        case UNICODE_ETA_YPOGERGRAMMENI: *plainLetter = UNICODE_ETA; *sign = LBR_LETTER_SIGN_YPOGERGRAMMENI; break;
        case UNICODE_ETA_OXIA_YPOGERGRAMMENI: *plainLetter = UNICODE_ETA; *sign = LBR_LETTER_SIGN_OXIA_YPOGERGRAMMENI; break;
        case UNICODE_ETA_PERISPOMENI: *plainLetter = UNICODE_ETA; *sign = LBR_LETTER_SIGN_PERISPOMENI; break;
        case UNICODE_ETA_PERISPOMENI_YPOGERGRAMMENI: *plainLetter = UNICODE_ETA; *sign = LBR_LETTER_SIGN_PERISPOMENI_YPOGERGRAMMENI; break;
            
        case UNICODE_IOTA: *plainLetter = UNICODE_IOTA; *sign = LBR_LETTER_SIGN_NONE; break;
        case UNICODE_IOTA_PSILI: *plainLetter = UNICODE_IOTA; *sign = LBR_LETTER_SIGN_PSILI; break;
        case UNICODE_IOTA_DASIA: *plainLetter = UNICODE_IOTA; *sign = LBR_LETTER_SIGN_DASIA; break;
        case UNICODE_IOTA_PSILI_VARIA: *plainLetter = UNICODE_IOTA; *sign = LBR_LETTER_SIGN_PSILI_VARIA; break;
        case UNICODE_IOTA_DASIA_VARIA: *plainLetter = UNICODE_IOTA; *sign = LBR_LETTER_SIGN_DASIA_VARIA; break;
        case UNICODE_IOTA_PSILI_OXIA: *plainLetter = UNICODE_IOTA; *sign = LBR_LETTER_SIGN_PSILI_OXIA; break;
        case UNICODE_IOTA_DASIA_OXIA: *plainLetter = UNICODE_IOTA; *sign = LBR_LETTER_SIGN_DASIA_OXIA; break;
        case UNICODE_IOTA_PSILI_PERISPOMENI: *plainLetter = UNICODE_IOTA; *sign = LBR_LETTER_SIGN_PSILI_PERISPOMENI; break;
        case UNICODE_IOTA_DASIA_PERISPOMENI: *plainLetter = UNICODE_IOTA; *sign = LBR_LETTER_SIGN_DASIA_PERISPOMENI; break;
        case UNICODE_IOTA_VARIA: *plainLetter = UNICODE_IOTA; *sign = LBR_LETTER_SIGN_VARIA; break;
        case UNICODE_IOTA_OXIA: *plainLetter = UNICODE_IOTA; *sign = LBR_LETTER_SIGN_OXIA; break;
        case UNICODE_IOTA_VRACHY: *plainLetter = UNICODE_IOTA; *sign = LBR_LETTER_SIGN_VRACHY; break;
        case UNICODE_IOTA_MACRON: *plainLetter = UNICODE_IOTA; *sign = LBR_LETTER_SIGN_MACRON; break;
        case UNICODE_IOTA_PERISPOMENI: *plainLetter = UNICODE_IOTA; *sign = LBR_LETTER_SIGN_PERISPOMENI; break;
            
        case UNICODE_OMICRON: *plainLetter = UNICODE_OMICRON; *sign = LBR_LETTER_SIGN_NONE; break;
        case UNICODE_OMICRON_PSILI: *plainLetter = UNICODE_OMICRON; *sign = LBR_LETTER_SIGN_PSILI; break;
        case UNICODE_OMICRON_DASIA: *plainLetter = UNICODE_OMICRON; *sign = LBR_LETTER_SIGN_DASIA; break;
        case UNICODE_OMICRON_PSILI_VARIA: *plainLetter = UNICODE_OMICRON; *sign = LBR_LETTER_SIGN_PSILI_VARIA; break;
        case UNICODE_OMICRON_DASIA_VARIA: *plainLetter = UNICODE_OMICRON; *sign = LBR_LETTER_SIGN_DASIA_VARIA; break;
        case UNICODE_OMICRON_PSILI_OXIA: *plainLetter = UNICODE_OMICRON; *sign = LBR_LETTER_SIGN_PSILI_OXIA; break;
        case UNICODE_OMICRON_DASIA_OXIA: *plainLetter = UNICODE_OMICRON; *sign = LBR_LETTER_SIGN_DASIA_OXIA; break;
        case UNICODE_OMICRON_VARIA: *plainLetter = UNICODE_OMICRON; *sign = LBR_LETTER_SIGN_VARIA; break;
        case UNICODE_OMICRON_OXIA: *plainLetter = UNICODE_OMICRON; *sign = LBR_LETTER_SIGN_OXIA; break;
            
        case UNICODE_UPSILON: *plainLetter = UNICODE_UPSILON; *sign = LBR_LETTER_SIGN_NONE; break;
        case UNICODE_UPSILON_PSILI: *plainLetter = UNICODE_UPSILON; *sign = LBR_LETTER_SIGN_PSILI; break;
        case UNICODE_UPSILON_DASIA: *plainLetter = UNICODE_UPSILON; *sign = LBR_LETTER_SIGN_DASIA; break;
        case UNICODE_UPSILON_PSILI_VARIA: *plainLetter = UNICODE_UPSILON; *sign = LBR_LETTER_SIGN_PSILI_VARIA; break;
        case UNICODE_UPSILON_DASIA_VARIA: *plainLetter = UNICODE_UPSILON; *sign = LBR_LETTER_SIGN_DASIA_VARIA; break;
        case UNICODE_UPSILON_PSILI_OXIA: *plainLetter = UNICODE_UPSILON; *sign = LBR_LETTER_SIGN_PSILI_OXIA; break;
        case UNICODE_UPSILON_DASIA_OXIA: *plainLetter = UNICODE_UPSILON; *sign = LBR_LETTER_SIGN_DASIA_OXIA; break;
        case UNICODE_UPSILON_PSILI_PERISPOMENI: *plainLetter = UNICODE_UPSILON; *sign = LBR_LETTER_SIGN_PSILI_PERISPOMENI; break;
        case UNICODE_UPSILON_DASIA_PERISPOMENI: *plainLetter = UNICODE_UPSILON; *sign = LBR_LETTER_SIGN_DASIA_PERISPOMENI; break;
        case UNICODE_UPSILON_VARIA: *plainLetter = UNICODE_UPSILON; *sign = LBR_LETTER_SIGN_VARIA; break;
        case UNICODE_UPSILON_OXIA: *plainLetter = UNICODE_UPSILON; *sign = LBR_LETTER_SIGN_OXIA; break;
        case UNICODE_UPSILON_VRACHY: *plainLetter = UNICODE_UPSILON; *sign = LBR_LETTER_SIGN_VRACHY; break;
        case UNICODE_UPSILON_MACRON: *plainLetter = UNICODE_UPSILON; *sign = LBR_LETTER_SIGN_MACRON; break;
        case UNICODE_UPSILON_PERISPOMENI: *plainLetter = UNICODE_UPSILON; *sign = LBR_LETTER_SIGN_PERISPOMENI; break;
            
        case UNICODE_OMEGA: *plainLetter = UNICODE_OMEGA; *sign = LBR_LETTER_SIGN_NONE; break;
        case UNICODE_OMEGA_PSILI: *plainLetter = UNICODE_OMEGA; *sign = LBR_LETTER_SIGN_PSILI; break;
        case UNICODE_OMEGA_DASIA: *plainLetter = UNICODE_OMEGA; *sign = LBR_LETTER_SIGN_DASIA; break;
        case UNICODE_OMEGA_PSILI_VARIA: *plainLetter = UNICODE_OMEGA; *sign = LBR_LETTER_SIGN_PSILI_VARIA; break;
        case UNICODE_OMEGA_DASIA_VARIA: *plainLetter = UNICODE_OMEGA; *sign = LBR_LETTER_SIGN_DASIA_VARIA; break;
        case UNICODE_OMEGA_PSILI_OXIA: *plainLetter = UNICODE_OMEGA; *sign = LBR_LETTER_SIGN_PSILI_OXIA; break;
        case UNICODE_OMEGA_DASIA_OXIA: *plainLetter = UNICODE_OMEGA; *sign = LBR_LETTER_SIGN_DASIA_OXIA; break;
        case UNICODE_OMEGA_PSILI_PERISPOMENI: *plainLetter = UNICODE_OMEGA; *sign = LBR_LETTER_SIGN_PSILI_PERISPOMENI; break;
        case UNICODE_OMEGA_DASIA_PERISPOMENI: *plainLetter = UNICODE_OMEGA; *sign = LBR_LETTER_SIGN_DASIA_PERISPOMENI; break;
        case UNICODE_OMEGA_VARIA: *plainLetter = UNICODE_OMEGA; *sign = LBR_LETTER_SIGN_VARIA; break;
        case UNICODE_OMEGA_OXIA: *plainLetter = UNICODE_OMEGA; *sign = LBR_LETTER_SIGN_OXIA; break;
        case UNICODE_OMEGA_PSILI_YPOGERGRAMMENI: *plainLetter = UNICODE_OMEGA; *sign = LBR_LETTER_SIGN_PSILI_YPOGERGRAMMENI; break;
        case UNICODE_OMEGA_DASIA_YPOGERGRAMMENI: *plainLetter = UNICODE_OMEGA; *sign = LBR_LETTER_SIGN_DASIA_YPOGERGRAMMENI; break;
        case UNICODE_OMEGA_PSILI_VARIA_YPOGERGRAMMENI: *plainLetter = UNICODE_OMEGA; *sign = LBR_LETTER_SIGN_PSILI_VARIA_YPOGERGRAMMENI; break;
        case UNICODE_OMEGA_DASIA_VARIA_YPOGERGRAMMENI: *plainLetter = UNICODE_OMEGA; *sign = LBR_LETTER_SIGN_DASIA_VARIA_YPOGERGRAMMENI; break;
        case UNICODE_OMEGA_PSILI_OXIA_YPOGERGRAMMENI: *plainLetter = UNICODE_OMEGA; *sign = LBR_LETTER_SIGN_PSILI_OXIA_YPOGERGRAMMENI; break;
        case UNICODE_OMEGA_DASIA_OXIA_YPOGERGRAMMENI: *plainLetter = UNICODE_OMEGA; *sign = LBR_LETTER_SIGN_DASIA_OXIA_YPOGERGRAMMENI; break;
        case UNICODE_OMEGA_PSILI_PERISPOMENI_YPOGERGRAMMENI: *plainLetter = UNICODE_OMEGA; *sign = LBR_LETTER_SIGN_PSILI_PERISPOMENI_YPOGERGRAMMENI; break;
        case UNICODE_OMEGA_DASIA_PERISPOMENI_YPOGERGRAMMENI: *plainLetter = UNICODE_OMEGA; *sign = LBR_LETTER_SIGN_DASIA_PERISPOMENI_YPOGERGRAMMENI; break;
        case UNICODE_OMEGA_VARIA_YPOGERGRAMMENI: *plainLetter = UNICODE_OMEGA; *sign = LBR_LETTER_SIGN_VARIA_YPOGERGRAMMENI; break;
        case UNICODE_OMEGA_YPOGERGRAMMENI: *plainLetter = UNICODE_OMEGA; *sign = LBR_LETTER_SIGN_YPOGERGRAMMENI; break;
        case UNICODE_OMEGA_OXIA_YPOGERGRAMMENI: *plainLetter = UNICODE_OMEGA; *sign = LBR_LETTER_SIGN_OXIA_YPOGERGRAMMENI; break;
        case UNICODE_OMEGA_PERISPOMENI: *plainLetter = UNICODE_OMEGA; *sign = LBR_LETTER_SIGN_PERISPOMENI; break;
        case UNICODE_OMEGA_PERISPOMENI_YPOGERGRAMMENI: *plainLetter = UNICODE_OMEGA; *sign = LBR_LETTER_SIGN_PERISPOMENI_YPOGERGRAMMENI; break;
            
        case UNICODE_RHO: *plainLetter = UNICODE_RHO; *sign = LBR_LETTER_SIGN_NONE; break;
        case UNICODE_RHO_DASIA: *plainLetter = UNICODE_RHO; *sign = LBR_LETTER_SIGN_DASIA; break;
            
        case UNICODE_BETA: *plainLetter = UNICODE_BETA; *sign = LBR_LETTER_SIGN_NONE; break;
        case UNICODE_GAMMA: *plainLetter = UNICODE_GAMMA; *sign = LBR_LETTER_SIGN_NONE; break;
        case UNICODE_DELTA: *plainLetter = UNICODE_DELTA; *sign = LBR_LETTER_SIGN_NONE; break;
        case UNICODE_ZETA: *plainLetter = UNICODE_ZETA; *sign = LBR_LETTER_SIGN_NONE; break;
        case UNICODE_THETA: *plainLetter = UNICODE_THETA; *sign = LBR_LETTER_SIGN_NONE; break;
        case UNICODE_KAPPA: *plainLetter = UNICODE_KAPPA; *sign = LBR_LETTER_SIGN_NONE; break;
        case UNICODE_LAMBDA: *plainLetter = UNICODE_LAMBDA; *sign = LBR_LETTER_SIGN_NONE; break;
        case UNICODE_MI: *plainLetter = UNICODE_MI; *sign = LBR_LETTER_SIGN_NONE; break;
        case UNICODE_NI: *plainLetter = UNICODE_NI; *sign = LBR_LETTER_SIGN_NONE; break;
        case UNICODE_XI: *plainLetter = UNICODE_XI; *sign = LBR_LETTER_SIGN_NONE; break;
        case UNICODE_PI: *plainLetter = UNICODE_PI; *sign = LBR_LETTER_SIGN_NONE; break;
        case UNICODE_SIGMA_FINAL: *plainLetter = UNICODE_SIGMA; *sign = LBR_LETTER_SIGN_NONE; break;
        case UNICODE_SIGMA: *plainLetter = UNICODE_SIGMA; *sign = LBR_LETTER_SIGN_NONE; break;
        case UNICODE_TAU: *plainLetter = UNICODE_TAU; *sign = LBR_LETTER_SIGN_NONE; break;
        case UNICODE_PHI: *plainLetter = UNICODE_PHI; *sign = LBR_LETTER_SIGN_NONE; break;
        case UNICODE_CHI: *plainLetter = UNICODE_CHI; *sign = LBR_LETTER_SIGN_NONE; break;
        case UNICODE_PSI: *plainLetter = UNICODE_PSI; *sign = LBR_LETTER_SIGN_NONE; break;
            
        case UNICODE_DIGAMMA: *plainLetter = UNICODE_DIGAMMA; *sign = LBR_LETTER_SIGN_NONE; break;
            
        case UNICODE_CAPITAL_ALPHA: *plainLetter = UNICODE_CAPITAL_ALPHA; *sign = LBR_LETTER_SIGN_NONE; break;
        case UNICODE_CAPITAL_ALPHA_PSILI: *plainLetter = UNICODE_CAPITAL_ALPHA_PSILI; *sign = LBR_LETTER_SIGN_PSILI; break;
        case UNICODE_CAPITAL_ALPHA_DASIA: *plainLetter = UNICODE_CAPITAL_ALPHA_DASIA; *sign = LBR_LETTER_SIGN_DASIA; break;
        case UNICODE_CAPITAL_ALPHA_PSILI_VARIA: *plainLetter = UNICODE_CAPITAL_ALPHA_PSILI_VARIA; *sign = LBR_LETTER_SIGN_PSILI_VARIA; break;
        case UNICODE_CAPITAL_ALPHA_DASIA_VARIA: *plainLetter = UNICODE_CAPITAL_ALPHA_DASIA_VARIA; *sign = LBR_LETTER_SIGN_DASIA_VARIA; break;
        case UNICODE_CAPITAL_ALPHA_PSILI_OXIA: *plainLetter = UNICODE_CAPITAL_ALPHA_PSILI_OXIA; *sign = LBR_LETTER_SIGN_PSILI_OXIA; break;
        case UNICODE_CAPITAL_ALPHA_DASIA_OXIA: *plainLetter = UNICODE_CAPITAL_ALPHA_DASIA_OXIA; *sign = LBR_LETTER_SIGN_DASIA_OXIA; break;
        case UNICODE_CAPITAL_ALPHA_PSILI_PERISPOMENI: *plainLetter = UNICODE_CAPITAL_ALPHA_PSILI_PERISPOMENI; *sign = LBR_LETTER_SIGN_PSILI_PERISPOMENI; break;
        case UNICODE_CAPITAL_ALPHA_DASIA_PERISPOMENI: *plainLetter = UNICODE_CAPITAL_ALPHA_DASIA_PERISPOMENI; *sign = LBR_LETTER_SIGN_DASIA_PERISPOMENI; break;
        case UNICODE_CAPITAL_ALPHA_VARIA: *plainLetter = UNICODE_CAPITAL_ALPHA_VARIA; *sign = LBR_LETTER_SIGN_VARIA; break;
        case UNICODE_CAPITAL_ALPHA_OXIA: *plainLetter = UNICODE_CAPITAL_ALPHA_OXIA; *sign = LBR_LETTER_SIGN_OXIA; break;
        case UNICODE_CAPITAL_ALPHA_VRACHY: *plainLetter = UNICODE_CAPITAL_ALPHA_VRACHY; *sign = LBR_LETTER_SIGN_VRACHY; break;
        case UNICODE_CAPITAL_ALPHA_MACRON: *plainLetter = UNICODE_CAPITAL_ALPHA_MACRON; *sign = LBR_LETTER_SIGN_MACRON; break;
        case UNICODE_CAPITAL_ALPHA_PERISPOMENI: *plainLetter = UNICODE_CAPITAL_ALPHA_PERISPOMENI; *sign = LBR_LETTER_SIGN_PERISPOMENI; break;
            
    }
}

#pragma mark Descriptions
+(NSString*)getLetterDescriptionByChar:(unichar)c {
    NSString* str = [LBRGreekString stringByChar:c];
    return [self getLetterDescriptionByStr:str];
}

+(NSString*)getLetterDescriptionByStr:(NSString*)str {
    return [letterDescriptionDictionary objectForKey:str];
}

+(NSString*)getSignDescriptionBySign:(LBRLetterSign)sign {
    return [signDescriptionlDictionary objectForKey:[NSString stringWithFormat:@"%d",sign]];
}

+(BOOL)isGreekChar:(unichar)c {
    BOOL retBool = false;
    unichar plainLetter = 0;
    LBRLetterSign sign = LBR_LETTER_SIGN_NONE;
    [self decomposeChar:c toLetter:&plainLetter toSign:&sign];
    if (plainLetter != UNICODE_NONE)
    {
        retBool = true;
    }
    return retBool;
}

#pragma mark
#pragma mark STUBS
+(BOOL)isAlphaVariant:(unichar)c {
    return NO;
}

+(BOOL)isEpsilonVariant:(unichar)c {
    return NO;
}

+(BOOL)isEtaVariant:(unichar)c {
    return NO;
}


+(BOOL)isIotaVariant:(unichar)c {
    return NO;
}


+(BOOL)isOmicronVariant:(unichar)c {
    return NO;
}


+(BOOL)isUpsilonVariant:(unichar)c {
    return NO;
}


+(BOOL)isOmegaVariant:(unichar)c {
    return NO;
}


+(BOOL)isRhoVariant:(unichar)c {
    return NO;
}

+(unichar)toAscii:(unichar)c {
    return NO;
}

#pragma mark -
#pragma mark Uppercase <-> Lowercase
// search:
// replace:
+(unichar)toUpperCase:(unichar)c {
    enum unicodeFontset enumCh = c;
    unichar retCh = c;
    switch (enumCh) {
        case UNICODE_ALPHA: retCh = UNICODE_CAPITAL_ALPHA; break;
        case UNICODE_ALPHA_OXIA2: retCh = UNICODE_CAPITAL_ALPHA_OXIA; break;
        case UNICODE_ALPHA_PSILI: retCh = UNICODE_CAPITAL_ALPHA_PSILI; break;
        case UNICODE_ALPHA_DASIA: retCh = UNICODE_CAPITAL_ALPHA_DASIA; break;
        case UNICODE_ALPHA_PSILI_VARIA: retCh = UNICODE_CAPITAL_ALPHA_PSILI_VARIA; break;
        case UNICODE_ALPHA_DASIA_VARIA: retCh = UNICODE_CAPITAL_ALPHA_DASIA_VARIA; break;
        case UNICODE_ALPHA_PSILI_OXIA: retCh = UNICODE_CAPITAL_ALPHA_PSILI_OXIA; break;
        case UNICODE_ALPHA_DASIA_OXIA: retCh = UNICODE_CAPITAL_ALPHA_DASIA_OXIA; break;
        case UNICODE_ALPHA_PSILI_PERISPOMENI: retCh = UNICODE_CAPITAL_ALPHA_PSILI_PERISPOMENI; break;
        case UNICODE_ALPHA_DASIA_PERISPOMENI: retCh = UNICODE_CAPITAL_ALPHA_DASIA_PERISPOMENI; break;
        case UNICODE_ALPHA_VARIA: retCh = UNICODE_CAPITAL_ALPHA_VARIA; break;
        case UNICODE_ALPHA_OXIA: retCh = UNICODE_CAPITAL_ALPHA_OXIA; break;
        case UNICODE_ALPHA_PSILI_YPOGERGRAMMENI: retCh = UNICODE_CAPITAL_ALPHA_PSILI; break;  // simplify
        case UNICODE_ALPHA_DASIA_YPOGERGRAMMENI: retCh = UNICODE_CAPITAL_ALPHA_DASIA; break;  // simplify
        case UNICODE_ALPHA_PSILI_VARIA_YPOGERGRAMMENI: retCh = UNICODE_CAPITAL_ALPHA_PSILI_VARIA; break;  // simplify
        case UNICODE_ALPHA_DASIA_VARIA_YPOGERGRAMMENI: retCh = UNICODE_CAPITAL_ALPHA_DASIA_VARIA; break;  // simplify
        case UNICODE_ALPHA_PSILI_OXIA_YPOGERGRAMMENI: retCh = UNICODE_CAPITAL_ALPHA_PSILI_OXIA; break;  // simplify
        case UNICODE_ALPHA_DASIA_OXIA_YPOGERGRAMMENI: retCh = UNICODE_CAPITAL_ALPHA_DASIA_OXIA; break;  // simplify
        case UNICODE_ALPHA_PSILI_PERISPOMENI_YPOGERGRAMMENI: retCh = UNICODE_CAPITAL_ALPHA_PSILI_PERISPOMENI; break;  // simplify
        case UNICODE_ALPHA_DASIA_PERISPOMENI_YPOGERGRAMMENI: retCh = UNICODE_CAPITAL_ALPHA_DASIA_PERISPOMENI; break;  // simplify
        case UNICODE_ALPHA_VRACHY: retCh = UNICODE_CAPITAL_ALPHA_VRACHY; break;
        case UNICODE_ALPHA_MACRON: retCh = UNICODE_CAPITAL_ALPHA_MACRON; break;
        case UNICODE_ALPHA_VARIA_YPOGERGRAMMENI: retCh = UNICODE_CAPITAL_ALPHA_VARIA; break;  // simplify
        case UNICODE_ALPHA_YPOGERGRAMMENI: retCh = UNICODE_CAPITAL_ALPHA; break;  // simplify
        case UNICODE_ALPHA_OXIA_YPOGERGRAMMENI: retCh = UNICODE_CAPITAL_ALPHA_OXIA; break;  // simplify
        case UNICODE_ALPHA_PERISPOMENI: retCh = UNICODE_CAPITAL_ALPHA_PERISPOMENI; break;
        case UNICODE_ALPHA_PERISPOMENI_YPOGERGRAMMENI: retCh = UNICODE_CAPITAL_ALPHA_PERISPOMENI; break;  // simplify
            
        case UNICODE_EPSILON: retCh = UNICODE_CAPITAL_EPSILON; break;
        case UNICODE_EPSILON_OXIA2: retCh = UNICODE_CAPITAL_EPSILON_OXIA; break;
        case UNICODE_EPSILON_PSILI: retCh = UNICODE_CAPITAL_EPSILON_PSILI; break;
        case UNICODE_EPSILON_DASIA: retCh = UNICODE_CAPITAL_EPSILON_DASIA; break;
        case UNICODE_EPSILON_PSILI_VARIA: retCh = UNICODE_CAPITAL_EPSILON_PSILI_VARIA; break;
        case UNICODE_EPSILON_DASIA_VARIA: retCh = UNICODE_CAPITAL_EPSILON_DASIA_VARIA; break;
        case UNICODE_EPSILON_PSILI_OXIA: retCh = UNICODE_CAPITAL_EPSILON_PSILI_OXIA; break;
        case UNICODE_EPSILON_DASIA_OXIA: retCh = UNICODE_CAPITAL_EPSILON_DASIA_OXIA; break;
        case UNICODE_EPSILON_VARIA: retCh = UNICODE_CAPITAL_EPSILON_VARIA; break;
        case UNICODE_EPSILON_OXIA: retCh = UNICODE_CAPITAL_EPSILON_OXIA; break;
            
        case UNICODE_ETA: retCh = UNICODE_CAPITAL_ETA; break;
        case UNICODE_ETA_OXIA2: retCh = UNICODE_CAPITAL_ETA_OXIA; break;
        case UNICODE_ETA_PSILI: retCh = UNICODE_CAPITAL_ETA_PSILI; break;
        case UNICODE_ETA_DASIA: retCh = UNICODE_CAPITAL_ETA_DASIA; break;
        case UNICODE_ETA_PSILI_VARIA: retCh = UNICODE_CAPITAL_ETA_PSILI_VARIA; break;
        case UNICODE_ETA_DASIA_VARIA: retCh = UNICODE_CAPITAL_ETA_DASIA_VARIA; break;
        case UNICODE_ETA_PSILI_OXIA: retCh = UNICODE_CAPITAL_ETA_PSILI_OXIA; break;
        case UNICODE_ETA_DASIA_OXIA: retCh = UNICODE_CAPITAL_ETA_DASIA_OXIA; break;
        case UNICODE_ETA_PSILI_PERISPOMENI: retCh = UNICODE_CAPITAL_ETA_PSILI_PERISPOMENI; break;
        case UNICODE_ETA_DASIA_PERISPOMENI: retCh = UNICODE_CAPITAL_ETA_DASIA_PERISPOMENI; break;
        case UNICODE_ETA_VARIA: retCh = UNICODE_CAPITAL_ETA_VARIA; break;
        case UNICODE_ETA_OXIA: retCh = UNICODE_CAPITAL_ETA_OXIA; break;
        case UNICODE_ETA_PSILI_YPOGERGRAMMENI: retCh = UNICODE_CAPITAL_ETA_PSILI; break;  // simplify
        case UNICODE_ETA_DASIA_YPOGERGRAMMENI: retCh = UNICODE_CAPITAL_ETA_DASIA; break;  // simplify
        case UNICODE_ETA_PSILI_VARIA_YPOGERGRAMMENI: retCh = UNICODE_CAPITAL_ETA_PSILI_VARIA; break;  // simplify
        case UNICODE_ETA_DASIA_VARIA_YPOGERGRAMMENI: retCh = UNICODE_CAPITAL_ETA_DASIA_VARIA; break;  // simplify
        case UNICODE_ETA_PSILI_OXIA_YPOGERGRAMMENI: retCh = UNICODE_CAPITAL_ETA_PSILI_OXIA; break;  // simplify
        case UNICODE_ETA_DASIA_OXIA_YPOGERGRAMMENI: retCh = UNICODE_CAPITAL_ETA_DASIA_OXIA; break;  // simplify
        case UNICODE_ETA_PSILI_PERISPOMENI_YPOGERGRAMMENI: retCh = UNICODE_CAPITAL_ETA_PSILI_PERISPOMENI; break;  // simplify
        case UNICODE_ETA_DASIA_PERISPOMENI_YPOGERGRAMMENI: retCh = UNICODE_CAPITAL_ETA_DASIA_PERISPOMENI; break;  // simplify
        case UNICODE_ETA_VARIA_YPOGERGRAMMENI: retCh = UNICODE_CAPITAL_ETA_VARIA; break;  // simplify
        case UNICODE_ETA_YPOGERGRAMMENI: retCh = UNICODE_CAPITAL_ETA; break;  // simplify
        case UNICODE_ETA_OXIA_YPOGERGRAMMENI: retCh = UNICODE_CAPITAL_ETA_OXIA; break;
        case UNICODE_ETA_PERISPOMENI: retCh = UNICODE_CAPITAL_ETA; break;  // simplify
        case UNICODE_ETA_PERISPOMENI_YPOGERGRAMMENI: retCh = UNICODE_CAPITAL_ETA; break;  // simplify
            
        case UNICODE_IOTA: retCh = UNICODE_CAPITAL_IOTA; break;
        case UNICODE_IOTA_OXIA2: retCh = UNICODE_CAPITAL_IOTA_OXIA; break;
        case UNICODE_IOTA_PSILI: retCh = UNICODE_CAPITAL_IOTA_PSILI; break;
        case UNICODE_IOTA_DASIA: retCh = UNICODE_CAPITAL_IOTA_DASIA; break;
        case UNICODE_IOTA_PSILI_VARIA: retCh = UNICODE_CAPITAL_IOTA_PSILI_VARIA; break;
        case UNICODE_IOTA_DASIA_VARIA: retCh = UNICODE_CAPITAL_IOTA_DASIA_VARIA; break;
        case UNICODE_IOTA_PSILI_OXIA: retCh = UNICODE_CAPITAL_IOTA_PSILI_OXIA; break;
        case UNICODE_IOTA_DASIA_OXIA: retCh = UNICODE_CAPITAL_IOTA_DASIA_OXIA; break;
        case UNICODE_IOTA_PSILI_PERISPOMENI: retCh = UNICODE_CAPITAL_IOTA_PSILI_PERISPOMENI; break;
        case UNICODE_IOTA_DASIA_PERISPOMENI: retCh = UNICODE_CAPITAL_IOTA_DASIA_PERISPOMENI; break;
        case UNICODE_IOTA_VARIA: retCh = UNICODE_CAPITAL_IOTA_VARIA; break;
        case UNICODE_IOTA_OXIA: retCh = UNICODE_CAPITAL_IOTA_OXIA; break;
        case UNICODE_IOTA_VRACHY: retCh = UNICODE_CAPITAL_IOTA_VRACHY; break;
        case UNICODE_IOTA_VRACHY_OXIA: retCh = UNICODE_CAPITAL_IOTA_VRACHY; break; // simplify
        case UNICODE_IOTA_MACRON: retCh = UNICODE_CAPITAL_IOTA_MACRON; break;
        case UNICODE_IOTA_MACRON_OXIA: retCh = UNICODE_CAPITAL_IOTA_MACRON; break;  // simplify
        case UNICODE_IOTA_VARIA_DIALYTIKA: retCh = UNICODE_CAPITAL_IOTA_VARIA; break;  // simplify
        case UNICODE_IOTA_DIALYTIKA: retCh = UNICODE_CAPITAL_IOTA; break;  // simplify
        case UNICODE_IOTA_PERISPOMENI: retCh = UNICODE_CAPITAL_IOTA; break;  // simplify
        case UNICODE_IOTA_PERISPOMENI_DIALYTIKA: retCh = UNICODE_CAPITAL_IOTA; break;  // simplify
            
        case UNICODE_OMICRON: retCh = UNICODE_CAPITAL_OMICRON; break;
        case UNICODE_OMICRON_PSILI: retCh = UNICODE_CAPITAL_OMICRON_PSILI; break;
        case UNICODE_OMICRON_DASIA: retCh = UNICODE_CAPITAL_OMICRON_DASIA; break;
        case UNICODE_OMICRON_PSILI_VARIA: retCh = UNICODE_CAPITAL_OMICRON_PSILI_VARIA; break;
        case UNICODE_OMICRON_DASIA_VARIA: retCh = UNICODE_CAPITAL_OMICRON_DASIA_VARIA; break;
        case UNICODE_OMICRON_PSILI_OXIA: retCh = UNICODE_CAPITAL_OMICRON_PSILI_OXIA; break;
        case UNICODE_OMICRON_DASIA_OXIA: retCh = UNICODE_CAPITAL_OMICRON_DASIA_OXIA; break;
        case UNICODE_OMICRON_VARIA: retCh = UNICODE_CAPITAL_OMICRON_VARIA; break;
        case UNICODE_OMICRON_OXIA: retCh = UNICODE_CAPITAL_OMICRON_OXIA; break;
            
        case UNICODE_UPSILON: retCh = UNICODE_CAPITAL_UPSILON; break;
        case UNICODE_UPSILON_OXIA2: retCh = UNICODE_CAPITAL_UPSILON_OXIA; break;
        case UNICODE_UPSILON_PSILI: retCh = UNICODE_CAPITAL_UPSILON; break;  // simplify
        case UNICODE_UPSILON_DASIA: retCh = UNICODE_CAPITAL_UPSILON_DASIA; break;
        case UNICODE_UPSILON_PSILI_VARIA: retCh = UNICODE_CAPITAL_UPSILON_VARIA; break;  // simplify
        case UNICODE_UPSILON_DASIA_VARIA: retCh = UNICODE_CAPITAL_UPSILON_DASIA_VARIA; break;
        case UNICODE_UPSILON_PSILI_OXIA: retCh = UNICODE_CAPITAL_UPSILON_OXIA; break;  // simplify
        case UNICODE_UPSILON_DASIA_OXIA: retCh = UNICODE_CAPITAL_UPSILON_DASIA_OXIA; break;
        case UNICODE_UPSILON_PSILI_PERISPOMENI: retCh = UNICODE_CAPITAL_UPSILON; break;  // simplify
        case UNICODE_UPSILON_DASIA_PERISPOMENI: retCh = UNICODE_CAPITAL_UPSILON_DASIA; break;
        case UNICODE_UPSILON_VARIA: retCh = UNICODE_CAPITAL_UPSILON_VARIA; break;
        case UNICODE_UPSILON_OXIA: retCh = UNICODE_CAPITAL_UPSILON_OXIA; break;
        case UNICODE_UPSILON_VRACHY: retCh = UNICODE_CAPITAL_UPSILON_VRACHY; break;
        case UNICODE_UPSILON_VRACHY_OXIA: retCh = UNICODE_CAPITAL_UPSILON_VRACHY; break;  // simplify
        case UNICODE_UPSILON_MACRON: retCh = UNICODE_CAPITAL_UPSILON_MACRON; break;
        case UNICODE_UPSILON_MACRON_OXIA: retCh = UNICODE_CAPITAL_UPSILON_MACRON; break; // simplify
        case UNICODE_UPSILON_VARIA_DIALYTIKA: retCh = UNICODE_CAPITAL_UPSILON_VARIA; break;  // simplify
        case UNICODE_UPSILON_DIALYTIKA: retCh = UNICODE_CAPITAL_UPSILON; break;  // simplify
        case UNICODE_UPSILON_PERISPOMENI: retCh = UNICODE_CAPITAL_UPSILON; break;  // simplify
        case UNICODE_UPSILON_PERISPOMENI_DIALYTIKA: retCh = UNICODE_CAPITAL_UPSILON; break;  // simplify
        case UNICODE_UPSILON_OXIA_DIALYTIKA:  retCh = UNICODE_CAPITAL_UPSILON_OXIA; break;  // simplify
            
        case UNICODE_OMEGA: retCh = UNICODE_CAPITAL_OMEGA; break;
        case UNICODE_OMEGA_PSILI: retCh = UNICODE_CAPITAL_OMEGA_PSILI; break;
        case UNICODE_OMEGA_DASIA: retCh = UNICODE_CAPITAL_OMEGA_DASIA; break;
        case UNICODE_OMEGA_PSILI_VARIA: retCh = UNICODE_CAPITAL_OMEGA_PSILI_VARIA; break;
        case UNICODE_OMEGA_DASIA_VARIA: retCh = UNICODE_CAPITAL_OMEGA_DASIA_VARIA; break;
        case UNICODE_OMEGA_PSILI_OXIA: retCh = UNICODE_CAPITAL_OMEGA_PSILI_OXIA; break;
        case UNICODE_OMEGA_DASIA_OXIA: retCh = UNICODE_CAPITAL_OMEGA_DASIA_OXIA; break;
        case UNICODE_OMEGA_PSILI_PERISPOMENI: retCh = UNICODE_CAPITAL_OMEGA_PSILI_PERISPOMENI; break;
        case UNICODE_OMEGA_DASIA_PERISPOMENI: retCh = UNICODE_CAPITAL_OMEGA_DASIA_PERISPOMENI; break;
        case UNICODE_OMEGA_VARIA: retCh = UNICODE_CAPITAL_OMEGA_VARIA; break;
        case UNICODE_OMEGA_OXIA: retCh = UNICODE_CAPITAL_OMEGA_OXIA; break;
        case UNICODE_OMEGA_PSILI_YPOGERGRAMMENI: retCh = UNICODE_CAPITAL_OMEGA_PSILI; break;  // simplify
        case UNICODE_OMEGA_DASIA_YPOGERGRAMMENI: retCh = UNICODE_CAPITAL_OMEGA_DASIA; break;  // simplify
        case UNICODE_OMEGA_PSILI_VARIA_YPOGERGRAMMENI: retCh = UNICODE_CAPITAL_OMEGA_PSILI_VARIA; break;  // simplify
        case UNICODE_OMEGA_DASIA_VARIA_YPOGERGRAMMENI: retCh = UNICODE_CAPITAL_OMEGA_DASIA_VARIA; break;  // simplify
        case UNICODE_OMEGA_PSILI_OXIA_YPOGERGRAMMENI: retCh = UNICODE_CAPITAL_OMEGA_PSILI_OXIA; break;  // simplify
        case UNICODE_OMEGA_DASIA_OXIA_YPOGERGRAMMENI: retCh = UNICODE_CAPITAL_OMEGA_DASIA_OXIA; break;  // simplify
        case UNICODE_OMEGA_PSILI_PERISPOMENI_YPOGERGRAMMENI: retCh = UNICODE_CAPITAL_OMEGA_PSILI_PERISPOMENI; break;  // simplify
        case UNICODE_OMEGA_DASIA_PERISPOMENI_YPOGERGRAMMENI: retCh = UNICODE_CAPITAL_OMEGA_DASIA_PERISPOMENI; break;  // simplify
        case UNICODE_OMEGA_VARIA_YPOGERGRAMMENI: retCh = UNICODE_CAPITAL_OMEGA_VARIA; break;  // simplify
        case UNICODE_OMEGA_YPOGERGRAMMENI: retCh = UNICODE_CAPITAL_OMEGA; break;  // simplify
        case UNICODE_OMEGA_OXIA_YPOGERGRAMMENI: retCh = UNICODE_CAPITAL_OMEGA_OXIA; break;  // simplify
        case UNICODE_OMEGA_PERISPOMENI: retCh = UNICODE_CAPITAL_OMEGA; break;  // simplify
        case UNICODE_OMEGA_PERISPOMENI_YPOGERGRAMMENI: retCh = UNICODE_CAPITAL_OMEGA; break;  // simplify
            
        case UNICODE_RHO: retCh = UNICODE_CAPITAL_RHO; break;
        case UNICODE_RHO_PSILI: retCh = UNICODE_CAPITAL_RHO; break;  // simplify
        case UNICODE_RHO_DASIA: retCh = UNICODE_CAPITAL_RHO_DASIA; break;
            
        case UNICODE_BETA: retCh = UNICODE_CAPITAL_BETA; break;
        case UNICODE_GAMMA: retCh = UNICODE_CAPITAL_GAMMA; break;
        case UNICODE_DELTA: retCh = UNICODE_CAPITAL_DELTA; break;
        case UNICODE_ZETA: retCh = UNICODE_CAPITAL_ZETA; break;
        case UNICODE_THETA: retCh = UNICODE_CAPITAL_THETA; break;
        case UNICODE_KAPPA: retCh = UNICODE_CAPITAL_KAPPA; break;
        case UNICODE_LAMBDA: retCh = UNICODE_CAPITAL_LAMBDA; break;
        case UNICODE_MI: retCh = UNICODE_CAPITAL_MI; break;
        case UNICODE_NI: retCh = UNICODE_CAPITAL_NI; break;
        case UNICODE_XI: retCh = UNICODE_CAPITAL_XI; break;
        case UNICODE_PI: retCh = UNICODE_CAPITAL_PI; break;
        case UNICODE_SIGMA_FINAL: retCh = UNICODE_CAPITAL_SIGMA; break;  // simplify
        case UNICODE_SIGMA: retCh = UNICODE_CAPITAL_SIGMA; break;
        case UNICODE_TAU: retCh = UNICODE_CAPITAL_TAU; break;
        case UNICODE_PHI: retCh = UNICODE_CAPITAL_PHI; break;
        case UNICODE_CHI: retCh = UNICODE_CAPITAL_CHI; break;
        case UNICODE_PSI: retCh = UNICODE_CAPITAL_PSI; break;
            
        case UNICODE_DIGAMMA: retCh = UNICODE_DIGAMMA; break;  // simplify
            
        case UNICODE_ALPHA_MACRON_OXIA: retCh = UNICODE_CAPITAL_ALPHA_OXIA; break;  // simplify
        case UNICODE_ALPHA_MACRON_PSILI: retCh = UNICODE_CAPITAL_ALPHA_PSILI; break;  // simplify
        case UNICODE_ALPHA_MACRON_DASIA: retCh = UNICODE_CAPITAL_ALPHA_DASIA; break;  // simplify
        case UNICODE_ALPHA_VRACHY_OXIA: retCh = UNICODE_CAPITAL_ALPHA_OXIA; break;  // simplify
        case UNICODE_IOTA_DIALYTIKA_VARIA: retCh = UNICODE_CAPITAL_IOTA_VARIA; break;  // simplify
        case UNICODE_IOTA_DIALYTIKA_OXIA: retCh = UNICODE_CAPITAL_IOTA_OXIA; break;  // simplify
            
        default:
            // nothing to do
            break;
    }
    return retCh;
}
+(unichar)toLowerCase:(unichar)c {
    enum unicodeFontset enumCh = c;
    unichar retCh = c;
    switch (enumCh) {
        case UNICODE_CAPITAL_ALPHA: retCh = UNICODE_ALPHA; break;
        case UNICODE_CAPITAL_ALPHA_PSILI: retCh = UNICODE_ALPHA_PSILI; break;
        case UNICODE_CAPITAL_ALPHA_DASIA: retCh = UNICODE_ALPHA_DASIA; break;
        case UNICODE_CAPITAL_ALPHA_PSILI_VARIA: retCh = UNICODE_ALPHA_PSILI_VARIA; break;
        case UNICODE_CAPITAL_ALPHA_DASIA_VARIA: retCh = UNICODE_ALPHA_DASIA_VARIA; break;
        case UNICODE_CAPITAL_ALPHA_PSILI_OXIA: retCh = UNICODE_ALPHA_PSILI_OXIA; break;
        case UNICODE_CAPITAL_ALPHA_DASIA_OXIA: retCh = UNICODE_ALPHA_DASIA_OXIA; break;
        case UNICODE_CAPITAL_ALPHA_PSILI_PERISPOMENI: retCh = UNICODE_ALPHA_PSILI_PERISPOMENI; break;
        case UNICODE_CAPITAL_ALPHA_DASIA_PERISPOMENI: retCh = UNICODE_ALPHA_DASIA_PERISPOMENI; break;
        case UNICODE_CAPITAL_ALPHA_VARIA: retCh = UNICODE_ALPHA_VARIA; break;
        case UNICODE_CAPITAL_ALPHA_OXIA: retCh = UNICODE_ALPHA_OXIA; break;
        case UNICODE_CAPITAL_ALPHA_VRACHY: retCh = UNICODE_ALPHA_VRACHY; break;
        case UNICODE_CAPITAL_ALPHA_MACRON: retCh = UNICODE_ALPHA_MACRON; break;
            
        case UNICODE_CAPITAL_BETA: retCh = UNICODE_BETA; break;
        case UNICODE_CAPITAL_GAMMA: retCh = UNICODE_GAMMA; break;
        case UNICODE_CAPITAL_DELTA: retCh = UNICODE_DELTA; break;
            
        case UNICODE_CAPITAL_EPSILON: retCh = UNICODE_EPSILON; break;
        case UNICODE_CAPITAL_EPSILON_PSILI: retCh = UNICODE_EPSILON_PSILI; break;
        case UNICODE_CAPITAL_EPSILON_DASIA: retCh = UNICODE_EPSILON_DASIA; break;
        case UNICODE_CAPITAL_EPSILON_PSILI_VARIA: retCh = UNICODE_EPSILON_PSILI_VARIA; break;
        case UNICODE_CAPITAL_EPSILON_DASIA_VARIA: retCh = UNICODE_EPSILON_DASIA_VARIA; break;
        case UNICODE_CAPITAL_EPSILON_PSILI_OXIA: retCh = UNICODE_EPSILON_PSILI_OXIA; break;
        case UNICODE_CAPITAL_EPSILON_DASIA_OXIA: retCh = UNICODE_EPSILON_DASIA_OXIA; break;
        case UNICODE_CAPITAL_EPSILON_VARIA: retCh = UNICODE_EPSILON_VARIA; break;
        case UNICODE_CAPITAL_EPSILON_OXIA: retCh = UNICODE_EPSILON_OXIA; break;
            
        case UNICODE_CAPITAL_ZETA: retCh = UNICODE_ZETA; break;
            
        case UNICODE_CAPITAL_ETA: retCh = UNICODE_ETA; break;
        case UNICODE_CAPITAL_ETA_PSILI: retCh = UNICODE_ETA_PSILI; break;
        case UNICODE_CAPITAL_ETA_DASIA: retCh = UNICODE_ETA_DASIA; break;
        case UNICODE_CAPITAL_ETA_PSILI_VARIA: retCh = UNICODE_ETA_PSILI_VARIA; break;
        case UNICODE_CAPITAL_ETA_DASIA_VARIA: retCh = UNICODE_ETA_DASIA_VARIA; break;
        case UNICODE_CAPITAL_ETA_PSILI_OXIA: retCh = UNICODE_ETA_PSILI_OXIA; break;
        case UNICODE_CAPITAL_ETA_DASIA_OXIA: retCh = UNICODE_ETA_DASIA_OXIA; break;
        case UNICODE_CAPITAL_ETA_PSILI_PERISPOMENI: retCh = UNICODE_ETA_PSILI_PERISPOMENI; break;
        case UNICODE_CAPITAL_ETA_DASIA_PERISPOMENI: retCh = UNICODE_ETA_DASIA_PERISPOMENI; break;
        case UNICODE_CAPITAL_ETA_VARIA: retCh = UNICODE_ETA_VARIA; break;
        case UNICODE_CAPITAL_ETA_OXIA: retCh = UNICODE_ETA_OXIA; break;
            
        case UNICODE_CAPITAL_THETA: retCh = UNICODE_THETA; break;
            
        case UNICODE_CAPITAL_IOTA: retCh = UNICODE_IOTA; break;
        case UNICODE_CAPITAL_IOTA_PSILI: retCh = UNICODE_IOTA_PSILI; break;
        case UNICODE_CAPITAL_IOTA_DASIA: retCh = UNICODE_IOTA_DASIA; break;
        case UNICODE_CAPITAL_IOTA_PSILI_VARIA: retCh = UNICODE_IOTA_PSILI_VARIA; break;
        case UNICODE_CAPITAL_IOTA_DASIA_VARIA: retCh = UNICODE_IOTA_DASIA_VARIA; break;
        case UNICODE_CAPITAL_IOTA_PSILI_OXIA: retCh = UNICODE_IOTA_PSILI_OXIA; break;
        case UNICODE_CAPITAL_IOTA_DASIA_OXIA: retCh = UNICODE_IOTA_DASIA_OXIA; break;
        case UNICODE_CAPITAL_IOTA_PSILI_PERISPOMENI: retCh = UNICODE_IOTA_PSILI_PERISPOMENI; break;
        case UNICODE_CAPITAL_IOTA_DASIA_PERISPOMENI: retCh = UNICODE_IOTA_DASIA_PERISPOMENI; break;
        case UNICODE_CAPITAL_IOTA_VARIA: retCh = UNICODE_IOTA_VARIA; break;
        case UNICODE_CAPITAL_IOTA_OXIA: retCh = UNICODE_IOTA_OXIA; break;
        case UNICODE_CAPITAL_IOTA_VRACHY: retCh = UNICODE_IOTA_VRACHY; break;
        case UNICODE_CAPITAL_IOTA_MACRON: retCh = UNICODE_IOTA_MACRON; break;
            
        case UNICODE_CAPITAL_KAPPA: retCh = UNICODE_KAPPA; break;
        case UNICODE_CAPITAL_LAMBDA: retCh = UNICODE_LAMBDA; break;
        case UNICODE_CAPITAL_MI: retCh = UNICODE_MI; break;
        case UNICODE_CAPITAL_NI: retCh = UNICODE_NI; break;
        case UNICODE_CAPITAL_XI: retCh = UNICODE_XI; break;
            
        case UNICODE_CAPITAL_OMICRON: retCh = UNICODE_OMICRON; break;
        case UNICODE_CAPITAL_OMICRON_PSILI: retCh = UNICODE_OMICRON_PSILI; break;
        case UNICODE_CAPITAL_OMICRON_DASIA: retCh = UNICODE_OMICRON_DASIA; break;
        case UNICODE_CAPITAL_OMICRON_PSILI_VARIA: retCh = UNICODE_OMICRON_PSILI_VARIA; break;
        case UNICODE_CAPITAL_OMICRON_DASIA_VARIA: retCh = UNICODE_OMICRON_DASIA_VARIA; break;
        case UNICODE_CAPITAL_OMICRON_PSILI_OXIA: retCh = UNICODE_OMICRON_PSILI_OXIA; break;
        case UNICODE_CAPITAL_OMICRON_DASIA_OXIA: retCh = UNICODE_OMICRON_DASIA_OXIA; break;
        case UNICODE_CAPITAL_OMICRON_VARIA: retCh = UNICODE_OMICRON_VARIA; break;
        case UNICODE_CAPITAL_OMICRON_OXIA: retCh = UNICODE_OMICRON_OXIA; break;
            
            
        case UNICODE_CAPITAL_PI: retCh = UNICODE_PI; break;
            
        case UNICODE_CAPITAL_RHO: retCh = UNICODE_RHO; break;
        case UNICODE_CAPITAL_RHO_DASIA: retCh = UNICODE_RHO_DASIA; break;
            
        case UNICODE_CAPITAL_SIGMA: retCh = UNICODE_SIGMA; break;
        case UNICODE_CAPITAL_TAU: retCh = UNICODE_TAU; break;
            
        case UNICODE_CAPITAL_UPSILON: retCh = UNICODE_UPSILON; break;
        case UNICODE_CAPITAL_UPSILON_DASIA: retCh = UNICODE_UPSILON_DASIA; break;
        case UNICODE_CAPITAL_UPSILON_DASIA_VARIA: retCh = UNICODE_UPSILON_DASIA_VARIA; break;
        case UNICODE_CAPITAL_UPSILON_DASIA_OXIA: retCh = UNICODE_UPSILON_DASIA_OXIA; break;
        case UNICODE_CAPITAL_UPSILON_DASIA_PERISPOMENI: retCh = UNICODE_UPSILON_DASIA_PERISPOMENI; break;
        case UNICODE_CAPITAL_UPSILON_VARIA: retCh = UNICODE_UPSILON_VARIA; break;
        case UNICODE_CAPITAL_UPSILON_OXIA: retCh = UNICODE_UPSILON_OXIA; break;
        case UNICODE_CAPITAL_UPSILON_VRACHY: retCh = UNICODE_UPSILON_VRACHY; break;
        case UNICODE_CAPITAL_UPSILON_MACRON: retCh = UNICODE_UPSILON_MACRON; break;
            
        case UNICODE_CAPITAL_PHI: retCh = UNICODE_PHI; break;
        case UNICODE_CAPITAL_CHI: retCh = UNICODE_CHI; break;
        case UNICODE_CAPITAL_PSI: retCh = UNICODE_PSI; break;
            
        case UNICODE_CAPITAL_OMEGA: retCh = UNICODE_OMEGA; break;
        case UNICODE_CAPITAL_OMEGA_PSILI: retCh = UNICODE_OMEGA_PSILI; break;
        case UNICODE_CAPITAL_OMEGA_DASIA: retCh = UNICODE_OMEGA_DASIA; break;
        case UNICODE_CAPITAL_OMEGA_PSILI_VARIA: retCh = UNICODE_OMEGA_PSILI_VARIA; break;
        case UNICODE_CAPITAL_OMEGA_DASIA_VARIA: retCh = UNICODE_OMEGA_DASIA_VARIA; break;
        case UNICODE_CAPITAL_OMEGA_PSILI_OXIA: retCh = UNICODE_OMEGA_PSILI_OXIA; break;
        case UNICODE_CAPITAL_OMEGA_DASIA_OXIA: retCh = UNICODE_OMEGA_DASIA_OXIA; break;
        case UNICODE_CAPITAL_OMEGA_PSILI_PERISPOMENI: retCh = UNICODE_OMEGA_PSILI_PERISPOMENI; break;
        case UNICODE_CAPITAL_OMEGA_DASIA_PERISPOMENI: retCh = UNICODE_OMEGA_DASIA_PERISPOMENI; break;
        case UNICODE_CAPITAL_OMEGA_VARIA: retCh = UNICODE_OMEGA_VARIA; break;
        case UNICODE_CAPITAL_OMEGA_OXIA: retCh = UNICODE_OMEGA_OXIA; break;
        case UNICODE_CAPITAL_ALPHA_PERISPOMENI: retCh = UNICODE_ALPHA_PERISPOMENI; break;
            
        default:
            
            // nothing to do
            break;
    }
    
    return retCh;
}

+(BOOL)isPhilological:(unichar)c {
    // FIXME TODO
    return NO;
}
+(BOOL)isPolytonic:(unichar)c {
    // FIXME TODO
    return NO;
}


+(unichar)asciiLetter2plainGreek:(unichar)c {
    unichar retCh = c;
    switch (c) {
        case 'a': retCh = UNICODE_ALPHA; break;
        case 'b': retCh = UNICODE_BETA; break;
        case 'g': retCh = UNICODE_GAMMA; break;
        case 'd': retCh = UNICODE_DELTA; break;
        case 'e': retCh = UNICODE_EPSILON; break;
        case 'z': retCh = UNICODE_ZETA; break;
        case 'h': retCh = UNICODE_ETA; break;
        case 'q': retCh = UNICODE_THETA; break;
        case 'i': retCh = UNICODE_IOTA; break;
        case 'k': retCh = UNICODE_KAPPA; break;
        case 'l': retCh = UNICODE_LAMBDA; break;
        case 'm': retCh = UNICODE_MI; break;
        case 'n': retCh = UNICODE_NI; break;
        case 'c': retCh = UNICODE_XI; break;
        case 'o': retCh = UNICODE_OMICRON; break;
        case 'p': retCh = UNICODE_PI; break;
        case 'r': retCh = UNICODE_RHO; break;
        case 's': retCh = UNICODE_SIGMA; break;
        case 't': retCh = UNICODE_TAU; break;
        case 'u': retCh = UNICODE_UPSILON; break;
        case 'f': retCh = UNICODE_PHI; break;
        case 'x': retCh = UNICODE_CHI; break;
        case 'y': retCh = UNICODE_PSI; break;
        case 'w': retCh = UNICODE_OMEGA; break;
            
        default:
            
            // nothing to do
            break;
    }
    
    return retCh;
}

#pragma mark -
#pragma mark Sort

//search: UNICODE_([A-Z_0-9]*) = 0x....,
//replace: case UNICODE_\1: retVal = SORT_\1; break;
+(enum fontsetSortOrder)sortOrder:(unichar)c {
    enum unicodeFontset enumCh = c;
    enum fontsetSortOrder retVal = 0;
    switch (enumCh) {
        case UNICODE_NONE: retVal = SORT_FIRST; break;
            
        case UNICODE_ALPHA: retVal = SORT_ALPHA; break;
        case UNICODE_ALPHA_OXIA2: retVal = SORT_ALPHA_OXIA; break;
        case UNICODE_ALPHA_PSILI: retVal = SORT_ALPHA_PSILI; break;
        case UNICODE_ALPHA_DASIA: retVal = SORT_ALPHA_DASIA; break;
        case UNICODE_ALPHA_PSILI_VARIA: retVal = SORT_ALPHA_PSILI_VARIA; break;
        case UNICODE_ALPHA_DASIA_VARIA: retVal = SORT_ALPHA_DASIA_VARIA; break;
        case UNICODE_ALPHA_PSILI_OXIA: retVal = SORT_ALPHA_PSILI_OXIA; break;
        case UNICODE_ALPHA_DASIA_OXIA: retVal = SORT_ALPHA_DASIA_OXIA; break;
        case UNICODE_ALPHA_PSILI_PERISPOMENI: retVal = SORT_ALPHA_PSILI_PERISPOMENI; break;
        case UNICODE_ALPHA_DASIA_PERISPOMENI: retVal = SORT_ALPHA_DASIA_PERISPOMENI; break;
        case UNICODE_ALPHA_VARIA: retVal = SORT_ALPHA_VARIA; break;
        case UNICODE_ALPHA_OXIA: retVal = SORT_ALPHA_OXIA; break;
        case UNICODE_ALPHA_PSILI_YPOGERGRAMMENI: retVal = SORT_ALPHA_PSILI_YPOGERGRAMMENI; break;
        case UNICODE_ALPHA_DASIA_YPOGERGRAMMENI: retVal = SORT_ALPHA_DASIA_YPOGERGRAMMENI; break;
        case UNICODE_ALPHA_PSILI_VARIA_YPOGERGRAMMENI: retVal = SORT_ALPHA_PSILI_VARIA_YPOGERGRAMMENI; break;
        case UNICODE_ALPHA_DASIA_VARIA_YPOGERGRAMMENI: retVal = SORT_ALPHA_DASIA_VARIA_YPOGERGRAMMENI; break;
        case UNICODE_ALPHA_PSILI_OXIA_YPOGERGRAMMENI: retVal = SORT_ALPHA_PSILI_OXIA_YPOGERGRAMMENI; break;
        case UNICODE_ALPHA_DASIA_OXIA_YPOGERGRAMMENI: retVal = SORT_ALPHA_DASIA_OXIA_YPOGERGRAMMENI; break;
        case UNICODE_ALPHA_PSILI_PERISPOMENI_YPOGERGRAMMENI: retVal = SORT_ALPHA_PSILI_PERISPOMENI_YPOGERGRAMMENI; break;
        case UNICODE_ALPHA_DASIA_PERISPOMENI_YPOGERGRAMMENI: retVal = SORT_ALPHA_DASIA_PERISPOMENI_YPOGERGRAMMENI; break;
        case UNICODE_ALPHA_VRACHY: retVal = SORT_ALPHA_VRACHY; break;
        case UNICODE_ALPHA_VRACHY_OXIA: retVal = SORT_ALPHA_VRACHY_OXIA; break;
        case UNICODE_ALPHA_MACRON: retVal = SORT_ALPHA_MACRON; break;
        case UNICODE_ALPHA_MACRON_OXIA: retVal = SORT_ALPHA_MACRON_OXIA; break;
        case UNICODE_ALPHA_MACRON_PSILI: retVal = SORT_ALPHA_MACRON_PSILI; break;
        case UNICODE_ALPHA_MACRON_DASIA: retVal = SORT_ALPHA_MACRON_DASIA; break;
        case UNICODE_ALPHA_VARIA_YPOGERGRAMMENI: retVal = SORT_ALPHA_VARIA_YPOGERGRAMMENI; break;
        case UNICODE_ALPHA_YPOGERGRAMMENI: retVal = SORT_ALPHA_YPOGERGRAMMENI; break;
        case UNICODE_ALPHA_OXIA_YPOGERGRAMMENI: retVal = SORT_ALPHA_OXIA_YPOGERGRAMMENI; break;
        case UNICODE_ALPHA_PERISPOMENI: retVal = SORT_ALPHA_PERISPOMENI; break;
        case UNICODE_ALPHA_PERISPOMENI_YPOGERGRAMMENI: retVal = SORT_ALPHA_PERISPOMENI_YPOGERGRAMMENI; break;
            
        case UNICODE_EPSILON: retVal = SORT_EPSILON; break;
        case UNICODE_EPSILON_OXIA2: retVal = SORT_EPSILON_OXIA; break;
        case UNICODE_EPSILON_PSILI: retVal = SORT_EPSILON_PSILI; break;
        case UNICODE_EPSILON_DASIA: retVal = SORT_EPSILON_DASIA; break;
        case UNICODE_EPSILON_PSILI_VARIA: retVal = SORT_EPSILON_PSILI_VARIA; break;
        case UNICODE_EPSILON_DASIA_VARIA: retVal = SORT_EPSILON_DASIA_VARIA; break;
        case UNICODE_EPSILON_PSILI_OXIA: retVal = SORT_EPSILON_PSILI_OXIA; break;
        case UNICODE_EPSILON_DASIA_OXIA: retVal = SORT_EPSILON_DASIA_OXIA; break;
        case UNICODE_EPSILON_VARIA: retVal = SORT_EPSILON_VARIA; break;
        case UNICODE_EPSILON_OXIA: retVal = SORT_EPSILON_OXIA; break;
            
        case UNICODE_ETA: retVal = SORT_ETA; break;
        case UNICODE_ETA_OXIA2: retVal = SORT_ETA_OXIA; break;
        case UNICODE_ETA_PSILI: retVal = SORT_ETA_PSILI; break;
        case UNICODE_ETA_DASIA: retVal = SORT_ETA_DASIA; break;
        case UNICODE_ETA_PSILI_VARIA: retVal = SORT_ETA_PSILI_VARIA; break;
        case UNICODE_ETA_DASIA_VARIA: retVal = SORT_ETA_DASIA_VARIA; break;
        case UNICODE_ETA_PSILI_OXIA: retVal = SORT_ETA_PSILI_OXIA; break;
        case UNICODE_ETA_DASIA_OXIA: retVal = SORT_ETA_DASIA_OXIA; break;
        case UNICODE_ETA_PSILI_PERISPOMENI: retVal = SORT_ETA_PSILI_PERISPOMENI; break;
        case UNICODE_ETA_DASIA_PERISPOMENI: retVal = SORT_ETA_DASIA_PERISPOMENI; break;
        case UNICODE_ETA_VARIA: retVal = SORT_ETA_VARIA; break;
        case UNICODE_ETA_OXIA: retVal = SORT_ETA_OXIA; break;
        case UNICODE_ETA_PSILI_YPOGERGRAMMENI: retVal = SORT_ETA_PSILI_YPOGERGRAMMENI; break;
        case UNICODE_ETA_DASIA_YPOGERGRAMMENI: retVal = SORT_ETA_DASIA_YPOGERGRAMMENI; break;
        case UNICODE_ETA_PSILI_VARIA_YPOGERGRAMMENI: retVal = SORT_ETA_PSILI_VARIA_YPOGERGRAMMENI; break;
        case UNICODE_ETA_DASIA_VARIA_YPOGERGRAMMENI: retVal = SORT_ETA_DASIA_VARIA_YPOGERGRAMMENI; break;
        case UNICODE_ETA_PSILI_OXIA_YPOGERGRAMMENI: retVal = SORT_ETA_PSILI_OXIA_YPOGERGRAMMENI; break;
        case UNICODE_ETA_DASIA_OXIA_YPOGERGRAMMENI: retVal = SORT_ETA_DASIA_OXIA_YPOGERGRAMMENI; break;
        case UNICODE_ETA_PSILI_PERISPOMENI_YPOGERGRAMMENI: retVal = SORT_ETA_PSILI_PERISPOMENI_YPOGERGRAMMENI; break;
        case UNICODE_ETA_DASIA_PERISPOMENI_YPOGERGRAMMENI: retVal = SORT_ETA_DASIA_PERISPOMENI_YPOGERGRAMMENI; break;
        case UNICODE_ETA_VARIA_YPOGERGRAMMENI: retVal = SORT_ETA_VARIA_YPOGERGRAMMENI; break;
        case UNICODE_ETA_YPOGERGRAMMENI: retVal = SORT_ETA_YPOGERGRAMMENI; break;
        case UNICODE_ETA_OXIA_YPOGERGRAMMENI: retVal = SORT_ETA_OXIA_YPOGERGRAMMENI; break;
        case UNICODE_ETA_PERISPOMENI: retVal = SORT_ETA_PERISPOMENI; break;
        case UNICODE_ETA_PERISPOMENI_YPOGERGRAMMENI: retVal = SORT_ETA_PERISPOMENI_YPOGERGRAMMENI; break;
            
        case UNICODE_IOTA: retVal = SORT_IOTA; break;
        case UNICODE_IOTA_OXIA2: retVal = SORT_IOTA_OXIA; break;
        case UNICODE_IOTA_PSILI: retVal = SORT_IOTA_PSILI; break;
        case UNICODE_IOTA_DASIA: retVal = SORT_IOTA_DASIA; break;
        case UNICODE_IOTA_PSILI_VARIA: retVal = SORT_IOTA_PSILI_VARIA; break;
        case UNICODE_IOTA_DASIA_VARIA: retVal = SORT_IOTA_DASIA_VARIA; break;
        case UNICODE_IOTA_PSILI_OXIA: retVal = SORT_IOTA_PSILI_OXIA; break;
        case UNICODE_IOTA_DASIA_OXIA: retVal = SORT_IOTA_DASIA_OXIA; break;
        case UNICODE_IOTA_PSILI_PERISPOMENI: retVal = SORT_IOTA_PSILI_PERISPOMENI; break;
        case UNICODE_IOTA_DASIA_PERISPOMENI: retVal = SORT_IOTA_DASIA_PERISPOMENI; break;
        case UNICODE_IOTA_VARIA: retVal = SORT_IOTA_VARIA; break;
        case UNICODE_IOTA_OXIA: retVal = SORT_IOTA_OXIA; break;
        case UNICODE_IOTA_VRACHY: retVal = SORT_IOTA_VRACHY; break;
        case UNICODE_IOTA_MACRON: retVal = SORT_IOTA_MACRON; break;
        case UNICODE_IOTA_VARIA_DIALYTIKA: retVal = SORT_IOTA_VARIA_DIALYTIKA; break;
        case UNICODE_IOTA_DIALYTIKA: retVal = SORT_IOTA_DIALYTIKA; break;
        case UNICODE_IOTA_PERISPOMENI: retVal = SORT_IOTA_PERISPOMENI; break;
        case UNICODE_IOTA_PERISPOMENI_DIALYTIKA: retVal = SORT_IOTA_PERISPOMENI_DIALYTIKA; break;
            
        case UNICODE_OMICRON: retVal = SORT_OMICRON; break;
        case UNICODE_OMICRON_PSILI: retVal = SORT_OMICRON_PSILI; break;
        case UNICODE_OMICRON_DASIA: retVal = SORT_OMICRON_DASIA; break;
        case UNICODE_OMICRON_PSILI_VARIA: retVal = SORT_OMICRON_PSILI_VARIA; break;
        case UNICODE_OMICRON_DASIA_VARIA: retVal = SORT_OMICRON_DASIA_VARIA; break;
        case UNICODE_OMICRON_PSILI_OXIA: retVal = SORT_OMICRON_PSILI_OXIA; break;
        case UNICODE_OMICRON_DASIA_OXIA: retVal = SORT_OMICRON_DASIA_OXIA; break;
        case UNICODE_OMICRON_VARIA: retVal = SORT_OMICRON_VARIA; break;
        case UNICODE_OMICRON_OXIA: retVal = SORT_OMICRON_OXIA; break;
            
        case UNICODE_UPSILON: retVal = SORT_UPSILON; break;
        case UNICODE_UPSILON_OXIA2: retVal = SORT_UPSILON_OXIA; break;
        case UNICODE_UPSILON_PSILI: retVal = SORT_UPSILON_PSILI; break;
        case UNICODE_UPSILON_DASIA: retVal = SORT_UPSILON_DASIA; break;
        case UNICODE_UPSILON_PSILI_VARIA: retVal = SORT_UPSILON_PSILI_VARIA; break;
        case UNICODE_UPSILON_DASIA_VARIA: retVal = SORT_UPSILON_DASIA_VARIA; break;
        case UNICODE_UPSILON_PSILI_OXIA: retVal = SORT_UPSILON_PSILI_OXIA; break;
        case UNICODE_UPSILON_DASIA_OXIA: retVal = SORT_UPSILON_DASIA_OXIA; break;
        case UNICODE_UPSILON_PSILI_PERISPOMENI: retVal = SORT_UPSILON_PSILI_PERISPOMENI; break;
        case UNICODE_UPSILON_DASIA_PERISPOMENI: retVal = SORT_UPSILON_DASIA_PERISPOMENI; break;
        case UNICODE_UPSILON_VARIA: retVal = SORT_UPSILON_VARIA; break;
        case UNICODE_UPSILON_OXIA: retVal = SORT_UPSILON_OXIA; break;
        case UNICODE_UPSILON_VRACHY: retVal = SORT_UPSILON_VRACHY; break;
        case UNICODE_UPSILON_VRACHY_OXIA: retVal = SORT_UPSILON_VRACHY_OXIA; break;
        case UNICODE_UPSILON_MACRON: retVal = SORT_UPSILON_MACRON; break;
        case UNICODE_UPSILON_VARIA_DIALYTIKA: retVal = SORT_UPSILON_VARIA_DIALYTIKA; break;
        case UNICODE_UPSILON_OXIA_DIALYTIKA: retVal = SORT_UPSILON_OXIA_DIALYTIKA; break;
        case UNICODE_UPSILON_DIALYTIKA: retVal = SORT_UPSILON_DIALYTIKA; break;
        case UNICODE_UPSILON_PERISPOMENI: retVal = SORT_UPSILON_PERISPOMENI; break;
        case UNICODE_UPSILON_PERISPOMENI_DIALYTIKA: retVal = SORT_UPSILON_PERISPOMENI_DIALYTIKA; break;
            
        case UNICODE_OMEGA: retVal = SORT_OMEGA; break;
        case UNICODE_OMEGA_PSILI: retVal = SORT_OMEGA_PSILI; break;
        case UNICODE_OMEGA_DASIA: retVal = SORT_OMEGA_DASIA; break;
        case UNICODE_OMEGA_PSILI_VARIA: retVal = SORT_OMEGA_PSILI_VARIA; break;
        case UNICODE_OMEGA_DASIA_VARIA: retVal = SORT_OMEGA_DASIA_VARIA; break;
        case UNICODE_OMEGA_PSILI_OXIA: retVal = SORT_OMEGA_PSILI_OXIA; break;
        case UNICODE_OMEGA_DASIA_OXIA: retVal = SORT_OMEGA_DASIA_OXIA; break;
        case UNICODE_OMEGA_PSILI_PERISPOMENI: retVal = SORT_OMEGA_PSILI_PERISPOMENI; break;
        case UNICODE_OMEGA_DASIA_PERISPOMENI: retVal = SORT_OMEGA_DASIA_PERISPOMENI; break;
        case UNICODE_OMEGA_VARIA: retVal = SORT_OMEGA_VARIA; break;
        case UNICODE_OMEGA_OXIA: retVal = SORT_OMEGA_OXIA; break;
        case UNICODE_OMEGA_PSILI_YPOGERGRAMMENI: retVal = SORT_OMEGA_PSILI_YPOGERGRAMMENI; break;
        case UNICODE_OMEGA_DASIA_YPOGERGRAMMENI: retVal = SORT_OMEGA_DASIA_YPOGERGRAMMENI; break;
        case UNICODE_OMEGA_PSILI_VARIA_YPOGERGRAMMENI: retVal = SORT_OMEGA_PSILI_VARIA_YPOGERGRAMMENI; break;
        case UNICODE_OMEGA_DASIA_VARIA_YPOGERGRAMMENI: retVal = SORT_OMEGA_DASIA_VARIA_YPOGERGRAMMENI; break;
        case UNICODE_OMEGA_PSILI_OXIA_YPOGERGRAMMENI: retVal = SORT_OMEGA_PSILI_OXIA_YPOGERGRAMMENI; break;
        case UNICODE_OMEGA_DASIA_OXIA_YPOGERGRAMMENI: retVal = SORT_OMEGA_DASIA_OXIA_YPOGERGRAMMENI; break;
        case UNICODE_OMEGA_PSILI_PERISPOMENI_YPOGERGRAMMENI: retVal = SORT_OMEGA_PSILI_PERISPOMENI_YPOGERGRAMMENI; break;
        case UNICODE_OMEGA_DASIA_PERISPOMENI_YPOGERGRAMMENI: retVal = SORT_OMEGA_DASIA_PERISPOMENI_YPOGERGRAMMENI; break;
        case UNICODE_OMEGA_VARIA_YPOGERGRAMMENI: retVal = SORT_OMEGA_VARIA_YPOGERGRAMMENI; break;
        case UNICODE_OMEGA_YPOGERGRAMMENI: retVal = SORT_OMEGA_YPOGERGRAMMENI; break;
        case UNICODE_OMEGA_OXIA_YPOGERGRAMMENI: retVal = SORT_OMEGA_OXIA_YPOGERGRAMMENI; break;
        case UNICODE_OMEGA_PERISPOMENI: retVal = SORT_OMEGA_PERISPOMENI; break;
        case UNICODE_OMEGA_PERISPOMENI_YPOGERGRAMMENI: retVal = SORT_OMEGA_PERISPOMENI_YPOGERGRAMMENI; break;
            
        case UNICODE_RHO: retVal = SORT_RHO; break;
        case UNICODE_RHO_PSILI: retVal = SORT_RHO_PSILI; break;
        case UNICODE_RHO_DASIA: retVal = SORT_RHO_DASIA; break;
            
        case UNICODE_BETA: retVal = SORT_BETA; break;
        case UNICODE_GAMMA: retVal = SORT_GAMMA; break;
        case UNICODE_DELTA: retVal = SORT_DELTA; break;
        case UNICODE_ZETA: retVal = SORT_ZETA; break;
        case UNICODE_THETA: retVal = SORT_THETA; break;
        case UNICODE_KAPPA: retVal = SORT_KAPPA; break;
        case UNICODE_LAMBDA: retVal = SORT_LAMBDA; break;
        case UNICODE_MI: retVal = SORT_MI; break;
        case UNICODE_NI: retVal = SORT_NI; break;
        case UNICODE_XI: retVal = SORT_XI; break;
        case UNICODE_PI: retVal = SORT_PI; break;
        case UNICODE_SIGMA_FINAL: retVal = SORT_SIGMA_FINAL; break;
        case UNICODE_SIGMA: retVal = SORT_SIGMA; break;
        case UNICODE_TAU: retVal = SORT_TAU; break;
        case UNICODE_PHI: retVal = SORT_PHI; break;
        case UNICODE_CHI: retVal = SORT_CHI; break;
        case UNICODE_PSI: retVal = SORT_PSI; break;
            
        case UNICODE_DIGAMMA: retVal = SORT_DIGAMMA; break;
            
            // to be relocated
        case UNICODE_IOTA_DIALYTIKA_VARIA: retVal = SORT_IOTA_DIALYTIKA_VARIA; break;
        case UNICODE_IOTA_DIALYTIKA_OXIA: retVal = SORT_IOTA_DIALYTIKA_OXIA; break;
        case UNICODE_IOTA_VRACHY_OXIA: retVal = SORT_IOTA_VRACHY_OXIA; break;
        case UNICODE_IOTA_MACRON_OXIA: retVal = SORT_IOTA_MACRON_OXIA; break;
        case UNICODE_UPSILON_MACRON_OXIA: retVal = SORT_UPSILON_MACRON_OXIA; break;
            
            //search: UNICODE_([A-Z_0-9]*) = 0x....,
            //replace: case UNICODE_\1:
        case UNICODE_CAPITAL_ALPHA: retVal = SORT_ALPHA; break;
        case UNICODE_CAPITAL_ALPHA_PSILI: retVal = SORT_ALPHA_PSILI; break;
        case UNICODE_CAPITAL_ALPHA_DASIA: retVal = SORT_ALPHA_DASIA; break;
        case UNICODE_CAPITAL_ALPHA_PSILI_VARIA: retVal = SORT_ALPHA_PSILI_VARIA; break;
        case UNICODE_CAPITAL_ALPHA_DASIA_VARIA: retVal = SORT_ALPHA_DASIA_VARIA; break;
        case UNICODE_CAPITAL_ALPHA_PSILI_OXIA: retVal = SORT_ALPHA_PSILI_OXIA; break;
        case UNICODE_CAPITAL_ALPHA_DASIA_OXIA: retVal = SORT_ALPHA_DASIA_OXIA; break;
        case UNICODE_CAPITAL_ALPHA_PSILI_PERISPOMENI: retVal = SORT_ALPHA_PSILI_PERISPOMENI; break;
        case UNICODE_CAPITAL_ALPHA_DASIA_PERISPOMENI: retVal = SORT_ALPHA_DASIA_PERISPOMENI; break;
        case UNICODE_CAPITAL_ALPHA_VARIA: retVal = SORT_ALPHA_VARIA; break;
        case UNICODE_CAPITAL_ALPHA_OXIA: retVal = SORT_ALPHA_OXIA; break;
        case UNICODE_CAPITAL_ALPHA_VRACHY: retVal = SORT_ALPHA_VRACHY; break;
        case UNICODE_CAPITAL_ALPHA_MACRON: retVal = SORT_ALPHA_MACRON; break;
            
        case UNICODE_CAPITAL_BETA: retVal = SORT_BETA; break;
        case UNICODE_CAPITAL_GAMMA: retVal = SORT_GAMMA; break;
        case UNICODE_CAPITAL_DELTA: retVal = SORT_DELTA; break;
            
        case UNICODE_CAPITAL_EPSILON: retVal = SORT_EPSILON; break;
        case UNICODE_CAPITAL_EPSILON_PSILI: retVal = SORT_EPSILON_PSILI; break;
        case UNICODE_CAPITAL_EPSILON_DASIA: retVal = SORT_EPSILON_DASIA; break;
        case UNICODE_CAPITAL_EPSILON_PSILI_VARIA: retVal = SORT_EPSILON_PSILI_VARIA; break;
        case UNICODE_CAPITAL_EPSILON_DASIA_VARIA: retVal = SORT_EPSILON_DASIA_VARIA; break;
        case UNICODE_CAPITAL_EPSILON_PSILI_OXIA: retVal = SORT_EPSILON_PSILI_OXIA; break;
        case UNICODE_CAPITAL_EPSILON_DASIA_OXIA: retVal = SORT_EPSILON_DASIA_OXIA; break;
        case UNICODE_CAPITAL_EPSILON_VARIA: retVal = SORT_EPSILON_VARIA; break;
        case UNICODE_CAPITAL_EPSILON_OXIA: retVal = SORT_EPSILON_OXIA; break;
            
        case UNICODE_CAPITAL_ZETA: retVal = SORT_ZETA; break;
            
        case UNICODE_CAPITAL_ETA: retVal = SORT_ETA; break;
        case UNICODE_CAPITAL_ETA_PSILI: retVal = SORT_ETA_PSILI; break;
        case UNICODE_CAPITAL_ETA_DASIA: retVal = SORT_ETA_DASIA; break;
        case UNICODE_CAPITAL_ETA_PSILI_VARIA: retVal = SORT_ETA_PSILI_VARIA; break;
        case UNICODE_CAPITAL_ETA_DASIA_VARIA: retVal = SORT_ETA_DASIA_VARIA; break;
        case UNICODE_CAPITAL_ETA_PSILI_OXIA: retVal = SORT_ETA_PSILI_OXIA; break;
        case UNICODE_CAPITAL_ETA_DASIA_OXIA: retVal = SORT_ETA_DASIA_OXIA; break;
        case UNICODE_CAPITAL_ETA_PSILI_PERISPOMENI: retVal = SORT_ETA_PSILI_PERISPOMENI; break;
        case UNICODE_CAPITAL_ETA_DASIA_PERISPOMENI: retVal = SORT_ETA_DASIA_PERISPOMENI; break;
        case UNICODE_CAPITAL_ETA_VARIA: retVal = SORT_ETA_VARIA; break;
        case UNICODE_CAPITAL_ETA_OXIA: retVal = SORT_ETA_OXIA; break;
            
        case UNICODE_CAPITAL_THETA: retVal = SORT_THETA; break;
            
        case UNICODE_CAPITAL_IOTA: retVal = SORT_IOTA; break;
        case UNICODE_CAPITAL_IOTA_PSILI: retVal = SORT_IOTA_PSILI; break;
        case UNICODE_CAPITAL_IOTA_DASIA: retVal = SORT_IOTA_DASIA; break;
        case UNICODE_CAPITAL_IOTA_PSILI_VARIA: retVal = SORT_IOTA_PSILI_VARIA; break;
        case UNICODE_CAPITAL_IOTA_DASIA_VARIA: retVal = SORT_IOTA_DASIA_VARIA; break;
        case UNICODE_CAPITAL_IOTA_PSILI_OXIA: retVal = SORT_IOTA_PSILI_OXIA; break;
        case UNICODE_CAPITAL_IOTA_DASIA_OXIA: retVal = SORT_IOTA_DASIA_OXIA; break;
        case UNICODE_CAPITAL_IOTA_PSILI_PERISPOMENI: retVal = SORT_IOTA_PSILI_PERISPOMENI; break;
        case UNICODE_CAPITAL_IOTA_DASIA_PERISPOMENI: retVal = SORT_IOTA_DASIA_PERISPOMENI; break;
        case UNICODE_CAPITAL_IOTA_VARIA: retVal = SORT_IOTA_VARIA; break;
        case UNICODE_CAPITAL_IOTA_OXIA: retVal = SORT_IOTA_OXIA; break;
        case UNICODE_CAPITAL_IOTA_VRACHY: retVal = SORT_IOTA_VRACHY; break;
        case UNICODE_CAPITAL_IOTA_MACRON: retVal = SORT_IOTA_MACRON; break;
            
        case UNICODE_CAPITAL_KAPPA: retVal = SORT_KAPPA; break;
        case UNICODE_CAPITAL_LAMBDA: retVal = SORT_LAMBDA; break;
        case UNICODE_CAPITAL_MI: retVal = SORT_MI; break;
        case UNICODE_CAPITAL_NI: retVal = SORT_NI; break;
        case UNICODE_CAPITAL_XI: retVal = SORT_XI; break;
            
        case UNICODE_CAPITAL_OMICRON: retVal = SORT_OMICRON; break;
        case UNICODE_CAPITAL_OMICRON_PSILI: retVal = SORT_OMICRON_PSILI; break;
        case UNICODE_CAPITAL_OMICRON_DASIA: retVal = SORT_OMICRON_DASIA; break;
        case UNICODE_CAPITAL_OMICRON_PSILI_VARIA: retVal = SORT_OMICRON_PSILI_VARIA; break;
        case UNICODE_CAPITAL_OMICRON_DASIA_VARIA: retVal = SORT_OMICRON_DASIA_VARIA; break;
        case UNICODE_CAPITAL_OMICRON_PSILI_OXIA: retVal = SORT_OMICRON_PSILI_OXIA; break;
        case UNICODE_CAPITAL_OMICRON_DASIA_OXIA: retVal = SORT_OMICRON_DASIA_OXIA; break;
        case UNICODE_CAPITAL_OMICRON_VARIA: retVal = SORT_OMICRON_VARIA; break;
        case UNICODE_CAPITAL_OMICRON_OXIA: retVal = SORT_OMICRON_OXIA; break;
            
            
        case UNICODE_CAPITAL_PI: retVal = SORT_PI; break;
            
        case UNICODE_CAPITAL_RHO: retVal = SORT_RHO; break;
        case UNICODE_CAPITAL_RHO_DASIA: retVal = SORT_RHO_DASIA; break;
            
        case UNICODE_CAPITAL_SIGMA: retVal = SORT_SIGMA; break;
        case UNICODE_CAPITAL_TAU: retVal = SORT_TAU; break;
            
        case UNICODE_CAPITAL_UPSILON: retVal = SORT_UPSILON; break;
        case UNICODE_CAPITAL_UPSILON_DASIA: retVal = SORT_UPSILON_DASIA; break;
        case UNICODE_CAPITAL_UPSILON_DASIA_VARIA: retVal = SORT_UPSILON_DASIA_VARIA; break;
        case UNICODE_CAPITAL_UPSILON_DASIA_OXIA: retVal = SORT_UPSILON_DASIA_OXIA; break;
        case UNICODE_CAPITAL_UPSILON_DASIA_PERISPOMENI: retVal = SORT_UPSILON_DASIA_PERISPOMENI; break;
        case UNICODE_CAPITAL_UPSILON_VARIA: retVal = SORT_UPSILON_VARIA; break;
        case UNICODE_CAPITAL_UPSILON_OXIA: retVal = SORT_UPSILON_OXIA; break;
        case UNICODE_CAPITAL_UPSILON_VRACHY: retVal = SORT_UPSILON_VRACHY; break;
        case UNICODE_CAPITAL_UPSILON_MACRON: retVal = SORT_UPSILON_MACRON; break;
            
        case UNICODE_CAPITAL_PHI: retVal = SORT_PHI; break;
        case UNICODE_CAPITAL_CHI: retVal = SORT_CHI; break;
        case UNICODE_CAPITAL_PSI: retVal = SORT_PSI; break;
            
        case UNICODE_CAPITAL_OMEGA: retVal = SORT_OMEGA; break;
        case UNICODE_CAPITAL_OMEGA_PSILI: retVal = SORT_OMEGA_PSILI; break;
        case UNICODE_CAPITAL_OMEGA_DASIA: retVal = SORT_OMEGA_DASIA; break;
        case UNICODE_CAPITAL_OMEGA_PSILI_VARIA: retVal = SORT_OMEGA_PSILI_VARIA; break;
        case UNICODE_CAPITAL_OMEGA_DASIA_VARIA: retVal = SORT_OMEGA_DASIA_VARIA; break;
        case UNICODE_CAPITAL_OMEGA_PSILI_OXIA: retVal = SORT_OMEGA_PSILI_OXIA; break;
        case UNICODE_CAPITAL_OMEGA_DASIA_OXIA: retVal = SORT_OMEGA_DASIA_OXIA; break;
        case UNICODE_CAPITAL_OMEGA_PSILI_PERISPOMENI: retVal = SORT_OMEGA_PSILI_PERISPOMENI; break;
        case UNICODE_CAPITAL_OMEGA_DASIA_PERISPOMENI: retVal = SORT_OMEGA_DASIA_PERISPOMENI; break;
        case UNICODE_CAPITAL_OMEGA_VARIA: retVal = SORT_OMEGA_VARIA; break;
        case UNICODE_CAPITAL_OMEGA_OXIA: retVal = SORT_OMEGA_OXIA; break;
            
        case UNICODE_CAPITAL_ALPHA_PERISPOMENI: retVal = SORT_ALPHA_PERISPOMENI; break;
            
            // Signs
//        case UNICODE_SIGN_PSILI: retVal = SORT_SIGN_PSILI; break;
//        case UNICODE_SIGN_DASIA: retVal = SORT_SIGN_DASIA; break;
//        case UNICODE_SIGN_VARIA: retVal = SORT_SIGN_VARIA; break;
//        case UNICODE_SIGN_OXIA: retVal = SORT_SIGN_OXIA; break;
//        case UNICODE_SIGN_PERISPOMENI: retVal = SORT_SIGN_PERISPOMENI; break;
//        case UNICODE_SIGN_YPOGERGRAMMENI: retVal = SORT_SIGN_YPOGERGRAMMENI; break;
            
            // Other chars
        case UNICODE_SIGN_PSILI:
        case UNICODE_SIGN_DASIA:
        case UNICODE_SIGN_VARIA:
        case UNICODE_SIGN_OXIA:
        case UNICODE_SIGN_PERISPOMENI:
        case UNICODE_SIGN_YPOGERGRAMMENI:
        case UNICODE_PUNCT_SPACE:
        case UNICODE_PUNCT_PARENTHESES_CLOSE:
        case UNICODE_PUNCT_PARENTHESES_OPEN:
        case UNICODE_PUNCT_DASH:
        case UNICODE_PUNCT_DOT:
        case UNICODE_PUNCT_COMMA:
        case UNICODE_PUNCT_ELLIPSIS:
        case UNICODE_PUNCT_COLON:
        case UNICODE_PUNCT_SEMICOLON:
        case UNICODE_PUNCT_QUESTION_MARK:
        case UNICODE_PUNCT_EXCLAMATION_MARK:
        case UNICODE_PUNCT_SLASH:
        case UNICODE_PUNCT_PERMIL:
        case UNICODE_PUNCT_LONG_DASH:
        case UNICODE_PUNCT_XXL_DASH:
        case UNICODE_PUNCT_DQUOTE_OPEN:
        case UNICODE_ACCENT_ACUTE:
        case UNICODE_ACCENT_ACUTE_LOW:
        case UNICODE_LATIN_S_CARON:
        case UNICODE_EXTRA_01:
        case UNICODE_EXTRA_02:
        case UNICODE_EXTRA_03:
        case UNICODE_EXTRA_04:
        case UNICODE_EXTRA_05:
        case UNICODE_EXTRA_06:
        case UNICODE_EXTRA_07:
        case UNICODE_EXTRA_08:
        case UNICODE_EXTRA_09:
        case UNICODE_EXTRA_10:
        case UNICODE_EXTRA_11:
        case UNICODE_EXTRA_12:
        case UNICODE_EXTRA_13:
        case UNICODE_EXTRA_14:
        case UNICODE_EXTRA_15:
        case UNICODE_EXTRA_16:
        case UNICODE_EXTRA_17:
        case UNICODE_EXTRA_18:
        case UNICODE_EXTRA_19:
        case UNICODE_EXTRA_20:
        case UNICODE_EXTRA_21:
        case UNICODE_EXTRA_22:
        case UNICODE_EXTRA_23:
        case UNICODE_EXTRA_24:
        case UNICODE_EXTRA_25:
        case UNICODE_EXTRA_26:
        case UNICODE_EXTRA_27:
        case UNICODE_EXTRA_28:
        case UNICODE_EXTRA_29:
        case UNICODE_EXTRA_30:
        case UNICODE_EXTRA_31:
        case UNICODE_EXTRA_32:
        case UNICODE_EXTRA_33:
        case UNICODE_EXTRA_34:
        case UNICODE_EXTRA_35:
        case UNICODE_EXTRA_36:
        case UNICODE_EXTRA_37:
        case UNICODE_EXTRA_38:
        case UNICODE_EXTRA_39:
        case UNICODE_EXTRA_40:
        case UNICODE_EXTRA_41:
        case UNICODE_EXTRA_42:
        case UNICODE_EXTRA_43:
        case UNICODE_EXTRA_44:
        case UNICODE_EXTRA_45:
        case UNICODE_EXTRA_46:
        case UNICODE_EXTRA_47:
        case UNICODE_EXTRA_48:
        case UNICODE_EXTRA_49:
        case UNICODE_EXTRA_50:
        case UNICODE_EXTRA_51:
        case UNICODE_EXTRA_52:
        case UNICODE_EXTRA_53:
        case UNICODE_EXTRA_54:
        case UNICODE_EXTRA_55:
        case UNICODE_EXTRA_56:
        case UNICODE_EXTRA_57:
        case UNICODE_EXTRA_58:
        case UNICODE_EXTRA_59:
        case UNICODE_EXTRA_60:
        case UNICODE_EXTRA_61:
        case UNICODE_EXTRA_62:
        case UNICODE_EXTRA_63:
        case UNICODE_EXTRA_64:
        case UNICODE_EXTRA_65:
            
            // skip special characters
            retVal = SORT_SKIP; break;
            
    }
    return retVal;
}

@end
