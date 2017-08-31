//
//  NSObject+CCModel.h
//  TaskDemo
//
//  Created by 初程程 on 2017/7/27.
//  Copyright © 2017年 初程程. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (CCModel)
+ (id)modelWithDict:(NSDictionary *)dict;
+ (id)modelWithJson:(NSString *)json;
@end
