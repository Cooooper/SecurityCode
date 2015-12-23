//
//  ViewController.m
//  SecurityCodeDemo
//
//  Created by Han Yahui on 15/12/22.
//  Copyright © 2015年 Han Yahui. All rights reserved.
//

#import "ViewController.h"

#import "SecurityCodeView.h"


@interface ViewController ()<SecurityCodeViewDelegate>

@property (nonatomic,strong)SecurityCodeView *codeView;
@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  CGFloat width = CGRectGetWidth(self.view.frame);
  
  self.codeView = [[SecurityCodeView alloc] initWithFrame:CGRectMake(0, 200, width, 60) codeNumber:4];
  self.codeView.backgroundColor = [UIColor colorWithRed:0 / 255.0  green:189 / 255.0 blue:140 / 255.0  alpha:1];
  self.codeView.secureTextEntry = NO;
  self.codeView.delegate = self;

  [self.view addSubview:self.codeView];
  
  
  
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
  [self.codeView inputBecomeFirstResponder];

}

-(void)securityCodeViewDidFinished:(SecurityCodeView *)codeView contentCode:(NSInteger)code
{
  NSLog(@"conde %d",code);
  
}


- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
