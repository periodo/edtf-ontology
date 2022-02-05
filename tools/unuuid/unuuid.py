#! /usr/bin/env python3

import re
import sys

bnodes: dict[str, int] = {}
triples: dict[str, int] = {}

BNODE: re.Pattern = re.compile(r"_:n([a-z0-9]+)")
TRIPLE: re.Pattern = re.compile(r"<urn:triple:([a-z0-9]+)>")


def replace_bnode(m: re.Match) -> str:
    return f"_:n{bnodes.setdefault(m.group(1), len(bnodes) + 1)}"


def replace_triple(m: re.Match) -> str:
    return f"<urn:triple:{triples.setdefault(m.group(1), len(triples) + 1)}>"


def main():
    for line in sys.stdin:
        line = BNODE.sub(replace_bnode, line)
        line = TRIPLE.sub(replace_triple, line)
        print(line, end="")


if __name__ == "__main__":
    main()
