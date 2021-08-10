#!/bin/env python

import matplotlib.pyplot as plt
import csv
import pandas as pd
import sys
import argparse


parser = argparse.ArgumentParser(description="Plot times.csv graphs")
parser.add_argument("--file", "-f", dest="file", help="file", metavar="f", type=str)

args = parser.parse_args()


def get_titles(filename):
    return filename.replace(".csv", "")


def read_csv(filename):
    df = pd.read_csv(filename)
    return df


def get_c_ij_df(df):
    return df.loc[(df["LANG"] == "C") & (df["LOOP_ORDER"] == "ij")]


def get_c_ji_df(df):
    return df.loc[(df["LANG"] == "C") & (df["LOOP_ORDER"] == "ji")]


def get_f_ij_df(df):
    return df.loc[(df["LANG"] == "FORTRAN") & (df["LOOP_ORDER"] == "ij")]


def get_f_ji_df(df):
    return df.loc[(df["LANG"] == "FORTRAN") & (df["LOOP_ORDER"] == "ji")]


def plot_all(df):
    c_ij_df = get_c_ij_df(df)
    c_ji_df = get_c_ji_df(df)
    f_ij_df = get_f_ij_df(df)
    f_ji_df = get_f_ji_df(df)

    plt.figure(0)
    plt.xlabel("Ordem (10^3)")
    plt.ylabel("Runtime (s)")

    plt.plot(c_ij_df["ORDER"], c_ij_df["TIME"], label="C - Loop: ij")
    plt.plot(c_ji_df["ORDER"], c_ji_df["TIME"], label="C - Loop: ji")
    plt.plot(f_ij_df["ORDER"], f_ij_df["TIME"], label="Fortran - Loop: ij")
    plt.plot(f_ji_df["ORDER"], f_ji_df["TIME"], label="Fortran - Loop: ji")
    plt.title("Tempos de cada código")
    plt.legend()
    plt.savefig("/tmp/all-times.png")


def plot_c(df):
    c_ij_df = get_c_ij_df(df)
    c_ji_df = get_c_ji_df(df)

    plt.figure(1)
    plt.xlabel("Ordem (10^3)")
    plt.ylabel("Runtime (s)")

    plt.plot(c_ij_df["ORDER"], c_ij_df["TIME"], label="C - Loop: ij")
    plt.plot(c_ji_df["ORDER"], c_ji_df["TIME"], label="C - Loop: ji")
    plt.title("Códigos em C")
    plt.legend()
    plt.savefig("/tmp/c-times.png")


def plot_f(df):
    f_ij_df = get_f_ij_df(df)
    f_ji_df = get_f_ji_df(df)

    plt.figure(2)
    plt.xlabel("Ordem (10^3)")
    plt.ylabel("Runtime (s)")

    plt.plot(f_ij_df["ORDER"], f_ij_df["TIME"], label="Fortran - Loop: ij")
    plt.plot(f_ji_df["ORDER"], f_ji_df["TIME"], label="Fortran - Loop: ji")
    plt.title("Códigos em Fortran")
    plt.legend()
    plt.savefig("/tmp/f90-times.png")


df = read_csv(args.file)
plot_all(df)
plot_c(df)
plot_f(df)
