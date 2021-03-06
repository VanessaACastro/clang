// RUN: %clang_cc1 -fobjc-nonfragile-abi -fsyntax-only -fobjc-arc -x objective-c %s.result
// RUN: cp %s %t
// RUN: %clang_cc1 -arcmt-modify -fobjc-nonfragile-abi -fsyntax-only -fobjc-arc -x objective-c %t
// RUN: diff %t %s.result
// RUN: rm %t

@protocol NSObject
- (oneway void)release;
@end

void test1(id p) {
  [p release];
}
