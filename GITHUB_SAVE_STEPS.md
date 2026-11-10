# Safely update this GitHub repository

This project package is intended to merge into the existing `Data-Analyst-Portfolio` repository root. Do not create a nested Git repository or replace the repository's raw data.

## Before copying files

1. Work from the existing repository checkout and run `git status --short --branch`.
2. Save or commit any local changes before merging the package.
3. Extract the ZIP to a temporary folder and copy its contents into the repository root, merging folders as needed.
4. If a destination file already exists, compare both versions and preserve the repository copy unless you have reviewed and intentionally merged the changes. Keep all existing raw source files unchanged.

## Review and publish

1. Fetch the remote and inspect recent history with `git fetch origin` and `git log --oneline --graph --decorate --all -10`.
2. Confirm the intended branch and that the working tree contains only the reviewed package changes.
3. Review `git status`, inspect the changes with `git diff --` and check whitespace with `git diff --check`.
4. Stage only the intended files, then inspect `git diff --cached` before committing.
5. Commit with a concise message such as `Add Data Analyst Project 1 portfolio materials`.
6. Push to the matching remote branch and verify the commit and files on GitHub.

If a push is rejected, fetch and inspect the new remote commits before proceeding. Do not force-push or reset away existing history. Stop to resolve any conflict that cannot be merged while preserving both the current work and the package content.

## Data and deliverable notes

- Preserve the existing raw synthetic CSV files in `projects/01-health-welfare-benefits-analytics/data/raw/`.
- The package includes aggregate findings reported during the project, but no row-level SQL result exports. Re-run the queries to produce reproducible record-level outputs.
- The `powerbi/` directory contains report specifications and build guidance, not a completed Power BI `.pbix` or real dashboard screenshots.
- Do not publish real personal or employer-confidential data, credentials, passwords, or connection strings.
