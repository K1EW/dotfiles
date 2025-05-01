#!/usr/bin/env python3

import subprocess

def if_icon(interface):
    if interface == "wifi":
        return ""
    elif interface == "ethernet":
        return "󰌘"

if __name__ == "__main__":
    try:
        output = subprocess.check_output(["nmcli", "device", "status"]).decode("utf-8")
        output = [x.strip() for x in output.split("\n") if "wifi" in x.split() or "ethernet" in x.split()]
        output = [x.split()[1:] for x in output]

        is_connected = False
        for connection in output:
            interface = connection[0]
            state = connection[1]
            ssid = connection[2] if len(connection) == 3 else " ".join(connection[2:])
            if state == "connected":
                print(f"{if_icon(interface)}  {ssid}")
                print("\n#b8bb26")
                is_connected = True
                break

        if not is_connected:
            print("󱛅 no connection")
            print("\n#fb4934")

    except subprocess.CalledProcessError as e:
        print("Cannot get wifi status: ", e)
    except Exception as e:
        print("Error: ", e)

