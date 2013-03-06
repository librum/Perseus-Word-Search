//
//  LBRReport.h
//  RocciConverter
//
//  Created by Claudio Capobianco on 07/01/13.
//  Copyright (c) 2013 Librum. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LBRReport : NSObject

-(id)initWithEmail:(NSString*)email;
-(void)setTextLabel:(NSTextField*)label;
-(void)setCcEmail:(NSString*)ccEmail;
-(void)updateWithLemma:(NSString*)text;

@end
