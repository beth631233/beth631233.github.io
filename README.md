# PageB · 个人品牌站（GitHub Pages 版）

纯静态网站，只用原生 HTML / CSS / JS。**不需要安装任何开发环境**，双击就能看，上传就能上线。

---

## 一、文件结构

```
site/
├── index.html                页面本体（一页 4 屏）
├── README.md                 本说明
└── assets/
    ├── css/style.css         全部样式
    ├── js/main.js            图片占位切换 + 滚动淡入（可选，删掉也能正常看）
    ├── fonts/
    │   ├── noto-serif-sc-600-subset.woff2   标题宋体（38KB，仅含本站用字）
    │   └── zcool-kuai-le-subset.woff2       手写体（20KB，仅含本站用字）
    └── images/
        ├── favicon.svg       浏览器标签图标
        ├── portrait.jpg      ← 待放入：个人照片
        ├── work-1.jpg        ← 待放入：作品图
        ├── work-2.jpg
        ├── work-3.jpg
        └── work-4.jpg
```

全站**零外部请求**：字体已本地化，没有 Google Fonts、没有 CDN、没有外部图片。国内打开也快。

---

## 二、在电脑上预览

**方法 A（最快）**
双击 `index.html`，浏览器直接打开。

**方法 B（推荐，更接近线上）**
终端执行：

```bash
cd ~/WorkBuddy/心理FDE/site
python3 -m http.server 8000
```

浏览器打开 <http://localhost:8000>。

**看手机效果**
Chrome 按 `⌥⌘I` → 点左上角手机图标 → 宽度选 **iPhone 12 Pro（390px）**。
建议同时试 **320px**（小屏）和 **768px**（平板）。

---

## 三、换照片 / 换作品图（不用改代码）

把图片按下面的文件名丢进 `assets/images/` 即可：

| 文件名 | 用在哪 | 建议尺寸 |
|--------|--------|----------|
| `portrait.jpg` | 首屏个人照片 | 竖版 4:5，宽 ≥ 900px |
| `work-1.jpg` ～ `work-4.jpg` | 作品区 4 个图位 | 正方形，宽 ≥ 800px |

- **有图自动显示，没图保留虚线占位块**，不需要动 HTML。
- 想加第 5 张作品：在 `index.html` 里复制一个 `.slot` 块，把 `work-5.jpg` 写进去即可。
- 想压缩体积：<https://squoosh.app> 压到 200KB 以内。

---

## 四、改文字

打开 `index.html`，文字都在正文里直接写，改完保存刷新即可。

⚠️ 两个注意：
1. **改字可能丢手写字形**。标题/手写体只打包了当前页面用到的字（共 223 个），新增的字会退回到系统字体。
   如果改了文案想恢复手写效果，运行 `tools/subset-fonts.sh`（需要联网，会重新生成字体文件）。
2. 事实只写本人确认过的，不确定的标【待确认】——这是本项目的内容规矩。

---

## 五、发布到 GitHub Pages

1. 登录 <https://github.com> → 右上角 `+` → `New repository`
2. 仓库名例如 `pageb-site`，选 **Public** → `Create repository`
3. 点 `uploading an existing file`，把 `site/` 里面的**全部内容**拖进去（`index.html`、`assets` 文件夹、`README.md`、`tools`）→ `Commit changes`
   - 注意：拖文件夹**里面的东西**，不要只拖 `site` 这个外层文件夹
4. 仓库 `Settings` → 左侧 `Pages` → `Source` 选 **Deploy from a branch**
5. Branch 选 **main**，目录选 **/(root)** → `Save`
6. 等 1–2 分钟刷新，页面顶部出现网址：`https://你的用户名.github.io/pageb-site/`
7. 手机打开验证；以后改内容只要重新上传覆盖，约 1 分钟自动更新

> 想要更短网址：仓库命名为 `你的用户名.github.io`，网址即为 `https://你的用户名.github.io/`

---

## 六、内容规矩（改稿时守住）

1. 经历、作品、能力**只用本人亲口说过的事实**，不确定写【待确认】
2. 参考站只学版式与配色，不搬其文字、图片、标志
3. 出现本人以外的人或公司 → 先取得对方同意（壹心理已获本人确认可点名；2021–2023 段不写公司名）
4. 移动端优先：九成访客用手机打开

---

## 七、待补清单

- [ ] `portrait.jpg` 个人照片
- [ ] `work-1.jpg` ～ `work-4.jpg` 作品图（4 张）
- [ ] 上线后把网址填到小红书主页

---

## 八、可选的维护脚本

`tools/subset-fonts.sh`：改了文案后重新生成字体子集。需要 macOS 自带 python3 与网络，普通浏览/发布**不需要**运行它。
