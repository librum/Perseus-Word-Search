//
//  ViewController.h
//  Perseus Word Search
//
//  Created by Claudio Capobianco on 26/02/13.
//  Copyright (c) 2013 Librum. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "searchFieldView.h"

@interface ViewController : NSViewController

@property (weak) IBOutlet NSTableView		*wordTableView;
@property (weak) IBOutlet NSArrayController	*wordContentArray;

@property (weak) IBOutlet searchFieldView *searchView;

@property (unsafe_unretained) IBOutlet NSTextView *wordDescription;

@property (weak) IBOutlet NSTextField *reportLabel;

@property (weak) IBOutlet NSTextField *infotLabel;

- (IBAction)doOpenXml:(id)sender;

- (IBAction)doOpenArchive:(id)sender;

- (IBAction)doSaveArchive:(id)sender;

@end
