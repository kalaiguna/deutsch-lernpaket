# Notion Database Setup (Optional)

By default the skills save each session as a child **page** inside your "Deutsch lernen B2"
Notion page. That is enough to use this repo — you do not need a database.

If you want a proper Notion **database** (table view, calendar view, date filters, faster
querying), follow the steps below. The dashboard will switch to `notion_query_database`
automatically once you set `NOTION_DB_ID`.

---

## Why bother?

| Feature | Page mode (default) | Database mode (optional) |
|---------|---------------------|--------------------------|
| Session storage | Child pages under "Deutsch lernen B2" | Rows in a Notion database |
| Android view | List of pages | Table or Calendar view |
| Dashboard live load | `notion_search` by title prefix | `notion_query_database` with date filter |
| Filtering by type/date | Not possible in Notion UI | Built-in |
| Setup required | None | ~10 minutes (steps below) |

---

## Step 1 — Create the Notion database

1. Open Notion on any device or the web app.
2. Inside your **"Deutsch lernen B2"** page, click the **"+"** to add a new block.
3. Type `/database` and choose **"Database — Inline"** (or "Full page" if you prefer).
4. Name it **"Deutsch B2 Sitzungen"**.

---

## Step 2 — Add the required properties

Delete the default properties Notion creates and add these instead:

| Property name | Type | Notes |
|---|---|---|
| **Name** | Title | Auto-created. Keep it. |
| **Date** | Date | Session date (YYYY-MM-DD). |
| **Type** | Select | Options: Konversation, Quiz, Hören, Schreiben, Lektüre, Grammatik, Monatsrückblick |
| **Theme** | Text | Session theme or task type. |
| **Word Count** | Number | Words written by learner (conversation/writing sessions). |
| **Mistake Count** | Number | Total mistakes corrected in the session. |
| **Score** | Text | Free-form score string, e.g. "8/10" or "Hörverstehen: 5/6". |
| **Source URL** | URL | Audio/article link (Sunday and Lektüre sessions). |

To add a property: click **"+"** at the right edge of the column headers inside the database.

---

## Step 3 — Get your database ID

1. Open the database as a full page (click the "⤢ open full page" icon at the top-right of
   the inline database, or open it directly).
2. Look at the browser URL. It will look like:

   ```
   https://www.notion.so/YourWorkspaceName/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx?v=...
   ```

3. The **32-character hex string** between the last `/` and the `?v=` is your database ID.
   Example: `a1b2c3d4e5f6a1b2c3d4e5f6a1b2c3d4`

4. Format it with hyphens (Notion accepts both, but the MCP connector may need the hyphenated
   form): `a1b2c3d4-e5f6-a1b2-c3d4-e5f6a1b2c3d4`

---

## Step 4 — Set NOTION_DB_ID in the dashboard

Open `core/dashboard/dashboard.html` in a text editor and find line 112:

```js
const NOTION_DB_ID = null;
```

Replace `null` with your database ID as a quoted string:

```js
const NOTION_DB_ID = "a1b2c3d4-e5f6-a1b2-c3d4-e5f6a1b2c3d4";
```

Save the file. The next time you click **"Try live again"** in the dashboard, it will call
`notion_query_database` instead of `notion_search`.

---

## Step 5 — How sessions are saved in database mode

Each skill has an **OPTIONAL DATABASE MODE** note at the bottom of its SKILL.md. When that
note is in effect, at the end of each session Claude will:

1. Save the full Notion page (with JSON code block + rich content) as a child of
   "Deutsch lernen B2" — exactly as before. **This page is still the primary data source.**
2. Also create a lightweight database row with the typed properties from Step 2.

The dashboard's `tryLiveLoad()` uses the database row for live load (faster, more reliable),
but falls back to the JSON code blocks in the child pages if more detail is needed.

---

## What happens to existing session pages?

Nothing. Existing child pages under "Deutsch lernen B2" are unaffected. The database mode
only adds new rows going forward — it does not migrate old pages.

If you want old sessions in the database too, ask Claude:

> "Read all Deutsch B2 Konversation and Übersetzung pages under Deutsch lernen B2 and create
> a database row in Deutsch B2 Sitzungen for each one."

---

## Troubleshooting

**"notion_query_database" returns an error:**
- Check that the database ID in the dashboard matches the one in the Notion URL exactly.
- Make sure the Notion MCP connector has permission to read databases (not just pages).
  In Claude Code: Settings → Integrations → Notion → check "Read databases".

**Database mode live load returns 0 sessions:**
- The database may be empty. Only sessions saved after setting up database mode will appear
  as rows. Old page-mode sessions are not automatically included.

**Dashboard still shows snapshot data after setting NOTION_DB_ID:**
- Open `core/dashboard/dashboard.html` in the browser, click **"Try live again"**.
- The live load only runs when that button is clicked; it does not auto-run on page load.
