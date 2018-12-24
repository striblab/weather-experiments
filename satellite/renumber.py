import os

x = 0
for filename in sorted(os.listdir("./final"), key=lambda x: int(x.split('.')[1])):
    os.rename('./final/%s' % filename, './final/color.%s.png' % x)
    x += 1