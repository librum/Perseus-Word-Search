//
//  searchFieldView.m
//  VerbiGreciMacOSX
//
//  Created by Claudio Capobianco on 13/05/12.
//  Copyright (c) 2012 Librum. All rights reserved.
//

#import "searchFieldView.h"
#import "LBRButton.h"
#import "LBRGreekChar.h"
#import "LBRGreekString.h"
#import "ilRocciFontset.h"

@interface searchFieldView ()

@property LBRButton* glassButton;
@property LBRButton* cancelButton;
@property BOOL isFirstResponder;
@property (nonatomic)  NSNumber* textSize;

@property id observedObject;
@property NSString* observedKeyPath;

@property NSString* searchText;

@end

@implementation searchFieldView

@synthesize textField = _textField;
@synthesize cancelButton = _cancelButton;
@synthesize glassButton = _glassButton;
@synthesize isFirstResponder = _isFirstResponder;
@synthesize textSize = _textSize;
@synthesize observedObject = _observedObject;
@synthesize observedKeyPath = _observedKeyPath;
@synthesize searchText = _searchText;

#pragma mark
#pragma mark Initialization

-(void)initButtonsWithFactor:(CGFloat)kFactor inFrame:(NSRect)frame {
    
    _glassButton = [[LBRButton alloc] init];
    NSRect glassRect = frame;
    glassRect.origin.x += 6*kFactor;
    glassRect.origin.y += 8*kFactor;
    glassRect.size.width = 9*kFactor;
    glassRect.size.height = 9*kFactor;
    _glassButton.visibleArea = glassRect;
    _glassButton.activeArea = _glassButton.visibleArea;
    
    _cancelButton = [[LBRButton alloc] init];
    NSRect cancelRect = frame;
    cancelRect.origin.x += cancelRect.size.width-18*kFactor;
    cancelRect.origin.y += 4*kFactor;
    cancelRect.size.width = 14*kFactor;
    cancelRect.size.height = 14*kFactor;
    _cancelButton.visibleArea = cancelRect;
    _cancelButton.activeArea = _cancelButton.visibleArea;
}

+(void) initialize {
    [LBRGreekString initialize];
    [LBRGreekChar initialize];
    [self exposeBinding:@"searchText"];
}

-(id)init {
    self = [super init];
    self.textField = @"";
    return self;
}

-(void)awakeFromNib {
    [super awakeFromNib];
    [LBRGreekString initialize];
    [LBRGreekChar initialize];
    self.textField = @"";
    self.textSize = [NSNumber numberWithInt:0];
}

#pragma mark
#pragma mark Set and get
-(void)setIsFirstResponder:(BOOL)val {
    _isFirstResponder = val;
    [self setNeedsDisplayInRect:[self bounds]];
}

-(BOOL)isFirstResponder {
    return _isFirstResponder;
}

-(void)setTextField:(NSString*)str {
    str = [self convertString:str];
    _textField = [NSString stringWithString:str];
    
  //  [[ControlViewController getInstance] updateFilter:str];
    [self.observedObject setValue:str forKeyPath:self.observedKeyPath];
    [self setNeedsDisplayInRect:[self bounds]];
}

-(NSString*)textField {
    return [NSString stringWithString:_textField];    
}

-(void)setTextSize:(NSNumber *)textSize {
    _textSize = textSize;
}

#pragma mark
#pragma mark Bindings
-(void) bind:(NSString *)binding toObject:(id)observable withKeyPath:(NSString *)keyPath options:(NSDictionary *)options {
    if ([binding isEqualToString:@"searchText"]) {
        self.observedObject = observable;
        self.observedKeyPath = [keyPath copy];
    }
}

#pragma mark
#pragma mark String Utils
-(NSString*)convertLastCharInSearch:(NSString*)searchStr {
    NSUInteger len = [searchStr length];
    if (len > 0) {
        NSString* lastLetterStr = [searchStr substringFromIndex:(len-1)];
        BOOL lastLetterIsAscii = [LBRGreekString isAsciiLetters:lastLetterStr];
        
        if (lastLetterIsAscii) {
            // replace the last ascii character with the corresponding greek char
            NSString* lastLetterGreekStr = [LBRGreekString asciiLetters2plainGreek:lastLetterStr];
            searchStr = [searchStr substringToIndex:(len-1)];
            if ([lastLetterStr isEqualToString:lastLetterGreekStr] == false)
            {
                // add letter to the search string        
                searchStr = [searchStr stringByAppendingString:lastLetterGreekStr];
            }
            else {
                NSBeep();
            } 
            
        }
    }
    return searchStr;
}

-(NSString*)concatAsciiChar:(unichar)c toString:(NSString*)searchStr {
    
    NSString* lastLetterGreekStr = [LBRGreekString asciiLetters2plainGreek:[LBRGreekString stringByChar:c]];
    if ([lastLetterGreekStr isEqualToString:[LBRGreekString stringByChar:c]]) {
        NSBeep();
    } else {
        searchStr = [searchStr stringByAppendingString:lastLetterGreekStr];
    } 
    
    return searchStr;
}

-(NSString*)convertFinalSigma:(NSString*)searchStr {
    searchStr = [LBRGreekString convertFinalSigma:searchStr];
    return searchStr;
}

-(NSString*)convertString:(NSString*)str {
    str = [self convertFinalSigma:str];
    //TODO: manage modifier characters (eg. a\ has to be à)
    return str;
}

#pragma mark
#pragma mark Drawing

-(void)drawGlassWithFactor:(CGFloat)kFactor {
    NSColor* grayColor = [NSColor colorWithCalibratedRed:0.45 green:0.45 blue:0.45 alpha:1];
    NSRect glassRect = self.glassButton.visibleArea;
    
    NSBezierPath* glassPath1 = [NSBezierPath bezierPath];
    [grayColor set];
    [glassPath1 setLineWidth:1.5*kFactor];
    [glassPath1 appendBezierPathWithOvalInRect:glassRect];
    [glassPath1 stroke];
    
    NSBezierPath* glassPath2 = [NSBezierPath bezierPath];
    CGFloat p1x = glassRect.origin.x + glassRect.size.width / 2.0 * (1+sin(M_PI_4));
    CGFloat p1y = glassRect.origin.y + glassRect.size.height / 2.0 * (1-cos(M_PI_4));
    CGFloat p2x = p1x + 4 * kFactor;
    CGFloat p2y = p1y - 4 * kFactor;
    [glassPath2 moveToPoint:NSMakePoint(p1x, p1y)];
    [glassPath2 lineToPoint:NSMakePoint(p2x, p2y)];
    [glassPath2 setLineWidth:1.5*kFactor];
    [glassPath2 stroke];
    
}

-(void)drawCancelButtonWithFactor:(CGFloat)kFactor {
    
    NSColor* lightGrayColor = [NSColor colorWithCalibratedRed:0.7 green:0.7 blue:0.7 alpha:1];
    NSColor* whiteColor = [NSColor whiteColor];
    NSRect cancelRect = self.cancelButton.visibleArea;
    
    NSBezierPath* cancelPath1 = [NSBezierPath bezierPath];
    [lightGrayColor set];
    [cancelPath1 appendBezierPathWithOvalInRect:cancelRect];
    [cancelPath1 fill];
    
    NSBezierPath* cancelPath2 = [NSBezierPath bezierPath];
    CGFloat p1x = cancelRect.origin.x + 4*kFactor;
    CGFloat p1y = cancelRect.origin.y + 4*kFactor;
    CGFloat p2x = p1x + 6*kFactor;
    CGFloat p2y = p1y + 6*kFactor;
    [whiteColor set];
    [cancelPath2 moveToPoint:NSMakePoint(p1x, p1y)];
    [cancelPath2 lineToPoint:NSMakePoint(p2x, p2y)];
    [cancelPath2 setLineWidth:1.5*kFactor];
    [cancelPath2 stroke];
    
    NSBezierPath* cancelPath3 = [NSBezierPath bezierPath];
    p1x = cancelRect.origin.x + 4*kFactor;
    p1y = cancelRect.origin.y + cancelRect.size.height - 4*kFactor;
    p2x = p1x + 6*kFactor;
    p2y = p1y - 6*kFactor;
    [whiteColor set];
    [cancelPath3 moveToPoint:NSMakePoint(p1x, p1y)];
    [cancelPath3 lineToPoint:NSMakePoint(p2x, p2y)];
    [cancelPath3 setLineWidth:1.5*kFactor];
    [cancelPath3 stroke];
}



-(void)drawBackgroundWithFactor:(CGFloat)kFactor inFrame:(NSRect)rect {
    
       
    NSColor* grayColor = [NSColor colorWithCalibratedRed:0.45 green:0.45 blue:0.45 alpha:1];
    NSBezierPath* bgPath = [NSBezierPath bezierPath];
  
    NSColor* whiteColor = [NSColor whiteColor];
    
    CGFloat yRad = rect.size.height / 2.0;
    CGFloat xRad = yRad * 0.9;
    
            [bgPath setLineWidth:1.0];
    
    [bgPath appendBezierPathWithRoundedRect:rect xRadius:xRad yRadius:yRad];
    [whiteColor set];
    [bgPath fill];
    
    if (self.isFirstResponder) {
        [NSGraphicsContext saveGraphicsState];
        /* To draw the focus rect, fill a bezier path containing the union of the rounded region and one (or both, for the center) halves of the label rect */
        NSSetFocusRingStyle(NSFocusRingOnly);
        [[NSColor clearColor] set];
        [bgPath fill];
        [NSGraphicsContext restoreGraphicsState];
    } else {
        [grayColor set];
        [bgPath stroke];
    }

    
    
    return;
}

-(void)drawTextFieldWithFactor:(CGFloat)kFactor inFrame:(NSRect)rect {
    
    NSMutableAttributedString *attrStr;
    NSRect visibleArea = rect;
    if ([self.textSize floatValue] == 0) {
        self.textSize = [NSNumber numberWithFloat:round(rect.size.height/1.43)];
    }
    NSFont* font= [NSFont fontWithName:@"ilRocci-unicode" size:[self.textSize floatValue]];
    
    NSDictionary *attrsDictionary;
    
    NSPoint drawPoint = visibleArea.origin;
    drawPoint.x += 22 * kFactor;
    drawPoint.y += visibleArea.size.height * 0.05 * kFactor;
    
     NSUInteger len = [self.textField length];
    
    if (len > 0) {
        attrsDictionary =
        [NSDictionary dictionaryWithObject:font
                                    forKey:NSFontAttributeName];
        attrStr = [[NSMutableAttributedString alloc] initWithString:self.textField attributes:attrsDictionary];
        
        // Change last letter color if needed
        BOOL changeLastLetterColor = NO; // disable for now
        if (changeLastLetterColor) {
            NSString *str = [NSString stringWithString:attrStr.string];
            NSString* lastLetterStr = [str substringFromIndex:(len-1)];
            unichar lastLetterChar = [lastLetterStr characterAtIndex:0];
            if ([LBRGreekChar hasVariants:lastLetterChar]) {
                NSRange range = NSMakeRange(len-1, 1);
                [attrStr beginEditing];
                [attrStr addAttribute:NSForegroundColorAttributeName
                                value:[NSColor grayColor]
                                range:range];
                [attrStr endEditing];
            }
        }
       
        
    } else {
        attrsDictionary =
        [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName,[NSColor grayColor],NSForegroundColorAttributeName, nil];
        NSString* findLemmaTxt = NSLocalizedStringFromTable(@"Find placeholder",@"InfoPlist",
                                                   @"Placeholder for find field");
        attrStr = [[NSMutableAttributedString alloc] initWithString:findLemmaTxt attributes:attrsDictionary];
    }
    //[str drawAtPoint:drawPoint withAttributes:attrsDictionary];
    [attrStr drawAtPoint:drawPoint];
}

-(NSRect)frame2search:(NSRect)rect {
    NSRect searchRect = rect;
    searchRect.origin.x += 3;
    searchRect.origin.y += 3;
    searchRect.size.width -= 3*2;
    searchRect.size.height -= 3*2;
    return searchRect;
}

#pragma mark
#pragma mark kDelegates
-(void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    NSRect searchRect = [self frame2search:dirtyRect];
    CGFloat kFactor = searchRect.size.height / 22;
    
    static BOOL init = true;
    if (init) {
        init = false;
        [self initButtonsWithFactor:kFactor inFrame:searchRect];
    }
    
    [self drawBackgroundWithFactor:kFactor inFrame:searchRect];
    [self drawGlassWithFactor:kFactor];
    if ([self.textField length] > 0) {
        [self drawCancelButtonWithFactor:kFactor];        
    }
    [self drawTextFieldWithFactor:kFactor inFrame:searchRect];
}

-(void)mouseDown:(NSEvent *)event {
    NSPoint clickLocation = [self convertPoint:[event locationInWindow]
                                  fromView:nil];
    if ([self.textField length] > 0) {
        NSRect testArea = self.cancelButton.activeArea;
        if (NSPointInRect(clickLocation,testArea)) {
            self.textField = @"";
        }
    }
}

- (void)flagsChanged:(NSEvent *)event {
    BOOL shiftKeyPressed = !! ([event modifierFlags] & NSShiftKeyMask);
    if (shiftKeyPressed) {
  //  [[ControlViewController getInstance] updateFilterToggleCase];
    }
}

-(void)keyDown:(NSEvent *)event {
    NSString *characters = [event characters];
    if ([characters length]) {
        NSString* searchStr = self.textField;
        NSUInteger len = [searchStr length];
        
        
        switch ([characters characterAtIndex:0]) {
            case NSEnterCharacter:
            case NSNewlineCharacter:
            case NSCarriageReturnCharacter:
                break;
            case NSDeleteCharacter:
                if (len > 0) {
                    searchStr = [searchStr substringToIndex:(len-1)];
                }
                break;
            case NSTabCharacter:
                [[self nextKeyView] becomeFirstResponder];
                break;
            default:
                searchStr = [self concatAsciiChar:[characters characterAtIndex:0] toString:searchStr];
                break;
        }
        self.textField = searchStr;
    }
    
}

-(BOOL)becomeFirstResponder {
    self.isFirstResponder = true;
    return YES;
}

-(BOOL)resignFirstResponder {
    BOOL okToChange = [super resignFirstResponder];
    if (okToChange) {
        self.isFirstResponder = false;
    }
    return okToChange;
    //return NO; // never lose responder!  
}

-(BOOL)acceptsFirstResponder {
    return YES;
}

@end
