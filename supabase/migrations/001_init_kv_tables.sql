-- ============================================================
-- IPPOO ASSURANCE — Migration initiale des tables KV
-- À exécuter dans : Supabase Dashboard > SQL Editor
-- URL: http://essai-supabase-2f6d39-194-28-99-129.sslip.io
-- ============================================================

-- Table générique pour les clés système (rate limits, HMAC, etc.)
CREATE TABLE IF NOT EXISTS system_kv (
  id TEXT PRIMARY KEY,
  value JSONB,
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- Profils utilisateurs
CREATE TABLE IF NOT EXISTS profiles (
  id TEXT PRIMARY KEY,
  value JSONB,
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- Contrats d'assurance
CREATE TABLE IF NOT EXISTS contracts (
  id TEXT PRIMARY KEY,
  value JSONB,
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- Sinistres / Réclamations
CREATE TABLE IF NOT EXISTS claims (
  id TEXT PRIMARY KEY,
  value JSONB,
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- Paiements / Cotisations
CREATE TABLE IF NOT EXISTS payments (
  id TEXT PRIMARY KEY,
  value JSONB,
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- Bénéficiaires
CREATE TABLE IF NOT EXISTS beneficiaries (
  id TEXT PRIMARY KEY,
  value JSONB,
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- Documents KYC déclarés
CREATE TABLE IF NOT EXISTS documents (
  id TEXT PRIMARY KEY,
  value JSONB,
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- Paramètres utilisateur (langue, notifs, etc.)
CREATE TABLE IF NOT EXISTS settings (
  id TEXT PRIMARY KEY,
  value JSONB,
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- Notifications in-app
CREATE TABLE IF NOT EXISTS notifications (
  id TEXT PRIMARY KEY,
  value JSONB,
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- Messagerie conseiller ↔ client
CREATE TABLE IF NOT EXISTS messages (
  id TEXT PRIMARY KEY,
  value JSONB,
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- Dossiers KYC
CREATE TABLE IF NOT EXISTS kyc (
  id TEXT PRIMARY KEY,
  value JSONB,
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- Journal d'audit utilisateur
CREATE TABLE IF NOT EXISTS user_audits (
  id TEXT PRIMARY KEY,
  value JSONB,
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- ============================================================
-- Index pour accélérer les recherches par préfixe (LIKE 'key%')
-- ============================================================
CREATE INDEX IF NOT EXISTS idx_system_kv_id ON system_kv (id);
CREATE INDEX IF NOT EXISTS idx_profiles_id ON profiles (id);
CREATE INDEX IF NOT EXISTS idx_contracts_id ON contracts (id);
CREATE INDEX IF NOT EXISTS idx_claims_id ON claims (id);
CREATE INDEX IF NOT EXISTS idx_payments_id ON payments (id);
CREATE INDEX IF NOT EXISTS idx_beneficiaries_id ON beneficiaries (id);
CREATE INDEX IF NOT EXISTS idx_documents_id ON documents (id);
CREATE INDEX IF NOT EXISTS idx_settings_id ON settings (id);
CREATE INDEX IF NOT EXISTS idx_notifications_id ON notifications (id);
CREATE INDEX IF NOT EXISTS idx_messages_id ON messages (id);
CREATE INDEX IF NOT EXISTS idx_kyc_id ON kyc (id);
CREATE INDEX IF NOT EXISTS idx_user_audits_id ON user_audits (id);

-- ============================================================
-- RLS (Row Level Security) — Désactivé car la fonction
-- utilise la SERVICE_ROLE_KEY qui bypasse le RLS
-- ============================================================
ALTER TABLE system_kv DISABLE ROW LEVEL SECURITY;
ALTER TABLE profiles DISABLE ROW LEVEL SECURITY;
ALTER TABLE contracts DISABLE ROW LEVEL SECURITY;
ALTER TABLE claims DISABLE ROW LEVEL SECURITY;
ALTER TABLE payments DISABLE ROW LEVEL SECURITY;
ALTER TABLE beneficiaries DISABLE ROW LEVEL SECURITY;
ALTER TABLE documents DISABLE ROW LEVEL SECURITY;
ALTER TABLE settings DISABLE ROW LEVEL SECURITY;
ALTER TABLE notifications DISABLE ROW LEVEL SECURITY;
ALTER TABLE messages DISABLE ROW LEVEL SECURITY;
ALTER TABLE kyc DISABLE ROW LEVEL SECURITY;
ALTER TABLE user_audits DISABLE ROW LEVEL SECURITY;

-- ============================================================
-- Vérification : liste les tables créées
-- ============================================================
SELECT table_name, pg_size_pretty(pg_total_relation_size(quote_ident(table_name))) AS size
FROM information_schema.tables
WHERE table_schema = 'public'
  AND table_name IN (
    'system_kv','profiles','contracts','claims','payments',
    'beneficiaries','documents','settings','notifications',
    'messages','kyc','user_audits'
  )
ORDER BY table_name;
