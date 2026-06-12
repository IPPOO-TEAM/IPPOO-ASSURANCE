import { Link } from "react-router";
import { motion } from "motion/react";
import {
  Shield, Users, Heart, Sparkles, Target, Compass, Award, Handshake, MapPin, ArrowRight,
  Building2, Briefcase, Globe2, TrendingUp, CheckCircle2
} from "lucide-react";
import { ImageWithFallback } from "./figma/ImageWithFallback";
import { usePageMeta } from "../lib/usePageMeta";
import { useLang } from "../lib/LanguageContext";
import { heroAboutTeam as heroImg } from "../lib/images";
import missionImg from "../../imports/t_l_chargement_-_2026-02-17T085009.981.jpg";

const stats = [
  { value: "85 000+", label: "Assurés actifs" },
  { value: "320", label: "Points partenaires" },
  { value: "14", label: "Pays de la zone CIMA" },
  { value: "98 %", label: "Sinistres réglés < 15 jours" },
];

const valeurs = [
  { icon: Heart, title: "Proximité", desc: "Nous allons à la rencontre des actifs de l'informel, là où ils travaillent : marchés, ateliers, points partenaires, mobile money.", color: "#c0392b" },
  { icon: Sparkles, title: "Simplicité", desc: "Nos contrats sont lisibles, nos prix transparents, nos parcours digitaux pensés pour un smartphone simple.", color: "#E65100" },
  { icon: Handshake, title: "Solidarité", desc: "La mutualisation des risques au service des plus vulnérables : c'est l'essence même de la micro-assurance.", color: "#0B6E4F" },
  { icon: Shield, title: "Confiance", desc: "Agréés par les autorités CIMA, nous appliquons les standards les plus exigeants en matière de gouvernance.", color: "#1565C0" },
];

const equipe = [
  { initiales: "KD", nom: "Kouadio Diomandé", role: "Directeur Général", bio: "20 ans dans l'assurance africaine, ex-directeur opérations chez un grand groupe panafricain.", color: "#0B6E4F" },
  { initiales: "AT", nom: "Aminata Traoré", role: "Directrice Technique & Souscription", bio: "Actuaire diplômée, spécialiste des produits de micro-assurance et santé.", color: "#c0392b" },
  { initiales: "SK", nom: "Sylvain Koffi", role: "Directeur des Opérations", bio: "Construit notre réseau de 320 points partenaires à travers la Bénin.", color: "#E65100" },
  { initiales: "MB", nom: "Mariam Bamba", role: "Directrice Sinistres & Indemnisations", bio: "Garantit nos engagements de délais et la qualité de l'expérience assuré.", color: "#1565C0" },
  { initiales: "JE", nom: "Joseph Ehouman", role: "Directeur Conformité & CIMA", bio: "Veille à la conformité réglementaire et à la solidité financière de l'entreprise.", color: "#7B1FA2" },
  { initiales: "FN", nom: "Fatou N'Diaye", role: "Directrice Digital & Innovation", bio: "Pilote la plateforme digitale et les partenariats mobile money.", color: "#00838F" },
];

const partenaires = [
  { nom: "FECECAM", type: "Microfinance" },
  { nom: "CLCAM", type: "Microfinance" },
  { nom: "NSIA", type: "Assurance & Banque" },
  { nom: "ECOBANK", type: "Banque" },
  { nom: "MOOV", type: "Mobile money" },
  { nom: "MTN", type: "Mobile money" },
];

const histoire = [
  { annee: "2022", titre: "Genèse du projet", desc: "Constat d'un trou béant dans l'accès à l'assurance pour les 85 % du Béninois travaillant dans l'informel." },
  { annee: "2023", titre: "Agrément CIMA & capital", desc: "Obtention de l'agrément, levée d'un capital social de 1 milliard FCFA et constitution de l'équipe fondatrice." },
  { annee: "2024", titre: "Premiers produits", desc: "Lancement de la Carte IPPOO et des 4 produits fondateurs : Santé, Marchandises, Maternité, Transport." },
  { annee: "2025", titre: "Réseau partenaires", desc: "Déploiement de 200 points partenaires au Bénin et intégration des principaux opérateurs mobile money." },
  { annee: "2026", titre: "Couverture complète", desc: "11 produits actifs, 85 000 assurés, ouverture d'antennes à Parakou, Bohicon, Porto-Novo et Natitingou." },
];

export function AProposPage() {
  const { t } = useLang();
  usePageMeta({
    title: "À propos Notre mission, notre équipe, nos valeurs",
    description: "Découvrez IPPOO ASSURANCE : 85 000 assurés, 320 points partenaires, présence dans 14 pays CIMA. Notre mission, nos valeurs, notre équipe dirigeante et nos engagements RSE.",
    image: heroImg,
  });
  return (
    <div className="overflow-hidden">
      {/* HERO */}
      <section className="relative min-h-[60vh] flex items-center bg-[#0d1117] text-white overflow-hidden">
        <div className="absolute inset-0">
          <ImageWithFallback src={heroImg} alt="Équipe IPPOO ASSURANCE en réunion" className="w-full h-full object-cover opacity-30" loading="eager" decoding="async" />
          <div className="absolute inset-0 bg-gradient-to-r from-[#0d1117] via-[#0d1117]/85 to-[#0d1117]/40" />
        </div>
        <div className="absolute top-20 right-[10%] w-72 h-72 bg-ippoo-green/15 rounded-full blur-[100px]" />
        <div className="absolute bottom-0 left-[5%] w-64 h-64 bg-[#E65100]/10 rounded-full blur-[80px]" />

        <div className="max-w-6xl mx-auto px-4 sm:px-6 lg:px-8 py-16 sm:py-20 relative">
          <motion.div initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} className="max-w-3xl">
            <h1 className="mb-5" style={{ fontSize: "clamp(2rem, 5vw, 3.5rem)", fontWeight: 900, lineHeight: 1.05, letterSpacing: "-0.02em" }}>
              IPPOO ASSURANCE,<br />{t.about.titleA} {t.about.titleAccent}
            </h1>
            <p className="text-white/65 max-w-2xl" style={{ fontSize: "1.0625rem", lineHeight: 1.85 }}>
              {t.about.lead}
            </p>
          </motion.div>
        </div>
      </section>

      {/* STATS */}
      <section className="py-14 bg-white border-b border-border/30">
        <div className="max-w-6xl mx-auto px-4 sm:px-6 lg:px-8 grid grid-cols-2 lg:grid-cols-4 gap-6">
          {stats.map((s, i) => (
            <motion.div key={s.label} initial={{ opacity: 0, y: 15 }} whileInView={{ opacity: 1, y: 0 }} viewport={{ once: true }} transition={{ delay: i * 0.08 }}
              className="text-center">
              <p style={{ fontSize: "clamp(1.75rem, 3.5vw, 2.5rem)", fontWeight: 900, color: "#0B6E4F", letterSpacing: "-0.02em" }}>{s.value}</p>
              <p className="text-muted-foreground mt-1" style={{ fontSize: "0.8125rem", fontWeight: 600 }}>{s.label}</p>
            </motion.div>
          ))}
        </div>
      </section>

      {/* MISSION / VISION */}
      <section className="py-16 sm:py-24 bg-[#f7f8fa]">
        <div className="max-w-6xl mx-auto px-4 sm:px-6 lg:px-8 grid grid-cols-1 lg:grid-cols-2 gap-12 items-center">
          <motion.div initial={{ opacity: 0, x: -20 }} whileInView={{ opacity: 1, x: 0 }} viewport={{ once: true }}>
            <div className="rounded-3xl overflow-hidden aspect-[5/4] shadow-xl">
              <ImageWithFallback src={missionImg} alt="Groupe de bénéficiaires IPPOO" className="w-full h-full object-cover" loading="lazy" decoding="async" />
            </div>
          </motion.div>
          <motion.div initial={{ opacity: 0, x: 20 }} whileInView={{ opacity: 1, x: 0 }} viewport={{ once: true }} className="space-y-6">
            <div className="space-y-4">
              <Block icon={Target} label="Mission" title="Une assurance digne et accessible pour celles et ceux que l'on n'assure jamais"
                body="Notre mission est claire : démocratiser l'assurance là où elle n'est jamais arrivée. Pour 85 % des actifs béninois commerçants de marché, artisans, transporteurs, mamans entrepreneures, agriculteurs un imprévu peut effacer des années d'efforts. IPPOO construit des protections simples, lisibles et abordables, payables en mobile money et activables en un SMS. Une couverture pensée comme un filet collectif, jamais comme une promesse hors de portée." />
              <Block icon={Compass} label="Vision" title="La mutuelle de référence des Béninois qui travaillent"
                body="Notre vision est béninoise et résolument ancrée dans les 12 départements du pays. Nous voulons devenir la première micro-assurance mutualiste du Bénin, avec un million d'assurés actifs et 2 000 points partenaires de proximité, du Littoral à l'Alibori. Une mutuelle moderne, fidèle à la tradition d'entraide béninoise, armée d'outils digitaux et d'une exigence réglementaire stricte pour tenir, partout au Bénin, chacun de ses engagements." />
              <Block icon={Award} label="Promesse" title="Une prise en charge rapide, ou nous remboursons"
                body="Couverture santé, assistance, indemnisation : chez IPPOO, le contrat n'est pas un papier c'est un engagement public. 98 % de nos sinistres sont réglés en moins de 15 jours ouvrés. Au-delà de ce délai, nous remboursons un mois de cotisation, sans condition. Une promesse vérifiable, mesurable, assumée : parce qu'une assurance qui ne tient pas ses délais n'est pas une assurance." />
            </div>
          </motion.div>
        </div>
      </section>

      {/* VALEURS */}
      <section className="py-16 sm:py-24 bg-white">
        <div className="max-w-6xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="max-w-2xl mb-12">
            <h2 className="mb-3" style={{ fontSize: "clamp(1.5rem, 3vw, 2.25rem)", fontWeight: 900, letterSpacing: "-0.02em" }}>Nos valeurs au quotidien</h2>
            <p className="text-muted-foreground" style={{ fontSize: "0.9375rem", lineHeight: 1.8 }}>
              Quatre principes simples guident toutes nos décisions, de la conception d'un produit à l'indemnisation d'un sinistre.
            </p>
          </div>
          <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-5">
            {valeurs.map((v, i) => (
              <motion.div key={v.title} initial={{ opacity: 0, y: 20 }} whileInView={{ opacity: 1, y: 0 }} viewport={{ once: true }} transition={{ delay: i * 0.08 }}
                className="p-6 rounded-2xl bg-[#f7f8fa] border border-border/30 hover:shadow-md transition-shadow">
                <div className="w-12 h-12 rounded-2xl flex items-center justify-center mb-4" style={{ backgroundColor: `${v.color}15` }}>
                  <v.icon className="w-6 h-6" style={{ color: v.color }} />
                </div>
                <h3 className="mb-2" style={{ fontSize: "1.0625rem", fontWeight: 800 }}>{v.title}</h3>
                <p className="text-muted-foreground" style={{ fontSize: "0.875rem", lineHeight: 1.7 }}>{v.desc}</p>
              </motion.div>
            ))}
          </div>
        </div>
      </section>

      {/* HISTOIRE */}
      <section className="py-16 sm:py-24 bg-[#0d1117] text-white relative overflow-hidden">
        <div className="absolute top-10 right-[5%] w-80 h-80 bg-ippoo-green/10 rounded-full blur-[120px]" />
        <div className="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 relative">
          <div className="mb-12">
            <h2 className="mb-3" style={{ fontSize: "clamp(1.5rem, 3vw, 2.25rem)", fontWeight: 900, letterSpacing: "-0.02em" }}>Notre histoire en 5 dates</h2>
            <p className="text-white/55" style={{ fontSize: "0.9375rem", lineHeight: 1.8 }}>De l'idée à 85 000 assurés en quatre ans.</p>
          </div>
          <ol className="relative border-l border-white/15 ml-2 space-y-8">
            {histoire.map((h, i) => (
              <motion.li key={h.annee} initial={{ opacity: 0, x: -10 }} whileInView={{ opacity: 1, x: 0 }} viewport={{ once: true }} transition={{ delay: i * 0.08 }} className="pl-6">
                <div className="absolute -left-[7px] w-3.5 h-3.5 rounded-full bg-ippoo-green ring-4 ring-ippoo-green/20" />
                <p className="text-ippoo-green mb-1" style={{ fontSize: "0.75rem", fontWeight: 700, letterSpacing: "0.08em", textTransform: "uppercase" }}>{h.annee}</p>
                <h3 className="mb-1" style={{ fontSize: "1.0625rem", fontWeight: 800 }}>{h.titre}</h3>
                <p className="text-white/55" style={{ fontSize: "0.875rem", lineHeight: 1.7 }}>{h.desc}</p>
              </motion.li>
            ))}
          </ol>
        </div>
      </section>

      {/* EQUIPE */}
      <section className="py-16 sm:py-24 bg-white">
        <div className="max-w-6xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="max-w-2xl mb-12">
            <h2 className="mb-3" style={{ fontSize: "clamp(1.5rem, 3vw, 2.25rem)", fontWeight: 900, letterSpacing: "-0.02em" }}>L'équipe dirigeante</h2>
            <p className="text-muted-foreground" style={{ fontSize: "0.9375rem", lineHeight: 1.8 }}>
              Une équipe expérimentée qui réunit l'expertise actuarielle, la connaissance terrain et la maîtrise du digital.
            </p>
          </div>
          <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-5">
            {equipe.map((m, i) => (
              <motion.div key={m.nom} initial={{ opacity: 0, y: 20 }} whileInView={{ opacity: 1, y: 0 }} viewport={{ once: true }} transition={{ delay: i * 0.06 }}
                className="p-6 rounded-2xl border border-border/30 hover:shadow-md transition-all">
                <div className="flex items-center gap-4 mb-4">
                  <div className="w-14 h-14 rounded-2xl flex items-center justify-center text-white shrink-0" style={{ backgroundColor: m.color, fontSize: "0.9375rem", fontWeight: 800, letterSpacing: "0.04em" }}>
                    {m.initiales}
                  </div>
                  <div>
                    <p style={{ fontSize: "0.9375rem", fontWeight: 800 }}>{m.nom}</p>
                    <p className="text-muted-foreground" style={{ fontSize: "0.75rem", fontWeight: 600 }}>{m.role}</p>
                  </div>
                </div>
                <p className="text-muted-foreground" style={{ fontSize: "0.8125rem", lineHeight: 1.7 }}>{m.bio}</p>
              </motion.div>
            ))}
          </div>
        </div>
      </section>

      {/* PARTENAIRES */}
      <section className="py-16 sm:py-24 bg-[#f7f8fa]">
        <div className="max-w-6xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="max-w-2xl mb-10">
            <h2 className="mb-3" style={{ fontSize: "clamp(1.5rem, 3vw, 2.25rem)", fontWeight: 900, letterSpacing: "-0.02em" }}>Nos partenaires</h2>
            <p className="text-muted-foreground" style={{ fontSize: "0.9375rem", lineHeight: 1.8 }}>
              Microfinance, banques et opérateurs mobile money : nos partenaires nous permettent d'accompagner les actifs de l'informel au plus près du terrain.
            </p>
          </div>
          <div className="grid grid-cols-2 sm:grid-cols-3 lg:grid-cols-6 gap-4">
            {partenaires.map((p) => {
              const domains: Record<string, string> = {
                FECECAM: "fececam-benin.com",
                CLCAM: "fececam-benin.com",
                NSIA: "groupensia.com",
                ECOBANK: "ecobank.com",
                MOOV: "moov-africa.bj",
                MTN: "mtn.com",
              };
              const logoUrl = `https://logo.clearbit.com/${domains[p.nom]}`;
              return (
                <div key={p.nom} className="flex flex-col items-center justify-center gap-2 bg-white rounded-2xl p-5 border border-border/30 aspect-[4/3] hover:shadow-md transition-shadow">
                  <img src={logoUrl} alt={`${p.nom} logo`} className="max-h-12 max-w-[80%] object-contain" loading="lazy" />
                  <p className="text-muted-foreground text-center" style={{ fontSize: "0.6875rem", fontWeight: 600 }}>{p.type}</p>
                </div>
              );
            })}
          </div>
        </div>
      </section>

      {/* RSE */}
      <section className="py-16 sm:py-24 bg-white">
        <div className="max-w-5xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="grid grid-cols-1 md:grid-cols-2 gap-8 items-start">
            <div>
              <div className="inline-flex items-center gap-2 bg-ippoo-green/10 text-ippoo-green px-3 py-1.5 rounded-full mb-4">
                <Globe2 className="w-3.5 h-3.5" />
                <span style={{ fontSize: "0.6875rem", fontWeight: 700, letterSpacing: "0.05em", textTransform: "uppercase" }}>Engagement RSE</span>
              </div>
              <h2 className="mb-3" style={{ fontSize: "clamp(1.5rem, 3vw, 2.25rem)", fontWeight: 900, letterSpacing: "-0.02em" }}>
                Un acteur engagé pour l'inclusion financière
              </h2>
              <p className="text-muted-foreground" style={{ fontSize: "0.9375rem", lineHeight: 1.8 }}>
                IPPOO réinvestit chaque année <strong>3 % de son chiffre d'affaires</strong> dans des programmes d'éducation financière, de prévention santé et de soutien aux organisations féminines de commerce.
              </p>
            </div>
            <ul className="space-y-3">
              {[
                { icon: Users, t: "Éducation financière", d: "Plus de 12 000 commerçants formés à la gestion de leur budget et de leur stock en 2025." },
                { icon: Heart, t: "Prévention santé", d: "Campagnes mobiles de dépistage du paludisme et de l'hypertension dans 28 marchés." },
                { icon: TrendingUp, t: "Soutien aux mamans entrepreneures", d: "Bourses pour 320 mamans bénéficiaires d'un contrat Maternité IPPOO." },
              ].map((it) => (
                <li key={it.t} className="flex items-start gap-4 p-4 rounded-2xl bg-[#f7f8fa]">
                  <div className="w-10 h-10 rounded-xl bg-ippoo-green/15 flex items-center justify-center shrink-0">
                    <it.icon className="w-5 h-5 text-ippoo-green" />
                  </div>
                  <div>
                    <p style={{ fontSize: "0.9375rem", fontWeight: 800 }}>{it.t}</p>
                    <p className="text-muted-foreground mt-0.5" style={{ fontSize: "0.8125rem", lineHeight: 1.7 }}>{it.d}</p>
                  </div>
                </li>
              ))}
            </ul>
          </div>
        </div>
      </section>

      {/* CTA */}
      <section className="relative py-20 sm:py-24 bg-[#0d1117] text-white overflow-hidden">
        <div className="absolute top-10 right-[20%] w-56 h-56 bg-ippoo-green/15 rounded-full blur-[80px]" />
        <div className="absolute bottom-0 left-[15%] w-40 h-40 bg-[#E65100]/10 rounded-full blur-[60px]" />
        <div className="max-w-3xl mx-auto px-4 sm:px-6 lg:px-8 text-center relative">
          <div className="w-14 h-14 rounded-2xl bg-ippoo-green/15 flex items-center justify-center mx-auto mb-5">
            <Briefcase className="w-7 h-7 text-ippoo-green" />
          </div>
          <h2 className="mb-3" style={{ fontSize: "clamp(1.5rem, 3vw, 2.25rem)", fontWeight: 900, letterSpacing: "-0.02em" }}>
            Rejoignez l'aventure IPPOO
          </h2>
          <p className="text-white/55 mb-8 max-w-lg mx-auto" style={{ fontSize: "0.9375rem", lineHeight: 1.85 }}>
            En tant qu'assuré, en tant que partenaire ou en tant que collaborateur : il y a forcément une place pour vous.
          </p>
          <div className="flex flex-wrap justify-center gap-3">
            <Link to="/devis" className="inline-flex items-center gap-2 bg-white text-[#0d1117] px-6 py-3.5 rounded-xl" style={{ fontSize: "0.875rem", fontWeight: 700 }}>
              Souscrire un contrat <ArrowRight className="w-4 h-4" />
            </Link>
            <Link to="/contact" className="inline-flex items-center gap-2 bg-white/10 backdrop-blur-sm border border-white/15 text-white px-6 py-3.5 rounded-xl hover:bg-white/15" style={{ fontSize: "0.875rem", fontWeight: 600 }}>
              <MapPin className="w-4 h-4 text-[#E65100]" /> Devenir partenaire
            </Link>
          </div>
        </div>
      </section>
    </div>
  );
}

function Block({ icon: Icon, label, title, body }: { icon: React.ElementType; label: string; title: string; body: string }) {
  return (
    <div className="flex items-start gap-4">
      <div className="w-11 h-11 rounded-xl bg-ippoo-green/10 flex items-center justify-center shrink-0">
        <Icon className="w-5 h-5 text-ippoo-green" />
      </div>
      <div>
        <p className="text-ippoo-green mb-1" style={{ fontSize: "0.6875rem", fontWeight: 700, letterSpacing: "0.08em", textTransform: "uppercase" }}>{label}</p>
        <h3 className="mb-1.5" style={{ fontSize: "1.125rem", fontWeight: 800, letterSpacing: "-0.01em" }}>{title}</h3>
        <p className="text-muted-foreground" style={{ fontSize: "0.875rem", lineHeight: 1.75 }}>{body}</p>
      </div>
    </div>
  );
}
