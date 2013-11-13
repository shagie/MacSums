//
//  MustCombs.m
//  MacSums
//
//  Created by Michael on 3/14/10.
//  Copyright 2010 Michael Turner. All rights reserved.
//

#import "MustCombs.h"


@implementation MustCombs

-(id)initWithCellCount:(int)width
{
	a = [NSMutableArray arrayWithCapacity:1];
	
	if (width == 2)
	{		
		[a addObject:[NSArray arrayWithObjects:
					  [NSNumber	numberWithInt:0],
					  [NSNumber numberWithInt:1],
					  [NSNumber numberWithInt:-1],
					  nil]];	// rg

		[a addObject:[NSArray arrayWithObjects:
					  [NSNumber	numberWithInt:0],
					  [NSNumber numberWithInt:-1],
					  [NSNumber numberWithInt:1],
					  nil]];	// rb
		
		[a addObject:[NSArray arrayWithObjects:
					  [NSNumber	numberWithInt:-1],
					  [NSNumber numberWithInt:0],
					  [NSNumber numberWithInt:1],
					  nil]];	// gb

		
		[a addObject:[NSArray arrayWithObjects:
					  [NSNumber	numberWithInt:1],
					  [NSNumber numberWithInt:0],
					  [NSNumber numberWithInt:-1],
					  nil]];	// gr
		
		[a addObject:[NSArray arrayWithObjects:
					  [NSNumber	numberWithInt:1],
					  [NSNumber numberWithInt:-1],
					  [NSNumber numberWithInt:0],
					  nil]];	// br
		
		[a addObject:[NSArray arrayWithObjects:
					  [NSNumber	numberWithInt:-1],
					  [NSNumber numberWithInt:1],
					  [NSNumber numberWithInt:0],
					  nil]];	// bg
	}
	
	else
	{
		for(int ri = 0; ri < width; ri++)
		{
			for(int gi = 0; gi < width; gi++)
			{
				for(int bi = 0; bi < width; bi++)
				{
					if(ri != bi && ri != gi && bi != gi)
					{
						[a addObject: [NSArray arrayWithObjects:
									   [NSNumber numberWithInt:ri],
									   [NSNumber numberWithInt:gi],
									   [NSNumber numberWithInt:bi],
									   nil]];
					}
				}
			}
		}
	}
	return self;
}

-(void)dealloc
{
	[super dealloc];
}


-(int)count
{
	return [a count];
}

-(NSArray *)mustAt:(int)index
{
	return [a objectAtIndex:index];
}

@end
