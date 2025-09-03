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
