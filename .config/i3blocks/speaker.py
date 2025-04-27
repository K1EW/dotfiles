#!/usr/bin/env python3

import subprocess
from statistics import mean

if __name__ == "__main__":
    try:
        output = subprocess.check_output(["amixer", "sget", "Master"]).decode("utf-8")
        output = [x for x in output.split("\n") if "%" in x]

        volume_level = int(mean([
            int(x[x.index("[") + 1:x.index("%")])
            for x in output
        ]))

        if "[on]" in output[0]:
            print(f"🔊 {volume_level}%")
        elif "[off]" in output[0]:
            print(f"🔇 {volume_level}%")
        else:
            raise Exception("Unknown state")
        print("\n#ebdbb2")

    except subprocess.CalledProcessError as e:
        print("Cannot get wifi status: ", e)
    except Exception as e:
        print("Error: ", e)

