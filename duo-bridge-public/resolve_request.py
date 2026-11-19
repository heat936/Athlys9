"""Resolve the single PUBLIC chat-created request in the triggering push.

Never reads private repositories. The request and generated report are publicly visible.
"""
import json
import os
import pathlib
import re
import sys

DEFAULT = (
    "Design three simple field validation tests for a fictional sports app's "
    "pole vault training form. Use concise English. This is public synthetic data."
)
ALLOWED = re.compile(r"^duo-bridge-public/requests/[a-z0-9][a-z0-9-]{7,70}\.json$")


def main():
    event = json.loads(pathlib.Path(os.environ["GITHUB_EVENT_PATH"]).read_text())
    changed = event.get("head_commit", {}).get("added", []) if os.environ.get("GITHUB_EVENT_NAME") == "push" else []
    chosen = [p for p in changed if ALLOWED.fullmatch(p)]
    if len(chosen) > 1:
        raise ValueError("A push must contain at most one new public Duo request")
    if chosen:
        obj = json.loads(pathlib.Path(chosen[0]).read_text(encoding="utf-8"))
        if set(obj) != {"mode", "task"} or obj["mode"] != "free_local":
            raise ValueError("Invalid public Duo request schema")
        task = obj["task"]
        if not isinstance(task, str) or not (20 <= len(task) <= 500):
            raise ValueError("Public task must be 20 to 500 characters")
        if "\x00" in task:
            raise ValueError("Invalid task characters")
        print("Public chat request validated:", chosen[0])
    else:
        task = DEFAULT
        print("No new chat request in this push; using generic public smoke task.")
    pathlib.Path("duo-request-task.txt").write_text(task, encoding="utf-8")


if __name__ == "__main__":
    main()
