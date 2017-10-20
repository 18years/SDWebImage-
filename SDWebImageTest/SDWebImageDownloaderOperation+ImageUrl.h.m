//
//  SDWE.m
//  SDWebImageTest
//
//  Created by 谢江涛 on 2017/10/19.
//  Copyright © 2017年 谢江涛. All rights reserved.
//

#import "SDWebImageDownloaderOperation+ImageUrl.h"
#import <objc/runtime.h>

@implementation SDWebImageDownloaderOperation (ImageUrl)

+ (void)load {
    
    Method oriM = class_getInstanceMethod([self class], @selector(initWithRequest:inSession:options:progress:completed:cancelled:));
    Method nM = class_getInstanceMethod([self class], @selector(ex_initWithRequest:inSession:options:progress:completed:cancelled:));
    
    method_exchangeImplementations(oriM, nM);
}

//** 直接修改request方式修改请求 */
- (id)ex_initWithRequest:(NSURLRequest *)request
               inSession:(NSURLSession *)session
                 options:(SDWebImageDownloaderOptions)options
                progress:(SDWebImageDownloaderProgressBlock)progressBlock
               completed:(SDWebImageDownloaderCompletedBlock)completedBlock
               cancelled:(SDWebImageNoParamsBlock)cancelBlock {
    id obj = [self ex_initWithRequest:request inSession:session options:options progress:progressBlock completed:completedBlock cancelled:cancelBlock];
    
    [request.allHTTPHeaderFields setValue:@"111" forKey:@"111"];
    NSLog(@"httpHeader is %@", request.allHTTPHeaderFields);
    
    unsigned int ivarCount;
    Ivar *ivarList = class_copyIvarList([self class], &ivarCount);
    for (int i = 0; i < ivarCount; i++) {
        Ivar ivar = ivarList[i];
        if ([[NSString stringWithUTF8String:ivar_getName(ivar)] isEqualToString:@"_request"]) {
            NSMutableURLRequest *r1 = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://gss3.bdstatic.com/%@",request.URL.path]] cachePolicy:request.cachePolicy timeoutInterval:request.timeoutInterval];
            r1.allHTTPHeaderFields = [request.allHTTPHeaderFields copy];
            NSLog(@"r1 httpHeader is %@", r1.allHTTPHeaderFields);
            object_setIvar(self, ivar, r1);
        }
    }
    
    return obj;
}
//** 可以借助UrlProtocol修改，修改 _session */

@end
