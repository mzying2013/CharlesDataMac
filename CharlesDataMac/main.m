//
//  main.m
//  CharlesDataMac
//
//  Created by Liu on 2018/9/11.
//  Copyright © 2018年 mzying.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Request.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        [[Request new] start];
        
        [[NSRunLoop currentRunLoop] run];
        
    }
    return 0;
}
