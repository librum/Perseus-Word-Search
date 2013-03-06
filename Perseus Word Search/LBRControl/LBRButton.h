//
//  LBRButton.h
//  VerbiGreciMacOSX
//
//  Created by Claudio Capobianco on 26/04/12.
//  Copyright (c) 2012 Librum. All rights reserved.
//

#import <Cocoa/Cocoa.h>

enum LBRButtonState {
    LBR_STATE_NONE = 0x00,
    LBR_STATE_SELECTABLE,
    LBR_STATE_NOT_SELECTABLE,
    LBR_STATE_PRESSED,
    LBR_STATE_NUM
};

typedef enum LBRButtonState LBRButtonState;

@interface LBRButton : NSObject

@property NSUInteger idx;

@property NSRect visibleArea;
@property NSRect activeArea;
@property BOOL isHidden;
@property BOOL isActive;
@property LBRButtonState state;

@property NSImage* imgSelectable;
@property NSImage* imgPressed;
@property NSImage* imgShift;

@property NSString* strData;
@property NSString* strDataAlt;
//@property NSString* strLabel;

-(id)init;
-(id)draw;
//-(id)drawAlternative;
-(id)toggle;
-(BOOL)isSelected;

@end
