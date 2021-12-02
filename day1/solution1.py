#import data
with open("data") as data:
    amount = 0
    previous = 0
    for line in data:
        if previous < int(line) and previous != 0:
            amount += 1
        previous = int(line)


    print(amount)