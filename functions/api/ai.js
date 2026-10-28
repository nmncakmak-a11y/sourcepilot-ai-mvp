// Cloudflare Pages Function placeholder.
// This endpoint is intentionally not wired to a provider yet.
// Configure AI_API_KEY as a server-side Pages secret before implementation.
export async function onRequestPost({ request, env }) {
  if (!env.AI_API_KEY) {
    return Response.json(
      { error: "AI integration is not configured yet. The current website is a demo prototype." },
      { status: 501 }
    );
  }

  return Response.json(
    { error: "AI provider adapter is not implemented yet." },
    { status: 501 }
  );
}
