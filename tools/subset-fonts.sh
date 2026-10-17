#!/bin/bash
# 改了文案后，重新生成字体子集（仅包含 index.html 里出现的字）
# 用法：在 site/ 目录下执行  bash tools/subset-fonts.sh
set -e
cd "$(dirname "$0")/.."

UA="Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0 Safari/537.36"

CHARS=$(python3 - <<'PY'
import re
html=open('index.html',encoding='utf-8').read()
body=re.sub(r'<!--.*?-->','',html,flags=re.S)
body=re.sub(r'<(script|style).*?</\1>','',body,flags=re.S)
text=re.sub(r'<[^>]+>','',body)
chars=''.join(sorted(set(text)))
chars=''.join(c for c in chars if not c.isspace())
chars=''.join(sorted(set(chars+'，。·「」（）—→abc')))
print(chars)
PY
)

Q=$(python3 -c "import urllib.parse,sys;print(urllib.parse.quote(sys.argv[1]))" "$CHARS")

FETCH() {
  local url="$1"
  curl -s -A "$UA" "https://fonts.googleapis.com/css2?family=${url}&text=${Q}" \
    | grep -o "https://fonts.gstatic.com[^)]*" | head -1
}

echo "→ 正在获取字体子集…"
U1=$(FETCH "ZCOOL+KuaiLe")
U2=$(FETCH "Noto+Serif+SC:wght@600")

[ -n "$U1" ] && curl -s -A "$UA" "$U1" -o assets/fonts/zcool-kuai-le-subset.woff2
[ -n "$U2" ] && curl -s -A "$UA" "$U2" -o assets/fonts/noto-serif-sc-600-subset.woff2

ls -la assets/fonts/*.woff2
echo "✓ 完成，刷新浏览器即可看到新的手写字形"
