//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Joaquin Windmuller on 12-06-28.
//  Copyright (c) 2012 Windmill IT. All rights reserved.
//

#import "CalculatorBrain.h"
#import <math.h>

@interface CalculatorBrain()
@property (nonatomic, strong) NSMutableArray *operandStack;
@end

@implementation CalculatorBrain
@synthesize operandStack = _operandStack;

- (NSMutableArray *)operandStack
{
    if (!_operandStack) {
        _operandStack = [[NSMutableArray alloc]init];
    }
    return _operandStack;
}

- (void) pushOperand:(double)operand
{
    [self.operandStack addObject:[NSNumber numberWithDouble:operand]];
}
- (double) popOperand
{
    NSNumber *operandObject = [self.operandStack lastObject];
    [self.operandStack removeLastObject];
    return [operandObject doubleValue];
}
- (double) performOperation:(NSString *)operation
{
    double result = 0;
    if ([operation isEqualToString:@"+"]) {
        result = [self popOperand] + [self popOperand];
        
    } else if ([operation isEqualToString:@"*"]) {
        result = [self popOperand] * [self popOperand];
        
    } else if ([operation isEqualToString:@"-"]) {
        double substrahend = [self popOperand];
        result = [self popOperand] - substrahend;
        
    } else if ([operation isEqualToString:@"/"]) {
        double divisor = [self popOperand];
        if (divisor) result = [self popOperand] / divisor;
        
    } else if ([operation isEqualToString:@"sqrt"]) {
        double subject = [self popOperand];
        if (subject > 0) result = sqrt(subject);
        
    } else if ([operation isEqualToString:@"sin"]) {
        double divisor = [self popOperand];
        if (divisor) result = sin([CalculatorBrain degreeToRad:divisor]);
        
    } else if ([operation isEqualToString:@"cos"]) {
        double divisor = [self popOperand];
        if (divisor) result = cos([CalculatorBrain degreeToRad:divisor]);;
        
    }
    [self pushOperand:result];
    return result;
}

+ (double) degreeToRad:(double)radians
{
    return  M_PI/180 * radians;
}
@end
