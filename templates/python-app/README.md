# python-app

Minimal Python starter within `ai-env`.

Structure
- `src/python_app/` — package with core code and CLI entry
- `tests/` — simple unit tests using `unittest`

Run
- Print greeting:
  - `python -m python_app --name AI`
- Run tests:
  - `python -m unittest -v`

Notes
- Tests adjust `sys.path` to import from `src/` (no install needed).
