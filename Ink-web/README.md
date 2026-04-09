# Ink-web Hosting

This folder is a plain static Ink web app. It is ready to deploy directly without a build step.

## GitHub Pages

This repo includes a GitHub Pages workflow at:

- `.github/workflows/deploy-pages.yml`

What to do:

1. Push this repo to GitHub.
2. In GitHub, open `Settings` -> `Pages`.
3. Set `Source` to `GitHub Actions`.
4. Push to `main` to deploy.

Notes:

- The workflow publishes the `Ink-web/` folder as-is.
- If your default branch is not `main`, update the branch name in the workflow.
- `.nojekyll` is included so Pages serves the folder as a raw static site.

## Vercel

This folder also includes:

- `vercel.json`

Recommended Vercel setup:

1. Import the GitHub repo into Vercel.
2. Set the project `Root Directory` to `Ink-web`.
3. Use `Other` / `No Framework`.
4. Leave `Build Command` empty.
5. Leave `Output Directory` empty.

## Updating The Story

The site currently loads:

- `ink.js`
- `Untitled.js`
- `main.js`

`Untitled.js` is the compiled story data file. If you update the source Ink story, re-export or recompile the story JSON/JS and replace `Untitled.js` before deploying.

## Runtime Notes

- Save/theme state is namespaced by page path so GitHub Pages project sites do not overwrite each other in `localStorage`.
- Asset paths are relative, so the site works from a GitHub Pages project subpath such as `/repo-name/`.
