#include "RikGlobalMenuTheme.h"

static Class _menuRegistryClass;

@implementation RikGlobalMenuTheme
- (Class)_findDBusMenuRegistryClass
{
  NSString	*path;
  NSBundle	*bundle;
  NSArray	*paths;
  NSUInteger	count;

  if (Nil != _menuRegistryClass)
    {
      return _menuRegistryClass;
    }
  paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,
    NSAllDomainsMask, YES);
  count = [paths count];
  while (count-- > 0)
    {
       path = [paths objectAtIndex: count];
       path = [path stringByAppendingPathComponent: @"Bundles"];
       path = [path stringByAppendingPathComponent: @"DBusMenu"];
       path = [path stringByAppendingPathExtension: @"bundle"];
       bundle = [NSBundle bundleWithPath: path];
       if (bundle != nil)
         {
           if ((_menuRegistryClass = [bundle principalClass]) != Nil)
             {
               break;  
             }
         }
     }
  return _menuRegistryClass;
}

- (id) initWithBundle: (NSBundle *)bundle
{
  if((self = [super initWithBundle: bundle]) != nil)
    {
    }
  menuRegistry = [[self _findDBusMenuRegistryClass] new];
  return self;
}

- (void)setMenu: (NSMenu*)m forWindow: (NSWindow*)w
{
  [menuRegistry setMenu: m forWindow: w];
  //[super setMenu: m forWindow: w];
}

@end
