//
//  operator.m
//  calc
//
//  Created by Ayodeji Ayodele on 8/04/2017.
//  Copyright © 2017 UTS. All rights reserved.
//

#import "operator.h"

@implementation operator

@synthesize operatorName =_operatorName;
@synthesize rank = _rank;

-(operator*) initWith: (NSString*)string{
    self = [super init];
    if(self != nil){
        NSArray *possibleValues = [operator getAvailableOperators];
        if(![possibleValues containsObject:string])
            @throw [NSException exceptionWithName:@"InvalidOperatorException"
                                           reason:[NSString stringWithFormat:@"%@ is not a valid operator",string]
                                         userInfo:nil];
       _operatorName = string;
        NSInteger position = [possibleValues indexOfObject:string];
        _rank = position;
    }
    
    return self;
}

//Get the list of acceptable operators
+(NSArray*) getAvailableOperators{
    NSArray *operators = [NSArray arrayWithObjects:@"/",@"x",@"%",@"+",@"-", nil];
    return operators;
}

-(BOOL) isHigherThan: (operator*)thisOperator{
    return [self rank] <= 2 && [thisOperator rank] > 2;
}

-(BOOL) isLowerThan: (operator*)thisOperator{
    return [self rank] > 2 && [thisOperator rank] <= 2;
}

@end
