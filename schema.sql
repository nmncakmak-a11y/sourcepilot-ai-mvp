-- Optional future Supabase schema. Review policies before production use.
create extension if not exists pgcrypto;

create table if not exists public.search_requests (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references auth.users(id) on delete set null,
  product_need text not null,
  category text,
  destination_country text,
  quantity text,
  target_delivery text,
  created_at timestamptz not null default now()
);

create table if not exists public.suppliers (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  country text,
  category text,
  website_url text,
  description text,
  verification_status text not null default 'unverified'
    check (verification_status in ('unverified','user_checked','independently_verified')),
  created_at timestamptz not null default now()
);

create table if not exists public.supplier_sources (
  id uuid primary key default gen_random_uuid(),
  supplier_id uuid not null references public.suppliers(id) on delete cascade,
  source_url text not null,
  source_title text,
  retrieved_at timestamptz not null default now()
);

create table if not exists public.matches (
  id uuid primary key default gen_random_uuid(),
  request_id uuid not null references public.search_requests(id) on delete cascade,
  supplier_id uuid not null references public.suppliers(id) on delete cascade,
  fit_score numeric check (fit_score >= 0 and fit_score <= 100),
  match_reason text,
  created_at timestamptz not null default now(),
  unique (request_id, supplier_id)
);

create table if not exists public.rfqs (
  id uuid primary key default gen_random_uuid(),
  request_id uuid not null references public.search_requests(id) on delete cascade,
  draft_text text not null,
  status text not null default 'draft'
    check (status in ('draft','approved','sent','cancelled')),
  approved_at timestamptz,
  created_at timestamptz not null default now()
);

create table if not exists public.supplier_responses (
  id uuid primary key default gen_random_uuid(),
  rfq_id uuid not null references public.rfqs(id) on delete cascade,
  supplier_id uuid references public.suppliers(id) on delete set null,
  response_text text,
  quoted_price numeric,
  currency text,
  lead_time text,
  received_at timestamptz,
  created_at timestamptz not null default now()
);

-- Before production: enable RLS on all tables and create least-privilege policies.
-- Do not expose service-role keys in the browser. Ensure users can only access
-- their own requests/RFQs and associated records. Public supplier records need
-- separate moderation and write permissions.
