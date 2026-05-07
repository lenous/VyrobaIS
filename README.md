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
- Hlášení problémů vedoucímu (viditelné všem, mistr řeší)
- Poznámky k výrobě (umístění, náhrady součástek, změny postupu)
- Role-based přístup, admin panel s nastavením aplikace
- 13 výrobních stanovišť: Sklad, Automat, Montáž THT, Pájení přetavením, AOI, RTG, Pájení vlna, Ruční pájení, Opravy, Programování, Lakování, Výstupní kontrola, Balení

## Spuštění lokálně

```bash
npx serve .
```

Aplikace je single-file HTML – stačí otevřít `index.html` v prohlížeči.
