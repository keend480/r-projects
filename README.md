# R Projects Portfolio

Collection of data analysis projects showcasing R skills in sports analytics and marketing optimization.

## Projects

### 1. NBA Salary Prediction [NBA_Project-1.R](NBA_Project-1.R)
**Purpose**: Predict NBA player salaries using linear regression and identify "good investments" (high VORP at predicted salary).

**Key Analysis**:
- Loads `nba_new.csv` dataset (upload this CSV to run).
- Correlation matrix (Spearman) via `corrplot`.
- Stepwise regression selects key predictors: REB, VORP, eFG, OR%, TO%, Usage, Age.
- Custom `value_determination()` function categorizes players: Expensive Talent, Good Investment, Over Price, Bench Warmer.
- Visualizes actual vs predicted salary scatterplot with `ggplot2`.
- Identifies top 10 good investments (e.g., Giannis, Luka, Trae under $42M combined).

**To Run**:
```r
# Install packages
install.packages(c("corrplot", "MASS", "dplyr", "ggplot2"))

# Run script (ensure nba_new.csv in same folder)
source("NBA_Project-1.R")
```

**Outputs**: Correlation heatmap, regression summary, player value predictions, salary comparison plot.

### 2. Marketing Dashboard & Forecast [graphsceler-2.R](graphsceler-2.R)
**Purpose**: Analyze October ad spend/installs by campaign/media source; forecast future costs with Prophet.

**Key Analysis**:
- Loads `dataceler.csv` (main data) and `forecastceler.csv` (forecast input).
- Computes CPC (cost per click), date parsing.
- `ggplot2` dashboard: Spend/installs by date, campaign, media source; CPI trends.
- Deep dive on Source_3 (high CPI in Campaign 7).
- Prophet forecast for next 22 days (cost trends/components).

**To Run**:
```r
# Install packages
install.packages(c("MASS", "dplyr", "ggplot2", "forecast", "prophet"))

# Run script (ensure CSVs in same folder)
source("graphsceler-2.R")
```

**Outputs**: Bar/line charts (spend, installs, CPI), Prophet forecast plot, predicted vs actual October spend.

## Setup Instructions
1. Clone repo: `git clone https://github.com/keend480/r-projects.git`
2. Place datasets (`nba_new.csv`, `dataceler.csv`, `forecastceler.csv`) in root folder [file:31][file:32].
3. Open in [RStudio](navigational_search:RStudio), run scripts section-by-section.

## Technologies
- R 4.x
- ggplot2, dplyr, corrplot, MASS, forecast, prophet

## Next Steps
- Add datasets via GitHub upload.
- Render outputs as R Markdown for interactive HTML.
