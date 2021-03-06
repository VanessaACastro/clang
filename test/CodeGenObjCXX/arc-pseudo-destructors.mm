// RUN: %clang_cc1 -fobjc-nonfragile-abi -fobjc-arc -fobjc-runtime-has-weak -fblocks -triple x86_64-apple-darwin10.0.0 -emit-llvm -o - %s | FileCheck %s

// CHECK: define void @_Z28test_objc_object_pseudo_dtorPU8__strongP11objc_objectPU6__weakS0_
void test_objc_object_pseudo_dtor(__strong id *ptr, __weak id *wptr) {
  // CHECK: load i8***
  // CHECK-NEXT: load i8** 
  // CHECK-NEXT: call void @objc_release
  ptr->~id();

  // CHECK: call void @objc_destroyWeak(i8** {{%.*}})
  wptr->~id();

  // CHECK: load i8***
  // CHECK-NEXT: load i8** 
  // CHECK-NEXT: call void @objc_release
  (*ptr).~id();

  // CHECK: call void @objc_destroyWeak(i8** {{%.*}})
  (*wptr).~id();
  // CHECK: ret void
}
