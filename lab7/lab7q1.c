#include <stdio.h>
int foo()
{
  puts("foo here");
}
int main()
{
  puts("hello");
  foo();
  bar();
}
int bar()
{
  puts("bar here");
}
