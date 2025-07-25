[![Lint](https://github.com/hideyuki-matsuyama/nova_lance_api/actions/workflows/lint.yml/badge.svg)](https://github.com/hideyuki-matsuyama/nova_lance_api/actions/workflows/lint.yml)
[![Test](https://github.com/hideyuki-matsuyama/nova_lance_api/actions/workflows/test.yml/badge.svg)](https://github.com/hideyuki-matsuyama/nova_lance_api/actions/workflows/test.yml)
[![Security](https://github.com/hideyuki-matsuyama/nova_lance_api/actions/workflows/security.yml/badge.svg)](https://github.com/hideyuki-matsuyama/nova_lance_api/actions/workflows/security.yml)
[![CodeQL](https://github.com/hideyuki-matsuyama/nova_lance_api/actions/workflows/github-code-scanning/codeql/badge.svg)](https://github.com/hideyuki-matsuyama/nova_lance_api/actions/workflows/github-code-scanning/codeql)
[![Postman API Tests](https://github.com/hideyuki-matsuyama/nova_lance_api/actions/workflows/postman.yml/badge.svg)](https://github.com/hideyuki-matsuyama/nova_lance_api/actions/workflows/postman.yml)
[![Dependabot Updates](https://github.com/hideyuki-matsuyama/nova_lance_api/actions/workflows/dependabot/dependabot-updates/badge.svg)](https://github.com/hideyuki-matsuyama/nova_lance_api/actions/workflows/dependabot/dependabot-updates)

# 🚧WIP

* 仮想プロダクトの Rails API アプリケーションです
* テスト実行時に **C1 カバレッジ** を計測しています
  - `Test` workflow の実行結果にある `Artifacts` からダウンロードして参照できます
* VSCode の拡張機能 `GitHub Local Actions` が動作します
  - git push することなく手元で GitHub Workflows が実行可能です
  - ただし当該拡張機能においては、制約により`Artifacts` が作成されません
    - ローカルで `bin/rspec` を実行する分には問題ありません
* Postman の collection.json は チーム開発で conflict が激しくなるため、コレクションを個別に管理できる Insomnia を採用しましたが、以下の理由により再検討が必要です
  - Insomnia 現行バージョンのエクスポート形式（v5 / HAR）が Insomnia の CLI ツール（inso）非対応となっております
  - そのため GitHub Actions で自動テストに使えず、目論見を外した状態です
  - 👉仕方なく Postman で テストを回すようにしました
    - js でテストを頑張るより Rails で完結させた方が良いね

## 起動方法

1. ```sh
   docker compose build
   docker compose up -d
   ```
2. (VSCode)ウィンドウ左下角のアイコンをクリック → 実行中のコンテナにアタッチ → /nova_lance_api 

## デバッグ方法(VSCode)

1. F5 キーでデバッグコンソールを有効にしてください
2. ブレークしたいコードに `debugger` を仕込んでください
<img width="1712" height="987" alt="image" src="https://github.com/user-attachments/assets/b3536f04-65c4-4bb0-8bc4-464a32215071" />
