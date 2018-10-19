//
//  ModifyViewController.m
//  AboutFMDB
//
//  Created by andacx on 2018/10/18.
//  Copyright © 2018年 andacx. All rights reserved.
//

#import "ModifyViewController.h"
#import "FMDB.h"


#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
@interface ModifyViewController ()
@property(nonatomic,strong)FMDatabase *db;

@property(strong,nonatomic)NSString * dbPath;

@property(strong,nonatomic)UITextField *nameTxteField;
@property(strong,nonatomic)UITextField *ageTxteField;

@end

@implementation ModifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改数据" ;
    [self.leftBtn setBackgroundImage:[UIImage imageNamed:@"home_nav_back"] forState:0] ;
    self.view.backgroundColor = [UIColor whiteColor] ;
    
    [self content] ;
}

- (void)content {
    
    self.nameTxteField = [[UITextField alloc]initWithFrame:CGRectMake(10, 95, SCREEN_WIDTH-20, 50)];
    self.nameTxteField.layer.borderWidth = 1.0;
    self.nameTxteField.layer.cornerRadius = 5.0;
    self.nameTxteField.layer.borderColor = [UIColor colorWithRed:227/255.0 green:227/255.0 blue:229/255.0 alpha:1].CGColor;
    self.nameTxteField.clipsToBounds = YES;
    self.nameTxteField.text = _userName;
    [self.view addSubview:_nameTxteField];
    
    self.ageTxteField = [[UITextField alloc]initWithFrame:CGRectMake(10, 175, SCREEN_WIDTH-20, 50)];
    self.ageTxteField.layer.borderWidth = 1.0;
    self.ageTxteField.layer.cornerRadius = 5.0;
    self.ageTxteField.layer.borderColor = [UIColor colorWithRed:227/255.0 green:227/255.0 blue:229/255.0 alpha:1].CGColor;
    self.ageTxteField.clipsToBounds = YES;
    self.ageTxteField.keyboardType = UIKeyboardTypeNumberPad;
    self.ageTxteField.text = _userAge;
    [self.view addSubview:_ageTxteField];
    
    UIButton *saveBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 260, SCREEN_WIDTH-20, 50)];
    saveBtn.backgroundColor = [UIColor orangeColor];
    [saveBtn setTitle:@"保存" forState:0];
    [saveBtn addTarget:self action:@selector(saveBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveBtn];
}

- (void)saveBtn:(UIButton *)sender {
    
    if (![_nameTxteField.text  isEqual: @""] && ![_ageTxteField.text  isEqual: @""]) {
        [self updateData];
    }
}

// 更新数据
- (void)updateData {
    
    NSLog(@"%@",_nameTxteField.text);
    
    //获得数据库文件的路径
    NSString *doc=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *fileName=[doc stringByAppendingPathComponent:@"userData.sqlite"];
    self.dbPath = fileName;
    
    FMDatabase *db = [FMDatabase databaseWithPath:self.dbPath];
    if ([db open]) {
        NSString *sql = @"UPDATE t_userData SET userName = ? , userAge = ? WHERE id = ?";
        BOOL res = [db executeUpdate:sql,_nameTxteField.text,_ageTxteField.text,_userId];
        if (!res) {
            NSLog(@"数据修改失败");
        } else {
            NSLog(@"数据修改成功");
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"数据修改成功" preferredStyle:UIAlertControllerStyleAlert];
            [self presentViewController:alert animated:YES completion:nil];
            [self performSelector:@selector(dismiss:) withObject:alert afterDelay:1.0];
        }
        [db close];
    }
}

- (void)dismiss:(UIAlertController *)alert{
    
    [alert dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popToRootViewControllerAnimated:YES];
    
    
}


@end
