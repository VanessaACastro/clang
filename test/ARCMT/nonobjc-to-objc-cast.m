// RUN: %clang_cc1 -triple x86_64-apple-darwin10 -fobjc-nonfragile-abi -fsyntax-only -fobjc-arc -x objective-c %s.result
// RUN: arcmt-test --args -triple x86_64-apple-darwin10 -fobjc-nonfragile-abi -fsyntax-only -x objective-c %s > %t
// RUN: diff %t %s.result

#include "Common.h"

@interface NSString : NSObject
@end

typedef const struct __CFString * CFStringRef;
extern const CFStringRef kUTTypePlainText;
extern const CFStringRef kUTTypeRTF;

typedef const struct __CFAllocator * CFAllocatorRef;
typedef const struct __CFUUID * CFUUIDRef;

extern const CFAllocatorRef kCFAllocatorDefault;

extern CFStringRef CFUUIDCreateString(CFAllocatorRef alloc, CFUUIDRef uuid);

void f(BOOL b, id p) {
  NSString *str = (NSString *)kUTTypePlainText;
  str = b ? kUTTypeRTF : kUTTypePlainText;
  str = (NSString *)(b ? kUTTypeRTF : kUTTypePlainText);
  str = (NSString *)p; // no change.

  CFUUIDRef   _uuid;
  NSString *_uuidString = (NSString *)CFUUIDCreateString(kCFAllocatorDefault, _uuid);
  _uuidString = [(NSString *)CFUUIDCreateString(kCFAllocatorDefault, _uuid) autorelease];
}

@implementation NSString (StrExt)
- (NSString *)stringEscapedAsURI {
  CFStringRef str = (CFStringRef)self;
  CFStringRef str2 = self;
  return self;
}
@end
