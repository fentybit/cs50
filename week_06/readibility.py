from cs50 import get_string

text = get_string("Text: ")
text_length = len(text)
letters = 0
sentences = 0
words = 1

for i in range(text_length):
    if text[i].isalpha():
        letters += 1

for i in range(text_length):
    if ord(text[i]) == 46 or ord(text[i]) == 33 or ord(text[i]) == 63:
        sentences += 1

for i in range(text_length):
    if ord(text[i]) == 32:
        words += 1

L = 100 * (letters / words)
S = 100 * (sentences / words)
grade = round(0.0588 * L - 0.296 * S - 15.8)

if 16 <= grade:
    print("Grade 16+")
elif grade < 1:
    print("Before Grade 1")
else:
    print(f"Grade {grade}")