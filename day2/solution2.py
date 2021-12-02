with open("data") as data:
    horizontal = 0
    depth = 0
    aim = 0
    for line in data:
        x = int(line.split(" ")[1])
        if "up" in line:
            aim = aim - x
        elif "down" in line:
            aim = aim + x
        else:
            horizontal += x
            depth += aim * x

    print(horizontal*depth)