#include <cs50.h>
#include <math.h>
#include <stdio.h>

int main(void)
{
    long n = get_long("Number: ");

    int i = 0;
    long digit = n;
    while (digit > 0)
    {
        digit = digit / 10;
        i++;
    }

    // credit card need to have right digit numbers
    if (i != 13 && i != 15 && i != 16)
    {
        printf("INVALID\n");
        return 0;
    }

    // sumcheck
    long num = n;
    int d1, d2, m1, m2, sum1 = 0, sum2 = 0;
    do
    {
        m1 = num % 10;
        num = num / 10;
        sum1 = sum1 + m1;

        m2 = num % 10;
        num = num / 10;
        m2 = m2 * 2;

        d1 = m2 % 10;
        d2 = m2 / 10;
        sum2 = sum2 + d1 + d2;
    }
    while (num > 0);

    int sumCheck = sum1 + sum2;
    if (sumCheck % 10 != 0)
    {
        printf("INVALID\n");
        return 0;
    }

    long card = n;
    do
    {
        card = card / 10;
    }
    while (card > 99);

    if ((card / 10 == 5) && (0 < card % 10 && card % 10 < 6))
    {
        printf("MASTERCARD\n");
    }
    else if ((card / 10 == 3) && (card % 10 == 4 || card % 10 == 7))
    {
        printf("AMEX\n");
    }
    else if (card / 10 == 4)
    {
        printf("VISA\n");
    }
    else
    {
        printf("INVALID\n");
        return 0;
    }
}