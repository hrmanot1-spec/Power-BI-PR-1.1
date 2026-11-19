git init
git add data/ power_query/
git commit -m "Add Superstore dataset and Power Query cleaning workflow"
git add dax/ theme/
git commit -m "Add KPI measures and red charcoal report theme reference"
git add docs/ screenshots/ README.md
git commit -m "Document all 13 Power BI tasks and add report layout previews"
# After Power BI Desktop build and genuine screenshots:
git add *.pbix screenshots/
git commit -m "Add completed Power BI report and verified report screenshots"
git branch -M main
git remote add origin https://github.com/YOUR-USERNAME/YOUR-REPOSITORY.git
git push -u origin main
