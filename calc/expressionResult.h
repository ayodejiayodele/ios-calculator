//
//  expressionResult.h
//  calc
//
//  Created by Ayodeji Ayodele on 9/04/2017.
//  Copyright © 2017 UTS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface expressionResult : NSObject

@property (readonly) NSArray *rawExpression;
@property (readonly) NSString *formattedExpression;
@property (readonly) float result;

- (expressionResult*) initWithExpression: (NSArray*) expression andFormattedExp: (NSString*) formattedExp andResult: (float) result;


@end
