//
//  ViewController.h
//  AboutFMDB
//
//  Created by andacx on 2018/10/18.
//  Copyright © 2018年 andacx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

typedef NS_ENUM(NSInteger, indext){
    index1,
    index2
};

@interface ViewController : BaseViewController

@property (nonatomic, assign) indext indext ;

@property (nonatomic, copy) void (^selectBlock) (NSMutableArray *) ;

- (void)select:(void(^)(NSString *)) block ;

@end

