/* create full set of SNOMED CT international release schema and data */

drop schema if exists snomedct cascade;
create schema snomedct;
set schema 'snomedct';

drop table if exists sctid cascade;
create table sctid(
  id bigint not null,
  effectivetime date not null,
  active boolean not null,
  moduleid bigint not null
);

create table concept(
  definitionstatusid bigint not null,
  CONSTRAINT concept_pkey PRIMARY KEY(id, effectivetime, active)
) INHERITS (sctid);

create table description(
  conceptid bigint not null,
  languagecode varchar(2) not null,
  typeid bigint not null,
  term varchar(255) not null,
  casesignificanceid bigint not null,
  CONSTRAINT description_pkey PRIMARY KEY(id, effectivetime, active)
) INHERITS (sctid);

create table relationship(
  sourceid bigint not null,
  destinationid bigint not null,
  relationshipgroup INTEGER not null,
  typeid bigint not null,
  characteristictypeid bigint not null,
  modifierid bigint not null,
  CONSTRAINT relationship_pkey PRIMARY KEY(id, effectivetime, active)
) INHERITS (sctid);

create table stated_relationship(
  sourceid bigint not null,
  destinationid bigint not null,
  relationshipgroup integer not null,
  typeid bigint not null,
  characteristictypeid bigint not null,
  modifierid bigint not null,
  CONSTRAINT stated_relationship_pkey PRIMARY KEY(id, effectivetime, active)
) INHERITS (sctid);

drop table if exists refset cascade;
create table refset(
  id uuid not null,
  effectivetime date not null,
  active boolean not null,
  moduleid bigint not null,
  refsetid bigint not null,
  referencedcomponentid bigint not null
);

create table refset_language(
  acceptabilityid bigint not null,
  CONSTRAINT refset_language_pkey PRIMARY KEY(id, effectivetime, active)
) inherits (refset);

create table refset_association(
  targetcomponentid bigint not null,
  CONSTRAINT refset_association_pkey PRIMARY KEY(id, effectivetime, active)
) inherits (refset);

create table refset_attributevalue(
  valueid bigint not null,
  CONSTRAINT refset_attributevalue_pkey PRIMARY KEY(id, effectivetime, active)
) inherits (refset);

create table refset_simplemap(
  maptarget varchar(32) not null,
  CONSTRAINT refset_simplemap_pkey PRIMARY KEY(id, effectivetime, active)
) inherits (refset);

create table refset_simple(
  CONSTRAINT refset_simple_pkey PRIMARY KEY(id, effectivetime, active)
) inherits (refset);

create table refset_complexmap(
  mapGroup integer not null,
  mapPriority integer not null,
  mapRule text,
  mapAdvice text,
  mapTarget varchar(32),
  correlationId bigint not null,
  CONSTRAINT refset_complexmap_pkey PRIMARY KEY(id, effectivetime, active)
) inherits (refset);
