from cs50 import get_float
from math import floor

while True:
    cash = get_float("Change owed: ")
    if cash > 0:
        break

cents = cash * 100

quarters = floor(cents/25)
cents = cents - quarters * 25

dimes = floor(cents/10)
cents = cents - dimes * 10

nickels = floor(cents/5)
cents = cents - nickels * 5

print(int(quarters + dimes + nickels + cents))