#!/bin/python3

import argparse
import json
import subprocess


parser = argparse.ArgumentParser()
parser.add_argument("action")
parser.add_argument("app")
parser.add_argument("env")


args = parser.parse_args()

action = args.action
app = args.app
env = args.env

env_json_file = open("./env.json")
env_json_contents = env_json_file.read()
env_json = json.loads(env_json_contents)
env_json_file.close()

steps = []


def replace_env(src: str, dest: str):
    src_file = open(src)
    src_file_contents = src_file.read()
    src_file.close()

    for k in env_json["env"][env]:
        src_file_contents = src_file_contents.replace(f"#{k}", env_json["env"][env][k])

    dest_file = open(dest, "w+")
    dest_file.write(src_file_contents)
    dest_file.close()

    pass


# Run replace env
replace_env("./template.env", "./backend/.env")
replace_env("./template.frontend.env", "./frontend/.env")


if app == "backend":
    if action == "run":
        steps = [("php artisan serve", "./backend")]

    elif action == "build":
        steps = [
            ("zip -r release.zip .", "./backend"),
            ("mv release.zip ..", "./backend"),
        ]

elif app == "frontend":
    if action == "run":
        steps = [("flutter run", "./frontend")]

    elif action == "build":
        steps = [("flutter build", "./frontend")]

elif app == "app":
    if action == "run":
        steps = [
            ("flutter build", "./frontend"),
            ("php artisan serve", "./backend"),
        ]

    elif action == "build":
        steps = [
            ("flutter build web", "./frontend"),
            # ("mv public public_html", "./backend"),
            ("cp -r frontend/build/web/* ./backend/public", "./"),
            ("zip -r release.zip . -x ./storage/item*", "./backend"),
            ("mv release.zip ..", "./backend"),
            # ("mv public_html public", "./backend"),
        ]
else:
    pass

for s, cwd in steps:
    subprocess.run(s, cwd=cwd, shell=True)
