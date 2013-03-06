//
//  LBRStringController.m
//  RocciConverter
//
//  Created by Claudio Capobianco on 08/02/13.
//  Copyright (c) 2013 Librum. All rights reserved.
//

#import "LBRStringController.h"

@interface LBRStringController ()
@property id observerObject;
@property NSString* keyPath;
@end


@implementation LBRStringController
@synthesize string = _string;
@synthesize observerObject = _observedObject;
@synthesize keyPath = _keyPath;

-(id)init {
    self = [super init];
    self.string = [[NSMutableString alloc]init];
    return self;
}

-(NSMutableString*)string{
    return _string;
}

-(void)setString:(NSMutableString *)string {
    _string = [string copy];
    NSLog(@"LBRStringController set string: %@",_string);
    [self.observerObject observeValueForKeyPath:self.keyPath ofObject:self change:nil context:nil];
}

-(void)addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context {
    if ([keyPath isEqualToString:@"string"]) {
        self.observerObject = observer;
        self.keyPath = [keyPath copy];
    }
}
@end
