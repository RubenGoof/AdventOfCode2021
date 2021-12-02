sums = []


def loadData():
    dataList = []
    with open("data") as data:
        for line in data:
            dataList.append(int(line))

    return dataList

def slidingWindowSums(dataList):
    counters = [0, -1, -2]
    #calculate sliding window with size 3
    for item in dataList:
        sums.append(0)
        for i in counters:
            if i >= 0:
                sums[i] += item
        counters = [counter+1 for counter in counters]

    #adjust for the last 2 items
    return sums[:-2]


def calculateIncreases(dataList):
    amount = 0
    previous = 0
    for line in dataList:
        if previous < int(line) and previous != 0:
            amount += 1
        previous = int(line)
    return amount

#test case
# print(calculateIncreases(slidingWindowSums([199,200,208,210,200,207,240,269,260,263])))

#true case
print(calculateIncreases(slidingWindowSums(loadData())))