//
//  BaseViewController.m
//  AboutFMDB
//
//  Created by andacx on 2018/10/18.
//  Copyright © 2018年 andacx. All rights reserved.
//

#import "BaseViewController.h"


@interface BaseViewController ()



@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.leftBtn = [UIButton buttonWithType:0] ;
    //    [self.leftBtn setTitle:@"删除" forState:UIControlStateNormal] ;
    [self.leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal] ;
    self.leftBtn.titleLabel.font = [UIFont systemFontOfSize:14] ;
    self.leftBtn.frame = CGRectMake(0, 0, 20, 30) ;
    [self.leftBtn addTarget:self action:@selector(leftPopBtn) forControlEvents:UIControlEventTouchUpInside] ;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.leftBtn] ;
    
    
    self.rightBtn = [UIButton buttonWithType:0] ;
    //    [self.rightBtn setTitle:@"添加" forState:UIControlStateNormal] ;
    [self.rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal] ;
    self.rightBtn.titleLabel.font = [UIFont systemFontOfSize:14] ;
    [self.rightBtn addTarget:self action:@selector(rightAddBtn) forControlEvents:UIControlEventTouchUpInside] ;
    self.rightBtn.frame = CGRectMake(0, 0, 20, 30) ;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightBtn] ;
}

- (void)leftPopBtn
{
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES] ;
    }else{
        [self dismissViewControllerAnimated:YES completion:nil] ;
    }
    
}

- (void)rightAddBtn
{
    
    
}




@end
