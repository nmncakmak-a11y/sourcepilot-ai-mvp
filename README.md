# SourcePilot AI MVP

An English-first prototype for AI-assisted B2B supplier discovery and request-for-quotation (RFQ) drafting.

## Current status
- Responsive single-page prototype.
- Request form and illustrative sample shortlist.
- RFQ draft generator with copy and text-download actions.
- **Not yet connected** to live supplier search, an AI API, user accounts, a database, or email sending.
- Supplier names and example.com URLs are placeholders, not verified suppliers.

## Run locally
Open `index.html` in a modern browser.

## Deploy free with Cloudflare Pages
1. Import this GitHub repository in Cloudflare Pages.
2. Use the repository root as the project directory.
3. No build command is needed; leave the build output directory as `/` or the root directory according to the dashboard prompt.
4. Deploy the static prototype.

## Next development steps
1. Add server-side AI integration and keep API keys in server environment variables.
2. Add live supplier search with citations/source URLs and timestamps.
3. Add authentication and database policies before storing buyer requests.
4. Add consent-based RFQ delivery only after buyer review and approval.

Do not put secrets in client-side JavaScript. Verify suppliers independently before relying on them.
