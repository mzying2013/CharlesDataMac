//
//  Request.m
//  CharlesData
//
//  Created by Liu on 2018/9/11.
//  Copyright © 2018年 mzying.com. All rights reserved.
//

#import "Request.h"
#import <AFNetworking.h>


static NSString * const kPath = @"app/user";


@implementation Request
AFHTTPSessionManager * _none;
AFHTTPSessionManager * _publicKey;
AFHTTPSessionManager * _certificate;
NSLock * _lock;

#pragma mark - Life Cycle
-(instancetype)init{
    self = [super init];
    
    if (self) {
        _none = [Request manager:AFSSLPinningModeNone];
        _publicKey = [Request manager:AFSSLPinningModePublicKey];
        _certificate = [Request manager:AFSSLPinningModeCertificate];
        
        _lock = [NSLock new];
    }
    
    return self;
}



#pragma mark - Manager
//AFSSLPinningModeNone,
//AFSSLPinningModePublicKey,
//AFSSLPinningModeCertificate,
+(AFHTTPSessionManager *)manager:(AFSSLPinningMode)model{
    NSURL * URL = [NSURL URLWithString:@"https://api.mzying.com/"];
    AFHTTPSessionManager * manager = [[AFHTTPSessionManager alloc] initWithBaseURL:URL];
    manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:model];
    //    manager.securityPolicy.allowInvalidCertificates = YES;
    //    manager.securityPolicy.validatesDomainName = NO;
    
    //Request Response
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSString * value;
    
    if (model == AFSSLPinningModeNone) {
        value = @"none";
    }else if (model == AFSSLPinningModePublicKey){
        value = @"publicKey";
    }else{
        value = @"certificate";
    }
    [manager.requestSerializer setValue:value forHTTPHeaderField:@"User-Agent"];
    return manager;
}


#pragma mark - Request
-(void)start{
    [_none GET:kPath
    parameters:nil
      progress:nil
       success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
           NSLog(@"_none success:%@",responseObject);
       } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
           NSLog(@"_none error:%@",error);
       }];
    
    [_publicKey GET:kPath
         parameters:nil
           progress:nil
            success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSLog(@"_publicKey success:%@",responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"_publicKey error:%@",error);
            }];
    
    [_certificate GET:kPath
           parameters:nil
             progress:nil
              success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                  NSLog(@"_certificate success:%@",responseObject);
              } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                  NSLog(@"_certificate error:%@",error);
              }];
}





@end

