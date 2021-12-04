import numpy as np

#importing the first line like this out of laziness
nums = [7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1]


def checkBingo(array):
    sheet = 0
    for x in array:
        for i in range(5):
            if not np.count_nonzero(x[:,i] != -1) or not np.count_nonzero(x[i] != -1):
                return sheet

        sheet +=1

    return -1

def calculateBingoSum(array):
    return np.sum(array, where=(array!=-1))


def iterateNumbers(bingoArray):
    iterations = 0
    for number in nums:
        bingoArray = np.where(bingoArray == number, -1, bingoArray)
        print(number)
        iterations += 1
        if iterations > 5:
            bingoSheet = checkBingo(bingoArray)
            if bingoSheet != -1:
                print("Bingo! ", number)
                print("On sheet: ", bingoSheet)
                return number, bingoArray[bingoSheet]
    return -1, []



def read_cards(strIn):
    cards = []
    with open(strIn) as data:
        current_card = []
        for line in data:
            # here we start a new bingo
            if line == '\n' or line == "":
                cards.append(current_card)
                current_card = []
            # here we read a line into our current bingo card
            else:
                # x = list(map(int, line.split()))
                current_card.append(list(map(int, line.split())))
        cards.append(current_card)  # at eof
    return cards

#now we draw the first 5 every time from the list
cards = read_cards("testDataPython")
bingoArray = np.array(cards)
number, bingoResult = iterateNumbers(bingoArray)
print(calculateBingoSum(bingoResult)*number)
