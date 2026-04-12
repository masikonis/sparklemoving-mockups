# Working with the designer

This repo holds static HTML/CSS mockups for the **Sparkle Moving** marketing site (a residential moving service). The mockups are a design artifact — they'll later be translated into the real production site.

The person you're collaborating with in this repo is a **designer, not a developer**. This is likely their first time using Claude Code. Keep that front of mind.

## How to talk to them

- Plain English. No jargon. If you must use a technical term, explain it in one short sentence.
- Describe changes in terms of what they'll **see on the page**, not what's happening in the code.
- Never show long code blocks unless they ask. Summarize what you changed visually: *"I made the hero heading bigger and added more space under it."*
- If something's ambiguous, ask. Don't guess at what they meant.
- They may describe things the way a designer would ("make this feel lighter", "more breathing room", "less aggressive"). Translate that into CSS; don't ask them to be more technical.

## The structure (keep it this way)

```
index.html                    ← homepage
<other-page>.html             ← more pages go at the root, one file per page
styles/
  common.css                  ← site-wide tokens: colors, fonts, base spacing
  components/                 ← things reused across pages (header, footer, buttons…)
  pages/<page-name>/          ← styles specific to one page, split by section
images/
```

**Rules:**
- One HTML file per page, at the root.
- Styles for something reused on multiple pages → `styles/components/`.
- Styles for a single page's section → `styles/pages/<page>/<section>.css`.
- New page → create `<page>.html` and a matching `styles/pages/<page>/` folder.
- Don't put everything in `common.css`. Only truly shared tokens/resets live there.

## Useful skill: `/frontend-design`

Claude Code ships with a skill called **`/frontend-design:frontend-design`** that is great for this project. It helps produce polished, distinctive frontend work and avoids generic-looking output. Suggest it to the designer when they:

- Ask for a new page or section from scratch.
- Want a section to feel more "designed" or less generic.
- Are iterating on visual quality (typography, layout, spacing, hierarchy).

They can invoke it by typing `/frontend-design:frontend-design` in the Claude Code prompt, or just ask in plain language and you can route the work through the skill.

## Working in small steps

Small steps beat big ones. Always.

- Make **one visible change at a time** — adjust spacing, then preview, then move on. Don't batch five unrelated tweaks.
- After each change, reload the browser and check it looks right before continuing.
- If the designer asks for several things at once, do them one by one and confirm each, not all in one go.
- If something breaks or looks wrong, stop and fix it before adding more changes on top.

Small steps make it easy to see what caused what, and easy to undo if needed.

## Previewing changes

The designer needs to see changes in a browser to judge them. From the `design/mockups` folder, run:

```
open index.html
```

You can run this yourself, or tell the designer to run it — either works. After any change, the designer must **reload the browser tab** to see it (you can't reload it for them). Always preview before committing. If something looks off, fix it first.

## Starting a new page

Right now there's only `index.html` (the homepage). When the designer wants a new page — say, an **About** page — here's the flow. Walk them through it; don't just do it silently.

### 1. Create the HTML file at the root

Every page is its own `.html` file at the top level. For About, that's `about.html`.

### 2. Reuse what already exists

Most pages share the **header** and **footer**, and all pages use **common.css** (colors, fonts, base styles). So the new file should pull those in exactly like `index.html` does:

```html
<link rel="stylesheet" href="styles/common.css">
<link rel="stylesheet" href="styles/components/header.css">
<!-- page-specific styles go here -->
<link rel="stylesheet" href="styles/components/footer.css">
```

Then **copy the `<header>` and `<footer>` markup** from `index.html` into the new page. Same HTML, same CSS → it looks identical and stays consistent across the site.

> **Rule of thumb:** if something appears on more than one page (header, footer, a button style, a card layout), it belongs in `styles/components/` and its markup gets copied between pages. If it's unique to one page, it goes in `styles/pages/<page-name>/`.

### 3. Add page-specific styles

For About-only sections, create a folder: `styles/pages/about/`. Make one CSS file per section, just like the homepage does (`hero.css`, `services.css`, etc.). Link them in the new HTML file between the header and footer styles.

Example `about.html` head:

```html
<link rel="stylesheet" href="styles/common.css">
<link rel="stylesheet" href="styles/components/header.css">
<link rel="stylesheet" href="styles/pages/about/intro.css">
<link rel="stylesheet" href="styles/pages/about/team.css">
<link rel="stylesheet" href="styles/components/footer.css">
```

### 4. Spotting reusable pieces

If while building a new page you notice a style or block that's **the same as something on another page**, stop and promote it:

- Move the CSS into `styles/components/<name>.css`.
- Link that new component file from both pages.
- Use the same HTML markup on both.

Don't copy-paste the CSS into two page folders — that's how things drift out of sync. Components exist so one change updates everywhere.

### 5. Good first commit for a new page

Once the new page loads in the browser with header + footer looking right (even if the middle is empty), **commit**. That's the "skeleton works" checkpoint. Then build the page section by section, committing as each section lands.

## Committing (saving progress)

Git is how we save snapshots of the work. When the designer reaches something they might want to come back to, **remind them to commit** — don't wait for them to ask.

**Good moments to suggest a commit:**
- A section looks the way they wanted.
- A whole page is done or in a good intermediate state.
- Before trying something experimental (so they can roll back if it doesn't work).
- End of a work session.

**How to prompt them:** *"This looks like a good checkpoint — want me to save it? I'll commit with a message like 'Tighten hero spacing and update CTA color'."*

When they agree, commit with a short, plain-English message that describes the **visible change**, not the code. Examples:
- ✅ `Tighten hero spacing and update CTA color`
- ✅ `Add service area map section`
- ❌ `Update CSS` (too vague)
- ❌ `Refactor hero.css flex layout` (too technical)

This repo has its own remote (`sparklemoving-mockups`). **Push often** — every commit that's worth keeping should get pushed to GitHub the same session. That way:

- The work is backed up (laptop dies, no work lost).
- Anything can be rolled back to a prior commit if an experiment goes sideways.
- The designer can always get back to a known-good state.

After committing, offer to push: *"Want me to push this to GitHub too?"* Default to yes unless they say otherwise.

## Rolling back when something breaks

The whole point of committing often is to make mistakes cheap. When the designer wants to undo, they'll ask in plain English: *"go back to before the pricing changes"*, *"undo the last thing"*, *"I liked the header from yesterday better"*.

- Use `git log --oneline` to find the right commit.
- For the most recent commit: `git revert HEAD` (keeps history clean, safe default).
- For going back several commits, or discarding uncommitted work: confirm with the designer first, then use `git reset --hard <commit>` (destructive — make sure pushed work isn't lost).
- If in doubt, ask: *"Want me to undo just the last change, or go all the way back to [earlier state]?"*

Explain the result in visual terms (*"I've restored the hero back to the version from this morning — the big heading is back"*), not in git terms. The designer doesn't need to know what revert vs. reset means.

## If they get stuck

Encourage them to describe **what they see vs. what they want**. That's always enough to go on — they don't need to know the code. Example: *"The buttons in the header feel too close together"* is a perfectly good brief.

## What not to do

- Don't reorganize files, rename things, or "clean up" code unless asked.
- Don't add new tools, frameworks, or build steps. This is plain HTML + CSS on purpose.
- Don't make invisible changes (refactors, reformatting) — every commit should correspond to something the designer can see.
- Don't pile up changes. Small, visible, committed steps are better than one big one.
