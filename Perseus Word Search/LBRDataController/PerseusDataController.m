//
//  PerseusDataController.m
//  VerbiGreci
//
//  Created by Claudio Capobianco on 07/04/12.
//  Copyright (c) 2012 Librum. All rights reserved.
//

#import "PerseusDataController.h"
#import "LBRGreekWordFilter.h"
#import "LBRGreekWord.h"
#import "LBRGreekString.h"


NSXMLParser* perseusParser;
//NSMutableString* tempVal;
NSString* tempVal;
NSMutableDictionary* tempWord;


@interface PerseusDataController () <NSXMLParserDelegate>

@property NSMutableArray* wordList;

@end

@implementation PerseusDataController

@synthesize wordList = _wordList;


//static NSString * const kGreekWordsArchiveFilename = @"greek.morph.archive";


#pragma mark -
#pragma mark NSXMLParser

static NSString * const kAnalyses = @"analyses";
static NSString * const kAnalysis = @"analysis";
static NSString * const kForm = @"form";
static NSString * const kLemma = @"lemma";
static NSString * const kPos = @"pos";
static NSString * const kPerson = @"person";
static NSString * const kNumber = @"number";
static NSString * const kTense = @"tense";
static NSString * const kMood = @"mood";
static NSString * const kVoice = @"voice";
static NSString * const kDialect = @"dialect";
static NSString * const kFeature = @"feature";
static NSString * const kGender = @"gender";
static NSString * const kCase = @"case";

- (void)parseXMLFile:(NSURL *)xmlURL {
    BOOL success;
    perseusParser = [[NSXMLParser alloc] initWithContentsOfURL:xmlURL];
    [perseusParser setDelegate:self];
    //[addressParser setShouldResolveExternalEntities:NO];
    success = [perseusParser parse]; // return value not used
    // if not successful, delegate is informed of error
}

#pragma mark NSXMLParser delegate methods

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    tempVal = @"";
    if ( [elementName isEqualToString:kAnalysis]) {
        tempWord = [[NSMutableDictionary alloc] init];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    tempVal = string;
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    static int counter = 0;
    static int okCounter = 0;
    
    //if (counter < 100000)
    {
        if ( [elementName isEqualToString:kAnalysis] ) {
            counter++;
            //NSLog(@"Adding form %@",tempWord.form);
            // FIXME: this version manage only verbs and participle
            // FIXME: we need to filter words because the whole database is too big and take too much time to be parsed.
            // Please suggest a solution!
            if ([LBRGreekWordFilter filterWord:tempWord]) {
                okCounter++;
                [self addGreekWord:tempWord];
            }
            if ( (counter % 10000) == 0) {
                NSLog(@"Added %d/%d forms, continuing...",okCounter,counter);
            }
            return;
        }
        else if ([elementName isEqualToString:kForm]) {
            NSString* form = [LBRGreekString ascii2greek:tempVal];
            [tempWord setObject:form forKey:@"form"];
            [tempWord setObject:[LBRGreekString toPlain:form] forKey:@"plainForm"];
        }
        else if ([elementName isEqualToString:kLemma]) {
            [tempWord setObject:[LBRGreekString ascii2greek:tempVal] forKey:@"lemma"];
        }
        else if ([elementName isEqualToString:kPos]) {
            [tempWord setObject:tempVal forKey:@"pos"];
        }
        else if ([elementName isEqualToString:kPerson]) {
            [tempWord setObject:tempVal forKey:@"person"];
        }
        else if ([elementName isEqualToString:kNumber]) {
            [tempWord setObject:tempVal forKey:@"number"];
        }
        else if ([elementName isEqualToString:kTense]) {
            [tempWord setObject:tempVal forKey:@"tense"];
        }
        else if ([elementName isEqualToString:kMood]) {
            [tempWord setObject:tempVal forKey:@"mood"];
        }
        else if ([elementName isEqualToString:kVoice]) {
            [tempWord setObject:tempVal forKey:@"voice"];
        }
        else if ([elementName isEqualToString:kDialect]) {
            tempWord = [LBRGreekWord addDialect:tempVal toWord:tempWord];
        }
        else if ([elementName isEqualToString:kFeature]) {
            tempWord = [LBRGreekWord addFeature:tempVal toWord:tempWord];
        }
        else if ([elementName isEqualToString:kGender]) {
            [tempWord setObject:tempVal forKey:@"gender"];
        }
        else if ([elementName isEqualToString:kCase]) {
            [tempWord setObject:tempVal forKey:@"gcase"];
        }
        
    }
    
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    NSLog(@"Parse Error: line %d, column %d",(int)[parser lineNumber], (int)[parser columnNumber]);
}

#pragma mark -
#pragma mark Data Controller methods
#pragma mark Populate list
- (BOOL)populateWithXml:(NSURL*)xmlURL {
    BOOL ret = NO;
    self.wordList = [[NSMutableArray alloc] init];
    [self parseXMLFile:xmlURL];
    NSUInteger count = [self.wordList count];
    if (count > 0) {
        NSLog(@"Added %u forms",(int)count);
        ret = YES;
    } else {
        NSLog(@"Cannot parse %@",xmlURL);
    }
    return ret;
}


- (BOOL)populateWithArchive:(NSURL*)archive {
    BOOL ret = NO;
    NSInputStream* inStream = [NSInputStream inputStreamWithURL:archive];
    NSPropertyListFormat * format = NULL;
    NSError* error = NULL;
    [inStream open];
    self.wordList = [NSPropertyListSerialization propertyListWithStream:inStream options:0 format:format error:&error];
    [inStream close];
    if (self.wordList == nil) {
        NSLog(@"Cannot read from archive %@",archive);
    } else {
        NSUInteger count = [self.wordList count];
        NSLog(@"Word list read from archive %@: %u forms",archive,(int)count);
        ret = YES;
    }
    return ret;
}

-(BOOL)saveArchiveWithFilename:(NSURL*)archive {
    BOOL isArchived = NO;
    NSOutputStream* outStream = [NSOutputStream outputStreamWithURL:archive append:NO];
    NSError* error = NULL;
    [outStream open];
    NSInteger len = [NSPropertyListSerialization writePropertyList:self.wordList toStream:outStream format:NSPropertyListBinaryFormat_v1_0 options:0 error:&error];
    [outStream close];
    if (len > 0) {
        NSLog(@"Archive %@ created",archive);
        isArchived = YES;
    } else {
        NSLog(@"Cannot archive %@",archive);
    }
    return isArchived;
}

#pragma mark Init
- (id)init {
    if (self = [super init]) {
        [LBRGreekString initialize];
        return self;
    }
    return nil;
}

#pragma mark Word list
-(NSArray*)getWordList {
    return _wordList;
}

- (void)addGreekWord:(NSDictionary*)word {
    [self.wordList addObject:word];
}

#pragma mark Definitions

-(NSAttributedString*)getDataWithId:(NSUInteger)word_id {
    
    NSFont *font = [NSFont fontWithName:@"New Athena Unicode" size:24.0];
    NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    
    NSMutableAttributedString* text = [[NSMutableAttributedString alloc] initWithString:@"" attributes:attrsDictionary];
    
    
    return text;
}


@end
