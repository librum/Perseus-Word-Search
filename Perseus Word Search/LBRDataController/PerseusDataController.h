//
//  PerseusDataController.h

//
//  Created by Claudio Capobianco on 07/04/12.
//  Copyright (c) 2012 Librum. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LBRGreekWord;

static NSString * const DATACTRL_KEY_SEARCH = @"form";
static NSString * const DATACTRL_KEY_LIST = @"form";
static NSString * const DATACTRL_KEY_LIST_2 = @"lemma";
static NSString * const DATACTRL_KEY_LIST_3 = @"mood";


@interface PerseusDataController : NSObject

-(NSArray*)getWordList;
-(NSAttributedString*)getDataWithId:(NSUInteger)word_id;

-(BOOL)populateWithXml:(NSURL*)url;
-(BOOL)populateWithArchive:(NSURL*)url;

-(BOOL)saveArchiveWithFilename:(NSURL*)url;
    
@end
