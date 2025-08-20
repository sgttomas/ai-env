import argparse
from .core import greet


def main() -> None:
    parser = argparse.ArgumentParser(description="python-app greeter")
    parser.add_argument("--name", default="world", help="Name to greet")
    args = parser.parse_args()
    print(greet(args.name))


if __name__ == "__main__":
    main()
