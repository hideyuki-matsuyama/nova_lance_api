[![Lint](https://github.com/hideyuki-matsuyama/nova_lance_api/actions/workflows/lint.yml/badge.svg)](https://github.com/hideyuki-matsuyama/nova_lance_api/actions/workflows/lint.yml)
[![Security](https://github.com/hideyuki-matsuyama/nova_lance_api/actions/workflows/security.yml/badge.svg)](https://github.com/hideyuki-matsuyama/nova_lance_api/actions/workflows/security.yml)
[![Test](https://github.com/hideyuki-matsuyama/nova_lance_api/actions/workflows/test.yml/badge.svg)](https://github.com/hideyuki-matsuyama/nova_lance_api/actions/workflows/test.yml)
[![CodeQL](https://github.com/hideyuki-matsuyama/nova_lance_api/actions/workflows/github-code-scanning/codeql/badge.svg)](https://github.com/hideyuki-matsuyama/nova_lance_api/actions/workflows/github-code-scanning/codeql)
[![Dependabot Updates](https://github.com/hideyuki-matsuyama/nova_lance_api/actions/workflows/dependabot/dependabot-updates/badge.svg)](https://github.com/hideyuki-matsuyama/nova_lance_api/actions/workflows/dependabot/dependabot-updates)

# 🚧WIP

* 仮想プロダクトの Rails API アプリケーションです
* テスト実行時に C0 カバレッジを計測しています
  - `Test` workflow の実行結果にある `Artifacts` からダウンロードして参照できます
* VSCode の拡張機能 `GitHub Local Actions` が動作します
  - git push することなく手元で GitHub Workflows が実行可能です
  - ただし当該拡張機能においては、制約により`Artifacts` が作成されません
* Postman の collection.json は conflict が激しくなるため、コレクションを個別に管理できる Insomnia を採用しましたが、以下の理由により再検討が必要です
  - Insomnia 現行バージョンのエクスポート形式（v5 / HAR）が Insomnia の CLI ツール（inso）非対応となっております
  - そのため GitHub Actions で自動テストに使えない状態です
