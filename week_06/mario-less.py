import cs50


while True:
    answer = cs50.get_int("Height: ")
    if answer > 0 and answer < 9:
        break

row = 0
column = 0
for row in range(answer):
    for column in range(answer):
        if row + column < answer - 1:
            print(" ", end="")
        else:
            print("#", end="")
        column += 1

    print()
    row += 1