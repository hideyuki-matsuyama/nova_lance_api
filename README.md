[![Lint](https://github.com/hideyuki-matsuyama/nova_lance_api/actions/workflows/lint.yml/badge.svg)](https://github.com/hideyuki-matsuyama/nova_lance_api/actions/workflows/lint.yml)
[![Security](https://github.com/hideyuki-matsuyama/nova_lance_api/actions/workflows/security.yml/badge.svg)](https://github.com/hideyuki-matsuyama/nova_lance_api/actions/workflows/security.yml)
[![Test](https://github.com/hideyuki-matsuyama/nova_lance_api/actions/workflows/test.yml/badge.svg)](https://github.com/hideyuki-matsuyama/nova_lance_api/actions/workflows/test.yml)

# 🚧WIP

* テスト実行時に C0 カバレッジを計測しています
  - `Test` workflow の実行結果にある `Artifacts` からダウンロードして参照できます
* VSCode の拡張機能 `GitHub Local Actions` が動作します
  - これにより git push することなく手元でワークフローが実行可能です
  - 当該拡張機能においては、その制約により`Artifacts` が作成されません
* Postman の collection.json は conflict が激しくなるため Insomnia を採用しましたが、以下の理由により再検討が必要です
  - Insomnia 現行バージョンのエクスポート形式（v5/HAR）が inso CLI 非対応
  - そのため GitHub Actions で自動テストに使えない
