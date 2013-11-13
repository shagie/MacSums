//
//  MustCombs.h
//  MacSums
//
//  Created by Michael on 3/14/10.
//  Copyright 2010 Michael Turner. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "My09Set.h"


@interface MustCombs : NSObject {
	NSMutableArray *a;
}

-(id)initWithCellCount:(int)width;
-(void)dealloc;

-(int)count;
-(NSArray *)mustAt:(int)index;


@end
