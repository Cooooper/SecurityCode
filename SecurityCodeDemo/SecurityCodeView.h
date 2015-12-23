//
//  SecurityCodeView.h
//  SecurityCodeDemo
//
//  Created by Han Yahui on 15/12/22.
//  Copyright © 2015年 Han Yahui. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SecurityCodeView;

@protocol SecurityCodeViewDelegate <NSObject>

//- (void)securityCodeView:(SecurityCodeView *)codeview didInputAtIndex:(NSInteger)index;
- (void)securityCodeViewDidFinished:(SecurityCodeView *)codeView contentCode:(NSInteger )code;


@end

@interface SecurityCodeView : UIView

-(instancetype)initWithFrame:(CGRect)frame codeNumber:(NSInteger)number;

@property (nonatomic,weak) id<SecurityCodeViewDelegate> delegate;

@property (nonatomic,assign) BOOL secureTextEntry;

- (void)inputBecomeFirstResponder;

@end
