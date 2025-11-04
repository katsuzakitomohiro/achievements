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
            └── main.pdf            # 生成されたPDF
```

## 必要環境

- **TeX Live** 2021以降（LuaLaTeX，BibLaTeX，Biberを含む）
- **フォント**:
  - 日本語: 原ノ味フォント（HaranoAji）
  - 欧文: Times New Roman / Liberation Serif / TeX Gyre Termes（環境に応じて自動選択）

## ビルド方法

### 基本的なビルド

プロジェクトルートから以下のコマンドを実行:

```bash
cd src/latex
latexmk main.tex
```

生成されたPDFは`src/latex/build/main.pdf`に出力されます。

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

## ライセンス

このプロジェクトは個人の業績管理用です。
