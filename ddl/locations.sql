-- locations.sql
-- Purpose: Stores location/facility information with geographical and operational details
-- Database: MySQL
-- Last Updated: Depends on the dev involvment , and new locations onboarding / updating location status

CREATE TABLE `locations` (
  `id` int NOT NULL AUTO_INCREMENT,                    -- Mainly used column for joins 
  `alias` varchar(100) DEFAULT NULL,                   -- Location nickname / alias
  `address_id` int NOT NULL,                           -- FK to address table
  `pincode_id` int DEFAULT NULL,                       -- FK to pincode table
  `city_id` int DEFAULT NULL,                          -- FK to city table
  `gstNumber` varchar(255) DEFAULT NULL,               -- GST registration number
  `entity_type` varchar(65) DEFAULT NULL,              -- Type of entity (PARTNER,CUSTOMER etc.) Mostly we fetch for partner by default through joins itslef.
  `entity_id` int DEFAULT NULL,                        -- FK to entity table -> This is most of the time mapped to partners p table on p.id
  `creator_type` varchar(65) DEFAULT NULL,             -- 
  `creator_id` int DEFAULT NULL,                       -- 
  `status` tinyint unsigned DEFAULT NULL,              -- Location status (active/inactive)
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `location_hash` varchar(45) DEFAULT NULL,            -- Unique hash identifier
  `default_user_id` int DEFAULT NULL,                  -- Default assigned user
  `geofence_radius` double NOT NULL DEFAULT '5',       -- Geofence radius in km
  `billing_name` varchar(255) DEFAULT NULL,            -- Name for billing purposes
  `location_ops_type` varchar(128) DEFAULT NULL,       -- One of the main filters used in queries to filter location types , EXAMPLE : 'FM','SC,'LM', etc...
  `parent_location_id` int DEFAULT NULL,               -- 
  `cluster_name` varchar(32) DEFAULT NULL,             -- 
  `hub_contact_number` varchar(100) DEFAULT NULL,      -- 
  `client_location_name` varchar(100) DEFAULT NULL,    -- Client-specific location name , This is used as a text search filter for location name
  `is_valmo_location` tinyint NOT NULL DEFAULT '0',    -- Flag for Valmo locations
  `sorter_user_id` bigint DEFAULT NULL,                -- FK to sorter user
  
  PRIMARY KEY (`id`),
  UNIQUE KEY `location_hash_UNIQUE` (`location_hash`),
  KEY `UPDATE_AT_INDEX` (`updated_at`),
  KEY `locations_pincode_id_IDX` (`pincode_id`) USING BTREE,
  KEY `locations_address_id_IDX` (`address_id`) USING BTREE,
  KEY `locations_entity_id_IDX` (`entity_id`) USING BTREE,
  KEY `locations_alias_IDX` (`alias`) USING BTREE,
  KEY `locations_entity_type_IDX` (`entity_type`) USING BTREE,
  KEY `alias_index` (`alias`),
  KEY `parent_location_id_indx` (`parent_location_id`),
  KEY `locations_creator_id_IDX` (`creator_id`) USING BTREE,
  KEY `locations_location_ops_type_IDX` (`location_ops_type`),
  KEY `locations_client_location_name_IDX` (`client_location_name`),
  KEY `locations_sorter_user_id_IDX` (`sorter_user_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5902096 DEFAULT CHARSET=utf8mb3;



Sample data :


INSERT INTO locations (id, alias, status, entity_type, location_ops_type, client_location_name, created_at) VALUES
5902095	JXR (MEESHO Pickup)	247912467	6465	187		CUSTOMER	10823	PARTNER	268	1	2025-09-02 19:16:29	2025-09-02 19:16:29	a9dd069114251d1a89c28e0b8cc334fb		5.0	JXR (MEESHO Pickup)						0	
5902094	JXR	247912467	6465	187		PARTNER	129793	PARTNER	129793	1	2025-09-02 19:16:29	2025-09-02 19:16:29	65b09af99c366e87178cbbd4c11f3a4b		5.0	JXR	FM				JXR	1	
5902093	W1/BHS/9/IZ3 (MEESHO Pickup)	247871488	7351	230		CUSTOMER	10823	PARTNER	268	1	2025-09-02 15:50:27	2025-09-02 15:50:27	27e3d48b9cebf011b0122ecf10054d3d		5.0	W1/BHS/9/IZ3 (MEESHO Pickup)						0	
5902092	W1/BHS/9/IZ3	247871488	7351	230		PARTNER	135064	PARTNER	135064	1	2025-09-02 15:50:27	2025-09-02 15:50:27	42982031edde96435185df1b4879047d		5.0	W1/BHS/9/IZ3	LM				IZ3	1	
5902091	W2/BWS/5/IU7 (MEESHO Pickup)	247871210	5591	189		CUSTOMER	10823	PARTNER	268	1	2025-09-02 15:49:02	2025-09-02 15:49:02	abdad66df42e04ba02550e0f7e9e5bca		5.0	W2/BWS/5/IU7 (MEESHO Pickup)						0	

