# 業績一覧（Achievements List）

このリポジトリは業績一覧を管理・生成するためのものです。

## 概要

LaTeX（LuaLaTeX + BibLaTeX/Biber）を使用して，研究業績および学術活動・社会貢献・資格などの一覧をPDF形式で生成します。

## プロジェクト構成

```text
achievements/
├── .gitignore                      # Git管理除外設定
├── .vscode/                        # VSCode設定
│   └── settings.json
├── CLAUDE.md                       # Claude向けドキュメント作成規約
├── README.md                       # このファイル
└── src/
    └── latex/
        ├── main.tex                # メインTeXファイル
        ├── .latexmkrc              # LaTeXビルド設定
        ├── config/
        │   ├── preamble.tex        # パッケージ設定
        │   └── macros.tex          # 文書情報・マクロ定義
        ├── contents/
        │   └── achievements.tex    # 業績一覧本体
        ├── bibliography/           # BibLaTeX用bibliographyファイル
        │   ├── research/           # 研究業績
        │   │   ├── journals.bib
        │   │   ├── international-conferences.bib
        │   │   ├── domestic-conferences.bib
        │   │   ├── others.bib
        │   │   └── awards.bib
        │   └── academic-social/    # 学術活動・社会貢献・資格
        │       ├── academic-activities.bib
        │       ├── social-contributions.bib
        │       ├── awards.bib
        │       └── qualifications.bib
        └── build/                  # ビルド出力ディレクトリ
            ├── .texmf-cache/       # LuaTeXフォントキャッシュ（Git管理対象外）
            ├── main.pdf            # 生成されたPDF（Git管理対象）
            ├── main.log            # ビルドログ（Git管理対象外）
            └── main.synctex.gz     # SyncTeX同期ファイル（Git管理対象外）
```

**注**: `build/` ディレクトリはGit管理されますが，`*.log`，`*.synctex.gz`，`.texmf-cache/` などの補助ファイル・ディレクトリは `.gitignore` により管理対象外です。

## 必要環境

- **TeX Live** 2021以降（LuaLaTeX，BibLaTeX，Biberを含む）
- **フォント**:
  - 日本語: 原ノ味フォント（HaranoAji）
  - 欧文: Times New Roman / Liberation Serif / TeX Gyre Termes（環境に応じて自動選択）

## ビルド方法

### VS Codeでのビルド（推奨）

LaTeX Workshop拡張機能を使用している場合，TeXファイルを保存（Ctrl+S / Cmd+S）するだけで自動的にビルドとクリーンアップが実行されます。

- **自動ビルド**: ファイル保存時に実行
- **自動クリーンアップ**: ビルド後に補助ファイルを自動削除（[.vscode/settings.json:50](.vscode/settings.json#L50), [61-69](.vscode/settings.json#L61-L69)）

### コマンドラインでのビルド

プロジェクトルートから以下のコマンドを実行:

```bash
cd src/latex
latexmk main.tex
```

生成されたPDFは`src/latex/build/main.pdf`に出力されます。

**注**: コマンドラインビルドでは，[.latexmkrc](.latexmkrc) の設定に基づく最小限のクリーンアップのみが実行されます。完全なクリーンアップにはVS Codeの使用を推奨します。

### クリーンビルド

```bash
cd src/latex
latexmk -C main.tex  # クリーンアップ
latexmk main.tex     # 再ビルド
```

### 継続監視モード（ファイル変更時に自動ビルド）

```bash
cd src/latex
latexmk -pvc main.tex
```

## カスタマイズ

### 文書情報の変更

[src/latex/config/macros.tex](src/latex/config/macros.tex) の以下の部分を編集:

```latex
\newcommand{\doctitle}{業績一覧}
\newcommand{\docauthor}{勝崎友裕}
\newcommand{\docyear}{2025}
\newcommand{\docmonth}{11}
```

### 業績データの追加・編集

各種bibファイル（`src/latex/bibliography/`配下）を編集してください。

- **研究業績**: `bibliography/research/`
  - `journals.bib`: 学術論文（査読有り）
  - `international-conferences.bib`: 国際会議論文（査読有り）
  - `domestic-conferences.bib`: 国内会議・研究会（査読無し）
  - `others.bib`: その他（シンポジウム・プレプリント・ソフトウェアなど）
  - `awards.bib`: 研究業績に関する受賞

- **学術活動・社会貢献・資格**: `bibliography/academic-social/`
  - `academic-activities.bib`: 学術活動
  - `social-contributions.bib`: 社会貢献
  - `awards.bib`: 学術活動・社会貢献に関する受賞
  - `qualifications.bib`: 資格・修了証明

## 文書作成規約

### 句読点の使用規則

詳細は[CLAUDE.md](CLAUDE.md)を参照してください。

- **日本語**: 読点「，」（全角カンマ），句点「。」（全角句点）
- **英語**: カンマ「, 」（半角カンマ + スペース），ピリオド「. 」（半角ピリオド + スペース）

## 公開にあたって

このリポジトリは，著者の業績一覧（CV）を組版するためのLaTeXソースとビルド設定を公開するものです。収録しているのは，学術論文・国際会議・国内会議・受賞・学術活動・社会貢献・資格といった，公表済みの業績情報に限られます。連絡先・住所・学籍番号などの個人情報は含みません。

業績データの内容は随時更新されるため，最新の状態は `src/latex/build/main.pdf` を参照してください。

## ライセンス

このリポジトリは，内容に応じて2種類の扱いを設けています。

### LaTeXソース・スクリプト・設定（MIT License）

`src/latex/main.tex`，`src/latex/config/`，`src/latex/contents/`，`src/latex/.latexmkrc`，`.vscode/settings.json`，`.gitignore` などの組版の仕組みにあたる部分は，MIT Licenseで提供します。詳細は[LICENSE](LICENSE)を参照してください。業績一覧を作成するためのテンプレートとして，自由に複製・改変・再配布できます。

### 業績データ・生成PDF（All rights reserved）

`src/latex/bibliography/**/*.bib` に収録した業績データの本文と，そこから生成した `src/latex/build/main.pdf` は，著作権を著者が留保します（All rights reserved）。

- 出典を明示した引用・参照は，許諾なく行えます。
- 全体または相当部分の複製・再配布・改変版の公開には，著者の許諾が必要です。
