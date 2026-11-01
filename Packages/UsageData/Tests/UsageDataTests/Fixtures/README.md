Recorded API responses and Keychain shapes used by the tests. Never commit a
fixture that contains a token: `grep -rE "sk-ant-oat01-[A-Za-z0-9_-]{20,}" .`
must stay empty.

- `usage_2026-10-21.json` — the response from spec §2.1 (recorded 2026-10-21) with the
  `null` service fields restored; `limits[]` has `session`, `weekly_all`, `weekly_scoped`.
- `usage_no_limits.json` — the same document without `limits` (fallback to
  `five_hour` / `seven_day`).
- `credentials.json` — the Keychain value shape from spec §2.3 with fake tokens and an
  `mcpOAuth` object that the parser must ignore.
