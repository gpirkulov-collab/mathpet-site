#!/usr/bin/env bash
# MathPet landing-site — local setup + push to GitHub.
# Run once from Terminal:
#   cd "/Users/georgepirkulov/Documents/Claude/Projects/MathPet/landing-site"
#   chmod +x setup.sh
#   ./setup.sh

set -e

GITHUB_USER="gpirkulov-collab"
REPO_NAME="mathpet-site"
REMOTE_URL="https://github.com/${GITHUB_USER}/${REPO_NAME}.git"

echo "→ Cleaning any half-initialized .git from sandbox..."
rm -rf .git

echo "→ Initializing fresh git repo on main branch..."
git init -b main
git config user.email "gpirkulov@gmail.com"
git config user.name "George Pirkulov"

echo "→ Staging files..."
git add .
git status --short

echo "→ Creating initial commit..."
git commit -m "initial: landing + privacy + terms (5 languages, Cloudflare Pages)"

echo
echo "✓ Local repo ready."
echo
echo "═══════════════════════════════════════════════════════"
echo "NEXT (manual, ~5 min):"
echo "═══════════════════════════════════════════════════════"
echo
echo "1. Create empty repo on GitHub:"
echo "   https://github.com/new"
echo "   - Owner: ${GITHUB_USER}"
echo "   - Name: ${REPO_NAME}"
echo "   - Public or Private — both work"
echo "   - Do NOT add README / .gitignore / license"
echo
echo "2. Push from this Terminal:"
echo "   git remote add origin ${REMOTE_URL}"
echo "   git push -u origin main"
echo
echo "3. Cloudflare Dashboard → Workers & Pages → Create → Pages tab"
echo "   - Connect to Git → choose ${REPO_NAME}"
echo "   - Framework preset: None"
echo "   - Build command: (empty)"
echo "   - Build output directory: (empty)"
echo "   - Save and Deploy"
echo
echo "4. Custom domain:"
echo "   - In your Pages project → Custom domains → Set up a custom domain"
echo "   - Enter: mathpet.app"
echo "   - Cloudflare auto-attaches DNS + SSL"
echo
echo "5. Email Routing:"
echo "   - Cloudflare Dashboard → mathpet.app → Email → Email Routing"
echo "   - Get started (auto MX records)"
echo "   - Routing rules → Create address: 'support' → Send to: gpirkulov@gmail.com"
echo "   - Verify destination email"
echo
echo "═══════════════════════════════════════════════════════"
echo "Final URLs:"
echo "═══════════════════════════════════════════════════════"
echo "  https://mathpet.app/"
echo "  https://mathpet.app/privacy"
echo "  https://mathpet.app/terms"
echo "  https://mathpet.app/ru/privacy  (and /es/, /fr/, /de/)"
echo
echo "Email: support@mathpet.app → gpirkulov@gmail.com"
