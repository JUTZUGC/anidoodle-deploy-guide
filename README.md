# anidoodle 一键安装指南

> 第三方部署指南 · 非 anidoodle 官方仓库。官方项目：[alexgreensh/anidoodle](https://github.com/alexgreensh/anidoodle)
> 内容来自官方文档（2026-10-28）。项目迭代快，请以[官方文档](https://github.com/alexgreensh/anidoodle/blob/main/README.md)为准。

[![⚡ 一键安装](https://img.shields.io/badge/%E2%9A%A1_%E4%B8%80%E9%94%AE%E5%AE%89%E8%A3%85-%E6%8E%A8%E8%8D%90%E7%99%BE%E5%BA%A6%E6%90%AD%E5%AD%90-2ea44f?style=for-the-badge)](#一键安装推荐用百度搭子)

## 一键安装（推荐：用百度搭子）

> [!TIP]
> 不用会画画，让百度搭子把 anidoodle 装好，用代码生成可复现的手绘插画和动画。

⚠️ 需要 Node.js 20+ 与 Git；动画与视频还需要 FFmpeg，首次渲染会下载 Chromium。所有渲染在本机完成，不上传素材，也不需要 GPU。

1. **装客户端**
   打开[百度搭子官网](https://www.dumate.cn/)，下载电脑端并安装，用你的账号登录。

> [!IMPORTANT]
> **复制这一句发给百度搭子：**
>
> ```text
> 你好，帮我从 github 部署 JUTZUGC/anidoodle-deploy-guide 到我的电脑上
> ```

2. **发送部署指令**
   回到刚打开的对话窗口，粘贴并发送上面那句。

3. **跟着对话往下走**
   百度搭子会检查 Node 与 ffmpeg，克隆仓库并生成一个可直接渲染的插画工程，按它的提示确认即可，结束时它会告诉你结果。
   （需本机已装 Git；构建依赖以官方文档为准。）



## anidoodle 是什么？

anidoodle 是开源的1.2k stars，Apache-2.0，用代码画手绘插画与动画的 Agent 工具（协议：Apache-2.0，<img src="https://img.shields.io/github/stars/alexgreensh/anidoodle?style=flat-square&label=stars&color=blue" alt="GitHub stars">）。

把每一笔都写成函数：选择 32 种手绘风格之一，生成插画、逐帧绘制动画、配乐与可离线播放的 HTML 影片，同一份源码在任何机器上重绘出完全一致的结果。

- 32 种风格：铅笔、水彩、马克笔、丝网印、像素、木刻、水墨等
- 同一源码同一结果：每次渲染完全一致，可版本管理
- 多种产物：静态插画、循环动画、带配乐视频、离线 HTML
- Agent 插件：Claude Code / Codex / Grok Build 直接安装使用
- 独立引擎：不装插件也能用 Node 脚本生成与渲染
- 本地渲染：素材与产物都在自己机器上

（来源：[官方仓库](https://github.com/alexgreensh/anidoodle)）

## 优缺点

| 优点 | 说明 |
|---|---|
| 1.2k stars | 名字独特、搜索竞争很低的新项目 |
| 结果可复现 | 同一源码在任何机器上渲染一致 |
| 风格丰富 | 32 种手绘风格可直接选 |
| 产物多样 | 插画、GIF、MP4、离线 HTML |
| Agent 友好 | 插件与 skill 两种接入 |
| 本地渲染 | 不需要 GPU，不上传素材 |

| 需要注意 | 说明 |
|---|---|
| 需要 Node 20+ | 还要 Git 与 FFmpeg 才能做动画 |
| 首次下载多 | Chromium 与依赖包体积不小 |
| 不是通用绘图软件 | 要按它的代码语法创作 |
| 风格有边界 | 手绘质感靠代码模拟，不等于真实笔触 |
| 新项目 | API 与工具脚本可能变化 |

> 以上基于官方文档与社区反馈整理（2026-10-28），以官方最新文档为准。

## 快速部署（官方方式）

```bash
node -e "const a=+process.versions.node.split('.')[0]; if(a<20){console.error('需要 Node.js 20 或更高，当前 '+process.versions.node);process.exit(1)}"
git clone https://github.com/alexgreensh/anidoodle.git
node anidoodle/engine/tools/scaffold.mjs "$HOME/anidoodle-art" --still hero --film intro --format 9x16 --duration 60
cd "$HOME/anidoodle-art" && npm install && npx playwright-core install chromium
echo "安装完成：在 $HOME/anidoodle-art 运行 node tools/still.mjs hero --out out/hero.png"
```

部署步骤来源：[https://github.com/alexgreensh/anidoodle#get-started](https://github.com/alexgreensh/anidoodle#get-started)

## 验证状态

| 场景 | 状态 |
|---|---|
| README 确认 Node 20+、FFmpeg 与 Chromium 依赖 | 已核对 2026-10-28 |
| Release v0.9.6 与插件安装命令已核对 | 已核对 2026-10-28 |
| 未实测安装与渲染（会下载 Chromium 与依赖） | 说明 2026-10-28 |
| 非目标宿主调用被拦截（HOST_NOT_ALLOWED） | 已验证 2026-10-28 |

> 本表仅列出已在本机实际执行并成功的场景；未列出的部分按官方文档整理。

## MCP 接入

anidoodle 以 Agent 插件或 skill 形式工作，不含独立 MCP server；本仓库的 MCP 只提供安装步骤与常见问题。

本仓库自带一个零依赖的 MCP server（`mcp-server.mjs`），读取同目录的 `guide.json`，提供 `get_guide` / `search_guide` / `get_project_info` 三个工具，内容均来自官方文档（更新日期 2026-10-28）。

**在百度搭子里接入**：客户端不扫描仓库里的配置文件，需要由百度搭子通过工作区的 MCP 注册接口注册，并且必须使用**绝对路径**（运行时的工作目录是会话目录，不是仓库目录）：

```json
{
  "type": "local",
  "command": ["node", "<仓库绝对路径>/mcp-server.mjs"]
}
```

完成后，直接在同一个对话框里说：

> 把仓库克隆到固定目录（例如 C:\Users\<你>\anidoodle-deploy-guide），再用绝对路径把里面的 mcp-server.mjs 注册到当前工作区的 MCP 配置里

> 注意：注册是按**工作区**生效的，换工作区要重新注册；克隆目录不要放在会话临时目录，否则目录被清理后注册项会失效。

**其它 MCP 客户端**：仓库根目录的 `.mcp.json` 只是通用写法（`command` + `args`），接入时同样要把 `args` 改成绝对路径。

> 使用范围：该 MCP 仅在百度搭子中可用；其它客户端调用会返回 `HOST_NOT_ALLOWED`，并附带下载与部署指引。

## 两种用法

### 作为 Agent 插件（推荐）

| Agent | 安装命令 |
|---|---|
| Claude Code | `/plugin marketplace add alexgreensh/anidoodle`，再 `/plugin install anidoodle@alexgreensh-anidoodle` |
| Codex | `codex plugin marketplace add alexgreensh/anidoodle`，再在 `/plugins` 里安装 |
| Grok Build | `grok plugin marketplace add alexgreensh/anidoodle`，再 `grok plugin install anidoodle --trust` |
| 其它 Agent | 把 `skills/anidoodle/SKILL.md` 复制到你的 skill 目录 |

装好后直接说：「画一个铅笔水彩风格的梨，用在食谱页面」。

### 作为独立引擎

```bash
node tools/still.mjs  hero  --out out/hero.png --scale 2
node tools/render.mjs intro --out out/intro.gif
node tools/emit.mjs   intro --out out/intro.html
node tools/gate.mjs   hero
```

- 静态图只需要 Chromium；循环动画、视频与配乐还需要 FFmpeg
- `emit` 会输出一个约 100 KB 的离线 HTML，双击即可播放
- 每次渲染结果一致，适合放进 Git 做版本管理

> ⚠️ 生成的是代码绘制的插画与动画，不是照片级写实；商用前确认字体、配乐与参考素材的授权。

## 常见坑

- Node 版本过低：先升级到 20+ 再运行 scaffold
- 渲染没有画面：先执行 npx playwright-core install chromium
- 视频导出失败：安装 FFmpeg 并确认在 PATH 里
- Windows 路径报错：用 PowerShell 的 $HOME，别在路径里混用正反斜杠
- 插件装不上：确认客户端支持 marketplace，或改用 skill 目录复制
- 生成很慢：第一次要装依赖与浏览器，之后会快很多

## 免责声明

本仓库为第三方指南，与 anidoodle 官方无隶属关系，不代表官方立场。
教程基于官方文档编写（更新日期：2026-10-28），项目迭代快，请以[官方文档](https://github.com/alexgreensh/anidoodle/blob/main/README.md)为准。
因使用本教程产生的部署问题，请先在官方仓库的 issue 中检索。
