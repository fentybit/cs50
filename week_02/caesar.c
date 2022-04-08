#include <cs50.h>
#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool only_digits(string s);
char rotate(char c, int n);

int main(int argc, string argv[])
{
    if (argc != 2 || only_digits(argv[1]))
    {
        printf("Usage: ./caesar key\n");
        return 1;
    }

    int key = atoi(argv[1]);
    string text = get_string("plaintext: ");

    printf("ciphertext: ");
    for (int i = 0, n = strlen(text); i < n; i++)
    {
        rotate(text[i], key);
    }
    printf("\n");
    return 0;
}

bool only_digits(string s)
{
    for (int i = 0, n = strlen(s); i < n; i++)
    {
        if (!isdigit(s[i]))
        {
            return 1;
        }
    }
    return 0;
}

char rotate(char c, int n)
{
    if (isalpha(c) && islower(c))
    {
        printf("%c", (((c - 97) + n) % 26) + 97);
    }
    else if (isalpha(c) && isupper(c))
    {
        printf("%c", (((c - 65) + n) % 26) + 65);
    }
    else
    {
        printf("%c", c);
    }
    return 0;
}