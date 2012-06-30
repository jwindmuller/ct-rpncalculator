//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Joaquin Windmuller on 12-06-28.
//  Copyright (c) 2012 Windmill IT. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"

@interface CalculatorViewController ()
@property BOOL userIsInTheMiddleOfInsertingANumber;
@property (nonatomic, strong) CalculatorBrain *brain;
@property (nonatomic, strong) NSMutableArray *commandsReceived;
@end

@implementation CalculatorViewController

@synthesize display;
@synthesize stackDisplay;
@synthesize userIsInTheMiddleOfInsertingANumber;
@synthesize brain = _brain;
@synthesize commandsReceived = _commandsReceived;

- (CalculatorBrain *) brain
{
    if (!_brain) _brain = [[CalculatorBrain alloc] init];
    return _brain;
}
- (NSMutableArray *) commandsReceived
{
    if (!_commandsReceived) _commandsReceived = [[NSMutableArray alloc] init];
    return _commandsReceived;
}

- (IBAction)clearPressed:(UIButton *)sender
{
    [self.brain amnesia];
    self.commandsReceived = nil;
    self.display.text = @"0";
    self.stackDisplay.text = @"";
}
- (IBAction)digitPressed:(UIButton *)sender {
    NSString *digit = [sender currentTitle];
    if ([digit isEqualToString:@"."]) {
        if ([self.display.text rangeOfString:@"."].location == NSNotFound) {
            digit = self.userIsInTheMiddleOfInsertingANumber ? @"" : @"0.";
        }
    }
    if ([digit isEqualToString:@"π"]) {
        digit = @"3.14159";
        self.display.text = @"";
    }
    if (self.userIsInTheMiddleOfInsertingANumber) {
        self.display.text = [self.display.text stringByAppendingString:digit];
        [self.commandsReceived removeLastObject];
    } else {
        self.display.text = digit;
        self.userIsInTheMiddleOfInsertingANumber = YES;
    }
    
    [self registerCommand:self.display.text];
}
- (IBAction)enterPressed {
    [self.brain pushOperand:[self.display.text doubleValue]];
    self.userIsInTheMiddleOfInsertingANumber = NO;
}
- (IBAction)operationPressed:(UIButton *)sender {
    if (self.userIsInTheMiddleOfInsertingANumber) {
        [self enterPressed];
    }
    NSString *operation = [sender currentTitle];
    double result = [self.brain performOperation:operation];
    self.display.text = [NSString stringWithFormat:@"%g", result];
    
    [self registerCommand:operation];
}
- (void) registerCommand:(NSString *)command
{
    [self.commandsReceived addObject:command];
    [self updateStackDisplay];
}
- (void) updateStackDisplay
{
    NSMutableString *stackDisplayText = [NSMutableString string];
    for (NSString *item in self.commandsReceived) {
        [stackDisplayText appendFormat:@"%@ ", item];
    }
    self.stackDisplay.text = stackDisplayText;
}

- (void)viewDidUnload {
    self.display = nil;
    self.stackDisplay = nil;
    [super viewDidUnload];
}
@end
