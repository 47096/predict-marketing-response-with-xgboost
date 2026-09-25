# Who will accept the next offer?

**A marketing budget problem, solved with customer data.**

You already know the pain: the campaign goes out to everyone, most people ignore it, and you cannot tell which half of the budget worked. I help marketing teams stop paying to contact people who will never say yes — and start the week with a **ranked list of who will**.

---

## The stake

Every send has a cost — discount, channel fee, brand fatigue, team time. If only **15%** of customers accept an offer, untargeted outreach means **~85% of that spend buys silence**. The fix is not “more data.” It is **knowing who is actually in play**.

## The story

A team has 2,240 customers and one question: *who should get the next offer?*

They have demographics, spend, channel behaviour, and past campaign history. No clean model. No shared view of “likely to accept.”

I took that from messy warehouse tables to a **targeting list a marketing lead can act on** — without waiting for a six-month data platform.

**Outcome on this build:**
- Model finds **95.5% of the customers who would accept**
- When it flags someone, it is right **~9 times out of 10**
- A marketing lead can call / email **the top of the list first** and stop wasting touches

> **The commercial idea:** contact fewer people, convert more of them. Same offer. Better list.

---

## What that looks like in your world

This is the same playbook I run with marketing, CRM, and growth teams:

| You have | I turn it into |
|----------|----------------|
| Campaign history and customer tables | A **score** per customer (“likely to accept”) |
| A budget and a send date | A **ranked list** sized to your budget |
| “Half the spend feels wasted” | A clear **suppress vs pursue** rule |
| Dashboard noise | A decision: **who gets the offer on Monday** |

**Typical engagement shape:** we define one campaign job (response, churn, upsell) → I build on your data → you leave with a list, the rules to run it, and a way to measure lift next quarter.

**[Talk to me about a campaign →](https://datafying.co/#contactus)** · [datafying](https://datafying.co/)

---

## Why marketing leaders bring me in

- I speak **offer, list, and budget** — not only AUC and gradients
- I size the model to the decision (no science project)
- I show the **trade-off you are choosing** (miss some responders vs waste touches) so you own the call
- Technical work is reproducible and handed over — not locked in a black box

---

## Proof of craft *(technical — keep us honest)*

### Business question
Of 2,240 customers (28 features), who will accept the offer (`Response = 1`)?

### What I did
| Step | Why it matters commercially |
|------|-----------------------------|
| Explored messy real data | Income arrived as `"$84,835.00 "` — dirty fields kill trust in the list |
| Engineered decision-useful features | Tenure, age, household — signals a marketer can explain to a stakeholder |
| Handled class imbalance | Only **15%** accepted; naive accuracy would look fine and fail in market |
| Trained XGBoost (tidymodels) | Strong tabular baseline — fast enough for campaign cycles |
| Evaluated **recall + precision** | The job is finding responders without flooding non-responders |

### Results
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

**So what for the budget holder:** Contact predicted-1 first. On this holdout: **~34 of 51** flagged would accept; **17** wasted touches; **33** responders only found if you also contact everyone else. You choose the cut-off by campaign budget — I make that trade-off visible.

### Behavioural signals that moved the needle
- **Past campaign acceptance** is the strongest predictor — suppress chronic non-responders
- **Household + tenure** add lift over spend-only views
- **Top-of-list precision is the lever** — you need the right names, not every name

### Example (what the list is for)
| Customer | Score | Why they are on the list |
|----------|-------|---------------------------|
| #1842 | 0.91 | Accepted previous offer · high tenure · active buyer |
| #2201 | 0.84 | Recent spend · opened past campaigns |
| #1904 | 0.79 | Mid-tenure · category match for this offer |

*(Illustrative pattern — real exports run at your list size.)*

### How this ships into a campaign
1. Score all customers (batch, on a schedule or pre-campaign)
2. Export **ranked CSV** to your ESP / CRM (Braze, Salesforce, HubSpot, …)
3. Suppress bottom scores; size the send to budget
4. Keep a **holdout** so next quarter you can prove lift, not just assert it

### Limits (honesty)
- Cold-start customers need rules until they generate history
- Scores drift as behaviour changes — retrain on a campaign cadence
- Use only data you have consent and a lawful basis to use

---

## Reproduce the build

```bash
git clone https://github.com/47096/campaign-response.git
cd campaign-response
```

```r
source("setup.R")     # installs dependencies
source("analysis.R")  # full pipeline
```

**Data:** [Marketing Analytics on Kaggle](https://www.kaggle.com/jackdaoud/marketing-data) — 2,240 customers, 28 features. Target: `Response`.

**Method in one line:** Explore → clean Income/tenure/age → stratified 80/20 split → XGBoost via tidymodels → precision/recall/F1/AUC + confusion matrix.

**Stack:** `tidymodels` · `xgboost` · `vip` · `naniar` · `corrplot` · `lubridate` · `stringr`

---

## Next step

If you have a campaign in the next 30 days and cannot say who should get it, that is exactly the engagement I do.

**[Book a conversation →](https://datafying.co/#contactus)** · Customer analytics for marketing teams · [datafying](https://datafying.co/)
