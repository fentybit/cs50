from csv import reader, DictReader
from sys import argv, exit


def main():

    # TODO: Check for command-line usage
    if len(argv) < 3:
        print("Usage: python dna.py data.csv sequence.txt")
        exit()

    # TODO: Read DNA sequence file into a variable
    with open(argv[2]) as dna_file:
        dna_reader = reader(dna_file)
        for row in dna_reader:
            dna_list = row

    dna = dna_list[0]
    sequences = {}

    # TODO: Read people database file into a variable
    with open(argv[1]) as people_file:
        people = reader(people_file)
        for row in people:
            dna_sequences = row
            dna_sequences.pop(0)
            break

    # TODO: Find longest match of each STR in DNA sequence
    for key in dna_sequences:
        if not key in sequences:
            sequences[key] = 0
        sequences[key] += longest_match(dna, key)

    # TODO: Check database for matching profiles
    with open(argv[1], newline='') as people_file:
        people = DictReader(people_file)
        for person in people:
            match = 0
            for dna in sequences:
                if sequences[dna] == int(person[dna]):
                    match += 1
            if match == len(sequences):
                print(person['name'])
                exit()
        print('No match')


def longest_match(sequence, subsequence):
    """Returns length of longest run of subsequence in sequence."""

    # Initialize variables
    longest_run = 0
    subsequence_length = len(subsequence)
    sequence_length = len(sequence)

    # Check each character in sequence for most consecutive runs of subsequence
    for i in range(sequence_length):

        # Initialize count of consecutive runs
        count = 0

        # Check for a subsequence match in a "substring" (a subset of characters) within sequence
        # If a match, move substring to next potential match in sequence
        # Continue moving substring and checking for matches until out of consecutive matches
        while True:

            # Adjust substring start and end
            start = i + count * subsequence_length
            end = start + subsequence_length

            # If there is a match in the substring
            if sequence[start:end] == subsequence:
                count += 1

            # If there is no match in the substring
            else:
                break

        # Update most consecutive matches found
        longest_run = max(longest_run, count)

    # After checking for runs at each character in seqeuence, return longest run found
    return longest_run


main()
