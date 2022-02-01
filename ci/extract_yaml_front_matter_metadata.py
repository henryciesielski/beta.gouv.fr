#!/usr/bin/env python3
import sys
import re
import yaml


def load_as_yaml(filename):
    with open(filename) as f:
        front_matter = next(yaml.load_all(f, Loader=yaml.FullLoader))
    return front_matter

def extract_first_yaml_part(filename):
    """ extract first part of yaml file (yaml front matter metadata only) """
    output = ''
    with open(filename) as file:
        inRecordingMode = False
        for line in file:
            if not inRecordingMode:
                if re.search(r'^---$', line):
                    inRecordingMode = True
                    output += line
            elif re.search(r'^---$', line):
                inRecordingMode = False
                break
            else:
                output += line

    return output


def main():
    for file in [sys.argv[1]]:
        print(extract_first_yaml_part(file), end='')


if __name__ == '__main__':
    main()
