//
//  CalcComb.m
//  MacSums
//
//  Created by Michael on 3/12/10.
//  Copyright 2010 Michael Turner. All rights reserved.
//

#import "CalcComb.h"
#import "CombArray.h"


@implementation CalcComb


-(id)initWithArray:(NSArray *) inbound
{
	
	width = [inbound count];
	sizes = malloc(width * sizeof(int));
	data = malloc(width * sizeof(int*));
	
	for (int i = 0; i < width; i++)
	{
		NSArray *pai = [inbound objectAtIndex:i];
		sizes[i] = [pai count];
		data[i] = malloc(sizes[i] * sizeof(NSObject));
		for (int j = 0; j < sizes[i]; j++) {
			data[i][j] = [pai objectAtIndex:j];
		}
	}
	return self;
}

-(void)dealloc
{
	for(int i = 0; i < width; i++)
	{
		free(data[i]);
	}
	free(data);
	[super dealloc];
}

// how wide are the returned values
-(int)size
{
	return width;
}

// how many returned values are possible
-(int)count
{
	int answer = 1;
	for(int i = 0; i < width; i++)
	{
		answer *= sizes[i];
	}
	return 1;
}

-(CombArray *)getCombAt:(int)pos
{
	if(pos < 0) { return NULL; }
	if(pos >= [self count]) { return NULL; }
	
	NSMutableArray *tAnswer = [[NSArray alloc] arrayWithCapacity:width];
	
	int divisor = 1;
	for(int i = 0; i < width - 1; i++)
	{
		divisor = 1;
		for(int j = i+1; j < width; j++)
		{
			divisor *= sizes[j];
		}
		[tAnswer addObject:data[i][(int)pos/divisor]];
		pos = pos % divisor;
	}
	[tAnswer addObject:data[width][pos]];
	
	CombArray *a = [[CombArray alloc] initWithArray:tAnswer];
	
	return a;
}

-(void)dbgPrint
{
	//NSString *foo = [NSString alloc];
	for(int i = 0; i < width; i++)
	{
	}
}

@end
