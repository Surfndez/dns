D(DOMAIN, REGISTRAR, DnsProvider(PROVIDER),

  // Publish CAA records indicating that only letsencrypt should issue certificates

  CAA("@", "issue", "letsencrypt.org", CF_TTL_ANY),
  CAA("@", "issuewild", "letsencrypt.org", CF_TTL_ANY),
  CAA("@", "iodef", "mailto:hostmaster@openstreetmap.org"),

  // Let google handle email

  MX("@", 1, "aspmx.l.google.com.", TTL("1h")),
  MX("@", 5, "alt1.aspmx.l.google.com.", TTL("1h")),
  MX("@", 5, "alt2.aspmx.l.google.com.", TTL("1h")),
  MX("@", 10, "alt3.aspmx.l.google.com.", TTL("1h")),
  MX("@", 10, "alt4.aspmx.l.google.com.", TTL("1h")),

  // Aliases for google services

  CNAME("login", "ghs.google.com."),

  // Main web server and it's aliases

  A("@", "193.60.236.19", TTL("10m")),
  A("www", "193.60.236.19", TTL("10m")),
  A("2020", "193.60.236.19", TTL("10m")),
  A("2019", "193.60.236.19", TTL("10m")),
  A("2018", "193.60.236.19", TTL("10m")),
  A("2017", "193.60.236.19", TTL("10m")),
  A("2016", "193.60.236.19", TTL("10m")),
  A("2014", "193.60.236.19", TTL("10m")),
  A("2013", "193.60.236.19", TTL("10m")),
  A("2012", "193.60.236.19", TTL("10m")),
  A("2011", "193.60.236.19", TTL("10m")),
  A("2010", "193.60.236.19", TTL("10m")),
  A("2009", "193.60.236.19", TTL("10m")),
  A("2008", "193.60.236.19", TTL("10m")),
  A("2007", "193.60.236.19", TTL("10m"))

);
