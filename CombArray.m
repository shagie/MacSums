//
//  CombArray.m
//  MacSums
//
//  Created by Michael on 3/13/10.
//  Copyright 2010 Michael Turner. All rights reserved.
//

#import "CombArray.h"


@implementation CombArray

-(id)initWithArray:(int*)a size:(int)s
{
	asize = s;
	data = malloc(s * sizeof(int));
	for(int i = 0; i < s; i++)
	{
		data[i] = a[i];
	}
	return self;
}

-(void)dealloc
{
	free(data);
	[super dealloc];
}

-(bool)hasDup
{
	bool answer = false;
	int *a = malloc(sizeof(int) * 9);
	for(int i = 0; i < 9; i++)
	{
		a[i] = 0;
	}
	for(int i = 0; i < asize; i++)
	{
		if(a[data[i]]++) { answer = true;}
	}
	free(a);
	return answer;
}

-(int*)getData
{
	return data;
}

@end
