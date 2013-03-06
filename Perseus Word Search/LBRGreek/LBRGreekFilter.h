//
//  LBRGreekFilter.h
//  RocciConverter
//
//  Created by Claudio Capobianco on 11/02/13.
//  Copyright (c) 2013 Librum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LBRGreekFilter.h"

@interface LBRGreekFilter : NSObject

+(NSArray*)filterArray:(NSArray*)array field:(NSString*)field forKey:(NSString*)searchText;

@end
