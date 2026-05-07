# VýrobaIS

Systém řízení výroby pro elektronickou výrobu (EMS).

🌐 **Live demo:** https://lenous.github.io/VyrobaIS/

## Přihlašovací údaje

Heslo pro všechny uživatele: `1234`

| Login | Jméno | Role |
|-------|-------|------|
| `admin` | Administrátor | Admin – plná práva + nastavení |
| `mistr` | Jan Novák | Mistr výroby |
| `tpv` | Petra Svobodová | TPV |
| `vedeni` | Karel Dvořák | Vedení |
| `op1` | Marie Horáčková | Operátor |
| `op2` | Tomáš Procházka | Operátor |
| `op3` | Jana Kučerová | Operátor |

## Funkce

- Tmavý elektronický design (inspirace HC Electronics)
- 6místné číslo zakázky s auto-incrementem (261100+) a vyhledáváním
- Numerická klávesnice pro zadávání počtů kusů (OK / Oprava / Zmetek)
- Validace součtu vůči vydanému počtu ze skladu
- Hlášení problémů vedoucímu (viditelné všem, mistr/admin řeší)
- Poznámky k výrobě (umístění, náhrady součástek, změny postupu)
- Údaje o zakázce: technologie (OLOVO/BEZOLOVO), typ výroby (Nová / Opakovaná / Revize),
  číslo planžety, dokumenty (BOM, osazovací výkres, GBR pasta, ostatní)
- Autocomplete zákazníků a výrobků z předchozích zakázek
- Správa stanovišť k zakázce – mistr/admin může stanoviště zapínat/vypínat
- Role-based přístup, admin panel s nastavením aplikace
- Admin audit přihlášení: kdo se přihlásil, kdy a z jakého zařízení/prohlížeče
- 9 výrobních stanovišť: Sklad, Automat, AOI, RTG, Montáž THT,
  Pájení vlnou/selektivní, Oprava po pájení, Výstupní kontrola, Balení

## Instalace jako aplikace (PWA)

VýrobaIS je Progressive Web App – funguje offline a dá se nainstalovat jako samostatná aplikace.

- **Android / desktop Chrome / Edge:** ⋮ menu → „Instalovat aplikaci"
- **iOS Safari:** ↑ Sdílet → „Přidat na plochu"

Po instalaci se VýrobaIS spouští v samostatném okně, má vlastní ikonu a běží offline.

## Persistence dat

### Lokální (výchozí)
Data se ukládají do localStorage prohlížeče. Vydrží reload, ale jsou viditelná
**jen v daném prohlížeči / zařízení**.

### Cloud sdílený (Supabase)
Pro sdílení mezi uživateli a zařízeními:

1. Vytvořte si projekt zdarma na [supabase.com](https://supabase.com)
2. V Supabase otevřete **SQL Editor → New query** a vložte obsah souboru
   [`schema.sql`](schema.sql) z tohoto repa, spusťte
3. **Settings → API** → zkopírujte **Project URL** a **anon public key**
4. V aplikaci jděte na **Správa → ☁️ Cloud** (jako admin) a vložte URL a klíč
5. Aplikace se restartuje a v záhlaví uvidíte zelený štítek **„☁️ Cloud"**.
   Změny se synchronizují mezi všemi zařízeními v reálném čase.

## Spuštění lokálně

```bash
npx serve .
```

Aplikace je single-page HTML – stačí otevřít `index.html` v prohlížeči.

## Struktura repa

| Soubor | Účel |
|--------|------|
| `index.html` | Aplikace (HTML + CSS + JS, ~1900 řádků) |
| `manifest.json` | PWA manifest (název, ikony, theme color) |
| `sw.js` | Service worker (offline cache) |
| `icon-192.png`, `icon-512.png` | PWA ikony |
| `schema.sql` | Supabase schema pro cloud sync |
| `README.md` | Tento soubor |
