# MathPet — landing site

Лендинг + Privacy Policy + Terms of Use для MathPet, на 5 языках (EN/ES/FR/DE/RU).

**Стек:** чистый HTML + embedded CSS, без сборщиков, без JS-фреймворков.
**Хостинг:** Cloudflare Pages (бесплатный план, домен уже на Cloudflare → 1-click deploy).
**Домен:** `mathpet.app` (зарегистрирован на Cloudflare).
**Email:** `support@mathpet.app` через Cloudflare Email Routing → пересылка на твой Gmail (бесплатно).

## Структура

```
landing-site/
├── index.html               # EN landing (default)
├── privacy.html             # EN Privacy Policy
├── terms.html               # EN Terms of Use
├── es/                      # Spanish (Español)
│   ├── index.html, privacy.html, terms.html
├── fr/                      # French (Français)
│   ├── index.html, privacy.html, terms.html
├── de/                      # German (Deutsch)
│   ├── index.html, privacy.html, terms.html
├── ru/                      # Russian (Русский)
│   ├── index.html, privacy.html, terms.html
├── favicon.svg
├── _redirects               # Cloudflare Pages: редиректы
├── _headers                 # Cloudflare Pages: security headers
├── setup.sh
├── STORE_PRIVACY_FORMS.md   # Apple/Google privacy form answers
├── STORE_LISTING.md         # App Store + Google Play copy (EN)
└── README.md                # этот файл
```

5 языков совпадают со списком в Flutter-приложении (см. `lib/l10n/app_*.arb`).

## Деплой через Cloudflare Pages (~10 минут)

### Шаг 1. Локальный git + первый коммит

```bash
cd "/Users/georgepirkulov/Documents/Claude/Projects/MathPet/landing-site"
chmod +x setup.sh
./setup.sh
```

(Скрипт делает: `rm -rf .git` → `git init` → `git add .` → `git commit`.)

### Шаг 2. Создать репо на GitHub и запушить

1. https://github.com/new
   - Owner: `gpirkulov-collab`
   - Name: `mathpet-site`
   - Public/Private — оба работают
   - Без README/.gitignore/license — оставить пустым
2. В Terminal:
   ```bash
   git remote add origin https://github.com/gpirkulov-collab/mathpet-site.git
   git push -u origin main
   ```

### Шаг 3. Создать Cloudflare Pages проект

1. Cloudflare Dashboard → раздел **Workers & Pages** → **Create** → вкладка **Pages** → **Connect to Git**.
2. Авторизуйся через GitHub (если не подключён) → выбери репо `mathpet-site`.
3. Build settings:
   - **Framework preset:** None (статика)
   - **Build command:** оставить пустым
   - **Build output directory:** оставить пустым (или `/` — корень)
   - **Root directory:** `/`
4. **Save and Deploy** → через ~30 секунд получишь URL вида `mathpet-site.pages.dev`.

### Шаг 4. Привязать домен `mathpet.app`

В Cloudflare Pages-проекте:
1. **Custom domains** → **Set up a custom domain** → введи `mathpet.app`.
2. Cloudflare видит что домен уже на твоём аккаунте → автоматически добавит DNS-запись и привяжет SSL.
3. Опционально: добавь `www.mathpet.app` если хочешь чтобы и www-вариант работал.

Через 1–2 минуты:
- https://mathpet.app — главная (EN)
- https://mathpet.app/privacy — Privacy Policy
- https://mathpet.app/terms — Terms
- https://mathpet.app/ru/ — RU лендинг
- https://mathpet.app/ru/privacy — RU Privacy

### Шаг 5. Email на домене через Cloudflare Email Routing

В Cloudflare Dashboard → mathpet.app → **Email** → **Email Routing**:
1. **Get started** → Cloudflare добавит MX-записи автоматически.
2. **Routing rules** → **Create address**:
   - Custom address: `support`
   - Action: **Send to email**
   - Destination: `gpirkulov@gmail.com`
3. Cloudflare пришлёт verify-письмо на твой Gmail — подтверди.
4. Готово. Письма на `support@mathpet.app` падают тебе в Gmail.

Опционально — catch-all чтобы любые `*@mathpet.app` шли тебе:
- Routing rules → **Catch-all address** → Send to → `gpirkulov@gmail.com`. Полезно если кто-то напишет на `info@`, `hello@` и т.д.

**Отправка** с `support@mathpet.app`: Email Routing только принимает входящие. Если нужно слать ответы с этого адреса — настрой в Gmail "Settings → Accounts → Send mail as → Add another email address". Через SMTP-relay (платный Gmail Workspace) или free Resend/Mailgun/Brevo (free tier 100 писем/день). Для саппорта инди-апа на старте можно отвечать обычным Gmail с подписью «MathPet Support».

## URLs для App Store / Google Play

При сабмите подставляй:

| Поле | EN | RU |
|---|---|---|
| Privacy Policy URL | `https://mathpet.app/privacy` | `https://mathpet.app/ru/privacy` |
| Terms of Use URL | `https://mathpet.app/terms` | `https://mathpet.app/ru/terms` |
| Support URL | `https://mathpet.app/` | `https://mathpet.app/ru/` |
| Marketing URL (App Store, optional) | `https://mathpet.app/` | — |
| Support email | `support@mathpet.app` | `support@mathpet.app` |

ES/FR/DE — заменить `/ru/` на `/es/`, `/fr/`, `/de/` соответственно.

## Заменить плейсхолдеры скриншотов

В `index.html` (и в каждом языковом подкаталоге) есть четыре блока `<div class="phone-mock">Screenshot 1</div>`. Когда будут реальные скриншоты:

1. Создай `landing-site/screenshots/` и положи туда `01.png` … `04.png`.
2. Замени блоки во всех `index.html`:
   ```html
   <img src="/screenshots/01.png" alt="Math session" class="phone-mock">
   ```
3. Стиль `.phone-mock` придётся обновить (убрать `display:flex`, `align-items: center` для текста).

## Сменить favicon на иконку приложения

Сейчас `favicon.svg` — emoji-дракончик. Когда будет 1024×1024 иконка приложения:

1. https://realfavicongenerator.net (бесплатно) → загрузи иконку → скачай pack.
2. Положи в `landing-site/`.
3. В `<head>` всех HTML добавь:
   ```html
   <link rel="icon" type="image/png" sizes="32x32" href="/favicon-32x32.png">
   <link rel="apple-touch-icon" sizes="180x180" href="/apple-touch-icon.png">
   ```

## Юридический дисклеймер

Privacy Policy и Terms написаны на основе COPPA, GDPR, требований Apple/Google и стандартных практик инди-разработчиков. **Я не юрист.** Документы покрывают типовые риски для MVP, не заменяют консультацию юриста. Перед серьёзным масштабированием (>10k платных юзеров, корпоративные клиенты, юзеры в строго регулируемых рынках типа California / Germany) — отдай на ревью.

В документах прописано:
- Юрисдикция: Montenegro (поменяй если регистрируешь юр.лицо в другой стране)
- Operator: «individual developer based in Montenegro»
- Email: `support@mathpet.app`
- Цены: $4.99/мес, $29.99/год (синхрон с PRD; если меняешь в App Store Connect — поменяй и тут)

## Стоимость

| Что | Цена |
|---|---|
| Домен `mathpet.app` (Cloudflare Registrar) | ~$10/год (уже куплен) |
| Cloudflare Pages | $0 |
| Cloudflare DNS | $0 |
| Cloudflare Email Routing | $0 |
| GitHub | $0 |
| **Итого** | **~$10/год** |

Лимиты Cloudflare Pages бесплатного тарифа: **unlimited bandwidth, unlimited requests, 500 builds/мес, 100 custom domains.** Это намного щедрее чем у Vercel Hobby (100 GB/мес).

## Локализованные ссылки

| Локаль | Главная | Privacy | Terms |
|---|---|---|---|
| EN | `/` | `/privacy` | `/terms` |
| ES | `/es/` | `/es/privacy` | `/es/terms` |
| FR | `/fr/` | `/fr/privacy` | `/fr/terms` |
| DE | `/de/` | `/de/privacy` | `/de/terms` |
| RU | `/ru/` | `/ru/privacy` | `/ru/terms` |

В App Store Connect и Google Play Console каждая локализация листинга может иметь свой URL Privacy Policy. Подставляй соответствующий.

