//
//  PermComb.h
//  MacSums
//
//  Created by Michael on 3/10/10.
//  Copyright 2010 Michael Turner. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Foundation/NSEnumerator.h>


@interface Permutation : NSEnumerator {
	NSMutableArray *data;
	int oIndex;
}

-(id)initWithSet:(NSSet *)set;
-(void)dealloc;

-(NSArray *)allObjects;
-(id)nextObject;
-(void)resetEnum;

@end
