"""A script that prepares a notebook for compatibility with papermill"""
import argparse
import json
import typing
from typing import Any

import papermill


def parse_args() -> dict[str, Any]:
    parser = argparse.ArgumentParser()
    parser.add_argument("filename", type=str, help="The notebook filename")

    args = parser.parse_args()
    args = vars(args)

    return args


def prepare(filename: str) -> None:
    parameters = papermill.inspect_notebook(filename)

    if parameters:
        return

    with open(filename, "rt") as f:
        notebook = json.load(f)

    header = notebook["cells"][0]
    metadata = notebook["metadata"]

    assert header["cell_type"] == "code", "The header cell must be a code cell"

    header["metadata"]["tags"] = ["parameters"]
    metadata["kernelspec"]["language"] = "python"

    with open(filename, "wt") as f:
        json.dump(notebook, f)


if __name__ == "__main__":
    args = parse_args()
    prepare(**args)
