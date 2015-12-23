//
//  SecurityCodeView.m
//  SecurityCodeDemo
//
//  Created by Han Yahui on 15/12/22.
//  Copyright © 2015年 Han Yahui. All rights reserved.
//

#import "SecurityCodeView.h"

@interface SecurityCodeView ()<UITextFieldDelegate>

@property (nonatomic,strong) NSMutableArray *fields;
@property (nonatomic,assign) NSInteger codeNumber;

@end

@implementation SecurityCodeView

-(instancetype)initWithFrame:(CGRect)frame codeNumber:(NSInteger)number
{
  self = [super initWithFrame:frame];
  if (self) {
        
    _fields = [NSMutableArray new];
    _codeNumber = number;
    
    CGFloat width = CGRectGetWidth(frame);
    
    CGFloat space = width / number;
    CGFloat x = space * 0.2;
    width = space - 2*x;
    
    for (NSInteger count = 0; count < number; count++) {
      
      UITextField *field = [[UITextField alloc] initWithFrame:CGRectMake(x, 10, width, 40)];
      field.backgroundColor = [UIColor whiteColor];
      field.keyboardType = UIKeyboardTypeNumberPad;
      field.textAlignment = NSTextAlignmentCenter;
      field.font = [UIFont systemFontOfSize:25];
      [field addTarget:self action:@selector(editingChanged:) forControlEvents:UIControlEventEditingChanged];

      field.delegate = self;
      [self addSubview:field];
      [_fields addObject:field];
    
      UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(x, 52, width, 2)];
      line.backgroundColor = [UIColor grayColor];
      [self addSubview:line];
      
      x += space;
    }
    
  }
  return self;
}

-(void)setSecureTextEntry:(BOOL)secureTextEntry
{
  for (UITextField *tf in _fields) {
    tf.secureTextEntry = secureTextEntry;
  }
  _secureTextEntry = secureTextEntry;
  
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
  
  NSInteger index = [_fields indexOfObject:textField];

  if (range.location > 0) {
    textField.text = string;
    index++;
    if (index < _fields.count) {
      UITextField *field = _fields[index];
      
      [self performSelector:@selector(bacomeFirst:) withObject:field afterDelay:0.1];
    
    }
    
    return NO;
  }

  
  if (string.length == 0) {
    index--;
    if (index >= 0) {
      
//      if (textField.text.length > 0) {
        textField.text = @"";
//      }
//      else {
        UITextField *field = _fields[index];
        [self performSelector:@selector(bacomeFirst:) withObject:field afterDelay:0.1];
//      }
    }
    return YES;
  }
  
  if (textField.text.length >1) {
    return NO;
  }
 
  index++;
  if (index < _fields.count) {
    UITextField *field = _fields[index];
    
    [self performSelector:@selector(bacomeFirst:) withObject:field afterDelay:0.1];
    
  }

  return YES;
}

- (void)editingChanged:(UITextField *)textField
{
  UITextField *field = [_fields lastObject];
  
  if ([field isEqual:textField] && textField.text.length == 1) {
    
    if ([self hasIllegalChar]) {
      return;
    }
    
    if ([self getContentCode].length == _codeNumber) {
      if ([self.delegate respondsToSelector:@selector(securityCodeViewDidFinished:contentCode:)]) {
        [self.delegate securityCodeViewDidFinished:self contentCode:[[self getContentCode] integerValue]];
      }
    }

  }
  
}

- (BOOL)hasIllegalChar
{
  for (UITextField *tf in _fields) {
    
    if (tf.text.length != 1) {
      [tf becomeFirstResponder];
      return YES;
    }
  }
  return NO;
}

- (NSString *)getContentCode
{
  NSMutableString *code = [NSMutableString new];
  for (UITextField *tf in _fields) {
    if (tf.text.length == 1) {
       [code appendString:tf.text];
    }
    else {
      return nil;
    }
    
  }
  
  return code;
  
}


- (void)bacomeFirst:(id)obj
{
  UITextField *field = obj;
  
  [field becomeFirstResponder];

}

- (void)inputBecomeFirstResponder
{
  UITextField *field = [_fields firstObject];
  
  [field becomeFirstResponder];
  
}

//禁止复制粘帖
-(BOOL)canPerformAction:(SEL)action withSender:(id)sender{
  UIMenuController *menuController = [UIMenuController sharedMenuController];
  if(menuController){
    menuController.menuVisible = NO;
  }
  return NO;
}



@end
