-- ============================================================
-- IPPOO ASSURANCE — Migration relationnelle structurée des tables
-- À exécuter dans : Supabase Dashboard > SQL Editor
-- URL: http://essai-supabase-2f6d39-194-28-99-129.sslip.io
-- ============================================================

-- Suppression des anciennes tables et vues si existantes
DROP VIEW IF EXISTS kv_store_752d1a39;
DROP TABLE IF EXISTS user_audits;
DROP TABLE IF EXISTS kyc;
DROP TABLE IF EXISTS messages;
DROP TABLE IF EXISTS notifications;
DROP TABLE IF EXISTS settings;
DROP TABLE IF EXISTS beneficiaries;
DROP TABLE IF EXISTS payments;
DROP TABLE IF EXISTS claims;
DROP TABLE IF EXISTS contracts;
DROP TABLE IF EXISTS profiles;
DROP TABLE IF EXISTS system_kv;

-- 1. Table générique pour les clés système (rate limits, HMAC, etc.)
CREATE TABLE system_kv (
  id TEXT PRIMARY KEY,
  value JSONB,
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- 2. Profils utilisateurs structurés
CREATE TABLE profiles (
  id TEXT PRIMARY KEY,
  email TEXT UNIQUE NOT NULL,
  name TEXT NOT NULL,
  phone TEXT,
  member_number TEXT UNIQUE,
  profile_type TEXT, -- 'particulier', 'informel', 'salarie'
  sous_profil TEXT[],
  first_name TEXT,
  last_name TEXT,
  gender TEXT,
  birth_date TEXT,
  birth_place TEXT,
  nationality TEXT,
  address TEXT,
  profession TEXT,
  activite TEXT,
  secteur TEXT,
  entreprise TEXT,
  statut_pro TEXT,
  company_name TEXT,
  ifu TEXT,
  id_type TEXT,
  id_number TEXT,
  country TEXT,
  country_dial TEXT,
  department TEXT,
  city TEXT,
  quartier TEXT,
  couverture TEXT[],
  couverture_autre TEXT,
  formule TEXT,
  documents_declares TEXT[],
  document_autre TEXT,
  enrolled_by TEXT,
  enrolled_by_uid TEXT,
  enrolled_at TIMESTAMPTZ,
  enrolled_source TEXT,
  kyc_verified BOOLEAN DEFAULT false,
  card_active BOOLEAN DEFAULT false,
  card_issued_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- 3. Contrats d'assurance structurés
CREATE TABLE contracts (
  id TEXT PRIMARY KEY,
  user_id TEXT REFERENCES profiles(id) ON DELETE CASCADE,
  product TEXT NOT NULL,
  premium NUMERIC,
  frequency TEXT,
  status TEXT,
  start_date TIMESTAMPTZ,
  end_date TIMESTAMPTZ,
  subscribed_by TEXT,
  subscribed_by_name TEXT,
  next_billing_date TIMESTAMPTZ,
  pending_renewal_payment_id TEXT,
  pending_renewal_at TIMESTAMPTZ,
  suspended_at TIMESTAMPTZ,
  suspended_reason TEXT,
  last_paid_at TIMESTAMPTZ,
  renewal_notice_sent BOOLEAN DEFAULT false,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- 4. Sinistres / Réclamations structurés
CREATE TABLE claims (
  id TEXT PRIMARY KEY,
  user_id TEXT REFERENCES profiles(id) ON DELETE CASCADE,
  contract_id TEXT REFERENCES contracts(id) ON DELETE SET NULL,
  type TEXT NOT NULL,
  description TEXT NOT NULL,
  amount NUMERIC,
  status TEXT,
  decided_by TEXT,
  decided_by_matricule TEXT,
  decided_at TIMESTAMPTZ,
  admin_note TEXT,
  assigned_to TEXT,
  assigned_at TIMESTAMPTZ,
  assigned_by TEXT,
  beneficiary JSONB,
  beneficiary_id TEXT,
  attachments JSONB,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- 5. Paiements / Cotisations structurés
CREATE TABLE payments (
  id TEXT PRIMARY KEY,
  user_id TEXT REFERENCES profiles(id) ON DELETE CASCADE,
  contract_id TEXT REFERENCES contracts(id) ON DELETE SET NULL,
  amount NUMERIC NOT NULL,
  method TEXT,
  purpose TEXT,
  status TEXT,
  collected_by TEXT,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- 6. Bénéficiaires structurés
CREATE TABLE beneficiaries (
  id TEXT PRIMARY KEY,
  user_id TEXT REFERENCES profiles(id) ON DELETE CASCADE,
  name TEXT NOT NULL,
  relation TEXT NOT NULL,
  birth_date TEXT,
  source TEXT,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- 7. Paramètres utilisateur structurés
CREATE TABLE settings (
  user_id TEXT PRIMARY KEY REFERENCES profiles(id) ON DELETE CASCADE,
  lang TEXT DEFAULT 'fr',
  notify_sms BOOLEAN DEFAULT true,
  notify_email BOOLEAN DEFAULT true,
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- 8. Notifications in-app structurées
CREATE TABLE notifications (
  id TEXT PRIMARY KEY,
  user_id TEXT REFERENCES profiles(id) ON DELETE CASCADE,
  title TEXT NOT NULL,
  body TEXT NOT NULL,
  type TEXT,
  read BOOLEAN DEFAULT false,
  to_path TEXT,
  created_at TIMESTAMPTZ DEFAULT now()
);

-- 9. Messagerie conseiller ↔ client
CREATE TABLE messages (
  id TEXT PRIMARY KEY,
  user_id TEXT REFERENCES profiles(id) ON DELETE CASCADE,
  content TEXT NOT NULL,
  reply_to_id TEXT,
  author TEXT,
  attachment JSONB,
  created_at TIMESTAMPTZ DEFAULT now()
);

-- 10. Dossiers KYC
CREATE TABLE kyc (
  id TEXT PRIMARY KEY,
  user_id TEXT REFERENCES profiles(id) ON DELETE CASCADE,
  type TEXT,
  fields JSONB,
  documents TEXT[],
  status TEXT,
  decided_by TEXT,
  decided_at TIMESTAMPTZ,
  admin_note TEXT,
  created_at TIMESTAMPTZ DEFAULT now()
);

-- 11. Journal d'audit utilisateur
CREATE TABLE user_audits (
  id TEXT PRIMARY KEY,
  user_id TEXT REFERENCES profiles(id) ON DELETE CASCADE,
  action TEXT NOT NULL,
  meta JSONB,
  created_at TIMESTAMPTZ DEFAULT now()
);

-- ============================================================
-- Index pour accélérer les recherches et requêtes
-- ============================================================
CREATE INDEX idx_profiles_email ON profiles (email);
CREATE INDEX idx_profiles_member ON profiles (member_number);
CREATE INDEX idx_contracts_user ON contracts (user_id);
CREATE INDEX idx_claims_user ON claims (user_id);
CREATE INDEX idx_payments_user ON payments (user_id);
CREATE INDEX idx_beneficiaries_user ON beneficiaries (user_id);
CREATE INDEX idx_notifications_user ON notifications (user_id);
CREATE INDEX idx_messages_user ON messages (user_id);
CREATE INDEX idx_kyc_user ON kyc (user_id);
CREATE INDEX idx_user_audits_user ON user_audits (user_id);

-- ============================================================
-- RLS (Row Level Security) — Désactivé car la Edge Function
-- utilise la SERVICE_ROLE_KEY
-- ============================================================
ALTER TABLE system_kv DISABLE ROW LEVEL SECURITY;
ALTER TABLE profiles DISABLE ROW LEVEL SECURITY;
ALTER TABLE contracts DISABLE ROW LEVEL SECURITY;
ALTER TABLE claims DISABLE ROW LEVEL SECURITY;
ALTER TABLE payments DISABLE ROW LEVEL SECURITY;
ALTER TABLE beneficiaries DISABLE ROW LEVEL SECURITY;
ALTER TABLE settings DISABLE ROW LEVEL SECURITY;
ALTER TABLE notifications DISABLE ROW LEVEL SECURITY;
ALTER TABLE messages DISABLE ROW LEVEL SECURITY;
ALTER TABLE kyc DISABLE ROW LEVEL SECURITY;
ALTER TABLE user_audits DISABLE ROW LEVEL SECURITY;

-- ============================================================
-- VUE DE COMPATIBILITÉ KV STORE (Lecture seule)
-- ============================================================
CREATE OR REPLACE VIEW kv_store_752d1a39 AS
  -- 1. Profiles
  SELECT 
    'profile:' || id AS key,
    json_build_object(
      'id', id,
      'email', email,
      'name', name,
      'phone', phone,
      'memberNumber', member_number,
      'type', profile_type,
      'sousProfil', sous_profil,
      'firstName', first_name,
      'lastName', last_name,
      'gender', gender,
      'birthDate', birth_date,
      'birthPlace', birth_place,
      'nationality', nationality,
      'address', address,
      'profession', profession,
      'activite', activite,
      'secteur', secteur,
      'entreprise', entreprise,
      'statutPro', statut_pro,
      'companyName', company_name,
      'ifu', ifu,
      'idType', id_type,
      'idNumber', id_number,
      'country', country,
      'countryDial', country_dial,
      'department', department,
      'city', city,
      'quartier', quartier,
      'couverture', couverture,
      'couvertureAutre', couverture_autre,
      'formule', formule,
      'documentsDeclares', documents_declares,
      'documentAutre', document_autre,
      'enrolledBy', enrolled_by,
      'enrolledByUid', enrolled_by_uid,
      'enrolledAt', enrolled_at,
      'enrolledSource', enrolled_source,
      'kycVerified', kyc_verified,
      'cardActive', card_active,
      'cardIssuedAt', card_issued_at,
      'createdAt', created_at
    )::jsonb AS value
  FROM profiles

  UNION ALL

  -- 2. Contracts (regroupés par user_id sous forme de tableau JSON)
  SELECT 
    'contracts:' || user_id AS key,
    coalesce(
      json_agg(
        json_build_object(
          'id', id,
          'userId', user_id,
          'product', product,
          'premium', premium,
          'frequency', frequency,
          'status', status,
          'startDate', start_date,
          'endDate', end_date,
          'subscribedBy', subscribed_by,
          'subscribedByName', subscribed_by_name,
          'nextBillingDate', next_billing_date,
          'pendingRenewalPaymentId', pending_renewal_payment_id,
          'pendingRenewalAt', pending_renewal_at,
          'suspendedAt', suspended_at,
          'suspendedReason', suspended_reason,
          'lastPaidAt', last_paid_at,
          'renewalNoticeSent', renewal_notice_sent,
          'createdAt', created_at,
          'updatedAt', updated_at
        )
      ), '[]'::json
    )::jsonb AS value
  FROM contracts
  GROUP BY user_id

  UNION ALL

  -- 3. Claims (regroupés par user_id sous forme de tableau JSON)
  SELECT 
    'claims:' || user_id AS key,
    coalesce(
      json_agg(
        json_build_object(
          'id', id,
          'userId', user_id,
          'contractId', contract_id,
          'type', type,
          'description', description,
          'amount', amount,
          'status', status,
          'decidedBy', decided_by,
          'decidedByMatricule', decided_by_matricule,
          'decidedAt', decided_at,
          'adminNote', admin_note,
          'assignedTo', assigned_to,
          'assignedAt', assigned_at,
          'assignedBy', assigned_by,
          'beneficiary', beneficiary,
          'beneficiaryId', beneficiary_id,
          'attachments', attachments,
          'createdAt', created_at,
          'updatedAt', updated_at
        )
      ), '[]'::json
    )::jsonb AS value
  FROM claims
  GROUP BY user_id

  UNION ALL

  -- 4. Payments (regroupés par user_id sous forme de tableau JSON)
  SELECT 
    'payments:' || user_id AS key,
    coalesce(
      json_agg(
        json_build_object(
          'id', id,
          'userId', user_id,
          'contractId', contract_id,
          'amount', amount,
          'method', method,
          'purpose', purpose,
          'status', status,
          'collectedBy', collected_by,
          'createdAt', created_at,
          'updatedAt', updated_at
        )
      ), '[]'::json
    )::jsonb AS value
  FROM payments
  GROUP BY user_id

  UNION ALL

  -- 5. Beneficiaries (regroupés par user_id sous forme de tableau JSON)
  SELECT 
    'beneficiaries:' || user_id AS key,
    coalesce(
      json_agg(
        json_build_object(
          'id', id,
          'userId', user_id,
          'name', name,
          'relation', relation,
          'birthDate', birth_date,
          'source', source,
          'createdAt', created_at,
          'updatedAt', updated_at
        )
      ), '[]'::json
    )::jsonb AS value
  FROM beneficiaries
  GROUP BY user_id

  UNION ALL

  -- 6. Settings (objet unique par utilisateur)
  SELECT 
    'settings:' || user_id AS key,
    json_build_object(
      'lang', lang,
      'notifySms', notify_sms,
      'notifyEmail', notify_email
    )::jsonb AS value
  FROM settings

  UNION ALL

  -- 7. Notifications (regroupées par user_id sous forme de tableau JSON)
  SELECT 
    'notifications:' || user_id AS key,
    coalesce(
      json_agg(
        json_build_object(
          'id', id,
          'userId', user_id,
          'title', title,
          'body', body,
          'type', type,
          'read', read,
          'to', to_path,
          'createdAt', created_at
        )
      ), '[]'::json
    )::jsonb AS value
  FROM notifications
  GROUP BY user_id

  UNION ALL

  -- 8. Messages (regroupés par user_id sous forme de tableau JSON)
  SELECT 
    'messages:' || user_id AS key,
    coalesce(
      json_agg(
        json_build_object(
          'id', id,
          'userId', user_id,
          'content', content,
          'replyToId', reply_to_id,
          'author', author,
          'attachment', attachment,
          'createdAt', created_at
        )
      ), '[]'::json
    )::jsonb AS value
  FROM messages
  GROUP BY user_id

  UNION ALL

  -- 9. KYC (dossier {current, history} par utilisateur)
  SELECT 
    'kyc:' || user_id AS key,
    json_build_object(
      'current', (
        SELECT json_build_object(
          'id', id, 'userId', user_id, 'type', type, 'fields', fields,
          'documents', documents, 'status', status, 'decidedBy', decided_by,
          'decidedAt', decided_at, 'adminNote', admin_note, 'createdAt', created_at
        ) FROM kyc k2 WHERE k2.user_id = kyc.user_id AND k2.status = 'pending' ORDER BY k2.created_at DESC LIMIT 1
      ),
      'history', coalesce(
        (SELECT json_agg(
          json_build_object(
            'id', id, 'userId', user_id, 'type', type, 'fields', fields,
            'documents', documents, 'status', status, 'decidedBy', decided_by,
            'decidedAt', decided_at, 'adminNote', admin_note, 'createdAt', created_at
          )
        ) FROM kyc k3 WHERE k3.user_id = kyc.user_id AND k3.status != 'pending'), '[]'::json
      )
    )::jsonb AS value
  FROM kyc
  GROUP BY user_id

  UNION ALL

  -- 10. Audits (regroupés par user_id sous forme de tableau JSON)
  SELECT 
    'audit:' || user_id AS key,
    coalesce(
      json_agg(
        json_build_object(
          'id', id,
          'userId', user_id,
          'action', action,
          'meta', meta,
          'at', created_at
        )
      ), '[]'::json
    )::jsonb AS value
  FROM user_audits
  GROUP BY user_id

  UNION ALL

  -- 11. System KV (rate limits, locks)
  SELECT 
    id AS key,
    value
  FROM system_kv;
