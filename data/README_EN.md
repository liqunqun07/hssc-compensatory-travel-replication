# Replication Package: Data Guide & Codebook (English)

**Manuscript Title:** *Restriction Intensity, Duration, and Compensatory Travel Intention: A Time-Contingent Test of Boredom and Sensation Seeking*  
**Submitted to:** *Humanities and Social Sciences Communications* (Springer Nature)

**Data collection and screening:** The questionnaires were distributed through Wenjuanxing (问卷星) and Jianshu (见数). Before analysis, responses with excessively short completion times and duplicate submissions were excluded. The files in this upload package are screened, de-identified analysis copies.

**Formal research-data status:** These files support the manuscript “Restriction Intensity, Duration, and Compensatory Travel Intention: A Time-Contingent Test of Boredom and Sensation Seeking” submitted to *Humanities and Social Sciences Communications* (manuscript ID `c184b6df-feca-4378-8b28-ae48e994097`). They are provided for technical review, peer review, and verification of the reported analyses only. Any other use requires prior written permission from the authors.

**Upload-copy privacy note:** Participant contact responses, survey identifiers, exact longitude/latitude, and detailed location metadata were removed. The local source files were not modified.

---

## 1. Survey Context & Language Note for International Reviewers

- **Target Population & Field Setting:** Data were collected from residents in 9 Chinese cities across various COVID-19 restriction levels between **November 30, 2021, and January 30, 2022**.
- **Data Collection Platforms:** Wenjuanxing (问卷星) and Jianshu (见数).
- **Reason for Chinese Survey Instruments & Headers:**  
  Because the empirical investigation examined Chinese residents experiencing real-time pandemic mobility restrictions in mainland China, all primary survey questionnaires and raw platform exports (`.xlsx`, `.csv`, `.doc`) were naturally administered in Simplified Chinese.
- **Bilingual Documentation:**  
  To ensure complete research transparency, analytical integrity, and seamless computational reproducibility, this guide provides complete English variable definitions, item-by-item translations, and code-mapping rules.

- **Use restriction:** No independent or secondary analysis, redistribution, derivative publication, commercial use, AI/machine-learning training, or participant re-identification is permitted without prior written authorization. See the root-level `DATA_USE_NOTICE_EN_ZH.md`.

---

## 2. Directory Layout in `/data/`

| File / Folder | Format / Sample Size | Description & Role in Manuscript |
|---|---|---|
| `raw/totaldatas.xlsx` | Excel (`N = 1,047`) | Primary empirical dataset for Study 1 & Study 2 (Tables 3, 4, 5, 6, 7, 10, 11). |
| `raw/shanghai_data.csv` | CSV (`N = 900`) | Subgroup dataset of Shanghai residents across duration tiers for Table 9. |
| `questionnaire/Credamo+疫情旅游意愿调查.doc` | RTF/DOC | Original Chinese online questionnaire distributed through Wenjuanxing (问卷星) and Jianshu (见数). |
| `questionnaire/Credamo+疫情旅游意愿调查(1202）.doc` | RTF/DOC | Tracking questionnaire version deployed during December 2021. |
| `DATA_CODEBOOK_EN.docx` | Word (.docx) | Formatted English Codebook for editorial / archival submission. |
| `DATA_CODEBOOK_ZH.docx` | Word (.docx) | Formatted Chinese Codebook for author reference. |

---

## 3. Variable Codebook & Mapping

| Raw Header / Variable Code | Construct / Concept | Measurement Description & Original Question | Operationalization / Coding |
|---|---|---|---|
| `提交答卷时间` / `time` | Survey Completion Time | Timestamp when the survey was completed | `YYYY-MM-DD` Date format |
| `first_time` | Restriction Onset Date | Official date when local restrictions were enacted | `YYYY-MM-DD` Date format |
| `period` | Restriction Duration Difference | Computed duration: `time - first_time` | Raw continuous day difference. |
| `duration_days` | Inclusive Restriction Duration | `period + 1`, counting the first day | Manuscript grouping: T1 (<=7d), T2 (8-21d), T3 (>21d). |
| `BR1` - `BR5` | State Boredom | 5 items from Chinese MSBS low-arousal subscale (Liu et al.) | 5-point Likert (1=Strongly disagree to 5=Strongly agree) |
| `SE1` - `SE6` | Sensation Seeking | 6 items from brief Chinese SSS-V scale | 5-point Likert (1=Strongly disagree to 5=Strongly agree) |
| `WI1` - `WI3` | Compensatory Travel Intention | 3 items measuring compensatory travel desire | 5-point Likert (1=Strongly disagree to 5=Strongly agree) |
| `block` | Community Lockdown | Residential compound lockdown (`小区是否封控`) | Binary: `1` = Yes, `0`/`2` = No |
| `entertain` | Entertainment Closure | Leisure & entertainment venues closure (`娱乐场所关闭`) | Binary: `1` = Yes, `0`/`2` = No |
| `closed` | Institutional Closure | Workplace / university closure (`学校/企业封闭管理`) | Binary: `1` = Yes, `0`/`2` = No |
| `wfh` | Home-based Work/Study | Working or studying remotely from home (`居家办公/学习`) | `1` = Work from home, `2` = Study from home, `0`/`3` = No |
| `gender` | Gender | Participant sex (`性别`) | `1` = Male, `2` = Female |
| `age` | Age Bracket | Age category (`年龄`) | `1` = <18, `2` = 18-24, `3` = 25-30, `4` = 31-40, `5` = 41-50, `6` = >50 |
| `education` | Education | Highest educational level (`学历`) | `1` = High school or below, `2` = Junior college, `3` = Bachelor, `4` = Master/PhD |
| `tourtime` | Baseline Travel Frequency | Pre-pandemic annual travel frequency (`年旅游频次`) | Continuous / Ordinal (trips per year) |

---

## 4. Psychometric Items: Chinese & English Wording

| Item Code | Latent Construct | Chinese Item Text (问卷原文) | English Translation (Manuscript) |
|---|---|---|---|
| **BR1** | State Boredom | 我觉得无事可做。 | I feel like I have nothing to do. |
| **BR2** | State Boredom | 我觉得时间过得很慢。 | I feel like time is passing very slowly. |
| **BR3** | State Boredom | 我对正在做的事情感到厌倦。 | I feel bored with what I am currently doing. |
| **BR4** | State Boredom | 我渴望有更有趣的事情发生。 | I crave for more interesting things to happen. |
| **BR5** | State Boredom | 我感到无聊和缺乏刺激。 | I feel bored and lack stimulation. |
| **SE1** | Sensation Seeking | 我喜欢尝试新鲜和刺激的事物。 | I like to try new and exciting things. |
| **SE2** | Sensation Seeking | 我喜欢参加未知的冒险活动。 | I enjoy participating in unpredictable adventures. |
| **SE3** | Sensation Seeking | 我愿意去探索未曾涉足的地方。 | I am willing to explore places I have never been. |
| **SE4** | Sensation Seeking | 我喜欢不可预测的生活体验。 | I prefer unpredictable life experiences. |
| **SE5** | Sensation Seeking | 我渴望从日常琐事中解脱出来。 | I yearn to break away from daily routines. |
| **SE6** | Sensation Seeking | 我喜欢体验强烈的感官冲击。 | I enjoy intense sensory sensations. |
| **WI1** | Travel Intention | 限制解除后，我非常渴望外出旅游。 | Once restrictions are lifted, I am eager to travel. |
| **WI2** | Travel Intention | 我计划近期安排一次补偿性旅游。 | I plan to arrange a compensatory trip in the near future. |
| **WI3** | Travel Intention | 旅游是我摆脱当前限制的首要选择。 | Travel is my top choice to overcome current restrictions. |

---

## 5. Quick Reproduction Guide

All empirical models are automated using standardized R scripts in `../code/`. To replicate the manuscript tables:

```bash
cd ../code
Rscript run_all.R
```
Replication outputs will be automatically written to `../output/` matching the published tables (Tables 3, 4, 5, 6, 7, 9, 10, 11).
