#include <string.h>
#include <stdio.h>
char password[20] = "california";
char input[32]="";
int matched=0;
int main()
{
    printf("enter password:");
    scanf("%s",input);
    if (strcmp(password,input)==0)
      matched=1;

    if (matched)
        printf("you guessed right!\n");
    else
        printf("you guessed wrong!\n");
}
