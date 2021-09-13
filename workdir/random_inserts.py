from random import randint, choice
from sys import argv

def generate_letter():
    lower = chr(randint(ord('a'), ord('z')))
    upper = chr(randint(ord('A'), ord('Z')))
    return choice([lower, upper])

def generate_word(size):
    word = ''
    for n in range(size):
        word += generate_letter()
    return word

def generate_inserts():
    return "INSERT INTO inventory.customers(id,first_name,last_name,email) VALUES ({},'{}','{}','{}');".format(randint(1,int(9999999)), generate_word(10), generate_word(15), generate_word(20), generate_word(20))

if __name__ == '__main__':
    for i in range(int(argv[1])):
        print(generate_inserts())