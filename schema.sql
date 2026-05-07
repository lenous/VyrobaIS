-- ════════════════════════════════════════════════════
-- VýrobaIS – Supabase schema
-- Spusťte v SQL editoru (Supabase → SQL Editor → New query)
-- ════════════════════════════════════════════════════

-- Tabulka pro stav celé aplikace (jednoduchý JSONB blob)
-- Pro malou dílnu (max desítky uživatelů) postačí.
create table if not exists public.app_state (
  id          text primary key,
  data        jsonb not null,
  updated_at  timestamptz not null default now()
);

-- RLS: zatím povolíme čtení/zápis komukoliv s anon klíčem.
-- V produkci doporučujeme zapnout autentizaci a uzamknout RLS na auth.uid().
alter table public.app_state enable row level security;

drop policy if exists "anon read"  on public.app_state;
drop policy if exists "anon write" on public.app_state;

create policy "anon read"  on public.app_state for select using (true);
create policy "anon write" on public.app_state for insert with check (true);
create policy "anon update" on public.app_state for update using (true) with check (true);

-- Realtime: zapnout pro tabulku, aby se klienti automaticky synchronizovali
alter publication supabase_realtime add table public.app_state;
