//
//  NSObject+CCModel.m
//  TaskDemo
//
//  Created by 初程程 on 2017/7/27.
//  Copyright © 2017年 初程程. All rights reserved.
//

#import "NSObject+CCModel.h"
#import <objc/runtime.h>
#define JK_IS_DICT_NIL(objDict) (![objDict isKindOfClass:[NSDictionary class]] || objDict == nil || [objDict count] <= 0)
#define JK_IS_ARRAY_NIL(objArray) (![objArray isKindOfClass:[NSArray class]] || objArray == nil || [objArray count] <= 0)
#define JK_IS_STR_NIL(objStr) (![objStr isKindOfClass:[NSString class]] || objStr == nil || [objStr length] <= 0)
@implementation NSObject (CCModel)
+ (id)modelWithDict:(NSDictionary *)dict{
    id model = [[self alloc] init];
    
    if (!JK_IS_DICT_NIL(dict)) {
        unsigned int count = 0;
        Class cls = [self class];
        Ivar *ivarList = class_copyIvarList(cls, &count);
        
        for (int i = 0; i<count; i++) {
            Ivar ivar = ivarList[i];
            
            NSString *ivarName = [NSString stringWithUTF8String:ivar_getName(ivar)];
            
            NSString *ivarType = [NSString stringWithUTF8String:ivar_getTypeEncoding(ivar)];
            
            NSString *key = [ivarName substringFromIndex:1];
            
            if ([[dict allKeys] containsObject:key]) {
                id value = dict[key];
                /*
                 在OC里指针的类型与声明的类型无关，指向什么类型才是它的类型，举个例子
                 NSString *aString = [@{@"key":@4} objectForKey:@"key"];
                 NSLog(@"%@========",[string substringFromIndex:0]);
                 这两行代码会报错，错误原因是[__NSCFNumber substringFromIndex:]: unrecognized selector sent to instance 也就是说这里的aString实际上是NSNumber类型的
                 在网络请求中，我们接收到的数字类的数据类型往往不一定会是string类型的 但是我们希望用string来
                 处理它，所以这里需要做强制的初始化确保类型的正确
                 */
                if ([ivarType isEqualToString:@"@\"NSString\""]) {
                    NSString *stringValue = [NSString stringWithFormat:@"%@",value];
                    
                    if (!JK_IS_STR_NIL(stringValue)) {
                        [model setValue:value forKey:key];
                    }else{
                        [model setValue:@"" forKey:key];
                    }
                    //对于字典类型的数据在业务中可能用一个model来接收
                }else if ([value isKindOfClass:NSClassFromString(@"NSDictionary")]&&![ivarType isEqualToString:@"@\"NSDictionary\""]){
                    
                    Class objClass = NSClassFromString([ivarType substringWithRange:NSMakeRange(2, ivarType.length-3)]);
                    
                    NSObject *obj = [objClass modelWithDict:value];
                    
                    [model setValue:obj forKey:key];
                }else{
                    if (value) {
                        [model setValue:value forKey:key];
                    }
                }
                
            }
        }
        free(ivarList);
    }
    return model;
}
+ (id)modelWithJson:(id)json{
    NSDictionary *modelDic = [self dictionaryWithJSON:json];
    return [self modelWithDict:modelDic];
}
+ (NSDictionary *)dictionaryWithJSON:(id)json {
    if (!json || json == (id)kCFNull) return nil;
    NSDictionary *dic = nil;
    NSData *jsonData = nil;
    if ([json isKindOfClass:[NSDictionary class]]) {
        dic = json;
    } else if ([json isKindOfClass:[NSString class]]) {
        jsonData = [(NSString *)json dataUsingEncoding : NSUTF8StringEncoding];
    } else if ([json isKindOfClass:[NSData class]]) {
        jsonData = json;
    }
    if (jsonData) {
        dic = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:NULL];
        if (![dic isKindOfClass:[NSDictionary class]]) dic = nil;
    }
    return dic;
}

@end
