# 复现材料：数据使用说明与变量编码手册（中文版）

**论文题目：** *Restriction Intensity, Duration, and Compensatory Travel Intention: A Time-Contingent Test of Boredom and Sensation Seeking*  
**投稿期刊：** *Humanities and Social Sciences Communications* (Springer Nature)

**数据收集与筛选：** 问卷通过问卷星和见数平台发放。数据在分析前已经完成筛选，已剔除答题时间过短和重复作答的记录。本目录中的文件是筛选后的去标识化分析数据副本。

**正式研究数据属性：** 本数据支撑论文《限制强度、持续时间与补偿性旅行意向：无聊感与感觉寻求的时间权变检验》（英文题目：*Restriction Intensity, Duration, and Compensatory Travel Intention: A Time-Contingent Test of Boredom and Sensation Seeking*），投稿期刊为 *Humanities and Social Sciences Communications*，投稿 ID 为 `c184b6df-feca-4378-8b28-ae48e994097`。数据仅供本论文技术审查、同行评审和结果核验使用，其他用途须事先取得作者书面许可。

已移除联系方式、问卷/受访者标识、精确经纬度和详细地点信息；本地工作目录中的源文件未被修改。

未经作者书面授权，不得独立研究或二次分析、再分发、制作衍生成果、商业使用、用于人工智能/机器学习训练，或尝试重新识别受访者。完整中英文使用声明见包根目录 `DATA_USE_NOTICE_EN_ZH.md`。

---

## 一、 数据收集背景与中文问卷说明

- **调查对象与情境：** 样本来源于 2021年11月30日 至 2022年1月30日 期间中国 9 个受疫情管控影响城市的常住居民。
- **采集平台：** 问卷星和见数平台。
- **中文材料说明：** 本研究针对中国本土情境限制开展实证调研，因此问卷原件及原始 Excel/CSV 表头字段均为简体中文。为便利国际审稿人与编辑部查阅及复现，本复现包提供了完备的中英文变量映射及一键 R 脚本。

---

## 二、 /data/ 目录文件清单

| 文件 / 路径 | 格式 / 样本量 | 说明与手稿对应表 |
|---|---|---|
| `raw/totaldatas.xlsx` | Excel (`N = 1,047`) | Study 1 和 Study 2 的主实证数据（对应 Table 3, 4, 5, 6, 7, 10, 11） |
| `raw/shanghai_data.csv` | CSV (`N = 900`) | 上海时序子样本数据（对应 Table 9） |
| `questionnaire/Credamo+疫情旅游意愿调查.doc` | RTF/DOC | 通过问卷星和见数平台发放的原始中文问卷 |
| `questionnaire/Credamo+疫情旅游意愿调查(1202）.doc` | RTF/DOC | 12月份跟踪调查版本问卷 |
| `DATA_CODEBOOK_EN.docx` | Word (.docx) | 提交编辑部 / 归档使用的英文版 Codebook |
| `DATA_CODEBOOK_ZH.docx` | Word (.docx) | 中文版变量与数据说明手册 |

---

## 三、 变量定义与中英文编码对照表

| 原始表头 / 变量名 | 构念名称 | 题项描述与原题 | 编码与取值规则 |
|---|---|---|---|
| `提交答卷时间` / `time` | 作答时间 | 问卷提交的具体时间 | `YYYY-MM-DD` 日期格式 |
| `first_time` | 限制起始时间 | 当地官方实施管控政策的起始日期 | `YYYY-MM-DD` 日期格式 |
| `period` | 限制持续时间差 | 作答时间与起始时间差：`time - first_time` | 原始连续型天数 |
| `duration_days` | 计入起始日的持续天数 | `period + 1` | 正式划分为 T1 (<=7天), T2 (8-21天), T3 (>21天) |
| `BR1` - `BR5` | 状态无聊感 | CMSBS 低唤醒分量表（5 题） | 5 点李克特量表（1=非常不同意 ~ 5=非常同意） |
| `SE1` - `SE6` | 感觉寻求 | SSS-V 中文简版量表（6 题） | 5 点李克特量表（1=非常不同意 ~ 5=非常同意） |
| `WI1` - `WI3` | 补偿性旅游意愿 | 补偿性旅游意愿量表（3 题） | 5 点李克特量表（1=非常不同意 ~ 5=非常同意） |
| `block` | 小区封控 | 小区是否封控 | 二分变量：`1` = 是，`0`/`2` = 否 |
| `entertain` | 娱乐场所关闭 | 周边娱乐休闲场所是否关闭 | 二分变量：`1` = 是，`0`/`2` = 否 |
| `closed` | 学校/企业封闭 | 学校或工作单位是否封闭管理 | 二分变量：`1` = 是，`0`/`2` = 否 |
| `wfh` | 居家办公/学习 | 是否居家办公或学习 | `1` = 居家办公，`2` = 居家学习，`0`/`3` = 否 |
| `gender` | 性别 | 被试性别 | `1` = 男，`2` = 女 |
| `age` | 年龄 | 被试年龄段 | `1` = 18岁以下, `2` = 18-24岁, `3` = 25-30岁, `4` = 31-40岁, `5` = 41-50岁, `6` = 50岁以上 |
| `education` | 学历 | 最高受教育程度 | `1` = 高中及以下, `2` = 大专, `3` = 本科, `4` = 硕士及以上 |
| `tourtime` | 疫情前旅游频次 | 每年外出旅游频次 | 连续 / 定序（次/年） |

---

## 四、 核心量表题项中英文对照表

| 题项代码 | 构念 | 中文原题项 | 英文对应翻译 |
|---|---|---|---|
| **BR1** | 状态无聊感 | 我觉得无事可做。 | I feel like I have nothing to do. |
| **BR2** | 状态无聊感 | 我觉得时间过得很慢。 | I feel like time is passing very slowly. |
| **BR3** | 状态无聊感 | 我对正在做的事情感到厌倦。 | I feel bored with what I am currently doing. |
| **BR4** | 状态无聊感 | 我渴望有更有趣的事情发生。 | I crave for more interesting things to happen. |
| **BR5** | 状态无聊感 | 我感到无聊和缺乏刺激。 | I feel bored and lack stimulation. |
| **SE1** | 感觉寻求 | 我喜欢尝试新鲜和刺激的事物。 | I like to try new and exciting things. |
| **SE2** | 感觉寻求 | 我喜欢参加未知的冒险活动。 | I enjoy participating in unpredictable adventures. |
| **SE3** | 感觉寻求 | 我愿意去探索未曾涉足的地方。 | I am willing to explore places I have never been. |
| **SE4** | 感觉寻求 | 我喜欢不可预测的生活体验。 | I prefer unpredictable life experiences. |
| **SE5** | 感觉寻求 | 我渴望从日常琐事中解脱出来。 | I yearn to break away from daily routines. |
| **SE6** | 感觉寻求 | 我喜欢体验强烈的感官冲击。 | I enjoy intense sensory sensations. |
| **WI1** | 补偿性旅游意愿 | 限制解除后，我非常渴望外出旅游。 | Once restrictions are lifted, I am eager to travel. |
| **WI2** | 补偿性旅游意愿 | 我计划近期安排一次补偿性旅游。 | I plan to arrange a compensatory trip in the near future. |
| **WI3** | 补偿性旅游意愿 | 旅游是我摆脱当前限制的首要选择。 | Travel is my top choice to overcome current restrictions. |

---

## 五、 一键复现指令

```bash
cd ../code
Rscript run_all.R
```
所有实证分析表格输出将生成于 `../output/` 文件夹。
