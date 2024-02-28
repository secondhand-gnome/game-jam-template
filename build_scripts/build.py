#!/usr/bin/python3

import configparser
import os
import pathlib
import shutil
import subprocess
import sys
import zipfile

BUILD_PATH = "Build/Web/"
ZIP_PATH = "Build/Web.zip"

def fancy_print(s: str):
    print(f"---\n| {s}\n---")

def check_deps():
    # Test that the godot command works
    godot_result = subprocess.run(
        ["godot", "--version"], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
    if godot_result.returncode != 0:
        print("godot command did not run")
        sys.exit(1)

    # Test that the butler command works
    butler_result = subprocess.run(
        ["butler", "--version"], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
    if butler_result.returncode != 0:
        print("butler command did not run")
        sys.exit(1)

def build_web():
    build_path = pathlib.Path(BUILD_PATH)
    if build_path.exists():
        fancy_print("Removing old Build dir")
        if build_path.is_dir():
            shutil.rmtree(build_path, ignore_errors=True)
        elif build_path.is_file() or build_path.is_symlink():
            build_path.unlink()
        else:
            print(f"Error - {BUILD_PATH} has unsupported file type")
            sys.exit(1)

    fancy_print("Creating new build dir")
    build_path.mkdir(parents=True)

    fancy_print("Building HTML5...")
    godot_build_result = subprocess.run(
        ["godot", "--headless", "--export-release", "Web", f"{BUILD_PATH}index.html"])
    if godot_build_result.returncode == 0:
        print("Build succeeded.")
    else:
        print("Build failed.")
        sys.exit(1)

def zip_web():
    old_zip_file = pathlib.Path(ZIP_PATH)
    if old_zip_file.exists():
        fancy_print("Removing old zip file...")
        old_zip_file.unlink()

    fancy_print("Zipping build files...")
    build_dir = pathlib.Path(BUILD_PATH)
    with zipfile.ZipFile(ZIP_PATH, mode="w") as zip:
        for file_path in build_dir.iterdir():
            print("Zipping ", file_path)
            zip.write(file_path, arcname=file_path.name)

def release_web():
    CONFIG_PATH = "build_scripts/build_config.ini"
    config = configparser.ConfigParser()
    config.read(CONFIG_PATH)
    user = config["butler"]["user"]
    game = config["butler"]["game"]

    if not user or not game:
        print(f"Need valid user and game in {CONFIG_PATH}")
        sys.exit(1)

    fancy_print("Uploading to itch.io...")
    butler_result  = subprocess.run(
        ["butler", "push", ZIP_PATH, f"{user}/{game}:html5-release"])


if __name__ == "__main__":
    check_deps()
    build_web()
    zip_web()
    release_web()