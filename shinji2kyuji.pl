use strict;
use warnings;
use utf8;
use open IO => qw/:utf8 :std/;

while (my $line = <>)  {
	print kyuzi_henkan($line);
}

sub kyuzi_henkan {
  # いくつかの漢字については、新字に対応する旧字が複数ある場合があるが、
  # ここでは1つの旧字にしか対応付けていない。
  # （例：「弁」に対応する旧字としては「辨・辯・瓣」があるが、
  # 　　　ここではとりあえず「辯」にしかならない。）

  my %kyuziMaps = (
    "亜"  => "亞",
    "悪"  => "惡",
    "圧"  => "壓",
    "扱"  => "\\CID{13637}%扱\n",
    "暗"  => "\\CID{13638}%暗\n",
    "囲"  => "\\CID{13528}%囲\n",
    "医"  => "醫",
    "為"  => "爲",
    "偉"  => "\\CID{13409}%偉\n",
    "意"  => "\\CID{13639}%意\n",
    "違"  => "\\CID{13641}%違\n",
    "遺"  => "\\CID{13642}%遺\n",
    "緯"  => "\\CID{13410}%緯\n",
    "壱"  => "壹",
    "逸"  => "逸",
    "飲"  => "飮",
    "隠"  => "隱",
    "羽"  => "羽",
    "運"  => "\\CID{13649}%運\n",
    "永"  => "\\CID{20154}%永\n",
    "栄"  => "榮",
    "営"  => "營",
    "衛"  => "衞",
    "駅"  => "驛",
    "謁"  => "謁",
    "円"  => "圓",
    "延"  => "\\CID{13654}%延\n",
    "沿"  => "\\CID{13416}%沿\n",
    "媛"  => "\\CID{7784}%媛\n",
    "援"  => "\\CID{13655}%援\n",
    "煙"  => "\\CID{13657}%煙\n",
    "遠"  => "\\CID{13658}%遠\n",
    "鉛"  => "\\CID{13659}%鉛\n",
    "塩"  => "鹽",
    "縁"  => "緣",
    "艶"  => "艷",
    "応"  => "應",
    "往"  => "\\CID{13661}%往\n",
    "欧"  => "歐",
    "殴"  => "毆",
    "桜"  => "櫻",
    "翁"  => "\\CID{13662}%翁\n",
    "奥"  => "奧",
    "横"  => "橫",
    "虞"  => "\\CID{13734}%虞\n",
    "音"  => "\\CID{13664}%音\n",
    "温"  => "溫",
    "穏"  => "穩",
    "化"  => "\\CID{13665}%化\n",
    "仮"  => "假",
    "花"  => "\\CID{13666}%花\n",
    "価"  => "價",
    "貨"  => "\\CID{13668}%貨\n",
    "過"  => "\\CID{13669}%過\n",
    "禍"  => "禍",
    "靴"  => "\\CID{7667}%靴\n",
    "蚊"  => "\\CID{20212}%蚊\n",
    "画"  => "畫",
    "芽"  => "\\CID{13670}%芽\n",
    "雅"  => "\\CID{13671}%雅\n",
    "餓"  => "\\CID{13672}%餓\n",
    "灰"  => "\\CID{13674}%灰\n",
    "会"  => "會",
    "拐"  => "\\CID{7649}%拐\n",
    "悔"  => "悔",
    "海"  => "海",
    "絵"  => "繪",
    "壊"  => "壞",
    "懐"  => "懷",
    "害"  => "\\CID{13675}%害\n",
    "慨"  => "慨",
    "概"  => "槪",
    "拡"  => "擴",
    "殻"  => "殼",
    "覚"  => "覺",
    "較"  => "\\CID{20226}%較\n",
    "学"  => "學",
    "岳"  => "嶽",
    "楽"  => "樂",
    "喝"  => "喝",
    "渇"  => "渴",
    "割"  => "\\CID{13684}%割\n",
    "褐"  => "褐",
    "轄"  => "\\CID{13685}%轄\n",
    "鎌"  => "\\CID{13686}%鎌\n",
    "缶"  => "罐",
    "巻"  => "卷",
    "陥"  => "陷",
    "貫"  => "\\CID{13426}%貫\n",
    "寒"  => "\\CID{13688}%寒\n",
    "勧"  => "勸",
    "寛"  => "寬",
    "漢"  => "漢",
    "関"  => "關",
    "歓"  => "歡",
    "緩"  => "\\CID{13690}%緩\n",
    "還"  => "\\CID{13692}%還\n",
    "館"  => "館",
    "環"  => "\\CID{13689}%環\n",
    "観"  => "觀",
    "韓"  => "\\CID{13694}%韓\n",
    "顔"  => "顏",
    "危"  => "\\CID{13696}%危\n",
    "気"  => "氣",
    "祈"  => "祈",
    "軌"  => "\\CID{13430}%軌\n",
    "既"  => "既",
    "起"  => "\\CID{13704}%起\n",
    "飢"  => "\\CID{13705}%飢\n",
    "帰"  => "歸",
    "亀"  => "龜",
    "幾"  => "\\CID{13700}%幾\n",
    "期"  => "\\CID{13702}%期\n",
    "器"  => "器",
    "機"  => "\\CID{13703}%機\n",
    "偽"  => "僞",
    "戯"  => "戲",
    "犠"  => "犧",
    "喫"  => "\\CID{13707}%喫\n",
    "逆"  => "\\CID{13709}%逆\n",
    "虐"  => "\\CID{13708}%虐\n",
    "及"  => "\\CID{13710}%及\n",
    "旧"  => "舊",
    "吸"  => "\\CID{13711}%吸\n",
    "急"  => "\\CID{13712}%急\n",
    "級"  => "\\CID{13713}%級\n",
    "窮"  => "\\CID{13431}%窮\n",
    "巨"  => "\\CID{13714}%巨\n",
    "拒"  => "\\CID{13715}%拒\n",
    "拠"  => "據",
    "挙"  => "擧",
    "虚"  => "虛",
    "距"  => "\\CID{13716}%距\n",
    "峡"  => "峽",
    "挟"  => "挾",
    "狭"  => "狹",
    "恐"  => "\\CID{13721}%恐\n",
    "強"  => "强",
    "教"  => "敎",
    "郷"  => "鄕",
    "響"  => "響",
    "暁"  => "曉",
    "近"  => "\\CID{13730}%近\n",
    "勤"  => "勤",
    "謹"  => "謹",
    "区"  => "\\CID{13524}%区\n",
    "駆"  => "\\CID{13628}%駆\n",
    "具"  => "\\CID{13733}%具\n",
    "遇"  => "\\CID{13736}%遇\n",
    "勲"  => "勳",
    "薫"  => "薰",
    "径"  => "徑",
    "茎"  => "莖",
    "契"  => "\\CID{13739}%契\n",
    "恵"  => "惠",
    "啓"  => "\\CID{13738}%啓\n",
    "掲"  => "揭",
    "渓"  => "溪",
    "経"  => "經",
    "蛍"  => "螢",
    "軽"  => "輕",
    "継"  => "繼",
    "鶏"  => "鷄",
    "芸"  => "藝",
    "迎"  => "\\CID{13742}%迎\n",
    "撃"  => "擊",
    "欠"  => "缺",
    "穴"  => "\\CID{13434}%穴\n",
    "傑"  => "\\CID{13743}%傑\n",
    "潔"  => "\\CID{13744}%潔\n",
    "券"  => "\\CID{13749}%券\n",
    "肩"  => "\\CID{13752}%肩\n",
    "建"  => "\\CID{13436}%建\n",
    "研"  => "硏",
    "県"  => "縣",
    "倹"  => "儉",
    "兼"  => "\\CID{13748}%兼\n",
    "剣"  => "劍",
    "拳"  => "\\CID{7969}%拳\n",
    "健"  => "\\CID{13435}%健\n",
    "険"  => "險",
    "圏"  => "圈",
    "検"  => "檢",
    "嫌"  => "\\CID{7675}%嫌\n",
    "献"  => "獻",
    "遣"  => "\\CID{13754}%遣\n",
    "権"  => "權",
    "憲"  => "\\CID{13750}%憲\n",
    "謙"  => "\\CID{13753}%謙\n",
    "鍵"  => "\\CID{1892}%鍵\n",
    "繭"  => "\\CID{14049}%繭\n",
    "顕"  => "顯",
    "験"  => "驗",
    "厳"  => "嚴",
    "戸"  => "戶",
    "雇"  => "\\CID{13758}%雇\n",
    "顧"  => "\\CID{13759}%顧\n",
    "呉"  => "吳",
    "娯"  => "娛",
    "誤"  => "\\CID{13762}%誤\n",
    "公"  => "\\CID{13440}%公\n",
    "広"  => "廣",
    "交"  => "\\CID{13439}%交\n",
    "更"  => "\\CID{13441}%更\n",
    "効"  => "效",
    "恒"  => "恆",
    "荒"  => "\\CID{13772}%荒\n",
    "校"  => "\\CID{13442}%校\n",
    "耕"  => "\\CID{13770}%耕\n",
    "降"  => "\\CID{13447}%降\n",
    "控"  => "\\CID{13766}%控\n",
    "梗"  => "\\CID{1998}%梗\n",
    "黄"  => "黃",
    "慌"  => "\\CID{13764}%慌\n",
    "港"  => "\\CID{13769}%港\n",
    "硬"  => "\\CID{13443}%硬\n",
    "絞"  => "\\CID{13444}%絞\n",
    "溝"  => "\\CID{7681}%溝\n",
    "鉱"  => "鑛",
    "構"  => "\\CID{13767}%構\n",
    "講"  => "\\CID{13773}%講\n",
    "購"  => "\\CID{13774}%購\n",
    "号"  => "號",
    "告"  => "吿",
    "国"  => "國",
    "黒"  => "黑",
    "穀"  => "穀",
    "酷"  => "\\CID{13776}%酷\n",
    "込"  => "\\CID{13779}%込\n",
    "鎖"  => "\\CID{13781}%鎖\n",
    "采"  => "\\CID{7685}%采\n",
    "砕"  => "碎",
    "彩"  => "\\CID{13783}%彩\n",
    "採"  => "\\CID{13784}%採\n",
    "済"  => "濟",
    "斎"  => "齋",
    "菜"  => "\\CID{13786}%菜\n",
    "剤"  => "劑",
    "罪"  => "\\CID{13449}%罪\n",
    "削"  => "\\CID{13789}%削\n",
    "咲"  => "\\CID{13788}%咲\n",
    "殺"  => "殺",
    "雑"  => "雜",
    "参"  => "參",
    "桟"  => "棧",
    "蚕"  => "蠶",
    "惨"  => "慘",
    "産"  => "產",
    "賛"  => "贊",
    "残"  => "殘",
    "史"  => "\\CID{13451}%史\n",
    "糸"  => "絲",
    "使"  => "\\CID{13450}%使\n",
    "祉"  => "祉",
    "姿"  => "\\CID{13792}%姿\n",
    "視"  => "視",
    "歯"  => "齒",
    "資"  => "\\CID{13797}%資\n",
    "飼"  => "飼",
    "諮"  => "\\CID{13795}%諮\n",
    "次"  => "\\CID{13799}%次\n",
    "児"  => "兒",
    "辞"  => "辭",
    "湿"  => "濕",
    "実"  => "實",
    "写"  => "寫",
    "社"  => "社",
    "舎"  => "舍",
    "者"  => "者",
    "捨"  => "\\CID{13804}%捨\n",
    "斜"  => "\\CID{13805}%斜\n",
    "煮"  => "煮",
    "遮"  => "\\CID{7694}%遮\n",
    "謝"  => "\\CID{13453}%謝\n",
    "邪"  => "\\CID{13806}%邪\n",
    "酌"  => "\\CID{13810}%酌\n",
    "釈"  => "釋",
    "爵"  => "\\CID{13808}%爵\n",
    "弱"  => "\\CID{13811}%弱\n",
    "主"  => "\\CID{13812}%主\n",
    "寿"  => "壽",
    "受"  => "\\CID{13813}%受\n",
    "授"  => "\\CID{13814}%授\n",
    "収"  => "收",
    "周"  => "\\CID{13815}%周\n",
    "臭"  => "臭",
    "終"  => "\\CID{13816}%終\n",
    "習"  => "\\CID{13817}%習\n",
    "週"  => "\\CID{13819}%週\n",
    "衆"  => "\\CID{13818}%衆\n",
    "住"  => "\\CID{13820}%住\n",
    "従"  => "從",
    "渋"  => "澁",
    "獣"  => "獸",
    "縦"  => "縱",
    "祝"  => "祝",
    "粛"  => "肅",
    "述"  => "\\CID{13822}%述\n",
    "術"  => "\\CID{13821}%術\n",
    "巡"  => "\\CID{13823}%巡\n",
    "潤"  => "\\CID{20166}%潤\n",
    "遵"  => "\\CID{13824}%遵\n",
    "処"  => "處",
    "所"  => "\\CID{13826}%所\n",
    "暑"  => "暑",
    "署"  => "署",
    "緒"  => "緖",
    "諸"  => "諸",
    "叙"  => "敍",
    "肖"  => "\\CID{13838}%肖\n",
    "尚"  => "尙",
    "松"  => "\\CID{13461}%松\n",
    "宵"  => "\\CID{13831}%宵\n",
    "将"  => "將",
    "消"  => "\\CID{13836}%消\n",
    "祥"  => "祥",
    "称"  => "\\CID{7846}%称\n",
    "商"  => "\\CID{13830}%商\n",
    "渉"  => "涉",
    "訟"  => "\\CID{13462}%訟\n",
    "勝"  => "\\CID{13829}%勝\n",
    "焼"  => "燒",
    "硝"  => "\\CID{13837}%硝\n",
    "証"  => "證",
    "奨"  => "奬",
    "丈"  => "\\CID{13463}%丈\n",
    "条"  => "條",
    "状"  => "狀",
    "乗"  => "乘",
    "城"  => "\\CID{2515}%城\n",
    "浄"  => "淨",
    "剰"  => "剩",
    "情"  => "\\CID{13842}%情\n",
    "畳"  => "疊",
    "縄"  => "繩",
    "壌"  => "壤",
    "嬢"  => "孃",
    "譲"  => "讓",
    "醸"  => "釀",
    "食"  => "\\CID{13847}%食\n",
    "植"  => "\\CID{13845}%植\n",
    "殖"  => "\\CID{13846}%殖\n",
    "飾"  => "\\CID{13844}%飾\n",
    "触"  => "觸",
    "嘱"  => "囑",
    "侵"  => "\\CID{13851}%侵\n",
    "神"  => "神",
    "浸"  => "\\CID{13853}%浸\n",
    "真"  => "\\CID{13357}%真\n",
    "進"  => "\\CID{13855}%進\n",
    "寝"  => "寢",
    "慎"  => "\\CID{13356}%慎\n",
    "刃"  => "\\CID{13858}%刃\n",
    "尽"  => "盡",
    "迅"  => "\\CID{13862}%迅\n",
    "尋"  => "\\CID{13859}%尋\n",
    "図"  => "圖",
    "粋"  => "粹",
    "衰"  => "\\CID{13863}%衰\n",
    "酔"  => "醉",
    "遂"  => "\\CID{13864}%遂\n",
    "穂"  => "穗",
    "随"  => "隨",
    "髄"  => "髓",
    "枢"  => "樞",
    "数"  => "數",
    "瀬"  => "瀨",
    "成"  => "\\CID{13867}%成\n",
    "声"  => "聲",
    "斉"  => "齊",
    "逝"  => "\\CID{7714}%逝\n",
    "盛"  => "\\CID{13868}%盛\n",
    "晴"  => "晴",
    "聖"  => "\\CID{13869}%聖\n",
    "誠"  => "\\CID{13871}%誠\n",
    "精"  => "精",
    "静"  => "靜",
    "請"  => "\\CID{13872}%請\n",
    "税"  => "稅",
    "隻"  => "\\CID{13877}%隻\n",
    "籍"  => "\\CID{13878}%籍\n",
    "窃"  => "竊",
    "雪"  => "\\CID{13881}%雪\n",
    "摂"  => "攝",
    "節"  => "節",
    "説"  => "說",
    "絶"  => "絕",
    "専"  => "專",
    "浅"  => "淺",
    "扇"  => "\\CID{13883}%扇\n",
    "栓"  => "\\CID{7717}%栓\n",
    "船"  => "\\CID{13886}%船\n",
    "戦"  => "戰",
    "践"  => "踐",
    "銭"  => "錢",
    "潜"  => "潛",
    "遷"  => "\\CID{13888}%遷\n",
    "選"  => "\\CID{13887}%選\n",
    "繊"  => "纖",
    "全"  => "\\CID{13890}%全\n",
    "前"  => "\\CID{13889}%前\n",
    "禅"  => "禪",
    "祖"  => "祖",
    "双"  => "\\CID{13525}%双\n",
    "壮"  => "壯",
    "争"  => "爭",
    "荘"  => "莊",
    "送"  => "\\CID{13895}%送\n",
    "捜"  => "搜",
    "挿"  => "插",
    "巣"  => "巢",
    "掃"  => "\\CID{13891}%掃\n",
    "曽"  => "曾",
    "痩"  => "瘦",
    "装"  => "裝",
    "僧"  => "僧",
    "層"  => "層",
    "総"  => "總",
    "遭"  => "\\CID{13896}%遭\n",
    "騒"  => "騷",
    "造"  => "\\CID{13897}%造\n",
    "増"  => "增",
    "憎"  => "憎",
    "蔵"  => "藏",
    "贈"  => "贈",
    "臓"  => "臟",
    "即"  => "卽",
    "速"  => "\\CID{13899}%速\n",
    "属"  => "屬",
    "賊"  => "\\CID{13900}%賊\n",
    "続"  => "續",
    "率"  => "\\CID{14085}%率\n",
    "尊"  => "\\CID{13901}%尊\n",
    "遜"  => "\\CID{7726}%遜\n",
    "妥"  => "\\CID{13903}%妥\n",
    "堕"  => "墮",
    "対"  => "對",
    "体"  => "體",
    "退"  => "\\CID{13905}%退\n",
    "帯"  => "帶",
    "逮"  => "\\CID{13906}%逮\n",
    "隊"  => "\\CID{13907}%隊\n",
    "滞"  => "滯",
    "台"  => "臺",
    "滝"  => "瀧",
    "択"  => "擇",
    "沢"  => "澤",
    "濯"  => "\\CID{7731}%濯\n",
    "達"  => "\\CID{13912}%達\n",
    "脱"  => "脫",
    "担"  => "擔",
    "単"  => "單",
    "炭"  => "\\CID{13916}%炭\n",
    "胆"  => "膽",
    "嘆"  => "嘆",
    "誕"  => "\\CID{13917}%誕\n",
    "団"  => "團",
    "断"  => "斷",
    "弾"  => "彈",
    "暖"  => "\\CID{13918}%暖\n",
    "値"  => "\\CID{13919}%値\n",
    "遅"  => "遲",
    "痴"  => "癡",
    "置"  => "\\CID{13920}%置\n",
    "逐"  => "\\CID{13924}%逐\n",
    "築"  => "\\CID{13921}%築\n",
    "虫"  => "蟲",
    "注"  => "\\CID{13926}%注\n",
    "昼"  => "晝",
    "柱"  => "\\CID{13925}%柱\n",
    "衷"  => "\\CID{20214}%衷\n",
    "鋳"  => "鑄",
    "駐"  => "\\CID{13927}%駐\n",
    "著"  => "著",
    "庁"  => "廳",
    "兆"  => "\\CID{13477}%兆\n",
    "彫"  => "\\CID{13928}%彫\n",
    "眺"  => "\\CID{13478}%眺\n",
    "朝"  => "\\CID{13931}%朝\n",
    "跳"  => "\\CID{13480}%跳\n",
    "徴"  => "\\CID{13929}%徴\n",
    "嘲"  => "\\CID{7821}%嘲\n",
    "潮"  => "\\CID{13932}%潮\n",
    "調"  => "\\CID{13933}%調\n",
    "聴"  => "聽",
    "懲"  => "懲",
    "直"  => "\\CID{13934}%直\n",
    "勅"  => "敕",
    "朕"  => "\\CID{13936}%朕\n",
    "鎮"  => "\\CID{13370}%鎮\n",
    "追"  => "\\CID{13938}%追\n",
    "墜"  => "\\CID{13937}%墜\n",
    "通"  => "\\CID{13939}%通\n",
    "塚"  => "塚",
    "坪"  => "\\CID{13940}%坪\n",
    "呈"  => "\\CID{13942}%呈\n",
    "廷"  => "\\CID{13482}%廷\n",
    "帝"  => "\\CID{13943}%帝\n",
    "庭"  => "\\CID{13481}%庭\n",
    "逓"  => "遞",
    "程"  => "\\CID{13944}%程\n",
    "艇"  => "\\CID{13483}%艇\n",
    "適"  => "\\CID{13946}%適\n",
    "迭"  => "\\CID{13947}%迭\n",
    "鉄"  => "鐵",
    "点"  => "點",
    "添"  => "\\CID{13948}%添\n",
    "転"  => "轉",
    "伝"  => "傳",
    "途"  => "\\CID{13950}%途\n",
    "都"  => "都",
    "冬"  => "\\CID{13954}%冬\n",
    "灯"  => "燈",
    "当"  => "當",
    "逃"  => "\\CID{13959}%逃\n",
    "唐"  => "\\CID{13955}%唐\n",
    "桃"  => "\\CID{13484}%桃\n",
    "透"  => "\\CID{13960}%透\n",
    "党"  => "黨",
    "盗"  => "盜",
    "稲"  => "稻",
    "糖"  => "\\CID{13956}%糖\n",
    "謄"  => "\\CID{13958}%謄\n",
    "藤"  => "\\CID{13957}%藤\n",
    "闘"  => "鬪",
    "騰"  => "\\CID{13961}%騰\n",
    "道"  => "\\CID{13963}%道\n",
    "導"  => "\\CID{13962}%導\n",
    "匿"  => "\\CID{20087}%匿\n",
    "徳"  => "德",
    "独"  => "獨",
    "読"  => "讀",
    "突"  => "突",
    "届"  => "屆",
    "那"  => "\\CID{7765}%那\n",
    "謎"  => "\\CID{7766}%謎\n",
    "難"  => "難",
    "弐"  => "貳",
    "肉"  => "\\CID{13967}%肉\n",
    "乳"  => "\\CID{13968}%乳\n",
    "忍"  => "\\CID{13969}%忍\n",
    "認"  => "\\CID{13970}%認\n",
    "寧"  => "\\CID{13971}%寧\n",
    "悩"  => "惱",
    "納"  => "\\CID{13972}%納\n",
    "脳"  => "腦",
    "派"  => "\\CID{13974}%派\n",
    "覇"  => "霸",
    "拝"  => "拜",
    "肺"  => "\\CID{13975}%肺\n",
    "排"  => "\\CID{13487}%排\n",
    "廃"  => "廢",
    "輩"  => "\\CID{13488}%輩\n",
    "売"  => "賣",
    "梅"  => "梅",
    "迫"  => "\\CID{13978}%迫\n",
    "博"  => "\\CID{13976}%博\n",
    "薄"  => "\\CID{13977}%薄\n",
    "麦"  => "麥",
    "縛"  => "\\CID{13979}%縛\n",
    "発"  => "發",
    "髪"  => "髮",
    "抜"  => "拔",
    "半"  => "\\CID{13986}%半\n",
    "伴"  => "\\CID{13984}%伴\n",
    "判"  => "\\CID{13985}%判\n",
    "班"  => "\\CID{13489}%班\n",
    "畔"  => "\\CID{13988}%畔\n",
    "飯"  => "飯",
    "頒"  => "\\CID{13490}%頒\n",
    "繁"  => "繁",
    "晩"  => "晚",
    "蛮"  => "蠻",
    "卑"  => "卑",
    "秘"  => "祕",
    "悲"  => "\\CID{13491}%悲\n",
    "扉"  => "\\CID{7779}%扉\n",
    "碑"  => "碑",
    "避"  => "\\CID{13991}%避\n",
    "鼻"  => "\\CID{13993}%鼻\n",
    "匹"  => "\\CID{13994}%匹\n",
    "姫"  => "姬",
    "評"  => "\\CID{13999}%評\n",
    "病"  => "\\CID{14001}%病\n",
    "浜"  => "濱",
    "貧"  => "\\CID{13496}%貧\n",
    "賓"  => "賓",
    "頻"  => "頻",
    "敏"  => "敏",
    "瓶"  => "甁",
    "父"  => "\\CID{13497}%父\n",
    "負"  => "\\CID{14005}%負\n",
    "浮"  => "\\CID{14004}%浮\n",
    "婦"  => "\\CID{14002}%婦\n",
    "敷"  => "\\CID{14003}%敷\n",
    "侮"  => "侮",
    "服"  => "\\CID{14007}%服\n",
    "福"  => "福",
    "覆"  => "\\CID{14008}%覆\n",
    "払"  => "拂",
    "仏"  => "佛",
    "粉"  => "\\CID{13502}%粉\n",
    "紛"  => "\\CID{13503}%紛\n",
    "雰"  => "\\CID{13504}%雰\n",
    "分"  => "\\CID{13499}%分\n",
    "文"  => "\\CID{20131}%文\n",
    "丙"  => "\\CID{14009}%丙\n",
    "平"  => "\\CID{14011}%平\n",
    "併"  => "倂",
    "並"  => "竝",
    "柄"  => "\\CID{20145}%柄\n",
    "塀"  => "塀",
    "幣"  => "\\CID{14010}%幣\n",
    "弊"  => "\\CID{14012}%弊\n",
    "餅"  => "餠",
    "辺"  => "邊",
    "返"  => "\\CID{14016}%返\n",
    "変"  => "變",
    "偏"  => "\\CID{14014}%偏\n",
    "遍"  => "\\CID{14017}%遍\n",
    "編"  => "\\CID{14015}%編\n",
    "弁"  => "辯",
    "便"  => "\\CID{13506}%便\n",
    "勉"  => "勉",
    "歩"  => "步",
    "簿"  => "\\CID{14018}%簿\n",
    "包"  => "\\CID{14019}%包\n",
    "邦"  => "\\CID{14028}%邦\n",
    "宝"  => "寶",
    "抱"  => "\\CID{14021}%抱\n",
    "泡"  => "\\CID{7793}%泡\n",
    "胞"  => "\\CID{14025}%胞\n",
    "砲"  => "\\CID{14023}%砲\n",
    "崩"  => "\\CID{14020}%崩\n",
    "豊"  => "豐",
    "飽"  => "\\CID{14029}%飽\n",
    "褒"  => "襃",
    "縫"  => "\\CID{14024}%縫\n",
    "亡"  => "\\CID{14031}%亡\n",
    "忙"  => "\\CID{14034}%忙\n",
    "忘"  => "\\CID{14033}%忘\n",
    "房"  => "\\CID{14035}%房\n",
    "冒"  => "\\CID{14038}%冒\n",
    "望"  => "\\CID{14037}%望\n",
    "帽"  => "\\CID{14032}%帽\n",
    "墨"  => "墨",
    "翻"  => "飜",
    "盆"  => "\\CID{13508}%盆\n",
    "麻"  => "\\CID{14044}%麻\n",
    "摩"  => "\\CID{14039}%摩\n",
    "磨"  => "\\CID{14042}%磨\n",
    "魔"  => "\\CID{14043}%魔\n",
    "毎"  => "每",
    "万"  => "萬",
    "満"  => "滿",
    "脈"  => "\\CID{14051}%脈\n",
    "迷"  => "\\CID{14054}%迷\n",
    "免"  => "免",
    "麺"  => "麵",
    "妄"  => "\\CID{14055}%妄\n",
    "盲"  => "\\CID{14057}%盲\n",
    "耗"  => "\\CID{14058}%耗\n",
    "黙"  => "默",
    "紋"  => "\\CID{14060}%紋\n",
    "弥"  => "彌",
    "訳"  => "譯",
    "薬"  => "藥",
    "躍"  => "\\CID{14063}%躍\n",
    "愉"  => "\\CID{14067}%愉\n",
    "諭"  => "\\CID{14068}%諭\n",
    "輸"  => "\\CID{14069}%輸\n",
    "猶"  => "\\CID{14072}%猶\n",
    "遊"  => "\\CID{14076}%遊\n",
    "与"  => "與",
    "予"  => "豫",
    "余"  => "餘",
    "誉"  => "譽",
    "要"  => "\\CID{14079}%要\n",
    "揺"  => "搖",
    "様"  => "樣",
    "養"  => "\\CID{14080}%養\n",
    "謡"  => "謠",
    "曜"  => "\\CID{14077}%曜\n",
    "翌"  => "\\CID{14081}%翌\n",
    "翼"  => "\\CID{14082}%翼\n",
    "来"  => "來",
    "頼"  => "賴",
    "乱"  => "亂",
    "覧"  => "\\CID{14218}%覧\n",
    "欄"  => "欄",
    "吏"  => "\\CID{13513}%吏\n",
    "竜"  => "\\CID{14087}%竜\n",
    "隆"  => "隆",
    "旅"  => "\\CID{14088}%旅\n",
    "虜"  => "虜",
    "両"  => "兩",
    "猟"  => "獵",
    "緑"  => "綠",
    "隣"  => "\\CID{14091}%隣\n",
    "涙"  => "淚",
    "塁"  => "壘",
    "類"  => "類",
    "礼"  => "禮",
    "励"  => "勵",
    "戻"  => "戾",
    "霊"  => "靈",
    "齢"  => "齡",
    "麗"  => "\\CID{13516}%麗\n",
    "暦"  => "曆",
    "歴"  => "歷",
    "恋"  => "戀",
    "連"  => "\\CID{14097}%連\n",
    "廉"  => "\\CID{14095}%廉\n",
    "練"  => "練",
    "錬"  => "鍊",
    "炉"  => "爐",
    "労"  => "勞",
    "郎"  => "郞",
    "朗"  => "朗",
    "廊"  => "廊",
    "楼"  => "樓",
    "録"  => "錄",
    "湾"  => "灣"
   );
  my $kyuziMaps = join('|', map { quotemeta } keys %kyuziMaps);
  $_[0] =~ s/($kyuziMaps)/$kyuziMaps{$1}/eg;
  return $_[0];

}

