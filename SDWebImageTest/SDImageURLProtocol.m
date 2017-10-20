//
//  SDImageURLProtocol.m
//  SDWebImageTest
//
//  Created by 谢江涛 on 2017/10/19.
//  Copyright © 2017年 谢江涛. All rights reserved.
//

#import "SDImageURLProtocol.h"

@implementation SDImageURLProtocol
+ (void)load {
    [NSURLProtocol registerClass:[self class]];
}

+ (BOOL)canInitWithRequest:(NSURLRequest *)request {
//    [NSURLProtocol ]
    return YES;
}

@end
