# Upload this portfolio to GitHub (Windows + VS Code)

## Before you start

1. Download and extract the ZIP.
2. Open the extracted `data_analyst_portfolio_github_ready` folder and confirm that it contains `README.md`, `docs/`, and `projects/`.
3. If you already have a GitHub repository for this portfolio, use that existing repository folder rather than creating a second nested Git repository.

## Option A — You already cloned your GitHub repository

1. Extract this ZIP to a temporary location.
2. Copy the contents inside `data_analyst_portfolio_github_ready/` into your existing local repository folder. Copy the files and folders inside it, not the outer folder itself, unless you intentionally want that extra folder level.
3. If Windows asks whether to replace files, review the differences first. Keep any newer work you want to preserve.
4. Open the repository root in VS Code.
5. Choose **Terminal → New Terminal**.
6. Run:

   ```bash
   git status
   git diff --check
   ```

7. Review the changed files. Stage the intended files:

   ```bash
   git add README.md GITHUB_SAVE_STEPS.md docs projects
   ```

8. Commit:

   ```bash
   git commit -m "Document benefits analytics Step 1 profiling"
   ```

9. Push to GitHub:

   ```bash
   git push
   ```

10. Refresh your GitHub repository page and check that the Markdown files, SQL scripts, and synthetic CSV files are visible.

## Option B — You have not cloned the repository yet

1. On GitHub, open your repository and select **Code → HTTPS**, then copy the repository URL.
2. In VS Code, open a terminal in the folder where you want to store your projects.
3. Clone the repository:

   ```bash
   git clone YOUR_REPOSITORY_URL
   ```

4. Copy the contents of the extracted ZIP into the newly cloned repository folder.
5. Open that repository folder in VS Code and follow steps 5–10 in Option A.

Replace `YOUR_REPOSITORY_URL` with the real URL copied from GitHub. Do not type the placeholder literally.

## Option C — Upload through the GitHub website

1. Open the target repository on GitHub.
2. Use **Add file → Upload files**.
3. Drag the files and folders from the extracted portfolio into the upload area.
4. Enter a commit message such as `Add benefits analytics profiling project`.
5. Select **Commit changes**.

For a large folder tree, VS Code and Git are usually easier to maintain than repeated browser uploads.

## Common checks

- If `git status` says the folder is not a Git repository, check that you opened the correct repository root.
- If `git push` returns a permission error, confirm that Git is authenticated to the GitHub account that has write access to the target repository.
- If a file contains real employer/client/employee information, passwords, tokens, or connection strings, do not commit it.
- The included CSV data is synthetic. Keep future project data synthetic or properly licensed.

## Suggested next daily-log entry

After pushing, add a dated file under `docs/daily-logs/` describing the profiling tasks completed, findings recorded, and the next Step 2 task.
