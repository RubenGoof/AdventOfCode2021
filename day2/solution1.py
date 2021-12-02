
with open("data") as data:
    horizontal = 0
    depth = 0
    for line in data:
        if "up" in line:
            depth = depth - int(line.split(" ")[1])
        elif "down" in line:
            depth = depth + int(line.split(" ")[1])
        else:
            horizontal += int(line.split(" ")[1])

    print(horizontal*depth)

