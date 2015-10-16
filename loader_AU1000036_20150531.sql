set schema 'snomedct';

DO $$
DECLARE 
  folder TEXT := 'C:\';
  type TEXT := 'Delta';
  release TEXT := 'AU1000036_20150531';
BEGIN
  EXECUTE 'COPY concept(id, effectivetime, active, moduleid, definitionstatusid) FROM ''' 
        || folder || '\Terminology\sct2_Concept_' || type || '_' release || '.txt'' WITH (FORMAT csv, HEADER true, DELIMITER ''	'')';
  EXECUTE 'COPY description(id, effectivetime, active, moduleid, conceptid, languagecode, typeid, term, casesignificanceid) FROM '''
        || folder || '\Terminology\sct2_Description_' || type || '_' release || '.txt'' WITH (FORMAT csv, HEADER true, DELIMITER ''	'')';
  EXECUTE 'COPY relationship(id, effectivetime, active, moduleid, sourceid, destinationid, relationshipgroup, typeid,characteristictypeid, modifierid) FROM '''
        || folder || '\Terminology\sct2_Relationship_' || type || '_' release || '.txt'' WITH (FORMAT csv, HEADER true, DELIMITER ''	'')';
        
  DROP TABLE IF EXISTS refset_language CASCADE;
  CREATE TABLE refset_language(
    acceptabilityid bigint not null,
    CONSTRAINT refset_language_pkey PRIMARY KEY(id, effectivetime, active)
  ) INHERITS (refset);
  EXECUTE 'COPY refset_language(id, effectivetime, active, moduleid, refsetid, referencedcomponentid, acceptabilityid) FROM '''
        || folder || '\Refset\Language\der2_cRefset_Language' || type || '-en-AU_' release || '.txt'' WITH (FORMAT csv, HEADER true, DELIMITER ''	'')';
  
  DROP TABLE IF EXISTS refset_refetdescriptor CASCADE;
  CREATE TABLE refset_refetdescriptor(
    attributedescription bigint not null,
    attributetype bigint not null,
    attributeorder integer not null,
    CONSTRAINT refset_refetdescriptor_pkey PRIMARY KEY(id, effectivetime, active)
  ) INHERITS (refset);
  EXECUTE 'COPY refset_refetdescriptor(id, effectivetime, active, moduleid, refsetid, referencedcomponentid, attributedescription, attributetype, attributeorder) FROM '''
        || folder || '\Refset\Metadata\der2_cciRefset_RefsetDescriptor' || type || '-en-AU_' release || '.txt'' WITH (FORMAT csv, HEADER true, DELIMITER ''	'')';
  
  DROP TABLE IF EXISTS refset_descriptiontype CASCADE;
  CREATE TABLE refset_descriptiontype(
    descriptionFormat bigint not null,
    descriptionLength integer not null,
    CONSTRAINT refset_descriptiontype_pkey PRIMARY KEY(id, effectivetime, active)
  ) INHERITS (refset);
  EXECUTE 'COPY refset_refetdescriptor(id, effectivetime, active, moduleid, refsetid, referencedcomponentid, descriptionFormat, descriptionLength) FROM '''
        || folder || '\Refset\Metadata\der2_ciRefset_DescriptionType' || type || '-en-AU_' release || '.txt'' WITH (FORMAT csv, HEADER true, DELIMITER ''	'')';
  
  DROP TABLE IF EXISTS refset_ModuleDependency CASCADE;
  CREATE TABLE refset_ModuleDependency(
    sourceEffectiveTime date not null,
    targetEffectiveTime date not null,
    CONSTRAINT refset_ModuleDependency_pkey PRIMARY KEY(id, effectivetime, active)
  ) INHERITS (refset);
  EXECUTE 'COPY refset_refetdescriptor(id, effectivetime, active, moduleid, refsetid, referencedcomponentid, sourceEffectiveTime, targetEffectiveTime) FROM '''
        || folder || '\Refset\Metadata\der2_ssRefset_ModuleDependency' || type || '-en-AU_' release || '.txt'' WITH (FORMAT csv, HEADER true, DELIMITER ''	'')';
END $$;
