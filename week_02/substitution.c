#include <cs50.h>
#include <ctype.h>
#include <stdio.h>
#include <string.h>

int main(int argc, string argv[])
{
    if (argc != 2)
    {
        printf("Usage: ./substitution key\n");
        return 1;
    }

    int length = strlen(argv[1]);
    if (length != 26)
    {
        printf("Key must contain 26 characters.\n");
        return 1;
    }


    for (int i = 0; i < 26; i++)
    {
        if (!isalpha(argv[1][i]))
        {
            printf("Key must contain alphabetical characters only.\n");
            return 1;
        }

        for (int j = i + 1; j < 26; j++)
        {
            if (argv[1][i] == argv[1][j])
            {
                printf("No duplicates on the alphabetical characters.\n");
                return 1;
            }
        }
    }

    string text = get_string("plaintext: ");
    printf("ciphertext: ");
    for (int i = 0, n = strlen(text); i < n; i++)
    {
        if (islower(text[i]))
        {
            printf("%c", tolower(argv[1][text[i] - 97]));
        }
        else if (isupper(text[i]))
        {
            printf("%c", toupper(argv[1][text[i] - 65]));
        }
        else
        {
            printf("%c", text[i]);
        }
    }
    printf("\n");
}