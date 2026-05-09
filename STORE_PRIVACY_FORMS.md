# Apple App Privacy & Google Data Safety — готовые ответы

Шпаргалка для заполнения форм Privacy при сабмите MathPet. Все ответы соответствуют написанному Privacy Policy. Заполняй ровно как тут — расхождения с текстом политики = повод для отказа на ревью.

Дисклеймер: ответы основаны на текущем продукте. Если добавишь Adjust SDK / Amplitude / Meta SDK — Privacy Labels придётся пересчитать и обновить.

---

## Часть 1. Apple App Store Connect → App Privacy

Путь: App Store Connect → твой app → App Privacy → Get Started.

### Шаг A. "Are you collecting data from this app?"

Ответ: **Yes**

(Иначе всё что ниже не показывается.)

### Шаг B. Categories — отметить какие данные собираешь

Apple даёт 13 групп. Отмечай только те, где ниже стоит **YES**.

| Группа | Собираешь? |
|---|---|
| Contact Info | **YES** (email) |
| Health & Fitness | NO |
| Financial Info | NO (Apple/Google handle payments) |
| Location | NO |
| Sensitive Info | NO |
| Contacts | NO |
| User Content | **YES** (Customer Support — переписка по support email) |
| Browsing History | NO |
| Search History | NO |
| Identifiers | **YES** (User ID) |
| Purchases | **YES** (Purchase History) |
| Usage Data | **YES** (Product Interaction) |
| Diagnostics | **YES** (Crash Data, Performance Data) |
| Other Data | NO |

### Шаг C. Детали по каждой собираемой группе

Для каждой галочки Apple спросит 3 вещи:
1. **Used for** (можно несколько): Third-Party Advertising / Developer's Advertising or Marketing / Analytics / Product Personalization / App Functionality / Other Purposes
2. **Linked to User?** Yes/No
3. **Used for Tracking?** Yes/No

#### Contact Info → Email Address

- Used for: ✅ App Functionality
- Linked to User: **Yes**
- Used for Tracking: **No**

(Email используется только для аутентификации и саппорта — это `App Functionality`. Не маркетинг.)

#### User Content → Customer Support

- Used for: ✅ App Functionality
- Linked to User: **Yes**
- Used for Tracking: **No**

#### Identifiers → User ID

- Used for: ✅ App Functionality, ✅ Analytics
- Linked to User: **Yes**
- Used for Tracking: **No**

(Firebase UID привязан к юзеру для синка прогресса. Анонимный installation ID для Crashlytics — формально это `User ID` тоже, в этой же группе.)

#### Purchases → Purchase History

- Used for: ✅ App Functionality
- Linked to User: **Yes**
- Used for Tracking: **No**

(Знание про активную подписку, нужно чтобы разблокировать платный контент.)

#### Usage Data → Product Interaction

- Used for: ✅ App Functionality, ✅ Analytics
- Linked to User: **Yes**
- Used for Tracking: **No**

(Прогресс ребёнка по задачам — это `App Functionality` для adaptive engine, плюс агрегированная аналитика по фичам.)

#### Diagnostics → Crash Data

- Used for: ✅ App Functionality
- Linked to User: **No**
- Used for Tracking: **No**

(Crashlytics сэмплит crash reports без email/имени — формально не linked.)

#### Diagnostics → Performance Data

- Used for: ✅ App Functionality
- Linked to User: **No**
- Used for Tracking: **No**

### Шаг D. Privacy Policy URL

```
https://mathpet.app/privacy
```

(или твой реальный поддомен)

### Шаг E. Возрастной рейтинг

App Information → Age Rating → "Edit":

- **Cartoon or Fantasy Violence:** None
- **Realistic Violence:** None
- **Prolonged Graphic or Sadistic Realistic Violence:** None
- **Profanity or Crude Humor:** None
- **Mature/Suggestive Themes:** None
- **Horror/Fear Themes:** None
- **Medical/Treatment Information:** None
- **Alcohol, Tobacco, or Drug Use:** None
- **Simulated Gambling:** None
- **Sexual Content or Nudity:** None
- **Graphic Sexual Content and Nudity:** None
- **Unrestricted Web Access:** No
- **Gambling:** No
- **Contests:** No

→ Final rating: **4+**

### Шаг F. Kids Category vs Education Category

В App Information → Category:

- Primary Category: **Education**
- Secondary Category: **Games → Family** (опционально)

**НЕ** ставь "Made for Kids" / Kids Category. По договорённости из PRD мы остаёмся в Education — это упрощает ревью и убирает кучу COPPA-обязательств в ServerSide. Текст в App Store не должен содержать "for children under 13"; используй "young learners", "ages 4+".

---

## Часть 2. Google Play Console → Data Safety

Путь: Play Console → твой app → Policy → App content → Data safety.

### Section 1. Data collection and security

| Question | Answer |
|---|---|
| Does your app collect or share any of the required user data types? | **Yes** |
| Is all of the user data collected by your app encrypted in transit? | **Yes** (Firebase + HTTPS) |
| Do you provide a way for users to request that their data is deleted? | **Yes** (через email — описано в Privacy Policy §10) |

### Section 2. Data types (детальная разбивка)

Google группирует так — отвечаю по каждому пункту что мы делаем в MathPet.

#### Personal info
- **Name** — NO
- **Email address** — **YES** (Collected, not shared)
  - Purposes: ✅ Account management
  - Optional or Required: **Required** (auth обязателен)
- **User IDs** — **YES** (Collected, not shared)
  - Purposes: ✅ Account management, ✅ Analytics
  - Required
- **Address, Phone number, Race/Ethnicity, Sexual orientation, etc.** — NO

#### Financial info
- Все пункты — **NO** (Apple/Google handle payments)

#### Health and fitness
- Все пункты — **NO**

#### Messages
- Все пункты — **NO**

#### Photos and videos
- Все пункты — **NO**

#### Audio files
- Все пункты — **NO**

#### Files and docs
- Все пункты — **NO**

#### Calendar
- Все пункты — **NO**

#### Contacts
- Все пункты — **NO**

#### App activity
- **App interactions** — **YES** (Collected, not shared)
  - Purposes: ✅ App functionality, ✅ Analytics
  - Required
- **In-app search history** — NO
- **Installed apps** — NO
- **Other user-generated content** — NO
- **Other actions** — NO

#### Web browsing
- Все пункты — **NO**

#### App info and performance
- **Crash logs** — **YES** (Collected, not shared)
  - Purposes: ✅ App functionality
  - Required
- **Diagnostics** — **YES**
  - Purposes: ✅ App functionality
  - Required
- **Other app performance data** — NO

#### Device or other IDs
- **Device or other IDs** — **YES** (Collected, not shared)
  - Purposes: ✅ Analytics, ✅ App functionality
  - Required

### Section 3. Security practices

- **Data is encrypted in transit:** Yes
- **Users can request that their data be deleted:** Yes (via email to support)
- **Committed to follow Play Families Policy:** Yes (если приложение target audience включает <13)

### Section 4. Privacy Policy URL

```
https://mathpet.app/privacy
```

---

## Часть 3. Google Play → Target audience and content

Путь: Play Console → Policy → App content → Target audience and content.

### Target audience

- **Target age group(s):** ☑ 5–8, ☑ 9–12 (опционально 13+ если хочешь чтобы родители 25+ скачивали "for my kid")
- **Appeals to children:** Yes

(Ловушка: если target ≤12, Google автоматически применяет Designed for Families policy — всё ниже становится обязательным.)

### Designed for Families policy compliance

- **Ads:** No ads (всегда так оставлять, иначе обязан Google-сертифицированный SDK с family-friendly фильтром)
- **In-app purchases:** Yes ($4.99/$29.99)
- **Restricted content:** No
- **Content rating:** заполнить отдельную форму, ответы те же что в Apple Age Rating выше → итог Everyone

---

## Часть 4. Настройка подписочных продуктов (вне форм Privacy, но рядом)

### App Store Connect → In-App Purchases

Создать два Auto-Renewable Subscription'а в одной Subscription Group "MathPet Premium":

**Monthly:**
- Reference Name: `MathPet Monthly`
- Product ID: `com.mathpet.app.monthly`
- Subscription Duration: 1 Month
- Price: USD 4.99 (Tier выберется автоматически)
- Free Trial: 7 days
- Localizations:
  - EN: Display Name "Monthly", Description "Unlimited math practice and pet customization, billed monthly."
  - RU: "Месячная подписка", "Безлимитные задачи и кастомизация питомца, оплата раз в месяц."

**Annual:**
- Reference Name: `MathPet Annual`
- Product ID: `com.mathpet.app.annual`
- Subscription Duration: 1 Year
- Price: USD 29.99
- Free Trial: 7 days
- Localizations:
  - EN: Display Name "Annual", Description "Unlimited math practice and pet customization, billed yearly. Save 50%."
  - RU: "Годовая подписка", "Безлимитные задачи и кастомизация питомца, оплата раз в год. Экономия 50%."

### Google Play Console → Monetize → Products → Subscriptions

Аналогично. Product IDs **должны быть теми же**: `com.mathpet.app.monthly` и `com.mathpet.app.annual` — это критично, чтобы код IAP в Flutter работал с одной точкой логики.

Для каждой подписки создать `base plan` + `offer` с trial:
- Base plan ID: `monthly` / `annual`
- Free trial offer: 7 days, eligibility "New customer acquisition"

---

## Чеклист перед сабмитом

- [ ] Privacy Policy URL отвечает 200 OK и не блокирован
- [ ] Terms URL отвечает 200 OK
- [ ] Support URL/email рабочий и читается
- [ ] Apple App Privacy заполнено по этому файлу
- [ ] Apple Age Rating: 4+
- [ ] Apple Category: Education (NOT Kids)
- [ ] Google Data Safety заполнено по этому файлу
- [ ] Google Target Audience: 5–12
- [ ] Google Content Rating: Everyone
- [ ] Subscription products созданы с одинаковыми ID на iOS и Android
- [ ] Sandbox-тест: trial → активная подписка → cancel — на iOS и Android
