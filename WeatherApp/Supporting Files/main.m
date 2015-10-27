//
//  main.m
//  WeatherApp
//
//  Created by Pawel Weglewski on 26/10/15.
//  Copyright © 2015 Pawel Weglewski. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <dlfcn.h>
#import <sys/types.h>

typedef int (*ptrace_ptr_t)(int _request, pid_t _pid, caddr_t _addr, int _data);
#if !defined(PT_DENY_ATTACH)
#define PT_DENY_ATTACH 31
#endif  

void disable_gdb() {
    void* handle = dlopen(0, RTLD_GLOBAL | RTLD_NOW);
    ptrace_ptr_t ptrace_ptr = dlsym(handle, "ptrace");
    ptrace_ptr(PT_DENY_ATTACH, 0, 0, 0);
    dlclose(handle);
    exit(-1);
}

int main(int argc, char * argv[]) {
#if !(DEBUG) // Don't interfere with Xcode debugging sessions.
    disable_gdb();
#endif
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
