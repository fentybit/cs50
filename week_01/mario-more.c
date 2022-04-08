#include <cs50.h>
#include <stdio.h>

int main(void)
{
    int n;
    do
    {
        n = get_int("Height: ");
    }
    while (n < 1 || 8 < n);

    for (int i = 0; i < n; i++)
    {
        for (int j = 0; j < n + 3 + i; j++)
        {
            if ((i + j < n - 1) || (j == n) || (j == n + 1))
            {
                printf(" ");
            }
            else
            {
                printf("#");
            }
        }
        printf("\n");
    }
}