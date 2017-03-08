## 1.2.0 (09/03/2017)

Features:
  - Added two new configuration options, `filter_payload_with_whitelist` and `whitelist_payload_shape`
    - See [README.md](https://github.com/MindscapeHQ/raygun4ruby#filtering-the-payload-by-whitelist) for an example of how to use them

Bugfixes:
  - raygun4ruby will no longer crash and suppress app exceptions when the API key is not configured