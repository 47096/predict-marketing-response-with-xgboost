# Who will accept the next offer?

**Case study — customer analytics · marketing response · XGBoost**

Marketing teams waste budget contacting customers who will never convert. I built a classifier that flags likely responders **before** the next campaign goes out — so spend goes to the people who say yes.

**Business question:** Of 2,240 customers, who will accept the offer?

**Outcome:** The model catches **95.5% of actual responders**. When it flags someone as likely to convert, it is right **9 times out of 10**. That is a targeting list a marketing lead can use on Monday morning.

---

## What I did

| Step | Why it matters |
|------|----------------|
| Explored messy real data | Income arrived as strings (`"$84,835.00 "`), not numbers |
| Engineered decision-useful features | Tenure, age, child count — not just raw columns |
| Handled severe class imbalance | Only **15%** accepted; blind accuracy would look fine and fail in market |
| Trained XGBoost (tidymodels) | Strong tabular baseline without over-engineering |
| Evaluated for **recall + precision** | The job is finding responders without flooding non-responders |

## Results

| Metric | Score | Read this as |
|--------|-------|----------------|
| **Recall** | **0.955** | We find almost everyone who would accept |
| **Precision** | **0.917** | Flagged names are usually right |
| F1 | 0.936 | Balance of the two |
| AUC | 0.920 | Strong ranking quality |
| Accuracy | 0.889 | Secondary under imbalance |
| Log loss | 0.245 | Well-calibrated probabilities |

**Confusion matrix**

|  | Actual 0 | Actual 1 |
|--|----------|----------|
| Predicted 0 | 365 (TN) | 33 (FN) |
| Predicted 1 | 17 (FP) | 34 (TP) |

**So what:** Contact the predicted-1 list first. Expect ~34 of 51 flagged customers to accept, and only 17 wasted touches. Miss 33 who would have accepted if you emailed everyone — that is the trade-off you choose on purpose.

## What this means for retention & campaign budget

- **Past campaign acceptance** is the strongest behavioural signal — suppress chronic non-responders and stop paying to reach them.
- **Household and tenure features add lift** over spend-only models — demographics alone are not enough.
- **Precision at the top of the list is the lever.** You do not need everyone; you need the names most likely to say yes.

## Who this is for

Marketing, CRM, and growth leads who want a **ranked call list**, not another dashboard.

## Work with me

I help businesses turn customer data into targeting and retention decisions — same method on your data.

**[Talk to me →](https://datafying.co/#contactus)** · Founder at [datafying](https://datafying.co/)

---

## Reproduce

```bash
git clone https://github.com/47096/campaign-response.git
cd campaign-response
```

```r
source("setup.R")     # installs dependencies
source("analysis.R")  # full pipeline
```

### Data

[Marketing Analytics on Kaggle](https://www.kaggle.com/jackdaoud/marketing-data) — 2,240 customers, 28 features (demographics, household, spend by category, channel purchases, past campaigns).

Target: `Response` (accepted the offer).

### Method in one line

Explore → clean Income/tenure/age → stratified 80/20 split → XGBoost via tidymodels → confusion matrix, precision/recall/F1/AUC.

### Stack

`tidymodels` · `xgboost` · `vip` · `naniar` · `corrplot` · `lubridate` · `stringr`

---

*Part of [datafying](https://datafying.co/) customer analytics work — [more case studies on GitHub](https://github.com/47096?tab=repositories).*
