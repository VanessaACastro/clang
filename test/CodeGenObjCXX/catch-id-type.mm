// RUN: %clang_cc1 -triple i386-apple-macosx10.6.6 -emit-llvm -fobjc-exceptions -fcxx-exceptions -fexceptions -o - %s | FileCheck %s
// rdar://8940528

@interface ns_array
+ (id) array;
@end

@implementation ns_array
+ (id) array { return 0; }
@end

id Groups();

@protocol P @end;

@interface INTF<P> {
    double dd;
}
@end

id FUNC() {
    id groups;
    try
    {
      groups = Groups();  // throws on errors.
    }
    catch( INTF<P>* error )
    {
      Groups();
    }
    catch( id error )
    { 
      // CHECK: call i32 (i8*, i8*, ...)* @llvm.eh.selector({{.*}} @__gxx_personality_v0 {{.*}} @_ZTIP4INTF {{.*}} @_ZTIP11objc_object {{.*}} @_ZTIP10objc_class
      error = error; 
      groups = [ns_array array]; 
    }
    catch (Class cl) {
      cl = cl;
      groups = [ns_array array];
    }
    return groups;

}

int main() {
  FUNC();
  return 0;
}
