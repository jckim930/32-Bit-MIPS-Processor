"""
Read Binary from a file then convert it to hex in a new file
"""
def get_lines(fname):
    try:
        f = open(fname)
    except IOError:
        print("ERROR: Could not open file " + fname)
        exit(1)

    lines = f.readlines()
    f.close()
    return lines

def parse_lines(lines):
    f = open("hex.txt", "w")
    for line in lines:
        line.strip()
        if not line:
            hexL = int('line', 2)
            print(hexL)
            hexL = hex(hexL)
            f.write(hexL)
    f.close()
    


def main():
    
    lines = get_lines("binary.txt");
    parse_lines(lines);
    
    
main()
