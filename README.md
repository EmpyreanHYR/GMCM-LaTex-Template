# GMCM LaTeX Template

自用整理的“华为杯”研究生数学建模竞赛 LaTeX 论文模板，基于 GMCMthesis，提供分章节写作、常用数学排版示例与一键编译脚本。

## 特性

- 使用原有 `gmcmthesis.cls`、封面资源和 `gmcm.bst` 文献样式。
- 以 `GMCM-main.tex` 为统一入口，摘要、正文、参考文献与附录分文件管理。
- 各问题按“模型建立—求解设置—结果—验证与解释”组织。
- 常规表格采用标准三线表，支持浅色表头、公式、子图和算法伪代码。
- 支持 Python、MATLAB 源文件导入与语法高亮。
- 一键编译主文件，自动处理参考文献和交叉引用，完成后清理辅助文件。

## 快速开始

### 1. 准备环境

安装包含 **XeLaTeX、BibTeX 和 latexmk** 的 TeX 发行版，并安装模板所需字体。macOS 可使用 MacTeX；Windows 可使用 TeX Live。

模板沿用 `fontset=windows`，使用宋体、黑体、楷体、仿宋、隶书、Times New Roman、Arial 和 Courier New。字体文件位于 `fonts/`，字体名称与安装说明见 [fonts/README.md](fonts/README.md)。

### 2. 获取模板

```bash
git clone https://github.com/EmpyreanHYR/GMCM-LaTex-Template.git
cd GMCM-LaTex-Template
```

也可以在 GitHub 下载 ZIP 并解压。

### 3. 编译

**macOS：** 在 Finder 中双击 `编译论文.command`，编译成功后自动打开 PDF；也可在仓库目录运行：

```bash
./makefiles.sh
```

**Windows：** 双击 `makefiles.bat`，或在仓库目录运行同名命令。

脚本固定只编译 `GMCM-main.tex`。所有辅助文件在临时目录生成，成功后仅将 `GMCM-main.pdf` 保存到仓库根目录；失败时保留原 PDF 和 `GMCM-build-error.log`，下次成功会删除错误日志。

在编辑器中手动编译时，将主文件设为 `GMCM-main.tex`，引擎设为 **XeLaTeX**，文献工具使用 **BibTeX**。也可以执行 `latexmk -xelatex GMCM-main.tex`；手动编译不包含脚本的自动清理步骤。

## 目录结构

```text
.
├── GMCM-main.tex          # 主文件、论文信息及宏包配置
├── gmcmthesis.cls         # 原模板文档类
├── gmcm.bst               # 参考文献样式
├── reference.bib          # 文献数据库
├── texfile/               # 摘要、正文、参考文献与附录
├── figures/               # 封面资源及论文图片
├── code/                  # Python / MATLAB 示例程序
├── examples/              # 原模板示例，供查阅
├── docs/contest/          # 比赛资料
├── fonts/                 # 字体文件与安装说明
├── makefiles.sh           # macOS / Unix 编译脚本
├── makefiles.bat          # Windows 编译脚本
└── 编译论文.command        # macOS 双击入口
```

## 开始写作

先在 `GMCM-main.tex` 中填写论文标题、学校、队号和队员信息，再编辑对应章节：

| 文件 | 内容 |
| --- | --- |
| `texfile/1abstract.tex` | 摘要与关键词 |
| `texfile/2ProblemRestatement.tex` | 问题重述 |
| `texfile/3ProblemAnalysis.tex` | 问题分析 |
| `texfile/4AssumptionAndSign.tex` | 模型假设与符号说明 |
| `texfile/5MakeModel.tex` | 数据预处理、各问题建模、求解、结果与验证 |
| `texfile/6ErrorAnalysis.tex` | 误差与敏感性分析 |
| `texfile/7ModelEvaluation.tex` | 模型评价与推广 |
| `texfile/8Reference.tex` | 参考文献输出 |
| `texfile/9Appendix.tex` | 程序与支撑材料 |

- 新增文献写入 `reference.bib`，在正文使用 `\cite{引用键}` 引用。
- 图片放入 `figures/`，代码放入 `code/`；示例中已有对应写法。
- 常规表格使用 `\toprule`、`\midrule`、`\bottomrule`，不加竖线和逐行网格；特定展示需要的额外边框仅在该表内设置。
- 默认不生成目录，摘要后直接进入正文；原始示例保存在 `examples/`，不参与一键编译。

题目、队号、正文提示、示例数据、图片、文献和程序均需按实际论文替换。

比赛资料位于 [docs/contest](docs/contest/)。
