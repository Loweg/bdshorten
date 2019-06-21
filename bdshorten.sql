CREATE TABLE public.links (
    id SERIAL PRIMARY KEY,
    symbol text UNIQUE NOT NULL,
    destination text NOT NULL,
    "timestamp" timestamp with time zone DEFAULT current_timestamp NOT NULL,
    expiry timestamp with time zone,
    deleted boolean DEFAULT false NOT NULL,
    CONSTRAINT links_check CHECK ((expiry > "timestamp"))
);

CREATE VIEW public.validlinks AS
 SELECT links.id,
    links.symbol,
    links.destination,
    links."timestamp",
    links.expiry,
    links.deleted
   FROM public.links
  WHERE (((links.expiry IS NULL) OR (links.expiry > CURRENT_TIMESTAMP)) AND (NOT links.deleted));