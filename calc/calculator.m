//
//  calculator.m
//  calc
//
//  Created by Ayodeji Ayodele on 4/04/2017.
//  Copyright © 2017 UTS. All rights reserved.
//

#import "calculator.h"
#import "operator.h"

@implementation calculator

/*********      Arithmetic Calculations *********/
+(float) addWithA: (float)a andB: (float)b{
    return a + b;
}

+(float) subtractWithA: (float)a andB: (float)b{
    return a - b;
}

+(float) multiplyWithA: (float)a andB: (float)b{
    return a * b;
}

+(float) divideWithA: (float)a andB: (float)b{
    return a / b;
}

+(NSInteger) remainderWithA: (NSInteger)a andB: (NSInteger)b{
    return a % b;
}
/*********      End of Arithmetic Calculations *********/

//Validate the supplied input
+(BOOL) validate: (NSArray*) arguments{
    if([arguments count] < 1)
        return false;
    NSInteger length = [arguments count];
    NSInteger i = 0;
    BOOL isValid = false;
    
    NSException *notNumberException = nil;
    NSException *notOperatorException = nil;
    
    //Check if argument is either a number or an operator
    //Even number positions are expected to be numbers
    //Odd number positions are expected to be operators
    do {
        if(i % 2 == 0 && !([self isValidNumber:arguments[i]])){
            notNumberException = [NSException exceptionWithName:@"InvalidArgumentException" reason:[NSString stringWithFormat:@"Invalid number: %@",arguments[i]] userInfo:nil];
        
            @throw notNumberException;
        }
        else if(i % 2 > 0 && !([self isValidOperator:arguments[i]])){
            notOperatorException = [NSException exceptionWithName:@"InvalidArgumentException" reason:[NSString stringWithFormat:@"Unknown operator: %@",arguments[i]] userInfo:nil];
            
            @throw notOperatorException;
        }
        else
            isValid = true;
        
        i++;
    } while(isValid && i < length);
    
    return isValid;
}

+(expressionResult*) evaluate: (NSArray*) arguments{
    if([calculator validate:arguments]){
        if([arguments count] == 1)//This is just a number and not an operation
            return [[expressionResult alloc] initWithExpression:arguments andFormattedExp:arguments[0] andResult:[arguments[0] floatValue]]; //Just return the number
        else{
            operator *firstOperator = [calculator getFirstOperator:arguments];
            operator *nextOperator = [calculator getNextOperator:arguments];
            if(firstOperator != nil && nextOperator == nil){
                float answer = [calculator calculateWithA:[arguments[0] floatValue]
                                                  andOperator:firstOperator
                                                         andB:[arguments[2] floatValue]];
                
                if(answer > INT32_MAX || answer < INT_MIN) //Cater for infinite results
                    @throw [NSException exceptionWithName:@"IntegerOverflowException" reason:@"Integer Overflow" userInfo:nil];
                
                NSString *formattedExp = [NSString stringWithFormat:@"(%@ %@ %@)", arguments[0], arguments[1],arguments[2]];
                
                return [[expressionResult alloc] initWithExpression:arguments andFormattedExp:formattedExp andResult:answer];
            }
            else if (firstOperator != nil && nextOperator != nil){ //More than one operation exists
                if([nextOperator isHigherThan:firstOperator]){
                    //Evaluate the second operator of the expression
                    NSArray *rightHandExpression = [NSArray arrayWithObjects:arguments[2],arguments[3],arguments[4], nil];
                    expressionResult *rightHandAnswer = [calculator evaluate:rightHandExpression];
                    
                    //Combine result with others
                    NSArray *newExpression = [NSArray arrayWithObjects:arguments[0],arguments[1],[NSString stringWithFormat:@"%f",[rightHandAnswer result]], nil];
                    if([arguments count] > 5)
                        for(int j = 5; j < [arguments count]; j++)
                            newExpression = [newExpression arrayByAddingObject:arguments[j]];
                    
                    return [calculator evaluate:newExpression]; //Recursive evaluation of the combination
                }
                else{
                    //Evaluate the first operator of the expression
                    NSArray *leftHandExpression = [NSArray arrayWithObjects:arguments[0],arguments[1],arguments[2], nil];
                    expressionResult *leftHandAnswer = [calculator evaluate:leftHandExpression];
                    
                    //Combine result with others
                    NSString *tempAns = [NSString stringWithFormat:@"%f",[leftHandAnswer result]];
                    NSArray *newExpression = [NSArray arrayWithObjects:tempAns, nil];
                    for(int k = 3; k < [arguments count]; k++)
                        newExpression = [newExpression arrayByAddingObject:arguments[k]];

                    return [calculator evaluate:newExpression]; //Recursive evaluation of the combination
                   
                }
            }
        }
    }
    
    return nil;
}

//Perform the calculation of (number operator number)
+(float) calculateWithA: (float)a andOperator: (operator*)op andB: (float) b{
    if([[op operatorName]  isEqual: @"/"])
        return [calculator divideWithA:a andB:b];
    else if ([[op operatorName] isEqual:@"x"])
        return [calculator multiplyWithA:a andB:b];
    else if([[op operatorName] isEqual:@"%"])
        return [calculator remainderWithA:a andB:b];
    else if ([[op operatorName] isEqual:@"+"])
        return [calculator addWithA:a andB:b];
    else if ([[op operatorName] isEqual:@"-"])
        return [calculator subtractWithA:a andB:b];
    else
        return -1;
}

//Check if a string is a positive or negative number
+(BOOL) isValidNumber: (NSString*) theString{
    NSError *error = nil;
    NSRegularExpression *numbersRegex = [NSRegularExpression
                                         regularExpressionWithPattern:@"^\\-?[0-9]\\d*(\\.\\d*)?$"
                                         options:0
                                         error:&error];

    NSInteger numberOfMatches = [numbersRegex numberOfMatchesInString:theString options:0 range:NSMakeRange(0,[theString length])];

    return numberOfMatches == 1;
}

//Check if a string is one of the acceptable operators
+(BOOL) isValidOperator: (NSString*)string{
    NSArray *operators = [operator getAvailableOperators];
    return [operators containsObject:string];
}

//Get the first operator of an arithmetic expression
+(operator*) getFirstOperator: (NSArray*) expression{
    if([expression count] > 1)
        return [[operator alloc] initWith:expression[1]];
    else
        return nil;
}

//Get the second operator of an arithmetic expression
+(operator*) getNextOperator: (NSArray*) expression{
    if([expression count] > 3)
        return [[operator alloc] initWith:expression[3]];
    else
        return nil;
}

//Check if any of the inputs is a decimal
+(BOOL) foundFloat: (NSArray*) expression{
    for(int i = 0; i < [expression count]; i++){
        if([expression[i] containsString:@"."])
            return true;
    }
    
    return false;
}



@end
