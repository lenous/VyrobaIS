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
-- POZNÁMKA: Statická aplikace do cloudu NEPOSÍLÁ hesla, profily uživatelů
-- ani logy přihlášení. Lokální demo hesla zůstávají jen v prohlížeči
-- v klíči 'vyrobais-creds-v2'. Cloud obsahuje pouze provozní výrobní data.
--
-- Tato jednoduchá varianta stále používá veřejný publishable/anon klíč,
-- takže je vhodná pro interní demo nebo uzavřenou síť. Pro ostrý provoz
-- použijte Supabase Auth nebo vlastní Python/FastAPI backend a role
-- kontrolujte serverově.
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
--   2. Přidat tabulku profiles(user_id uuid references auth.users, role text)
--   3. Změnit RLS na pravidla podle auth.uid() a role z profiles
--   4. Audit logy a citlivé změny zapisovat serverově, ne z klienta.
