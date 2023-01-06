//
//  expressionResult.m
//  calc
//
//  Created by Ayodeji Ayodele on 9/04/2017.
//  Copyright © 2017 UTS. All rights reserved.
//

#import "expressionResult.h"

@implementation expressionResult

@synthesize rawExpression = _rawExpression;
@synthesize formattedExpression = _formattedExpression;
@synthesize result = _result;

- (expressionResult*) initWithExpression: (NSArray*) expression andFormattedExp: (NSString*) formattedExp andResult: (float) result{
    self = [super init];
    if(self != nil){
        _rawExpression = expression;
        _formattedExpression = formattedExp;
        _result = result;
    }
    
    return self;
}

@end
