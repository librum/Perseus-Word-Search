//
//  ViewController.m
//  Perseus Word Search
//
//  Created by Claudio Capobianco on 26/02/13.
//  Copyright (c) 2013 Librum. All rights reserved.
//

#import "ViewController.h"
#import "LBRGreekFormatter.h"

#import "PerseusDataController.h"
#import "LBRStringController.h"
#import "LBRGreekString.h"
#import "LBRGreekFilter.h"
#import "LBRGreekWord.h"
#import "LBRReport.h"

//singleton to avoid a not initialized self pointer on IBAction
ViewController* mySelf = nil;

@interface ViewController ()
@property PerseusDataController* perseusController;
@property NSDictionary *attrsDictionary;

@property LBRStringController* mySearchString;

@property NSTextStorage* textStorage;
@property NSTextContainer* textContainer;

@property LBRReport* report;

@end

@implementation ViewController

@synthesize wordDescription = _wordDescription;
@synthesize perseusController = _perseusController;
@synthesize attrsDictionary = _attrsDictionary;
@synthesize mySearchString = _mySearchString;
@synthesize textStorage = _textStorage;
@synthesize reportLabel = _reportLabel;
@synthesize report = _report;

#pragma mark -
#pragma mark Initialization


-(id)init
{
    self = [super init];
    mySelf = self; // store the last self, ie the valid one
    
    NSFont *font = [NSFont fontWithName:@"New Athena Unicode" size:12.0];
    self.attrsDictionary = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    [[[self.wordDescription textStorage] mutableString] setString:@""];
    self.perseusController = [[PerseusDataController alloc] init];
    
    return self;
}

-(NSString*)addLocalizedField:(NSString*)field toArray:(NSArray*)array{
    NSString* dictName = @"PerseusDict";
    NSString* locKey = [[NSString alloc]initWithFormat:@"loc%@",field];
    if (array != nil) {
        for (NSMutableDictionary *word in array)
        {
            NSString* locString = NSLocalizedStringFromTable([LBRGreekWord getVerbMood:word],dictName,@"");
            //NSString* locString = NSLocalizedStringFromTable([word objectForKey:field],dictName,@"");
            
            [word setObject:locString forKey:locKey];
        }
    }
    return locKey;
}

-(void)awakeFromNib {

   [self.wordTableView setRowHeight:18];
    
    NSString* dictName = @"InfoPlist";
    NSTableColumn *column = [self.wordTableView tableColumnWithIdentifier:@"form"];
    NSString* keyPath = [[NSString alloc]initWithFormat:@"arrangedObjects.%@",DATACTRL_KEY_LIST];
	[column bind:@"value" toObject:self.wordContentArray withKeyPath:keyPath options:nil];
    [column.headerCell setStringValue:NSLocalizedStringFromTable(@"Form",dictName,@"Form")];
    
    column = [self.wordTableView tableColumnWithIdentifier:@"lemma"];
    keyPath = [[NSString alloc]initWithFormat:@"arrangedObjects.%@",DATACTRL_KEY_LIST_2];
	[column bind:@"value" toObject:self.wordContentArray withKeyPath:keyPath options:nil];
    [column.headerCell setStringValue:NSLocalizedStringFromTable(@"Lemma",dictName,@"Lemma")];
    
    column = [self.wordTableView tableColumnWithIdentifier:@"mood"];
    NSString* locKey = [self addLocalizedField:DATACTRL_KEY_LIST_3 toArray:nil];
    keyPath = [[NSString alloc]initWithFormat:@"arrangedObjects.%@",locKey];
	[column bind:@"value" toObject:self.wordContentArray withKeyPath:keyPath options:nil];
    [column.headerCell setStringValue:NSLocalizedStringFromTable(@"Mood",dictName,@"Mood")];
    
    
    // start listening for selection changes in our NSTableView's array controller
	[self.wordContentArray addObserver: self
                          forKeyPath: @"selectionIndexes"
                             options: NSKeyValueObservingOptionNew
                             context: NULL];
    
    self.mySearchString = [[LBRStringController alloc] init];
    //[self.searchView bind:@"searchText" toObject:self.mySearchString withKeyPath:@"string" options:nil];
    NSString* findLemmaTxt = NSLocalizedStringFromTable(@"Find placeholder",@"InfoPlist",
                                                        @"Placeholder for find field");
    [[self.searchField cell] setPlaceholderString:findLemmaTxt];
    [[self.searchField cell] setFormatter:[[LBRGreekFormatter alloc]init]];
    
    [self.mySearchString addObserver:self
                          forKeyPath:@"string"
                             options:NSKeyValueObservingOptionNew
                             context:NULL];
    
    // Probably also perseus webmaster is interested, but we're waiting for a confirm
    //self.report = [[LBRReport alloc]initWithEmail:@"webmaster@perseus.tufts.edu"];
    self.report = [[LBRReport alloc]initWithEmail:@"claudio@librum.it"];
    //[self.report setCcEmail:@"claudio@librum.it"];
    [self.report setTextLabel:self.reportLabel];
    
    [[mySelf infotLabel] setStringValue:@""];
}

#pragma mark -
#pragma mark Filter
// TODO use predicate instead of custom filtering

//-(NSArray*)filterArray:(NSArray*)array forKey:(NSString*)key {
//    NSString* keyPlain = [LBRGreekString toPlain:key];
//    NSPredicate *pred =
//    [NSPredicate predicateWithFormat:@"%@ beginswith %@",
//     [LBRGreekString toPlain:@"SELF.strLemma"],
//     keyPlain];
//    return [array filteredArrayUsingPredicate:pred];
//}


#pragma mark -
#pragma mark Observer
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"selectionIndexes"]) {
        NSIndexSet *idxSet = [object selectionIndexes];
        NSUInteger idxFirst = [idxSet firstIndex];
        id objs = [self.wordContentArray arrangedObjects];
        NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:@""];
        NSString *lemma = [[NSString alloc] init];
        if ([objs count] > 0) {
            NSDictionary* obj = [objs objectAtIndex:idxFirst];
            /* debug */
//            NSUInteger index=[idxSet firstIndex];
//            while(index != NSNotFound)
//            {
//                NSLog(@" %@",[[objs objectAtIndex:index] objectForKey:@"form"]);
//                index=[idxSet indexGreaterThanIndex: index];
//            }
            /* end debug */
            //LBRGreekWord* word = [obj objectForKey:@"word"];
            NSLog(@"Table section changed: keyPath = %@, %@", keyPath, idxSet);
            attrString = [LBRGreekWord analysis:obj];
            [[mySelf infotLabel] setStringValue:@""];
        }
        
        if (attrString!=nil) {
            [[self.wordDescription textStorage] setAttributedString:attrString];
            if (lemma!=nil) {
                [self.report updateWithLemma:lemma];
            }
        } else {
            [[[self.wordDescription textStorage] mutableString]setString:@""];
            [self.report updateWithLemma:nil];
        }
        
    }
    else if ([keyPath isEqualToString:@"string"]) {
        NSString* key = self.mySearchString.string;
        NSLog(@"Search field changed: keyPath = %@, %@", keyPath, key);
        [self updateFilterWithLemma:key];
        
    }
}

#pragma mark -
#pragma mark Search
- (void)updateFilterWithLemma:(NSString*)key {
    PerseusDataController* rController = self.perseusController;
    
    // Select update mode
    NSArray* origList = nil;
    if ([self narrowFilteredList:key]) {
        // new key has only a new character at the end
        origList = [self.wordContentArray content];
    } else {
        // completely new key, search on all lemmas
        origList = [rController getWordList];
    }
    
    NSArray* filteredList = [LBRGreekFilter filterArray:(NSArray*)origList field:@"plainForm" forKey:key];
    if (filteredList == nil) {
        // search text is an empty string
        // display all lemma on the list and an empty glossa
        [self.wordContentArray setContent:[rController getWordList]];
        [[[self.wordDescription textStorage] mutableString]setString:@""];
        [self.report updateWithLemma:nil];
    } else if ([filteredList count] > 0) {
        [self.wordContentArray setContent:filteredList];
    } else {
        // nothing found
        [self.wordContentArray setContent:nil];
    }

}

- (IBAction)updateFilter:sender {
    
    NSString *searchString = [self.searchField stringValue];

    [self updateFilterWithLemma:searchString];
}

#pragma -
#pragma Misc
-(BOOL)narrowFilteredList:(NSString*)key {
    static NSString* lastKey = nil;
    BOOL retVal = NO;
    
    if (lastKey == nil) {
        // do nothing
    }
    else if ([key hasPrefix:lastKey]) {
        retVal = YES;
    }
    
    lastKey = [key copy];
    return retVal;
}

-(void)updateWordArrayWithArray:(NSArray*)arr {
    // Delete all objects
    [self.wordContentArray setContent:nil];
    
    // add new objects
    [mySelf.wordContentArray addObjects:arr];
    [mySelf.wordContentArray setSelectionIndex:0];
    
    //mySelf.searchView.textField = @"";
    // FIXME TODO Reset string
}

#pragma -
#pragma mark Open
- (IBAction)doOpenXml:(id)sender {
    NSOpenPanel *openPanel  = [NSOpenPanel openPanel];
    NSArray* arr = [[NSArray alloc]initWithObjects:@"xml", nil];
    [openPanel setAllowedFileTypes:arr];
    NSInteger result  = [openPanel runModal];
    
    if(result == NSOKButton){
        NSURL* input =  [[openPanel URLs] objectAtIndex:0];
        NSLog(@"input: %@",input);
        PerseusDataController* rController = mySelf.perseusController;
        [rController populateWithXml:input];
        NSArray *arr = [rController getWordList];
        // FIXME TODO: probably there's a better way to localize a field to be shown in the table
        [mySelf addLocalizedField:DATACTRL_KEY_LIST_3 toArray:arr];
        [mySelf updateWordArrayWithArray:arr];
        NSString* infoString = [NSString stringWithFormat:@"Loaded %lu forms",(unsigned long)[arr count]];
        [[mySelf infotLabel] setStringValue:infoString];
    }
}

- (IBAction)doOpenArchive:(id)sender {
    NSOpenPanel *openPanel  = [NSOpenPanel openPanel];
    NSArray* arr = [[NSArray alloc]initWithObjects:@"archive", nil];
    [openPanel setAllowedFileTypes:arr];
    NSInteger result  = [openPanel runModal];
    
    if(result == NSOKButton){
        // FIXME Filename is deprecated, but how to convert URL into a NSString with path?
        NSURL* input =  [[openPanel URLs] objectAtIndex:0];
        NSLog(@"input: %@",input);
        PerseusDataController* rController = mySelf.perseusController;
        [rController populateWithArchive:input];
        NSArray *arr = [rController getWordList];
        [mySelf updateWordArrayWithArray:arr];
        NSString* infoString = [NSString stringWithFormat:@"Loaded %lu forms",(unsigned long)[arr count]];
        [[mySelf infotLabel] setStringValue:infoString];
    }
}
-(IBAction)doSaveArchive:(id)sender {
    NSSavePanel *savePanel  = [NSSavePanel savePanel];
    NSArray* arr = [[NSArray alloc]initWithObjects:@"archive", nil];
    [savePanel setAllowedFileTypes:arr];
    NSInteger result  = [savePanel runModal];
    if(result == NSOKButton){
        // FIXME Filename is deprecated, but how to convert URL into a NSString with path?
        NSURL* input =  [savePanel URL];
        NSLog(@"save as: %@",input);
        PerseusDataController* rController = mySelf.perseusController;
        if ([rController saveArchiveWithFilename:input]) {
            NSString* infoString = [NSString stringWithFormat:@"Saved"];
            [[mySelf infotLabel] setStringValue:infoString];
        } else {
            NSString* infoString = [NSString stringWithFormat:@"Save error!"];
            [[mySelf infotLabel] setStringValue:infoString];
        };
    }
}

@end
