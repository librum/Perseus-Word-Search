//
//  LBRReport.m
//
//  Created by Claudio Capobianco on 07/01/13.
//  Copyright (c) 2013 Librum. All rights reserved.
//

#import "LBRReport.h"

@interface LBRReport ()
@property NSString* email;
@property (nonatomic)  NSString* ccEmail;
@property NSString* subj;
@property NSString* body;
@property NSTextField* label;
@property NSString* lemma;
@end

@implementation LBRReport

@synthesize subj = _subj;
@synthesize body = _body;
@synthesize email = _email;
@synthesize lemma = _lemma;

-(id)initWithEmail:(NSString *)email
{
    self = [super init];
    self.email = [[NSString alloc]initWithString:email];
    self.lemma = nil;
    [self updateBody];
    [self updateSubject];
    return self;
}

-(NSURL*)getReportUrl {
    NSString* linkStr;
    if (self.ccEmail != nil) {
        linkStr = [NSString stringWithFormat:@"mailto:%@?cc=%@&subject=%@&body=%@",
                         [self.email stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
                         [self.ccEmail stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
                         [self.subj stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
                         [self.body stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    } else {
        linkStr = [NSString stringWithFormat:@"mailto:%@?subject=%@&body=%@",
                             [self.email stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
                             [self.subj stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
                             [self.body stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    return [NSURL URLWithString:linkStr];
}

-(NSTextField*)newLabel:(NSTextField*)label {
    NSURL *linkURL = [self getReportUrl];
    return [self newLabel:label withUrl:linkURL];
}

-(NSTextField*)newLabel:(NSTextField*)label withUrl:(NSURL*)linkURL{
    // both are needed, otherwise hyperlink won't accept mousedown
    [label setAllowsEditingTextAttributes: YES];
    [label setSelectable: YES];
    
    NSString* localTxt = NSLocalizedStringFromTable(@"Report an error",@"InfoPlist",
                                                    @"Report an error using email");
    
    NSFont *font = [NSFont fontWithName:@"ilRocci-unicode" size:12.0];
    NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    NSMutableAttributedString* attrString = [[NSMutableAttributedString alloc] initWithString:localTxt attributes:attrsDictionary];
    
    
    NSRange selectedRange = {0,[attrString length]};
    [attrString beginEditing];
    [attrString addAttribute:NSLinkAttributeName
                       value:linkURL
                       range:selectedRange];
    
    [attrString addAttribute:NSForegroundColorAttributeName
                       value:[NSColor blueColor]
                       range:selectedRange];
    
    [attrString addAttribute:NSUnderlineStyleAttributeName
                       value:[NSNumber numberWithInt:NSSingleUnderlineStyle]
                       range:selectedRange];
    
    [attrString endEditing];
    
    [label setAttributedStringValue:attrString];
    
    return label;
}

-(void)updateLabel {
    NSURL *linkURL = [self getReportUrl];
    NSMutableAttributedString* attrString = [[NSMutableAttributedString alloc] initWithAttributedString:self.label.attributedStringValue];
    NSRange selectedRange = {0,[attrString length]};
    [attrString beginEditing];
    [attrString addAttribute:NSLinkAttributeName
                       value:linkURL
                       range:selectedRange];
    [attrString endEditing];
    [self.label setAttributedStringValue:attrString];
}

-(void)setTextLabel:(NSTextField*)label {
    self.label = [self newLabel:label];
}

-(void)setCcEmail:(NSString *)ccEmail{
   _ccEmail = [ccEmail copy];
    
}


-(void)updateSubject {
    NSDictionary* info = [[NSBundle mainBundle] infoDictionary];
//    NSArray * allKeys = [info allKeys];
//    for (int i =0; i<26;i++ ) {
//        NSLog(@"allkey[%d]: %@: %@",i,allKeys[i],[info objectForKey:allKeys[i]]);
//    }
    NSString* txtSubj = NSLocalizedStringFromTable(@"Error report for application",@"InfoPlist",@"Report subject");
    NSMutableString* text = [[NSMutableString alloc] initWithFormat:
                             @"%@: %@",
                             txtSubj,[info objectForKey:@"CFBundleName"]];
    self.subj = text;
    
}

-(void)updateBody {
    NSDictionary* info = [[NSBundle mainBundle] infoDictionary];
    NSString* header = NSLocalizedStringFromTable(@"Application info",@"InfoPlist",@"Report body");
    NSString* txtExec = NSLocalizedStringFromTable(@"Executable file",@"InfoPlist",@"Report body");
    NSString* txtVer = NSLocalizedStringFromTable(@"Version",@"InfoPlist",@"Report body");

    NSMutableString* text = [[NSMutableString alloc] initWithFormat:
                             @"%@:\n"
                              "  - %@: %@\n"
                              "  - %@: %@\n",
                             header,
                             txtExec,[info objectForKey:@"CFBundleExecutable"],
                             txtVer,[info objectForKey:@"CFBundleShortVersionString"]];
    if (self.lemma != nil) {
        NSString* txtLemma = NSLocalizedStringFromTable(@"Lemma",@"InfoPlist",@"Report body");
        [text appendFormat:
         @"  - %@: %@\n",
         txtLemma,
         self.lemma];
    }
    
    NSString* txtAskDetails = NSLocalizedStringFromTable(@"Please provide more details",@"InfoPlist",@"Report body");
    [text appendFormat:@"\n%@:\n",txtAskDetails];
    
    self.body = text;
}

-(void)updateWithLemma:(NSString*)text {
    self.lemma = text;
    [self updateBody];
    [self updateLabel];
}



@end
