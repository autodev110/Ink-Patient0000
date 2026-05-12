# Ink: Patient 0000

Ink is a browser-based interactive fiction game built from an Ink story. The player reads short scene text, chooses what to do next, and the game tracks state such as health, ammo, noise, access cards, and discovered information.

## Folder Structure

- `.github/workflows/deploy-pages.yml` deploys the static web version to GitHub Pages.
- `Ink-web/` contains the playable website.
- `Ink-web/index.html` is the page structure for the game UI.
- `Ink-web/style.css` controls the visual design, layout, fonts, and responsive behavior.
- `Ink-web/main.js` connects the compiled Ink story to the browser interface.
- `Ink-web/Untitled.js` contains the compiled story data used by the web game.
- `Ink-web/ink.js` is the Ink runtime used to play the compiled story.
- `Ink-web/fonts/` contains the fonts used by the website.
- `Ink-web/ink_background.png` is the background image used by the game.
- `story.ink` is the original Ink source file for the story.
- `fonts/` and `ink_background.png` are source copies of the web assets.

## Game Summary

Patient 0000 is a horror escape story set inside a failing medical facility. You choose a subject, explore the facility, manage limited resources, and make decisions that change what paths and outcomes become available.

## How The Game Works

Open the web version and choose one of the available subjects to begin. Each turn presents story text and a set of choices. Choices can move you between rooms, reveal information, spend resources, raise danger, unlock routes, or lead to an ending.

The status panel shows the current subject, health, ammo, noise level, and any access cards you have collected. Some choices only appear after finding items, learning information, or changing the facility state. When a route ends, the game records the outcome and lets you restart to try another path.
