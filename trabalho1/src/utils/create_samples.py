#!/bin/env python
import random
import argparse


parser = argparse.ArgumentParser(description="Create random matrices and vectors")
parser.add_argument(
    "--path", "-p", dest="path", help="destination", metavar="d", type=str
)
parser.add_argument(
    "--initial", "-i", dest="initial", help="minimum order", metavar="i", type=int
)
parser.add_argument(
    "--end", "-e", dest="end", help="maximum order", metavar="e", type=int
)
parser.add_argument("--step", "-s", dest="step", help="steps", metavar="s", type=int)

args = parser.parse_args()


def createSamples(path):
    print(
        f"[SAMPLES] [CREATING SAMPLES] [ORDER: START={args.initial}, END={args.end}, STEP={args.step}]"
    )
    for order in range(args.initial, args.end + 1, args.step):
        writeMatrix(order, path)
        writeVector(order, path)


def createRandomFloat():

    return random.uniform(-10.0, 10.0)


def createRandomVector(order):
    vector = []

    for i in range(0, order + 1):
        vector.append(createRandomFloat())

    return vector


def floatToString(f):
    return str(f)


def writeMatrix(order, dest):
    fileName = f"{str(order)}.matrix"
    print(f"\t[ORDER={order}][MATRIX] File = {fileName}")
    f = open(dest + fileName, "w")
    for i in range(order):
        f.write(",".join(map(floatToString, createRandomVector(order))))
        f.write("\n")

    f.close()


def writeVector(order, dest):
    fileName = f"{str(order)}.vector"
    print(f"\t[ORDER={order}][VECTOR] File = {fileName}")
    f = open(dest + fileName, "w")
    vector = createRandomVector(order)
    for i in vector:
        f.write(str(i))
        f.write("\n")


createSamples(args.path)
