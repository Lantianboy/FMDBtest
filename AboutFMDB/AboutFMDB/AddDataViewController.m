//
//  AddDataViewController.m
//  AboutFMDB
//
//  Created by andacx on 2018/10/18.
//  Copyright © 2018年 andacx. All rights reserved.
//

#import "AddDataViewController.h"
#import <FMDB.h>
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
@interface AddDataViewController ()
@property(nonatomic,strong)FMDatabase *db;

@property(strong,nonatomic)NSString * dbPath;

@property(strong,nonatomic)UITextField *nameTxteField;
@property(strong,nonatomic)UITextField *ageTxteField;
@end

@implementation AddDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"添加数据" ;
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
    self.nameTxteField.placeholder = @"请输入姓名";
    [self.view addSubview:_nameTxteField];
    
    self.ageTxteField = [[UITextField alloc]initWithFrame:CGRectMake(10, 175, SCREEN_WIDTH-20, 50)];
    self.ageTxteField.layer.borderWidth = 1.0;
    self.ageTxteField.layer.cornerRadius = 5.0;
    self.ageTxteField.layer.borderColor = [UIColor colorWithRed:227/255.0 green:227/255.0 blue:229/255.0 alpha:1].CGColor;
    self.ageTxteField.clipsToBounds = YES;
    self.ageTxteField.keyboardType = UIKeyboardTypeNumberPad;
    self.ageTxteField.placeholder = @"请输入年龄";
    [self.view addSubview:_ageTxteField];
    
    UIButton *saveBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 260, SCREEN_WIDTH-20, 50)];
    saveBtn.backgroundColor = [UIColor redColor];
    [saveBtn setTitle:@"保存" forState:0];
    [saveBtn addTarget:self action:@selector(saveBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveBtn];
}

- (void)saveBtn
{
    if (self.nameTxteField.text.length > 0 && self.ageTxteField.text.length > 0) {
        [self saveData] ;
    }
}

- (void)saveData
{
    NSString * doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] ;
    NSString * fileName = [doc stringByAppendingPathComponent:@"userData.sqlite"] ;
    self.dbPath = fileName ;
    
    //获取数据库
    FMDatabase *db = [FMDatabase databaseWithPath:self.dbPath] ;
    //打开数据库
    if ([db open]) {
        //创表
        BOOL result = [db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_userData (id integer PRIMARY KEY AUTOINCREMENT, userName text NOT NULL, userAge text NOT NULL);"] ;
        if (result) {
            NSLog(@"创表成功") ;
        }else{
            NSLog(@"创表失败") ;
        }
    }
    self.db = db ;
    [self insert] ;
    
}

//插入数据
-(void)insert{
    BOOL res = [self.db executeUpdate:@"INSERT INTO t_userData (userName, userAge) VALUES (?, ?);", _nameTxteField.text, _ageTxteField.text];
    
    if (!res) {
        NSLog(@"增加数据失败");
    }else{
        NSLog(@"增加数据成功");
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"新增数据成功" preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alert animated:YES completion:nil];
        [self performSelector:@selector(dismiss:) withObject:alert afterDelay:0.5];
        
    }
}

- (void)dismiss:(UIAlertController *)alert{
    
    [alert dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popToRootViewControllerAnimated:YES];
    
    
}


@end
