//
//  LBRButton.m
//  VerbiGreciMacOSX
//
//  Created by Claudio Capobianco on 26/04/12.
//  Copyright (c) 2012 Librum. All rights reserved.
//

#import "LBRGreekString.h"
#import "LBRGreekChar.h"
#import "LBRButton.h"

@interface LBRButton ()

@end

/* singleton */
static NSImage* imgPressed;
static NSImage* imgSelectable;
static NSImage* imgShift;

@implementation LBRButton

#pragma mark
#pragma mark Synthesize
@synthesize idx = _idx;
@synthesize visibleArea = _visibleArea;
@synthesize activeArea = _activeArea;
@synthesize isHidden = _isHidden;
@synthesize isActive = _isActive;
@synthesize state = _state;
@synthesize imgSelectable = _imgSelectable;
@synthesize imgPressed = _imgPressed;
@synthesize imgShift = _imgShift;
@synthesize strData = _strData;
@synthesize strDataAlt = _strDataAlt;
//@synthesize strLabel = _strLabel;

#pragma mark
#pragma mark Misc
static void initImages(void)
{
    NSString* imageName = [[NSBundle mainBundle]
                           pathForResource:@"btnStatePressed" ofType:@"png"];
    imgPressed = [[NSImage alloc] initWithContentsOfFile:imageName];
    imageName = [[NSBundle mainBundle]
                 pathForResource:@"btnStateSelectable" ofType:@"png"];
    imgSelectable = [[NSImage alloc] initWithContentsOfFile:imageName];
    imageName = [[NSBundle mainBundle]
                 pathForResource:@"shiftKey2" ofType:@"png"];
    imgShift = [[NSImage alloc] initWithContentsOfFile:imageName];
}

-(NSRect)shrinkRect:(NSRect)rect withThickness:(float)thickness
{
    NSRect rectOut = rect;
    rectOut.origin.x += thickness;
    rectOut.origin.y += thickness;
    rectOut.size.width -= 2*thickness;
    rectOut.size.height -= 2*thickness;
    return rectOut;
}


#pragma mark
#pragma mark Drawing
static void DrawRoundedRect(NSRect rect, CGFloat xRad, CGFloat yRad)
{
    NSBezierPath* thePath = [NSBezierPath bezierPath];
    
    [thePath appendBezierPathWithRoundedRect:rect xRadius:xRad yRadius:yRad];
    [thePath stroke];
}

static void DrawRoundedRectFill(NSRect rect, CGFloat xRad, CGFloat yRad)
{
    NSBezierPath* thePath = [NSBezierPath bezierPath];
    
    [thePath appendBezierPathWithRoundedRect:rect xRadius:xRad yRadius:yRad];
    [thePath fill];
}

-(void)drawBezierStateSelectable
{
    //[NSBezierPath fillRect:rect];
    //NSColor* color = [NSColor blackColor];
    NSRect rect = self.visibleArea;
    rect = [self shrinkRect:rect withThickness:3];
    
    NSColor* color = [NSColor colorWithCalibratedRed:0.5 green:0.5 blue:0.5 alpha:1];
    [color set];
    DrawRoundedRect(rect,4,4);
    
    [[NSColor whiteColor] set];
    DrawRoundedRectFill(rect,4,4);
    
    return;
}

-(void)drawBezierStateNotSelectable
{    
    NSRect rect = self.visibleArea;
    rect = [self shrinkRect:rect withThickness:3];
    
    NSColor* color = [NSColor colorWithCalibratedRed:0.5 green:0.5 blue:0.5 alpha:1];
    [color set];
    
    NSBezierPath* thePath = [NSBezierPath bezierPath];
    CGFloat xRad = 4;
    CGFloat yRad = 4;
    [thePath appendBezierPathWithRoundedRect:rect xRadius:xRad yRadius:yRad];
    addDashStyleToPath(thePath);
    [thePath stroke];
    
    return;
}

-(void)drawBezierStatePressed
{
    NSRect rect = self.visibleArea;
    rect = [self shrinkRect:rect withThickness:3];
    
    NSColor* color = [NSColor colorWithCalibratedRed:0.5 green:0.5 blue:0.5 alpha:1];
    [color set];
    DrawRoundedRect(rect,4,4);
    
    //color = [NSColor colorWithCalibratedRed:0.5 green:0.5 blue:0.8 alpha:1]; // violet
//    color = [NSColor colorWithCalibratedRed:0.71 green:0.83 blue:0.95 alpha:1];
//    [color set];
//    DrawRoundedRectFill(rect,4,4);
    
    NSColor *color1 = [NSColor colorWithCalibratedRed:0.71 green:0.83 blue:0.95 alpha:1];
    NSColor *color2 = [NSColor colorWithCalibratedRed:0.81 green:0.93 blue:0.95 alpha:1];
    NSGradient* aGradient = [[NSGradient alloc] initWithStartingColor:color1  endingColor:color2];
        
    NSBezierPath*    clipShape = [NSBezierPath bezierPath];
    [clipShape appendBezierPathWithRoundedRect:rect xRadius:4 yRadius:4];
    [aGradient drawInBezierPath:clipShape angle:-90.0];
    return;
}

static void addDashStyleToPath(NSBezierPath* thePath)
{
    // Set the line dash pattern.
    CGFloat lineDash[6];    
    lineDash[0] = 4.0;
    lineDash[1] = 1.0;
    [thePath setLineDash:lineDash count:2 phase:0.0];
}

-(void)drawBezier
{
    /*if ([self.strData isEqualToString:@""])
    {
        [self drawBezierStateNotSelectable];
    }
    else*/ {
        switch (self.state) {
            case LBR_STATE_SELECTABLE:
                [self drawBezierStateSelectable];
                break;
            case LBR_STATE_NOT_SELECTABLE:
                [self drawBezierStateNotSelectable];
                break;
            case LBR_STATE_PRESSED:
                [self drawBezierStatePressed];
                break;
            default:
                break;
        }
    }

    return;
}

-(void)drawImage
{
    switch (self.state) {
        case LBR_STATE_SELECTABLE:
            [self.imgSelectable drawInRect:self.visibleArea fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];
            break;
        case LBR_STATE_PRESSED:
            [self.imgPressed drawInRect:self.visibleArea fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];
            break;
            
        default:
            break;
    }  
}

-(void)drawStr:(NSString*) str
{
    NSRect visibleArea = self.visibleArea;
    
    NSFont* font= [NSFont fontWithName:@"ilRocci" size:27.0];
    NSDictionary *attrsDictionary =
    [NSDictionary dictionaryWithObject:font
                                forKey:NSFontAttributeName];
    NSSize strSize = [str sizeWithAttributes:attrsDictionary];
    
    NSPoint drawPoint = visibleArea.origin;
    drawPoint.x += (visibleArea.size.width - strSize.width) / 2.0;
    drawPoint.y += visibleArea.size.height * (-0.25);
    
    if ([str compare:@"^"] == NSOrderedSame)
    {
        // workaround for up
        drawPoint.y += visibleArea.size.height * (0.4);
        NSRect rect = NSMakeRect(visibleArea.origin.x+4,visibleArea.origin.y+15,26,26);
        [self.imgShift drawInRect:rect fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];
        
    }else if ([LBRGreekString isUppercase:str])  {
        // workaround for capital letters
        drawPoint.y += 2;
        if ([LBRGreekChar isPlain:[str characterAtIndex:0]] == false) {
            drawPoint.y += 2;
        }
        [str drawAtPoint:drawPoint withAttributes:attrsDictionary];
    } else {
        [str drawAtPoint:drawPoint withAttributes:attrsDictionary];

    }
}

-(id)drawBackground
{
    //if (self.imgPressed == nil)
    {
        [self drawBezier];
    }
    /*else
    {
        [self drawImage];
    }*/
    return self;
}

#pragma mark
#pragma mark Public methods
-(id)init
{
    self = [super init];
    
    if (self != nil) {
        self.state = LBR_STATE_SELECTABLE;
        self.isActive = true;
        self.isHidden = false;
        
        if (imgPressed == nil) {
            initImages();
        }
        self.imgPressed = imgPressed;
        self.imgSelectable = imgSelectable;
        self.imgShift = imgShift;
    }
    
    return self;
}

-(id)draw
{
    [self drawBackground];
    [self drawStr:self.strData];
    return self;
}

-(id)drawAlternative
{
    [self drawBackground];
    [self drawStr:self.strDataAlt];
    return self;
}

-(id)toggle
{
    LBRButton* lBtn = self;
    
    if (lBtn.state == LBR_STATE_PRESSED)
    {
        lBtn.state = LBR_STATE_SELECTABLE;
    } else if (lBtn.state == LBR_STATE_SELECTABLE) {
        lBtn.state = LBR_STATE_PRESSED;
    }
    
    return self;
}

-(BOOL)isSelected
{
    LBRButton* lBtn = self;
    
    if (lBtn.state == LBR_STATE_PRESSED)
    {
        return true;
    }
    return false;
}

@end
