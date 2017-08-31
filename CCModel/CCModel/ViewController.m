//
//  ViewController.m
//  CCModel
//
//  Created by 初程程 on 2017/7/27.
//  Copyright © 2017年 初程程. All rights reserved.
//

#import "ViewController.h"
#import "NSObject+CCModel.h"
#import "Person.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSDictionary *dic = @{
                          @"name":@"ccc",
                          @"age":@"18",
                          @"intro":@{
                                  @"name":@"ccc",
                                  @"age":@"18"
                                     },
                          @"friends":@[@"xiaoming",@"lihua"],
                          @"dog":@{@"color":@"red"}
                          };
    
    Person *person = [Person modelWithDict:dic];
    
    NSLog(@"%@======%@========%@========%@=========%@",person.name,person.age,person.intro,person.friends,person.dog.color);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
