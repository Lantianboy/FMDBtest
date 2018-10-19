//
//  ViewController.m
//  AboutFMDB
//
//  Created by andacx on 2018/10/18.
//  Copyright © 2018年 andacx. All rights reserved.
//

#import "ViewController.h"
#import "AddDataViewController.h"
#import <FMDB.h>
#import "ModifyViewController.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView * myTableView ;
@property (strong, nonatomic) FMDatabase * fmdb ;
@property (strong,nonatomic) NSMutableArray *nameArr ;
@property (strong,nonatomic) NSMutableArray *ageArr ;
@property(strong,nonatomic)NSMutableArray *idArr;
@property (copy, nonatomic) NSString * fileName ;


@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated
{
    [self lookData] ;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"数据列表";
    [self.leftBtn setTitle:@"清空" forState:UIControlStateNormal] ;
    [self.rightBtn setTitle:@"添加" forState:UIControlStateNormal] ;
    self.view.backgroundColor = [UIColor whiteColor] ;
    self.myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain] ;
    self.myTableView.delegate = self ;
    self.myTableView.dataSource = self ;
    self.myTableView.tableFooterView = [UIView new] ;
    [self.view addSubview:self.myTableView] ;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _ageArr.count ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50 ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"] ;
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"] ;
    cell.textLabel.text = [NSString stringWithFormat:@"姓名:%@  年龄:%@岁",_nameArr[indexPath.row],_ageArr[indexPath.row]];
    
    return cell ;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO] ;
    
    ModifyViewController *avc = [[ModifyViewController alloc]init];
    
    avc.userId = _idArr[indexPath.row];
    avc.userAge = _ageArr[indexPath.row];
    avc.userName = _nameArr[indexPath.row];
    
    [self.navigationController pushViewController:avc animated:YES];
}

- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    
    UITableViewRowAction *action = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        NSString *str = [NSString stringWithFormat:@"%@",_idArr[indexPath.row]];
        int count = [str intValue];
        
        [self deleteData:count];
    
    }] ;
    
    return @[action] ;
}
// 删除一条数据
- (void)deleteData:(NSInteger)userid{
    
    NSLog(@"%ld",(long)userid);
//    //1.获得数据库文件的路径
//    NSString *doc=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//    NSString *fileName=[doc stringByAppendingPathComponent:@"userData.sqlite"];
    
    //2.获得数据库
    FMDatabase *db = [FMDatabase databaseWithPath:self.fileName];
    if ([db open]) {
        
        NSString *str = [NSString stringWithFormat:@"DELETE FROM t_userData WHERE id = %ld",userid];
        
        BOOL res = [db executeUpdate:str];
        
        if (!res) {
            NSLog(@"数据删除失败");
            [self lookData];
        } else {
            NSLog(@"数据删除成功");
            [self lookData];
        }
        [db close];
    }
}

- (void)lookData
{
    self.nameArr = [[NSMutableArray alloc]initWithCapacity:0];
    self.ageArr = [[NSMutableArray alloc]initWithCapacity:0];
    self.idArr = [[NSMutableArray alloc]initWithCapacity:0];
    
    //1.获取数据库文件的路径
    NSString * doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] ;
    NSString * fileName = [doc stringByAppendingPathComponent:@"userData.sqlite"] ;
    self.fileName = fileName ;
    //获取数据库
    FMDatabase * db = [FMDatabase databaseWithPath:self.fileName] ;
    
    //打开数据库
    if ([db open]) {
        
    }
    self.fmdb = db ;
    
    //执行查询语句
    FMResultSet * resultSet = [self.fmdb executeQuery:@"SELECT * FROM t_userData"] ;
    
    //遍历结果
    while ([resultSet next]) {
        NSString * nameStr = [resultSet stringForColumn:@"userName"] ;
        [self.nameArr addObject:nameStr] ;
        
        NSString * ageStr = [resultSet stringForColumn:@"userAge"] ;
        [self.ageArr addObject:ageStr] ;
        
        NSString *idStr = [resultSet stringForColumn:@"id"];
        [self.idArr addObject:idStr];
        
        NSLog(@"%@,%@,%@",_nameArr,_ageArr,_idArr);
    }
    
    [self.myTableView reloadData] ;
    
}

- (void)leftPopBtn
{
    [self deleteAllData] ;
}

- (void)deleteAllData
{
    //获取数据库
    FMDatabase * db = [FMDatabase databaseWithPath:self.fileName] ;
    if ([db open]) {
        NSString * str = @"DELETE FROM t_userData" ;
        
        BOOL result = [db executeUpdate:str] ;
        
        if (!result) {
            NSLog(@"数据清除失败") ;
        }else{
            NSLog(@"数据清除成功") ;
            [self lookData] ;
        }
        
        [db close] ;
    }
    
}


- (void)rightAddBtn
{
    AddDataViewController * view = [[AddDataViewController alloc] init] ;
    [self.navigationController pushViewController:view animated:YES] ;
}


@end
