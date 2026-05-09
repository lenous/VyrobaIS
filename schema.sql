-- ════════════════════════════════════════════════════
-- VýrobaIS – Supabase schema (zabezpečená verze)
-- Spusťte v SQL editoru (Supabase → SQL Editor → New query)
-- ════════════════════════════════════════════════════

-- Tabulka pro stav celé aplikace (jednoduchý JSONB blob)
-- Pro malou dílnu (max desítky uživatelů) postačí.
create table if not exists public.app_state (
  id          text primary key,
  data        jsonb not null,
  updated_at  timestamptz not null default now()
);

-- ── RLS POLITIKY ──────────────────────────────────────
-- Přístup omezen pouze na řádek 'main' (žádné jiné řádky nelze vytvořit/číst).
-- POZNÁMKA: Hesla uživatelů se do cloudu NEUKLÁDAJÍ – zůstávají pouze lokálně
-- v prohlížeči v klíči 'vyrobais-creds-v2'. Cloud obsahuje pouze provozní data.
-- ──────────────────────────────────────────────────────
alter table public.app_state enable row level security;

drop policy if exists "anon read"   on public.app_state;
drop policy if exists "anon write"  on public.app_state;
drop policy if exists "anon update" on public.app_state;
drop policy if exists "app read"    on public.app_state;
drop policy if exists "app write"   on public.app_state;
drop policy if exists "app update"  on public.app_state;

-- Čtení: pouze řádek 'main'
create policy "app read" on public.app_state
  for select using (id = 'main');

-- Vkládání: pouze řádek 'main'
create policy "app write" on public.app_state
  for insert with check (id = 'main');

-- Aktualizace: pouze řádek 'main'
create policy "app update" on public.app_state
  for update using (id = 'main') with check (id = 'main');

-- ── REALTIME ──────────────────────────────────────────
-- Klienti se automaticky synchronizují při změně.
alter publication supabase_realtime add table public.app_state;

-- ── DOPORUČENÍ PRO PRODUKCI ───────────────────────────
-- Pro vyšší bezpečnost lze přidat Supabase Auth:
--   1. V Supabase zapnout Authentication → Email provider
--   2. Vytvořit sdílený servisní účet (app-service@firma.cz)
--   3. Změnit RLS na: using (auth.uid() IS NOT NULL)
--   4. Aplikace se přihlásí k Supabase tímto servisním účtem
--      a teprve pak může číst/zapisovat data.
