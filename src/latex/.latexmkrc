#!/usr/bin/env perl
# ==================================================
# latexmk設定ファイル（LuaLaTeX用）
# 業績一覧専用
# ==================================================

# ==================================================
# PDFエンジン設定
# ==================================================

$pdf_mode = 4; # 4 = LuaLaTeX を使用
$lualatex = "lualatex -synctex=1 -interaction=nonstopmode -file-line-error %O %S";

# ==================================================
# 参考文献処理
# ==================================================

$biber = "biber %O %S";
$bibtex_use = 2; # 2 = biber を使用

# ==================================================
# クリーンアップ設定
# ==================================================

# 注意: synctex.gz（PDF-TeX間ジャンプ用）と log（デバッグ用）は含めない
$clean_ext = "aux bbl bcf blg brf fdb_latexmk fls lof lot out run.xml toc xdv";

# 追加のクリーンアップターゲット
$clean_full_ext = "aux bbl bcf blg brf fdb_latexmk fls lof log lot out run.xml toc synctex.gz";

# ==================================================
# PDFビューア設定（プラットフォーム対応）
# ==================================================

if ($^O eq "MSWin32") {
    $pdf_previewer = "start %S"; # Windows標準のPDFビューア
} elsif ($^O eq "darwin") {
    $pdf_previewer = "open %S";  # macOS標準のPDFビューア
} else {
    # Linux/Unix系（CIを含む）
    $pdf_previewer = "echo 'PDF generated: %S'"; # CI環境では表示のみ
}

# ==================================================
# 出力ディレクトリ設定
# ==================================================

$out_dir = "build";
$emulate_aux = 1;

# ==================================================
# プラットフォーム共通設定
# ==================================================

# キャッシュディレクトリの設定
$ENV{'TEXMFCACHE'} = "build/.texmf-cache";

# 入力パスの設定（全プラットフォーム共通）
$ENV{'LUAINPUTS'} = ".;./src//;";
$ENV{'TEXINPUTS'} = ".;./src//;";
$ENV{'BIBINPUTS'} = ".;./src//;./src/bibliography//;";
$ENV{'BSTINPUTS'} = ".;./src//;";

# ==================================================
# プラットフォーム固有設定
# ==================================================

if ($^O eq "MSWin32") {
    # Windows固有設定
    # ファイル名にスペースや日本語が含まれる場合の対策
    $latex_silent_switch = "-interaction=batchmode";
    $pdflatex_silent_switch = "-interaction=batchmode";
    $lualatex_silent_switch = "-interaction=batchmode";
    
    # Windows日本語パス対応
    $ENV{'LUAINPUTS'} .= ";";  # パス区切り文字の調整
} else {
    # Unix系（Linux/macOS/CI環境）
    # 標準設定を使用（デフォルトの-interaction=nonstopmode）
    $latex_silent_switch = "-interaction=nonstopmode";
    $pdflatex_silent_switch = "-interaction=nonstopmode";
    $lualatex_silent_switch = "-interaction=nonstopmode";
}

# ==================================================
# その他の設定
# ==================================================

$max_repeat = 5; # 最大実行回数

# 不要なディレクトリを削除するフック
sub remove_build_dirs {
    use File::Path qw(remove_tree);
    
    # buildディレクトリ内のconfig、contents、.texmf-cache以外の不要ディレクトリを削除
    if (-d "build/config") {
        remove_tree("build/config", {safe => 1});
    }
    if (-d "build/contents") {
        remove_tree("build/contents", {safe => 1});
    }
}

# ==================================================
# ビルド完了後のクリーンアップフック（プラットフォーム対応）
# ==================================================

if ($^O eq "MSWin32") {
    # Windows環境
    $success_cmd = 'perl -e "use File::Path qw(remove_tree); remove_tree(q{build/config}, {safe => 1}) if -d q{build/config}; remove_tree(q{build/contents}, {safe => 1}) if -d q{build/contents};"';
    $failure_cmd = 'perl -e "use File::Path qw(remove_tree); remove_tree(q{build/config}, {safe => 1}) if -d q{build/config}; remove_tree(q{build/contents}, {safe => 1}) if -d q{build/contents};"';
} else {
    # Unix系環境（Linux/macOS/CI環境）
    $success_cmd = 'rm -rf build/config build/contents 2>/dev/null || true';
    $failure_cmd = 'rm -rf build/config build/contents 2>/dev/null || true';
}

END {
    remove_build_dirs();
}
