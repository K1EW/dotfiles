#!/usr/bin/env python3

import subprocess

LOW_BATTER = 20

def battery_icon(charge_level):
    if charge_level >= 90:
        return ""
    elif charge_level >= 70:
        return ""
    elif charge_level >= 50:
        return ""
    elif charge_level >= 30:
        return ""
    else:
        return ""

if __name__ == "__main__":
    try:
        output = subprocess.check_output(["acpi", "-b"]).decode("utf-8")
        output = output[output.find(":") + 1:]
        output = output.split(",")
        output = [x.strip() for x in output]

        status = output[0]
        charge_level = int(output[1][:-1])

        if status == "Full":
            print(f"⚡{battery_icon(charge_level)} {charge_level}%")
            print("\n#ebdbb2")
        elif status == "Discharging":
            print(f"{battery_icon(charge_level)} {charge_level}%")
            if charge_level <= LOW_BATTER:
                print("\n#fb4934")
            else:
                print("\n#ebdbb2")
        else:
            raise Exception("Cannot parse battery status")

    except subprocess.CalledProcessError as e:
        print("Cannot get battery status: ", e)
    except Exception as e:
        print("Error: ", e)

