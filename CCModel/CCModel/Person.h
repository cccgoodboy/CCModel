//
//  Person.h
//  CCModel
//
//  Created by 初程程 on 2017/8/31.
//  Copyright © 2017年 初程程. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Dog.h"
@interface Person : NSObject
@property (nonatomic ,copy)NSString *name;
@property (nonatomic ,copy)NSString *age;
@property (nonatomic ,strong)NSDictionary *intro;
@property (nonatomic ,strong)NSArray *friends;
@property (nonatomic ,strong)Dog *dog;

@end
