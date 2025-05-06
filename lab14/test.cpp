#include <stdio.h>
int main()
{
  float f=8.625;
  float g=13.4;
  printf("f=%f\n",f);
  printf("g=%f\n",g);
  f = f + g;
  f = f - g;
  f = f * g;
  f = f / g;
  if (f > g)
    printf("f larger\n");
}
