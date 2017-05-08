use warnings;
use strict;
use IO::File;
use Text::CSV_XS;
use Inline::Files;

my $csv_obj = Text::CSV_XS -> new({binary=>1});
my $input   = IO::File -> new('../kyuji-table.csv', "r") or die "$!";
my $output  = IO::File -> new('./kyuji-table.tex', "w") or die "$!";

# ヘッダを出力
while (<HEADER>) {
  print $output $_;
}

$csv_obj -> getline($input); # 最初の1行を飛ばす

# 表の中身を出力
while (my $columns = $csv_obj -> getline($input)) {
  (my $cid_output = @$columns[5]) =~ s/CID\+([0-9]+)/{\\huge \\CID{$1}}/g;
  print $output <<"EOS";
  @$columns[0] & {\\huge @$columns[1]} &
    {\\huge @$columns[2]} @$columns[3] &
    $cid_output @$columns[4] / @$columns[5] \\\\ \\hline
EOS
}

while (<FOOTER>) {
  print $output $_;
}

$input  -> close;
$output -> close;

__HEADER__
\documentclass[uplatex,12pt]{jsarticle}
\usepackage[jis2004,deluxe]{otf}
\usepackage{longtable}
\renewcommand{\arraystretch}{1.8}
\begin{document}

\noindent{\gtfamily\bfseries\Huge 新旧字体対照表}

\begin{longtable}[c]{llp{3cm}l}
   \hline
   ID & 新字 & 旧字（IVS不使用） & 旧字（IVS使用）\\
   \hline\hline
   \endhead
__FOOTER__
\end{longtable}
\end{document}
