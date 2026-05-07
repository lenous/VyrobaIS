# VýrobaIS

Systém řízení výroby pro elektronickou výrobu (EMS).

🌐 **Live demo:** https://lenous.github.io/VyrobaIS/

## Přihlašovací údaje

Heslo pro všechny uživatele: `1234`

| Login | Jméno | Role |
|-------|-------|------|
| `jan` / `jan.novak@firma.cz` | Jan Novák | Operátor |
| `tpv` / `petr.dvorak@firma.cz` | Petr Dvořák | TPV |
| `mistr` / `martin.svoboda@firma.cz` | Martin Svoboda | Mistr výroby |
| `vedeni` / `eva.kralova@firma.cz` | Eva Králová | Vedení |
| `admin` / `admin@firma.cz` | IT Admin | Admin – plná práva + nastavení |
| `lucie` / `lucie@firma.cz` | Lucie Bláhová | Operátor automatů |
| `karel` / `karel@firma.cz` | Karel Malý | Operátor balení / výstupní kontrola |

## Funkce

- Tmavý elektronický design (inspirace HC Electronics)
- 6místné číslo zakázky s auto-incrementem (261100+) a vyhledáváním
- Numerická klávesnice pro zadávání počtů kusů (OK / Oprava / Zmetek)
- Validace a automatické omezení součtu vůči vydanému počtu ze skladu
- Sloučená demo data z Expo aplikace: zakázky 260321, 260318, 260315, role a uživatelé
- Program automatu zapisuje operátor automatů, mistr, vedení nebo admin
- Checklist pro automaty obsahuje RTG kontrolu
- Hlášení problémů vedoucímu (viditelné všem, mistr řeší)
- Poznámky k výrobě (umístění, náhrady součástek, změny postupu)
- Role-based přístup, admin panel s nastavením aplikace
- 13 výrobních stanovišť: Sklad, Automat, Montáž THT, Pájení přetavením, AOI, RTG, Pájení vlna, Ruční pájení, Opravy, Programování, Lakování, Výstupní kontrola, Balení

## Spuštění lokálně

```bash
npx serve .
```

Aplikace je single-file HTML – stačí otevřít `index.html` v prohlížeči.
