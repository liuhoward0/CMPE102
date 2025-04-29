// A program to list file directory structure recursively on Linux
#include <stdio.h>
#include <string.h>
#include <dirent.h>
void listFilesRecursively(char *parent, char *path);
int main()
{
    // Directory path to list files
    char path[100];
    char parent[100];
    // Input path from user
    printf("Enter path to list files: ");
    scanf("%s", path);
    strcpy(parent,path);
    strcat(parent,"/");
    listFilesRecursively(path, path);
    return 0;
}
/**
 * Lists all files and sub-directories recursively 
 * considering path as base path.
 */
void listFilesRecursively(char *parent, char *basePath)
{
    char path[1000];
    char newparent[1000];
    struct dirent *dp;
    DIR *dir = opendir(basePath);
    // Unable to open directory stream
    if (!dir)
        return;
    while ((dp = readdir(dir)) != NULL)
    {
        if (strcmp(dp->d_name, ".") != 0 && strcmp(dp->d_name, "..") != 0)
        {
            printf("%s/%s\n", parent, dp->d_name);
            strcpy(newparent,parent);
            strcat(newparent,"/");
            strcat(newparent,dp->d_name);
            // Construct new path from our base path
            strcpy(path, basePath);
            strcat(path, "/");
            strcat(path, dp->d_name);
            listFilesRecursively(newparent, path);
        }
    }
    closedir(dir);
}
