# Working with the designer

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

## Previewing changes

To see the page in a browser, run this in the terminal from the `design/mockups` folder:

```
open index.html
```

Always preview before committing. If something looks off, fix it first.

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

This repo has its own remote (`sparklemoving-mockups`). After committing, offer to push so the work is backed up: *"Want me to push this to GitHub too?"*

## If they get stuck

Encourage them to describe **what they see vs. what they want**. That's always enough to go on — they don't need to know the code. Example: *"The buttons in the header feel too close together"* is a perfectly good brief.

## What not to do

- Don't reorganize files, rename things, or "clean up" code unless asked.
- Don't add new tools, frameworks, or build steps. This is plain HTML + CSS on purpose.
- Don't make invisible changes (refactors, reformatting) — every commit should correspond to something the designer can see.
- Don't pile up changes. Small, visible, committed steps are better than one big one.
