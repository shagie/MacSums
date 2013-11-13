//
//  PermComb.m
//  MacSums
//
//  Created by Michael on 3/10/10.
//  Copyright 2010 Michael Turner. All rights reserved.
//

#import "Permutation.h"

NSArray *intArraytoNS(int list[],int m)
{
	NSMutableArray *a = [[NSMutableArray alloc] initWithCapacity:m];
	for(int i = 0; i < m; i++)
	{
		[a addObject:[NSNumber numberWithInt:list[i]]];
	}
	return a;
}


@implementation Permutation

-(void)permuteList:(int *)list withCount:(int)m realCount:(int) c
{
	int temp;
	if(!m)
	{
		[data addObject: intArraytoNS(list, c)];
	}
	else 
	{
		for(int i = 0; i < m; i++)
		{
			temp = list[i];
			list[i] = list[m-1];
			list[m-1] = temp;
			[self permuteList:list withCount:m-1 realCount:c];
			temp = list[m-1];
			list[m-1] = list[i];
			list[i] = temp;
		}
	}
}

-(id)initWithSet:(NSSet *)set
{
	data = [[NSMutableArray alloc] init];
	oIndex = 0;
	int c = [set count];
	int *a = malloc(sizeof(int) * c);
	int i = 0;
	
	NSLog(@"Constructing a[]");
	for(NSNumber *nsi in set)
	{
		a[i] = [nsi intValue];
		NSLog(@"i%d : %d",i,a[i]);
		i++;
	}
	[self permuteList:a withCount:c realCount:c];
	free(a);

#ifdef DEBUGZ
	NSLog(@"Verifying permuate");
	for(int i = 0; i < [data count]; i++)
	{
		NSArray *b = [data objectAtIndex:i];
		NSMutableString *s = [NSMutableString stringWithString:@""];
		for(int j = 0; j < [b count]; j++)
		{
			[s appendString: [NSString stringWithFormat:@"%d",[[b objectAtIndex:j] intValue]]];
		}
		NSLog(@"%d : %@",i,s);
	}
	NSLog(@"End verify");
#endif
	
	return self;
}

		 
-(void)dealloc
{
	for(int i = 0; i < [data count]; i++)
	{
		[[data objectAtIndex:i] release];
	}
	[data dealloc];
	[super dealloc];
}

-(NSArray *)allObjects
{
	return data;
}

-(id)nextObject
{
	if(oIndex < [data count])
	{
		return [data objectAtIndex:oIndex++];
	}
	return nil;
}

-(void)resetEnum
{
	oIndex = 0;
}

@end

