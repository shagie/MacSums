//
//  SumsUtilTest.m
//  MacSums
//
//  Created by Michael on 3/9/10.
//  Copyright 2010 Michael Turner. All rights reserved.
//

#import "SumsUtilTest.h"
#import "SumsUtil.h"
#import <SenTestingKit/SenTestingKit.h>


@implementation SumsUtilTest

-(void)testFactorial
{
	STAssertTrue(factorial(0) == 1, @"0! != 1");
}

@end
