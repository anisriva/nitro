/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

CREATE DATABASE IF NOT EXISTS `digicert_com` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `digicert_com`;

CREATE TABLE IF NOT EXISTS `access_permission` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `name` varchar(255) NOT NULL,
  `scope` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `access_permission_feature_map` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `access_permission_id` int(10) unsigned NOT NULL,
  `feature_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `access_role` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(512) DEFAULT NULL,
  `internal_description` varchar(512) DEFAULT NULL,
  `api_role` tinyint(4) NOT NULL DEFAULT 0,
  `is_admin` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=130584 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `access_role_permission` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `access_role_id` int(10) unsigned NOT NULL,
  `access_permission_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_access_role_id_permission_id` (`access_role_id`,`access_permission_id`)
) ENGINE=InnoDB AUTO_INCREMENT=540 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `access_user_role_map` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `access_role_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_user_id_access_role_id` (`user_id`,`access_role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=768661 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `accounts` (
  `id` int(6) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `type` enum('retail','enterprise','grid','hisp') NOT NULL DEFAULT 'retail',
  `acct_type` tinyint(1) DEFAULT 0,
  `acct_class_id` smallint(5) unsigned DEFAULT 1,
  `acct_status` tinyint(1) DEFAULT 0,
  `is_enterprise` tinyint(1) NOT NULL DEFAULT 0,
  `reseller_id` int(11) NOT NULL DEFAULT 0,
  `primary_company_id` int(11) NOT NULL DEFAULT 0,
  `discount_id` int(5) unsigned zerofill DEFAULT 00000,
  `acct_create_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `allow_trial` tinyint(1) NOT NULL DEFAULT 0,
  `show_addr_on_seal` tinyint(1) NOT NULL DEFAULT 0,
  `renewal_notice_email` varchar(50) NOT NULL DEFAULT '60' COMMENT 'Number of days before the expiration of certificates to send a renewal email',
  `renewal_notice_phone` varchar(50) NOT NULL DEFAULT '30' COMMENT 'Number of days before the expiration of certificates to call to remind about renewal.',
  `vip` tinyint(1) NOT NULL DEFAULT 0,
  `send_minus_104` tinyint(1) DEFAULT 1,
  `send_minus_90` tinyint(1) DEFAULT 1,
  `send_minus_60` tinyint(1) DEFAULT 1,
  `send_minus_30` tinyint(1) DEFAULT 1,
  `send_minus_7` tinyint(1) DEFAULT 1,
  `send_minus_3` tinyint(1) DEFAULT 1,
  `send_plus_7` tinyint(1) DEFAULT 1,
  `make_renewal_calls` tinyint(1) DEFAULT 1,
  `receipt_note` text DEFAULT NULL,
  `cert_format` enum('attachment','plaintext') DEFAULT 'attachment',
  `default_root_path` enum('digicert','entrust','cybertrust') DEFAULT 'digicert',
  `compat_root_path` enum('entrust','cybertrust') NOT NULL DEFAULT 'cybertrust',
  `prefer_global_root` tinyint(4) DEFAULT 1,
  `account_options` set('limit_dcvs','reissue_no_revoke','is_mvp_enabled','no_auto_dcv','hide_subscriber_agreement','ip_locked','dc_guid_allowed','no_collect_email','also_email_unit_members','dont_prefill_deposit_info','allow_cname_dcvs','key_usage_critical_false','po_disabled','no_invoice_email','no_invoice_mail','basic_constraints_critical_false','session_roaming','no_autofill_po_billto','ev_cs_device_locking','default_no_admin_dcvs','dcv_only_show_approvable','force_no_admin_dcvs','_wc_sans','has_limited_admins','ssl_data_encipherment_option','ssl_radius_eku_option','no_auto_invoice','use_org_unit','cloud_retail_api','im_session','restrict_manual_dcvs','no_auto_resend_dcv') DEFAULT NULL,
  `account_tags` varchar(100) DEFAULT '',
  `max_referrals` int(11) NOT NULL DEFAULT 3,
  `acct_death_date` date DEFAULT NULL,
  `gsa` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `max_uc_names` smallint(3) unsigned NOT NULL DEFAULT 0,
  `i18n_language_id` tinyint(4) unsigned DEFAULT 1,
  `namespace_protected` tinyint(4) NOT NULL DEFAULT 0,
  `acct_rep_staff_id` int(10) unsigned DEFAULT 0,
  `dev_staff_id` int(10) unsigned DEFAULT NULL,
  `client_mgr_staff_id` int(10) unsigned DEFAULT NULL,
  `force_password_change_days` smallint(5) unsigned NOT NULL DEFAULT 0,
  `enabled_apis` set('client_cert_api','advanced_api','grid_api','wildcard_api','shopify_api','yahoo_api','simple_api','retail_api','inpriva_api','direct_api','hisp_api','fbca_api','gtld_api') DEFAULT NULL,
  `first_order_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `invoice_notes` text DEFAULT NULL,
  `ssl_ca_cert_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_testing` tinyint(4) NOT NULL DEFAULT 0,
  `balance_negative_limit` int(11) DEFAULT NULL,
  `balance_reminder_threshold` int(11) DEFAULT NULL,
  `cert_transparency` enum('default','on','logonly','ocsp','embed','off') NOT NULL DEFAULT 'embed',
  `use_existing_commission_rate` tinyint(4) NOT NULL DEFAULT 0,
  `partner_user_id` int(11) NOT NULL DEFAULT 0,
  `tfa_enabled` tinyint(4) NOT NULL DEFAULT 0,
  `tfa_show_remember_checkbox` tinyint(4) NOT NULL DEFAULT 0,
  `show_hidden_products` varchar(255) DEFAULT NULL,
  `has_limited_admins` tinyint(3) NOT NULL DEFAULT 0,
  `require_agreement` tinyint(3) NOT NULL DEFAULT 0,
  `agreement_id` int(10) unsigned DEFAULT NULL,
  `agreement_ip` varchar(50) DEFAULT NULL,
  `agreement_user_id` int(10) unsigned DEFAULT NULL,
  `agreement_date` timestamp NULL DEFAULT NULL,
  `express_installer` tinyint(4) DEFAULT 0,
  `is_cert_central` tinyint(4) DEFAULT 0,
  `last_note_date` datetime DEFAULT NULL,
  `display_rep` tinyint(4) DEFAULT 1,
  `acct_origin` set('digi','vz','azr','certcent','venafi','google','marketing') DEFAULT 'digi',
  `lead_source` varchar(255) DEFAULT NULL,
  `zero_balance_email` tinyint(4) DEFAULT 1,
  `test_cert_lifetime` int(11) DEFAULT 3,
  PRIMARY KEY (`id`),
  KEY `accounts_create_date` (`acct_create_date`),
  KEY `accounts_is_enterprise` (`is_enterprise`),
  KEY `accounts_renewal_notice_phone` (`renewal_notice_phone`(5)),
  KEY `reseller` (`id`,`reseller_id`),
  KEY `acct_type` (`acct_type`),
  KEY `primary_company_id` (`primary_company_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1588884 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `account_agreement_audit_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `agreement_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `ip_address` varchar(40) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2301297 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `account_agreement_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `agreement_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `ip_address` varchar(40) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `account_agreement_idx` (`account_id`,`agreement_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2493750 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `account_auth_key` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` int(10) unsigned NOT NULL,
  `auth_key_id` varchar(64) NOT NULL,
  `is_active` tinyint(3) unsigned NOT NULL DEFAULT 1,
  `date_created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_account_id` (`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1717 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `account_ca_map` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `ca_cert_id` int(11) NOT NULL,
  `csr_type` enum('any','rsa','ecc') NOT NULL DEFAULT 'any',
  `signature_hash` enum('any','sha1','sha2-any','sha256','sha384','sha512') NOT NULL DEFAULT 'any',
  PRIMARY KEY (`id`),
  KEY `account_id` (`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=241 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `account_class_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `account_class_id` int(11) NOT NULL,
  `old_account_class_id` int(11) NOT NULL,
  `staff_id` int(11) NOT NULL,
  `change_time` datetime DEFAULT NULL,
  `acct_rep_staff_id` int(11) DEFAULT NULL,
  `old_acct_rep_staff_id` int(11) DEFAULT NULL,
  `dev_staff_id` int(11) DEFAULT NULL,
  `old_dev_staff_id` int(11) DEFAULT NULL,
  `client_mgr_staff_id` int(11) DEFAULT NULL,
  `old_client_mgr_staff_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_account_id` (`account_id`),
  KEY `idx_staff_id` (`staff_id`)
) ENGINE=InnoDB AUTO_INCREMENT=38334 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `account_client_ca_profiles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `acct_id` int(6) unsigned NOT NULL,
  `product_id` int(10) unsigned NOT NULL,
  `cert_template_id` int(10) unsigned NOT NULL,
  `ca_cert_id` smallint(5) unsigned NOT NULL,
  `legacy_ca_cert_id` smallint(5) unsigned NOT NULL,
  `is_private` tinyint(3) unsigned NOT NULL,
  `is_active` tinyint(3) unsigned NOT NULL,
  `is_email_domain_validation_required` tinyint(3) unsigned NOT NULL,
  `is_email_delivery_required` tinyint(3) unsigned NOT NULL,
  `max_lifetime` tinyint(3) unsigned NOT NULL,
  `internal_description` varchar(255) DEFAULT NULL,
  `display_sort_id` smallint(6) NOT NULL DEFAULT 0,
  `api_id` varchar(255) DEFAULT NULL,
  `container_id` int(10) unsigned DEFAULT NULL,
  `api_group_name` varchar(45) DEFAULT NULL,
  `unique_common_name_required` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `ascii_sanitize_request` tinyint(3) DEFAULT 0,
  `api_delivery_only` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `allow_sans` tinyint(3) unsigned DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `api_id_UNIQUE` (`api_id`),
  KEY `acct_id` (`acct_id`),
  KEY `cert_template_id` (`cert_template_id`)
) ENGINE=InnoDB AUTO_INCREMENT=260 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `account_commission_rates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `acct_id` int(10) unsigned DEFAULT NULL,
  `commission_id` int(10) unsigned DEFAULT NULL,
  `date_started` date DEFAULT NULL,
  `date_ended` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12514 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `account_descendant_map` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int(10) unsigned NOT NULL,
  `child_id` int(10) unsigned NOT NULL,
  `child_account_level` int(10) unsigned NOT NULL DEFAULT 1,
  `managed_by_user_id` int(10) unsigned DEFAULT NULL,
  `child_name` varchar(64) DEFAULT NULL,
  `hidden` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_parent_id_child_id` (`parent_id`,`child_id`),
  UNIQUE KEY `ix_child_id_parent_id` (`child_id`,`parent_id`),
  KEY `ix_account_level` (`child_account_level`),
  KEY `ix_account_manager` (`managed_by_user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=32689 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `account_discount_rate_expirations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL DEFAULT 0,
  `discount_id` int(11) NOT NULL DEFAULT 0,
  `expiration_date` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_account_id` (`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=34343 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `account_funds` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` int(10) unsigned NOT NULL,
  `container_id` int(10) unsigned NOT NULL,
  `acct_adjust_id` int(10) unsigned NOT NULL,
  `created` datetime NOT NULL DEFAULT current_timestamp(),
  `expiration` datetime NOT NULL DEFAULT current_timestamp(),
  `started` datetime DEFAULT NULL,
  `amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `balance` decimal(10,2) NOT NULL DEFAULT 0.00,
  `status` enum('active','consumed','expired') NOT NULL DEFAULT 'active',
  PRIMARY KEY (`id`),
  KEY `idx_account_id` (`account_id`),
  KEY `idx_container_id` (`container_id`),
  KEY `idx_status` (`status`),
  KEY `idx_expiration` (`expiration`),
  KEY `idx_acct_adjust_id` (`acct_adjust_id`)
) ENGINE=InnoDB AUTO_INCREMENT=124870 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `account_funds_expiry_notices` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `account_funds_id` int(10) unsigned NOT NULL,
  `minus_0_sent` tinyint(1) NOT NULL DEFAULT 0,
  `minus_3_sent` tinyint(1) NOT NULL DEFAULT 0,
  `minus_7_sent` tinyint(1) NOT NULL DEFAULT 0,
  `minus_14_sent` tinyint(1) NOT NULL DEFAULT 0,
  `minus_30_sent` tinyint(1) NOT NULL DEFAULT 0,
  `minus_60_sent` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_account_funds_id` (`account_funds_id`),
  KEY `idx_minus_0_sent` (`minus_0_sent`),
  KEY `idx_minus_3_sent` (`minus_3_sent`),
  KEY `idx_minus_7_sent` (`minus_7_sent`),
  KEY `idx_minus_14_sent` (`minus_14_sent`),
  KEY `idx_minus_30_sent` (`minus_30_sent`),
  KEY `idx_minus_60_sent` (`minus_60_sent`)
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `account_modification` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(40) NOT NULL DEFAULT '',
  `description` varchar(100) DEFAULT NULL,
  `configuration` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `account_origin_cookies` (
  `acct_id` int(6) unsigned zerofill NOT NULL,
  `utmv` varchar(255) DEFAULT NULL,
  `initial_page` varchar(255) DEFAULT NULL COMMENT 'The url for the landing page.',
  `referer` varchar(255) DEFAULT NULL COMMENT 'The url that referred the user to the landing page.',
  `search_term` varchar(100) DEFAULT NULL,
  `query_string` varchar(100) DEFAULT NULL,
  `date_recorded` datetime DEFAULT NULL,
  `medium` varchar(64) DEFAULT NULL,
  `source` varchar(64) DEFAULT NULL,
  `campaign` varchar(64) DEFAULT NULL,
  `date_landed` datetime DEFAULT NULL COMMENT 'The date the landing page was hit.',
  `ip` varchar(45) DEFAULT NULL COMMENT 'The IP address of the user who created the account. IPv4 (15 chars), IPv6 (39 chars) IPv6 notation for IPv4 (45 chars)',
  PRIMARY KEY (`acct_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `account_ou_cert_request_map` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` int(10) unsigned NOT NULL,
  `ou_value` varchar(255) NOT NULL,
  `certificate_request_id` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_account_ou_cert_request` (`account_id`,`ou_value`,`certificate_request_id`),
  KEY `ix_ou_value` (`ou_value`)
) ENGINE=InnoDB AUTO_INCREMENT=644336 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `account_private_ca_certs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `acct_id` int(6) unsigned NOT NULL,
  `ca_cert_id` smallint(5) unsigned NOT NULL,
  `container_id` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `acct_ca_cert_id` (`acct_id`,`ca_cert_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2243 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `account_product_map` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `product_name_id` varchar(64) NOT NULL,
  `require_tos` tinyint(4) NOT NULL DEFAULT 1,
  `date_created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_account_product` (`account_id`,`product_name_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15817743 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `account_reseller_info` (
  `acct_id` int(6) unsigned zerofill NOT NULL DEFAULT 000000,
  `max_partner_discount` tinyint(3) unsigned NOT NULL DEFAULT 10,
  `existing_customer_commission_rate` tinyint(3) unsigned NOT NULL DEFAULT 10,
  `commission_id` int(5) unsigned NOT NULL DEFAULT 0,
  `incentive_plan` tinyint(4) NOT NULL DEFAULT 0,
  `flag` tinyint(2) NOT NULL DEFAULT 0,
  `rsl_effective_date` date NOT NULL DEFAULT '0000-00-00',
  `rsl_cancel_date` date NOT NULL DEFAULT '0000-00-00',
  `rsl_cancel_reason` text NOT NULL,
  `rsl_reject_reason` text NOT NULL,
  `rsl_agreement_id` int(10) unsigned NOT NULL DEFAULT 0,
  `rsl_apply_date` date NOT NULL DEFAULT '0000-00-00',
  `rsl_pay_type` enum('acct_credit','check') NOT NULL DEFAULT 'acct_credit',
  `allowed_products` varchar(255) NOT NULL,
  `domain` varchar(255) DEFAULT NULL,
  `company_type_id` tinyint(3) unsigned DEFAULT NULL,
  `company_type_other` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`acct_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `account_settings` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL DEFAULT current_timestamp(),
  `account_id` int(10) unsigned NOT NULL,
  `name` varchar(64) NOT NULL,
  `value` text DEFAULT NULL,
  `read_only` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_account_id_name` (`account_id`,`name`),
  KEY `idx_name` (`name`(11))
) ENGINE=InnoDB AUTO_INCREMENT=1200387 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `acct_adjust` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `acct_id` int(6) unsigned zerofill NOT NULL DEFAULT 000000,
  `unit_id` int(11) unsigned NOT NULL DEFAULT 0,
  `order_id` int(8) unsigned zerofill NOT NULL DEFAULT 00000000,
  `ent_client_cert_id` int(10) NOT NULL DEFAULT 0,
  `adjust_type` tinyint(3) DEFAULT NULL,
  `amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `staff_id` int(10) NOT NULL DEFAULT 0,
  `note` mediumtext DEFAULT NULL,
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `balance_after` decimal(10,2) NOT NULL DEFAULT 0.00,
  `balance_breakdown` mediumtext DEFAULT NULL,
  `receipt_id` int(10) NOT NULL DEFAULT 0,
  `confirmed` tinyint(1) NOT NULL DEFAULT 1,
  `confirmed_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `confirmed_staff` int(10) NOT NULL DEFAULT 5,
  `prev_type` tinyint(3) DEFAULT NULL,
  `confirm_note` mediumtext DEFAULT NULL,
  `po_id` int(10) unsigned DEFAULT NULL,
  `container_id` int(10) unsigned DEFAULT NULL,
  `netsuite_invoice_id` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `acct_id` (`acct_id`),
  KEY `receipt_id` (`receipt_id`),
  KEY `unit_id` (`unit_id`),
  KEY `idx_order_id` (`order_id`),
  KEY `idx_container_id` (`container_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4578949 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `acct_classes` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `tier` enum('Retail Accounts','Managed Accounts') DEFAULT 'Retail Accounts',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `acct_docs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `acct_id` int(6) unsigned zerofill NOT NULL DEFAULT 000000,
  `filename` varchar(128) NOT NULL DEFAULT '',
  `upload_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `status` tinyint(3) NOT NULL DEFAULT 1,
  `notes` varchar(255) NOT NULL DEFAULT '',
  `is_new` tinyint(1) NOT NULL DEFAULT 1,
  `type` varchar(30) NOT NULL DEFAULT 'agreement',
  `staff_id` int(11) NOT NULL DEFAULT 0,
  `contract_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `acct_docs_a_id_idx` (`acct_id`)
) ENGINE=InnoDB AUTO_INCREMENT=42109 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `acct_flags` (
  `id` tinyint(1) NOT NULL AUTO_INCREMENT,
  `number` tinyint(1) NOT NULL DEFAULT 0,
  `color` varchar(16) NOT NULL DEFAULT '',
  `description` varchar(128) NOT NULL DEFAULT '',
  `color_code` varchar(7) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `acct_notes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `acct_id` int(8) unsigned zerofill DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `note` text DEFAULT NULL,
  `staff_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `acct_id` (`acct_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14205 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `acct_statuses` (
  `id` tinyint(3) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `acct_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` mediumtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `acct_units_adjust` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` int(10) unsigned NOT NULL,
  `contract_id` int(10) unsigned NOT NULL,
  `unit_bundle_id` int(11) DEFAULT NULL,
  `product_id` int(10) unsigned NOT NULL,
  `order_id` int(10) unsigned NOT NULL,
  `cert_tracker_id` int(10) unsigned DEFAULT NULL,
  `adjust_type` int(10) unsigned NOT NULL,
  `amount` decimal(10,2) DEFAULT 0.00,
  `server_license` int(10) unsigned NOT NULL,
  `staff_id` int(10) unsigned NOT NULL,
  `note` text DEFAULT NULL,
  `created` datetime NOT NULL DEFAULT current_timestamp(),
  `balance_after` decimal(10,2) DEFAULT 0.00,
  `container_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_account_id` (`account_id`),
  KEY `ix_product_id` (`product_id`),
  KEY `ix_order_id` (`order_id`),
  KEY `ix_contract_id` (`contract_id`),
  KEY `ix_unit_bundle_id` (`unit_bundle_id`)
) ENGINE=InnoDB AUTO_INCREMENT=475380 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `acme_api_keys` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `api_permission_id` int(10) unsigned NOT NULL,
  `url_mask` varchar(10) DEFAULT NULL,
  `organization_id` int(10) NOT NULL,
  `product_name_id` varchar(64) NOT NULL,
  `validity_days` int(10) unsigned DEFAULT NULL,
  `validity_years` int(10) unsigned DEFAULT NULL,
  `ssl_profile_option` varchar(32) DEFAULT NULL,
  `container_id` int(10) unsigned DEFAULT NULL,
  `eab_kid` varchar(255) DEFAULT NULL,
  `eab_hmac` varchar(255) DEFAULT NULL,
  `ca_cert_id` varchar(255) DEFAULT NULL,
  `order_validity_days` int(11) DEFAULT NULL,
  `order_validity_years` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_api_permission_id` (`api_permission_id`) USING HASH,
  KEY `ix_container_id` (`container_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4413 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `acme_metadata` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `acme_api_key_id` int(10) unsigned NOT NULL,
  `metadata_id` int(10) unsigned NOT NULL,
  `value` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_acme_api_key_metadata` (`acme_api_key_id`,`metadata_id`)
) ENGINE=InnoDB AUTO_INCREMENT=766 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `additional_order_info` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(10) unsigned NOT NULL,
  `option_name` enum('server_licenses','legacy_product_name','symc_order_id','san_packages','voucher_id','va_status','guest_access') COLLATE utf8mb4_bin NOT NULL,
  `option_value_str` text COLLATE utf8mb4_bin NOT NULL,
  `option_value_int` int(11) unsigned DEFAULT NULL,
  `date_created` datetime NOT NULL DEFAULT current_timestamp(),
  `last_updated` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_order_id_option_name` (`order_id`,`option_name`),
  KEY `ix_order_id` (`order_id`),
  KEY `ix_option_name` (`option_name`),
  KEY `ix_option_value_int` (`option_value_int`)
) ENGINE=InnoDB AUTO_INCREMENT=9198282 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='Order Options Table. One to Many on order_id';

CREATE TABLE IF NOT EXISTS `adjust_types` (
  `id` tinyint(3) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL DEFAULT '',
  `description` varchar(255) NOT NULL DEFAULT '',
  `admin_only` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `agreements` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(50) NOT NULL DEFAULT 'normal_subscriber',
  `acct_id` int(11) NOT NULL DEFAULT 0,
  `effective_date` datetime NOT NULL,
  `end_date` datetime DEFAULT NULL,
  `condition` varchar(50) NOT NULL,
  `text` text NOT NULL,
  `text_es` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `alert` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `account_id` int(11) NOT NULL DEFAULT 0,
  `category` varchar(64) NOT NULL,
  `message` text NOT NULL,
  `start_date` datetime NOT NULL,
  `expiration_date` datetime NOT NULL,
  `display_filters` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_account_id` (`account_id`),
  KEY `idx_expiration_date` (`expiration_date`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `alert_dismissal` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `alert_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_alert_id` (`alert_id`),
  KEY `idx_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `allowed_saml_products` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_name_id` varchar(255) NOT NULL,
  `date_created` datetime NOT NULL,
  `account_id` int(11) DEFAULT NULL,
  `allowed_lifetimes` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `product_name_id_UNIQUE` (`product_name_id`,`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1064 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `api_calls` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `acct_id` int(6) unsigned zerofill NOT NULL DEFAULT 000000,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `action` varchar(32) DEFAULT NULL,
  `ip_address` varchar(15) NOT NULL DEFAULT '',
  `date_time` datetime DEFAULT NULL,
  `data` mediumtext DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=338779 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `api_call_log` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` int(11) unsigned NOT NULL,
  `user_id` int(11) unsigned NOT NULL,
  `api` enum('REST') NOT NULL DEFAULT 'REST',
  `api_key` varchar(255) DEFAULT NULL,
  `remote_ip` int(10) unsigned NOT NULL,
  `call_time` datetime NOT NULL,
  `duration` float(6,2) DEFAULT NULL,
  `method` varchar(15) NOT NULL DEFAULT 'GET',
  `request_url` varchar(125) NOT NULL DEFAULT '',
  `request_headers` text DEFAULT NULL,
  `request_body` text DEFAULT NULL,
  `response_code` int(3) NOT NULL,
  `response_headers` text DEFAULT NULL,
  `response_body` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `acl_account_id` (`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4067969 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `api_log_cc_v2` (
  `hash_id` bigint(20) unsigned NOT NULL,
  `transaction_date` date NOT NULL DEFAULT '0000-00-00',
  `controller` varchar(255) DEFAULT NULL,
  `methods` varchar(16) NOT NULL DEFAULT '',
  `route` varchar(192) NOT NULL DEFAULT '',
  `content_type` varchar(64) NOT NULL DEFAULT '',
  `transaction_count` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`hash_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `api_permissions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `acct_id` int(6) unsigned zerofill NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `hashed_api_key` varchar(255) NOT NULL DEFAULT '',
  `create_date` datetime DEFAULT NULL,
  `last_used_date` datetime DEFAULT NULL,
  `name` varchar(200) DEFAULT NULL,
  `status` enum('active','revoked') DEFAULT 'active',
  `external_id` varchar(255) DEFAULT NULL,
  `key_type` enum('permanent','temporary','acme') NOT NULL DEFAULT 'permanent',
  `validity_minutes` int(11) NOT NULL DEFAULT 0,
  `access_role_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `external_id_UNIQUE` (`external_id`),
  KEY `acct_id` (`acct_id`),
  KEY `user_id` (`user_id`),
  KEY `idx_key_type` (`key_type`) USING HASH
) ENGINE=InnoDB AUTO_INCREMENT=1336655 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `api_permissions_old` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `acct_id` int(6) unsigned zerofill NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `hashed_api_key` varchar(255) NOT NULL DEFAULT '',
  `create_date` datetime DEFAULT NULL,
  `last_used_date` datetime DEFAULT NULL,
  `name` varchar(200) DEFAULT NULL,
  `status` enum('active','revoked') DEFAULT 'active',
  `external_id` varchar(255) DEFAULT NULL,
  `key_type` enum('permanent','temporary','acme') NOT NULL DEFAULT 'permanent',
  `validity_minutes` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `external_id_UNIQUE` (`external_id`),
  KEY `acct_id` (`acct_id`),
  KEY `user_id` (`user_id`),
  KEY `idx_key_type` (`key_type`) USING HASH
) ENGINE=InnoDB AUTO_INCREMENT=1206096 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `audit_bad_address_orders` (
  `order_id` int(10) unsigned NOT NULL,
  `status` varchar(16) NOT NULL DEFAULT 'new',
  `revoked` tinyint(4) NOT NULL DEFAULT 0,
  `reissued` tinyint(4) NOT NULL DEFAULT 0,
  `address_fixed` tinyint(4) NOT NULL DEFAULT 0,
  `prevalidation_expired` tinyint(4) NOT NULL DEFAULT 0,
  `needs_revoke` varchar(16) DEFAULT NULL,
  `batch_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `bad_internal_names` (
  `order_id` int(10) unsigned DEFAULT NULL,
  `last_checked_order` int(10) unsigned DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `blacklisted_domains` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `domain_blacklist_id` int(11) unsigned NOT NULL,
  `match_type` enum('base_domain','extracted_base_domain') NOT NULL,
  `indexed_domain` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `domain_blacklist_id` (`domain_blacklist_id`),
  KEY `indexed_domain` (`indexed_domain`(8))
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `blacklist_cache_dates` (
  `blacklist_name` varchar(100) NOT NULL,
  `date_last_cached` datetime DEFAULT NULL,
  PRIMARY KEY (`blacklist_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `blacklist_consolidated` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `source` varchar(128) NOT NULL,
  `type` varchar(16) NOT NULL DEFAULT '',
  `name` varchar(512) NOT NULL,
  `slim_name` varchar(512) NOT NULL,
  `country_code` varchar(2) NOT NULL DEFAULT '',
  `is_aka` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `ix_slim_name` (`slim_name`(255))
) ENGINE=InnoDB AUTO_INCREMENT=29394 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `blacklist_denied_persons` (
  `name` varchar(255) NOT NULL,
  `slim_name` varchar(255) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `country` char(2) NOT NULL,
  `postal_code` varchar(50) DEFAULT NULL,
  KEY `name` (`name`),
  KEY `country` (`country`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `blacklist_ecfr_orgs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `country` varchar(255) DEFAULT NULL,
  `org_name` text DEFAULT NULL,
  `slim_name` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1611 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `blacklist_ip` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ip` varchar(15) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `blacklist_millersmiles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `date_reported` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_name` (`name`(10))
) ENGINE=InnoDB AUTO_INCREMENT=441904 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `blacklist_phishtank` (
  `phish_id` int(10) DEFAULT NULL,
  `url` text DEFAULT NULL,
  `phish_detail_url` text DEFAULT NULL,
  `submission_time` datetime DEFAULT NULL,
  `verified` tinyint(4) DEFAULT NULL,
  `verification_time` datetime DEFAULT NULL,
  `online` tinyint(4) DEFAULT NULL,
  `target` text DEFAULT NULL,
  `target_slim_name` varchar(200) DEFAULT NULL,
  `base_domain` text DEFAULT NULL,
  KEY `target_slim_name` (`target_slim_name`(12)),
  KEY `base_domain` (`base_domain`(12))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `blacklist_sdn_akas` (
  `id` int(10) unsigned NOT NULL,
  `person_id` int(10) unsigned DEFAULT NULL,
  `aka` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_aka` (`aka`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `blacklist_sdn_orgs` (
  `id` int(10) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `blacklist_sdn_org_akas` (
  `id` int(10) unsigned NOT NULL,
  `person_id` int(10) unsigned DEFAULT NULL,
  `aka` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_aka` (`aka`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `blacklist_sdn_persons` (
  `id` int(10) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `boomi_account_updates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` int(10) unsigned NOT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_account_id` (`account_id`),
  KEY `idx_date_updates` (`date_updated`)
) ENGINE=InnoDB AUTO_INCREMENT=90680 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `boomi_po_updates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `po_id` int(10) unsigned NOT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_po_id` (`po_id`),
  KEY `idx_date_updates` (`date_updated`)
) ENGINE=InnoDB AUTO_INCREMENT=166500 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `canned_notes` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ordering` int(11) NOT NULL DEFAULT 0,
  `category` varchar(50) NOT NULL DEFAULT '',
  `text` varchar(255) NOT NULL DEFAULT '',
  `date_updated` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  `date_deleted` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `case_notes` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` timestamp NOT NULL DEFAULT current_timestamp(),
  `order_id` int(11) unsigned NOT NULL,
  `staff_id` int(11) unsigned NOT NULL,
  `order_action_requested` tinyint(3) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=26966 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `case_note_canned_notes` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `case_note_id` int(11) unsigned NOT NULL,
  `canned_note_id` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=40538 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `ca_calls` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `call_type` varchar(255) NOT NULL DEFAULT '',
  `common_name` varchar(255) NOT NULL DEFAULT '',
  `date_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `order_id` int(8) NOT NULL DEFAULT 0,
  `data` mediumtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `ca_calls_air_gap` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(8) unsigned zerofill NOT NULL DEFAULT 00000000,
  `reissue_id` int(11) NOT NULL DEFAULT 0,
  `duplicate_id` int(11) NOT NULL DEFAULT 0,
  `ent_client_cert_id` int(11) NOT NULL DEFAULT 0,
  `call_type` varchar(255) NOT NULL DEFAULT '',
  `common_name` varchar(255) NOT NULL DEFAULT '',
  `date_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `request_data` mediumtext NOT NULL,
  `response_data` mediumtext NOT NULL,
  `request_id` varchar(50) NOT NULL DEFAULT '0',
  `downloaded_date_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `uploaded_date_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `completed_date_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `ca_cert_info` (
  `ca_cert_id` smallint(5) unsigned NOT NULL,
  `subject_common_name` varchar(255) NOT NULL,
  `subject_org_name` varchar(255) NOT NULL,
  `issuer_common_name` varchar(255) NOT NULL,
  `valid_from` varchar(19) NOT NULL DEFAULT '',
  `valid_to` varchar(19) NOT NULL DEFAULT '',
  `serial_number` varchar(64) NOT NULL,
  `thumbprint` char(40) NOT NULL,
  `signature_hash` varchar(64) NOT NULL,
  `is_private` tinyint(3) unsigned NOT NULL,
  `is_root` tinyint(3) unsigned NOT NULL,
  `issuer_ca_cert_id` smallint(5) unsigned NOT NULL,
  `pem` text NOT NULL,
  `external_id` varchar(40) NOT NULL DEFAULT '',
  `flags` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`ca_cert_id`),
  UNIQUE KEY `serial_number_UNIQUE` (`serial_number`),
  UNIQUE KEY `thumbprint_UNIQUE` (`thumbprint`),
  KEY `flags` (`flags`(12))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `ca_cert_templates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `ca_template_data` text DEFAULT NULL,
  `ui_template_data` text DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `is_key_escrow` tinyint(3) unsigned NOT NULL,
  `private_only` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `ca_intermediates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `thumbprint` varchar(128) NOT NULL DEFAULT '',
  `common_name` varchar(100) NOT NULL DEFAULT '',
  `pem` mediumtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `thumbprint` (`thumbprint`)
) ENGINE=InnoDB AUTO_INCREMENT=1153 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `ca_issued_certs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(8) unsigned zerofill NOT NULL DEFAULT 00000000,
  `reissue_id` int(11) NOT NULL DEFAULT 0,
  `duplicate_id` int(11) NOT NULL DEFAULT 0,
  `ent_client_cert_id` int(11) NOT NULL DEFAULT 0,
  `ctime` timestamp NOT NULL DEFAULT current_timestamp(),
  `common_name` varchar(128) NOT NULL DEFAULT '',
  `valid_from` date NOT NULL DEFAULT '0000-00-00',
  `valid_till` date NOT NULL DEFAULT '0000-00-00',
  `keysize` int(11) NOT NULL DEFAULT 0,
  `serial_number` varchar(36) NOT NULL DEFAULT '',
  `thumbprint` varchar(42) NOT NULL DEFAULT '',
  `ca_order_id` varchar(20) NOT NULL DEFAULT '',
  `sans` text NOT NULL,
  `chain` varchar(32) DEFAULT NULL,
  `pem` mediumtext DEFAULT NULL,
  `ca_cert_id` smallint(6) NOT NULL DEFAULT 0,
  `last_seen` date NOT NULL DEFAULT '1900-01-01',
  `last_seen_ocsp` date NOT NULL DEFAULT '1900-01-01',
  `key_type` enum('ecc','rsa','dsa','dh','') NOT NULL DEFAULT '',
  `sig` enum('','sha1WithRSAEncryption','sha224WithRSAEncryption','sha256WithRSAEncryption','sha384WithRSAEncryption','sha512WithRSAEncryption','sha384ECDSA','sha256ECDSA') NOT NULL DEFAULT '',
  `revoked` tinyint(3) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `ent_client_cert_id` (`ent_client_cert_id`),
  KEY `thumbprint` (`thumbprint`(8)),
  KEY `serial_number` (`serial_number`(8)),
  KEY `ca_order_id` (`ca_order_id`(8)),
  KEY `_idx_valid_till` (`valid_till`),
  KEY `_idx_ctime` (`ctime`)
) ENGINE=InnoDB AUTO_INCREMENT=28029363 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `certcentral_conversion_data_cache` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` int(10) unsigned NOT NULL,
  `account_name` varchar(256) DEFAULT NULL,
  `master_user_email` varchar(256) DEFAULT NULL,
  `master_user_firstname` varchar(64) DEFAULT NULL,
  `master_user_lastname` varchar(64) DEFAULT NULL,
  `account_rep` varchar(64) DEFAULT NULL,
  `account_manager` varchar(64) DEFAULT NULL,
  `conversion_blockers` varchar(1024) DEFAULT NULL,
  `conversion_warnings` varchar(1024) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `active_orders` int(10) unsigned NOT NULL DEFAULT 0,
  `active_client_certs` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_account_id` (`account_id`),
  KEY `idx_date_created` (`date_created`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `certificate_notes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `certificate_tracker_id` int(11) NOT NULL,
  `text` text DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_certificate_tracker_id` (`certificate_tracker_id`)
) ENGINE=InnoDB AUTO_INCREMENT=978986 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `certificate_reissue_notices` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `certificate_tracker_id` int(10) unsigned NOT NULL,
  `minus_90_sent` tinyint(1) NOT NULL DEFAULT 0,
  `minus_60_sent` tinyint(1) NOT NULL DEFAULT 0,
  `minus_30_sent` tinyint(1) NOT NULL DEFAULT 0,
  `minus_7_sent` tinyint(1) NOT NULL DEFAULT 0,
  `minus_3_sent` tinyint(1) NOT NULL DEFAULT 0,
  `plus_7_sent` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `certificate_tracker_id` (`certificate_tracker_id`),
  KEY `minus_90_sent` (`minus_90_sent`),
  KEY `minus_60_sent` (`minus_60_sent`),
  KEY `minus_30_sent` (`minus_30_sent`),
  KEY `minus_7_sent` (`minus_7_sent`),
  KEY `minus_3_sent` (`minus_3_sent`),
  KEY `plus_7_sent` (`plus_7_sent`)
) ENGINE=InnoDB AUTO_INCREMENT=13820 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `certificate_tracker` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `type` tinyint(3) unsigned NOT NULL,
  `public_id` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_public_id` (`public_id`(6))
) ENGINE=InnoDB AUTO_INCREMENT=125977622 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `cert_approvals` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `domain_id` int(11) NOT NULL,
  `name_scope` varchar(255) NOT NULL,
  `standing` enum('yes','no','canceled') NOT NULL,
  `origin` enum('dcv','dal','phone','internal','clone','cname','demo','direct','txt','standing_email','standing_phone') DEFAULT NULL,
  `approver_name` varchar(255) NOT NULL DEFAULT '',
  `approver_email` varchar(255) NOT NULL DEFAULT '',
  `approver_ip` varchar(15) NOT NULL DEFAULT '',
  `staff_id` int(11) NOT NULL DEFAULT 0,
  `staff_note` text DEFAULT NULL,
  `doc_id` int(11) DEFAULT 0,
  `ctime` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `mtime` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `agreement_id` tinyint(4) NOT NULL DEFAULT 0,
  `clone_id` int(11) DEFAULT NULL,
  `approver_dcv_token` varchar(32) DEFAULT NULL,
  `standing_cert_approval_id` int(11) DEFAULT NULL,
  `manual` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `domain_id` (`domain_id`),
  KEY `name_scope` (`name_scope`),
  KEY `standing` (`standing`)
) ENGINE=InnoDB AUTO_INCREMENT=4034520 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `cert_inspector_access_tokens` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `token` varchar(32) NOT NULL DEFAULT '',
  `email` varchar(100) NOT NULL DEFAULT '',
  `firstname` varchar(150) NOT NULL DEFAULT '',
  `lastname` varchar(150) NOT NULL DEFAULT '',
  `organization` varchar(150) NOT NULL DEFAULT '',
  `phone` varchar(25) DEFAULT NULL,
  `phone_extension` varchar(12) DEFAULT NULL,
  `token_first_generated` timestamp NOT NULL DEFAULT current_timestamp(),
  `account_created` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `certificate_inspector_download_2` (`token`),
  UNIQUE KEY `customer_email` (`email`),
  KEY `certificate_inspector_download_token` (`token`)
) ENGINE=InnoDB AUTO_INCREMENT=20263 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `checkboxes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `reference` varchar(50) DEFAULT NULL,
  `name` varchar(1024) NOT NULL,
  `description` text DEFAULT NULL,
  `type` enum('DOMAIN','COMPANY','CONTACT') DEFAULT NULL,
  `note_required` tinyint(1) NOT NULL DEFAULT 0,
  `note_template` text DEFAULT NULL,
  `special_purpose` enum('gtld_reject') DEFAULT NULL,
  `default_valid_time` varchar(45) DEFAULT NULL,
  `hook` varchar(100) DEFAULT NULL,
  `read_only` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `type` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=1814 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `checkbox_customer_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `message` varchar(2048) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `checkbox_customer_statuses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `checklist_name_id` int(11) DEFAULT NULL COMMENT 'This column allows us to make rejection/other step status messages that are specific to a checklist_name_id.  Excluding a checklist_name_id allows status codes to be reused across multiple checklists which all include some checklist_step_id where they all',
  `checklist_step_id` int(11) NOT NULL,
  `checkbox_id` int(11) DEFAULT NULL,
  `special_purpose` enum('gtld_reject','gtld_approved') DEFAULT NULL,
  `active` tinyint(1) NOT NULL,
  `customer_status_code` int(11) NOT NULL COMMENT 'Allows the API to pass back standard ''reason codes'' along with the status messages.  Note that you could hypothetically have 2 messages with different message texts (customer_message) for human consumption, but whose semantic meaning for automated systems',
  `checkbox_customer_message_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `CHECKLIST_STEP` (`checklist_step_id`,`active`)
) ENGINE=InnoDB AUTO_INCREMENT=165 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `checkbox_docs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `checkbox_id` int(10) unsigned NOT NULL,
  `doc_type_id` int(10) unsigned NOT NULL,
  `name` varchar(100) NOT NULL DEFAULT '',
  `description` text DEFAULT NULL,
  `num_required` tinyint(3) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `fk_assertion_docs_assertions` (`checkbox_id`),
  KEY `fk_assertion_docs_doc_types` (`doc_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1070 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `checklists` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `checklist_name_id` int(11) NOT NULL,
  `checklist_step_id` int(11) DEFAULT NULL,
  `checkbox_id` int(11) NOT NULL,
  `org_type_id` int(10) unsigned DEFAULT NULL,
  `modifier_id` int(10) unsigned DEFAULT NULL,
  `checklist_role_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_active` tinyint(1) NOT NULL DEFAULT 0,
  `sort_order` tinyint(3) unsigned DEFAULT 100,
  `date_created` datetime DEFAULT NULL,
  `date_inactivated` datetime DEFAULT NULL,
  `valid_months` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_checklist_assertions_assertions` (`checkbox_id`),
  KEY `fk_checklist_assertions_assertion_groups` (`checklist_step_id`),
  KEY `fk_checklist_assertions_checklist_modifiers` (`modifier_id`),
  KEY `fk_checklist_checklist_role_id` (`checklist_role_id`),
  KEY `is_active` (`is_active`),
  KEY `org_type_id` (`org_type_id`),
  KEY `checklist_name_id` (`checklist_name_id`),
  KEY `modifier_id` (`modifier_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1107 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `checklist_cache` (
  `order_id` int(11) NOT NULL DEFAULT 0,
  `checklist_id` int(11) NOT NULL DEFAULT 0,
  `company_id` int(11) NOT NULL DEFAULT 0,
  `domain_id` int(11) NOT NULL DEFAULT 0,
  `last_checked` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `status` enum('unknown','in_progress','first_auth_done','second_auth_done','issue_ready') NOT NULL DEFAULT 'unknown',
  `whats_left_counts` varchar(255) NOT NULL DEFAULT '',
  `whats_left_json` text DEFAULT NULL,
  PRIMARY KEY (`order_id`,`company_id`,`domain_id`,`checklist_id`),
  KEY `domain_id` (`domain_id`),
  KEY `checklist_id` (`checklist_id`,`company_id`,`domain_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `checklist_modifiers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `description` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `checklist_roles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `checklist_steps` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `reference` varchar(50) DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `sort_order` smallint(3) unsigned DEFAULT 100,
  `customer_friendly_name` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1019 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `checkmarks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `checkbox_id` int(10) unsigned NOT NULL,
  `company_id` int(10) unsigned DEFAULT NULL,
  `domain_id` int(10) unsigned DEFAULT NULL,
  `contact_id` int(10) DEFAULT NULL,
  `checkmark_status_id` int(10) unsigned NOT NULL,
  `first_approval_staff_id` int(10) unsigned DEFAULT NULL,
  `first_approval_date_time` datetime DEFAULT NULL,
  `second_approval_staff_id` int(10) unsigned DEFAULT NULL,
  `second_approval_date_time` datetime DEFAULT NULL,
  `audit_staff_id` int(10) unsigned DEFAULT NULL,
  `audit_date_time` datetime DEFAULT NULL,
  `review_note` text DEFAULT NULL,
  `date_expires` datetime NOT NULL,
  `rejected_staff_id` int(10) unsigned DEFAULT NULL,
  `rejected_date_time` datetime DEFAULT NULL,
  `checkbox_customer_status_id` int(11) DEFAULT NULL COMMENT 'A customer message (with optional API status code) for this checkmark.  Currently used to include a customer-friendly "reject reason" for gTLD''s.',
  PRIMARY KEY (`id`),
  KEY `fk_company_assertions_assertions` (`checkbox_id`),
  KEY `fk_company_assertions_companies` (`company_id`),
  KEY `fk_company_assertions_domains` (`domain_id`),
  KEY `fk_company_assertions_staff` (`first_approval_staff_id`),
  KEY `fk_company_assertions_staff1` (`second_approval_staff_id`),
  KEY `fk_company_assertions_assertion_statuses` (`checkmark_status_id`),
  KEY `checkmarks_date_expires` (`date_expires`),
  KEY `fk_checkmarks_contact_id` (`contact_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15048709 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `checkmark_amendments` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `checklist_step_id` int(10) unsigned NOT NULL,
  `old_checkmark_id` int(10) unsigned NOT NULL,
  `new_checkmark_id` int(10) unsigned DEFAULT NULL,
  `staff_id` int(10) unsigned NOT NULL,
  `note` text NOT NULL,
  `date_created` datetime NOT NULL,
  `date_completed` datetime DEFAULT NULL,
  `approved_staff_id` int(10) unsigned NOT NULL,
  `date_approved` datetime DEFAULT NULL,
  `cancelled_staff_id` int(11) DEFAULT NULL,
  `date_cancelled` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `old_idx` (`old_checkmark_id`)
) ENGINE=InnoDB AUTO_INCREMENT=22106 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `checkmark_docs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `checkmark_id` int(10) unsigned NOT NULL,
  `document_id` int(11) NOT NULL,
  `created_by_staff_id` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_company_assertion_docs_company_assertions` (`checkmark_id`),
  KEY `fk_company_assertion_docs_documents` (`document_id`),
  KEY `fk_company_assertion_docs_staff` (`created_by_staff_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13406296 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `checkmark_notes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `checkmark_id` int(10) unsigned NOT NULL,
  `staff_id` int(10) unsigned NOT NULL,
  `date_created` datetime NOT NULL,
  `note` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_checkmark_notes_checkmarks` (`checkmark_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3225556 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `client_cert_email` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ent_client_cert_id` int(10) unsigned NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_token_id` int(10) unsigned DEFAULT NULL,
  `date_emailed` datetime DEFAULT NULL,
  `date_validated` datetime DEFAULT NULL,
  `date_created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_ent_client_cert_id` (`ent_client_cert_id`)
) ENGINE=InnoDB AUTO_INCREMENT=905410 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `client_cert_renewal_notices` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ent_client_cert_id` int(11) DEFAULT NULL,
  `order_id` int(11) NOT NULL,
  `minus_90_sent` tinyint(1) NOT NULL DEFAULT 0,
  `minus_60_sent` tinyint(1) NOT NULL DEFAULT 0,
  `minus_30_sent` tinyint(1) NOT NULL DEFAULT 0,
  `minus_7_sent` tinyint(1) NOT NULL DEFAULT 0,
  `minus_3_sent` tinyint(1) NOT NULL DEFAULT 0,
  `plus_7_sent` tinyint(1) NOT NULL DEFAULT 0,
  `disable_renewal_notifications` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_order_id` (`order_id`),
  KEY `idx_ent_client_cert_id` (`ent_client_cert_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13233 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `cobranding_images` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` int(11) DEFAULT NULL,
  `reseller_id` int(10) unsigned DEFAULT NULL,
  `filename` varchar(150) DEFAULT NULL,
  `image_type` tinyint(3) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `cobranding_image_types` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `commissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `reseller_id` int(6) unsigned zerofill NOT NULL DEFAULT 000000,
  `month` tinyint(2) unsigned zerofill NOT NULL DEFAULT 00,
  `year` mediumint(4) NOT NULL DEFAULT 0,
  `calculated_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `num_orders` int(11) NOT NULL DEFAULT 0,
  `order_total` decimal(10,2) NOT NULL DEFAULT 0.00,
  `percentage` tinyint(2) NOT NULL DEFAULT 10,
  `paid_amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `paid_bonus` decimal(10,2) NOT NULL,
  `paid_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `paid_memo` varchar(255) NOT NULL DEFAULT '',
  `rates` text NOT NULL,
  `universal` tinyint(1) NOT NULL DEFAULT 0,
  `rate_id` int(5) unsigned zerofill NOT NULL DEFAULT 00000,
  `currency` char(3) CHARACTER SET ascii NOT NULL DEFAULT 'USD',
  PRIMARY KEY (`id`),
  UNIQUE KEY `reseller_id` (`reseller_id`,`month`,`year`)
) ENGINE=InnoDB AUTO_INCREMENT=70202 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `commission_adjustments` (
  `id` int(8) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `order_id` int(8) unsigned NOT NULL,
  `normal_commission_date` date NOT NULL,
  `adjusted_commission_date` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=572 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `commission_rates` (
  `id` int(5) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL DEFAULT '',
  `universal` tinyint(1) NOT NULL DEFAULT 0,
  `rates` text NOT NULL,
  `effective_date` date NOT NULL DEFAULT '0000-00-00',
  `expiration_date` date DEFAULT '0000-00-00',
  `expired` binary(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=183 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `common_names` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(8) unsigned zerofill NOT NULL,
  `common_name` varchar(255) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `domain_id` int(11) NOT NULL,
  `approve_id` int(11) NOT NULL DEFAULT 0,
  `status` enum('active','inactive','pending') DEFAULT 'active',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `domain_id` (`domain_id`),
  KEY `active` (`active`),
  KEY `common_names_approve_id` (`approve_id`),
  KEY `common_names_status` (`status`),
  KEY `common_name` (`common_name`(18))
) ENGINE=InnoDB AUTO_INCREMENT=48094078 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `companies` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `acct_id` int(6) unsigned zerofill NOT NULL DEFAULT 000000,
  `container_id` int(10) unsigned DEFAULT NULL,
  `org_contact_id` int(11) NOT NULL DEFAULT 0,
  `tech_contact_id` int(11) NOT NULL DEFAULT 0,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `ev_status` tinyint(4) NOT NULL DEFAULT 1,
  `org_name` varchar(255) NOT NULL DEFAULT '',
  `org_type` int(10) NOT NULL DEFAULT 1,
  `org_assumed_name` varchar(255) NOT NULL DEFAULT '',
  `org_addr1` varchar(128) NOT NULL DEFAULT '',
  `org_addr2` varchar(128) NOT NULL DEFAULT '',
  `org_zip` varchar(40) NOT NULL DEFAULT '',
  `org_city` varchar(128) NOT NULL DEFAULT '',
  `org_state` varchar(128) NOT NULL DEFAULT '',
  `org_country` varchar(2) NOT NULL DEFAULT '',
  `org_email` varchar(128) NOT NULL,
  `telephone` varchar(32) NOT NULL DEFAULT '',
  `org_reg_num` varchar(200) NOT NULL DEFAULT '',
  `jur_city` varchar(128) NOT NULL DEFAULT '',
  `jur_state` varchar(128) NOT NULL DEFAULT '',
  `jur_country` varchar(2) NOT NULL DEFAULT '',
  `incorp_agency` varchar(255) NOT NULL DEFAULT '',
  `master_agreement_sent` tinyint(1) NOT NULL DEFAULT 0,
  `locked` tinyint(1) NOT NULL DEFAULT 0,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `ov_validated_until` datetime DEFAULT NULL,
  `ev_validated_until` datetime DEFAULT NULL,
  `public_phone` varchar(32) NOT NULL DEFAULT '',
  `public_email` varchar(128) NOT NULL DEFAULT '',
  `namespace_protected` tinyint(4) NOT NULL DEFAULT 0,
  `slim_org_name` varchar(255) NOT NULL DEFAULT '',
  `pending_validation_checklist_ids` varchar(50) NOT NULL,
  `validation_submit_date` datetime DEFAULT NULL,
  `reject_notes` varchar(255) NOT NULL DEFAULT '',
  `reject_date_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `reject_staff` int(10) unsigned NOT NULL DEFAULT 0,
  `flag` tinyint(4) NOT NULL DEFAULT 0,
  `snooze_until` datetime DEFAULT NULL,
  `checklist_modifiers` varchar(30) NOT NULL,
  `ascii_name` varchar(255) DEFAULT NULL,
  `risk_score` smallint(5) unsigned NOT NULL DEFAULT 0,
  `incorp_agency_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `acct_id` (`acct_id`),
  KEY `org_contact_id` (`org_contact_id`),
  KEY `tech_contact_id` (`tech_contact_id`),
  KEY `status` (`status`),
  KEY `companies_org_name` (`org_name`),
  KEY `companies_org_state` (`org_state`),
  KEY `companies_org_country` (`org_country`),
  KEY `companies_jur_state` (`jur_state`),
  KEY `companies_jur_country` (`jur_country`),
  KEY `active` (`active`),
  KEY `org_type` (`org_type`),
  KEY `slim_org_name` (`slim_org_name`),
  KEY `pending_validation_checklist_ids` (`pending_validation_checklist_ids`),
  KEY `validation_submit_date` (`validation_submit_date`),
  KEY `container_id` (`container_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1400846 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `companies_statuses` (
  `id` tinyint(1) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `company_history` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `company_id` int(10) unsigned DEFAULT NULL,
  `staff_id` int(10) unsigned DEFAULT NULL,
  `datetime` datetime DEFAULT NULL,
  `field_name` varchar(255) DEFAULT NULL,
  `old_value` varchar(255) DEFAULT NULL,
  `new_value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_company_assertion_docs_staff` (`staff_id`),
  KEY `fk_company_assertions_companies` (`company_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4010636 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `company_intermediates` (
  `acct_id` int(11) NOT NULL,
  `ca_cert_id` int(11) NOT NULL,
  PRIMARY KEY (`acct_id`,`ca_cert_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `company_subdomains` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `domain_id` int(11) DEFAULT NULL,
  `company_id` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `status` enum('requested','approved','declined') DEFAULT 'requested',
  `ctime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `company_index` (`company_id`,`name`),
  KEY `domain_index` (`domain_id`)
) ENGINE=InnoDB AUTO_INCREMENT=132750 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `company_types` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `contacts` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `job_title` varchar(64) DEFAULT NULL,
  `firstname` varchar(128) DEFAULT NULL,
  `lastname` varchar(128) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `telephone` varchar(32) DEFAULT NULL,
  `telephone_ext` varchar(16) NOT NULL DEFAULT '',
  `fax` varchar(32) DEFAULT NULL,
  `i18n_language_id` tinyint(4) unsigned DEFAULT 1,
  `last_updated` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  `container_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `firstname` (`firstname`),
  KEY `lastname` (`lastname`),
  KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2529882 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `contact_map` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) DEFAULT NULL,
  `organization_id` int(11) DEFAULT NULL,
  `contact_id` int(11) DEFAULT NULL,
  `verified_contact_id` int(11) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_contact` (`contact_id`),
  KEY `idx_organization_id` (`organization_id`)
) ENGINE=InnoDB AUTO_INCREMENT=993697 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `contact_whitelist` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `contact_hash` varchar(32) DEFAULT NULL,
  `staff_id` int(11) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `account_id` int(10) unsigned DEFAULT NULL,
  `firstname` varchar(64) DEFAULT NULL,
  `lastname` varchar(64) DEFAULT NULL,
  `email` varchar(128) DEFAULT NULL,
  `phone` varchar(64) DEFAULT NULL,
  `phone_extension` varchar(64) DEFAULT NULL,
  `fax` varchar(64) DEFAULT NULL,
  `job_title` varchar(64) DEFAULT NULL,
  `staff_id2` int(10) unsigned DEFAULT NULL,
  `note` text DEFAULT NULL,
  `document_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_contact_hash` (`contact_hash`),
  KEY `ix_date_created` (`date_created`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `container` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `public_id` varchar(32) NOT NULL,
  `parent_id` int(10) unsigned DEFAULT NULL,
  `tree_level` smallint(5) unsigned NOT NULL,
  `account_id` int(10) unsigned NOT NULL,
  `container_template_id` int(10) unsigned NOT NULL,
  `logo_file_id` int(10) unsigned DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `is_active` tinyint(3) unsigned NOT NULL,
  `user_agreement_id` int(11) DEFAULT NULL,
  `ekey` varchar(32) DEFAULT NULL,
  `allowed_domain_names` text DEFAULT NULL,
  `type` varchar(16) NOT NULL DEFAULT 'standard',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_public_id` (`public_id`),
  KEY `ix_account_id` (`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=536799 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `container_ca_map` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `container_id` int(11) unsigned NOT NULL,
  `product_name_id` varchar(255) NOT NULL,
  `ca_cert_id` int(11) unsigned NOT NULL,
  `csr_type` enum('any','rsa','ecc') NOT NULL DEFAULT 'any',
  `signature_hash` enum('any','sha1','sha2-any','sha256','sha384','sha512') NOT NULL DEFAULT 'any',
  PRIMARY KEY (`id`),
  KEY `ix_container_product` (`container_id`,`product_name_id`)
) ENGINE=InnoDB AUTO_INCREMENT=42507 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `container_descendant_map` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `container_id` int(10) unsigned NOT NULL,
  `descendant_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_container_id_descendant_id` (`container_id`,`descendant_id`),
  UNIQUE KEY `ix_descendant_id_container_id` (`descendant_id`,`container_id`)
) ENGINE=InnoDB AUTO_INCREMENT=504120 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `container_domain` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `container_id` int(10) unsigned NOT NULL,
  `domain_id` int(10) unsigned DEFAULT NULL,
  `subdomain_id` int(10) unsigned DEFAULT NULL,
  `is_active` tinyint(4) DEFAULT 1,
  `organization_id` int(10) unsigned DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `status` varchar(16) DEFAULT NULL,
  `full_domain_view` tinyint(1) DEFAULT 0,
  `dcv_method` varchar(16) DEFAULT NULL,
  `dcv_name_scope` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_container_id` (`container_id`),
  KEY `ix_domain_id` (`domain_id`),
  KEY `ix_subdomain_id` (`subdomain_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3381413 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `container_guest_key` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `container_id` int(10) unsigned NOT NULL,
  `date_created` datetime NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `key` varchar(64) NOT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `validity_periods` set('1','2','3','custom') NOT NULL DEFAULT '',
  `mpki_token` varchar(50) DEFAULT NULL,
  `org_permission` enum('both','existing','new') DEFAULT NULL,
  `domain_permission` tinyint(1) unsigned NOT NULL DEFAULT 1,
  `contact_permission` tinyint(1) unsigned NOT NULL DEFAULT 1,
  `txn_summary_permission` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `language_preference` tinyint(4) unsigned NOT NULL DEFAULT 1,
  `expand_cert_opts` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `dcv_method_permission` tinyint(1) unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_key` (`key`)
) ENGINE=InnoDB AUTO_INCREMENT=93182 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `container_guest_key_product_map` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `guest_key_id` int(10) unsigned NOT NULL,
  `product_name_id` varchar(64) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_guest_key_id_product_name_id` (`guest_key_id`,`product_name_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14534 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `container_oem_ica_map` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `container_id` int(10) unsigned NOT NULL,
  `product_name_id` varchar(255) NOT NULL,
  `custom_ica` varchar(64) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_container_product` (`container_id`,`product_name_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3796 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `container_permission_override` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `account_id` int(10) unsigned NOT NULL,
  `container_template_id` int(11) NOT NULL DEFAULT 0,
  `container_id` int(11) NOT NULL DEFAULT 0,
  `access_permission_id` int(10) unsigned NOT NULL,
  `scope` tinyint(3) unsigned DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_account_template_container_permission_id` (`account_id`,`container_template_id`,`container_id`,`access_permission_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7980987 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `container_product_restrictions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `container_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL DEFAULT 0,
  `product_name_id` varchar(64) NOT NULL,
  `allowed_hashes` varchar(250) NOT NULL DEFAULT 'any',
  `allowed_intermediates` varchar(250) NOT NULL DEFAULT 'any',
  `default_intermediate` varchar(12) DEFAULT NULL,
  `allowed_lifetimes` varchar(50) NOT NULL DEFAULT 'any',
  `allow_auto_renew` tinyint(3) unsigned NOT NULL DEFAULT 1,
  `allowed_fqdns` smallint(5) unsigned DEFAULT NULL,
  `allowed_wildcards` smallint(5) unsigned DEFAULT NULL,
  `ct_log_option` enum('per_cert','always','never') DEFAULT NULL,
  `allow_auto_reissue` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `ix_container_id_role_id` (`container_id`,`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=443171 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `container_settings` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime DEFAULT NULL,
  `container_id` int(11) unsigned DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `value` text DEFAULT NULL,
  `allow_override` tinyint(3) unsigned NOT NULL DEFAULT 1,
  `read_only` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `inheritable` tinyint(3) unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE KEY `un_container_id_name` (`container_id`,`name`),
  KEY `ix_container` (`container_id`),
  KEY `name_idx` (`name`(11))
) ENGINE=InnoDB AUTO_INCREMENT=2502154 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `container_template` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `account_id` int(10) unsigned DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `internal_description` varchar(1024) DEFAULT NULL,
  `is_primary` tinyint(3) unsigned NOT NULL,
  `agreement_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25331 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `container_template_access_role_map` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `template_id` int(10) unsigned DEFAULT NULL,
  `access_role_id` int(10) unsigned NOT NULL,
  `account_id` int(11) NOT NULL DEFAULT 0,
  `active` tinyint(3) unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_template_access_role_account_id` (`template_id`,`access_role_id`,`account_id`),
  KEY `ix_account_id` (`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1699577 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `container_template_feature_map` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `container_template_id` int(10) unsigned NOT NULL,
  `feature_id` int(10) unsigned NOT NULL,
  `feature_scope` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_container_template_id_feature_id_feature_scope` (`container_template_id`,`feature_id`,`feature_scope`)
) ENGINE=InnoDB AUTO_INCREMENT=719 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `container_template_map` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `container_template_id` int(10) unsigned NOT NULL,
  `mapped_template_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `container_template_permission_map` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `container_template_id` int(10) unsigned NOT NULL,
  `access_permission_id` int(10) unsigned NOT NULL,
  `scope` tinyint(3) unsigned DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_container_template_id_permission_id` (`container_template_id`,`access_permission_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3814 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `container_template_product_map` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `template_id` int(10) unsigned NOT NULL,
  `product_name_id` varchar(64) NOT NULL,
  `require_tos` tinyint(3) unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_template_id_product_name_id` (`template_id`,`product_name_id`)
) ENGINE=InnoDB AUTO_INCREMENT=631 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `countries` (
  `id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `abbrev` varchar(2) NOT NULL DEFAULT '',
  `upper_abbrev` varchar(2) NOT NULL DEFAULT '',
  `name` varchar(128) DEFAULT NULL,
  `sort_order` tinyint(4) NOT NULL DEFAULT 4,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `allow_ev` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `abbrev` (`abbrev`),
  KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=247 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `country_alias` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime DEFAULT NULL,
  `display` tinyint(4) DEFAULT 0,
  `alias` varchar(255) NOT NULL,
  `phone_code` varchar(3) NOT NULL,
  `parent_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_phone_code` (`phone_code`)
) ENGINE=InnoDB AUTO_INCREMENT=2139 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `country_code` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `phone_code` varchar(3) NOT NULL,
  `regex_validation` varchar(30) DEFAULT NULL,
  `allowed_lengths` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_phone_code` (`phone_code`)
) ENGINE=InnoDB AUTO_INCREMENT=222 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `credited_certs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `acct_id` int(10) unsigned DEFAULT NULL,
  `date_credited` date DEFAULT NULL,
  `any_other` smallint(5) unsigned DEFAULT NULL,
  `any_ssl` smallint(5) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `current_standard_pricing` (
  `currency` char(3) NOT NULL,
  `standard_pricing` text NOT NULL,
  `last_updated` datetime NOT NULL,
  PRIMARY KEY (`currency`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `customer_order` (
  `id` int(10) unsigned NOT NULL,
  `product_name_id` int(10) unsigned NOT NULL,
  `account_id` int(10) unsigned NOT NULL,
  `container_id` int(10) unsigned NOT NULL,
  `status` enum('pending','reissue_pending','issued','revoked','rejected','canceled','waiting_pickup') NOT NULL DEFAULT 'pending',
  `ip_address` varchar(15) CHARACTER SET ascii DEFAULT NULL,
  `certificate_tracker_id` int(10) unsigned NOT NULL DEFAULT 0,
  `customer_order_id` varchar(64) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `date_issued` datetime DEFAULT NULL,
  `status_last_updated` datetime DEFAULT NULL,
  `user_id` int(10) unsigned DEFAULT 0,
  `auto_renew` tinyint(1) NOT NULL DEFAULT 0,
  `renewed_order_id` int(10) unsigned DEFAULT NULL,
  `is_renewed` tinyint(1) NOT NULL DEFAULT 0,
  `disable_renewal_notifications` tinyint(1) NOT NULL DEFAULT 0,
  `disable_issuance_email` tinyint(1) NOT NULL DEFAULT 0,
  `ssl_profile_option` varchar(32) CHARACTER SET ascii DEFAULT NULL,
  `additional_emails` text DEFAULT NULL,
  `custom_renewal_message` text DEFAULT NULL,
  `additional_template_data` text DEFAULT NULL,
  `order_options` text DEFAULT NULL,
  `cs_provisioning_method` enum('client_app','email','ship_token','none') DEFAULT NULL,
  `dcv_method` varchar(16) CHARACTER SET ascii DEFAULT NULL,
  `common_name` varchar(255) DEFAULT NULL,
  `organization_units` text DEFAULT NULL,
  `organization_id` int(10) unsigned DEFAULT NULL,
  `dns_names` text DEFAULT NULL,
  `csr` text DEFAULT NULL,
  `signature_hash` varchar(8) CHARACTER SET ascii DEFAULT NULL,
  `validity_years` int(10) unsigned NOT NULL,
  `date_valid_from` date DEFAULT NULL,
  `date_valid_till` date DEFAULT NULL,
  `serial_number` varchar(128) CHARACTER SET ascii DEFAULT NULL,
  `thumbprint` varchar(40) CHARACTER SET ascii DEFAULT NULL,
  `ca_cert_id` int(10) unsigned NOT NULL,
  `plus_feature` tinyint(1) DEFAULT NULL,
  `service_name` varchar(32) DEFAULT NULL,
  `server_platform_id` int(11) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `cost` decimal(10,2) DEFAULT NULL,
  `purchased_dns_names` int(10) unsigned NOT NULL DEFAULT 0,
  `purchased_wildcard_names` int(10) unsigned NOT NULL DEFAULT 0,
  `pay_type` varchar(4) CHARACTER SET ascii NOT NULL DEFAULT 'A',
  `stat_row_id` int(10) unsigned DEFAULT NULL,
  `names_stat_row_id` int(10) unsigned DEFAULT NULL,
  `wildcard_names_stat_row_id` int(10) unsigned DEFAULT NULL,
  `receipt_id` int(10) unsigned DEFAULT NULL,
  `agreement_id` int(10) unsigned DEFAULT NULL,
  `is_out_of_contract` tinyint(1) NOT NULL DEFAULT 0,
  `locale` varchar(8) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_account_id` (`account_id`),
  KEY `ix_product_name_id` (`product_name_id`),
  KEY `ix_container_id` (`container_id`),
  KEY `ix_date_created` (`date_created`),
  KEY `ix_status_last_updated` (`status_last_updated`),
  KEY `ix_common_name` (`common_name`(16)),
  KEY `ix_organization_id` (`organization_id`),
  KEY `ix_validity_years` (`validity_years`),
  KEY `ix_valid_till` (`date_valid_till`),
  KEY `ix_receipt_id` (`receipt_id`),
  KEY `id_certificate_tracker_id` (`certificate_tracker_id`),
  KEY `id_thumbprint` (`thumbprint`(10)),
  KEY `ix_customer_order_id` (`customer_order_id`(8)),
  KEY `ix_serial_number` (`serial_number`(8)),
  KEY `ix_renewed_order_id` (`renewed_order_id`),
  KEY `ix_user_id` (`user_id`),
  KEY `ix_ca_cert_id` (`ca_cert_id`),
  KEY `ix_dcv_method` (`dcv_method`),
  KEY `ix_date_issued` (`date_issued`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `customer_order_contact` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(10) unsigned NOT NULL,
  `firstname` varchar(128) DEFAULT NULL,
  `lastname` varchar(128) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `telephone` varchar(32) DEFAULT NULL,
  `job_title` varchar(64) DEFAULT NULL,
  `contact_type` varchar(32) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `last_updated` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_order_id` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=33248624 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `customer_order_domain` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(10) unsigned NOT NULL,
  `domain_name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_order_id` (`order_id`),
  KEY `ix_domain_name` (`domain_name`)
) ENGINE=InnoDB AUTO_INCREMENT=226816734 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `customer_order_email` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(10) unsigned NOT NULL,
  `email` varchar(255) NOT NULL,
  `date_created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_order_id` (`order_id`),
  KEY `ix_email` (`email`),
  KEY `ix_date_created` (`date_created`)
) ENGINE=InnoDB AUTO_INCREMENT=949432 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `customer_order_reissue_history` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(10) unsigned NOT NULL,
  `legacy_reissue_id` int(10) unsigned DEFAULT NULL,
  `legacy_client_cert_id` int(10) unsigned DEFAULT NULL,
  `is_original_order` tinyint(4) NOT NULL DEFAULT 0,
  `status` enum('pending','reissue_pending','issued','revoked','rejected','canceled') NOT NULL DEFAULT 'pending',
  `ip_address` varchar(15) CHARACTER SET ascii DEFAULT NULL,
  `certificate_tracker_id` int(10) unsigned DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `date_issued` datetime DEFAULT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  `additional_template_data` text DEFAULT NULL,
  `order_options` text DEFAULT NULL,
  `dcv_method` varchar(16) CHARACTER SET ascii DEFAULT NULL,
  `common_name` varchar(255) DEFAULT NULL,
  `organization_units` text DEFAULT NULL,
  `organization_id` int(10) unsigned DEFAULT NULL,
  `dns_names` text DEFAULT NULL,
  `csr` text DEFAULT NULL,
  `signature_hash` varchar(8) CHARACTER SET ascii DEFAULT NULL,
  `date_valid_from` date DEFAULT NULL,
  `date_valid_till` date DEFAULT NULL,
  `serial_number` varchar(128) CHARACTER SET ascii DEFAULT NULL,
  `thumbprint` varchar(40) CHARACTER SET ascii DEFAULT NULL,
  `ca_cert_id` int(10) unsigned NOT NULL,
  `service_name` varchar(32) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `cost` decimal(10,2) DEFAULT NULL,
  `purchased_dns_names` int(10) unsigned DEFAULT NULL,
  `pay_type` varchar(4) CHARACTER SET ascii NOT NULL DEFAULT 'A',
  `stat_row_id` int(10) unsigned DEFAULT NULL,
  `names_stat_row_id` int(10) unsigned DEFAULT NULL,
  `receipt_id` int(10) unsigned DEFAULT NULL,
  `agreement_id` int(10) unsigned DEFAULT NULL,
  `is_out_of_contract` tinyint(1) NOT NULL DEFAULT 0,
  `purchased_wildcard_names` int(10) unsigned DEFAULT NULL,
  `wildcard_names_stat_row_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_order_id` (`order_id`),
  KEY `ix_legacy_reissue_id` (`legacy_reissue_id`),
  KEY `ix_legacy_client_cert_id` (`legacy_client_cert_id`),
  KEY `ix_certificate_tracker_id` (`certificate_tracker_id`),
  KEY `ix_receipt_id` (`receipt_id`),
  KEY `ix_date_created` (`date_created`)
) ENGINE=InnoDB AUTO_INCREMENT=5729768 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `customer_po_request` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` int(10) unsigned NOT NULL,
  `container_id` int(10) unsigned NOT NULL,
  `date_created` datetime NOT NULL,
  `approval_status` enum('pending','approved','rejected') DEFAULT 'pending',
  `review_staff_id` mediumint(8) unsigned NOT NULL,
  `cust_po_number` varchar(96) DEFAULT '',
  `bill_to_email` varchar(128) NOT NULL DEFAULT '',
  `amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `currency` varchar(3) NOT NULL DEFAULT '',
  `reject_notes` varchar(255) NOT NULL DEFAULT '',
  `reject_date_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `vat_number` varchar(128) NOT NULL DEFAULT '',
  `billing_contact_name` varchar(128) NOT NULL DEFAULT '',
  `billing_org_name` varchar(128) NOT NULL DEFAULT '',
  `billing_org_addr1` varchar(128) NOT NULL DEFAULT '',
  `billing_org_addr2` varchar(128) NOT NULL DEFAULT '',
  `billing_org_city` varchar(64) NOT NULL DEFAULT '',
  `billing_org_state` varchar(64) NOT NULL DEFAULT '',
  `billing_org_zip` varchar(10) NOT NULL DEFAULT '',
  `billing_org_country` varchar(2) NOT NULL DEFAULT '0',
  `billing_telephone` varchar(32) NOT NULL DEFAULT '',
  `hard_copy_path` varchar(255) DEFAULT '',
  `hard_copy_date` datetime DEFAULT NULL,
  `customer_notes` varchar(512) DEFAULT NULL,
  `additional_emails` varchar(512) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `account_id` (`account_id`),
  KEY `container_id` (`container_id`),
  KEY `date_created` (`date_created`),
  KEY `approval_status` (`approval_status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `custom_fields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `acct_id` int(6) unsigned DEFAULT NULL,
  `identifier` int(11) NOT NULL,
  `reference` enum('company','user_contact','address_request','device_request','org_request','fbca_address_request') NOT NULL,
  `name` varchar(50) NOT NULL,
  `description` varchar(500) DEFAULT NULL,
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  PRIMARY KEY (`id`),
  UNIQUE KEY `acct_id` (`acct_id`,`identifier`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `custom_renewal_notices` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `body` text DEFAULT NULL,
  `notice_level` enum('account','order','unit') DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1524 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `custom_renewal_notice_accounts` (
  `id` int(10) unsigned NOT NULL,
  `custom_renewal_notice_id` mediumint(8) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `custom_renewal_notice_ent_requests` (
  `id` int(10) unsigned NOT NULL,
  `custom_renewal_notice_id` mediumint(8) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `custom_renewal_notice_ent_units` (
  `id` int(10) unsigned NOT NULL,
  `custom_renewal_notice_id` mediumint(8) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `custom_renewal_notice_orders` (
  `id` int(10) unsigned NOT NULL,
  `custom_renewal_notice_id` mediumint(8) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `custom_values` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `custom_field_id` int(11) NOT NULL,
  `reference_id` int(11) NOT NULL,
  `value` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `reference_id` (`reference_id`,`custom_field_id`),
  KEY `value` (`value`)
) ENGINE=InnoDB AUTO_INCREMENT=94126 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `cust_audit_log` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `parent_log_id` int(11) unsigned DEFAULT NULL,
  `date_time` datetime NOT NULL,
  `acct_id` int(6) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `ip_address` int(10) unsigned NOT NULL,
  `ip_country` char(2) DEFAULT NULL,
  `action_status` enum('failed','successful') DEFAULT NULL,
  `action` varchar(50) NOT NULL,
  `target_type` varchar(50) NOT NULL DEFAULT '',
  `target_id` int(11) unsigned NOT NULL,
  `message` varchar(1500) DEFAULT NULL,
  `staff_id` smallint(5) unsigned DEFAULT NULL,
  `origin` enum('ui','api') NOT NULL DEFAULT 'ui',
  `container_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `parent_log_id` (`parent_log_id`),
  KEY `acct_id` (`acct_id`),
  KEY `date_time` (`date_time`),
  KEY `ip_address` (`ip_address`),
  KEY `container_id` (`container_id`),
  KEY `cust_audit_log_user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=192761791 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `cust_audit_log_notifications` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `acct_id` int(11) unsigned NOT NULL DEFAULT 0,
  `container_id` int(10) unsigned DEFAULT NULL,
  `user_id` int(11) unsigned NOT NULL DEFAULT 0,
  `email_address` varchar(255) DEFAULT NULL,
  `cat_cert_issuance` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `cat_user_changes` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `cat_logins` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `cat_bad_ip_logins` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `cat_cert_revoke` tinyint(1) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `ix_acct_id` (`acct_id`),
  KEY `ix_container_id` (`container_id`),
  KEY `ix_user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3316 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `data_deleted` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `table` varchar(64) DEFAULT NULL,
  `record_id` int(10) unsigned DEFAULT NULL,
  `description` varchar(128) DEFAULT NULL,
  `date_time` datetime DEFAULT NULL,
  `data` mediumtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `record_id` (`record_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2487359 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `dcj_accounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date_created` datetime DEFAULT current_timestamp(),
  `account_id` int(11) NOT NULL,
  `portal` enum('storefront','geostorefront','geocenter') NOT NULL,
  `portal_tech_email` varchar(256) CHARACTER SET ascii NOT NULL,
  `user_id` int(11) NOT NULL,
  `is_master` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_portal_portal_tech_email` (`portal`,`portal_tech_email`),
  KEY `idx_account_id` (`account_id`),
  KEY `idx_is_master` (`is_master`)
) ENGINE=InnoDB AUTO_INCREMENT=28743 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `dcj_certificates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date_created` datetime DEFAULT current_timestamp(),
  `portal` enum('storefront','geostorefront','geocenter') NOT NULL,
  `portal_tech_email` varchar(256) CHARACTER SET ascii NOT NULL,
  `serial_number` varchar(128) CHARACTER SET ascii NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  `error_description` varchar(1024) DEFAULT NULL,
  `last_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `serial_number` (`serial_number`),
  KEY `idx_portal_portal_tech_email` (`portal`,`portal_tech_email`),
  KEY `idx_status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=94198 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `dcj_coupon_list` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `coupon_number` varchar(16) NOT NULL,
  `product_name` varchar(256) DEFAULT NULL,
  `coupon_price` varchar(45) DEFAULT NULL,
  `coupon_consumed_person_id` varchar(45) DEFAULT NULL,
  `coupon_consumed_date` datetime DEFAULT NULL,
  `coupon_status` varchar(45) DEFAULT NULL,
  `common_name` varchar(256) DEFAULT NULL,
  `cert_enrollment_date` datetime DEFAULT NULL,
  `cert_valid_period` varchar(45) DEFAULT NULL,
  `cert_enrollment_company_name` varchar(256) DEFAULT NULL,
  `cert_enrollment_company_address` varchar(256) DEFAULT NULL,
  `cert_enrollment_company_postcode` varchar(45) DEFAULT NULL,
  `cert_enrollment_company_phone_number` varchar(256) DEFAULT NULL,
  `cert_enrollment_company_department_name` varchar(256) DEFAULT NULL,
  `cert_enrollment_company_contact_person_email_address` varchar(256) DEFAULT NULL,
  `cert_enrollment_company_contact_person_name` varchar(256) DEFAULT NULL,
  `tech_company_name` varchar(256) DEFAULT NULL,
  `tech_company_department_name` varchar(256) DEFAULT NULL,
  `tech_company_tech_contact_email` varchar(256) DEFAULT NULL,
  `tech_company_tech_person_name` varchar(256) DEFAULT NULL,
  `admin_company_name` varchar(256) DEFAULT NULL,
  `admin_company_department_name` varchar(256) DEFAULT NULL,
  `admin_company_admin_email` varchar(256) DEFAULT NULL,
  `admin_company_admin_name` varchar(256) DEFAULT NULL,
  `coupon_management_number` varchar(256) DEFAULT NULL,
  `coupon_type` varchar(45) DEFAULT NULL,
  `coupon_given_partner_id` int(10) unsigned DEFAULT NULL,
  `coupon_start_date` datetime DEFAULT NULL,
  `coupon_date_valid_till` datetime DEFAULT NULL,
  `coupon_giver_id` int(10) unsigned DEFAULT NULL,
  `coupon_given_date` datetime DEFAULT NULL,
  `coupon_approver_id` int(10) unsigned DEFAULT NULL,
  `coupon_approval_date` datetime DEFAULT NULL,
  `partner_id` int(10) unsigned DEFAULT NULL,
  `partner_name` varchar(256) DEFAULT NULL,
  `partner_address` varchar(256) DEFAULT NULL,
  `partner_post_code` varchar(45) DEFAULT NULL,
  `partner_telephone_number` varchar(45) DEFAULT NULL,
  `partner_fax_number` varchar(45) DEFAULT NULL,
  `partner_email` varchar(256) DEFAULT NULL,
  `giver_id` int(10) unsigned DEFAULT NULL,
  `giver_permission` varchar(45) DEFAULT NULL,
  `giver_name` varchar(256) DEFAULT NULL,
  `giver_email` varchar(256) DEFAULT NULL,
  `approver_id` int(10) unsigned DEFAULT NULL,
  `approver_permission` varchar(256) DEFAULT NULL,
  `approver_name` varchar(256) DEFAULT NULL,
  `approver_email` varchar(256) DEFAULT NULL,
  `crm_product_id` int(10) unsigned DEFAULT NULL,
  `sf_product_id` int(10) unsigned DEFAULT NULL,
  `shop_id` int(10) unsigned DEFAULT NULL,
  `product_price` varchar(256) DEFAULT NULL,
  `product_displayed_name` varchar(256) DEFAULT NULL,
  `product_campaign_flag` int(1) unsigned DEFAULT NULL,
  `product_note` varchar(256) DEFAULT NULL,
  `product_enrollment_required_flag` int(1) unsigned DEFAULT NULL,
  `product_multiple_purchase_flag` int(1) unsigned DEFAULT NULL,
  `product_price_type` varchar(256) DEFAULT NULL,
  `product_registered_date` datetime DEFAULT NULL,
  `product_registerant_id` int(10) unsigned DEFAULT NULL,
  `product_updated_date` datetime DEFAULT NULL,
  `product_updater_id` int(10) unsigned DEFAULT NULL,
  `account_id` int(10) unsigned DEFAULT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  `voucher_code_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `coupon_number` (`coupon_number`),
  KEY `idx_voucher_code_id` (`voucher_code_id`)
) ENGINE=InnoDB AUTO_INCREMENT=22386 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `dcj_order_migration_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date_created` datetime DEFAULT current_timestamp(),
  `account_id` int(11) NOT NULL,
  `start_time` datetime DEFAULT NULL,
  `completed_time` datetime DEFAULT NULL,
  `user_id` int(11) DEFAULT 0,
  `staff_id` int(11) DEFAULT 0,
  `last_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_account_id` (`account_id`),
  KEY `idx_date_created` (`date_created`),
  KEY `idx_completed` (`completed_time`)
) ENGINE=InnoDB AUTO_INCREMENT=30364 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `dcv_audit_data` (
  `order_id` int(10) unsigned NOT NULL,
  `duplicate_id` int(10) unsigned DEFAULT NULL,
  `reissue_id` int(10) unsigned DEFAULT NULL,
  `date_issued` datetime NOT NULL,
  `date_expires` datetime NOT NULL,
  `serial_number` char(42) DEFAULT NULL,
  `product_id` smallint(5) unsigned NOT NULL,
  `product_name` char(50) NOT NULL,
  `root_path` enum('digicert','entrust','cybertrust','comodo') NOT NULL,
  `ca_cert_id` int(10) unsigned NOT NULL,
  `is_missing_dcvs` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `remediation_dcv_date` datetime DEFAULT NULL,
  `remediation_days` smallint(6) DEFAULT NULL,
  `pem` mediumtext DEFAULT NULL,
  `chain` varchar(32) DEFAULT NULL,
  UNIQUE KEY `duplicate_id` (`duplicate_id`),
  UNIQUE KEY `reissue_id` (`reissue_id`),
  UNIQUE KEY `order_id_duplicate_id` (`order_id`,`duplicate_id`),
  UNIQUE KEY `order_id_reissue_id` (`order_id`,`reissue_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `dcv_cache` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `domain_id` int(10) unsigned NOT NULL,
  `date_created` datetime NOT NULL,
  `order_id` int(10) unsigned NOT NULL DEFAULT 0,
  `domain_name` varchar(255) NOT NULL,
  `include_subdomains` tinyint(4) NOT NULL DEFAULT 1,
  `dcv_method` varchar(255) NOT NULL,
  `approver_name` varchar(255) NOT NULL DEFAULT '',
  `approver_email` varchar(255) NOT NULL DEFAULT '',
  `validation_date` datetime DEFAULT NULL,
  `staff_id` int(10) unsigned NOT NULL DEFAULT 0,
  `staff_note` text DEFAULT NULL,
  `document_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_clone` tinyint(4) NOT NULL DEFAULT 0,
  `cert_tracker_id` int(10) unsigned DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `domain_id` (`domain_id`,`domain_name`,`include_subdomains`,`cert_tracker_id`),
  KEY `idx_date_create` (`date_created`),
  KEY `idx_domain_id` (`domain_id`),
  KEY `idx_order_id` (`order_id`),
  KEY `idx_domain_name` (`include_subdomains`,`domain_name`),
  KEY `idx_validation_date` (`validation_date`)
) ENGINE=InnoDB AUTO_INCREMENT=22343983 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `dcv_cache_old` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `domain_id` int(10) unsigned NOT NULL,
  `date_created` datetime NOT NULL,
  `order_id` int(10) unsigned NOT NULL DEFAULT 0,
  `domain_name` varchar(255) NOT NULL,
  `include_subdomains` tinyint(4) NOT NULL DEFAULT 1,
  `dcv_method` varchar(255) NOT NULL,
  `approver_name` varchar(255) NOT NULL DEFAULT '',
  `approver_email` varchar(255) NOT NULL DEFAULT '',
  `validation_date` datetime DEFAULT NULL,
  `staff_id` int(10) unsigned NOT NULL DEFAULT 0,
  `staff_note` text DEFAULT NULL,
  `document_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_clone` tinyint(4) NOT NULL DEFAULT 0,
  `cert_tracker_id` int(10) unsigned DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `idx_date_create` (`date_created`),
  KEY `idx_domain_id` (`domain_id`),
  KEY `idx_order_id` (`order_id`),
  KEY `idx_domain_name` (`include_subdomains`,`domain_name`),
  KEY `idx_validation_date` (`validation_date`)
) ENGINE=InnoDB AUTO_INCREMENT=21800273 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `dcv_email_blocklist` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(50) NOT NULL,
  `notes` varchar(200) DEFAULT NULL,
  `created_by_staff_id` int(11) NOT NULL DEFAULT 0,
  `date_added` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=117 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `dcv_email_sent` (
  `dcv_history_id` int(10) unsigned NOT NULL,
  `email_address` varchar(255) NOT NULL,
  PRIMARY KEY (`dcv_history_id`,`email_address`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `dcv_expire_cache` (
  `cert_approval_id` int(11) DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  `reason` varchar(255) DEFAULT NULL,
  `result` varchar(50) DEFAULT NULL,
  UNIQUE KEY `cert_approval_id_idx` (`cert_approval_id`),
  KEY `result_idx` (`result`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `dcv_invitations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(128) NOT NULL,
  `token` varchar(32) NOT NULL,
  `order_id` int(8) unsigned zerofill NOT NULL,
  `reissue_id` int(8) unsigned DEFAULT 0,
  `domain_id` int(11) NOT NULL,
  `name_scope` varchar(255) DEFAULT NULL,
  `date_time` datetime DEFAULT NULL,
  `status` enum('active','deleted') NOT NULL DEFAULT 'active',
  `source` varchar(20) DEFAULT NULL,
  `email_name_scope` varchar(255) DEFAULT NULL,
  `container_domain_id` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `email` (`email`(8)),
  KEY `token` (`token`(8)),
  KEY `order_id` (`order_id`),
  KEY `domain_id` (`domain_id`),
  KEY `dcv_invitations_reissue_id` (`reissue_id`),
  KEY `container_domain_id_idx` (`container_domain_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10629088 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `dcv_queue` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(8) unsigned zerofill NOT NULL,
  `domain_id` int(11) unsigned NOT NULL,
  `sent` tinyint(1) NOT NULL DEFAULT 0,
  `staff` int(10) unsigned NOT NULL DEFAULT 0,
  `date_sent` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `dcv_reverify` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `domain_id` int(11) NOT NULL,
  `dibs_staff_id` int(11) DEFAULT NULL,
  `dibs_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8169 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `dcv_reverify_results` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `domain_id` int(11) NOT NULL,
  `result` varchar(100) DEFAULT NULL,
  `staff_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12052 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `dcv_sort_cache` (
  `domain_id` int(11) DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  `reason` varchar(255) DEFAULT NULL,
  `category` varchar(50) DEFAULT NULL,
  `resolution` varchar(50) DEFAULT NULL,
  `meta_data` text DEFAULT NULL,
  UNIQUE KEY `domain_id_idx` (`domain_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `dcv_tokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `domain_id` int(11) NOT NULL,
  `method` enum('cname') NOT NULL DEFAULT 'cname',
  `token` varchar(64) NOT NULL,
  `verification_value` varchar(253) NOT NULL,
  `order_id` int(8) unsigned zerofill NOT NULL,
  `reissue_id` int(8) unsigned DEFAULT 0,
  `date_time` datetime DEFAULT NULL,
  `status` enum('active','deleted') NOT NULL DEFAULT 'active',
  `container_domain_id` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `domain_id` (`domain_id`),
  KEY `method` (`method`),
  KEY `token` (`token`(8)),
  KEY `order_id` (`order_id`),
  KEY `dcv_tokens_reissue_id` (`reissue_id`),
  KEY `idx_container_domain_id` (`container_domain_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1568 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `deleted_subdomains` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` int(10) unsigned NOT NULL,
  `container_id` int(10) unsigned NOT NULL,
  `reversion_sql` mediumtext NOT NULL,
  `cleanup_event_time` datetime NOT NULL,
  `date_created` datetime NOT NULL,
  `date_reverted` datetime DEFAULT NULL,
  `created_by_staff_id` int(10) unsigned NOT NULL,
  `reverted_by_staff_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=714 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `deposit_audit` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `action_id` int(10) unsigned DEFAULT NULL,
  `field_name` varchar(50) DEFAULT NULL,
  `old_value` varchar(255) DEFAULT NULL,
  `new_value` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=72797 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `deposit_audit_action` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `deposit_id` int(10) unsigned DEFAULT NULL,
  `staff_id` smallint(5) unsigned NOT NULL DEFAULT 0,
  `date_dt` datetime DEFAULT NULL,
  `action_type` varchar(255) DEFAULT NULL,
  `affected_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36466 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `digicert_reviews` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `review` text DEFAULT NULL,
  `nickname` varchar(20) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `status` enum('pending','approved','rejected') DEFAULT 'pending',
  `ip_address` int(10) unsigned DEFAULT NULL,
  `date_time` datetime DEFAULT NULL,
  `stars_overall` tinyint(3) unsigned DEFAULT NULL,
  `stars_features` tinyint(3) unsigned DEFAULT NULL,
  `stars_support` tinyint(3) unsigned DEFAULT NULL,
  `stars_experience` tinyint(3) unsigned DEFAULT NULL,
  `stars_issuance_speed` tinyint(3) unsigned DEFAULT NULL,
  `recommend` tinyint(3) unsigned DEFAULT NULL,
  `helpful` smallint(5) unsigned DEFAULT 0,
  `unhelpful` smallint(5) unsigned DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18027 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `digiloot` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `digiloot_details` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `loot_id` smallint(5) unsigned DEFAULT NULL,
  `size` varchar(10) DEFAULT NULL,
  `color` varchar(20) DEFAULT NULL,
  `stock` smallint(5) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `digiloot_orders` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned DEFAULT NULL,
  `acct_id` int(10) unsigned DEFAULT NULL,
  `loot_id` smallint(5) unsigned DEFAULT NULL,
  `loot_details_id` smallint(5) unsigned DEFAULT NULL,
  `date_time` datetime DEFAULT NULL,
  `status` varchar(20) DEFAULT 'pending',
  `note_to_customer` text DEFAULT NULL,
  `reason` text DEFAULT NULL,
  `staff_id` int(10) unsigned DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `address1` varchar(255) DEFAULT NULL,
  `address2` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `state` varchar(25) DEFAULT NULL,
  `postal_code` varchar(15) DEFAULT NULL,
  `country` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_acct_id` (`acct_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1249 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `direct_accredited` (
  `direct_trust_identifier` varchar(45) NOT NULL,
  `status` tinyint(2) DEFAULT NULL,
  `status_changed` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`direct_trust_identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `disable_ou_script_accounts_affected` (
  `account_id` int(10) unsigned NOT NULL,
  `phase` int(11) NOT NULL,
  `description` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `discount_rates` (
  `id` int(5) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL DEFAULT '',
  `universal` tinyint(1) NOT NULL DEFAULT 0,
  `rates` text NOT NULL,
  `discount_duration_days` int(11) DEFAULT NULL,
  `percent_discount` tinyint(4) NOT NULL DEFAULT 0,
  `percent_discount_products` varchar(50) NOT NULL DEFAULT '0',
  `percent_discount_lifetime` varchar(20) NOT NULL DEFAULT '0',
  `description` text NOT NULL,
  `created_by_staff_id` int(11) NOT NULL,
  `currency` char(3) CHARACTER SET ascii NOT NULL DEFAULT 'USD',
  `manage_code` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_manage_code` (`manage_code`)
) ENGINE=InnoDB AUTO_INCREMENT=15893 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `discount_types` (
  `id` tinyint(3) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `discovery_api_keys` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `discovery_api_key` varchar(32) DEFAULT NULL,
  `acct_id` int(6) NOT NULL DEFAULT 0,
  `max_ip_count` int(11) NOT NULL DEFAULT 1024,
  `customer_name` varchar(150) DEFAULT NULL,
  `customer_organization` varchar(150) DEFAULT NULL,
  `customer_email` varchar(100) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `send_emails` tinyint(4) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `discovery_api_key` (`discovery_api_key`),
  KEY `acct_id` (`acct_id`)
) ENGINE=InnoDB AUTO_INCREMENT=54953 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `discovery_certs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `discovery_api_key_id` int(11) NOT NULL,
  `order_id` int(8) unsigned zerofill NOT NULL DEFAULT 00000000,
  `product_id` int(11) DEFAULT NULL,
  `sha1_thumbprint` varchar(40) DEFAULT NULL,
  `valid_from` date NOT NULL DEFAULT '0000-00-00',
  `valid_till` date NOT NULL DEFAULT '0000-00-00',
  `keysize` int(11) DEFAULT NULL,
  `issuer` varchar(255) DEFAULT NULL,
  `common_name` varchar(255) DEFAULT NULL,
  `sans` text DEFAULT NULL,
  `org_name` varchar(255) DEFAULT NULL,
  `org_city` varchar(255) DEFAULT NULL,
  `org_state` varchar(128) DEFAULT NULL,
  `org_country` varchar(128) DEFAULT NULL,
  `send_minus_30` tinyint(1) NOT NULL DEFAULT 0,
  `send_minus_7` tinyint(1) NOT NULL DEFAULT 0,
  `sent_minus_30` tinyint(1) NOT NULL DEFAULT 0,
  `sent_minus_7` tinyint(1) NOT NULL DEFAULT 0,
  `certificate` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `discovery_api_key_id` (`discovery_api_key_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1094553 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `discovery_cert_usage` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `discovery_scan_id` int(11) DEFAULT NULL,
  `discovery_cert_id` int(11) DEFAULT NULL,
  `servers` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `discovery_scan_id` (`discovery_scan_id`),
  KEY `discovery_cert_id` (`discovery_cert_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2392351 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `discovery_scans` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `discovery_api_key_id` int(11) NOT NULL,
  `scan_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `scan_type` enum('manual','scheduled','') NOT NULL DEFAULT '',
  `scan_duration` int(11) DEFAULT NULL,
  `scan_data` longtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `discovery_api_key_id` (`discovery_api_key_id`)
) ENGINE=InnoDB AUTO_INCREMENT=113794 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `docs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `company_id` int(11) DEFAULT NULL,
  `domain_id` int(11) DEFAULT NULL,
  `contact_id` int(11) DEFAULT NULL,
  `order_id` int(11) DEFAULT NULL,
  `file_path` varchar(255) DEFAULT NULL,
  `upload_time` datetime DEFAULT NULL,
  `status` tinyint(1) DEFAULT 1,
  `staff_id` int(11) DEFAULT NULL,
  `page_current` int(11) DEFAULT NULL,
  `page_count` int(11) DEFAULT NULL,
  `doc_type_id` int(11) NOT NULL,
  `expires_time` datetime DEFAULT NULL,
  `is_perpetual` tinyint(1) NOT NULL DEFAULT 0,
  `display_name` varchar(255) DEFAULT NULL,
  `original_name` varchar(255) DEFAULT NULL,
  `file_modified_time` datetime DEFAULT NULL,
  `user_uploaded` tinyint(1) DEFAULT 0,
  `user_id` int(11) DEFAULT NULL,
  `key_index` tinyint(4) NOT NULL DEFAULT 0,
  `execution_date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_company_assertions_companies` (`company_id`),
  KEY `fk_company_assertions_domains` (`domain_id`),
  KEY `fk_assertion_docs_staff_id` (`staff_id`),
  KEY `contact_id` (`contact_id`),
  KEY `order_id` (`order_id`),
  KEY `docs_upload_time` (`upload_time`)
) ENGINE=InnoDB AUTO_INCREMENT=35595122 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `docs_unassigned` (
  `doc_id` int(11) NOT NULL DEFAULT 0,
  `staff_id` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`doc_id`),
  KEY `staff_id` (`staff_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `doc_emails` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `doc_id` int(10) unsigned NOT NULL,
  `email_address` varchar(255) DEFAULT NULL,
  `staff_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_doc_id` (`doc_id`)
) ENGINE=InnoDB AUTO_INCREMENT=339608 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `doc_history` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `doc_id` int(11) DEFAULT NULL,
  `staff_id` int(11) DEFAULT NULL,
  `action` enum('EXPIRE','NOTE','APPROVE','REJECT','CHANGE','UPLOAD') DEFAULT NULL,
  `datetime` datetime DEFAULT NULL,
  `note` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_company_assertions_docs` (`doc_id`),
  KEY `fk_company_assertions_staff` (`staff_id`)
) ENGINE=InnoDB AUTO_INCREMENT=41879159 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `doc_phone_number` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `doc_id` int(10) unsigned NOT NULL,
  `phone_number` varchar(64) DEFAULT NULL,
  `staff_id` int(10) unsigned NOT NULL,
  `phone_ext` varchar(48) DEFAULT NULL,
  `twilio_call_sid` varchar(48) DEFAULT NULL,
  `call_status_code` varchar(100) DEFAULT NULL,
  `call_status_message` varchar(100) DEFAULT NULL,
  `authenticity_pin` varchar(32) DEFAULT NULL,
  `last_update_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_doc_id` (`doc_id`)
) ENGINE=InnoDB AUTO_INCREMENT=109329 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `doc_statuses` (
  `id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `doc_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `description` text DEFAULT NULL,
  `short_name` varchar(50) DEFAULT NULL,
  `valid_time` varchar(25) DEFAULT NULL,
  `is_perpetual` tinyint(1) NOT NULL DEFAULT 0,
  `sort_order` int(10) unsigned DEFAULT 0,
  `auto_assign` enum('DOMAIN','COMPANY','CONTACT') DEFAULT NULL,
  `use_execution_date` tinyint(1) NOT NULL DEFAULT 0,
  `is_active` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `domains` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `scope` varchar(255) DEFAULT NULL,
  `company_id` int(11) NOT NULL DEFAULT 0,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `date_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `standalone` tinyint(1) NOT NULL DEFAULT 0,
  `approved_by` int(11) NOT NULL DEFAULT 0,
  `reject_notes` varchar(255) NOT NULL DEFAULT '',
  `reject_date_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `reject_staff` int(10) unsigned NOT NULL DEFAULT 0,
  `is_public` tinyint(4) NOT NULL DEFAULT 1,
  `internal_staff_id` int(10) unsigned DEFAULT NULL,
  `internal_date_time` datetime DEFAULT NULL,
  `flag` tinyint(4) NOT NULL DEFAULT 0,
  `snooze_until` datetime DEFAULT NULL,
  `alexa_rank` int(12) unsigned DEFAULT NULL,
  `namespace_protected` tinyint(4) NOT NULL DEFAULT 0,
  `pending_validation_checklist_ids` varchar(50) NOT NULL DEFAULT '',
  `validation_submit_date` datetime DEFAULT NULL,
  `checklist_modifiers` varchar(30) NOT NULL DEFAULT '',
  `dns_caa` enum('unknown','not_found','found') NOT NULL DEFAULT 'unknown',
  `dns_caa_date` date NOT NULL DEFAULT '1900-01-01',
  `allow_cname_dcv` tinyint(4) NOT NULL DEFAULT 0,
  `risk_score` smallint(5) unsigned NOT NULL DEFAULT 0,
  `dcv_method` varchar(20) DEFAULT NULL,
  `dcv_name_scope` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `company_id` (`company_id`),
  KEY `status` (`status`),
  KEY `is_public` (`is_public`),
  KEY `snooze_until` (`snooze_until`),
  KEY `pending_validation_checklist_ids` (`pending_validation_checklist_ids`),
  KEY `validation_submit_date` (`validation_submit_date`),
  KEY `date_time` (`date_time`)
) ENGINE=InnoDB AUTO_INCREMENT=2582868 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `domain_blacklists` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `domain_ra_map` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `domain_name` varchar(255) NOT NULL,
  `domain_id` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_domain_id_name` (`domain_id`,`domain_name`),
  KEY `idx_domain_name` (`domain_name`),
  KEY `idx_domain_id` (`domain_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2875202 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `domain_statuses` (
  `id` tinyint(4) NOT NULL AUTO_INCREMENT,
  `name` mediumtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `early_expired_snapshots` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `enterprise_snapshot_id` int(11) DEFAULT NULL,
  `acct_id` int(11) DEFAULT NULL,
  `container_id` int(11) DEFAULT NULL,
  `company_id` int(11) DEFAULT NULL,
  `domain_id` int(11) DEFAULT NULL,
  `snapshot_active_orders` int(11) DEFAULT NULL,
  `vip` int(11) DEFAULT NULL,
  `is_cis` int(11) DEFAULT NULL,
  `days_since_last_order_snapshot` int(11) DEFAULT NULL,
  `days_till_next_expiration_snapshot` int(11) DEFAULT NULL,
  `days_till_dcv_expires` int(11) DEFAULT NULL,
  `account_active_orders` int(11) DEFAULT NULL,
  `days_since_api_used` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `enterprise_snapshot_id` (`enterprise_snapshot_id`),
  KEY `acct_id` (`acct_id`),
  KEY `company_id` (`company_id`),
  KEY `domain_id` (`domain_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14652 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `email_machine_templates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL DEFAULT '',
  `template` text NOT NULL,
  `note_template` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `email_subscription_status` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `email_address` varchar(255) NOT NULL,
  `subscribed` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `last_updated_by_user_id` int(10) unsigned NOT NULL DEFAULT 0,
  `last_updated` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `date_created` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_email_address` (`email_address`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `email_template` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date_created` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `account_id` int(11) NOT NULL DEFAULT 0,
  `container_id` int(11) DEFAULT NULL,
  `language_code` varchar(10) NOT NULL DEFAULT 'en',
  `template_name` varchar(50) NOT NULL,
  `template_content` text DEFAULT NULL,
  `active` tinyint(4) NOT NULL DEFAULT 1,
  `descriptor` varchar(50) DEFAULT NULL,
  `whitelabel_image_url` varchar(255) DEFAULT NULL,
  `from_email` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_index` (`account_id`,`language_code`,`template_name`,`active`),
  KEY `account_id` (`account_id`),
  KEY `template_name` (`template_name`(16))
) ENGINE=InnoDB AUTO_INCREMENT=1381 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `email_tokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `token` varchar(128) NOT NULL DEFAULT '',
  `create_date` datetime DEFAULT NULL,
  `expiry_date` datetime DEFAULT NULL,
  `order_id` int(10) unsigned NOT NULL DEFAULT 0,
  `reissue_id` int(10) unsigned NOT NULL DEFAULT 0,
  `ent_client_cert_id` int(10) unsigned NOT NULL DEFAULT 0,
  `company_id` int(10) NOT NULL DEFAULT 0,
  `purpose` varchar(40) NOT NULL DEFAULT 'other',
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `reissue_id` (`reissue_id`),
  KEY `ent_client_cert_id` (`ent_client_cert_id`),
  KEY `idx_token` (`token`(6))
) ENGINE=InnoDB AUTO_INCREMENT=685071 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `email_token_common_name_map` (
  `token_id` int(10) unsigned DEFAULT NULL,
  `common_name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `enterprise_snapshots` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `company_id` int(10) unsigned NOT NULL DEFAULT 0,
  `domain_id` int(10) unsigned NOT NULL DEFAULT 0,
  `checklist_id` int(10) unsigned NOT NULL DEFAULT 0,
  `snapshot_info` text DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `validated_until` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `company_id` (`company_id`),
  KEY `domain_id` (`domain_id`)
) ENGINE=InnoDB AUTO_INCREMENT=20086813 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `ent_account_active_dates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `acct_id` int(6) unsigned zerofill NOT NULL,
  `signup_date` datetime NOT NULL,
  `deactivation_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `acct_id` (`acct_id`,`signup_date`)
) ENGINE=InnoDB AUTO_INCREMENT=23924 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `ent_account_info` (
  `acct_id` int(6) unsigned zerofill NOT NULL,
  `account_title` varchar(128) DEFAULT NULL,
  `ekey` varchar(32) NOT NULL,
  `signup_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `alt_url` varchar(255) NOT NULL,
  `branding_logo` varchar(128) DEFAULT NULL,
  `admin_email` varchar(255) DEFAULT NULL,
  `admin_email_settings` text DEFAULT NULL,
  `request_page_note` text DEFAULT NULL,
  `balance_reminder_threshold` int(11) DEFAULT 1000,
  `balance_negative_limit` int(11) DEFAULT 0,
  `role_permissions` varchar(10000) NOT NULL DEFAULT '',
  `allow_prod_change` tinyint(1) NOT NULL DEFAULT 1,
  `allow_single_limited` tinyint(1) NOT NULL DEFAULT 1,
  `allow_wildcard_limited` tinyint(1) NOT NULL DEFAULT 0,
  `allow_uc_limited` tinyint(1) NOT NULL DEFAULT 1,
  `allow_ev_limited` tinyint(1) NOT NULL DEFAULT 1,
  `allow_single_admin` tinyint(4) NOT NULL DEFAULT 1,
  `allow_wildcard_admin` tinyint(4) NOT NULL DEFAULT 0,
  `allow_uc_admin` tinyint(4) NOT NULL DEFAULT 1,
  `allow_ev_admin` tinyint(4) NOT NULL DEFAULT 1,
  `allow_single_helpdesk` tinyint(4) NOT NULL DEFAULT 1,
  `allow_wildcard_helpdesk` tinyint(4) NOT NULL DEFAULT 0,
  `allow_uc_helpdesk` tinyint(4) NOT NULL DEFAULT 1,
  `allow_ev_helpdesk` tinyint(4) NOT NULL DEFAULT 1,
  `allow_one_year_limited` tinyint(4) NOT NULL DEFAULT 1,
  `allow_two_year_limited` tinyint(4) NOT NULL DEFAULT 1,
  `allow_three_year_limited` tinyint(4) NOT NULL DEFAULT 1,
  `allow_login_requests` tinyint(4) NOT NULL DEFAULT 1,
  `allow_custom_expiration` tinyint(4) NOT NULL DEFAULT 1,
  `allow_unvalidated_approvals` tinyint(4) NOT NULL DEFAULT 0,
  `allow_client_certs` tinyint(4) NOT NULL DEFAULT 0,
  `allow_guest_requests` tinyint(64) NOT NULL DEFAULT 0,
  `client_cert_settings` set('allow','allow_client_only','allow_escrow','allow_client_private','allow_client_custom_public') NOT NULL,
  `client_cert_subroot_id` smallint(5) unsigned NOT NULL DEFAULT 34,
  `client_cert_support_phone` varchar(255) DEFAULT NULL,
  `client_cert_support_email` varchar(255) DEFAULT NULL,
  `client_cert_support_text` varchar(2500) DEFAULT NULL,
  `client_cert_api_return_url` varchar(255) DEFAULT NULL,
  `default_signature_hash` enum('sha1','sha256','sha384','sha512') NOT NULL DEFAULT 'sha1',
  `guest_request_token` varchar(50) DEFAULT NULL,
  `guest_request_ips` text DEFAULT NULL,
  `guest_request_ips_unrestricted` tinyint(1) DEFAULT 0,
  `separate_unit_funds` tinyint(4) NOT NULL DEFAULT 0,
  `ev_api_agreement_id` int(11) DEFAULT NULL,
  `allow_private_ssl` tinyint(4) NOT NULL DEFAULT 0,
  `gtld_account_enabled` tinyint(4) NOT NULL DEFAULT 0,
  `allow_wifi_in_gui` tinyint(4) NOT NULL DEFAULT 0,
  `whois_account_enabled` tinyint(4) NOT NULL DEFAULT 0,
  `default_validity` tinyint(3) unsigned DEFAULT 3,
  PRIMARY KEY (`acct_id`),
  KEY `idx_ekey` (`ekey`(6))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `ent_approval_rules` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `acct_id` int(6) unsigned zerofill NOT NULL,
  `name` varchar(255) NOT NULL,
  `sort_order` int(11) NOT NULL,
  `status` enum('active','inactive','deleted') NOT NULL,
  `created_by_id` int(11) NOT NULL,
  `cron` int(1) NOT NULL DEFAULT 0,
  `data` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2402 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `ent_client_certs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `product_id` int(10) unsigned DEFAULT NULL,
  `domain_id` int(10) unsigned NOT NULL DEFAULT 0,
  `company_id` int(10) unsigned NOT NULL DEFAULT 0,
  `common_name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `org_unit` varchar(255) DEFAULT NULL,
  `cert_profile_id` int(11) NOT NULL DEFAULT 1,
  `status` tinyint(3) unsigned NOT NULL DEFAULT 1,
  `reason` tinyint(3) unsigned NOT NULL DEFAULT 1,
  `date_requested` datetime DEFAULT NULL,
  `date_issued` datetime DEFAULT NULL,
  `lifetime` tinyint(3) unsigned DEFAULT NULL,
  `valid_from` date DEFAULT NULL,
  `valid_till` date DEFAULT NULL,
  `serial_number` varchar(128) DEFAULT NULL,
  `origin` enum('ui','api') DEFAULT 'ui',
  `renewals_left` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `renewal_record_exists` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `renewal_of_cert_id` int(10) unsigned NOT NULL DEFAULT 0,
  `approved_by` int(10) unsigned NOT NULL DEFAULT 0,
  `stat_row_id` int(10) unsigned NOT NULL DEFAULT 0,
  `ca_cert_id` smallint(6) unsigned NOT NULL DEFAULT 0,
  `receipt_id` int(10) unsigned NOT NULL DEFAULT 0,
  `email_token` varchar(32) DEFAULT NULL,
  `date_emailed` datetime DEFAULT NULL,
  `ca_order_id` int(10) unsigned NOT NULL DEFAULT 0,
  `csr` text DEFAULT NULL,
  `signature_hash` enum('sha1','sha256','sha384','sha512') NOT NULL DEFAULT 'sha1',
  `reissued_cert_id` int(10) unsigned NOT NULL DEFAULT 0,
  `reissue_email_sent` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `agreement_id` int(10) unsigned NOT NULL DEFAULT 0,
  `inpriva_email_validated` tinyint(4) NOT NULL DEFAULT 0,
  `is_out_of_contract` tinyint(1) NOT NULL DEFAULT 0,
  `user_id` int(10) unsigned DEFAULT NULL,
  `order_tracker_id` int(10) unsigned DEFAULT NULL,
  `thumbprint` varchar(40) DEFAULT NULL,
  `certificate_tracker_id` int(10) unsigned DEFAULT NULL,
  `unique_id` varchar(10) NOT NULL DEFAULT '',
  `pay_type` varchar(4) DEFAULT NULL,
  `disable_issuance_email` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `dns_names` text DEFAULT NULL,
  `additional_template_data` text DEFAULT NULL,
  `note` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `domain_id` (`domain_id`),
  KEY `company_id` (`company_id`),
  KEY `ent_client_certs_valid_from` (`valid_from`),
  KEY `is_out_of_contract` (`is_out_of_contract`),
  KEY `status` (`status`),
  KEY `order_tracker_id` (`order_tracker_id`),
  KEY `certificate_tracker_id_idx` (`certificate_tracker_id`),
  KEY `idx_reissued_cert_id` (`reissued_cert_id`),
  KEY `ix_renewal_id` (`renewal_of_cert_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1267593 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `ent_client_cert_data` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `client_cert_id` int(11) NOT NULL,
  `data` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8030 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `ent_client_cert_recovery_requests` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ent_client_cert_id` int(10) unsigned NOT NULL,
  `account_admin_id` int(10) unsigned NOT NULL,
  `recovery_admin_id` int(10) unsigned NOT NULL,
  `email_token` varchar(100) NOT NULL,
  `date_time` datetime NOT NULL,
  `recover_date_time` datetime NOT NULL,
  PRIMARY KEY (`id`,`email_token`),
  UNIQUE KEY `email_token` (`email_token`)
) ENGINE=InnoDB AUTO_INCREMENT=1921 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `ent_requests` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `acct_id` int(6) unsigned zerofill NOT NULL,
  `unit_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `alt_user_id` int(10) unsigned NOT NULL,
  `order_id` int(8) unsigned zerofill NOT NULL,
  `old_order_id` int(8) unsigned zerofill NOT NULL,
  `company_id` int(11) NOT NULL DEFAULT 0,
  `request_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `ip_address` varchar(15) NOT NULL,
  `action` enum('issue','revoke','renew','reissue','duplicate','new user') NOT NULL,
  `csr` text NOT NULL,
  `serversw` smallint(5) NOT NULL,
  `licenses` tinyint(4) NOT NULL,
  `common_names` text NOT NULL,
  `org_unit` varchar(255) NOT NULL,
  `lifetime` tinyint(4) NOT NULL,
  `product_id` int(11) NOT NULL,
  `status` set('pending','approved','rejected','preapproved') DEFAULT NULL,
  `mtime` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `comments` text NOT NULL,
  `admin_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `admin_id` int(10) unsigned DEFAULT NULL,
  `admin_note` text DEFAULT NULL,
  `auto_renew` tinyint(4) DEFAULT 0,
  `auto_renew_email_sent` tinyint(4) DEFAULT 0,
  `allow_unit_access` tinyint(1) NOT NULL DEFAULT 0,
  `valid_till` date NOT NULL DEFAULT '0000-00-00',
  `short_issue` date NOT NULL DEFAULT '0000-00-00',
  `signature_hash` enum('sha1','sha256','sha384','sha512') NOT NULL DEFAULT 'sha1',
  `root_path` enum('digicert','entrust','cybertrust','comodo') NOT NULL DEFAULT 'entrust',
  `grid_service_name` varchar(255) DEFAULT NULL,
  `promo_code` varchar(50) NOT NULL,
  `custom_fields` mediumtext DEFAULT NULL,
  `additional_emails` text DEFAULT NULL,
  `guest_request_name` varchar(255) DEFAULT NULL,
  `guest_request_email` varchar(255) DEFAULT NULL,
  `ip_outside_range` tinyint(1) DEFAULT 0,
  `order_users` varchar(255) DEFAULT NULL,
  `agreement_id` int(10) unsigned DEFAULT NULL,
  `ca_cert_id` smallint(4) unsigned DEFAULT NULL,
  `wifi_data` text DEFAULT NULL,
  `product_addons` text DEFAULT NULL,
  `ssl_profile_option` enum('data_encipherment','secure_email_eku') DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `acct_id` (`acct_id`),
  KEY `user_id` (`user_id`),
  KEY `order_id` (`order_id`),
  KEY `status` (`status`),
  KEY `unit_id` (`unit_id`),
  KEY `old_order_id` (`old_order_id`),
  KEY `company_id` (`company_id`)
) ENGINE=InnoDB AUTO_INCREMENT=720937 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `ent_request_docs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `file_path` varchar(255) DEFAULT NULL,
  `original_name` varchar(96) DEFAULT NULL,
  `upload_time` datetime DEFAULT '1900-01-01 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30022 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `ent_subdomains` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `domain_id` int(11) DEFAULT NULL,
  `subdomain` varchar(255) NOT NULL,
  `ctime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `domain_id` (`domain_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1012202 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `ent_units` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `acct_id` int(6) unsigned zerofill DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `allowed_domains` text NOT NULL,
  `moved_to_container_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `acct_id` (`acct_id`)
) ENGINE=InnoDB AUTO_INCREMENT=31585 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `ev_company_agreements` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `verified_contact_id` int(10) unsigned NOT NULL DEFAULT 0,
  `company_id` int(10) unsigned NOT NULL DEFAULT 0,
  `date_time` datetime NOT NULL,
  `ip_address` varchar(15) NOT NULL,
  `agreement_id` int(10) unsigned NOT NULL DEFAULT 0,
  `status` enum('active','inactive') DEFAULT 'active',
  `verified_contact_snapshot_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `company_id` (`company_id`),
  KEY `verified_contact_id` (`verified_contact_id`),
  KEY `status` (`status`),
  KEY `verified_contact_snapshot_id` (`verified_contact_snapshot_id`)
) ENGINE=InnoDB AUTO_INCREMENT=78900 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `ev_contacts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) NOT NULL,
  `company_id` int(11) NOT NULL,
  `role_id` tinyint(1) NOT NULL,
  `firstname` varchar(64) NOT NULL,
  `lastname` varchar(64) NOT NULL,
  `email` varchar(255) NOT NULL,
  `job_title` varchar(64) NOT NULL,
  `telephone` varchar(32) NOT NULL,
  `master_agreement_id` int(11) NOT NULL,
  `token` varchar(200) NOT NULL,
  `token_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `company_role` (`company_id`,`role_id`),
  KEY `user_id` (`user_id`),
  KEY `master_agreement_id_email` (`master_agreement_id`,`email`)
) ENGINE=InnoDB AUTO_INCREMENT=10795 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `ev_contacts_temp` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(8) unsigned zerofill NOT NULL,
  `role_id` tinyint(1) NOT NULL,
  `firstname` varchar(128) NOT NULL,
  `lastname` varchar(128) NOT NULL,
  `job_title` varchar(128) NOT NULL,
  `email` varchar(255) NOT NULL,
  `telephone` varchar(32) NOT NULL,
  `company_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `role_id` (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11995 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `ev_master_agreements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `company_id` int(11) NOT NULL,
  `date_signed` date NOT NULL,
  `date_entered` datetime NOT NULL,
  `valid_till` date NOT NULL,
  `doc_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `company_id` (`company_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2334 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `extended_order_info` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(10) unsigned NOT NULL,
  `valid_till` date DEFAULT NULL,
  `is_longer_validity_order` tinyint(1) DEFAULT 0,
  `auto_reissue` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_order_id` (`order_id`),
  KEY `ix_valid_till` (`valid_till`)
) ENGINE=InnoDB AUTO_INCREMENT=7667058 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `external_service_lookups` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` int(10) unsigned NOT NULL,
  `external_id` varchar(255) NOT NULL,
  `service` varchar(255) NOT NULL,
  `date_created` datetime NOT NULL DEFAULT current_timestamp(),
  `date_updated` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `external_service_lookups_account_id_idx` (`account_id`),
  KEY `external_service_lookups_service_id_idx` (`external_id`),
  KEY `external_service_lookups_service_idx` (`service`)
) ENGINE=InnoDB AUTO_INCREMENT=22050 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `feature` (
  `id` int(10) unsigned NOT NULL,
  `date_created` datetime DEFAULT NULL,
  `feature_name` varchar(255) NOT NULL,
  `display_name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `display_name_UNIQUE` (`display_name`),
  UNIQUE KEY `feature_name_UNIQUE` (`feature_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `file` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `extension` varchar(16) DEFAULT NULL,
  `path` varchar(255) DEFAULT NULL,
  `size` int(10) unsigned NOT NULL,
  `is_temporary` tinyint(4) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=243564 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `flags` (
  `id` tinyint(1) NOT NULL AUTO_INCREMENT,
  `number` tinyint(1) NOT NULL DEFAULT 0,
  `color` varchar(16) NOT NULL DEFAULT '',
  `description` varchar(128) NOT NULL DEFAULT '',
  `color_code` varchar(7) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`),
  KEY `color` (`color`),
  KEY `description` (`description`),
  KEY `color_code` (`color_code`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `followup_statuses` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `geo_address_override` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL DEFAULT current_timestamp(),
  `staff_id` int(10) unsigned NOT NULL,
  `company_id` int(10) unsigned NOT NULL,
  `order_id` int(11) DEFAULT NULL,
  `org_address` varchar(500) NOT NULL,
  `description` varchar(500) NOT NULL,
  `audited_date` datetime DEFAULT NULL,
  `audited_by` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`staff_id`),
  KEY `idx_company_id` (`company_id`),
  KEY `idx_order_id` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2583 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `geo_country_regions` (
  `country` varchar(2) NOT NULL DEFAULT '',
  `country_name` varchar(255) DEFAULT NULL,
  `region` varchar(255) DEFAULT NULL,
  `language` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`country`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `guest_request` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `requester_name` varchar(75) NOT NULL,
  `requester_email` varchar(75) NOT NULL,
  `request_date` datetime NOT NULL,
  `approve_date` datetime DEFAULT NULL,
  `container_id` int(11) NOT NULL,
  `note` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `hardenize_accounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(10) unsigned NOT NULL,
  `account_name` varchar(16) NOT NULL,
  `status` varchar(16) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `last_updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_id` (`account_id`),
  KEY `idx_account_id` (`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=446 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `hardenize_ct_notification_status` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `email_type` varchar(100) DEFAULT NULL,
  `email_status` tinyint(1) DEFAULT NULL,
  `api_request` text DEFAULT NULL,
  `email_recipients` varchar(100) DEFAULT NULL,
  `notification_trigger_time` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_account_id_email_type_notification_time` (`account_id`,`email_type`,`notification_trigger_time`)
) ENGINE=InnoDB AUTO_INCREMENT=1609 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `hardenize_order_ct_monitoring_status` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `order_id` bigint(20) NOT NULL,
  `hostname` varchar(1024) NOT NULL,
  `ct_monitoring_status` tinyint(1) DEFAULT NULL,
  `date_created` datetime NOT NULL DEFAULT current_timestamp(),
  `last_updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_order_id` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2177 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `hardware_order_extras` (
  `order_id` int(8) unsigned zerofill NOT NULL,
  `ship_name` varchar(128) DEFAULT NULL,
  `ship_addr1` varchar(128) DEFAULT NULL,
  `ship_addr2` varchar(128) DEFAULT NULL,
  `ship_city` varchar(128) DEFAULT NULL,
  `ship_state` varchar(128) DEFAULT NULL,
  `ship_zip` varchar(40) DEFAULT NULL,
  `ship_country` varchar(128) DEFAULT NULL,
  `ship_method` enum('STANDARD','EXPEDITED') DEFAULT NULL,
  `device_manufacturer` varchar(128) DEFAULT NULL,
  `device_serial` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `hardware_platforms` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `display_name` varchar(100) NOT NULL DEFAULT '',
  `product_name` varchar(100) NOT NULL DEFAULT '',
  `model` varchar(50) NOT NULL DEFAULT '',
  `manufacturer` varchar(100) NOT NULL DEFAULT '',
  `sort_order` int(11) NOT NULL DEFAULT 100,
  `driver_url` varchar(200) NOT NULL DEFAULT '',
  `device_type` enum('token','hsm') NOT NULL DEFAULT 'token',
  `fips_certified` varchar(20) NOT NULL DEFAULT '',
  `common_criteria_certified` varchar(30) NOT NULL DEFAULT '',
  `enabled_for_product` set('evcode','ds') NOT NULL DEFAULT 'evcode,ds',
  PRIMARY KEY (`id`),
  KEY `device_type` (`fips_certified`),
  KEY `common_criteria_certified` (`common_criteria_certified`),
  KEY `product_name` (`product_name`),
  KEY `manufacturer` (`manufacturer`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `hardware_ship_info` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(8) unsigned zerofill NOT NULL DEFAULT 00000000,
  `status` enum('pending','created','shipped','received') NOT NULL DEFAULT 'pending',
  `tracking_number` varchar(100) DEFAULT NULL,
  `date_mailed` datetime DEFAULT NULL,
  `date_received` datetime DEFAULT NULL,
  `hardware_otp` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=15093 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `hardware_token_info` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(8) unsigned zerofill NOT NULL DEFAULT 00000000,
  `init_code` varchar(128) NOT NULL,
  `status` enum('active','used','rejected') NOT NULL DEFAULT 'active',
  `date_generated` datetime DEFAULT NULL,
  `token_platform_id` int(11) NOT NULL DEFAULT 0,
  `token_info` text NOT NULL,
  `created_by_customer` tinyint(1) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `init_code` (`init_code`)
) ENGINE=InnoDB AUTO_INCREMENT=41174 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `heartbleed_certs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `acct_id` int(6) unsigned zerofill NOT NULL DEFAULT 000000,
  `order_id` int(8) unsigned zerofill NOT NULL DEFAULT 00000000,
  `status` enum('patch','replace','install','revoke','complete') NOT NULL DEFAULT 'patch',
  `serial_number` varchar(36) NOT NULL DEFAULT '',
  `thumbprint` varchar(42) NOT NULL DEFAULT '',
  `host_name` varchar(128) NOT NULL DEFAULT '',
  `ip_address` varchar(15) NOT NULL DEFAULT '',
  `port` smallint(5) unsigned NOT NULL DEFAULT 443,
  `valid_till` date NOT NULL DEFAULT '1900-01-01',
  `create_date` datetime NOT NULL DEFAULT '1900-01-01 00:00:00',
  `last_vulnerable` datetime NOT NULL DEFAULT '1900-01-01 00:00:00',
  `last_scanned` datetime NOT NULL DEFAULT '1900-01-01 00:00:00',
  `hash1` int(10) unsigned NOT NULL DEFAULT 0,
  `hash2` int(10) unsigned NOT NULL DEFAULT 0,
  `hash3` int(10) unsigned NOT NULL DEFAULT 0,
  `hash4` int(10) unsigned NOT NULL DEFAULT 0,
  `hash5` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `serial_number` (`serial_number`(8)),
  KEY `thumbprint` (`thumbprint`(8)),
  KEY `hash1` (`hash1`),
  KEY `host_lookup` (`ip_address`(6),`host_name`(4)),
  KEY `acct_id` (`acct_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14320 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `high_risk_clues` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `field_name` enum('email','org_name','country','contact_name','phone','domain','general_keyword','ip_address','whois') DEFAULT NULL,
  `match_type` enum('contains','startswith','endswith','regex','equals','slim_org_match') NOT NULL DEFAULT 'equals',
  `value` varchar(200) NOT NULL,
  `risk_score` int(11) NOT NULL DEFAULT 10,
  `created_by_staff_id` int(11) NOT NULL DEFAULT 0,
  `date_added` datetime NOT NULL,
  `reason` varchar(200) DEFAULT NULL,
  `limited_to_products` varchar(255) NOT NULL DEFAULT '',
  `limited_to_org_types` varchar(255) NOT NULL DEFAULT '',
  `status` enum('active','deleted') DEFAULT 'active',
  PRIMARY KEY (`id`),
  UNIQUE KEY `field_name_2` (`field_name`,`match_type`,`value`),
  KEY `field_name` (`field_name`),
  KEY `match_type` (`match_type`),
  KEY `value` (`value`)
) ENGINE=InnoDB AUTO_INCREMENT=5347 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `high_risk_clues_whitelist` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `high_risk_clue_id` int(10) unsigned NOT NULL,
  `account_id` int(10) unsigned NOT NULL,
  `is_active` tinyint(3) unsigned NOT NULL DEFAULT 1,
  `date_created` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `created_staff_id` smallint(5) unsigned NOT NULL,
  `date_inactivated` timestamp NULL DEFAULT NULL,
  `inactivated_staff_id` smallint(5) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `high_risk_clue_id` (`high_risk_clue_id`),
  KEY `account_id` (`account_id`),
  KEY `is_active` (`is_active`)
) ENGINE=InnoDB AUTO_INCREMENT=1577 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `hisp_account_extras` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `acct_id` int(11) DEFAULT NULL,
  `is_ra` int(1) NOT NULL DEFAULT 0,
  `accredited_roots` varchar(255) DEFAULT NULL,
  `non_accredited_root` int(11) DEFAULT NULL,
  `direct_trust_identifier` varchar(255) DEFAULT NULL,
  `accredited` tinyint(4) DEFAULT 0,
  `declaration_of_id_path` varchar(255) NOT NULL,
  `declaration_of_id_name` varchar(255) NOT NULL,
  `declaration_of_id_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `validation_contact` enum('isso','applicant','org_contact','hisp_contact') NOT NULL DEFAULT 'isso',
  `pre_validation_contact` enum('org_contact','hisp_contact') NOT NULL DEFAULT 'hisp_contact',
  `validation_level` enum('standard','minimum') DEFAULT 'standard',
  `single_use` int(1) DEFAULT 0,
  `use_npi` int(1) DEFAULT 0,
  `show_case_notes` tinyint(4) DEFAULT 0,
  `use_experian` int(1) DEFAULT 0,
  `products` set('address','org','device','fbca_address') DEFAULT 'address,org,device',
  PRIMARY KEY (`id`),
  UNIQUE KEY `acct_id` (`acct_id`),
  KEY `direct_trust_identifier` (`direct_trust_identifier`)
) ENGINE=InnoDB AUTO_INCREMENT=118 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `hisp_company_extras` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `company_id` int(11) NOT NULL,
  `agreement_id` int(11) DEFAULT NULL,
  `agreement_user_id` int(11) DEFAULT NULL,
  `ent_request_id` int(11) DEFAULT NULL,
  `level` enum('basic','medium') DEFAULT 'basic',
  `sole_proprietor` int(1) DEFAULT NULL,
  `hipaa_type` enum('covered','associate','other','notapplicable','notdeclared','patient') DEFAULT NULL,
  `accredited_root` int(11) DEFAULT 88,
  `validation_contact` enum('isso','applicant','org_contact','hisp_contact') NOT NULL DEFAULT 'isso',
  `pre_validation_contact` enum('org_contact','hisp_contact') NOT NULL DEFAULT 'hisp_contact',
  `declaration_of_id_path` varchar(255) NOT NULL,
  `declaration_of_id_name` varchar(255) NOT NULL,
  `declaration_of_id_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `single_use` int(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_company` (`company_id`),
  KEY `ent_request_id` (`ent_request_id`)
) ENGINE=InnoDB AUTO_INCREMENT=102805 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `hisp_ent_request_extras` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ent_request_id` int(11) DEFAULT NULL,
  `isso_id` int(11) DEFAULT NULL,
  `representative_id` int(11) DEFAULT NULL,
  `verified_contact_id` int(11) DEFAULT NULL,
  `level` enum('basic','medium') DEFAULT 'basic',
  `subject_individual_id` int(11) DEFAULT NULL,
  `ca_cert_id_deprecated` int(11) NOT NULL DEFAULT 0,
  `domain` text DEFAULT NULL,
  `subdomain` text DEFAULT NULL,
  `contact_email` varchar(255) DEFAULT NULL,
  `direct_email` varchar(255) DEFAULT NULL,
  `hipaa_type` enum('covered','associate','other','notapplicable','notdeclared','patient') DEFAULT NULL,
  `csr2` text DEFAULT NULL,
  `npi_id` int(11) DEFAULT NULL,
  `include_address` tinyint(1) DEFAULT NULL,
  `group_cert` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ent_request_id` (`ent_request_id`),
  KEY `npi_id` (`npi_id`)
) ENGINE=InnoDB AUTO_INCREMENT=269089 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `hisp_public_keys` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `acct_id` int(11) DEFAULT NULL,
  `type` set('encryption','signing','dual') DEFAULT NULL,
  `hash1` int(10) unsigned DEFAULT NULL,
  `hash2` int(10) unsigned DEFAULT NULL,
  `hash3` int(10) unsigned DEFAULT NULL,
  `hash4` int(10) unsigned DEFAULT NULL,
  `hash5` int(10) unsigned DEFAULT NULL,
  `issued_date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index2` (`acct_id`,`hash1`,`hash2`,`hash3`,`hash4`,`hash5`)
) ENGINE=InnoDB AUTO_INCREMENT=246779 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `hisp_user_extras` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `addr1` varchar(128) DEFAULT NULL,
  `addr2` varchar(128) DEFAULT NULL,
  `city` varchar(128) DEFAULT NULL,
  `state` varchar(128) DEFAULT NULL,
  `zip` varchar(40) DEFAULT NULL,
  `country` varchar(2) DEFAULT NULL,
  `agreement_id` int(11) DEFAULT NULL,
  `agreement_date` datetime DEFAULT NULL,
  `alternate_email` varchar(255) DEFAULT NULL,
  `level` set('basic','medium') DEFAULT 'basic',
  `access_certs` tinyint(1) DEFAULT 0,
  `isso` tinyint(1) DEFAULT 0,
  `representative` tinyint(1) DEFAULT 0,
  `trusted_agent` tinyint(1) DEFAULT 0,
  `all_hcos` tinyint(1) DEFAULT 0,
  `written_agreement` tinyint(1) DEFAULT 0,
  `ta_written_agreement` tinyint(1) DEFAULT 0,
  `encrypted_data` text NOT NULL,
  `user_completed` int(1) DEFAULT 0,
  `verification_method` enum('experian','doid') DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=137548 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `i18n_languages` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name_in_english` varchar(255) NOT NULL DEFAULT '',
  `name_in_language` varchar(255) NOT NULL,
  `abbreviation` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `abbr` (`abbreviation`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `imperva_block_ip_rules` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ip_address` varchar(40) NOT NULL DEFAULT '',
  `imperva_rule_id` int(11) NOT NULL,
  `created_time` datetime NOT NULL DEFAULT current_timestamp(),
  `disabled_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `imperva_rule_id` (`imperva_rule_id`),
  KEY `disabled_time` (`disabled_time`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `incentive_plans` (
  `id` tinyint(4) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `incident_communications_report_cache` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` int(10) unsigned DEFAULT NULL,
  `company_id` int(10) unsigned DEFAULT NULL,
  `company_name` varchar(256) DEFAULT NULL,
  `order_id` int(8) unsigned DEFAULT NULL,
  `reissue_id` int(11) DEFAULT NULL,
  `duplicate_id` int(11) DEFAULT NULL,
  `serial_number` varchar(36) DEFAULT NULL,
  `common_name` varchar(128) DEFAULT NULL,
  `sans` text DEFAULT NULL,
  `product_name` varchar(128) DEFAULT NULL,
  `valid_from` datetime DEFAULT NULL,
  `valid_to` datetime DEFAULT NULL,
  `revoked_status` varchar(16) DEFAULT NULL,
  `revoked_time` datetime DEFAULT NULL,
  `certificate_pem` mediumtext DEFAULT NULL,
  `primary_company_id` int(10) unsigned DEFAULT NULL,
  `account_class` varchar(50) DEFAULT NULL,
  `account_rep_name` varchar(256) DEFAULT NULL,
  `account_rep_email` varchar(256) DEFAULT NULL,
  `account_rep_phone` varchar(256) DEFAULT NULL,
  `order_org_contact_name` varchar(256) DEFAULT NULL,
  `order_org_contact_email` varchar(256) DEFAULT NULL,
  `order_org_contact_phone` varchar(256) DEFAULT NULL,
  `order_tech_contact_name` varchar(256) DEFAULT NULL,
  `order_tech_contact_email` varchar(256) DEFAULT NULL,
  `order_tech_contact_phone` varchar(256) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `staff_id` int(10) unsigned NOT NULL,
  `is_certcentral` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_order_reissue_duplicate` (`order_id`,`reissue_id`,`duplicate_id`),
  KEY `idx_account_id` (`account_id`),
  KEY `idx_serial_number` (`serial_number`),
  KEY `idx_order_id` (`order_id`),
  KEY `idx_date_created` (`date_created`)
) ENGINE=InnoDB AUTO_INCREMENT=398 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `intermediates` (
  `ca_cert_id` int(11) NOT NULL,
  `external_id` varchar(16) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT current_timestamp(),
  `type` enum('ev','ov','direct') DEFAULT NULL,
  `accredited` int(1) DEFAULT 0,
  `active` int(1) DEFAULT 1,
  `always_available` int(1) DEFAULT 1,
  `fbca` tinyint(4) DEFAULT 1,
  PRIMARY KEY (`ca_cert_id`),
  UNIQUE KEY `external_id` (`external_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `invoice` (
  `id` int(4) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `acct_id` int(6) unsigned zerofill NOT NULL DEFAULT 000000,
  `status` int(1) NOT NULL DEFAULT 1,
  `void` int(1) NOT NULL DEFAULT 0,
  `po_id` int(6) NOT NULL,
  `po_number` varchar(32) NOT NULL,
  `date` datetime NOT NULL,
  `terms` int(2) NOT NULL DEFAULT 10,
  `terms_eom` tinyint(4) DEFAULT 0,
  `date_due` datetime NOT NULL,
  `customer_contact` varchar(128) NOT NULL,
  `customer_contact_email` varchar(255) DEFAULT NULL,
  `technical_contact` varchar(128) NOT NULL,
  `invoice_name` varchar(128) NOT NULL,
  `invoice_address_1` varchar(64) NOT NULL,
  `invoice_address_2` varchar(64) DEFAULT NULL,
  `invoice_city` varchar(64) NOT NULL,
  `invoice_state` varchar(64) NOT NULL,
  `invoice_country` varchar(2) NOT NULL,
  `invoice_zip` varchar(10) DEFAULT NULL,
  `invoice_telephone` varchar(32) NOT NULL DEFAULT '',
  `invoice_telephone_ext` varchar(16) NOT NULL DEFAULT '',
  `invoice_amount` decimal(10,2) DEFAULT 0.00,
  `amount_owed` decimal(10,2) DEFAULT NULL,
  `has_history` int(1) DEFAULT 0,
  `notice_sent` tinyint(3) unsigned DEFAULT 0,
  `void_date` datetime DEFAULT NULL,
  `void_staff_id` int(10) unsigned DEFAULT NULL,
  `void_reason` text DEFAULT NULL,
  `notes` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `po_id` (`po_id`),
  KEY `acct_id` (`acct_id`)
) ENGINE=InnoDB AUTO_INCREMENT=192344 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `invoice_audit` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `action_id` int(10) unsigned DEFAULT NULL,
  `field_name` varchar(50) DEFAULT NULL,
  `old_value` varchar(255) DEFAULT NULL,
  `new_value` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3449278 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `invoice_audit_action` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `invoice_id` int(10) unsigned DEFAULT NULL,
  `staff_id` smallint(5) unsigned NOT NULL DEFAULT 0,
  `date_dt` datetime DEFAULT NULL,
  `action_type` varchar(255) DEFAULT NULL,
  `affected_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=568046 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `invoice_deposits` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `deposit_date` datetime DEFAULT NULL,
  `staff_id` int(10) unsigned NOT NULL DEFAULT 0,
  `payment_medium` varchar(12) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36180 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `invoice_history` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `invoice_id` int(8) NOT NULL,
  `note_date` datetime NOT NULL,
  `staff_id` int(10) unsigned NOT NULL DEFAULT 0,
  `payment_medium` varchar(45) DEFAULT NULL,
  `void` int(1) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `memo` text DEFAULT NULL,
  `amount_paid` decimal(10,2) DEFAULT NULL,
  `new_balance` decimal(10,2) DEFAULT NULL,
  `deposit_id` int(1) DEFAULT 0,
  `deposit_date` date DEFAULT NULL,
  `wire_fees_graced` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `invoice_id_idx` (`invoice_id`)
) ENGINE=InnoDB AUTO_INCREMENT=139579 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `invoice_nightly_report` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `count_over_100` int(5) NOT NULL DEFAULT 0,
  `value_over_100` decimal(10,2) NOT NULL DEFAULT 0.00,
  `percent_count_over_100` decimal(3,1) NOT NULL DEFAULT 0.0,
  `value_percent_over_100` decimal(3,1) NOT NULL DEFAULT 0.0,
  `count_over_50` int(5) NOT NULL DEFAULT 0,
  `value_over_50` decimal(10,2) NOT NULL DEFAULT 0.00,
  `percent_count_over_50` decimal(3,1) NOT NULL DEFAULT 0.0,
  `value_percent_over_50` decimal(3,1) NOT NULL DEFAULT 0.0,
  `count_over_20` int(5) NOT NULL DEFAULT 0,
  `value_over_20` decimal(10,2) NOT NULL DEFAULT 0.00,
  `percent_count_over_20` decimal(3,1) NOT NULL DEFAULT 0.0,
  `value_percent_over_20` decimal(3,1) NOT NULL DEFAULT 0.0,
  `total_open_invoices` int(5) NOT NULL DEFAULT 0,
  `total_open_value` decimal(10,2) NOT NULL DEFAULT 0.00,
  `funds_received` decimal(10,2) NOT NULL DEFAULT 0.00,
  `invoiced_today` decimal(10,2) NOT NULL DEFAULT 0.00,
  `received_today` decimal(10,2) NOT NULL DEFAULT 0.00,
  `currency` char(3) CHARACTER SET ascii NOT NULL DEFAULT 'USD',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10233 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `invoice_products` (
  `id` int(4) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `invoice_id` int(4) unsigned NOT NULL DEFAULT 0,
  `quantity` int(4) NOT NULL DEFAULT 0,
  `product` varchar(64) NOT NULL DEFAULT '',
  `years` tinyint(1) NOT NULL DEFAULT 0,
  `servers` int(4) NOT NULL DEFAULT 0,
  `license` enum('single','unlimited') NOT NULL DEFAULT 'single',
  `cred_amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `order_id` int(8) unsigned zerofill NOT NULL DEFAULT 00000000,
  `amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `order_ids` int(8) unsigned zerofill NOT NULL DEFAULT 00000000,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `invoice_statuses` (
  `id` tinyint(4) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  `short_name` varchar(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `ip_access` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime DEFAULT NULL,
  `acct_id` int(6) unsigned zerofill NOT NULL DEFAULT 000000,
  `container_id` int(11) DEFAULT NULL,
  `ent_unit_id` int(11) unsigned NOT NULL DEFAULT 0,
  `user_id` int(10) unsigned NOT NULL DEFAULT 0,
  `scope_container_id` int(11) DEFAULT NULL,
  `ip_address` varchar(15) NOT NULL DEFAULT '',
  `ip_address_end` varchar(15) NOT NULL DEFAULT '',
  `description` varchar(255) DEFAULT '',
  `guest_request_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_guest_request_id` (`guest_request_id`),
  KEY `acct_id` (`acct_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11167 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `key_recovery_admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_account` (`user_id`,`account_id`),
  KEY `account_id` (`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `legal_policies_hooks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL DEFAULT '',
  `link_text` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `legal_policies_links` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `link` text NOT NULL,
  `percentage` tinyint(3) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `logo_docs` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `hash` varchar(75) DEFAULT NULL,
  `doc_id` int(11) DEFAULT NULL,
  `company_id` int(11) DEFAULT NULL,
  `trademark_country_code` varchar(25) DEFAULT NULL,
  `trademark_office_url` varchar(25) DEFAULT NULL,
  `trademark_registration_number` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=320 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `log_account_settings_change` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_time` datetime NOT NULL DEFAULT current_timestamp() COMMENT 'The date and time of the account settings change',
  `ip_address` varchar(15) NOT NULL COMMENT 'The IP address that the user was using when they made the change',
  `staff_id` int(10) unsigned DEFAULT NULL COMMENT 'The staff id of the adminarea staff user who made the account settings change',
  `user_id` int(10) unsigned DEFAULT NULL COMMENT 'The user id of the customer who made the account settings change',
  `username` varchar(255) NOT NULL COMMENT 'The username of the adminarea user who made the account setting change',
  `account_id` int(10) unsigned NOT NULL COMMENT 'The id of the account that was affected',
  `setting` varchar(50) NOT NULL COMMENT 'A text tag that identifies the setting that was changed',
  `fieldname` varchar(50) NOT NULL COMMENT 'The database fieldname that was changed table.field',
  `old_value` varchar(255) NOT NULL COMMENT 'The previous value of the setting',
  `new_value` varchar(255) NOT NULL COMMENT 'The new value of the setting',
  `description` tinytext NOT NULL COMMENT 'A human readable description of the change',
  `note` tinytext DEFAULT NULL COMMENT 'An optional note explaining the change if the UI prompts for it',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `staff_id` (`staff_id`) USING BTREE,
  KEY `account_id` (`account_id`) USING BTREE,
  KEY `setting` (`setting`) USING BTREE,
  KEY `date_time` (`date_time`) USING BTREE,
  KEY `user_id` (`user_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7248 DEFAULT CHARSET=utf8 COMMENT='This table is used to track changes to account settings made through adminarea by DigiCert staff members or by customers through the CertCentral API or UI.';

CREATE TABLE IF NOT EXISTS `log_admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `staff_id` int(11) NOT NULL DEFAULT 0,
  `username` varchar(128) NOT NULL DEFAULT '',
  `date_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `ip_address` varchar(15) NOT NULL DEFAULT '',
  `description` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `log_admin_ip_address` (`ip_address`(6)),
  KEY `log_admin_description` (`description`(10)),
  KEY `staff_id` (`staff_id`)
) ENGINE=InnoDB AUTO_INCREMENT=56830412 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `log_email_clicks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uxtime` int(10) unsigned NOT NULL,
  `email_id` int(10) unsigned NOT NULL,
  `action` varchar(16) DEFAULT NULL,
  `email_description` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `email_id` (`email_id`),
  KEY `uxtime` (`uxtime`)
) ENGINE=InnoDB AUTO_INCREMENT=352236 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `log_email_opens` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uxtime` int(10) unsigned NOT NULL,
  `email_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `email_id` (`email_id`),
  KEY `uxtime` (`uxtime`)
) ENGINE=InnoDB AUTO_INCREMENT=3034760 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `log_email_templates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `language` varchar(2) NOT NULL DEFAULT '',
  `template` varchar(48) NOT NULL DEFAULT '',
  `tracking_hash` varchar(8) NOT NULL DEFAULT '',
  `acct_id` int(10) unsigned NOT NULL DEFAULT 0,
  `order_id` int(10) unsigned NOT NULL DEFAULT 0,
  `to` varchar(128) NOT NULL DEFAULT '',
  `data` mediumtext DEFAULT NULL,
  `extras` mediumtext DEFAULT NULL,
  `staff_id` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `template` (`template`(8)),
  KEY `date_time` (`date_time`)
) ENGINE=InnoDB AUTO_INCREMENT=125767171 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `log_forgot` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ip_address` varchar(15) NOT NULL DEFAULT '',
  `ip_country` char(2) DEFAULT NULL,
  `date_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `user_id` int(11) NOT NULL DEFAULT 0,
  `username` varchar(128) NOT NULL DEFAULT '',
  `result` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ip_address` (`ip_address`),
  KEY `date_time` (`date_time`)
) ENGINE=InnoDB AUTO_INCREMENT=122409 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `log_manual` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `staff_id` smallint(5) unsigned NOT NULL DEFAULT 0,
  `time_performed` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `log_action` int(4) unsigned zerofill NOT NULL DEFAULT 0000,
  `notes` text NOT NULL,
  `ip` varchar(15) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1294 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `manual_dcv` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `domain_public_id` varchar(255) NOT NULL,
  `dcv_type` varchar(255) DEFAULT NULL,
  `contact_info` text DEFAULT NULL,
  `screenshot_doc_id` varchar(255) DEFAULT NULL,
  `auth_doc_id` varchar(255) DEFAULT NULL,
  `staff_id_first_auth` int(11) DEFAULT NULL,
  `staff_id_second_auth` int(11) DEFAULT NULL,
  `first_auth_date` datetime NOT NULL,
  `second_auth_date` datetime DEFAULT NULL,
  `reject_date` datetime DEFAULT NULL,
  `random_value_doc_id` varchar(255) DEFAULT NULL,
  `random_value` varchar(100) DEFAULT NULL,
  `validation_url` varchar(3000) DEFAULT NULL,
  `audited_date` datetime DEFAULT NULL,
  `audited_by` int(10) unsigned DEFAULT NULL,
  `is_ip_address` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `ix_domain_public_id` (`domain_public_id`(8)),
  KEY `idx_dcv_type` (`dcv_type`),
  KEY `idx_first_auth` (`staff_id_first_auth`),
  KEY `idx_second_auth` (`staff_id_second_auth`),
  KEY `idx_is_ip` (`is_ip_address`)
) ENGINE=InnoDB AUTO_INCREMENT=136299 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `metadata` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `account_id` int(10) unsigned NOT NULL,
  `label` varchar(100) NOT NULL,
  `is_required` tinyint(1) NOT NULL DEFAULT 0,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `data_type` varchar(20) DEFAULT NULL,
  `description` varchar(512) DEFAULT NULL,
  `drop_down_options` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_account_id_label` (`account_id`,`label`)
) ENGINE=InnoDB AUTO_INCREMENT=7194 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `netsuite_invoice` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` int(10) unsigned NOT NULL,
  `container_id` int(10) unsigned NOT NULL,
  `date_created` datetime NOT NULL,
  `ns_so_internal_id` int(10) unsigned DEFAULT 0,
  `ns_inv_internal_id` int(10) unsigned DEFAULT 0,
  `ns_invoice_number` varchar(20) NOT NULL DEFAULT '',
  `ns_created_date` datetime DEFAULT NULL,
  `cc_invoice_id` int(10) unsigned NOT NULL COMMENT 'invoice.id',
  `item_subtotal` decimal(17,2) NOT NULL DEFAULT 0.00,
  `tax_subtotal` decimal(17,2) NOT NULL DEFAULT 0.00,
  `invoice_total` decimal(17,2) NOT NULL DEFAULT 0.00,
  `amount_remaining` decimal(17,2) NOT NULL DEFAULT 0.00,
  `invoice_email` varchar(192) NOT NULL DEFAULT '',
  `invoice_creation_type` enum('auto_invoice','invoice_for_po','wire_transfer_invoice') DEFAULT NULL,
  `invoice_memo` varchar(255) NOT NULL DEFAULT '',
  `currency` varchar(3) NOT NULL DEFAULT 'USD',
  `terms` enum('NET 30 EOM','NET 30','NET 45 EOM','NET 45','NET 60 EOM','NET 60','NET 90 EOM','NET 90') NOT NULL DEFAULT 'NET 30',
  `payment_method` enum('other','ns-invoice-payment','wire-transfer') NOT NULL DEFAULT 'other',
  `payment_status` enum('UNPAID','PAID') NOT NULL DEFAULT 'UNPAID',
  `cancel_date` datetime NOT NULL DEFAULT '1900-01-01 00:00:00',
  `payment_recorded_date` datetime NOT NULL DEFAULT '1900-01-01 00:00:00',
  `refund_required` tinyint(4) NOT NULL DEFAULT 0,
  `refund_completed` tinyint(4) NOT NULL DEFAULT 0,
  `netsuite_invoice_pdf_url` varchar(255) NOT NULL DEFAULT '',
  `voucher_order_id` int(10) unsigned DEFAULT 0,
  `ns_inv_due_date` datetime DEFAULT NULL,
  `ns_tran_date` datetime DEFAULT NULL,
  `receipt_id` int(10) unsigned NOT NULL,
  `billing_attention` varchar(255) NOT NULL DEFAULT '',
  `billing_org_name` varchar(255) NOT NULL DEFAULT '',
  `billing_addr1` varchar(255) NOT NULL DEFAULT '',
  `billing_addr2` varchar(255) NOT NULL DEFAULT '',
  `billing_city` varchar(128) NOT NULL DEFAULT '',
  `billing_state` varchar(64) NOT NULL DEFAULT '',
  `billing_zip` varchar(32) NOT NULL DEFAULT '',
  `billing_telephone` varchar(32) NOT NULL DEFAULT '',
  `billing_country` varchar(2) NOT NULL DEFAULT '',
  `customer_po_request_id` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `date_created` (`date_created`),
  KEY `account_id` (`account_id`),
  KEY `payment_status` (`payment_status`),
  KEY `ns_inv_internal_id` (`ns_inv_internal_id`),
  KEY `cc_invoice_id` (`cc_invoice_id`),
  KEY `idx_voucher_order_id` (`voucher_order_id`),
  KEY `idx_customer_po_request_id` (`customer_po_request_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10316 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `netsuite_invoice_item` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `netsuite_invoice_id` int(10) unsigned NOT NULL,
  `item_amount` decimal(17,2) NOT NULL DEFAULT 0.00,
  `product_id` int(11) NOT NULL DEFAULT 0,
  `sales_stat_id` int(11) NOT NULL DEFAULT 0,
  `order_id` int(11) NOT NULL DEFAULT 0,
  `reissue_id` int(10) unsigned DEFAULT 0 COMMENT 'customer_order_reissue_history.id',
  `order_transaction_id` int(10) unsigned DEFAULT 0,
  `validity_years` int(10) unsigned DEFAULT NULL,
  `validity_days` smallint(5) unsigned DEFAULT 0,
  `voucher_code_id` int(10) unsigned DEFAULT 0,
  `no_of_fqdns` tinyint(3) unsigned DEFAULT 0,
  `no_of_wildcards` tinyint(3) unsigned DEFAULT 0,
  `use_san_package` tinyint(1) DEFAULT NULL,
  `group_id` int(10) unsigned DEFAULT 0,
  `ns_external_product_id` varchar(32) DEFAULT NULL,
  `item_tax_amount` decimal(17,2) NOT NULL DEFAULT 0.00,
  `effective_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  `quantity` smallint(5) unsigned DEFAULT 0,
  `issuance_recorded` tinyint(3) unsigned DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `netsuite_invoice_id` (`netsuite_invoice_id`),
  KEY `sales_stat_id` (`sales_stat_id`),
  KEY `order_id` (`order_id`),
  KEY `reissue_id` (`reissue_id`),
  KEY `order_transaction_id` (`order_transaction_id`),
  KEY `idx_voucher_code_id` (`voucher_code_id`),
  KEY `idx_ns_external_product_id` (`ns_external_product_id`),
  KEY `idx_issuance_recorded` (`issuance_recorded`)
) ENGINE=InnoDB AUTO_INCREMENT=10558 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `netsuite_tax_transaction` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL DEFAULT current_timestamp(),
  `account_id` int(10) unsigned NOT NULL,
  `container_id` int(10) unsigned DEFAULT NULL,
  `tax_amount` decimal(18,2) NOT NULL,
  `start_date` datetime NOT NULL,
  `acct_adjust_id` int(10) unsigned NOT NULL,
  `order_id` int(8) unsigned NOT NULL DEFAULT 0,
  `voucher_order_id` int(10) unsigned NOT NULL DEFAULT 0,
  `currency` varchar(3) NOT NULL DEFAULT 'USD',
  PRIMARY KEY (`id`),
  KEY `ix_account_id` (`account_id`),
  KEY `ix_container_id` (`container_id`),
  KEY `ix_order_id` (`order_id`),
  KEY `ix_acct_adjust_id` (`acct_adjust_id`),
  KEY `ix_date_created` (`date_created`),
  KEY `ix_voucher_order_id` (`voucher_order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16370 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `netsuite_transaction` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `order_date` datetime NOT NULL COMMENT 'The date the original order was placed, whether or not it was issued',
  `start_date` datetime NOT NULL COMMENT 'The issue date (col_date) of the first certificate on the order, or in case of vouchers the transaction date',
  `end_date` date DEFAULT '0000-00-00' COMMENT 'For certs, should contain cert expiry date. For vouchers, col_date +1year. For multi-year plans, extended_order_info.valid_till',
  `account_id` int(10) unsigned NOT NULL COMMENT 'The account_id, except when a subaccount_order_transaction exists... then should contain billed_account_id',
  `container_id` int(10) unsigned DEFAULT NULL COMMENT 'The container_id, except when a subaccount_order_transaction exists... then it should contain the container_id for the billed_account_id. For non-container accounts (Direct Health) must be NULL.',
  `order_id` int(8) unsigned NOT NULL DEFAULT 0 COMMENT 'Must be populated for all orders and client_certs',
  `voucher_order_id` int(10) unsigned NOT NULL DEFAULT 0,
  `gross_amount` decimal(18,2) NOT NULL COMMENT 'Positive or negative, but should never be 0. Do not insert a netsuite_transaction record if the amount is $0',
  `tax_amount` decimal(18,2) NOT NULL COMMENT 'Calculated tax amount',
  `total_amount` decimal(18,2) NOT NULL COMMENT 'Sum of gross_amount + tax_amount',
  `currency` varchar(3) NOT NULL DEFAULT 'USD' COMMENT 'The currency for gross_amount, tax_amount, and total_amount',
  `product_id` int(11) DEFAULT NULL COMMENT 'The product_id of the transaction.',
  `type` enum('order','rejection','refund','invoice-refund') NOT NULL DEFAULT 'order' COMMENT 'Transaction type',
  `pay_type` enum('acct-credit','credit-card','wire-deposit','check-deposit','po-deposit') DEFAULT NULL COMMENT 'Payment Method used for this transaction',
  `parent_transaction_id` int(10) unsigned DEFAULT NULL COMMENT 'This field is not sent to NetSuite, but helps track the original netsuite_transaction id for refunds/revokes',
  `receipt_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'This field is not sent to NetSuite, but is stored to facilitate tracking and debugging any issues that could arise',
  PRIMARY KEY (`id`),
  KEY `ix_account_id` (`account_id`),
  KEY `ix_container_id` (`container_id`),
  KEY `ix_order_id` (`order_id`),
  KEY `ix_parent_transaction_id` (`parent_transaction_id`),
  KEY `ix_receipt_id` (`receipt_id`),
  KEY `ix_date_created` (`date_created`),
  KEY `ix_voucher_order_id` (`voucher_order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=507120 DEFAULT CHARSET=utf8 COMMENT='This table is used to record financial transactions that need to be integrated to and recorded in NetSuite.';

CREATE TABLE IF NOT EXISTS `notes_deleted` (
  `id` int(10) unsigned NOT NULL,
  `acct_id` int(10) unsigned DEFAULT NULL,
  `order_id` int(10) unsigned DEFAULT NULL,
  `company_id` int(10) unsigned DEFAULT NULL,
  `domain_id` int(10) unsigned DEFAULT NULL,
  `reissue_id` int(10) unsigned DEFAULT NULL,
  `staff_id` int(10) unsigned DEFAULT NULL,
  `date_time` datetime NOT NULL,
  `sticky` int(11) DEFAULT NULL,
  `note` text NOT NULL,
  `del_date_time` datetime NOT NULL,
  `del_staff_id` int(10) unsigned DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `notes_shared` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `acct_id` int(10) unsigned NOT NULL DEFAULT 0,
  `order_id` int(10) unsigned NOT NULL DEFAULT 0,
  `company_id` int(10) unsigned NOT NULL DEFAULT 0,
  `domain_id` int(10) unsigned NOT NULL DEFAULT 0,
  `reissue_id` int(10) unsigned NOT NULL DEFAULT 0,
  `staff_id` int(10) unsigned NOT NULL DEFAULT 0,
  `date_time` datetime NOT NULL,
  `sticky` int(11) NOT NULL DEFAULT 0,
  `is_support` tinyint(4) NOT NULL DEFAULT 0,
  `is_suspension_reason` tinyint(1) NOT NULL DEFAULT 0,
  `note` text NOT NULL,
  `container_id` int(10) unsigned NOT NULL DEFAULT 0,
  `notetype` varchar(45) NOT NULL DEFAULT 'order',
  `important` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `date_time` (`date_time`),
  KEY `fk_company_assertions_acct` (`acct_id`),
  KEY `fk_company_assertions_order` (`order_id`),
  KEY `fk_company_assertions_companies` (`company_id`),
  KEY `fk_company_assertions_domains` (`domain_id`),
  KEY `fk_company_assertions_reissues` (`reissue_id`),
  KEY `staff_id` (`staff_id`),
  KEY `container_id` (`container_id`)
) ENGINE=InnoDB AUTO_INCREMENT=28420045 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `notifications` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `staff_id` int(11) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `notification` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `npi` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `npi` varchar(10) NOT NULL,
  `verified_contact_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `company_id` int(11) DEFAULT NULL,
  `acct_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `acct_id` (`acct_id`,`npi`)
) ENGINE=InnoDB AUTO_INCREMENT=670 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `nrnotes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(8) unsigned zerofill DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `note` text DEFAULT NULL,
  `staff_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `date_index` (`date`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=463645 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `oem_accounts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `account_id` int(10) unsigned NOT NULL,
  `account_type` varchar(45) DEFAULT NULL,
  `oem_account_id` varchar(45) DEFAULT NULL,
  `master_account_id` int(10) DEFAULT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'inactive',
  `migrated_date` timestamp NULL DEFAULT NULL,
  `auto_import_certificates` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `migration_complete` tinyint(1) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_account_id` (`account_id`),
  KEY `idx_oem_master_account_id` (`oem_account_id`,`master_account_id`),
  KEY `idx_account_status` (`status`),
  KEY `idx_migration_complete` (`migration_complete`)
) ENGINE=InnoDB AUTO_INCREMENT=1244384 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `oem_order_migration_queue` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` int(10) unsigned NOT NULL,
  `date_created` datetime NOT NULL DEFAULT current_timestamp(),
  `start_time` datetime DEFAULT NULL,
  `completed_time` datetime DEFAULT NULL,
  `orders_migrated` int(10) unsigned NOT NULL DEFAULT 0,
  `exception_thrown` tinyint(4) NOT NULL DEFAULT 0,
  `total_pages` int(11) NOT NULL DEFAULT 0,
  `current_page` int(11) NOT NULL DEFAULT 0,
  `last_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `start_on_page` int(11) NOT NULL DEFAULT 0,
  `bookmark` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `ix_date_created` (`date_created`),
  KEY `ix_account` (`account_id`),
  KEY `ix_completed` (`completed_time`)
) ENGINE=InnoDB AUTO_INCREMENT=3101834 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `oem_orgs_sent_to_validation` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `organization_id` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2954 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `orders` (
  `id` int(8) unsigned zerofill NOT NULL,
  `last_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `po_id` int(4) unsigned zerofill NOT NULL DEFAULT 0000,
  `reseller_id` int(6) unsigned zerofill NOT NULL DEFAULT 000000,
  `user_id` int(11) unsigned DEFAULT 0,
  `company_id` int(11) NOT NULL DEFAULT 0,
  `domain_id` int(11) NOT NULL DEFAULT 0,
  `common_name` varchar(255) NOT NULL DEFAULT '',
  `org_unit` varchar(255) NOT NULL,
  `org_contact_id` int(11) NOT NULL DEFAULT 0,
  `tech_contact_id` int(11) NOT NULL DEFAULT 0,
  `product_id` int(11) DEFAULT NULL,
  `trial` tinyint(4) NOT NULL DEFAULT 0,
  `origin` enum('retail','enterprise') DEFAULT 'retail',
  `value` decimal(10,2) DEFAULT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 1,
  `reason` tinyint(4) NOT NULL DEFAULT 1,
  `date_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `lifetime` tinyint(4) NOT NULL DEFAULT 0,
  `servers` int(4) NOT NULL DEFAULT 0,
  `addons` varchar(255) NOT NULL,
  `csr` text NOT NULL,
  `serversw` smallint(5) NOT NULL DEFAULT 0,
  `pay_type` varchar(4) NOT NULL DEFAULT '1',
  `do_not_charge_cc` tinyint(4) DEFAULT 0,
  `ca_order_id` int(11) NOT NULL DEFAULT 0,
  `ca_apply_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `ca_status` smallint(6) NOT NULL DEFAULT 0,
  `ca_collect_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `ca_error_msg` varchar(255) NOT NULL DEFAULT '',
  `valid_from` date NOT NULL DEFAULT '0000-00-00',
  `valid_till` date NOT NULL DEFAULT '0000-00-00',
  `short_issue` date NOT NULL DEFAULT '0000-00-00',
  `extra_days` int(11) NOT NULL,
  `serial_number` varchar(128) NOT NULL,
  `is_renewed` tinyint(1) NOT NULL DEFAULT 0,
  `renewed_order_id` int(8) unsigned zerofill NOT NULL DEFAULT 00000000,
  `is_first_order` tinyint(1) NOT NULL DEFAULT 0,
  `upgrade` tinyint(4) NOT NULL DEFAULT 0,
  `flag` tinyint(1) NOT NULL DEFAULT 0,
  `send_minus_104` tinyint(1) DEFAULT 1,
  `send_minus_90` tinyint(1) NOT NULL DEFAULT 0,
  `send_minus_60` tinyint(1) NOT NULL DEFAULT 1,
  `send_minus_30` tinyint(1) NOT NULL DEFAULT 1,
  `send_minus_7` tinyint(1) NOT NULL DEFAULT 1,
  `send_minus_3` tinyint(1) DEFAULT 1,
  `send_plus_7` tinyint(1) NOT NULL DEFAULT 1,
  `make_renewal_calls` tinyint(1) NOT NULL DEFAULT 1,
  `minus_104_sent` tinyint(1) DEFAULT 0,
  `minus_90_sent` tinyint(1) NOT NULL DEFAULT 0,
  `minus_60_sent` tinyint(1) NOT NULL DEFAULT 0,
  `minus_30_sent` tinyint(1) NOT NULL DEFAULT 0,
  `minus_7_sent` tinyint(1) NOT NULL DEFAULT 0,
  `minus_3_sent` tinyint(1) DEFAULT 0,
  `plus_7_sent` tinyint(1) NOT NULL DEFAULT 0,
  `send_renewal_notices` tinyint(1) NOT NULL DEFAULT 1,
  `in_progress` tinyint(1) NOT NULL DEFAULT 0,
  `comodo_submitted` tinyint(1) NOT NULL DEFAULT 0,
  `followup_status` tinyint(4) NOT NULL DEFAULT 1,
  `followup_date` date NOT NULL,
  `snooze_until` datetime DEFAULT '2000-01-01 00:00:00',
  `ip_address` varchar(15) NOT NULL DEFAULT '',
  `approved_by` int(11) NOT NULL DEFAULT 0,
  `approved_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `take_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `issuing_ca` varchar(64) NOT NULL DEFAULT 'digicertca',
  `promo_code` varchar(17) NOT NULL,
  `show_addr_on_seal` tinyint(1) NOT NULL DEFAULT 0,
  `post_order_done` tinyint(1) NOT NULL DEFAULT 0,
  `stat_row_id` int(11) NOT NULL DEFAULT 0,
  `names_stat_row_id` int(11) NOT NULL DEFAULT 0,
  `test_order` tinyint(1) NOT NULL DEFAULT 0,
  `hide` tinyint(1) NOT NULL DEFAULT 0,
  `vip` tinyint(1) NOT NULL DEFAULT 0,
  `ca_cert_id` smallint(4) NOT NULL DEFAULT 33,
  `plus_feature` tinyint(4) DEFAULT 0,
  `whois_status` tinyint(4) NOT NULL DEFAULT 0,
  `mark_audit` tinyint(1) NOT NULL DEFAULT 0,
  `internal_audit` int(10) unsigned DEFAULT 0,
  `internal_audit_date` datetime DEFAULT NULL,
  `receipt_id` int(10) NOT NULL DEFAULT 0,
  `root_path` enum('digicert','entrust','cybertrust','comodo') DEFAULT 'digicert',
  `root_path_orig` enum('digicert','entrust','cybertrust','comodo') DEFAULT 'digicert',
  `order_options` set('hide_street_address','easy_ev','renew_90_days','auto_renew','show_street_address') DEFAULT NULL,
  `timezone_id` smallint(6) NOT NULL DEFAULT 0,
  `risk_score` smallint(5) unsigned DEFAULT NULL,
  `agreement_id` int(10) unsigned NOT NULL DEFAULT 0,
  `cs_provisioning_method` enum('none','ship_token','client_app','email','api') NOT NULL DEFAULT 'none',
  `checklist_modifiers` varchar(30) NOT NULL,
  `signature_hash` enum('sha1','sha256','sha384','sha512') NOT NULL DEFAULT 'sha1',
  `reached` tinyint(4) NOT NULL DEFAULT 0,
  `gtld_status` tinyint(3) unsigned DEFAULT NULL,
  `certificate_tracker_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `po_id` (`po_id`),
  KEY `reselling_partner_id` (`reseller_id`),
  KEY `domain_id` (`domain_id`),
  KEY `org_contact_id` (`org_contact_id`),
  KEY `product_id` (`product_id`),
  KEY `status` (`status`),
  KEY `reason` (`reason`),
  KEY `date_time` (`date_time`),
  KEY `serversw` (`serversw`),
  KEY `renewed_order_id` (`renewed_order_id`),
  KEY `flag` (`flag`),
  KEY `stat_row_id` (`stat_row_id`),
  KEY `followup_date` (`followup_date`),
  KEY `orders_send_renewal_notices` (`send_renewal_notices`),
  KEY `orders_valid_till` (`valid_till`),
  KEY `order_serial` (`serial_number`(10)),
  KEY `orders_user_id` (`user_id`),
  KEY `orders_snooze` (`snooze_until`),
  KEY `orders_company_id` (`company_id`),
  KEY `in_progress` (`in_progress`),
  KEY `receipt_id` (`receipt_id`),
  KEY `last_updated` (`last_updated`),
  KEY `orders_valid_from` (`valid_from`),
  KEY `certificate_tracker_id` (`certificate_tracker_id`),
  KEY `orders_approved_by` (`approved_by`),
  KEY `common_name` (`common_name`(14))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `orders_declined` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `acct_id` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `common_name` varchar(200) DEFAULT NULL,
  `visible` tinyint(4) NOT NULL DEFAULT 1,
  `suspicious` enum('stolen_or_lost','bank_has_questions','general_decline','') DEFAULT '',
  `ip_address` varchar(15) DEFAULT '',
  `ip_address_int` int(10) unsigned DEFAULT NULL,
  `cc_error_msg` varchar(255) DEFAULT '',
  `cc_info` varchar(16) NOT NULL DEFAULT '',
  `note` text DEFAULT NULL,
  `note_timestamp` datetime DEFAULT NULL,
  `note_staff_id` int(11) DEFAULT NULL,
  `session_info` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ip_address` (`ip_address`),
  KEY `visible` (`visible`),
  KEY `acct_id` (`acct_id`),
  KEY `cc_error_msg` (`cc_error_msg`(32)),
  KEY `common_name` (`common_name`(12))
) ENGINE=InnoDB AUTO_INCREMENT=1329756 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_action_queue` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `container_id` int(10) unsigned NOT NULL,
  `date_created` datetime NOT NULL,
  `order_tracker_id` int(10) unsigned NOT NULL,
  `action_type` tinyint(3) unsigned NOT NULL,
  `action_status` tinyint(3) unsigned NOT NULL,
  `requester_user_id` int(10) unsigned NOT NULL,
  `reviewer_user_id` int(10) unsigned NOT NULL DEFAULT 0,
  `processor_user_id` int(10) unsigned DEFAULT NULL,
  `date_processed` datetime DEFAULT NULL,
  `certificate_id` int(10) unsigned DEFAULT NULL,
  `comments` varchar(255) DEFAULT NULL,
  `processor_comment` varchar(255) DEFAULT NULL,
  `guest_requester_first_name` varchar(255) DEFAULT NULL,
  `guest_requester_last_name` varchar(255) DEFAULT NULL,
  `guest_requester_email` varchar(255) DEFAULT NULL,
  `date_reviewed` datetime DEFAULT NULL,
  `order_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_container_id_action_status` (`container_id`,`action_status`),
  KEY `ix_order_tracker_id` (`order_tracker_id`),
  KEY `action_status` (`action_status`),
  KEY `ix_requester_user_id` (`requester_user_id`),
  KEY `ix_order_id` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11491497 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_api_key_map` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(10) unsigned NOT NULL,
  `api_permission_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_order_id` (`order_id`),
  KEY `idx_api_permission_id` (`api_permission_id`)
) ENGINE=InnoDB AUTO_INCREMENT=112426760 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_approvals` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(8) unsigned zerofill NOT NULL,
  `reissue_id` int(11) NOT NULL DEFAULT 0,
  `verified_contact_id` int(10) unsigned NOT NULL,
  `date_time` datetime NOT NULL,
  `ip_address` varchar(15) NOT NULL,
  `order_details` text NOT NULL,
  `origin` enum('email','phone') NOT NULL DEFAULT 'email',
  `staff_id` int(11) NOT NULL DEFAULT 0,
  `staff_note` text NOT NULL,
  `status` enum('active','inactive') DEFAULT 'active',
  `verified_contact_snapshot_id` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `verified_contact_id` (`verified_contact_id`),
  KEY `status` (`status`),
  KEY `verified_contact_snapshot_id` (`verified_contact_snapshot_id`),
  KEY `reissue_id` (`reissue_id`)
) ENGINE=InnoDB AUTO_INCREMENT=763143 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_approvals_oem` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cert_id` varchar(32) NOT NULL,
  `verified_contact_id` int(10) unsigned NOT NULL,
  `date_time` datetime NOT NULL,
  `ip_address` varchar(15) NOT NULL,
  `origin` enum('email','phone') NOT NULL DEFAULT 'email',
  `order_approvals_oem_invite_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cert_id_idx` (`cert_id`)
) ENGINE=InnoDB AUTO_INCREMENT=18222 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_approvals_oem_delegation` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `organization_id` int(10) unsigned NOT NULL,
  `verified_contact_id` int(10) unsigned NOT NULL,
  `created_by_staff_id` int(10) unsigned NOT NULL,
  `date_created` datetime NOT NULL,
  `note` text DEFAULT NULL,
  `ip_address` varchar(255) DEFAULT NULL,
  `approver_name` varchar(130) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_verified_contact_id` (`verified_contact_id`),
  KEY `idx_organization_id` (`organization_id`)
) ENGINE=InnoDB AUTO_INCREMENT=87953 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_approvals_oem_delegation_invites` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `organization_id` int(10) unsigned NOT NULL,
  `verified_contact_id` int(10) unsigned NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `sent_by_staff_id` int(10) unsigned NOT NULL,
  `date_sent` datetime NOT NULL,
  `order_approvals_oem_delegation_id` int(11) DEFAULT NULL,
  `token` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_verified_contact_id` (`verified_contact_id`)
) ENGINE=InnoDB AUTO_INCREMENT=49537 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_approvals_oem_invites` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cert_id` varchar(32) NOT NULL,
  `verified_contact_id` int(10) unsigned NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `sent_by_staff_id` int(10) unsigned DEFAULT NULL,
  `date_sent` datetime NOT NULL,
  `token` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cert_id_idx` (`cert_id`)
) ENGINE=InnoDB AUTO_INCREMENT=46084 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_benefits` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(10) unsigned NOT NULL,
  `actual_price` decimal(10,2) DEFAULT 0.00,
  `discount_percent` decimal(5,2) DEFAULT 0.00,
  `validity_benefit_days` smallint(5) unsigned DEFAULT NULL,
  `benefits` text DEFAULT NULL,
  `benefits_data` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_order_id` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1128 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_cert_transparency` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(10) unsigned DEFAULT NULL,
  `date_disabled` datetime DEFAULT NULL,
  `date_enabled` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=920036 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_checkmarks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(10) unsigned NOT NULL,
  `reissue_id` int(10) unsigned DEFAULT NULL,
  `checkmark_id` int(10) unsigned NOT NULL,
  `date_created` datetime NOT NULL,
  `checklist_step_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_checkmarks_order_id_idx` (`order_id`),
  KEY `order_checkmarks_checkmark_id_idx` (`checkmark_id`)
) ENGINE=InnoDB AUTO_INCREMENT=538858219 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_common_names_snapshots` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `order_id` int(10) unsigned NOT NULL,
  `reissue_id` int(10) unsigned DEFAULT NULL,
  `common_name_id` int(10) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `is_common_name` tinyint(1) NOT NULL DEFAULT 0,
  `active` tinyint(1) DEFAULT NULL,
  `domain_id` int(10) unsigned DEFAULT NULL,
  `approve_id` int(10) unsigned DEFAULT NULL,
  `status` enum('active','inactive','pending') DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_common_names_snapshots_order_id_idx` (`order_id`),
  KEY `domain_id` (`domain_id`),
  KEY `common_name_id` (`common_name_id`)
) ENGINE=InnoDB AUTO_INCREMENT=99331949 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_company_snapshots` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `order_id` int(10) unsigned NOT NULL,
  `reissue_id` int(10) unsigned DEFAULT NULL,
  `company_id` int(10) unsigned NOT NULL,
  `acct_id` int(6) unsigned DEFAULT NULL,
  `org_contact_id` int(11) DEFAULT NULL,
  `tech_contact_id` int(11) DEFAULT NULL,
  `bill_contact_id` int(11) DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `ev_status` tinyint(4) DEFAULT NULL,
  `org_name` varchar(255) DEFAULT NULL,
  `org_type` int(10) DEFAULT NULL,
  `org_assumed_name` varchar(255) DEFAULT NULL,
  `org_unit` varchar(64) DEFAULT NULL,
  `org_addr1` varchar(128) DEFAULT NULL,
  `org_addr2` varchar(128) DEFAULT NULL,
  `org_zip` varchar(40) DEFAULT NULL,
  `org_city` varchar(128) DEFAULT NULL,
  `org_state` varchar(128) DEFAULT NULL,
  `org_country` varchar(2) DEFAULT NULL,
  `org_email` varchar(128) DEFAULT NULL,
  `telephone` varchar(32) DEFAULT NULL,
  `org_reg_num` varchar(200) DEFAULT NULL,
  `jur_city` varchar(128) DEFAULT NULL,
  `jur_state` varchar(128) DEFAULT NULL,
  `jur_country` varchar(2) DEFAULT NULL,
  `incorp_agency` varchar(255) DEFAULT NULL,
  `master_agreement_sent` tinyint(1) DEFAULT NULL,
  `locked` tinyint(1) DEFAULT NULL,
  `validated_until` datetime DEFAULT NULL,
  `ov_validated_until` datetime DEFAULT NULL,
  `ev_validated_until` datetime DEFAULT NULL,
  `active` tinyint(4) DEFAULT 1,
  `public_phone` varchar(32) DEFAULT NULL,
  `public_email` varchar(128) DEFAULT NULL,
  `ascii_name` varchar(255) DEFAULT NULL,
  `address_validated_date` datetime DEFAULT NULL,
  `incorp_agency_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_company_snapshots_order_id_idx` (`order_id`),
  KEY `ix_company_id` (`company_id`),
  KEY `idx_account_id` (`acct_id`),
  KEY `incorp_agency_id` (`incorp_agency_id`)
) ENGINE=InnoDB AUTO_INCREMENT=34038823 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_duplicates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(8) unsigned zerofill NOT NULL DEFAULT 00000000,
  `sub_id` int(3) unsigned zerofill NOT NULL DEFAULT 000,
  `ca_order_id` varchar(18) NOT NULL,
  `date_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `staff_id` int(11) NOT NULL DEFAULT 0,
  `status` tinyint(4) NOT NULL DEFAULT 1,
  `collected` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `serial_number` varchar(128) NOT NULL,
  `csr` text NOT NULL,
  `serversw` smallint(5) NOT NULL DEFAULT 0,
  `sans` text NOT NULL,
  `common_name` varchar(255) NOT NULL,
  `org_unit` varchar(100) DEFAULT NULL,
  `ca_cert_id` smallint(6) NOT NULL DEFAULT 33,
  `revoked` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `hidden` tinyint(4) DEFAULT 0,
  `thumbprint` varchar(40) DEFAULT '',
  `customer_note` text DEFAULT NULL,
  `signature_hash` enum('sha1','sha256','sha384','sha512') NOT NULL DEFAULT 'sha1',
  `root_path` enum('digicert','entrust','cybertrust','comodo') NOT NULL DEFAULT 'entrust',
  `data_encipherment` tinyint(4) NOT NULL DEFAULT 0,
  `string_type` enum('PS','T61','UTF8','AUTO') NOT NULL DEFAULT 'AUTO',
  `in_progress` tinyint(1) NOT NULL DEFAULT 0,
  `certificate_tracker_id` int(10) unsigned DEFAULT NULL,
  `csr_key_type` varchar(3) NOT NULL DEFAULT '',
  `request_id` int(11) DEFAULT NULL,
  `type` set('other','encryption','signing') DEFAULT 'other',
  `user_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `addl_uc_order_id` (`order_id`),
  KEY `addl_uc_hidden` (`hidden`),
  KEY `collected_index` (`collected`),
  KEY `certificate_tracker_id` (`certificate_tracker_id`),
  KEY `request_id` (`request_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1406710 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_extras` (
  `order_id` int(8) unsigned zerofill NOT NULL,
  `asa_option` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `unit_id` int(10) unsigned NOT NULL DEFAULT 0,
  `allow_unit_access` tinyint(1) NOT NULL DEFAULT 0,
  `thumbprint` varchar(40) DEFAULT '',
  `ent_check1_staff_id` int(11) DEFAULT NULL,
  `ent_check2_staff_id` int(11) DEFAULT NULL,
  `additional_emails` text DEFAULT NULL,
  `wildcard_sans` text DEFAULT NULL,
  `dc_guid` varchar(64) NOT NULL DEFAULT '',
  `key_usage` varchar(96) NOT NULL DEFAULT '',
  `show_phone` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `show_email` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `show_address` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `cert_registration_number` varchar(128) NOT NULL,
  `is_out_of_contract` tinyint(1) NOT NULL DEFAULT 0,
  `direct_hipaa_type` enum('covered','associate','other') DEFAULT NULL,
  `wifi_option` enum('logo','friendlyname','both') DEFAULT NULL,
  `service_name` varchar(32) NOT NULL DEFAULT '',
  `ssl_profile_option` varchar(32) NOT NULL DEFAULT '',
  `subject_email` varchar(128) NOT NULL DEFAULT '',
  `custom_renewal_message` text DEFAULT NULL,
  `disable_renewal_notifications` tinyint(1) NOT NULL DEFAULT 0,
  `disable_issuance_email` tinyint(3) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`order_id`),
  KEY `ent_check1_staff_id` (`ent_check1_staff_id`),
  KEY `ent_check2_staff_id` (`ent_check2_staff_id`),
  KEY `unit_id` (`unit_id`),
  KEY `is_out_of_contract` (`is_out_of_contract`),
  KEY `idx_disable_renewal_notifications` (`disable_renewal_notifications`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_guest_access` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` int(10) unsigned NOT NULL,
  `order_id` int(10) unsigned NOT NULL,
  `fqdn` varchar(256) NOT NULL,
  `date_created` datetime NOT NULL,
  `email` varchar(256) NOT NULL,
  `hashkey` varchar(128) NOT NULL,
  `fqdn_linked_orders` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25272 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_high_risk_clues_map` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `high_risk_clues_id` int(11) DEFAULT NULL,
  `order_id` int(11) DEFAULT NULL,
  `reference_id` int(11) DEFAULT NULL,
  `reason_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `origin` enum('DigiCert','other') DEFAULT 'DigiCert',
  PRIMARY KEY (`id`),
  KEY `high_risk_clues_id` (`high_risk_clues_id`),
  KEY `order_id` (`order_id`,`reference_id`)
) ENGINE=InnoDB AUTO_INCREMENT=675 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_iceberg` (
  `order_id` int(8) unsigned zerofill NOT NULL DEFAULT 00000000,
  `json` text DEFAULT NULL,
  `incoming_email_sent` tinyint(4) NOT NULL DEFAULT 0,
  `issuance_email_sent` tinyint(4) NOT NULL DEFAULT 0,
  `insert_date` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_ids` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=125139768 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_installer_token` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `token` varchar(45) NOT NULL,
  `order_id` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `sub_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_token` (`token`),
  KEY `idx_order_id` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13382179 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_install_notes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(10) unsigned NOT NULL,
  `date_time` datetime DEFAULT NULL,
  `install_status` varchar(50) DEFAULT NULL,
  `install_data` text DEFAULT NULL,
  `staff_id` int(11) DEFAULT NULL,
  `staff_note` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7501390 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_install_status` (
  `order_id` int(10) unsigned NOT NULL,
  `install_status` varchar(40) DEFAULT 'unchecked',
  `followup_status` enum('pending','complete') NOT NULL DEFAULT 'pending',
  `date_last_checked` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `snooze_until` datetime DEFAULT NULL,
  `sent_email` tinyint(4) DEFAULT NULL,
  `extra_info` text DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  KEY `install_status` (`install_status`),
  KEY `followup_status` (`followup_status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_metadata` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `order_id` int(10) unsigned NOT NULL,
  `metadata_id` int(10) unsigned NOT NULL,
  `value` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_item_metadata_id` (`order_id`,`metadata_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3095254 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_origin_cookies` (
  `order_id` int(10) unsigned NOT NULL,
  `acct_id` int(10) unsigned DEFAULT NULL,
  `origin` varchar(255) DEFAULT NULL,
  `date_recorded` datetime DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  KEY `acct_id` (`acct_id`),
  KEY `date_recorded` (`date_recorded`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_pay_types` (
  `id` tinyint(4) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL DEFAULT '',
  `nb_abbr` varchar(8) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_price_computation` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(10) unsigned NOT NULL,
  `account_id` int(10) unsigned NOT NULL,
  `actual_price` decimal(10,2) DEFAULT 0.00,
  `computed_price` decimal(10,2) DEFAULT 0.00,
  `revenue` decimal(12,2) DEFAULT 0.00,
  PRIMARY KEY (`id`),
  KEY `ix_order_id` (`order_id`),
  KEY `ix_account_id` (`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9619012 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_price_recalculation` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` int(10) unsigned NOT NULL,
  `created` datetime NOT NULL DEFAULT current_timestamp(),
  `start_time` datetime DEFAULT NULL,
  `completed_time` datetime DEFAULT NULL,
  `orders_updated` int(10) unsigned NOT NULL DEFAULT 0,
  `status` enum('pending','running','completed','incomplete','stopped') NOT NULL DEFAULT 'pending',
  `last_updated_order` int(10) unsigned NOT NULL DEFAULT 0,
  `last_update_time` datetime DEFAULT current_timestamp(),
  `generate_report` tinyint(4) DEFAULT 0,
  `from_date` date DEFAULT curdate(),
  `to_date` date DEFAULT curdate(),
  PRIMARY KEY (`id`),
  KEY `idx_status` (`status`),
  KEY `idx_account_id` (`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=252 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_renewal_notices` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(10) unsigned NOT NULL,
  `minus_90_sent` tinyint(1) NOT NULL DEFAULT 0,
  `minus_60_sent` tinyint(1) NOT NULL DEFAULT 0,
  `minus_30_sent` tinyint(1) NOT NULL DEFAULT 0,
  `minus_7_sent` tinyint(1) NOT NULL DEFAULT 0,
  `minus_3_sent` tinyint(1) NOT NULL DEFAULT 0,
  `plus_7_sent` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_order_id` (`order_id`),
  KEY `ix_minus_90_sent` (`minus_90_sent`),
  KEY `ix_minus_60_sent` (`minus_60_sent`),
  KEY `ix_minus_30_sent` (`minus_30_sent`),
  KEY `ix_minus_7_sent` (`minus_7_sent`),
  KEY `ix_minus_3_sent` (`minus_3_sent`),
  KEY `ix_plus_7_sent` (`plus_7_sent`)
) ENGINE=InnoDB AUTO_INCREMENT=16998435 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_renewal_stats` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(10) unsigned DEFAULT NULL,
  `ctime` timestamp NOT NULL DEFAULT '2000-01-01 07:00:00',
  `mtime` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `renewal_disposition` enum('renewed_with_us','still_has_our_expired_cert','competitor_cert','doesnt_resolve','unable_to_connect','no_certificate_found','invalid_name','private_ip','self_signed_cert','untrusted_or_unknown_ca','') NOT NULL DEFAULT '',
  `product_id` int(11) DEFAULT NULL,
  `valid_till` date NOT NULL DEFAULT '0000-00-00',
  `new_order_id` int(8) unsigned zerofill NOT NULL,
  `new_acct_id` int(6) unsigned zerofill NOT NULL DEFAULT 000000,
  `new_valid_from` date NOT NULL DEFAULT '0000-00-00',
  `new_valid_till` date NOT NULL DEFAULT '0000-00-00',
  `new_issuer_name` varchar(64) NOT NULL DEFAULT '',
  `new_ca_group` varchar(64) NOT NULL DEFAULT '',
  `new_product_type` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `order_id` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17231001 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_request` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `order_tracker_id` int(10) unsigned NOT NULL,
  `order_action_queue_id` int(10) unsigned NOT NULL,
  `status` tinyint(3) unsigned NOT NULL,
  `reason` tinyint(3) unsigned NOT NULL,
  `product_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `organization_id` int(10) unsigned NOT NULL,
  `agreement_id` int(10) unsigned NOT NULL,
  `cert_profile_id` int(10) unsigned DEFAULT NULL,
  `organization_unit` varchar(255) DEFAULT NULL,
  `lifetime` int(10) unsigned NOT NULL,
  `csr` text DEFAULT NULL,
  `common_name` varchar(255) NOT NULL,
  `dns_names` text NOT NULL,
  `server_platform_id` int(11) DEFAULT NULL,
  `ip_address` varchar(15) DEFAULT NULL,
  `ca_cert_id` int(10) unsigned DEFAULT NULL,
  `signature_hash` varchar(15) NOT NULL,
  `key_size` smallint(5) unsigned DEFAULT NULL,
  `root_path` varchar(20) NOT NULL,
  `email` varchar(1024) DEFAULT NULL,
  `origin` varchar(30) DEFAULT NULL,
  `service_name` varchar(150) DEFAULT NULL,
  `custom_expiration_date` datetime DEFAULT NULL,
  `renewal_of_order_id` int(11) DEFAULT NULL,
  `extra_input` text DEFAULT NULL,
  `cs_provisioning_method` varchar(15) NOT NULL DEFAULT 'none',
  `addons` varchar(255) DEFAULT NULL,
  `auto_renew` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `additional_emails` text DEFAULT NULL,
  `user_assignments` varchar(255) DEFAULT NULL,
  `promo_code` varchar(100) DEFAULT NULL,
  `receipt_id` int(11) DEFAULT NULL,
  `is_out_of_contract` tinyint(3) NOT NULL DEFAULT 0,
  `disable_renewal_notifications` tinyint(1) NOT NULL DEFAULT 0,
  `order_validation_notes` varchar(2000) DEFAULT NULL,
  `disable_issuance_email` tinyint(3) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `ix_order_tracker_id` (`order_tracker_id`),
  KEY `order_action_queue_id` (`order_action_queue_id`),
  KEY `idx_renewal_of_order_id` (`renewal_of_order_id`),
  KEY `receipt_id` (`receipt_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10550915 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_request_extras` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `order_request_id` int(10) unsigned NOT NULL,
  `ship_name` varchar(128) DEFAULT NULL,
  `ship_addr1` varchar(128) DEFAULT NULL,
  `ship_addr2` varchar(128) DEFAULT NULL,
  `ship_city` varchar(128) DEFAULT NULL,
  `ship_state` varchar(128) DEFAULT NULL,
  `ship_zip` varchar(40) DEFAULT NULL,
  `ship_country` varchar(128) DEFAULT NULL,
  `ship_method` enum('STANDARD','EXPEDITED') DEFAULT NULL,
  `subject_name` varchar(150) DEFAULT NULL,
  `subject_job_title` varchar(150) DEFAULT NULL,
  `subject_phone` varchar(150) DEFAULT NULL,
  `subject_email` varchar(150) DEFAULT NULL,
  `custom_renewal_message` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_order_request_id` (`order_request_id`)
) ENGINE=InnoDB AUTO_INCREMENT=110675 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_status_map` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `status_id` int(10) unsigned NOT NULL,
  `reason_id` int(10) unsigned NOT NULL,
  `customer_order_status` varchar(32) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_status_reason` (`status_id`,`reason_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_tor_service_descriptors` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(10) unsigned NOT NULL,
  `uri` varchar(2048) NOT NULL,
  `public_key` text NOT NULL,
  `date_created` datetime NOT NULL,
  `staff_id_created_by` int(10) unsigned NOT NULL,
  `date_deleted` datetime NOT NULL,
  `staff_id_deleted_by` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=455 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_tracker` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `container_id` int(10) unsigned DEFAULT NULL,
  `order_id` int(10) unsigned NOT NULL,
  `type` tinyint(3) unsigned NOT NULL,
  `product_name_id` varchar(64) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `order_id` (`order_id`),
  KEY `ix_order_id` (`order_id`),
  KEY `ix_container_id` (`container_id`)
) ENGINE=InnoDB AUTO_INCREMENT=125754161 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_transaction` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `container_id` int(10) unsigned NOT NULL,
  `order_id` int(10) unsigned NOT NULL,
  `receipt_id` int(10) unsigned DEFAULT NULL,
  `acct_adjust_id` int(10) unsigned DEFAULT NULL,
  `po_id` int(10) unsigned DEFAULT NULL,
  `amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `payment_type` varchar(50) NOT NULL,
  `transaction_date` datetime NOT NULL,
  `transaction_type` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_container_id` (`container_id`),
  KEY `ix_order_id` (`order_id`),
  KEY `ix_receipt_id` (`receipt_id`),
  KEY `ix_acct_adjust_id` (`acct_adjust_id`)
) ENGINE=InnoDB AUTO_INCREMENT=119571130 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `date_added` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`,`user_id`),
  KEY `idx_user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=118441989 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_verified_contacts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(8) unsigned zerofill NOT NULL,
  `verified_contact_id` int(11) NOT NULL,
  `checklist_role_ids` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `order_verified_contact_id` (`order_id`,`verified_contact_id`),
  KEY `verified_contact_id` (`verified_contact_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19200709 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_verified_contacts_snapshots` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `order_id` int(8) unsigned NOT NULL DEFAULT 0,
  `reissue_id` int(10) unsigned NOT NULL DEFAULT 0,
  `verified_contact_id` int(10) unsigned NOT NULL,
  `status` enum('pending','active','inactive') NOT NULL DEFAULT 'pending',
  `user_id` int(10) NOT NULL,
  `company_id` int(11) NOT NULL,
  `firstname` varchar(64) NOT NULL,
  `lastname` varchar(64) NOT NULL,
  `email` varchar(255) NOT NULL,
  `job_title` varchar(64) NOT NULL,
  `telephone` varchar(32) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `order_id_idx` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=18111911 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_verified_emails` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(6) unsigned zerofill NOT NULL,
  `verified_contact_id` int(10) unsigned NOT NULL,
  `date_verified` datetime DEFAULT NULL,
  `cert_common_name` varchar(64) NOT NULL DEFAULT '',
  `email` varchar(128) NOT NULL DEFAULT '',
  `ip_address` varchar(15) NOT NULL DEFAULT '',
  `status` enum('active','inactive') DEFAULT 'active',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4131 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_wifi_friendly_names` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL,
  `friendlyname_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1367 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_wifi_logos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(10) unsigned NOT NULL,
  `language` char(3) NOT NULL,
  `uri` text NOT NULL,
  `doc_id` int(10) unsigned DEFAULT NULL,
  `content_type` varchar(100) DEFAULT NULL,
  `date_retrieved` timestamp NULL DEFAULT NULL,
  `date_created` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1367 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `organization_contact_snapshots` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `verified_contact_id` int(10) unsigned DEFAULT NULL,
  `checklist_id` int(10) unsigned DEFAULT NULL,
  `organization_id` int(10) unsigned DEFAULT NULL,
  `snapshot_data` blob DEFAULT NULL,
  `snapshot_date` datetime DEFAULT NULL,
  `snapshot_br_version` varchar(32) DEFAULT NULL,
  `contact_valid_from` datetime DEFAULT NULL,
  `doc_valid_from` datetime DEFAULT NULL,
  `snapshot_checklist_version` varchar(16) DEFAULT NULL,
  `max_validity_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_org_checklist` (`verified_contact_id`,`checklist_id`),
  KEY `idx_verified_contact_id` (`verified_contact_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3045554 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `organization_container_assignments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `organization_id` int(11) NOT NULL,
  `container_id` int(11) NOT NULL,
  `date_created` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_organization_id` (`organization_id`),
  KEY `idx_container_id` (`container_id`)
) ENGINE=InnoDB AUTO_INCREMENT=126947 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `organization_logo` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL DEFAULT current_timestamp(),
  `organization_id` int(10) unsigned NOT NULL,
  `logo` mediumtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_org_id` (`organization_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `organization_metadata` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `organization_id` int(11) DEFAULT NULL,
  `brand` varchar(256) DEFAULT NULL,
  `context_data` varchar(256) DEFAULT NULL,
  `locale` varchar(5) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `customer_comment_template` varchar(255) DEFAULT NULL,
  `customer_comment_lang` varchar(5) DEFAULT NULL,
  `customer_comment_date` datetime DEFAULT NULL,
  `customer_comment` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_organization` (`organization_id`)
) ENGINE=InnoDB AUTO_INCREMENT=410278 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `organization_snapshots` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `organization_id` int(10) unsigned DEFAULT NULL,
  `checklist_id` int(10) unsigned DEFAULT NULL,
  `snapshot_data` blob DEFAULT NULL,
  `snapshot_date` datetime DEFAULT NULL,
  `snapshot_br_version` varchar(32) DEFAULT NULL,
  `org_valid_from` datetime DEFAULT NULL,
  `doc_valid_from` datetime DEFAULT NULL,
  `snapshot_checklist_version` varchar(16) DEFAULT NULL,
  `max_validity_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_org_checklist` (`organization_id`,`checklist_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2917340 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `organization_validation_cache` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `organization_id` int(11) DEFAULT NULL,
  `checklist_id` int(11) DEFAULT NULL,
  `valid_from` date DEFAULT NULL,
  `valid_until` date DEFAULT NULL,
  `date_created` datetime DEFAULT current_timestamp(),
  `last_updated` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_org_checklist` (`organization_id`,`checklist_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1568283 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `org_types` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `ou_account_exemptions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` int(10) unsigned NOT NULL,
  `date_created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_account_id` (`account_id`) USING HASH
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `ou_blacklist` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` int(10) unsigned NOT NULL DEFAULT 0,
  `ou_value` varchar(128) NOT NULL,
  `staff_id` int(11) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_account_ou` (`account_id`,`ou_value`)
) ENGINE=InnoDB AUTO_INCREMENT=10195 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `ou_whitelist` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` int(10) unsigned NOT NULL,
  `ou_value` varchar(128) NOT NULL,
  `staff_id` int(11) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `staff_id2` int(10) unsigned DEFAULT NULL,
  `note` text DEFAULT NULL,
  `document_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_account_value` (`account_id`,`ou_value`),
  KEY `ix_date_created` (`date_created`)
) ENGINE=InnoDB AUTO_INCREMENT=215860 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `payment_profiles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `gty_profile_id` varchar(32) NOT NULL,
  `cc_label` varchar(128) DEFAULT NULL,
  `cc_last4` varchar(4) DEFAULT NULL,
  `cc_exp_month` varchar(2) DEFAULT NULL,
  `cc_exp_year` varchar(4) DEFAULT NULL,
  `cc_type` enum('amex','visa','mastercard','discover','other','none') NOT NULL DEFAULT 'none',
  `bill_name` varchar(128) DEFAULT NULL,
  `bill_org_name` varchar(128) DEFAULT NULL,
  `bill_addr1` varchar(128) DEFAULT NULL,
  `bill_addr2` varchar(128) DEFAULT NULL,
  `bill_city` varchar(128) DEFAULT NULL,
  `bill_state` varchar(128) DEFAULT NULL,
  `bill_zip` varchar(40) DEFAULT NULL,
  `bill_country` varchar(2) DEFAULT NULL,
  `bill_email` varchar(255) DEFAULT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 1,
  `gty_status` varchar(64) NOT NULL DEFAULT '',
  `payment_gty` varchar(32) NOT NULL DEFAULT 'cybersource',
  `date_created` datetime NOT NULL,
  `new_profile_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=91342 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `direct_group` set('view_HCO','view_users','view_requests','view_certificates','view_domains','account_settings','edit_users','edit_roles','edit_users_hco','all_HCOs','all_ISSOs','all_users','request_cert','request_address_cert','request_org_cert','request_device_cert','additional_emails','approve_requests','reject_requests','edit_requests','view_certificate','add_order_notes','delete_order_notes','view_order_notes','rekey_cert','revoke_cert','cancel_order','download_cert','view_order_duplicates','deposit_funds','view_balance') DEFAULT NULL,
  `direct_group2` set('view_documents','all_documents','upload_documents','view_balance_history','edit_self','edit_HCO','edit_ISSO','view_contacts','edit_contacts','expire_documents','download_documents','edit_contacts_hco','custom_fields','delete_hco','deactivate_hco','create_users','create_contacts','approval_rules','delete_domains','approve_domains','edit_domains','add_domains','submit_domains','resend_dcv','import','case_notes','request_fbca_address_cert') DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `permissions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=94 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `permission_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `acct_id` int(11) DEFAULT NULL,
  `permission_id` int(11) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `description` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `permission_id` (`permission_id`),
  KEY `acct_id` (`acct_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `permission_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  `type` set('grant','revoke') DEFAULT NULL,
  `level` set('group','user') DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `permission_id` (`user_id`,`permission_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=37534 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `php_sessions` (
  `s_num` varchar(32) NOT NULL,
  `s_mtime` int(11) DEFAULT NULL,
  `s_ctime` int(11) DEFAULT NULL,
  `s_data` mediumtext DEFAULT NULL,
  `s_user_type` enum('cust','staff') NOT NULL DEFAULT 'cust',
  PRIMARY KEY (`s_num`),
  KEY `php_sessions_mtime` (`s_mtime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `pki_notes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(8) unsigned zerofill DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `note` text DEFAULT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_orderid` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=57142798 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `po` (
  `id` int(4) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `acct_id` int(6) unsigned zerofill NOT NULL DEFAULT 000000,
  `flag` tinyint(4) NOT NULL DEFAULT 0,
  `status` tinyint(4) NOT NULL DEFAULT 0,
  `invoice_number` int(8) DEFAULT NULL,
  `invoice_status` tinyint(1) NOT NULL DEFAULT 1,
  `notes` text DEFAULT NULL,
  `date_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `contact_name` varchar(128) NOT NULL DEFAULT '',
  `electronic_signature` varchar(128) DEFAULT NULL,
  `email` varchar(128) NOT NULL DEFAULT '',
  `telephone` varchar(32) NOT NULL DEFAULT '',
  `telephone_ext` varchar(16) NOT NULL DEFAULT '',
  `fax` varchar(32) NOT NULL DEFAULT '',
  `org_name` varchar(128) NOT NULL DEFAULT '',
  `org_addr1` varchar(128) NOT NULL DEFAULT '',
  `org_addr2` varchar(128) NOT NULL DEFAULT '',
  `org_city` varchar(64) NOT NULL DEFAULT '',
  `org_state` varchar(64) NOT NULL DEFAULT '',
  `org_country` varchar(2) NOT NULL DEFAULT '0',
  `org_zip` varchar(10) NOT NULL DEFAULT '',
  `inv_term` int(2) DEFAULT 10,
  `inv_term_eom` tinyint(4) DEFAULT 0,
  `inv_contact_name` varchar(128) NOT NULL DEFAULT '',
  `inv_email` varchar(128) NOT NULL DEFAULT '',
  `inv_telephone` varchar(32) NOT NULL DEFAULT '',
  `inv_telephone_ext` varchar(16) NOT NULL DEFAULT '',
  `inv_fax` varchar(32) NOT NULL DEFAULT '',
  `inv_org_name` varchar(128) NOT NULL DEFAULT '',
  `inv_org_addr1` varchar(128) NOT NULL DEFAULT '',
  `inv_org_addr2` varchar(128) NOT NULL DEFAULT '',
  `inv_org_city` varchar(64) NOT NULL DEFAULT '',
  `inv_org_state` varchar(64) NOT NULL DEFAULT '',
  `inv_org_country` varchar(2) NOT NULL DEFAULT '',
  `inv_org_zip` varchar(10) NOT NULL DEFAULT '',
  `po_number` varchar(32) NOT NULL DEFAULT '',
  `amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `amount_owed` decimal(10,2) DEFAULT NULL,
  `reject_notes` varchar(255) NOT NULL DEFAULT '',
  `reject_date_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `reject_staff` int(10) unsigned NOT NULL DEFAULT 0,
  `inv_send_mail` tinyint(1) NOT NULL DEFAULT 0,
  `inv_send_fax` tinyint(1) NOT NULL DEFAULT 0,
  `invoice_sent` tinyint(1) NOT NULL DEFAULT 0,
  `hard_copy_name` varchar(128) NOT NULL DEFAULT '',
  `paid_amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `paid_date_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `send_email_reminders` tinyint(4) NOT NULL DEFAULT 1,
  `send_from` int(10) unsigned DEFAULT NULL,
  `date_last_emailed` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `unit_id` int(11) NOT NULL DEFAULT 0,
  `container_id` int(10) unsigned DEFAULT NULL,
  `is_internal` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `converted_from_quote` datetime DEFAULT NULL,
  `quote_expiration_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `status` (`status`),
  KEY `invoice_status` (`invoice_status`),
  KEY `idx_acct` (`acct_id`),
  KEY `idx_invoice_number` (`invoice_number`),
  KEY `container_id` (`container_id`)
) ENGINE=InnoDB AUTO_INCREMENT=215631 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `po_audit` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `action_id` int(10) unsigned DEFAULT NULL,
  `field_name` varchar(50) DEFAULT NULL,
  `old_value` text DEFAULT NULL,
  `new_value` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1030437 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `po_audit_action` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `po_id` int(10) unsigned DEFAULT NULL,
  `staff_id` smallint(5) unsigned NOT NULL DEFAULT 0,
  `date_dt` datetime DEFAULT NULL,
  `action_type` varchar(255) DEFAULT NULL,
  `affected_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=668575 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `po_contact` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `po_id` int(10) unsigned NOT NULL,
  `name` varchar(128) DEFAULT NULL,
  `email` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_po_id` (`po_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16408 DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `po_docs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `po_id` int(4) unsigned zerofill NOT NULL DEFAULT 0000,
  `filename` varchar(128) NOT NULL DEFAULT '',
  `ctime` datetime NOT NULL,
  `notes` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_po_id` (`po_id`)
) ENGINE=InnoDB AUTO_INCREMENT=92352 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `po_flags` (
  `id` tinyint(1) NOT NULL AUTO_INCREMENT,
  `number` tinyint(1) NOT NULL DEFAULT 0,
  `color` varchar(16) NOT NULL DEFAULT '',
  `description` varchar(128) NOT NULL DEFAULT '',
  `color_code` varchar(7) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `po_invoice_statuses` (
  `id` tinyint(4) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `po_notes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `po_id` int(8) unsigned zerofill DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `note` text DEFAULT NULL,
  `staff_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `po_notes_po_id` (`po_id`),
  KEY `date_index` (`date`)
) ENGINE=InnoDB AUTO_INCREMENT=1082493 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `po_prod` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) NOT NULL DEFAULT 0,
  `order_id` int(8) unsigned zerofill NOT NULL DEFAULT 00000000,
  `years` tinyint(1) NOT NULL DEFAULT 0,
  `servers` int(4) NOT NULL DEFAULT 0,
  `license` enum('single','unlimited') NOT NULL DEFAULT 'single',
  `po_id` int(4) unsigned zerofill NOT NULL DEFAULT 0000,
  `redeemed` tinyint(1) NOT NULL DEFAULT 0,
  `status` tinyint(4) NOT NULL DEFAULT 1,
  `amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `domain` varchar(255) NOT NULL DEFAULT '',
  `cred_amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `addl_cn_price` decimal(10,2) NOT NULL DEFAULT 0.00,
  `product_name_id` varchar(64) DEFAULT NULL,
  `purchased_wildcard_names` int(10) unsigned NOT NULL DEFAULT 0,
  `addl_wc_price` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `po_id` (`po_id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2390594 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `po_prod_addons` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `po_prod_id` int(10) unsigned NOT NULL,
  `addon_id` int(10) unsigned NOT NULL,
  `amount` decimal(10,0) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `po_prod_id` (`po_prod_id`),
  KEY `po_addon_addon_id` (`addon_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13648 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `po_prod_statuses` (
  `id` tinyint(4) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `po_statuses` (
  `id` tinyint(4) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `practical_demo_tokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `domain_id` int(11) NOT NULL,
  `name_scope` varchar(255) DEFAULT NULL,
  `date_submitted` datetime DEFAULT NULL,
  `expiration_date` datetime DEFAULT NULL,
  `confirmed_date` datetime DEFAULT NULL,
  `cert_approval_id` int(11) DEFAULT NULL,
  `token_target` varchar(255) DEFAULT NULL,
  `token` varchar(255) DEFAULT NULL,
  `method` varchar(32) DEFAULT NULL,
  `scope_id` varchar(255) DEFAULT NULL,
  `container_domain_id` varchar(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_domain_id` (`domain_id`,`name_scope`),
  KEY `idx_container_domain_id` (`container_domain_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1753677 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `pre_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `public_id` varchar(255) NOT NULL,
  `date_created` datetime NOT NULL,
  `expire_date` datetime DEFAULT NULL,
  `date_processed` datetime DEFAULT NULL,
  `type` enum('SAML') NOT NULL,
  `container_id` int(11) NOT NULL,
  `order_data` text NOT NULL,
  `order_id` int(11) DEFAULT NULL,
  `person_id` varchar(255) DEFAULT NULL,
  `idp_entity_id` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `public_id_UNIQUE` (`public_id`)
) ENGINE=InnoDB AUTO_INCREMENT=90091 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `pricing_contracts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `acct_id` int(6) unsigned NOT NULL,
  `date_time` datetime NOT NULL,
  `created_by_staff_id` int(10) unsigned NOT NULL,
  `effective_date` datetime NOT NULL,
  `term_length` tinyint(4) NOT NULL,
  `end_date` datetime NOT NULL,
  `auto_renewal` tinyint(4) NOT NULL,
  `service_fee` decimal(10,2) NOT NULL,
  `service_fee_limit_type` enum('year','term','6months','quarter','month') NOT NULL DEFAULT 'year',
  `total_cert_limit` varchar(10) NOT NULL,
  `total_ssl_cert_limit` varchar(10) NOT NULL,
  `total_client_cert_limit` varchar(10) NOT NULL,
  `limit_type` enum('year','term') NOT NULL DEFAULT 'year',
  `product_limits` text DEFAULT NULL,
  `pricing_model` enum('flatfee','percert','combined','tiered','tiered_revenue','prepay','none') DEFAULT NULL,
  `discount_type` enum('none','percent_all','percent_each','fixed') NOT NULL DEFAULT 'none',
  `total_domain_limit` varchar(5) NOT NULL,
  `price_locking` enum('30_days_notice','year','term') NOT NULL DEFAULT '30_days_notice',
  `needs_cps_change_notices` tinyint(4) NOT NULL DEFAULT 0,
  `has_custom_terms` tinyint(4) NOT NULL DEFAULT 0,
  `note` text NOT NULL,
  `custom_rates` text NOT NULL,
  `percent_discount` tinyint(4) NOT NULL DEFAULT 0,
  `allowed_lifetime` enum('any','one','two','three','four','five','six') NOT NULL DEFAULT 'any',
  `current_tier` int(10) unsigned DEFAULT NULL,
  `last_annual_check` datetime DEFAULT NULL,
  `is_lifetime_tiered` tinyint(4) NOT NULL DEFAULT 0,
  `is_tier1_base_pricing` tinyint(4) NOT NULL DEFAULT 0,
  `require_click_agreement` tinyint(4) NOT NULL DEFAULT 0,
  `agreement_id` int(10) unsigned DEFAULT NULL,
  `agreement_ip` varchar(50) DEFAULT NULL,
  `agreement_user_id` int(10) unsigned DEFAULT NULL,
  `agreement_date` timestamp NULL DEFAULT NULL,
  `ela` tinyint(4) NOT NULL DEFAULT 0,
  `enterprise_support_plan` tinyint(4) NOT NULL DEFAULT 1,
  `unit_rates` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `subaccount_unit_discounts` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `acct_id` (`acct_id`),
  KEY `effective_date` (`effective_date`),
  KEY `end_date` (`end_date`),
  KEY `auto_renewal` (`auto_renewal`),
  KEY `total_domain_limit` (`total_domain_limit`),
  KEY `price_locking` (`price_locking`),
  KEY `has_custom_terms` (`has_custom_terms`)
) ENGINE=InnoDB AUTO_INCREMENT=24131 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `pricing_contract_sales_stats` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `contract_id` int(10) unsigned DEFAULT NULL,
  `sales_stat_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `pricing_contract_sales_stats_sales_stat_id` (`sales_stat_id`),
  KEY `contract_id` (`contract_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9004 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `pricing_contract_tiers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pricing_contract_id` int(10) unsigned NOT NULL,
  `max_volume` int(8) unsigned NOT NULL,
  `is_unlimited` tinyint(4) unsigned NOT NULL DEFAULT 0,
  `discount_type` enum('none','percent_all','percent_each','fixed') DEFAULT NULL,
  `custom_rates` text DEFAULT NULL,
  `percent_discount` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14088 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `private_ca_info` (
  `id` int(11) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `common_name` varchar(255) NOT NULL DEFAULT '',
  `private_ca_org_id` int(11) unsigned NOT NULL DEFAULT 0,
  `org_unit` text DEFAULT NULL,
  `signature_hash` enum('sha1','sha256','sha384','sha512') NOT NULL DEFAULT 'sha256',
  `key_size` varchar(10) NOT NULL DEFAULT '2048',
  `key_algorithm` varchar(10) NOT NULL DEFAULT 'rsa',
  `lifetime` tinyint(4) unsigned NOT NULL DEFAULT 0,
  `custom_expiration_date` datetime DEFAULT NULL,
  `custom_validity_days` int(6) unsigned DEFAULT NULL,
  `is_root` tinyint(4) unsigned NOT NULL DEFAULT 0,
  `is_cert_revocation_list` tinyint(4) unsigned DEFAULT NULL,
  `is_ocsp` tinyint(4) unsigned DEFAULT NULL,
  `cps_default` tinyint(4) unsigned DEFAULT NULL,
  `custom_cps_url` text DEFAULT NULL,
  `custom_policy_identifier` text DEFAULT NULL,
  `order_specific_message` text DEFAULT NULL,
  `root_ca_cert_id` int(11) unsigned NOT NULL DEFAULT 0,
  `root_ca_private_pki_order_id` int(11) unsigned zerofill NOT NULL DEFAULT 00000000000,
  `date_created` datetime DEFAULT NULL,
  `user_id` int(11) unsigned DEFAULT 0,
  `account_id` int(6) unsigned zerofill NOT NULL DEFAULT 000000,
  `status` varchar(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `ix_common_name` (`common_name`),
  KEY `ix_root_ca_cert_id` (`root_ca_cert_id`),
  KEY `ix_root_ca_private_pki_order_id` (`root_ca_private_pki_order_id`),
  KEY `ix_account_id` (`account_id`),
  KEY `ix_status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `private_ca_organizations` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` int(6) unsigned zerofill NOT NULL DEFAULT 000000,
  `container_id` int(11) unsigned DEFAULT NULL,
  `org_name` varchar(255) NOT NULL DEFAULT '',
  `org_city` varchar(128) NOT NULL DEFAULT '',
  `org_state` varchar(128) NOT NULL DEFAULT '',
  `org_country` varchar(2) NOT NULL DEFAULT '',
  `date_created` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_unique_acct_org` (`account_id`,`org_name`,`org_country`),
  KEY `ix_account_id` (`account_id`),
  KEY `ix_container_id` (`container_id`),
  KEY `ix_org_name` (`org_name`),
  KEY `ix_org_country` (`org_country`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `products` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(128) DEFAULT NULL,
  `simple_name` varchar(128) NOT NULL,
  `accounting_code` varchar(10) NOT NULL DEFAULT '',
  `cmd_prod_id` varchar(64) DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `has_sans` tinyint(1) NOT NULL DEFAULT 0,
  `additional_dns_names_allowed` tinyint(1) NOT NULL DEFAULT 0,
  `valid_addons` varchar(255) NOT NULL,
  `ca_product_type` enum('ssl','codesigning','client','none','ev_ssl','ov_ssl','dv_ssl') DEFAULT NULL,
  `max_lifetime` tinyint(3) unsigned NOT NULL DEFAULT 3,
  `min_lifetime` tinyint(3) unsigned NOT NULL DEFAULT 1,
  `max_days` smallint(5) unsigned DEFAULT NULL,
  `review_url` varchar(255) DEFAULT NULL,
  `review_url_text` varchar(255) DEFAULT NULL,
  `api_name` varchar(45) DEFAULT NULL,
  `api_group_name` varchar(45) DEFAULT NULL,
  `product_type` varchar(45) DEFAULT NULL,
  `description` varchar(512) DEFAULT NULL,
  `domain_blacklist_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `cmd_prod_id` (`cmd_prod_id`),
  KEY `active` (`active`),
  KEY `simple_name` (`simple_name`)
) ENGINE=InnoDB AUTO_INCREMENT=11026 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `product_api` (
  `product_api_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id` int(10) unsigned NOT NULL,
  `product_id` int(10) unsigned NOT NULL,
  `product_name_id` varchar(64) NOT NULL,
  `product_type` varchar(64) NOT NULL,
  `group_type` varchar(64) NOT NULL,
  `product_name` varchar(128) NOT NULL,
  `profile_id` int(10) unsigned DEFAULT NULL,
  `sort_order` int(10) unsigned DEFAULT 10000,
  `short_description` varchar(255) DEFAULT NULL,
  `user_interface_description` text DEFAULT NULL,
  PRIMARY KEY (`product_api_id`),
  UNIQUE KEY `idx_product_name_id` (`product_name_id`),
  KEY `idx_product_id` (`id`),
  KEY `ix_product_id` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=337 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `product_api_old` (
  `id` int(10) unsigned NOT NULL,
  `product_name_id` varchar(64) NOT NULL,
  `product_type` varchar(64) NOT NULL,
  `group_type` varchar(64) NOT NULL,
  `product_name` varchar(128) NOT NULL,
  `profile_id` int(10) unsigned DEFAULT NULL,
  `sort_order` int(10) unsigned DEFAULT 10000,
  `short_description` varchar(255) DEFAULT NULL,
  `user_interface_description` text DEFAULT NULL,
  PRIMARY KEY (`product_name_id`),
  KEY `idx_product_id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `product_rates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `product_id` int(10) unsigned DEFAULT NULL,
  `rates` text DEFAULT NULL,
  `renewal_discount` varchar(255) DEFAULT NULL,
  `addl_cn` varchar(255) DEFAULT NULL,
  `start_date` datetime NOT NULL,
  `fqdn_rates` varchar(255) DEFAULT NULL,
  `wildcard_rates` varchar(255) DEFAULT NULL,
  `currency` char(3) CHARACTER SET ascii NOT NULL DEFAULT 'USD',
  `fqdn_package_rates` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`),
  KEY `ix_currency` (`currency`)
) ENGINE=InnoDB AUTO_INCREMENT=581 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `promotion_new_customer` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `created` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_new` tinyint(1) unsigned DEFAULT NULL,
  `test_results` text DEFAULT NULL,
  `is_eligible` tinyint(1) unsigned DEFAULT NULL,
  `eligibility_notes` text DEFAULT NULL,
  `promo_code_id` int(11) unsigned DEFAULT NULL,
  `order_id` int(11) unsigned DEFAULT NULL,
  `order_price` smallint(5) unsigned DEFAULT NULL,
  `rewarded` tinyint(1) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `promo_codes` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `expiration_date` date NOT NULL,
  `num_uses` int(11) NOT NULL DEFAULT 1,
  `num_uses_per_account` int(11) NOT NULL DEFAULT 1,
  `promo_code` varchar(100) NOT NULL,
  `product_prices` text NOT NULL,
  `percent_discount` varchar(10) NOT NULL DEFAULT '0',
  `extra_days` int(11) NOT NULL,
  `lifetime` varchar(25) NOT NULL DEFAULT '0',
  `product_id` varchar(255) NOT NULL DEFAULT '0',
  `max_names` smallint(5) unsigned NOT NULL DEFAULT 0,
  `customer_name` varchar(100) NOT NULL,
  `customer_org` varchar(100) NOT NULL,
  `customer_email` varchar(100) NOT NULL,
  `customer_phone` varchar(30) NOT NULL,
  `make_permanent_discount` tinyint(4) NOT NULL DEFAULT 0,
  `note` text NOT NULL,
  `reason_id` tinyint(3) unsigned DEFAULT 0,
  `competitor_number` tinyint(3) unsigned DEFAULT NULL,
  `staff_id` int(11) NOT NULL DEFAULT 0,
  `cust_user_id` int(11) NOT NULL DEFAULT 0,
  `acct_id` int(6) unsigned NOT NULL DEFAULT 0,
  `completed` tinyint(4) NOT NULL DEFAULT 0,
  `category` varchar(50) NOT NULL,
  `order_id` int(8) unsigned zerofill NOT NULL DEFAULT 00000000,
  `receipt_id` int(10) NOT NULL DEFAULT 0,
  `stat_row_id` int(11) NOT NULL DEFAULT 0,
  `only_new_accounts` tinyint(4) NOT NULL DEFAULT 0,
  `allowed_names` varchar(200) DEFAULT NULL,
  `cert_expiration_date` date DEFAULT NULL,
  `source_page` varchar(255) DEFAULT NULL,
  `currency` char(3) CHARACTER SET ascii NOT NULL DEFAULT 'USD',
  `custom_days` int(11) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`promo_code`),
  KEY `promo_code_order_id_idx` (`order_id`),
  KEY `order_id` (`order_id`),
  KEY `receipt_id` (`receipt_id`),
  KEY `idx_acct_id` (`acct_id`)
) ENGINE=InnoDB AUTO_INCREMENT=238122 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `promo_code_extras` (
  `promo_code_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_info` text DEFAULT NULL,
  PRIMARY KEY (`promo_code_id`)
) ENGINE=InnoDB AUTO_INCREMENT=33463 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `promo_code_orders` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `promo_code_id` int(10) unsigned NOT NULL,
  `acct_id` int(6) unsigned zerofill DEFAULT NULL,
  `order_id` int(8) unsigned zerofill DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `account_index` (`acct_id`),
  KEY `order_index` (`order_id`),
  KEY `promo_code_id` (`promo_code_id`)
) ENGINE=InnoDB AUTO_INCREMENT=96893 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `promo_code_reasons` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `reason` varchar(255) NOT NULL,
  `status` varchar(20) DEFAULT 'active',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `promo_pages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `thumbnail` varchar(255) NOT NULL DEFAULT '',
  `text` mediumtext NOT NULL,
  `description` text NOT NULL,
  `name` varchar(128) NOT NULL DEFAULT '',
  `order` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `quotes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `recipientName` varchar(150) NOT NULL,
  `recipientOrgName` varchar(150) NOT NULL,
  `recipientEmail` varchar(150) NOT NULL,
  `recipientPhone` varchar(25) NOT NULL,
  `productCount` int(11) NOT NULL,
  `productDetails` text NOT NULL,
  `grandTotal` double NOT NULL,
  `token` varchar(50) NOT NULL,
  `promo_code` varchar(20) NOT NULL,
  `staff_id` int(11) NOT NULL,
  `note` text NOT NULL,
  `date_time` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `token` (`token`)
) ENGINE=InnoDB AUTO_INCREMENT=83163 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `real_id_states` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` char(50) NOT NULL,
  `real_id_compliant` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `date_last_modified` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `modified_by` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `real_id_compliant` (`real_id_compliant`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `reasons` (
  `id` tinyint(4) NOT NULL AUTO_INCREMENT,
  `status_id` tinyint(4) NOT NULL DEFAULT 0,
  `name` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `status_id` (`status_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `receipts` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `date_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `acct_amount` decimal(10,2) DEFAULT 0.00,
  `cc_amount` decimal(10,2) DEFAULT 0.00,
  `cc_last4` varchar(4) DEFAULT NULL,
  `cc_exp_date` varchar(4) DEFAULT NULL,
  `cc_type` enum('amex','visa','mastercard','discover','other','none') NOT NULL DEFAULT 'none',
  `gty_trans_id` varchar(32) DEFAULT '0',
  `gty_settlement_id` varchar(32) DEFAULT '0',
  `gty_refund_id` varchar(32) DEFAULT '0',
  `bill_name` varchar(128) DEFAULT NULL,
  `bill_org_name` varchar(128) DEFAULT NULL,
  `bill_addr1` varchar(128) DEFAULT NULL,
  `bill_addr2` varchar(128) DEFAULT NULL,
  `bill_city` varchar(128) DEFAULT NULL,
  `bill_state` varchar(128) DEFAULT NULL,
  `bill_zip` varchar(40) DEFAULT NULL,
  `bill_country` varchar(2) DEFAULT NULL,
  `bill_email` varchar(255) DEFAULT NULL,
  `gty_status` varchar(64) NOT NULL DEFAULT '',
  `gty_capture_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `gty_auth_msg` varchar(128) NOT NULL DEFAULT '',
  `gty_request_token` varchar(128) NOT NULL DEFAULT '',
  `gty_ref_code` varchar(128) NOT NULL DEFAULT '',
  `payment_gty` enum('cybersource','netbilling') NOT NULL DEFAULT 'cybersource',
  `payment_profile_id` varchar(32) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `gty_trans_id` (`gty_trans_id`),
  KEY `gty_settlement_id` (`gty_settlement_id`)
) ENGINE=InnoDB AUTO_INCREMENT=119065236 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `receipt_tax` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `receipt_id` int(10) unsigned NOT NULL,
  `tax_amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `gross_amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  PRIMARY KEY (`id`),
  KEY `ix_receipt_id` (`receipt_id`)
) ENGINE=InnoDB AUTO_INCREMENT=76497410 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `registration_authority` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` int(10) unsigned NOT NULL,
  `registration_authority_hash` varchar(128) DEFAULT NULL,
  `registration_authority_encrypted` varchar(255) DEFAULT NULL,
  `ip_ranges` varchar(255) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_account_id` (`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `reissues` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(8) unsigned zerofill NOT NULL DEFAULT 00000000,
  `status` tinyint(1) NOT NULL DEFAULT 2,
  `ca_order_id` int(11) NOT NULL DEFAULT 0,
  `cmd_prod_id` varchar(64) NOT NULL,
  `date_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `staff_id` int(11) NOT NULL DEFAULT 0,
  `auth_1_staff` int(11) NOT NULL,
  `auth_1_date_time` datetime NOT NULL,
  `auth_2_staff` int(11) NOT NULL,
  `auth_2_date_time` datetime NOT NULL,
  `csr` text NOT NULL,
  `serversw` smallint(5) NOT NULL,
  `add_cn` tinyint(2) NOT NULL,
  `reason` text NOT NULL,
  `collected` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `revoked` tinyint(1) NOT NULL DEFAULT 0,
  `reason_code` tinyint(1) NOT NULL,
  `update_expiry` tinyint(1) NOT NULL,
  `valid_till` date NOT NULL DEFAULT '0000-00-00',
  `whois_completed` tinyint(1) NOT NULL,
  `whois_staff_id` int(10) NOT NULL,
  `whois_date_time` datetime NOT NULL,
  `org_name_completed` tinyint(1) NOT NULL,
  `org_name_staff_id` int(10) NOT NULL,
  `org_name_date_time` datetime NOT NULL,
  `old_common_name` text NOT NULL,
  `new_common_name` text NOT NULL,
  `old_sans` text NOT NULL,
  `new_sans` text NOT NULL,
  `new_sans_to_validate` text DEFAULT NULL,
  `old_org_name` varchar(255) NOT NULL,
  `new_org_name` varchar(255) NOT NULL,
  `old_org_unit` varchar(128) NOT NULL,
  `new_org_unit` varchar(128) NOT NULL,
  `old_org_addr1` varchar(128) NOT NULL,
  `new_org_addr1` varchar(128) NOT NULL,
  `old_org_addr2` varchar(128) NOT NULL,
  `new_org_addr2` varchar(128) NOT NULL,
  `old_org_city` varchar(64) NOT NULL,
  `new_org_city` varchar(64) NOT NULL,
  `old_org_state` varchar(64) NOT NULL,
  `new_org_state` varchar(64) NOT NULL,
  `old_org_country` varchar(2) NOT NULL,
  `new_org_country` varchar(2) NOT NULL,
  `old_org_zip` varchar(12) NOT NULL,
  `new_org_zip` varchar(12) NOT NULL,
  `old_email` varchar(255) NOT NULL,
  `new_email` varchar(255) NOT NULL,
  `old_telephone` varchar(32) NOT NULL,
  `new_telephone` varchar(32) NOT NULL,
  `old_telephone_ext` varchar(12) NOT NULL,
  `new_telephone_ext` varchar(12) NOT NULL,
  `reject_date_time` datetime NOT NULL,
  `reject_staff_id` int(10) NOT NULL,
  `reject_reason` text NOT NULL,
  `stat_row_id` int(11) NOT NULL,
  `string_type` enum('PS','T61','UTF8','AUTO') NOT NULL DEFAULT 'AUTO',
  `ca_cert_id` smallint(6) NOT NULL DEFAULT 33,
  `origin` enum('retail','enterprise','staff') DEFAULT 'retail',
  `delay_revoke` smallint(6) NOT NULL,
  `receipt_id` int(10) NOT NULL DEFAULT 0,
  `signature_hash` enum('sha1','sha256','sha384','sha512') DEFAULT 'sha1',
  `root_path` enum('digicert','entrust','cybertrust','comodo') NOT NULL DEFAULT 'entrust',
  `no_sans` tinyint(1) NOT NULL DEFAULT 0,
  `code_signing_cert_token` varchar(32) DEFAULT NULL,
  `risk_score` smallint(5) unsigned DEFAULT NULL,
  `key_usage` varchar(150) DEFAULT NULL,
  `in_progress` tinyint(1) NOT NULL DEFAULT 0,
  `pay_type` varchar(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `stat_row_id` (`stat_row_id`),
  KEY `reissues_status` (`status`),
  KEY `collected_index` (`collected`),
  KEY `status` (`status`),
  KEY `receipt_id` (`receipt_id`),
  KEY `in_progress` (`in_progress`)
) ENGINE=InnoDB AUTO_INCREMENT=901018 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `reissue_notes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `reissue_id` int(8) unsigned zerofill DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `note` text DEFAULT NULL,
  `staff_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `reissue_notes_reissue_id` (`reissue_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10388 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `rejections` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(8) unsigned zerofill NOT NULL DEFAULT 00000000,
  `reject_notes` text NOT NULL,
  `reject_date_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `reject_staff` int(10) unsigned NOT NULL DEFAULT 0,
  `reject_stat_row_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=512443 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `reports` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `container_id` int(10) unsigned NOT NULL,
  `template_id` int(10) unsigned NOT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'requested',
  `instance_id` varchar(255) DEFAULT NULL,
  `last_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `email_sent` varchar(10) NOT NULL DEFAULT 'no',
  `url` varchar(400) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `template_id_idx` (`template_id`),
  CONSTRAINT `template_id` FOREIGN KEY (`template_id`) REFERENCES `report_templates` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1000075 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `report_schedules` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `report_id` int(10) unsigned NOT NULL,
  `frequency` enum('MONTHLY','WEEKLY','DAILY') NOT NULL,
  `parameters` varchar(45) DEFAULT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'requested',
  `instance_id` varchar(255) DEFAULT NULL,
  `last_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `report_id_idx` (`report_id`),
  CONSTRAINT `report_id` FOREIGN KEY (`report_id`) REFERENCES `reports` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1000005 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `report_templates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fields` varchar(1000) NOT NULL,
  `filters` varchar(1000) DEFAULT NULL,
  `parameters` varchar(200) DEFAULT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `last_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `query_name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1000063 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `request_auth_log` (
  `company_id` int(10) unsigned NOT NULL,
  `date_processed` datetime NOT NULL,
  `already_completed` tinyint(3) unsigned NOT NULL,
  `found_dcv` tinyint(3) unsigned DEFAULT NULL,
  `found_ov_checks` tinyint(3) unsigned DEFAULT NULL,
  `reference_dcv_id` int(10) unsigned DEFAULT NULL,
  `reference_checkmark_id` int(10) unsigned DEFAULT NULL,
  `created_checkmark_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`company_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `request_auth_tool` (
  `org_id` int(10) unsigned NOT NULL,
  `cert_approval_id` int(10) unsigned DEFAULT NULL,
  `cis_domain_id` varchar(255) DEFAULT NULL,
  `last_checked` datetime DEFAULT NULL,
  `date_found` datetime DEFAULT NULL,
  `checkmark_note` text DEFAULT NULL,
  UNIQUE KEY `org_id` (`org_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `reseller_company_types` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `reseller_seal_info` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Use UNSIGNED MEDIUMINT limits us to 16 million seals to keep us below the hash collision threshold',
  `hash` char(8) DEFAULT NULL COMMENT 'CHAR(8) with our hashing algorithm would have a collision at around 19 million hashes',
  `reseller_id` int(10) unsigned NOT NULL,
  `domains` text DEFAULT NULL,
  `created_timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  `seen_on_url` varchar(255) DEFAULT NULL,
  `seen_timestamp` timestamp NULL DEFAULT NULL,
  `seen_with_params` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `reseller_id` (`reseller_id`),
  UNIQUE KEY `hash` (`hash`)
) ENGINE=InnoDB AUTO_INCREMENT=7241 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `revokes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(8) unsigned zerofill NOT NULL DEFAULT 00000000,
  `date_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `staff_id` int(11) NOT NULL DEFAULT 0,
  `reason` text NOT NULL,
  `reason_code` tinyint(1) NOT NULL DEFAULT 0,
  `simple_reason` enum('unknown','duplicate','info_change','installation','new_provider','no_longer_needed','nonpayment','private_key','test_order','prod_change','validation') NOT NULL DEFAULT 'unknown',
  `refunded` tinyint(1) NOT NULL DEFAULT 0,
  `server_response` text NOT NULL,
  `temp_hide` tinyint(1) NOT NULL DEFAULT 0,
  `refund_code` varchar(32) NOT NULL DEFAULT '',
  `completed` tinyint(1) NOT NULL DEFAULT 0,
  `delay_revoke` int(11) NOT NULL DEFAULT 0,
  `auth_1_staff` int(11) NOT NULL DEFAULT 0,
  `auth_1_date_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `auth_2_staff` int(11) NOT NULL DEFAULT 0,
  `auth_2_date_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `confirmed_authentic` tinyint(1) NOT NULL DEFAULT 0,
  `stat_row_id` int(11) NOT NULL,
  `serial_number` varchar(64) NOT NULL,
  `type` enum('revoke','cancel') NOT NULL DEFAULT 'revoke',
  `po_id` int(11) DEFAULT NULL,
  `cc_refund_amount` decimal(10,2) DEFAULT NULL,
  `acct_refund_amount` decimal(10,2) DEFAULT NULL,
  `wire_transfer_refund_amount` decimal(10,2) DEFAULT NULL,
  `is_suspicious` tinyint(1) DEFAULT NULL,
  `high_risk_items` varchar(255) DEFAULT NULL,
  `request_received` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `order_id` (`order_id`),
  KEY `stat_row_id` (`stat_row_id`),
  KEY `serial_number` (`serial_number`),
  KEY `date_time` (`date_time`),
  KEY `completed_idx` (`completed`)
) ENGINE=InnoDB AUTO_INCREMENT=2847897 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `risky_contacts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `certificate_request_id` varchar(128) NOT NULL,
  `contact_hash` varchar(32) DEFAULT NULL,
  `firstname` int(10) unsigned NOT NULL,
  `lastname` int(10) unsigned NOT NULL,
  `email` int(10) unsigned NOT NULL,
  `telephone` int(10) unsigned NOT NULL,
  `snooze_until` datetime DEFAULT NULL,
  `status` varchar(32) NOT NULL DEFAULT 'pending',
  `staff_id` int(11) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `date_completed` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_certificate_request_id` (`certificate_request_id`),
  KEY `ix_contact_hash` (`contact_hash`),
  KEY `ix_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `risky_domains` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `public_id` varchar(35) NOT NULL,
  `account_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `risk_score` int(10) DEFAULT NULL,
  `snooze_until` datetime DEFAULT NULL,
  `completed_date` datetime DEFAULT NULL,
  `brand` varchar(256) DEFAULT NULL,
  `locale` varchar(5) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_domain_public_id` (`public_id`(8)),
  KEY `risky_domains_account_id` (`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=125443 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `risky_ou` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `certificate_request_id` varchar(128) DEFAULT NULL,
  `account_id` int(10) unsigned NOT NULL,
  `ou_value` varchar(256) NOT NULL,
  `date_created` datetime NOT NULL,
  `account_name` varchar(255) DEFAULT NULL,
  `organization_name` varchar(255) DEFAULT NULL,
  `reserved_by_staff_id` int(10) unsigned DEFAULT NULL,
  `reserved_date_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_account_value` (`account_id`,`ou_value`(255)),
  KEY `ix_certificate_request_id` (`certificate_request_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1463634 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `risk_history` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(10) unsigned DEFAULT NULL,
  `reissue_id` int(10) unsigned DEFAULT NULL,
  `company_id` int(10) unsigned NOT NULL DEFAULT 0,
  `domain_id` int(10) unsigned NOT NULL DEFAULT 0,
  `risk_score` smallint(5) unsigned DEFAULT NULL,
  `risk_factors` text DEFAULT NULL,
  `date_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `company_id` (`company_id`),
  KEY `domain_id` (`domain_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19402029 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `salesforce_account_watchlist` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `last_touched` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `acct_id` int(6) unsigned zerofill NOT NULL,
  `total_spent_before_mpki` int(11) DEFAULT NULL,
  `total_spent_since_mpki` int(11) DEFAULT NULL,
  `month_to_date_total` int(11) DEFAULT NULL,
  `month_to_date_cert_count` smallint(6) DEFAULT NULL,
  `rejected_from_watchlist` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `sf_account_guid` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `acct_id` (`acct_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1085 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `salesforce_last_upsert_times` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `type` enum('orders','contacts') DEFAULT NULL,
  `record_id` int(11) DEFAULT NULL,
  `upsert_timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `type` (`type`,`record_id`),
  KEY `sflut_record_id` (`record_id`),
  KEY `sflut_up_ts` (`upsert_timestamp`)
) ENGINE=InnoDB AUTO_INCREMENT=907046 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `salesforce_order_leads` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `last_touched` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `order_id` int(10) unsigned NOT NULL,
  `staff_id` smallint(5) unsigned NOT NULL,
  `rejected_by_sales` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `sf_lead_guid` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `sales_acct_notes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `acct_id` int(8) unsigned zerofill DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `context` varchar(25) NOT NULL,
  `note` varchar(255) DEFAULT NULL,
  `staff_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=494 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `sales_stats` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ord_date` datetime NOT NULL,
  `col_date` datetime NOT NULL,
  `units` smallint(6) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `country` varchar(2) NOT NULL,
  `reseller_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `is_renewal` tinyint(1) NOT NULL DEFAULT 0,
  `is_first_order` tinyint(1) NOT NULL DEFAULT 0,
  `order_id` int(8) unsigned zerofill NOT NULL,
  `ent_client_cert_id` int(10) unsigned NOT NULL DEFAULT 0,
  `serversw` smallint(5) NOT NULL,
  `type` enum('revoke','rejection','order','cancel') NOT NULL DEFAULT 'order',
  `origin` enum('retail','enterprise') DEFAULT 'retail',
  `lifetime` tinyint(2) NOT NULL,
  `test_order` tinyint(1) NOT NULL DEFAULT 0,
  `finance_revamp` tinyint(1) NOT NULL DEFAULT 0,
  `col_till` date DEFAULT '0000-00-00',
  `sale_type` enum('po','acct','funny','credit','unknown','bill reseller','ela','wire','subscription','voucher') DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `country` (`country`),
  KEY `reseller_id` (`reseller_id`),
  KEY `is_renewal` (`is_renewal`),
  KEY `units` (`units`),
  KEY `amount` (`amount`),
  KEY `serversw` (`serversw`),
  KEY `type` (`type`),
  KEY `ord_date` (`ord_date`),
  KEY `col_date` (`col_date`),
  KEY `lifetime` (`lifetime`),
  KEY `order_type` (`order_id`,`type`),
  KEY `test_order` (`test_order`),
  KEY `ss_origin` (`origin`),
  KEY `is_first_order` (`is_first_order`),
  KEY `ent_client_cert_id` (`ent_client_cert_id`)
) ENGINE=InnoDB AUTO_INCREMENT=213651751 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `sales_stats_audit` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `stat_row_id` int(10) DEFAULT NULL,
  `staff_id` int(10) NOT NULL,
  `memo` tinytext DEFAULT NULL,
  `modified` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14493 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `saml_assertion_log1` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `saml_response` text NOT NULL,
  `account_id` int(10) unsigned DEFAULT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  `entity_id` varchar(1024) DEFAULT NULL,
  `attributes` text DEFAULT NULL,
  `errors` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_date_created` (`date_created`),
  KEY `ix_account_id` (`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `saml_assertion_log2` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `saml_response` text NOT NULL,
  `account_id` int(10) unsigned DEFAULT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  `entity_id` varchar(1024) DEFAULT NULL,
  `attributes` text DEFAULT NULL,
  `errors` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_date_created` (`date_created`),
  KEY `ix_account_id` (`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4157 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `saml_assertion_log3` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `saml_response` text NOT NULL,
  `account_id` int(10) unsigned DEFAULT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  `entity_id` varchar(1024) DEFAULT NULL,
  `attributes` text DEFAULT NULL,
  `errors` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_date_created` (`date_created`),
  KEY `ix_account_id` (`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4588 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `saml_entity` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` int(10) unsigned NOT NULL,
  `xml_metadata` mediumtext DEFAULT NULL,
  `source_url` varchar(1024) DEFAULT NULL,
  `idp_entity_id` varchar(1024) NOT NULL,
  `idp_signon_url` varchar(1024) NOT NULL,
  `attribute_mapping` varchar(2048) DEFAULT NULL,
  `friendly_name` varchar(64) DEFAULT NULL,
  `friendly_slug` varchar(64) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `last_signon_date` datetime DEFAULT NULL,
  `last_xml_pull_date` datetime DEFAULT NULL,
  `type` varchar(16) DEFAULT NULL,
  `discoverable` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_slug` (`friendly_slug`),
  KEY `ix_account` (`account_id`),
  KEY `ix_type` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=3298 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `saml_entity_certificate` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `saml_entity_id` int(10) unsigned NOT NULL,
  `certificate` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_saml_entity_id` (`saml_entity_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7659 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `saml_guest_request` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `person_id` varchar(64) NOT NULL,
  `account_id` int(10) unsigned NOT NULL,
  `order_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_person_id` (`person_id`),
  KEY `idx_account_id` (`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=239 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `saml_login_token` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `token` varchar(255) NOT NULL,
  `created_date` datetime DEFAULT NULL,
  `expires_date` datetime DEFAULT NULL,
  `is_processed` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `token_UNIQUE` (`token`)
) ENGINE=InnoDB AUTO_INCREMENT=2635 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `seal_info` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Use UNSIGNED MEDIUMINT limits us to 16 million seals to keep us below the hash collision threshold',
  `hash` char(8) DEFAULT NULL COMMENT 'CHAR(8) with our hashing algorithm would have a collision at around 19 million hashes',
  `order_id` int(10) unsigned NOT NULL,
  `created_timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  `seen_on_url` varchar(255) DEFAULT NULL,
  `seen_timestamp` timestamp NULL DEFAULT NULL,
  `seen_with_params` varchar(255) DEFAULT NULL,
  `stored_settings` varchar(255) DEFAULT NULL,
  `organization_logo_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `order_id` (`order_id`),
  UNIQUE KEY `hash` (`hash`),
  KEY `ix_logo_id` (`organization_logo_id`)
) ENGINE=InnoDB AUTO_INCREMENT=179374 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `seal_info_deprecated` (
  `order_id` int(10) unsigned NOT NULL,
  `seen_timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  `seen_on_url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `security_questions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `question` varchar(255) NOT NULL DEFAULT '',
  `status` enum('active','retired') DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `serversw` (
  `id` smallint(5) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) DEFAULT NULL,
  `best_format` varchar(20) DEFAULT NULL,
  `sort_order` tinyint(4) unsigned DEFAULT NULL,
  `install_url` varchar(150) DEFAULT NULL,
  `csr_url` varchar(150) DEFAULT NULL,
  `cert_type` enum('server','code') NOT NULL DEFAULT 'server',
  `requires_new_csr` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `sort_order` (`sort_order`)
) ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `sf_contacts_temp` (
  `acct_id` int(6) unsigned zerofill NOT NULL DEFAULT 000000,
  `watched_id` int(11) unsigned DEFAULT 0,
  `id` int(11) unsigned NOT NULL DEFAULT 0,
  `contact_type` enum('org','tech','bill') DEFAULT NULL,
  `job_title` varchar(64) DEFAULT NULL,
  `firstname` varchar(128) DEFAULT NULL,
  `lastname` varchar(128) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `telephone` varchar(32) DEFAULT NULL,
  `telephone_ext` varchar(16) NOT NULL DEFAULT '',
  `fax` varchar(32) DEFAULT NULL,
  `org_type` tinyint(3) DEFAULT NULL,
  `org_name` varchar(255) DEFAULT NULL,
  `org_unit` varchar(64) DEFAULT NULL,
  `org_addr1` varchar(128) DEFAULT NULL,
  `org_addr2` varchar(128) DEFAULT NULL,
  `org_zip` varchar(40) DEFAULT NULL,
  `org_city` varchar(128) DEFAULT NULL,
  `org_state` varchar(128) DEFAULT NULL,
  `org_country` varchar(2) DEFAULT NULL,
  `org_reg_num` varchar(25) DEFAULT NULL,
  `org_duns_num` varchar(32) DEFAULT NULL,
  `opt_in_news` tinyint(1) NOT NULL DEFAULT 0,
  `usable_org_name` varchar(255) NOT NULL DEFAULT '',
  `timezone` varchar(40) DEFAULT NULL,
  `i18n_language_id` tinyint(4) unsigned DEFAULT 1,
  `last_updated` timestamp NULL DEFAULT NULL,
  `sf_guid` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `acct_id` (`acct_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `sf_orders_temp` (
  `acct_id` int(6) unsigned zerofill NOT NULL DEFAULT 000000,
  `org_name` varchar(255) NOT NULL DEFAULT '',
  `id` int(8) unsigned zerofill NOT NULL,
  `date_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `common_name` varchar(255) NOT NULL DEFAULT '',
  `status` tinyint(4) NOT NULL DEFAULT 1,
  `reason` tinyint(4) NOT NULL DEFAULT 1,
  `lifetime` tinyint(4) NOT NULL DEFAULT 0,
  `product_id` int(11) DEFAULT NULL,
  `is_renewed` tinyint(1) NOT NULL DEFAULT 0,
  `renewed_order_id` int(8) unsigned zerofill NOT NULL DEFAULT 00000000,
  `is_first_order` tinyint(1) NOT NULL DEFAULT 0,
  `valid_till` date NOT NULL DEFAULT '0000-00-00',
  `ca_collect_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `value` decimal(10,2) DEFAULT NULL,
  `sf_guid` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `acct_id` (`acct_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `signing_timestamp_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(8) unsigned zerofill NOT NULL,
  `order_timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=179907 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `siteseallink` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `language` char(5) NOT NULL DEFAULT 'en_US',
  `link` varchar(64) NOT NULL DEFAULT '0',
  `percentage` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `type` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=241 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `siteseallinkproducts` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `type_id` tinyint(3) unsigned DEFAULT NULL,
  `product_id` smallint(5) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `siteseallinktype` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `siteseallinkurl` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `language` char(5) NOT NULL DEFAULT 'en_US',
  `link` varchar(192) NOT NULL DEFAULT '',
  `percentage` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `type` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=133 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `staff` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `firstname` varchar(50) DEFAULT NULL,
  `lastname` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `username` varchar(120) DEFAULT NULL,
  `dotname` varchar(60) DEFAULT NULL,
  `staff_role_id` smallint(6) NOT NULL DEFAULT 200,
  `hashpass` varchar(128) NOT NULL DEFAULT '',
  `newpass` tinyint(4) DEFAULT 1,
  `status` enum('active','inactive','deleted','locked out') DEFAULT 'active',
  `ip_access` text NOT NULL,
  `last_pw_change` date NOT NULL DEFAULT '0000-00-00',
  `failed_attempts` tinyint(1) NOT NULL DEFAULT 0,
  `phone_extension` varchar(4) DEFAULT NULL,
  `staff_direct_phone` varchar(20) DEFAULT NULL,
  `settings` set('timecard_required','prompt_for_time','track_time_daily','track_time_weekly','account_rep','account_dev','account_client_mgr') DEFAULT NULL,
  `photo_file_id` int(10) unsigned DEFAULT NULL,
  `hire_date` date DEFAULT NULL,
  `risk_approval_threshold` smallint(5) NOT NULL DEFAULT 0,
  `queue_status` int(11) DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2526 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `staff_background_info` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `staff_id` int(10) unsigned NOT NULL,
  `token` varchar(128) NOT NULL,
  `provider_name` varchar(255) NOT NULL,
  `provider_email` varchar(255) NOT NULL,
  `provider_employer` varchar(255) NOT NULL,
  `candidate_name` varchar(255) NOT NULL,
  `requested_date` datetime DEFAULT NULL,
  `completed` tinyint(1) DEFAULT 0,
  `completed_date` datetime DEFAULT NULL,
  `hidden` tinyint(1) DEFAULT 0,
  `hidden_date` datetime DEFAULT NULL,
  `datum_provider_role` varchar(255) DEFAULT '',
  `datum_how_long_known` varchar(255) DEFAULT '',
  `datum_employment_dates` varchar(255) DEFAULT '',
  `datum_compensation` varchar(255) DEFAULT '',
  `datum_responsibilities` text DEFAULT NULL,
  `datum_leadership` text DEFAULT NULL,
  `datum_promotion` varchar(255) DEFAULT '',
  `datum_rehire` tinyint(1) DEFAULT NULL,
  `datum_rehire_ex` varchar(255) DEFAULT '',
  `datum_strengths` text DEFAULT NULL,
  `datum_accomplishments` text DEFAULT NULL,
  `datum_rel_coworkers` varchar(255) DEFAULT '',
  `datum_rel_supervisor` varchar(255) DEFAULT '',
  `datum_rel_customers` varchar(255) DEFAULT '',
  `datum_rate_verbal` int(11) DEFAULT NULL,
  `datum_rate_written` int(11) DEFAULT NULL,
  `datum_schedule` varchar(255) DEFAULT '',
  `datum_attendance` varchar(255) DEFAULT '',
  `datum_overtime` varchar(255) DEFAULT '',
  `datum_pressure` varchar(255) DEFAULT '',
  `datum_character` text DEFAULT NULL,
  `datum_misc` text DEFAULT NULL,
  `datum_weaknesses` text DEFAULT NULL,
  `datum_compare_peers` text DEFAULT NULL,
  `datum_recommend` text DEFAULT NULL,
  `datum_work_again` text DEFAULT NULL,
  `datum_sales_v_service` text DEFAULT NULL,
  `datum_presentation` text DEFAULT NULL,
  `datum_deadlines` text DEFAULT NULL,
  `datum_right_v_on_time` text DEFAULT NULL,
  `datum_other` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_bginfo_token` (`token`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `staff_client_certs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `staff_id` int(11) NOT NULL DEFAULT 0,
  `create_date` date NOT NULL DEFAULT '1900-01-01',
  `expiry_date` date NOT NULL DEFAULT '1900-01-01',
  `common_name` varchar(64) NOT NULL DEFAULT '',
  `email` varchar(255) NOT NULL DEFAULT '',
  `org_unit` varchar(128) NOT NULL DEFAULT '',
  `serial_number` varchar(64) NOT NULL DEFAULT '',
  `revoked` tinyint(4) NOT NULL DEFAULT 0,
  `signature_hash` set('unknown','sha1','sha256','sha384','sha512','sha256ecdsa','sha384ecdsa') NOT NULL DEFAULT 'unknown',
  `encrypted_key` mediumtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `staff_id` (`staff_id`),
  KEY `serial_number` (`serial_number`(6))
) ENGINE=InnoDB AUTO_INCREMENT=2388 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `staff_ip_access` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` date DEFAULT '1900-01-01',
  `ip_address` varchar(15) NOT NULL DEFAULT '',
  `ip_address_end` varchar(15) NOT NULL DEFAULT '',
  `description` varchar(255) DEFAULT '',
  `allow_my_docs_polling` tinyint(3) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `staff_otp_cache` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `device_id` int(11) DEFAULT NULL,
  `staff_id` int(11) DEFAULT NULL,
  `otp` varchar(32) DEFAULT NULL,
  `date_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3545929 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `staff_otp_deleted` (
  `id` int(10) unsigned NOT NULL,
  `staff_id` int(11) DEFAULT NULL,
  `device_key` varchar(255) DEFAULT NULL,
  `shared_secret` varchar(255) DEFAULT NULL,
  `device_description` varchar(255) DEFAULT NULL,
  `ctime` datetime DEFAULT NULL,
  `algorithm` enum('motp','oath-hotp') NOT NULL DEFAULT 'motp',
  `failed_attempts` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `staff_otp_devices` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `staff_id` int(11) DEFAULT NULL,
  `device_key` varchar(255) DEFAULT NULL,
  `shared_secret` varchar(255) DEFAULT NULL,
  `device_description` varchar(255) DEFAULT NULL,
  `ctime` datetime DEFAULT NULL,
  `algorithm` enum('motp','oath-hotp') NOT NULL DEFAULT 'motp',
  `failed_attempts` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2117 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `staff_permission_failures` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `staff_id` smallint(6) NOT NULL DEFAULT 0,
  `date_time` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `permission` varchar(255) NOT NULL DEFAULT '',
  `request_uri` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16602 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `staff_permission_import` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `role_name` varchar(255) NOT NULL DEFAULT '',
  `permission` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `staff_permission_snapshots` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `staff_roles_snapshot` mediumtext DEFAULT NULL,
  `staff_permissions_snapshot` mediumtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `date_time_idx` (`date_time`)
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `staff_phone_devices` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_time` datetime DEFAULT NULL,
  `staff_id` int(10) unsigned NOT NULL DEFAULT 0,
  `device_user` varchar(64) NOT NULL DEFAULT '0',
  `device_pass` varchar(128) NOT NULL DEFAULT '0',
  `device_token` varchar(64) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `staff_id` (`staff_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1482 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `staff_pw_changes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `staff_id` int(11) NOT NULL DEFAULT 0,
  `date` date NOT NULL DEFAULT '0000-00-00',
  `hashpass` varchar(128) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6164 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `staff_roles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `role_name` varchar(64) NOT NULL DEFAULT '',
  `department` varchar(64) NOT NULL DEFAULT '',
  `summary` varchar(255) NOT NULL DEFAULT '',
  `base_role_id` smallint(6) NOT NULL DEFAULT 0,
  `is_base_role` tinyint(4) NOT NULL DEFAULT 0,
  `permissions` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=286 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `staff_role_descendant_map` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `staff_role_id` int(10) unsigned NOT NULL,
  `descendant_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=196 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `staff_shift` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `staff_id` int(10) unsigned DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `staff_date_idx` (`staff_id`,`start_date`,`end_date`)
) ENGINE=InnoDB AUTO_INCREMENT=93 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `staff_shift_day` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `shift_id` smallint(5) unsigned DEFAULT NULL,
  `day` tinyint(3) unsigned DEFAULT NULL,
  `start_hour` tinyint(3) unsigned DEFAULT NULL,
  `end_hour` tinyint(3) unsigned DEFAULT NULL,
  `start_min` tinyint(3) unsigned DEFAULT NULL,
  `end_min` tinyint(3) unsigned DEFAULT NULL,
  `extension` varchar(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `shift_id_idx` (`shift_id`)
) ENGINE=InnoDB AUTO_INCREMENT=432 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `staff_tags` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `staff_id` int(11) NOT NULL,
  `tag` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4188 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `standing_approval_invitations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `acct_id` int(11) NOT NULL,
  `email` varchar(128) NOT NULL,
  `org_name` varchar(255) DEFAULT NULL,
  `token` varchar(32) NOT NULL,
  `date_time` datetime DEFAULT NULL,
  `status` enum('active','deleted') NOT NULL DEFAULT 'active',
  `standing_cert_approval_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `standing_cert_approvals` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `acct_id` int(11) NOT NULL,
  `origin` enum('email','phone') DEFAULT NULL,
  `approver_name` varchar(255) NOT NULL DEFAULT '',
  `approver_email` varchar(255) DEFAULT NULL,
  `approver_phone` varchar(255) DEFAULT NULL,
  `approver_ip` varchar(15) NOT NULL DEFAULT '',
  `org_name` varchar(255) DEFAULT NULL,
  `staff_id` int(11) NOT NULL DEFAULT 0,
  `staff_note` text DEFAULT NULL,
  `ctime` datetime DEFAULT NULL,
  `agreement_id` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `statuses` (
  `id` tinyint(4) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `subaccount_invite` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `date_created` datetime DEFAULT NULL,
  `last_sent_date` datetime DEFAULT NULL,
  `date_used` datetime DEFAULT NULL,
  `status` varchar(16) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `parent_account_id` int(10) unsigned zerofill NOT NULL,
  `token` varchar(255) NOT NULL,
  `subaccount_id` int(10) unsigned zerofill DEFAULT NULL,
  `subaccount_type` varchar(64) NOT NULL,
  `invite_note` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_token` (`token`),
  KEY `idx_date_created` (`date_created`)
) ENGINE=InnoDB AUTO_INCREMENT=641 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `subaccount_order_transaction` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(10) unsigned NOT NULL,
  `billed_account_id` int(10) unsigned NOT NULL,
  `account_id` int(10) unsigned NOT NULL,
  `container_id` int(10) unsigned NOT NULL,
  `price` decimal(10,2) DEFAULT 0.00,
  `order_price` decimal(10,2) DEFAULT 0.00,
  `currency` char(3) NOT NULL DEFAULT 'USD',
  `receipt_id` int(10) unsigned DEFAULT 0,
  `acct_adjust_id` int(10) unsigned DEFAULT 0,
  `order_transaction_id` int(10) unsigned DEFAULT 0,
  `transaction_date` datetime DEFAULT current_timestamp(),
  `transaction_type` varchar(32) DEFAULT NULL,
  `balance` decimal(10,2) DEFAULT 0.00,
  PRIMARY KEY (`id`),
  KEY `idx_billed_account_id` (`billed_account_id`),
  KEY `idx_account_id` (`account_id`),
  KEY `idx_container_id` (`container_id`),
  KEY `ix_order_id` (`order_id`),
  KEY `idx_order_transaction_id` (`order_transaction_id`),
  KEY `idx_acct_adjust_id` (`acct_adjust_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16168628 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `subaccount_product_rates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` int(10) unsigned NOT NULL,
  `parent_account_id` int(10) unsigned NOT NULL,
  `product_rates` text NOT NULL,
  `client_cert_rates` text DEFAULT NULL,
  `currency` char(3) NOT NULL DEFAULT 'USD',
  `user_id` int(10) unsigned NOT NULL,
  `date_created` datetime NOT NULL DEFAULT current_timestamp(),
  `last_updated` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_account_id` (`account_id`),
  KEY `ix_parent_account_id` (`parent_account_id`),
  KEY `ix_currency` (`currency`)
) ENGINE=InnoDB AUTO_INCREMENT=143939 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `support_email_random_values` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `date_expired` datetime DEFAULT NULL,
  `date_completed` datetime DEFAULT NULL,
  `organization_id` int(10) unsigned DEFAULT NULL,
  `domain_id` varchar(128) DEFAULT NULL,
  `doc_id` int(10) unsigned DEFAULT NULL,
  `email_address` varchar(255) NOT NULL,
  `staff_id` int(10) unsigned NOT NULL,
  `random_value` varchar(128) NOT NULL,
  `type` varchar(32) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_random_value` (`random_value`) USING HASH
) ENGINE=InnoDB AUTO_INCREMENT=420565 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `symc_order_notes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `symc_order_id` varchar(32) DEFAULT NULL,
  `staff_id` int(10) unsigned NOT NULL DEFAULT 0,
  `date_time` datetime NOT NULL,
  `note` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `date_time` (`date_time`),
  KEY `order_id_idx` (`symc_order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=419446 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `tfa_accounts` (
  `acct_id` int(11) unsigned NOT NULL,
  `last_enabled` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`acct_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `tfa_requirements` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `acct_id` int(8) NOT NULL DEFAULT 0,
  `container_id` int(11) unsigned DEFAULT NULL,
  `auth_type` enum('google_auth','client_cert') CHARACTER SET latin1 NOT NULL DEFAULT 'google_auth',
  `scope_type` enum('account','role','user','container') NOT NULL DEFAULT 'user',
  `scope_container_id` int(11) unsigned DEFAULT NULL,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `role` varchar(20) NOT NULL,
  `date_added` datetime NOT NULL,
  `forced_by_digicert` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `acct_id` (`acct_id`),
  KEY `auth_type` (`auth_type`),
  KEY `scope_type` (`scope_type`),
  KEY `user_id` (`user_id`),
  KEY `role` (`role`),
  KEY `forced_by_digicert` (`forced_by_digicert`)
) ENGINE=InnoDB AUTO_INCREMENT=16499 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `tool_logs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `host` varchar(255) DEFAULT NULL,
  `tool` varchar(25) DEFAULT NULL,
  `time_requested` datetime DEFAULT NULL,
  `ip1` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `ip2` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `ip3` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `ip4` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `data` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `host` (`host`(12),`tool`(2))
) ENGINE=InnoDB AUTO_INCREMENT=1939427 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `ui_stored_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `date_created` timestamp NOT NULL DEFAULT current_timestamp(),
  `date_modified` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `name` varchar(64) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_user_name` (`user_id`,`name`)
) ENGINE=InnoDB AUTO_INCREMENT=109305 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `unborn_orders` (
  `sessionid` varchar(64) NOT NULL,
  `last_hit` datetime DEFAULT NULL,
  `order_data` text DEFAULT NULL,
  PRIMARY KEY (`sessionid`),
  KEY `idx_last_hit` (`last_hit`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `unit_bundles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` int(10) unsigned NOT NULL,
  `contract_id` int(10) unsigned NOT NULL,
  `deal_id` varchar(10) DEFAULT NULL,
  `staff_id` int(10) unsigned NOT NULL,
  `product_id` int(10) unsigned NOT NULL,
  `total_units` decimal(10,2) unsigned DEFAULT 0.00,
  `remaining_units` decimal(10,2) unsigned DEFAULT 0.00,
  `date_time` datetime DEFAULT current_timestamp(),
  `start_date` datetime NOT NULL,
  `end_date` datetime NOT NULL,
  `note` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `account_id` (`account_id`),
  KEY `contract_id` (`contract_id`),
  KEY `product_id` (`product_id`),
  KEY `start_date` (`start_date`),
  KEY `end_date` (`end_date`)
) ENGINE=InnoDB AUTO_INCREMENT=42121 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `unit_order` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `created_date` datetime NOT NULL DEFAULT current_timestamp(),
  `account_id` int(10) unsigned NOT NULL,
  `unit_account_id` int(10) unsigned DEFAULT NULL,
  `unit_contract_id` int(10) unsigned DEFAULT NULL,
  `status` varchar(32) NOT NULL,
  `cost` decimal(10,2) NOT NULL DEFAULT 0.00,
  `expiration_date` date NOT NULL,
  `notes` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_account_id` (`account_id`),
  KEY `idx_unit_account_id` (`unit_account_id`),
  KEY `idx_expiration_date` (`expiration_date`),
  KEY `idx_status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=2235 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `unit_order_bundle` (
  `unit_order_id` int(10) unsigned NOT NULL,
  `product_name_id` varchar(255) NOT NULL,
  `units` int(10) unsigned NOT NULL DEFAULT 0,
  `cost` decimal(10,2) NOT NULL DEFAULT 0.00,
  KEY `idx_unit_order_id` (`unit_order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `unit_order_transaction` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `unit_order_id` int(10) unsigned NOT NULL,
  `account_id` int(10) unsigned NOT NULL,
  `container_id` int(10) unsigned DEFAULT NULL,
  `acct_adjust_id` int(10) unsigned NOT NULL,
  `amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `tax_amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `currency` char(3) NOT NULL DEFAULT 'USD',
  `payment_type` enum('balance') NOT NULL DEFAULT 'balance',
  `transaction_date` datetime NOT NULL DEFAULT current_timestamp(),
  `transaction_type` enum('order','refund') NOT NULL DEFAULT 'order',
  PRIMARY KEY (`id`),
  KEY `idx_account_id` (`account_id`),
  KEY `idx_acct_adjust_id` (`acct_adjust_id`),
  KEY `idx_unit_id` (`unit_order_id`),
  KEY `ix_transaction_date` (`transaction_date`)
) ENGINE=InnoDB AUTO_INCREMENT=1236 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `upgrade_options` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `number` tinyint(4) NOT NULL DEFAULT 0,
  `name` varchar(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `acct_id` int(6) unsigned zerofill NOT NULL DEFAULT 000000,
  `firstname` varchar(128) DEFAULT NULL,
  `lastname` varchar(128) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `username` varchar(64) DEFAULT NULL,
  `job_title` varchar(64) DEFAULT NULL,
  `telephone` varchar(32) DEFAULT NULL,
  `telephone_extension` varchar(32) DEFAULT NULL,
  `hashpass` varchar(128) NOT NULL DEFAULT '',
  `newpass` tinyint(4) DEFAULT 1,
  `opt_in_news` tinyint(1) DEFAULT 0,
  `is_master` tinyint(1) DEFAULT 0,
  `super_access` tinyint(1) NOT NULL DEFAULT 0,
  `reseller_access` tinyint(1) NOT NULL DEFAULT 0,
  `basic_access` tinyint(1) NOT NULL DEFAULT 1,
  `recovery_admin` tinyint(1) NOT NULL DEFAULT 0,
  `status` enum('active','inactive','deleted') NOT NULL DEFAULT 'active',
  `secret_question` int(11) NOT NULL DEFAULT 0,
  `secret_answer` varchar(255) NOT NULL DEFAULT '',
  `first_ip` varchar(15) DEFAULT NULL,
  `ctime` datetime DEFAULT NULL,
  `role` varchar(200) NOT NULL,
  `ent_role` varchar(200) DEFAULT 'limited',
  `ent_unit_id` int(10) unsigned DEFAULT 0,
  `token` varchar(32) DEFAULT NULL,
  `token_time` datetime NOT NULL DEFAULT '1900-00-00 00:00:00',
  `last_verified` datetime DEFAULT '1900-00-00 00:00:00',
  `forgot_block` tinyint(4) NOT NULL DEFAULT 0,
  `consecutive_failed_logins` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `i18n_language_id` tinyint(4) unsigned DEFAULT 1,
  `agent_agreement_id` int(11) NOT NULL,
  `agent_agreement_date` datetime DEFAULT NULL,
  `last_password_change` datetime NOT NULL,
  `account_summary_email_frequency` enum('never','monthly','quarterly') NOT NULL DEFAULT 'never',
  `tfa_phone_number` varchar(40) NOT NULL,
  `is_limited_admin` tinyint(3) NOT NULL DEFAULT 0,
  `container_id` int(10) unsigned DEFAULT NULL,
  `default_payment_profile_id` int(11) DEFAULT 0,
  `last_login_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  KEY `acct_id` (`acct_id`),
  KEY `idx_email` (`email`(12)),
  KEY `token` (`token`(8)),
  KEY `container_id` (`container_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2027503 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `users_requiring_password_reset` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `reason` varchar(64) DEFAULT NULL,
  `date_created` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `ix_user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4103 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `user_company` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `company_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`company_id`),
  KEY `company_id` (`company_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1888631 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `user_contact_info` (
  `user_id` int(10) unsigned NOT NULL,
  `field` varchar(32) NOT NULL,
  `value` varchar(255) NOT NULL,
  KEY `user_id` (`user_id`),
  KEY `field` (`field`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `user_container_assignments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `container_id` int(11) NOT NULL,
  `date_created` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_container_id` (`container_id`)
) ENGINE=InnoDB AUTO_INCREMENT=38624 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `user_ent_units` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `unit_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id_idx` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=57139 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `user_google_auth_cache` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `device_id` int(11) NOT NULL DEFAULT 0,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `otp` varchar(50) NOT NULL,
  `date_time` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `device_id` (`device_id`),
  KEY `otp` (`otp`),
  KEY `date_time` (`date_time`)
) ENGINE=InnoDB AUTO_INCREMENT=471693 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `user_google_auth_devices` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `acct_id` int(8) unsigned NOT NULL DEFAULT 0,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `date_added` datetime NOT NULL,
  `date_last_used` datetime NOT NULL,
  `encrypted_secret_key` varchar(255) NOT NULL,
  `failed_attempts` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `acct_id` (`acct_id`)
) ENGINE=InnoDB AUTO_INCREMENT=29568 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `user_invite` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `date_accepted` datetime DEFAULT NULL,
  `date_processed` datetime DEFAULT NULL,
  `last_sent_date` datetime DEFAULT NULL,
  `status` varchar(16) NOT NULL,
  `invite_key` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `user_id` int(11) NOT NULL,
  `container_id` int(11) NOT NULL,
  `processor_user_id` int(11) DEFAULT NULL,
  `created_user_id` int(11) DEFAULT NULL,
  `requested_firstname` varchar(128) DEFAULT NULL,
  `requested_lastname` varchar(128) DEFAULT NULL,
  `requested_username` varchar(64) DEFAULT NULL,
  `requested_job_title` varchar(128) DEFAULT NULL,
  `requested_telephone` varchar(32) DEFAULT NULL,
  `requested_hashpass` varchar(128) NOT NULL DEFAULT '',
  `requested_secret_question` int(11) DEFAULT NULL,
  `requested_secret_answer` varchar(255) DEFAULT NULL,
  `invite_note` varchar(255) DEFAULT NULL,
  `processor_comment` varchar(255) DEFAULT NULL,
  `is_sso_only` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_user_invites_key` (`invite_key`) USING HASH,
  KEY `ix_container_id_user_id` (`container_id`,`user_id`),
  KEY `user_invite_username` (`requested_username`)
) ENGINE=InnoDB AUTO_INCREMENT=66141628 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `user_tfa_client_certs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `acct_id` int(8) unsigned NOT NULL DEFAULT 0,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `date_added` datetime NOT NULL,
  `date_last_used` datetime NOT NULL,
  `thumbprint` varchar(40) NOT NULL DEFAULT '',
  `expire_date` datetime NOT NULL,
  `issuer_dn` varchar(100) NOT NULL,
  `ca_order_id` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `acct_id` (`acct_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6585 DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `validation_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `sub_of` int(11) NOT NULL DEFAULT 0,
  `ia_qiis` tinyint(1) NOT NULL DEFAULT 1,
  `approved_staff` smallint(2) unsigned NOT NULL DEFAULT 0,
  `approved_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `ia_qiis` (`ia_qiis`)
) ENGINE=InnoDB AUTO_INCREMENT=2291 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `validation_contexts` (
  `item_id` int(11) NOT NULL,
  `context` varchar(40) DEFAULT NULL,
  `sort_order` tinyint(4) DEFAULT NULL,
  KEY `contexts_item_id` (`item_id`),
  KEY `contexts_context` (`context`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `validation_docs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `v_id` int(4) unsigned zerofill NOT NULL DEFAULT 0000,
  `filename` varchar(128) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `v_id` (`v_id`)
) ENGINE=InnoDB AUTO_INCREMENT=322 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `validation_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category` int(11) NOT NULL DEFAULT 0,
  `contexts` varchar(150) NOT NULL DEFAULT '',
  `scope` mediumtext NOT NULL,
  `country` varchar(150) NOT NULL,
  `state` varchar(150) NOT NULL,
  `city` varchar(150) NOT NULL,
  `sort_order` tinyint(4) DEFAULT NULL,
  `title` varchar(255) NOT NULL DEFAULT '',
  `url` varchar(1000) NOT NULL DEFAULT '',
  `email` varchar(255) NOT NULL DEFAULT '',
  `telephone` varchar(64) NOT NULL DEFAULT '',
  `fax` varchar(64) NOT NULL DEFAULT '',
  `snail_mail` text NOT NULL,
  `description` text NOT NULL,
  `ia_qiis` tinyint(1) NOT NULL DEFAULT 1,
  `username` varchar(128) NOT NULL,
  `password` varchar(128) NOT NULL,
  `submitted_staff` smallint(2) unsigned NOT NULL DEFAULT 0,
  `submitted_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `ov_approved_staff_1` smallint(2) unsigned NOT NULL DEFAULT 0,
  `ov_approved_time_1` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `ov_approved_staff_2` smallint(2) unsigned NOT NULL DEFAULT 0,
  `ov_approved_time_2` datetime NOT NULL,
  `ev_approved_staff_1` smallint(2) unsigned NOT NULL DEFAULT 0,
  `ev_approved_time_1` datetime NOT NULL,
  `ev_approved_staff_2` smallint(2) unsigned NOT NULL DEFAULT 0,
  `ev_approved_time_2` datetime NOT NULL,
  `post_params` mediumtext DEFAULT NULL,
  `disable_joi_state_province` tinyint(1) DEFAULT 0,
  `disable_joi_locality` tinyint(1) DEFAULT 0,
  `joi_reg_num_patterns` text DEFAULT NULL,
  `ov_status` varchar(16) NOT NULL DEFAULT 'new',
  `ev_status` varchar(16) NOT NULL DEFAULT 'new',
  `joi_reg_num_regex_vals` text DEFAULT '',
  `enforce_regex_check` tinyint(1) DEFAULT 1,
  `last_disclosed` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `is_disclosed` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `category` (`category`)
) ENGINE=InnoDB AUTO_INCREMENT=17622 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `validation_items_history` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `validation_item_id` int(11) NOT NULL,
  `item_json` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `is_archived` tinyint(1) NOT NULL DEFAULT 0,
  `date_updated` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_validation_item_id` (`validation_item_id`),
  KEY `idx_date_updated` (`date_updated`)
) ENGINE=InnoDB AUTO_INCREMENT=9301 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `validation_item_urls` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `validation_item_id` int(11) NOT NULL,
  `url` varchar(1000) NOT NULL DEFAULT '',
  `date_created` datetime NOT NULL DEFAULT current_timestamp(),
  `last_updated` datetime NOT NULL DEFAULT current_timestamp(),
  `staff_id` int(10) unsigned NOT NULL,
  `is_archived` tinyint(1) NOT NULL DEFAULT 0,
  `archived_reason` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `idx_validation_item_id` (`validation_item_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19283 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `validation_notes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `v_id` int(8) unsigned zerofill DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `note` text DEFAULT NULL,
  `staff_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `v_id` (`v_id`)
) ENGINE=InnoDB AUTO_INCREMENT=124 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `valid_dupe_accts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `acct_id` int(6) unsigned zerofill NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=135 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `verified_contacts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `status` enum('pending','active','inactive') NOT NULL DEFAULT 'pending',
  `user_id` int(10) NOT NULL,
  `company_id` int(11) NOT NULL,
  `acct_id` int(8) NOT NULL DEFAULT 0,
  `firstname` varchar(64) NOT NULL,
  `lastname` varchar(64) NOT NULL,
  `email` varchar(255) NOT NULL,
  `job_title` varchar(64) NOT NULL,
  `telephone` varchar(32) NOT NULL,
  `token` varchar(200) NOT NULL,
  `token_date` datetime DEFAULT NULL,
  `encrypted_data` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `status` (`status`),
  KEY `company_id` (`company_id`),
  KEY `firstname` (`firstname`),
  KEY `lastname` (`lastname`),
  KEY `token` (`token`),
  KEY `acct_id` (`acct_id`)
) ENGINE=InnoDB AUTO_INCREMENT=811131 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `verified_contact_roles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `verified_contact_id` int(11) NOT NULL DEFAULT 0,
  `checklist_role_id` int(11) NOT NULL DEFAULT 0,
  `valid_till_date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `verified_contact_id` (`verified_contact_id`),
  KEY `checklist_role_id` (`checklist_role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3450583 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `virtual_account` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `bank_number` char(4) NOT NULL,
  `branch_number` char(3) NOT NULL,
  `virtual_account_number` char(7) NOT NULL,
  `virtual_account_type` char(1) NOT NULL,
  `account_registration_date` datetime DEFAULT NULL,
  `using_start_date` datetime DEFAULT NULL,
  `account_id` int(10) unsigned DEFAULT NULL,
  `container_id` int(10) unsigned DEFAULT NULL,
  `status` varchar(2) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `staff_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_virtual_account_1` (`account_id`,`container_id`),
  KEY `idx_virtual_account_2` (`bank_number`,`branch_number`,`status`,`update_date`)
) ENGINE=InnoDB AUTO_INCREMENT=100001 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `virtual_account_bank_master` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `bank_number` char(4) NOT NULL,
  `branch_number` char(3) NOT NULL,
  `bank_name` varchar(64) NOT NULL,
  `branch_name` varchar(64) NOT NULL,
  `account_name` varchar(64) NOT NULL,
  `update_date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_virtual_account_bank_master` (`bank_number`,`branch_number`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `virtual_account_history` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `virtual_account_id` int(10) unsigned NOT NULL,
  `bank_number` char(4) NOT NULL,
  `branch_number` char(3) NOT NULL,
  `virtual_account_number` char(7) NOT NULL,
  `virtual_account_type` char(1) NOT NULL,
  `using_start_date` datetime DEFAULT NULL,
  `account_id` int(10) unsigned DEFAULT NULL,
  `container_id` int(10) unsigned DEFAULT NULL,
  `status` varchar(2) NOT NULL,
  `update_date` datetime NOT NULL,
  `staff_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31121 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `virtual_account_release` (
  `virtual_account_id` int(10) unsigned NOT NULL,
  `account_id` int(10) unsigned NOT NULL,
  `update_date` datetime NOT NULL,
  PRIMARY KEY (`virtual_account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `voucher_code` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `voucher_order_id` int(10) unsigned NOT NULL,
  `code` varchar(64) NOT NULL,
  `account_id` int(10) unsigned DEFAULT NULL,
  `product_name_id` varchar(255) NOT NULL,
  `no_of_fqdns` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `no_of_wildcards` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `shipping_method` tinyint(3) unsigned DEFAULT NULL,
  `validity_days` smallint(5) unsigned DEFAULT NULL,
  `validity_years` tinyint(3) unsigned DEFAULT NULL,
  `created_date` datetime NOT NULL DEFAULT current_timestamp(),
  `start_date` date DEFAULT NULL,
  `expiry_date` date DEFAULT NULL,
  `use_san_package` tinyint(1) DEFAULT NULL,
  `status` varchar(32) NOT NULL,
  `group_id` smallint(5) unsigned NOT NULL DEFAULT 1,
  `cost` decimal(10,2) NOT NULL DEFAULT 0.00,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_voucher_code` (`code`),
  KEY `idx_account_id` (`account_id`),
  KEY `idx_status` (`status`),
  KEY `idx_group_id` (`group_id`),
  KEY `idx_vo_id` (`voucher_order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=31617 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `voucher_code_orders` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `voucher_code_id` int(10) unsigned DEFAULT NULL,
  `order_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_order_id` (`order_id`),
  KEY `idx_voucher_code_id` (`voucher_code_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19888 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `voucher_code_reissued` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `voucher_code_id` int(10) unsigned NOT NULL,
  `reissued_code` varchar(64) NOT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  `created_date` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_reissued_code` (`reissued_code`),
  KEY `idx_voucher_code_id` (`voucher_code_id`),
  KEY `idx_user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `voucher_order` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `created_date` datetime NOT NULL DEFAULT current_timestamp(),
  `account_id` int(10) unsigned NOT NULL,
  `status` varchar(32) NOT NULL,
  `cost` decimal(10,2) NOT NULL DEFAULT 0.00,
  `cost_plus_tax` decimal(18,2) NOT NULL DEFAULT 0.00,
  `name` varchar(128) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `expiration_date` date NOT NULL,
  `codes_count` smallint(5) unsigned NOT NULL DEFAULT 0,
  `redeemed_count` smallint(5) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `idx_account_id` (`account_id`),
  KEY `idx_expiration_date` (`expiration_date`)
) ENGINE=InnoDB AUTO_INCREMENT=18162 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `voucher_order_transaction` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `voucher_order_id` int(10) unsigned DEFAULT NULL,
  `account_id` int(10) NOT NULL,
  `container_id` int(10) unsigned DEFAULT NULL,
  `receipt_id` int(10) unsigned DEFAULT NULL,
  `acct_adjust_id` int(10) unsigned DEFAULT NULL,
  `invoice_id` int(10) unsigned DEFAULT 0,
  `amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `currency` char(3) NOT NULL DEFAULT 'USD',
  `payment_type` varchar(50) NOT NULL,
  `transaction_date` datetime NOT NULL DEFAULT current_timestamp(),
  `transaction_type` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_account_id` (`account_id`),
  KEY `idx_acct_ajust_id` (`acct_adjust_id`),
  KEY `idx_receipt_id` (`receipt_id`),
  KEY `idx_vo_id` (`voucher_order_id`),
  KEY `ix_transaction_date` (`transaction_date`),
  KEY `idx_invoice_id` (`invoice_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17688 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `voucher_receipt_tax` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `receipt_id` int(10) unsigned NOT NULL DEFAULT 0,
  `voucher_order_id` int(10) unsigned NOT NULL DEFAULT 0,
  `group_id` smallint(5) unsigned NOT NULL DEFAULT 0,
  `product_id` int(11) NOT NULL DEFAULT 0,
  `quantity` smallint(5) unsigned NOT NULL DEFAULT 0,
  `tax_amount` decimal(18,2) NOT NULL DEFAULT 0.00,
  `gross_amount` decimal(18,2) NOT NULL DEFAULT 0.00,
  PRIMARY KEY (`id`),
  KEY `ix_receipt_id` (`receipt_id`),
  KEY `ix_voucher_order_id` (`voucher_order_id`),
  KEY `ix_group_id` (`group_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1942 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `vt_api_call` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` date DEFAULT NULL,
  `api_count` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=269921 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `vt_report_data` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` varchar(255) DEFAULT NULL,
  `order_status` varchar(255) DEFAULT NULL,
  `report_status` varchar(255) DEFAULT NULL,
  `scan_date` date DEFAULT NULL,
  `serial_number` varchar(255) DEFAULT NULL,
  `file_hashes` varchar(255) DEFAULT NULL,
  `data` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5531 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `vt_report_query` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `query_name` varchar(50) NOT NULL DEFAULT '',
  `query_type` varchar(10) NOT NULL DEFAULT 'POSTAUTH',
  `query_text` text DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `changed_by` varchar(45) DEFAULT NULL,
  `comments` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `weak_keys` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ip` varchar(16) DEFAULT NULL,
  `page` varchar(64) DEFAULT NULL,
  `username` varchar(64) DEFAULT NULL,
  `acct_id` int(11) DEFAULT NULL,
  `csr` text DEFAULT NULL,
  `date_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=199 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `weak_keys_all` (
  `id` int(11) NOT NULL,
  `keysize` smallint(5) unsigned NOT NULL DEFAULT 0,
  `seed` smallint(5) unsigned NOT NULL DEFAULT 0,
  `seed_type` enum('rnd','nornd','noreadrnd','') NOT NULL DEFAULT '',
  `arch` enum('ppc64','i386','x86_64','') NOT NULL DEFAULT '',
  `hash1` int(10) unsigned NOT NULL DEFAULT 0,
  `hash2` int(10) unsigned NOT NULL DEFAULT 0,
  `hash3` int(10) unsigned NOT NULL DEFAULT 0,
  `hash4` int(10) unsigned NOT NULL DEFAULT 0,
  `hash5` int(10) unsigned NOT NULL DEFAULT 0,
  KEY `weak_keys_all_hash1` (`hash1`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `whois_batch` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime DEFAULT NULL,
  `account_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `product_id` int(10) unsigned NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=83 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `whois_cache` (
  `domain` varchar(255) NOT NULL,
  `emails` text DEFAULT NULL,
  `whois_output` text DEFAULT NULL,
  `cache_time` datetime DEFAULT NULL,
  `alexa_rank` int(11) DEFAULT NULL,
  PRIMARY KEY (`domain`),
  KEY `cache_time` (`cache_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `whois_contact` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime DEFAULT NULL,
  `whois_record_id` int(10) unsigned NOT NULL,
  `contact_type` varchar(50) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `address_country` varchar(255) DEFAULT NULL,
  `phone` varchar(30) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `clean_phone` varchar(255) DEFAULT NULL,
  `phone_extension` varchar(255) DEFAULT NULL,
  `raa_type` varchar(255) DEFAULT NULL,
  `se_exists` int(1) DEFAULT NULL,
  `se_allowed_chars` int(1) DEFAULT NULL,
  `se_at_char` int(1) DEFAULT NULL,
  `se_domain` int(1) DEFAULT NULL,
  `se_local` int(1) DEFAULT NULL,
  `se_format` int(1) DEFAULT NULL,
  `se_resolvable` int(1) DEFAULT NULL,
  `se_syn_success` int(1) DEFAULT NULL,
  `se_anomaly_detected` int(1) DEFAULT NULL,
  `oe_valid` int(1) DEFAULT NULL,
  `oe_server` int(1) DEFAULT NULL,
  `st_exists` int(1) DEFAULT NULL,
  `st_cc_present` int(1) DEFAULT NULL,
  `st_cc_format` int(1) DEFAULT NULL,
  `st_not_short` int(1) DEFAULT NULL,
  `st_not_long` int(1) DEFAULT NULL,
  `st_allowed_length` int(1) DEFAULT NULL,
  `st_allowed_chars` int(1) DEFAULT NULL,
  `st_extension_present` int(1) DEFAULT NULL,
  `st_extension_char` int(1) DEFAULT NULL,
  `st_extension_format` int(1) DEFAULT NULL,
  `st_2009_success` int(1) DEFAULT NULL,
  `st_2013_success` int(1) DEFAULT NULL,
  `st_syn_success` int(1) DEFAULT NULL,
  `ot_valid` int(1) DEFAULT NULL,
  `ot_dial_early` int(1) DEFAULT NULL,
  `ot_connected` int(1) DEFAULT NULL,
  `ot_busy` int(1) DEFAULT NULL,
  `ot_disconnected` int(1) DEFAULT NULL,
  `ot_all_circuits` int(1) DEFAULT NULL,
  `ot_invalid` int(1) DEFAULT NULL,
  `ot_success` int(1) DEFAULT NULL,
  `se_2009_success` tinyint(4) DEFAULT NULL,
  `se_2013_success` tinyint(4) DEFAULT NULL,
  `st_prepended_zero` int(1) DEFAULT NULL,
  `early_phone` varchar(50) DEFAULT NULL,
  `st_op_syn_success` int(1) DEFAULT NULL,
  `ot_non_digit_char` int(1) DEFAULT NULL,
  `st_local_zero` int(1) DEFAULT NULL,
  `ot_2009_success` int(1) DEFAULT NULL,
  `ot_2013_success` int(1) DEFAULT NULL,
  `ot_retries` tinyint(4) DEFAULT 0,
  `oe_blocked` tinyint(4) DEFAULT NULL,
  `oe_2009_success` tinyint(4) DEFAULT NULL,
  `oe_2013_success` tinyint(4) DEFAULT NULL,
  `oe_success` tinyint(4) DEFAULT NULL,
  `email_domain_part` varchar(255) DEFAULT NULL,
  `email_local_part` varchar(255) DEFAULT NULL,
  `address_city` varchar(255) DEFAULT NULL,
  `address_state` varchar(255) DEFAULT NULL,
  `address_zip` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_whois_record_id` (`whois_record_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1091470 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `whois_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `doc_id` int(11) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `org_name` varchar(255) DEFAULT NULL,
  `staff_id` int(11) DEFAULT 0,
  `whois_type` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `doc_id` (`doc_id`)
) ENGINE=InnoDB AUTO_INCREMENT=555410 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `whois_record` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime DEFAULT NULL,
  `domain` varchar(255) DEFAULT NULL,
  `batch_id` int(10) unsigned NOT NULL DEFAULT 0,
  `product_id` int(10) unsigned NOT NULL,
  `date_completed` datetime DEFAULT NULL,
  `approved_staff_id` int(10) unsigned DEFAULT NULL,
  `open_date` datetime DEFAULT NULL,
  `open_by_staff_id` int(10) unsigned DEFAULT NULL,
  `original_record` text DEFAULT NULL,
  `whois_date_created` varchar(255) DEFAULT NULL,
  `whois_date_updated` varchar(255) DEFAULT NULL,
  `raa_gfather` int(1) DEFAULT NULL,
  `ot_common` int(1) DEFAULT NULL,
  `oe_duplicates` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `domain` (`domain`(8)),
  KEY `ix_batch_id` (`batch_id`),
  KEY `date_completed` (`date_completed`)
) ENGINE=InnoDB AUTO_INCREMENT=363824 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `wifi_friendlynames` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `language` char(3) NOT NULL,
  `friendlyname` text NOT NULL,
  `encoded_friendlyname` text DEFAULT NULL,
  `verified_contact_id` int(11) NOT NULL,
  `date_created` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=216 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `wip_queue` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `position` bigint(20) DEFAULT NULL,
  `entity_type` varchar(50) NOT NULL,
  `entity_id` int(11) NOT NULL,
  `reissue_id` int(11) DEFAULT NULL,
  `checklist_id` int(11) DEFAULT NULL,
  `priority` tinyint(4) DEFAULT 1,
  `created_date` datetime NOT NULL,
  `sleep_until` datetime DEFAULT NULL,
  `dibs_date` datetime DEFAULT NULL,
  `dibs_staff_id` int(11) DEFAULT NULL,
  `origin` varchar(50) DEFAULT NULL,
  `work_type` varchar(50) DEFAULT NULL,
  `work_status` varchar(50) DEFAULT NULL,
  `product_group` varchar(50) DEFAULT NULL,
  `org_country` varchar(50) DEFAULT NULL,
  `untouched` tinyint(4) DEFAULT 1,
  `parent_reservation_id` int(11) DEFAULT NULL,
  `last_checked` timestamp NULL DEFAULT NULL,
  `BRAND` varchar(25) DEFAULT NULL,
  `timezone` varchar(50) DEFAULT '',
  `premium` tinyint(4) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `idx_priority` (`priority`),
  KEY `idx_entity_id` (`entity_id`),
  KEY `idx_dibs_staff_id` (`dibs_staff_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8773472 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `wip_queue_assignment_definition` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `work_types` varchar(255) DEFAULT NULL,
  `work_statuses` varchar(255) DEFAULT NULL,
  `product_groups` varchar(255) DEFAULT NULL,
  `origins` varchar(255) DEFAULT NULL,
  `org_countries` varchar(255) DEFAULT NULL,
  `brands` varchar(255) DEFAULT NULL,
  `exclude_org_countries` varchar(255) DEFAULT NULL,
  `business_hours_only` tinyint(4) NOT NULL DEFAULT 0,
  `account_ids` varchar(255) DEFAULT NULL,
  `premium` varchar(3) NOT NULL DEFAULT '*',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=328 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `wip_queue_assignment_templates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `assignment_json` text NOT NULL,
  `date_created` datetime NOT NULL,
  `created_by_staff_id` int(10) unsigned DEFAULT NULL,
  `date_last_modified` datetime DEFAULT NULL,
  `last_modified_by_staff_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `wip_queue_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `wip_queue_id` int(11) DEFAULT NULL,
  `staff_id` int(11) DEFAULT NULL,
  `event` varchar(255) DEFAULT NULL,
  `timestamp` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `wip_queue_id` (`wip_queue_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3641487 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `wip_queue_reports` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `staff_id` int(11) DEFAULT NULL,
  `group_by` varchar(255) DEFAULT NULL,
  `sorted_group_by` varchar(255) DEFAULT NULL,
  `chart_type` varchar(255) DEFAULT NULL,
  `include_total` tinyint(4) DEFAULT NULL,
  `filters` text DEFAULT NULL,
  `last_result` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `wip_queue_report_preferences` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `wip_queue_report_id` int(11) NOT NULL,
  `staff_id` int(11) NOT NULL,
  `star` tinyint(4) DEFAULT 0,
  `hide` tinyint(4) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_report_staff` (`wip_queue_report_id`,`staff_id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `wip_queue_staff_assignments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `staff_id` int(11) NOT NULL,
  `wip_queue_assignment_definition_id` int(11) NOT NULL,
  `priority` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=54487 DEFAULT CHARSET=utf8;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

CREATE TABLE IF NOT EXISTS `access_permission` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `name` varchar(255) NOT NULL,
  `scope` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `access_permission_feature_map` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `access_permission_id` int(10) unsigned NOT NULL,
  `feature_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `access_role` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(512) DEFAULT NULL,
  `internal_description` varchar(512) DEFAULT NULL,
  `api_role` tinyint(4) NOT NULL DEFAULT 0,
  `is_admin` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=130584 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `access_role_permission` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `access_role_id` int(10) unsigned NOT NULL,
  `access_permission_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_access_role_id_permission_id` (`access_role_id`,`access_permission_id`)
) ENGINE=InnoDB AUTO_INCREMENT=540 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `access_user_role_map` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `access_role_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_user_id_access_role_id` (`user_id`,`access_role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=768661 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `accounts` (
  `id` int(6) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `type` enum('retail','enterprise','grid','hisp') NOT NULL DEFAULT 'retail',
  `acct_type` tinyint(1) DEFAULT 0,
  `acct_class_id` smallint(5) unsigned DEFAULT 1,
  `acct_status` tinyint(1) DEFAULT 0,
  `is_enterprise` tinyint(1) NOT NULL DEFAULT 0,
  `reseller_id` int(11) NOT NULL DEFAULT 0,
  `primary_company_id` int(11) NOT NULL DEFAULT 0,
  `discount_id` int(5) unsigned zerofill DEFAULT 00000,
  `acct_create_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `allow_trial` tinyint(1) NOT NULL DEFAULT 0,
  `show_addr_on_seal` tinyint(1) NOT NULL DEFAULT 0,
  `renewal_notice_email` varchar(50) NOT NULL DEFAULT '60' COMMENT 'Number of days before the expiration of certificates to send a renewal email',
  `renewal_notice_phone` varchar(50) NOT NULL DEFAULT '30' COMMENT 'Number of days before the expiration of certificates to call to remind about renewal.',
  `vip` tinyint(1) NOT NULL DEFAULT 0,
  `send_minus_104` tinyint(1) DEFAULT 1,
  `send_minus_90` tinyint(1) DEFAULT 1,
  `send_minus_60` tinyint(1) DEFAULT 1,
  `send_minus_30` tinyint(1) DEFAULT 1,
  `send_minus_7` tinyint(1) DEFAULT 1,
  `send_minus_3` tinyint(1) DEFAULT 1,
  `send_plus_7` tinyint(1) DEFAULT 1,
  `make_renewal_calls` tinyint(1) DEFAULT 1,
  `receipt_note` text DEFAULT NULL,
  `cert_format` enum('attachment','plaintext') DEFAULT 'attachment',
  `default_root_path` enum('digicert','entrust','cybertrust') DEFAULT 'digicert',
  `compat_root_path` enum('entrust','cybertrust') NOT NULL DEFAULT 'cybertrust',
  `prefer_global_root` tinyint(4) DEFAULT 1,
  `account_options` set('limit_dcvs','reissue_no_revoke','is_mvp_enabled','no_auto_dcv','hide_subscriber_agreement','ip_locked','dc_guid_allowed','no_collect_email','also_email_unit_members','dont_prefill_deposit_info','allow_cname_dcvs','key_usage_critical_false','po_disabled','no_invoice_email','no_invoice_mail','basic_constraints_critical_false','session_roaming','no_autofill_po_billto','ev_cs_device_locking','default_no_admin_dcvs','dcv_only_show_approvable','force_no_admin_dcvs','_wc_sans','has_limited_admins','ssl_data_encipherment_option','ssl_radius_eku_option','no_auto_invoice','use_org_unit','cloud_retail_api','im_session','restrict_manual_dcvs','no_auto_resend_dcv') DEFAULT NULL,
  `account_tags` varchar(100) DEFAULT '',
  `max_referrals` int(11) NOT NULL DEFAULT 3,
  `acct_death_date` date DEFAULT NULL,
  `gsa` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `max_uc_names` smallint(3) unsigned NOT NULL DEFAULT 0,
  `i18n_language_id` tinyint(4) unsigned DEFAULT 1,
  `namespace_protected` tinyint(4) NOT NULL DEFAULT 0,
  `acct_rep_staff_id` int(10) unsigned DEFAULT 0,
  `dev_staff_id` int(10) unsigned DEFAULT NULL,
  `client_mgr_staff_id` int(10) unsigned DEFAULT NULL,
  `force_password_change_days` smallint(5) unsigned NOT NULL DEFAULT 0,
  `enabled_apis` set('client_cert_api','advanced_api','grid_api','wildcard_api','shopify_api','yahoo_api','simple_api','retail_api','inpriva_api','direct_api','hisp_api','fbca_api','gtld_api') DEFAULT NULL,
  `first_order_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `invoice_notes` text DEFAULT NULL,
  `ssl_ca_cert_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_testing` tinyint(4) NOT NULL DEFAULT 0,
  `balance_negative_limit` int(11) DEFAULT NULL,
  `balance_reminder_threshold` int(11) DEFAULT NULL,
  `cert_transparency` enum('default','on','logonly','ocsp','embed','off') NOT NULL DEFAULT 'embed',
  `use_existing_commission_rate` tinyint(4) NOT NULL DEFAULT 0,
  `partner_user_id` int(11) NOT NULL DEFAULT 0,
  `tfa_enabled` tinyint(4) NOT NULL DEFAULT 0,
  `tfa_show_remember_checkbox` tinyint(4) NOT NULL DEFAULT 0,
  `show_hidden_products` varchar(255) DEFAULT NULL,
  `has_limited_admins` tinyint(3) NOT NULL DEFAULT 0,
  `require_agreement` tinyint(3) NOT NULL DEFAULT 0,
  `agreement_id` int(10) unsigned DEFAULT NULL,
  `agreement_ip` varchar(50) DEFAULT NULL,
  `agreement_user_id` int(10) unsigned DEFAULT NULL,
  `agreement_date` timestamp NULL DEFAULT NULL,
  `express_installer` tinyint(4) DEFAULT 0,
  `is_cert_central` tinyint(4) DEFAULT 0,
  `last_note_date` datetime DEFAULT NULL,
  `display_rep` tinyint(4) DEFAULT 1,
  `acct_origin` set('digi','vz','azr','certcent','venafi','google','marketing') DEFAULT 'digi',
  `lead_source` varchar(255) DEFAULT NULL,
  `zero_balance_email` tinyint(4) DEFAULT 1,
  `test_cert_lifetime` int(11) DEFAULT 3,
  PRIMARY KEY (`id`),
  KEY `accounts_create_date` (`acct_create_date`),
  KEY `accounts_is_enterprise` (`is_enterprise`),
  KEY `accounts_renewal_notice_phone` (`renewal_notice_phone`(5)),
  KEY `reseller` (`id`,`reseller_id`),
  KEY `acct_type` (`acct_type`),
  KEY `primary_company_id` (`primary_company_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1588884 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `account_agreement_audit_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `agreement_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `ip_address` varchar(40) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2301297 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `account_agreement_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `agreement_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `ip_address` varchar(40) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `account_agreement_idx` (`account_id`,`agreement_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2493750 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `account_auth_key` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` int(10) unsigned NOT NULL,
  `auth_key_id` varchar(64) NOT NULL,
  `is_active` tinyint(3) unsigned NOT NULL DEFAULT 1,
  `date_created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_account_id` (`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1717 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `account_ca_map` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `ca_cert_id` int(11) NOT NULL,
  `csr_type` enum('any','rsa','ecc') NOT NULL DEFAULT 'any',
  `signature_hash` enum('any','sha1','sha2-any','sha256','sha384','sha512') NOT NULL DEFAULT 'any',
  PRIMARY KEY (`id`),
  KEY `account_id` (`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=241 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `account_class_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `account_class_id` int(11) NOT NULL,
  `old_account_class_id` int(11) NOT NULL,
  `staff_id` int(11) NOT NULL,
  `change_time` datetime DEFAULT NULL,
  `acct_rep_staff_id` int(11) DEFAULT NULL,
  `old_acct_rep_staff_id` int(11) DEFAULT NULL,
  `dev_staff_id` int(11) DEFAULT NULL,
  `old_dev_staff_id` int(11) DEFAULT NULL,
  `client_mgr_staff_id` int(11) DEFAULT NULL,
  `old_client_mgr_staff_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_account_id` (`account_id`),
  KEY `idx_staff_id` (`staff_id`)
) ENGINE=InnoDB AUTO_INCREMENT=38334 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `account_client_ca_profiles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `acct_id` int(6) unsigned NOT NULL,
  `product_id` int(10) unsigned NOT NULL,
  `cert_template_id` int(10) unsigned NOT NULL,
  `ca_cert_id` smallint(5) unsigned NOT NULL,
  `legacy_ca_cert_id` smallint(5) unsigned NOT NULL,
  `is_private` tinyint(3) unsigned NOT NULL,
  `is_active` tinyint(3) unsigned NOT NULL,
  `is_email_domain_validation_required` tinyint(3) unsigned NOT NULL,
  `is_email_delivery_required` tinyint(3) unsigned NOT NULL,
  `max_lifetime` tinyint(3) unsigned NOT NULL,
  `internal_description` varchar(255) DEFAULT NULL,
  `display_sort_id` smallint(6) NOT NULL DEFAULT 0,
  `api_id` varchar(255) DEFAULT NULL,
  `container_id` int(10) unsigned DEFAULT NULL,
  `api_group_name` varchar(45) DEFAULT NULL,
  `unique_common_name_required` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `ascii_sanitize_request` tinyint(3) DEFAULT 0,
  `api_delivery_only` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `allow_sans` tinyint(3) unsigned DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `api_id_UNIQUE` (`api_id`),
  KEY `acct_id` (`acct_id`),
  KEY `cert_template_id` (`cert_template_id`)
) ENGINE=InnoDB AUTO_INCREMENT=260 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `account_commission_rates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `acct_id` int(10) unsigned DEFAULT NULL,
  `commission_id` int(10) unsigned DEFAULT NULL,
  `date_started` date DEFAULT NULL,
  `date_ended` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12514 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `account_descendant_map` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int(10) unsigned NOT NULL,
  `child_id` int(10) unsigned NOT NULL,
  `child_account_level` int(10) unsigned NOT NULL DEFAULT 1,
  `managed_by_user_id` int(10) unsigned DEFAULT NULL,
  `child_name` varchar(64) DEFAULT NULL,
  `hidden` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_parent_id_child_id` (`parent_id`,`child_id`),
  UNIQUE KEY `ix_child_id_parent_id` (`child_id`,`parent_id`),
  KEY `ix_account_level` (`child_account_level`),
  KEY `ix_account_manager` (`managed_by_user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=32689 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `account_discount_rate_expirations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL DEFAULT 0,
  `discount_id` int(11) NOT NULL DEFAULT 0,
  `expiration_date` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_account_id` (`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=34343 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `account_funds` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` int(10) unsigned NOT NULL,
  `container_id` int(10) unsigned NOT NULL,
  `acct_adjust_id` int(10) unsigned NOT NULL,
  `created` datetime NOT NULL DEFAULT current_timestamp(),
  `expiration` datetime NOT NULL DEFAULT current_timestamp(),
  `started` datetime DEFAULT NULL,
  `amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `balance` decimal(10,2) NOT NULL DEFAULT 0.00,
  `status` enum('active','consumed','expired') NOT NULL DEFAULT 'active',
  PRIMARY KEY (`id`),
  KEY `idx_account_id` (`account_id`),
  KEY `idx_container_id` (`container_id`),
  KEY `idx_status` (`status`),
  KEY `idx_expiration` (`expiration`),
  KEY `idx_acct_adjust_id` (`acct_adjust_id`)
) ENGINE=InnoDB AUTO_INCREMENT=124870 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `account_funds_expiry_notices` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `account_funds_id` int(10) unsigned NOT NULL,
  `minus_0_sent` tinyint(1) NOT NULL DEFAULT 0,
  `minus_3_sent` tinyint(1) NOT NULL DEFAULT 0,
  `minus_7_sent` tinyint(1) NOT NULL DEFAULT 0,
  `minus_14_sent` tinyint(1) NOT NULL DEFAULT 0,
  `minus_30_sent` tinyint(1) NOT NULL DEFAULT 0,
  `minus_60_sent` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_account_funds_id` (`account_funds_id`),
  KEY `idx_minus_0_sent` (`minus_0_sent`),
  KEY `idx_minus_3_sent` (`minus_3_sent`),
  KEY `idx_minus_7_sent` (`minus_7_sent`),
  KEY `idx_minus_14_sent` (`minus_14_sent`),
  KEY `idx_minus_30_sent` (`minus_30_sent`),
  KEY `idx_minus_60_sent` (`minus_60_sent`)
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `account_modification` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(40) NOT NULL DEFAULT '',
  `description` varchar(100) DEFAULT NULL,
  `configuration` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `account_origin_cookies` (
  `acct_id` int(6) unsigned zerofill NOT NULL,
  `utmv` varchar(255) DEFAULT NULL,
  `initial_page` varchar(255) DEFAULT NULL COMMENT 'The url for the landing page.',
  `referer` varchar(255) DEFAULT NULL COMMENT 'The url that referred the user to the landing page.',
  `search_term` varchar(100) DEFAULT NULL,
  `query_string` varchar(100) DEFAULT NULL,
  `date_recorded` datetime DEFAULT NULL,
  `medium` varchar(64) DEFAULT NULL,
  `source` varchar(64) DEFAULT NULL,
  `campaign` varchar(64) DEFAULT NULL,
  `date_landed` datetime DEFAULT NULL COMMENT 'The date the landing page was hit.',
  `ip` varchar(45) DEFAULT NULL COMMENT 'The IP address of the user who created the account. IPv4 (15 chars), IPv6 (39 chars) IPv6 notation for IPv4 (45 chars)',
  PRIMARY KEY (`acct_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `account_ou_cert_request_map` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` int(10) unsigned NOT NULL,
  `ou_value` varchar(255) NOT NULL,
  `certificate_request_id` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_account_ou_cert_request` (`account_id`,`ou_value`,`certificate_request_id`),
  KEY `ix_ou_value` (`ou_value`)
) ENGINE=InnoDB AUTO_INCREMENT=644336 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `account_private_ca_certs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `acct_id` int(6) unsigned NOT NULL,
  `ca_cert_id` smallint(5) unsigned NOT NULL,
  `container_id` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `acct_ca_cert_id` (`acct_id`,`ca_cert_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2243 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `account_product_map` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `product_name_id` varchar(64) NOT NULL,
  `require_tos` tinyint(4) NOT NULL DEFAULT 1,
  `date_created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_account_product` (`account_id`,`product_name_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15817743 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `account_reseller_info` (
  `acct_id` int(6) unsigned zerofill NOT NULL DEFAULT 000000,
  `max_partner_discount` tinyint(3) unsigned NOT NULL DEFAULT 10,
  `existing_customer_commission_rate` tinyint(3) unsigned NOT NULL DEFAULT 10,
  `commission_id` int(5) unsigned NOT NULL DEFAULT 0,
  `incentive_plan` tinyint(4) NOT NULL DEFAULT 0,
  `flag` tinyint(2) NOT NULL DEFAULT 0,
  `rsl_effective_date` date NOT NULL DEFAULT '0000-00-00',
  `rsl_cancel_date` date NOT NULL DEFAULT '0000-00-00',
  `rsl_cancel_reason` text NOT NULL,
  `rsl_reject_reason` text NOT NULL,
  `rsl_agreement_id` int(10) unsigned NOT NULL DEFAULT 0,
  `rsl_apply_date` date NOT NULL DEFAULT '0000-00-00',
  `rsl_pay_type` enum('acct_credit','check') NOT NULL DEFAULT 'acct_credit',
  `allowed_products` varchar(255) NOT NULL,
  `domain` varchar(255) DEFAULT NULL,
  `company_type_id` tinyint(3) unsigned DEFAULT NULL,
  `company_type_other` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`acct_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `account_settings` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL DEFAULT current_timestamp(),
  `account_id` int(10) unsigned NOT NULL,
  `name` varchar(64) NOT NULL,
  `value` text DEFAULT NULL,
  `read_only` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_account_id_name` (`account_id`,`name`),
  KEY `idx_name` (`name`(11))
) ENGINE=InnoDB AUTO_INCREMENT=1200387 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `acct_adjust` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `acct_id` int(6) unsigned zerofill NOT NULL DEFAULT 000000,
  `unit_id` int(11) unsigned NOT NULL DEFAULT 0,
  `order_id` int(8) unsigned zerofill NOT NULL DEFAULT 00000000,
  `ent_client_cert_id` int(10) NOT NULL DEFAULT 0,
  `adjust_type` tinyint(3) DEFAULT NULL,
  `amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `staff_id` int(10) NOT NULL DEFAULT 0,
  `note` mediumtext DEFAULT NULL,
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `balance_after` decimal(10,2) NOT NULL DEFAULT 0.00,
  `balance_breakdown` mediumtext DEFAULT NULL,
  `receipt_id` int(10) NOT NULL DEFAULT 0,
  `confirmed` tinyint(1) NOT NULL DEFAULT 1,
  `confirmed_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `confirmed_staff` int(10) NOT NULL DEFAULT 5,
  `prev_type` tinyint(3) DEFAULT NULL,
  `confirm_note` mediumtext DEFAULT NULL,
  `po_id` int(10) unsigned DEFAULT NULL,
  `container_id` int(10) unsigned DEFAULT NULL,
  `netsuite_invoice_id` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `acct_id` (`acct_id`),
  KEY `receipt_id` (`receipt_id`),
  KEY `unit_id` (`unit_id`),
  KEY `idx_order_id` (`order_id`),
  KEY `idx_container_id` (`container_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4578949 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `acct_classes` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `tier` enum('Retail Accounts','Managed Accounts') DEFAULT 'Retail Accounts',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `acct_docs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `acct_id` int(6) unsigned zerofill NOT NULL DEFAULT 000000,
  `filename` varchar(128) NOT NULL DEFAULT '',
  `upload_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `status` tinyint(3) NOT NULL DEFAULT 1,
  `notes` varchar(255) NOT NULL DEFAULT '',
  `is_new` tinyint(1) NOT NULL DEFAULT 1,
  `type` varchar(30) NOT NULL DEFAULT 'agreement',
  `staff_id` int(11) NOT NULL DEFAULT 0,
  `contract_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `acct_docs_a_id_idx` (`acct_id`)
) ENGINE=InnoDB AUTO_INCREMENT=42109 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `acct_flags` (
  `id` tinyint(1) NOT NULL AUTO_INCREMENT,
  `number` tinyint(1) NOT NULL DEFAULT 0,
  `color` varchar(16) NOT NULL DEFAULT '',
  `description` varchar(128) NOT NULL DEFAULT '',
  `color_code` varchar(7) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `acct_notes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `acct_id` int(8) unsigned zerofill DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `note` text DEFAULT NULL,
  `staff_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `acct_id` (`acct_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14205 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `acct_statuses` (
  `id` tinyint(3) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `acct_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` mediumtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `acct_units_adjust` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` int(10) unsigned NOT NULL,
  `contract_id` int(10) unsigned NOT NULL,
  `unit_bundle_id` int(11) DEFAULT NULL,
  `product_id` int(10) unsigned NOT NULL,
  `order_id` int(10) unsigned NOT NULL,
  `cert_tracker_id` int(10) unsigned DEFAULT NULL,
  `adjust_type` int(10) unsigned NOT NULL,
  `amount` decimal(10,2) DEFAULT 0.00,
  `server_license` int(10) unsigned NOT NULL,
  `staff_id` int(10) unsigned NOT NULL,
  `note` text DEFAULT NULL,
  `created` datetime NOT NULL DEFAULT current_timestamp(),
  `balance_after` decimal(10,2) DEFAULT 0.00,
  `container_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_account_id` (`account_id`),
  KEY `ix_product_id` (`product_id`),
  KEY `ix_order_id` (`order_id`),
  KEY `ix_contract_id` (`contract_id`),
  KEY `ix_unit_bundle_id` (`unit_bundle_id`)
) ENGINE=InnoDB AUTO_INCREMENT=475380 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `acme_api_keys` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `api_permission_id` int(10) unsigned NOT NULL,
  `url_mask` varchar(10) DEFAULT NULL,
  `organization_id` int(10) NOT NULL,
  `product_name_id` varchar(64) NOT NULL,
  `validity_days` int(10) unsigned DEFAULT NULL,
  `validity_years` int(10) unsigned DEFAULT NULL,
  `ssl_profile_option` varchar(32) DEFAULT NULL,
  `container_id` int(10) unsigned DEFAULT NULL,
  `eab_kid` varchar(255) DEFAULT NULL,
  `eab_hmac` varchar(255) DEFAULT NULL,
  `ca_cert_id` varchar(255) DEFAULT NULL,
  `order_validity_days` int(11) DEFAULT NULL,
  `order_validity_years` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_api_permission_id` (`api_permission_id`) USING HASH,
  KEY `ix_container_id` (`container_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4413 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `acme_metadata` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `acme_api_key_id` int(10) unsigned NOT NULL,
  `metadata_id` int(10) unsigned NOT NULL,
  `value` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_acme_api_key_metadata` (`acme_api_key_id`,`metadata_id`)
) ENGINE=InnoDB AUTO_INCREMENT=766 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `additional_order_info` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(10) unsigned NOT NULL,
  `option_name` enum('server_licenses','legacy_product_name','symc_order_id','san_packages','voucher_id','va_status','guest_access') COLLATE utf8mb4_bin NOT NULL,
  `option_value_str` text COLLATE utf8mb4_bin NOT NULL,
  `option_value_int` int(11) unsigned DEFAULT NULL,
  `date_created` datetime NOT NULL DEFAULT current_timestamp(),
  `last_updated` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_order_id_option_name` (`order_id`,`option_name`),
  KEY `ix_order_id` (`order_id`),
  KEY `ix_option_name` (`option_name`),
  KEY `ix_option_value_int` (`option_value_int`)
) ENGINE=InnoDB AUTO_INCREMENT=9198282 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='Order Options Table. One to Many on order_id';

CREATE TABLE IF NOT EXISTS `adjust_types` (
  `id` tinyint(3) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL DEFAULT '',
  `description` varchar(255) NOT NULL DEFAULT '',
  `admin_only` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `agreements` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(50) NOT NULL DEFAULT 'normal_subscriber',
  `acct_id` int(11) NOT NULL DEFAULT 0,
  `effective_date` datetime NOT NULL,
  `end_date` datetime DEFAULT NULL,
  `condition` varchar(50) NOT NULL,
  `text` text NOT NULL,
  `text_es` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `alert` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `account_id` int(11) NOT NULL DEFAULT 0,
  `category` varchar(64) NOT NULL,
  `message` text NOT NULL,
  `start_date` datetime NOT NULL,
  `expiration_date` datetime NOT NULL,
  `display_filters` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_account_id` (`account_id`),
  KEY `idx_expiration_date` (`expiration_date`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `alert_dismissal` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `alert_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_alert_id` (`alert_id`),
  KEY `idx_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `allowed_saml_products` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_name_id` varchar(255) NOT NULL,
  `date_created` datetime NOT NULL,
  `account_id` int(11) DEFAULT NULL,
  `allowed_lifetimes` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `product_name_id_UNIQUE` (`product_name_id`,`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1064 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `api_calls` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `acct_id` int(6) unsigned zerofill NOT NULL DEFAULT 000000,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `action` varchar(32) DEFAULT NULL,
  `ip_address` varchar(15) NOT NULL DEFAULT '',
  `date_time` datetime DEFAULT NULL,
  `data` mediumtext DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=338779 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `api_call_log` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` int(11) unsigned NOT NULL,
  `user_id` int(11) unsigned NOT NULL,
  `api` enum('REST') NOT NULL DEFAULT 'REST',
  `api_key` varchar(255) DEFAULT NULL,
  `remote_ip` int(10) unsigned NOT NULL,
  `call_time` datetime NOT NULL,
  `duration` float(6,2) DEFAULT NULL,
  `method` varchar(15) NOT NULL DEFAULT 'GET',
  `request_url` varchar(125) NOT NULL DEFAULT '',
  `request_headers` text DEFAULT NULL,
  `request_body` text DEFAULT NULL,
  `response_code` int(3) NOT NULL,
  `response_headers` text DEFAULT NULL,
  `response_body` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `acl_account_id` (`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4067969 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `api_log_cc_v2` (
  `hash_id` bigint(20) unsigned NOT NULL,
  `transaction_date` date NOT NULL DEFAULT '0000-00-00',
  `controller` varchar(255) DEFAULT NULL,
  `methods` varchar(16) NOT NULL DEFAULT '',
  `route` varchar(192) NOT NULL DEFAULT '',
  `content_type` varchar(64) NOT NULL DEFAULT '',
  `transaction_count` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`hash_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `api_permissions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `acct_id` int(6) unsigned zerofill NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `hashed_api_key` varchar(255) NOT NULL DEFAULT '',
  `create_date` datetime DEFAULT NULL,
  `last_used_date` datetime DEFAULT NULL,
  `name` varchar(200) DEFAULT NULL,
  `status` enum('active','revoked') DEFAULT 'active',
  `external_id` varchar(255) DEFAULT NULL,
  `key_type` enum('permanent','temporary','acme') NOT NULL DEFAULT 'permanent',
  `validity_minutes` int(11) NOT NULL DEFAULT 0,
  `access_role_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `external_id_UNIQUE` (`external_id`),
  KEY `acct_id` (`acct_id`),
  KEY `user_id` (`user_id`),
  KEY `idx_key_type` (`key_type`) USING HASH
) ENGINE=InnoDB AUTO_INCREMENT=1336655 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `api_permissions_old` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `acct_id` int(6) unsigned zerofill NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `hashed_api_key` varchar(255) NOT NULL DEFAULT '',
  `create_date` datetime DEFAULT NULL,
  `last_used_date` datetime DEFAULT NULL,
  `name` varchar(200) DEFAULT NULL,
  `status` enum('active','revoked') DEFAULT 'active',
  `external_id` varchar(255) DEFAULT NULL,
  `key_type` enum('permanent','temporary','acme') NOT NULL DEFAULT 'permanent',
  `validity_minutes` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `external_id_UNIQUE` (`external_id`),
  KEY `acct_id` (`acct_id`),
  KEY `user_id` (`user_id`),
  KEY `idx_key_type` (`key_type`) USING HASH
) ENGINE=InnoDB AUTO_INCREMENT=1206096 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `audit_bad_address_orders` (
  `order_id` int(10) unsigned NOT NULL,
  `status` varchar(16) NOT NULL DEFAULT 'new',
  `revoked` tinyint(4) NOT NULL DEFAULT 0,
  `reissued` tinyint(4) NOT NULL DEFAULT 0,
  `address_fixed` tinyint(4) NOT NULL DEFAULT 0,
  `prevalidation_expired` tinyint(4) NOT NULL DEFAULT 0,
  `needs_revoke` varchar(16) DEFAULT NULL,
  `batch_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `bad_internal_names` (
  `order_id` int(10) unsigned DEFAULT NULL,
  `last_checked_order` int(10) unsigned DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `blacklisted_domains` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `domain_blacklist_id` int(11) unsigned NOT NULL,
  `match_type` enum('base_domain','extracted_base_domain') NOT NULL,
  `indexed_domain` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `domain_blacklist_id` (`domain_blacklist_id`),
  KEY `indexed_domain` (`indexed_domain`(8))
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `blacklist_cache_dates` (
  `blacklist_name` varchar(100) NOT NULL,
  `date_last_cached` datetime DEFAULT NULL,
  PRIMARY KEY (`blacklist_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `blacklist_consolidated` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `source` varchar(128) NOT NULL,
  `type` varchar(16) NOT NULL DEFAULT '',
  `name` varchar(512) NOT NULL,
  `slim_name` varchar(512) NOT NULL,
  `country_code` varchar(2) NOT NULL DEFAULT '',
  `is_aka` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `ix_slim_name` (`slim_name`(255))
) ENGINE=InnoDB AUTO_INCREMENT=29394 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `blacklist_denied_persons` (
  `name` varchar(255) NOT NULL,
  `slim_name` varchar(255) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `country` char(2) NOT NULL,
  `postal_code` varchar(50) DEFAULT NULL,
  KEY `name` (`name`),
  KEY `country` (`country`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `blacklist_ecfr_orgs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `country` varchar(255) DEFAULT NULL,
  `org_name` text DEFAULT NULL,
  `slim_name` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1611 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `blacklist_ip` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ip` varchar(15) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `blacklist_millersmiles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `date_reported` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_name` (`name`(10))
) ENGINE=InnoDB AUTO_INCREMENT=441904 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `blacklist_phishtank` (
  `phish_id` int(10) DEFAULT NULL,
  `url` text DEFAULT NULL,
  `phish_detail_url` text DEFAULT NULL,
  `submission_time` datetime DEFAULT NULL,
  `verified` tinyint(4) DEFAULT NULL,
  `verification_time` datetime DEFAULT NULL,
  `online` tinyint(4) DEFAULT NULL,
  `target` text DEFAULT NULL,
  `target_slim_name` varchar(200) DEFAULT NULL,
  `base_domain` text DEFAULT NULL,
  KEY `target_slim_name` (`target_slim_name`(12)),
  KEY `base_domain` (`base_domain`(12))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `blacklist_sdn_akas` (
  `id` int(10) unsigned NOT NULL,
  `person_id` int(10) unsigned DEFAULT NULL,
  `aka` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_aka` (`aka`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `blacklist_sdn_orgs` (
  `id` int(10) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `blacklist_sdn_org_akas` (
  `id` int(10) unsigned NOT NULL,
  `person_id` int(10) unsigned DEFAULT NULL,
  `aka` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_aka` (`aka`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `blacklist_sdn_persons` (
  `id` int(10) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `boomi_account_updates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` int(10) unsigned NOT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_account_id` (`account_id`),
  KEY `idx_date_updates` (`date_updated`)
) ENGINE=InnoDB AUTO_INCREMENT=90680 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `boomi_po_updates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `po_id` int(10) unsigned NOT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_po_id` (`po_id`),
  KEY `idx_date_updates` (`date_updated`)
) ENGINE=InnoDB AUTO_INCREMENT=166500 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `canned_notes` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ordering` int(11) NOT NULL DEFAULT 0,
  `category` varchar(50) NOT NULL DEFAULT '',
  `text` varchar(255) NOT NULL DEFAULT '',
  `date_updated` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  `date_deleted` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `case_notes` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` timestamp NOT NULL DEFAULT current_timestamp(),
  `order_id` int(11) unsigned NOT NULL,
  `staff_id` int(11) unsigned NOT NULL,
  `order_action_requested` tinyint(3) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=26966 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `case_note_canned_notes` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `case_note_id` int(11) unsigned NOT NULL,
  `canned_note_id` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=40538 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `ca_calls` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `call_type` varchar(255) NOT NULL DEFAULT '',
  `common_name` varchar(255) NOT NULL DEFAULT '',
  `date_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `order_id` int(8) NOT NULL DEFAULT 0,
  `data` mediumtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `ca_calls_air_gap` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(8) unsigned zerofill NOT NULL DEFAULT 00000000,
  `reissue_id` int(11) NOT NULL DEFAULT 0,
  `duplicate_id` int(11) NOT NULL DEFAULT 0,
  `ent_client_cert_id` int(11) NOT NULL DEFAULT 0,
  `call_type` varchar(255) NOT NULL DEFAULT '',
  `common_name` varchar(255) NOT NULL DEFAULT '',
  `date_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `request_data` mediumtext NOT NULL,
  `response_data` mediumtext NOT NULL,
  `request_id` varchar(50) NOT NULL DEFAULT '0',
  `downloaded_date_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `uploaded_date_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `completed_date_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `ca_cert_info` (
  `ca_cert_id` smallint(5) unsigned NOT NULL,
  `subject_common_name` varchar(255) NOT NULL,
  `subject_org_name` varchar(255) NOT NULL,
  `issuer_common_name` varchar(255) NOT NULL,
  `valid_from` varchar(19) NOT NULL DEFAULT '',
  `valid_to` varchar(19) NOT NULL DEFAULT '',
  `serial_number` varchar(64) NOT NULL,
  `thumbprint` char(40) NOT NULL,
  `signature_hash` varchar(64) NOT NULL,
  `is_private` tinyint(3) unsigned NOT NULL,
  `is_root` tinyint(3) unsigned NOT NULL,
  `issuer_ca_cert_id` smallint(5) unsigned NOT NULL,
  `pem` text NOT NULL,
  `external_id` varchar(40) NOT NULL DEFAULT '',
  `flags` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`ca_cert_id`),
  UNIQUE KEY `serial_number_UNIQUE` (`serial_number`),
  UNIQUE KEY `thumbprint_UNIQUE` (`thumbprint`),
  KEY `flags` (`flags`(12))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `ca_cert_templates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `ca_template_data` text DEFAULT NULL,
  `ui_template_data` text DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `is_key_escrow` tinyint(3) unsigned NOT NULL,
  `private_only` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `ca_intermediates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `thumbprint` varchar(128) NOT NULL DEFAULT '',
  `common_name` varchar(100) NOT NULL DEFAULT '',
  `pem` mediumtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `thumbprint` (`thumbprint`)
) ENGINE=InnoDB AUTO_INCREMENT=1153 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `ca_issued_certs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(8) unsigned zerofill NOT NULL DEFAULT 00000000,
  `reissue_id` int(11) NOT NULL DEFAULT 0,
  `duplicate_id` int(11) NOT NULL DEFAULT 0,
  `ent_client_cert_id` int(11) NOT NULL DEFAULT 0,
  `ctime` timestamp NOT NULL DEFAULT current_timestamp(),
  `common_name` varchar(128) NOT NULL DEFAULT '',
  `valid_from` date NOT NULL DEFAULT '0000-00-00',
  `valid_till` date NOT NULL DEFAULT '0000-00-00',
  `keysize` int(11) NOT NULL DEFAULT 0,
  `serial_number` varchar(36) NOT NULL DEFAULT '',
  `thumbprint` varchar(42) NOT NULL DEFAULT '',
  `ca_order_id` varchar(20) NOT NULL DEFAULT '',
  `sans` text NOT NULL,
  `chain` varchar(32) DEFAULT NULL,
  `pem` mediumtext DEFAULT NULL,
  `ca_cert_id` smallint(6) NOT NULL DEFAULT 0,
  `last_seen` date NOT NULL DEFAULT '1900-01-01',
  `last_seen_ocsp` date NOT NULL DEFAULT '1900-01-01',
  `key_type` enum('ecc','rsa','dsa','dh','') NOT NULL DEFAULT '',
  `sig` enum('','sha1WithRSAEncryption','sha224WithRSAEncryption','sha256WithRSAEncryption','sha384WithRSAEncryption','sha512WithRSAEncryption','sha384ECDSA','sha256ECDSA') NOT NULL DEFAULT '',
  `revoked` tinyint(3) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `ent_client_cert_id` (`ent_client_cert_id`),
  KEY `thumbprint` (`thumbprint`(8)),
  KEY `serial_number` (`serial_number`(8)),
  KEY `ca_order_id` (`ca_order_id`(8)),
  KEY `_idx_valid_till` (`valid_till`),
  KEY `_idx_ctime` (`ctime`)
) ENGINE=InnoDB AUTO_INCREMENT=28029363 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `certcentral_conversion_data_cache` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` int(10) unsigned NOT NULL,
  `account_name` varchar(256) DEFAULT NULL,
  `master_user_email` varchar(256) DEFAULT NULL,
  `master_user_firstname` varchar(64) DEFAULT NULL,
  `master_user_lastname` varchar(64) DEFAULT NULL,
  `account_rep` varchar(64) DEFAULT NULL,
  `account_manager` varchar(64) DEFAULT NULL,
  `conversion_blockers` varchar(1024) DEFAULT NULL,
  `conversion_warnings` varchar(1024) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `active_orders` int(10) unsigned NOT NULL DEFAULT 0,
  `active_client_certs` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_account_id` (`account_id`),
  KEY `idx_date_created` (`date_created`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `certificate_notes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `certificate_tracker_id` int(11) NOT NULL,
  `text` text DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_certificate_tracker_id` (`certificate_tracker_id`)
) ENGINE=InnoDB AUTO_INCREMENT=978986 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `certificate_reissue_notices` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `certificate_tracker_id` int(10) unsigned NOT NULL,
  `minus_90_sent` tinyint(1) NOT NULL DEFAULT 0,
  `minus_60_sent` tinyint(1) NOT NULL DEFAULT 0,
  `minus_30_sent` tinyint(1) NOT NULL DEFAULT 0,
  `minus_7_sent` tinyint(1) NOT NULL DEFAULT 0,
  `minus_3_sent` tinyint(1) NOT NULL DEFAULT 0,
  `plus_7_sent` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `certificate_tracker_id` (`certificate_tracker_id`),
  KEY `minus_90_sent` (`minus_90_sent`),
  KEY `minus_60_sent` (`minus_60_sent`),
  KEY `minus_30_sent` (`minus_30_sent`),
  KEY `minus_7_sent` (`minus_7_sent`),
  KEY `minus_3_sent` (`minus_3_sent`),
  KEY `plus_7_sent` (`plus_7_sent`)
) ENGINE=InnoDB AUTO_INCREMENT=13820 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `certificate_tracker` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `type` tinyint(3) unsigned NOT NULL,
  `public_id` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_public_id` (`public_id`(6))
) ENGINE=InnoDB AUTO_INCREMENT=125977622 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `cert_approvals` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `domain_id` int(11) NOT NULL,
  `name_scope` varchar(255) NOT NULL,
  `standing` enum('yes','no','canceled') NOT NULL,
  `origin` enum('dcv','dal','phone','internal','clone','cname','demo','direct','txt','standing_email','standing_phone') DEFAULT NULL,
  `approver_name` varchar(255) NOT NULL DEFAULT '',
  `approver_email` varchar(255) NOT NULL DEFAULT '',
  `approver_ip` varchar(15) NOT NULL DEFAULT '',
  `staff_id` int(11) NOT NULL DEFAULT 0,
  `staff_note` text DEFAULT NULL,
  `doc_id` int(11) DEFAULT 0,
  `ctime` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `mtime` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `agreement_id` tinyint(4) NOT NULL DEFAULT 0,
  `clone_id` int(11) DEFAULT NULL,
  `approver_dcv_token` varchar(32) DEFAULT NULL,
  `standing_cert_approval_id` int(11) DEFAULT NULL,
  `manual` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `domain_id` (`domain_id`),
  KEY `name_scope` (`name_scope`),
  KEY `standing` (`standing`)
) ENGINE=InnoDB AUTO_INCREMENT=4034520 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `cert_inspector_access_tokens` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `token` varchar(32) NOT NULL DEFAULT '',
  `email` varchar(100) NOT NULL DEFAULT '',
  `firstname` varchar(150) NOT NULL DEFAULT '',
  `lastname` varchar(150) NOT NULL DEFAULT '',
  `organization` varchar(150) NOT NULL DEFAULT '',
  `phone` varchar(25) DEFAULT NULL,
  `phone_extension` varchar(12) DEFAULT NULL,
  `token_first_generated` timestamp NOT NULL DEFAULT current_timestamp(),
  `account_created` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `certificate_inspector_download_2` (`token`),
  UNIQUE KEY `customer_email` (`email`),
  KEY `certificate_inspector_download_token` (`token`)
) ENGINE=InnoDB AUTO_INCREMENT=20263 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `checkboxes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `reference` varchar(50) DEFAULT NULL,
  `name` varchar(1024) NOT NULL,
  `description` text DEFAULT NULL,
  `type` enum('DOMAIN','COMPANY','CONTACT') DEFAULT NULL,
  `note_required` tinyint(1) NOT NULL DEFAULT 0,
  `note_template` text DEFAULT NULL,
  `special_purpose` enum('gtld_reject') DEFAULT NULL,
  `default_valid_time` varchar(45) DEFAULT NULL,
  `hook` varchar(100) DEFAULT NULL,
  `read_only` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `type` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=1814 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `checkbox_customer_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `message` varchar(2048) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `checkbox_customer_statuses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `checklist_name_id` int(11) DEFAULT NULL COMMENT 'This column allows us to make rejection/other step status messages that are specific to a checklist_name_id.  Excluding a checklist_name_id allows status codes to be reused across multiple checklists which all include some checklist_step_id where they all',
  `checklist_step_id` int(11) NOT NULL,
  `checkbox_id` int(11) DEFAULT NULL,
  `special_purpose` enum('gtld_reject','gtld_approved') DEFAULT NULL,
  `active` tinyint(1) NOT NULL,
  `customer_status_code` int(11) NOT NULL COMMENT 'Allows the API to pass back standard ''reason codes'' along with the status messages.  Note that you could hypothetically have 2 messages with different message texts (customer_message) for human consumption, but whose semantic meaning for automated systems',
  `checkbox_customer_message_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `CHECKLIST_STEP` (`checklist_step_id`,`active`)
) ENGINE=InnoDB AUTO_INCREMENT=165 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `checkbox_docs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `checkbox_id` int(10) unsigned NOT NULL,
  `doc_type_id` int(10) unsigned NOT NULL,
  `name` varchar(100) NOT NULL DEFAULT '',
  `description` text DEFAULT NULL,
  `num_required` tinyint(3) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `fk_assertion_docs_assertions` (`checkbox_id`),
  KEY `fk_assertion_docs_doc_types` (`doc_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1070 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `checklists` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `checklist_name_id` int(11) NOT NULL,
  `checklist_step_id` int(11) DEFAULT NULL,
  `checkbox_id` int(11) NOT NULL,
  `org_type_id` int(10) unsigned DEFAULT NULL,
  `modifier_id` int(10) unsigned DEFAULT NULL,
  `checklist_role_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_active` tinyint(1) NOT NULL DEFAULT 0,
  `sort_order` tinyint(3) unsigned DEFAULT 100,
  `date_created` datetime DEFAULT NULL,
  `date_inactivated` datetime DEFAULT NULL,
  `valid_months` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_checklist_assertions_assertions` (`checkbox_id`),
  KEY `fk_checklist_assertions_assertion_groups` (`checklist_step_id`),
  KEY `fk_checklist_assertions_checklist_modifiers` (`modifier_id`),
  KEY `fk_checklist_checklist_role_id` (`checklist_role_id`),
  KEY `is_active` (`is_active`),
  KEY `org_type_id` (`org_type_id`),
  KEY `checklist_name_id` (`checklist_name_id`),
  KEY `modifier_id` (`modifier_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1107 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `checklist_cache` (
  `order_id` int(11) NOT NULL DEFAULT 0,
  `checklist_id` int(11) NOT NULL DEFAULT 0,
  `company_id` int(11) NOT NULL DEFAULT 0,
  `domain_id` int(11) NOT NULL DEFAULT 0,
  `last_checked` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `status` enum('unknown','in_progress','first_auth_done','second_auth_done','issue_ready') NOT NULL DEFAULT 'unknown',
  `whats_left_counts` varchar(255) NOT NULL DEFAULT '',
  `whats_left_json` text DEFAULT NULL,
  PRIMARY KEY (`order_id`,`company_id`,`domain_id`,`checklist_id`),
  KEY `domain_id` (`domain_id`),
  KEY `checklist_id` (`checklist_id`,`company_id`,`domain_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `checklist_modifiers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `description` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `checklist_roles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `checklist_steps` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `reference` varchar(50) DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `sort_order` smallint(3) unsigned DEFAULT 100,
  `customer_friendly_name` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1019 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `checkmarks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `checkbox_id` int(10) unsigned NOT NULL,
  `company_id` int(10) unsigned DEFAULT NULL,
  `domain_id` int(10) unsigned DEFAULT NULL,
  `contact_id` int(10) DEFAULT NULL,
  `checkmark_status_id` int(10) unsigned NOT NULL,
  `first_approval_staff_id` int(10) unsigned DEFAULT NULL,
  `first_approval_date_time` datetime DEFAULT NULL,
  `second_approval_staff_id` int(10) unsigned DEFAULT NULL,
  `second_approval_date_time` datetime DEFAULT NULL,
  `audit_staff_id` int(10) unsigned DEFAULT NULL,
  `audit_date_time` datetime DEFAULT NULL,
  `review_note` text DEFAULT NULL,
  `date_expires` datetime NOT NULL,
  `rejected_staff_id` int(10) unsigned DEFAULT NULL,
  `rejected_date_time` datetime DEFAULT NULL,
  `checkbox_customer_status_id` int(11) DEFAULT NULL COMMENT 'A customer message (with optional API status code) for this checkmark.  Currently used to include a customer-friendly "reject reason" for gTLD''s.',
  PRIMARY KEY (`id`),
  KEY `fk_company_assertions_assertions` (`checkbox_id`),
  KEY `fk_company_assertions_companies` (`company_id`),
  KEY `fk_company_assertions_domains` (`domain_id`),
  KEY `fk_company_assertions_staff` (`first_approval_staff_id`),
  KEY `fk_company_assertions_staff1` (`second_approval_staff_id`),
  KEY `fk_company_assertions_assertion_statuses` (`checkmark_status_id`),
  KEY `checkmarks_date_expires` (`date_expires`),
  KEY `fk_checkmarks_contact_id` (`contact_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15048709 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `checkmark_amendments` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `checklist_step_id` int(10) unsigned NOT NULL,
  `old_checkmark_id` int(10) unsigned NOT NULL,
  `new_checkmark_id` int(10) unsigned DEFAULT NULL,
  `staff_id` int(10) unsigned NOT NULL,
  `note` text NOT NULL,
  `date_created` datetime NOT NULL,
  `date_completed` datetime DEFAULT NULL,
  `approved_staff_id` int(10) unsigned NOT NULL,
  `date_approved` datetime DEFAULT NULL,
  `cancelled_staff_id` int(11) DEFAULT NULL,
  `date_cancelled` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `old_idx` (`old_checkmark_id`)
) ENGINE=InnoDB AUTO_INCREMENT=22106 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `checkmark_docs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `checkmark_id` int(10) unsigned NOT NULL,
  `document_id` int(11) NOT NULL,
  `created_by_staff_id` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_company_assertion_docs_company_assertions` (`checkmark_id`),
  KEY `fk_company_assertion_docs_documents` (`document_id`),
  KEY `fk_company_assertion_docs_staff` (`created_by_staff_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13406296 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `checkmark_notes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `checkmark_id` int(10) unsigned NOT NULL,
  `staff_id` int(10) unsigned NOT NULL,
  `date_created` datetime NOT NULL,
  `note` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_checkmark_notes_checkmarks` (`checkmark_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3225556 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `client_cert_email` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ent_client_cert_id` int(10) unsigned NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_token_id` int(10) unsigned DEFAULT NULL,
  `date_emailed` datetime DEFAULT NULL,
  `date_validated` datetime DEFAULT NULL,
  `date_created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_ent_client_cert_id` (`ent_client_cert_id`)
) ENGINE=InnoDB AUTO_INCREMENT=905410 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `client_cert_renewal_notices` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ent_client_cert_id` int(11) DEFAULT NULL,
  `order_id` int(11) NOT NULL,
  `minus_90_sent` tinyint(1) NOT NULL DEFAULT 0,
  `minus_60_sent` tinyint(1) NOT NULL DEFAULT 0,
  `minus_30_sent` tinyint(1) NOT NULL DEFAULT 0,
  `minus_7_sent` tinyint(1) NOT NULL DEFAULT 0,
  `minus_3_sent` tinyint(1) NOT NULL DEFAULT 0,
  `plus_7_sent` tinyint(1) NOT NULL DEFAULT 0,
  `disable_renewal_notifications` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_order_id` (`order_id`),
  KEY `idx_ent_client_cert_id` (`ent_client_cert_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13233 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `cobranding_images` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` int(11) DEFAULT NULL,
  `reseller_id` int(10) unsigned DEFAULT NULL,
  `filename` varchar(150) DEFAULT NULL,
  `image_type` tinyint(3) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `cobranding_image_types` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `commissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `reseller_id` int(6) unsigned zerofill NOT NULL DEFAULT 000000,
  `month` tinyint(2) unsigned zerofill NOT NULL DEFAULT 00,
  `year` mediumint(4) NOT NULL DEFAULT 0,
  `calculated_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `num_orders` int(11) NOT NULL DEFAULT 0,
  `order_total` decimal(10,2) NOT NULL DEFAULT 0.00,
  `percentage` tinyint(2) NOT NULL DEFAULT 10,
  `paid_amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `paid_bonus` decimal(10,2) NOT NULL,
  `paid_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `paid_memo` varchar(255) NOT NULL DEFAULT '',
  `rates` text NOT NULL,
  `universal` tinyint(1) NOT NULL DEFAULT 0,
  `rate_id` int(5) unsigned zerofill NOT NULL DEFAULT 00000,
  `currency` char(3) CHARACTER SET ascii NOT NULL DEFAULT 'USD',
  PRIMARY KEY (`id`),
  UNIQUE KEY `reseller_id` (`reseller_id`,`month`,`year`)
) ENGINE=InnoDB AUTO_INCREMENT=70202 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `commission_adjustments` (
  `id` int(8) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `order_id` int(8) unsigned NOT NULL,
  `normal_commission_date` date NOT NULL,
  `adjusted_commission_date` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=572 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `commission_rates` (
  `id` int(5) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL DEFAULT '',
  `universal` tinyint(1) NOT NULL DEFAULT 0,
  `rates` text NOT NULL,
  `effective_date` date NOT NULL DEFAULT '0000-00-00',
  `expiration_date` date DEFAULT '0000-00-00',
  `expired` binary(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=183 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `common_names` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(8) unsigned zerofill NOT NULL,
  `common_name` varchar(255) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `domain_id` int(11) NOT NULL,
  `approve_id` int(11) NOT NULL DEFAULT 0,
  `status` enum('active','inactive','pending') DEFAULT 'active',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `domain_id` (`domain_id`),
  KEY `active` (`active`),
  KEY `common_names_approve_id` (`approve_id`),
  KEY `common_names_status` (`status`),
  KEY `common_name` (`common_name`(18))
) ENGINE=InnoDB AUTO_INCREMENT=48094078 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `companies` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `acct_id` int(6) unsigned zerofill NOT NULL DEFAULT 000000,
  `container_id` int(10) unsigned DEFAULT NULL,
  `org_contact_id` int(11) NOT NULL DEFAULT 0,
  `tech_contact_id` int(11) NOT NULL DEFAULT 0,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `ev_status` tinyint(4) NOT NULL DEFAULT 1,
  `org_name` varchar(255) NOT NULL DEFAULT '',
  `org_type` int(10) NOT NULL DEFAULT 1,
  `org_assumed_name` varchar(255) NOT NULL DEFAULT '',
  `org_addr1` varchar(128) NOT NULL DEFAULT '',
  `org_addr2` varchar(128) NOT NULL DEFAULT '',
  `org_zip` varchar(40) NOT NULL DEFAULT '',
  `org_city` varchar(128) NOT NULL DEFAULT '',
  `org_state` varchar(128) NOT NULL DEFAULT '',
  `org_country` varchar(2) NOT NULL DEFAULT '',
  `org_email` varchar(128) NOT NULL,
  `telephone` varchar(32) NOT NULL DEFAULT '',
  `org_reg_num` varchar(200) NOT NULL DEFAULT '',
  `jur_city` varchar(128) NOT NULL DEFAULT '',
  `jur_state` varchar(128) NOT NULL DEFAULT '',
  `jur_country` varchar(2) NOT NULL DEFAULT '',
  `incorp_agency` varchar(255) NOT NULL DEFAULT '',
  `master_agreement_sent` tinyint(1) NOT NULL DEFAULT 0,
  `locked` tinyint(1) NOT NULL DEFAULT 0,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `ov_validated_until` datetime DEFAULT NULL,
  `ev_validated_until` datetime DEFAULT NULL,
  `public_phone` varchar(32) NOT NULL DEFAULT '',
  `public_email` varchar(128) NOT NULL DEFAULT '',
  `namespace_protected` tinyint(4) NOT NULL DEFAULT 0,
  `slim_org_name` varchar(255) NOT NULL DEFAULT '',
  `pending_validation_checklist_ids` varchar(50) NOT NULL,
  `validation_submit_date` datetime DEFAULT NULL,
  `reject_notes` varchar(255) NOT NULL DEFAULT '',
  `reject_date_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `reject_staff` int(10) unsigned NOT NULL DEFAULT 0,
  `flag` tinyint(4) NOT NULL DEFAULT 0,
  `snooze_until` datetime DEFAULT NULL,
  `checklist_modifiers` varchar(30) NOT NULL,
  `ascii_name` varchar(255) DEFAULT NULL,
  `risk_score` smallint(5) unsigned NOT NULL DEFAULT 0,
  `incorp_agency_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `acct_id` (`acct_id`),
  KEY `org_contact_id` (`org_contact_id`),
  KEY `tech_contact_id` (`tech_contact_id`),
  KEY `status` (`status`),
  KEY `companies_org_name` (`org_name`),
  KEY `companies_org_state` (`org_state`),
  KEY `companies_org_country` (`org_country`),
  KEY `companies_jur_state` (`jur_state`),
  KEY `companies_jur_country` (`jur_country`),
  KEY `active` (`active`),
  KEY `org_type` (`org_type`),
  KEY `slim_org_name` (`slim_org_name`),
  KEY `pending_validation_checklist_ids` (`pending_validation_checklist_ids`),
  KEY `validation_submit_date` (`validation_submit_date`),
  KEY `container_id` (`container_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1400846 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `companies_statuses` (
  `id` tinyint(1) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `company_history` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `company_id` int(10) unsigned DEFAULT NULL,
  `staff_id` int(10) unsigned DEFAULT NULL,
  `datetime` datetime DEFAULT NULL,
  `field_name` varchar(255) DEFAULT NULL,
  `old_value` varchar(255) DEFAULT NULL,
  `new_value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_company_assertion_docs_staff` (`staff_id`),
  KEY `fk_company_assertions_companies` (`company_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4010636 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `company_intermediates` (
  `acct_id` int(11) NOT NULL,
  `ca_cert_id` int(11) NOT NULL,
  PRIMARY KEY (`acct_id`,`ca_cert_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `company_subdomains` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `domain_id` int(11) DEFAULT NULL,
  `company_id` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `status` enum('requested','approved','declined') DEFAULT 'requested',
  `ctime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `company_index` (`company_id`,`name`),
  KEY `domain_index` (`domain_id`)
) ENGINE=InnoDB AUTO_INCREMENT=132750 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `company_types` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `contacts` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `job_title` varchar(64) DEFAULT NULL,
  `firstname` varchar(128) DEFAULT NULL,
  `lastname` varchar(128) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `telephone` varchar(32) DEFAULT NULL,
  `telephone_ext` varchar(16) NOT NULL DEFAULT '',
  `fax` varchar(32) DEFAULT NULL,
  `i18n_language_id` tinyint(4) unsigned DEFAULT 1,
  `last_updated` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  `container_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `firstname` (`firstname`),
  KEY `lastname` (`lastname`),
  KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2529882 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `contact_map` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) DEFAULT NULL,
  `organization_id` int(11) DEFAULT NULL,
  `contact_id` int(11) DEFAULT NULL,
  `verified_contact_id` int(11) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_contact` (`contact_id`),
  KEY `idx_organization_id` (`organization_id`)
) ENGINE=InnoDB AUTO_INCREMENT=993697 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `contact_whitelist` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `contact_hash` varchar(32) DEFAULT NULL,
  `staff_id` int(11) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `account_id` int(10) unsigned DEFAULT NULL,
  `firstname` varchar(64) DEFAULT NULL,
  `lastname` varchar(64) DEFAULT NULL,
  `email` varchar(128) DEFAULT NULL,
  `phone` varchar(64) DEFAULT NULL,
  `phone_extension` varchar(64) DEFAULT NULL,
  `fax` varchar(64) DEFAULT NULL,
  `job_title` varchar(64) DEFAULT NULL,
  `staff_id2` int(10) unsigned DEFAULT NULL,
  `note` text DEFAULT NULL,
  `document_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_contact_hash` (`contact_hash`),
  KEY `ix_date_created` (`date_created`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `container` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `public_id` varchar(32) NOT NULL,
  `parent_id` int(10) unsigned DEFAULT NULL,
  `tree_level` smallint(5) unsigned NOT NULL,
  `account_id` int(10) unsigned NOT NULL,
  `container_template_id` int(10) unsigned NOT NULL,
  `logo_file_id` int(10) unsigned DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `is_active` tinyint(3) unsigned NOT NULL,
  `user_agreement_id` int(11) DEFAULT NULL,
  `ekey` varchar(32) DEFAULT NULL,
  `allowed_domain_names` text DEFAULT NULL,
  `type` varchar(16) NOT NULL DEFAULT 'standard',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_public_id` (`public_id`),
  KEY `ix_account_id` (`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=536799 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `container_ca_map` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `container_id` int(11) unsigned NOT NULL,
  `product_name_id` varchar(255) NOT NULL,
  `ca_cert_id` int(11) unsigned NOT NULL,
  `csr_type` enum('any','rsa','ecc') NOT NULL DEFAULT 'any',
  `signature_hash` enum('any','sha1','sha2-any','sha256','sha384','sha512') NOT NULL DEFAULT 'any',
  PRIMARY KEY (`id`),
  KEY `ix_container_product` (`container_id`,`product_name_id`)
) ENGINE=InnoDB AUTO_INCREMENT=42507 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `container_descendant_map` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `container_id` int(10) unsigned NOT NULL,
  `descendant_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_container_id_descendant_id` (`container_id`,`descendant_id`),
  UNIQUE KEY `ix_descendant_id_container_id` (`descendant_id`,`container_id`)
) ENGINE=InnoDB AUTO_INCREMENT=504120 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `container_domain` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `container_id` int(10) unsigned NOT NULL,
  `domain_id` int(10) unsigned DEFAULT NULL,
  `subdomain_id` int(10) unsigned DEFAULT NULL,
  `is_active` tinyint(4) DEFAULT 1,
  `organization_id` int(10) unsigned DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `status` varchar(16) DEFAULT NULL,
  `full_domain_view` tinyint(1) DEFAULT 0,
  `dcv_method` varchar(16) DEFAULT NULL,
  `dcv_name_scope` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_container_id` (`container_id`),
  KEY `ix_domain_id` (`domain_id`),
  KEY `ix_subdomain_id` (`subdomain_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3381413 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `container_guest_key` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `container_id` int(10) unsigned NOT NULL,
  `date_created` datetime NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `key` varchar(64) NOT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `validity_periods` set('1','2','3','custom') NOT NULL DEFAULT '',
  `mpki_token` varchar(50) DEFAULT NULL,
  `org_permission` enum('both','existing','new') DEFAULT NULL,
  `domain_permission` tinyint(1) unsigned NOT NULL DEFAULT 1,
  `contact_permission` tinyint(1) unsigned NOT NULL DEFAULT 1,
  `txn_summary_permission` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `language_preference` tinyint(4) unsigned NOT NULL DEFAULT 1,
  `expand_cert_opts` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `dcv_method_permission` tinyint(1) unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_key` (`key`)
) ENGINE=InnoDB AUTO_INCREMENT=93182 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `container_guest_key_product_map` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `guest_key_id` int(10) unsigned NOT NULL,
  `product_name_id` varchar(64) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_guest_key_id_product_name_id` (`guest_key_id`,`product_name_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14534 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `container_oem_ica_map` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `container_id` int(10) unsigned NOT NULL,
  `product_name_id` varchar(255) NOT NULL,
  `custom_ica` varchar(64) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_container_product` (`container_id`,`product_name_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3796 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `container_permission_override` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `account_id` int(10) unsigned NOT NULL,
  `container_template_id` int(11) NOT NULL DEFAULT 0,
  `container_id` int(11) NOT NULL DEFAULT 0,
  `access_permission_id` int(10) unsigned NOT NULL,
  `scope` tinyint(3) unsigned DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_account_template_container_permission_id` (`account_id`,`container_template_id`,`container_id`,`access_permission_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7980987 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `container_product_restrictions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `container_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL DEFAULT 0,
  `product_name_id` varchar(64) NOT NULL,
  `allowed_hashes` varchar(250) NOT NULL DEFAULT 'any',
  `allowed_intermediates` varchar(250) NOT NULL DEFAULT 'any',
  `default_intermediate` varchar(12) DEFAULT NULL,
  `allowed_lifetimes` varchar(50) NOT NULL DEFAULT 'any',
  `allow_auto_renew` tinyint(3) unsigned NOT NULL DEFAULT 1,
  `allowed_fqdns` smallint(5) unsigned DEFAULT NULL,
  `allowed_wildcards` smallint(5) unsigned DEFAULT NULL,
  `ct_log_option` enum('per_cert','always','never') DEFAULT NULL,
  `allow_auto_reissue` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `ix_container_id_role_id` (`container_id`,`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=443171 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `container_settings` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime DEFAULT NULL,
  `container_id` int(11) unsigned DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `value` text DEFAULT NULL,
  `allow_override` tinyint(3) unsigned NOT NULL DEFAULT 1,
  `read_only` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `inheritable` tinyint(3) unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE KEY `un_container_id_name` (`container_id`,`name`),
  KEY `ix_container` (`container_id`),
  KEY `name_idx` (`name`(11))
) ENGINE=InnoDB AUTO_INCREMENT=2502154 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `container_template` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `account_id` int(10) unsigned DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `internal_description` varchar(1024) DEFAULT NULL,
  `is_primary` tinyint(3) unsigned NOT NULL,
  `agreement_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25331 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `container_template_access_role_map` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `template_id` int(10) unsigned DEFAULT NULL,
  `access_role_id` int(10) unsigned NOT NULL,
  `account_id` int(11) NOT NULL DEFAULT 0,
  `active` tinyint(3) unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_template_access_role_account_id` (`template_id`,`access_role_id`,`account_id`),
  KEY `ix_account_id` (`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1699577 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `container_template_feature_map` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `container_template_id` int(10) unsigned NOT NULL,
  `feature_id` int(10) unsigned NOT NULL,
  `feature_scope` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_container_template_id_feature_id_feature_scope` (`container_template_id`,`feature_id`,`feature_scope`)
) ENGINE=InnoDB AUTO_INCREMENT=719 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `container_template_map` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `container_template_id` int(10) unsigned NOT NULL,
  `mapped_template_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `container_template_permission_map` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `container_template_id` int(10) unsigned NOT NULL,
  `access_permission_id` int(10) unsigned NOT NULL,
  `scope` tinyint(3) unsigned DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_container_template_id_permission_id` (`container_template_id`,`access_permission_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3814 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `container_template_product_map` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `template_id` int(10) unsigned NOT NULL,
  `product_name_id` varchar(64) NOT NULL,
  `require_tos` tinyint(3) unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_template_id_product_name_id` (`template_id`,`product_name_id`)
) ENGINE=InnoDB AUTO_INCREMENT=631 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `countries` (
  `id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `abbrev` varchar(2) NOT NULL DEFAULT '',
  `upper_abbrev` varchar(2) NOT NULL DEFAULT '',
  `name` varchar(128) DEFAULT NULL,
  `sort_order` tinyint(4) NOT NULL DEFAULT 4,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `allow_ev` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `abbrev` (`abbrev`),
  KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=247 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `country_alias` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime DEFAULT NULL,
  `display` tinyint(4) DEFAULT 0,
  `alias` varchar(255) NOT NULL,
  `phone_code` varchar(3) NOT NULL,
  `parent_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_phone_code` (`phone_code`)
) ENGINE=InnoDB AUTO_INCREMENT=2139 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `country_code` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `phone_code` varchar(3) NOT NULL,
  `regex_validation` varchar(30) DEFAULT NULL,
  `allowed_lengths` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_phone_code` (`phone_code`)
) ENGINE=InnoDB AUTO_INCREMENT=222 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `credited_certs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `acct_id` int(10) unsigned DEFAULT NULL,
  `date_credited` date DEFAULT NULL,
  `any_other` smallint(5) unsigned DEFAULT NULL,
  `any_ssl` smallint(5) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `current_standard_pricing` (
  `currency` char(3) NOT NULL,
  `standard_pricing` text NOT NULL,
  `last_updated` datetime NOT NULL,
  PRIMARY KEY (`currency`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `customer_order` (
  `id` int(10) unsigned NOT NULL,
  `product_name_id` int(10) unsigned NOT NULL,
  `account_id` int(10) unsigned NOT NULL,
  `container_id` int(10) unsigned NOT NULL,
  `status` enum('pending','reissue_pending','issued','revoked','rejected','canceled','waiting_pickup') NOT NULL DEFAULT 'pending',
  `ip_address` varchar(15) CHARACTER SET ascii DEFAULT NULL,
  `certificate_tracker_id` int(10) unsigned NOT NULL DEFAULT 0,
  `customer_order_id` varchar(64) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `date_issued` datetime DEFAULT NULL,
  `status_last_updated` datetime DEFAULT NULL,
  `user_id` int(10) unsigned DEFAULT 0,
  `auto_renew` tinyint(1) NOT NULL DEFAULT 0,
  `renewed_order_id` int(10) unsigned DEFAULT NULL,
  `is_renewed` tinyint(1) NOT NULL DEFAULT 0,
  `disable_renewal_notifications` tinyint(1) NOT NULL DEFAULT 0,
  `disable_issuance_email` tinyint(1) NOT NULL DEFAULT 0,
  `ssl_profile_option` varchar(32) CHARACTER SET ascii DEFAULT NULL,
  `additional_emails` text DEFAULT NULL,
  `custom_renewal_message` text DEFAULT NULL,
  `additional_template_data` text DEFAULT NULL,
  `order_options` text DEFAULT NULL,
  `cs_provisioning_method` enum('client_app','email','ship_token','none') DEFAULT NULL,
  `dcv_method` varchar(16) CHARACTER SET ascii DEFAULT NULL,
  `common_name` varchar(255) DEFAULT NULL,
  `organization_units` text DEFAULT NULL,
  `organization_id` int(10) unsigned DEFAULT NULL,
  `dns_names` text DEFAULT NULL,
  `csr` text DEFAULT NULL,
  `signature_hash` varchar(8) CHARACTER SET ascii DEFAULT NULL,
  `validity_years` int(10) unsigned NOT NULL,
  `date_valid_from` date DEFAULT NULL,
  `date_valid_till` date DEFAULT NULL,
  `serial_number` varchar(128) CHARACTER SET ascii DEFAULT NULL,
  `thumbprint` varchar(40) CHARACTER SET ascii DEFAULT NULL,
  `ca_cert_id` int(10) unsigned NOT NULL,
  `plus_feature` tinyint(1) DEFAULT NULL,
  `service_name` varchar(32) DEFAULT NULL,
  `server_platform_id` int(11) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `cost` decimal(10,2) DEFAULT NULL,
  `purchased_dns_names` int(10) unsigned NOT NULL DEFAULT 0,
  `purchased_wildcard_names` int(10) unsigned NOT NULL DEFAULT 0,
  `pay_type` varchar(4) CHARACTER SET ascii NOT NULL DEFAULT 'A',
  `stat_row_id` int(10) unsigned DEFAULT NULL,
  `names_stat_row_id` int(10) unsigned DEFAULT NULL,
  `wildcard_names_stat_row_id` int(10) unsigned DEFAULT NULL,
  `receipt_id` int(10) unsigned DEFAULT NULL,
  `agreement_id` int(10) unsigned DEFAULT NULL,
  `is_out_of_contract` tinyint(1) NOT NULL DEFAULT 0,
  `locale` varchar(8) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_account_id` (`account_id`),
  KEY `ix_product_name_id` (`product_name_id`),
  KEY `ix_container_id` (`container_id`),
  KEY `ix_date_created` (`date_created`),
  KEY `ix_status_last_updated` (`status_last_updated`),
  KEY `ix_common_name` (`common_name`(16)),
  KEY `ix_organization_id` (`organization_id`),
  KEY `ix_validity_years` (`validity_years`),
  KEY `ix_valid_till` (`date_valid_till`),
  KEY `ix_receipt_id` (`receipt_id`),
  KEY `id_certificate_tracker_id` (`certificate_tracker_id`),
  KEY `id_thumbprint` (`thumbprint`(10)),
  KEY `ix_customer_order_id` (`customer_order_id`(8)),
  KEY `ix_serial_number` (`serial_number`(8)),
  KEY `ix_renewed_order_id` (`renewed_order_id`),
  KEY `ix_user_id` (`user_id`),
  KEY `ix_ca_cert_id` (`ca_cert_id`),
  KEY `ix_dcv_method` (`dcv_method`),
  KEY `ix_date_issued` (`date_issued`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `customer_order_contact` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(10) unsigned NOT NULL,
  `firstname` varchar(128) DEFAULT NULL,
  `lastname` varchar(128) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `telephone` varchar(32) DEFAULT NULL,
  `job_title` varchar(64) DEFAULT NULL,
  `contact_type` varchar(32) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `last_updated` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_order_id` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=33248624 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `customer_order_domain` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(10) unsigned NOT NULL,
  `domain_name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_order_id` (`order_id`),
  KEY `ix_domain_name` (`domain_name`)
) ENGINE=InnoDB AUTO_INCREMENT=226816734 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `customer_order_email` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(10) unsigned NOT NULL,
  `email` varchar(255) NOT NULL,
  `date_created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_order_id` (`order_id`),
  KEY `ix_email` (`email`),
  KEY `ix_date_created` (`date_created`)
) ENGINE=InnoDB AUTO_INCREMENT=949432 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `customer_order_reissue_history` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(10) unsigned NOT NULL,
  `legacy_reissue_id` int(10) unsigned DEFAULT NULL,
  `legacy_client_cert_id` int(10) unsigned DEFAULT NULL,
  `is_original_order` tinyint(4) NOT NULL DEFAULT 0,
  `status` enum('pending','reissue_pending','issued','revoked','rejected','canceled') NOT NULL DEFAULT 'pending',
  `ip_address` varchar(15) CHARACTER SET ascii DEFAULT NULL,
  `certificate_tracker_id` int(10) unsigned DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `date_issued` datetime DEFAULT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  `additional_template_data` text DEFAULT NULL,
  `order_options` text DEFAULT NULL,
  `dcv_method` varchar(16) CHARACTER SET ascii DEFAULT NULL,
  `common_name` varchar(255) DEFAULT NULL,
  `organization_units` text DEFAULT NULL,
  `organization_id` int(10) unsigned DEFAULT NULL,
  `dns_names` text DEFAULT NULL,
  `csr` text DEFAULT NULL,
  `signature_hash` varchar(8) CHARACTER SET ascii DEFAULT NULL,
  `date_valid_from` date DEFAULT NULL,
  `date_valid_till` date DEFAULT NULL,
  `serial_number` varchar(128) CHARACTER SET ascii DEFAULT NULL,
  `thumbprint` varchar(40) CHARACTER SET ascii DEFAULT NULL,
  `ca_cert_id` int(10) unsigned NOT NULL,
  `service_name` varchar(32) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `cost` decimal(10,2) DEFAULT NULL,
  `purchased_dns_names` int(10) unsigned DEFAULT NULL,
  `pay_type` varchar(4) CHARACTER SET ascii NOT NULL DEFAULT 'A',
  `stat_row_id` int(10) unsigned DEFAULT NULL,
  `names_stat_row_id` int(10) unsigned DEFAULT NULL,
  `receipt_id` int(10) unsigned DEFAULT NULL,
  `agreement_id` int(10) unsigned DEFAULT NULL,
  `is_out_of_contract` tinyint(1) NOT NULL DEFAULT 0,
  `purchased_wildcard_names` int(10) unsigned DEFAULT NULL,
  `wildcard_names_stat_row_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_order_id` (`order_id`),
  KEY `ix_legacy_reissue_id` (`legacy_reissue_id`),
  KEY `ix_legacy_client_cert_id` (`legacy_client_cert_id`),
  KEY `ix_certificate_tracker_id` (`certificate_tracker_id`),
  KEY `ix_receipt_id` (`receipt_id`),
  KEY `ix_date_created` (`date_created`)
) ENGINE=InnoDB AUTO_INCREMENT=5729768 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `customer_po_request` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` int(10) unsigned NOT NULL,
  `container_id` int(10) unsigned NOT NULL,
  `date_created` datetime NOT NULL,
  `approval_status` enum('pending','approved','rejected') DEFAULT 'pending',
  `review_staff_id` mediumint(8) unsigned NOT NULL,
  `cust_po_number` varchar(96) DEFAULT '',
  `bill_to_email` varchar(128) NOT NULL DEFAULT '',
  `amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `currency` varchar(3) NOT NULL DEFAULT '',
  `reject_notes` varchar(255) NOT NULL DEFAULT '',
  `reject_date_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `vat_number` varchar(128) NOT NULL DEFAULT '',
  `billing_contact_name` varchar(128) NOT NULL DEFAULT '',
  `billing_org_name` varchar(128) NOT NULL DEFAULT '',
  `billing_org_addr1` varchar(128) NOT NULL DEFAULT '',
  `billing_org_addr2` varchar(128) NOT NULL DEFAULT '',
  `billing_org_city` varchar(64) NOT NULL DEFAULT '',
  `billing_org_state` varchar(64) NOT NULL DEFAULT '',
  `billing_org_zip` varchar(10) NOT NULL DEFAULT '',
  `billing_org_country` varchar(2) NOT NULL DEFAULT '0',
  `billing_telephone` varchar(32) NOT NULL DEFAULT '',
  `hard_copy_path` varchar(255) DEFAULT '',
  `hard_copy_date` datetime DEFAULT NULL,
  `customer_notes` varchar(512) DEFAULT NULL,
  `additional_emails` varchar(512) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `account_id` (`account_id`),
  KEY `container_id` (`container_id`),
  KEY `date_created` (`date_created`),
  KEY `approval_status` (`approval_status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `custom_fields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `acct_id` int(6) unsigned DEFAULT NULL,
  `identifier` int(11) NOT NULL,
  `reference` enum('company','user_contact','address_request','device_request','org_request','fbca_address_request') NOT NULL,
  `name` varchar(50) NOT NULL,
  `description` varchar(500) DEFAULT NULL,
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  PRIMARY KEY (`id`),
  UNIQUE KEY `acct_id` (`acct_id`,`identifier`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `custom_renewal_notices` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `body` text DEFAULT NULL,
  `notice_level` enum('account','order','unit') DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1524 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `custom_renewal_notice_accounts` (
  `id` int(10) unsigned NOT NULL,
  `custom_renewal_notice_id` mediumint(8) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `custom_renewal_notice_ent_requests` (
  `id` int(10) unsigned NOT NULL,
  `custom_renewal_notice_id` mediumint(8) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `custom_renewal_notice_ent_units` (
  `id` int(10) unsigned NOT NULL,
  `custom_renewal_notice_id` mediumint(8) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `custom_renewal_notice_orders` (
  `id` int(10) unsigned NOT NULL,
  `custom_renewal_notice_id` mediumint(8) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `custom_values` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `custom_field_id` int(11) NOT NULL,
  `reference_id` int(11) NOT NULL,
  `value` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `reference_id` (`reference_id`,`custom_field_id`),
  KEY `value` (`value`)
) ENGINE=InnoDB AUTO_INCREMENT=94126 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `cust_audit_log` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `parent_log_id` int(11) unsigned DEFAULT NULL,
  `date_time` datetime NOT NULL,
  `acct_id` int(6) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `ip_address` int(10) unsigned NOT NULL,
  `ip_country` char(2) DEFAULT NULL,
  `action_status` enum('failed','successful') DEFAULT NULL,
  `action` varchar(50) NOT NULL,
  `target_type` varchar(50) NOT NULL DEFAULT '',
  `target_id` int(11) unsigned NOT NULL,
  `message` varchar(1500) DEFAULT NULL,
  `staff_id` smallint(5) unsigned DEFAULT NULL,
  `origin` enum('ui','api') NOT NULL DEFAULT 'ui',
  `container_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `parent_log_id` (`parent_log_id`),
  KEY `acct_id` (`acct_id`),
  KEY `date_time` (`date_time`),
  KEY `ip_address` (`ip_address`),
  KEY `container_id` (`container_id`),
  KEY `cust_audit_log_user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=192761791 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `cust_audit_log_notifications` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `acct_id` int(11) unsigned NOT NULL DEFAULT 0,
  `container_id` int(10) unsigned DEFAULT NULL,
  `user_id` int(11) unsigned NOT NULL DEFAULT 0,
  `email_address` varchar(255) DEFAULT NULL,
  `cat_cert_issuance` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `cat_user_changes` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `cat_logins` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `cat_bad_ip_logins` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `cat_cert_revoke` tinyint(1) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `ix_acct_id` (`acct_id`),
  KEY `ix_container_id` (`container_id`),
  KEY `ix_user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3316 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `data_deleted` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `table` varchar(64) DEFAULT NULL,
  `record_id` int(10) unsigned DEFAULT NULL,
  `description` varchar(128) DEFAULT NULL,
  `date_time` datetime DEFAULT NULL,
  `data` mediumtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `record_id` (`record_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2487359 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `dcj_accounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date_created` datetime DEFAULT current_timestamp(),
  `account_id` int(11) NOT NULL,
  `portal` enum('storefront','geostorefront','geocenter') NOT NULL,
  `portal_tech_email` varchar(256) CHARACTER SET ascii NOT NULL,
  `user_id` int(11) NOT NULL,
  `is_master` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_portal_portal_tech_email` (`portal`,`portal_tech_email`),
  KEY `idx_account_id` (`account_id`),
  KEY `idx_is_master` (`is_master`)
) ENGINE=InnoDB AUTO_INCREMENT=28743 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `dcj_certificates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date_created` datetime DEFAULT current_timestamp(),
  `portal` enum('storefront','geostorefront','geocenter') NOT NULL,
  `portal_tech_email` varchar(256) CHARACTER SET ascii NOT NULL,
  `serial_number` varchar(128) CHARACTER SET ascii NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  `error_description` varchar(1024) DEFAULT NULL,
  `last_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `serial_number` (`serial_number`),
  KEY `idx_portal_portal_tech_email` (`portal`,`portal_tech_email`),
  KEY `idx_status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=94198 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `dcj_coupon_list` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `coupon_number` varchar(16) NOT NULL,
  `product_name` varchar(256) DEFAULT NULL,
  `coupon_price` varchar(45) DEFAULT NULL,
  `coupon_consumed_person_id` varchar(45) DEFAULT NULL,
  `coupon_consumed_date` datetime DEFAULT NULL,
  `coupon_status` varchar(45) DEFAULT NULL,
  `common_name` varchar(256) DEFAULT NULL,
  `cert_enrollment_date` datetime DEFAULT NULL,
  `cert_valid_period` varchar(45) DEFAULT NULL,
  `cert_enrollment_company_name` varchar(256) DEFAULT NULL,
  `cert_enrollment_company_address` varchar(256) DEFAULT NULL,
  `cert_enrollment_company_postcode` varchar(45) DEFAULT NULL,
  `cert_enrollment_company_phone_number` varchar(256) DEFAULT NULL,
  `cert_enrollment_company_department_name` varchar(256) DEFAULT NULL,
  `cert_enrollment_company_contact_person_email_address` varchar(256) DEFAULT NULL,
  `cert_enrollment_company_contact_person_name` varchar(256) DEFAULT NULL,
  `tech_company_name` varchar(256) DEFAULT NULL,
  `tech_company_department_name` varchar(256) DEFAULT NULL,
  `tech_company_tech_contact_email` varchar(256) DEFAULT NULL,
  `tech_company_tech_person_name` varchar(256) DEFAULT NULL,
  `admin_company_name` varchar(256) DEFAULT NULL,
  `admin_company_department_name` varchar(256) DEFAULT NULL,
  `admin_company_admin_email` varchar(256) DEFAULT NULL,
  `admin_company_admin_name` varchar(256) DEFAULT NULL,
  `coupon_management_number` varchar(256) DEFAULT NULL,
  `coupon_type` varchar(45) DEFAULT NULL,
  `coupon_given_partner_id` int(10) unsigned DEFAULT NULL,
  `coupon_start_date` datetime DEFAULT NULL,
  `coupon_date_valid_till` datetime DEFAULT NULL,
  `coupon_giver_id` int(10) unsigned DEFAULT NULL,
  `coupon_given_date` datetime DEFAULT NULL,
  `coupon_approver_id` int(10) unsigned DEFAULT NULL,
  `coupon_approval_date` datetime DEFAULT NULL,
  `partner_id` int(10) unsigned DEFAULT NULL,
  `partner_name` varchar(256) DEFAULT NULL,
  `partner_address` varchar(256) DEFAULT NULL,
  `partner_post_code` varchar(45) DEFAULT NULL,
  `partner_telephone_number` varchar(45) DEFAULT NULL,
  `partner_fax_number` varchar(45) DEFAULT NULL,
  `partner_email` varchar(256) DEFAULT NULL,
  `giver_id` int(10) unsigned DEFAULT NULL,
  `giver_permission` varchar(45) DEFAULT NULL,
  `giver_name` varchar(256) DEFAULT NULL,
  `giver_email` varchar(256) DEFAULT NULL,
  `approver_id` int(10) unsigned DEFAULT NULL,
  `approver_permission` varchar(256) DEFAULT NULL,
  `approver_name` varchar(256) DEFAULT NULL,
  `approver_email` varchar(256) DEFAULT NULL,
  `crm_product_id` int(10) unsigned DEFAULT NULL,
  `sf_product_id` int(10) unsigned DEFAULT NULL,
  `shop_id` int(10) unsigned DEFAULT NULL,
  `product_price` varchar(256) DEFAULT NULL,
  `product_displayed_name` varchar(256) DEFAULT NULL,
  `product_campaign_flag` int(1) unsigned DEFAULT NULL,
  `product_note` varchar(256) DEFAULT NULL,
  `product_enrollment_required_flag` int(1) unsigned DEFAULT NULL,
  `product_multiple_purchase_flag` int(1) unsigned DEFAULT NULL,
  `product_price_type` varchar(256) DEFAULT NULL,
  `product_registered_date` datetime DEFAULT NULL,
  `product_registerant_id` int(10) unsigned DEFAULT NULL,
  `product_updated_date` datetime DEFAULT NULL,
  `product_updater_id` int(10) unsigned DEFAULT NULL,
  `account_id` int(10) unsigned DEFAULT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  `voucher_code_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `coupon_number` (`coupon_number`),
  KEY `idx_voucher_code_id` (`voucher_code_id`)
) ENGINE=InnoDB AUTO_INCREMENT=22386 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `dcj_order_migration_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date_created` datetime DEFAULT current_timestamp(),
  `account_id` int(11) NOT NULL,
  `start_time` datetime DEFAULT NULL,
  `completed_time` datetime DEFAULT NULL,
  `user_id` int(11) DEFAULT 0,
  `staff_id` int(11) DEFAULT 0,
  `last_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_account_id` (`account_id`),
  KEY `idx_date_created` (`date_created`),
  KEY `idx_completed` (`completed_time`)
) ENGINE=InnoDB AUTO_INCREMENT=30364 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `dcv_audit_data` (
  `order_id` int(10) unsigned NOT NULL,
  `duplicate_id` int(10) unsigned DEFAULT NULL,
  `reissue_id` int(10) unsigned DEFAULT NULL,
  `date_issued` datetime NOT NULL,
  `date_expires` datetime NOT NULL,
  `serial_number` char(42) DEFAULT NULL,
  `product_id` smallint(5) unsigned NOT NULL,
  `product_name` char(50) NOT NULL,
  `root_path` enum('digicert','entrust','cybertrust','comodo') NOT NULL,
  `ca_cert_id` int(10) unsigned NOT NULL,
  `is_missing_dcvs` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `remediation_dcv_date` datetime DEFAULT NULL,
  `remediation_days` smallint(6) DEFAULT NULL,
  `pem` mediumtext DEFAULT NULL,
  `chain` varchar(32) DEFAULT NULL,
  UNIQUE KEY `duplicate_id` (`duplicate_id`),
  UNIQUE KEY `reissue_id` (`reissue_id`),
  UNIQUE KEY `order_id_duplicate_id` (`order_id`,`duplicate_id`),
  UNIQUE KEY `order_id_reissue_id` (`order_id`,`reissue_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `dcv_cache` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `domain_id` int(10) unsigned NOT NULL,
  `date_created` datetime NOT NULL,
  `order_id` int(10) unsigned NOT NULL DEFAULT 0,
  `domain_name` varchar(255) NOT NULL,
  `include_subdomains` tinyint(4) NOT NULL DEFAULT 1,
  `dcv_method` varchar(255) NOT NULL,
  `approver_name` varchar(255) NOT NULL DEFAULT '',
  `approver_email` varchar(255) NOT NULL DEFAULT '',
  `validation_date` datetime DEFAULT NULL,
  `staff_id` int(10) unsigned NOT NULL DEFAULT 0,
  `staff_note` text DEFAULT NULL,
  `document_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_clone` tinyint(4) NOT NULL DEFAULT 0,
  `cert_tracker_id` int(10) unsigned DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `domain_id` (`domain_id`,`domain_name`,`include_subdomains`,`cert_tracker_id`),
  KEY `idx_date_create` (`date_created`),
  KEY `idx_domain_id` (`domain_id`),
  KEY `idx_order_id` (`order_id`),
  KEY `idx_domain_name` (`include_subdomains`,`domain_name`),
  KEY `idx_validation_date` (`validation_date`)
) ENGINE=InnoDB AUTO_INCREMENT=22343983 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `dcv_cache_old` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `domain_id` int(10) unsigned NOT NULL,
  `date_created` datetime NOT NULL,
  `order_id` int(10) unsigned NOT NULL DEFAULT 0,
  `domain_name` varchar(255) NOT NULL,
  `include_subdomains` tinyint(4) NOT NULL DEFAULT 1,
  `dcv_method` varchar(255) NOT NULL,
  `approver_name` varchar(255) NOT NULL DEFAULT '',
  `approver_email` varchar(255) NOT NULL DEFAULT '',
  `validation_date` datetime DEFAULT NULL,
  `staff_id` int(10) unsigned NOT NULL DEFAULT 0,
  `staff_note` text DEFAULT NULL,
  `document_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_clone` tinyint(4) NOT NULL DEFAULT 0,
  `cert_tracker_id` int(10) unsigned DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `idx_date_create` (`date_created`),
  KEY `idx_domain_id` (`domain_id`),
  KEY `idx_order_id` (`order_id`),
  KEY `idx_domain_name` (`include_subdomains`,`domain_name`),
  KEY `idx_validation_date` (`validation_date`)
) ENGINE=InnoDB AUTO_INCREMENT=21800273 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `dcv_email_blocklist` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(50) NOT NULL,
  `notes` varchar(200) DEFAULT NULL,
  `created_by_staff_id` int(11) NOT NULL DEFAULT 0,
  `date_added` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=117 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `dcv_email_sent` (
  `dcv_history_id` int(10) unsigned NOT NULL,
  `email_address` varchar(255) NOT NULL,
  PRIMARY KEY (`dcv_history_id`,`email_address`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `dcv_expire_cache` (
  `cert_approval_id` int(11) DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  `reason` varchar(255) DEFAULT NULL,
  `result` varchar(50) DEFAULT NULL,
  UNIQUE KEY `cert_approval_id_idx` (`cert_approval_id`),
  KEY `result_idx` (`result`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `dcv_invitations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(128) NOT NULL,
  `token` varchar(32) NOT NULL,
  `order_id` int(8) unsigned zerofill NOT NULL,
  `reissue_id` int(8) unsigned DEFAULT 0,
  `domain_id` int(11) NOT NULL,
  `name_scope` varchar(255) DEFAULT NULL,
  `date_time` datetime DEFAULT NULL,
  `status` enum('active','deleted') NOT NULL DEFAULT 'active',
  `source` varchar(20) DEFAULT NULL,
  `email_name_scope` varchar(255) DEFAULT NULL,
  `container_domain_id` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `email` (`email`(8)),
  KEY `token` (`token`(8)),
  KEY `order_id` (`order_id`),
  KEY `domain_id` (`domain_id`),
  KEY `dcv_invitations_reissue_id` (`reissue_id`),
  KEY `container_domain_id_idx` (`container_domain_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10629088 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `dcv_queue` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(8) unsigned zerofill NOT NULL,
  `domain_id` int(11) unsigned NOT NULL,
  `sent` tinyint(1) NOT NULL DEFAULT 0,
  `staff` int(10) unsigned NOT NULL DEFAULT 0,
  `date_sent` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `dcv_reverify` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `domain_id` int(11) NOT NULL,
  `dibs_staff_id` int(11) DEFAULT NULL,
  `dibs_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8169 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `dcv_reverify_results` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `domain_id` int(11) NOT NULL,
  `result` varchar(100) DEFAULT NULL,
  `staff_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12052 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `dcv_sort_cache` (
  `domain_id` int(11) DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  `reason` varchar(255) DEFAULT NULL,
  `category` varchar(50) DEFAULT NULL,
  `resolution` varchar(50) DEFAULT NULL,
  `meta_data` text DEFAULT NULL,
  UNIQUE KEY `domain_id_idx` (`domain_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `dcv_tokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `domain_id` int(11) NOT NULL,
  `method` enum('cname') NOT NULL DEFAULT 'cname',
  `token` varchar(64) NOT NULL,
  `verification_value` varchar(253) NOT NULL,
  `order_id` int(8) unsigned zerofill NOT NULL,
  `reissue_id` int(8) unsigned DEFAULT 0,
  `date_time` datetime DEFAULT NULL,
  `status` enum('active','deleted') NOT NULL DEFAULT 'active',
  `container_domain_id` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `domain_id` (`domain_id`),
  KEY `method` (`method`),
  KEY `token` (`token`(8)),
  KEY `order_id` (`order_id`),
  KEY `dcv_tokens_reissue_id` (`reissue_id`),
  KEY `idx_container_domain_id` (`container_domain_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1568 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `deleted_subdomains` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` int(10) unsigned NOT NULL,
  `container_id` int(10) unsigned NOT NULL,
  `reversion_sql` mediumtext NOT NULL,
  `cleanup_event_time` datetime NOT NULL,
  `date_created` datetime NOT NULL,
  `date_reverted` datetime DEFAULT NULL,
  `created_by_staff_id` int(10) unsigned NOT NULL,
  `reverted_by_staff_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=714 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `deposit_audit` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `action_id` int(10) unsigned DEFAULT NULL,
  `field_name` varchar(50) DEFAULT NULL,
  `old_value` varchar(255) DEFAULT NULL,
  `new_value` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=72797 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `deposit_audit_action` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `deposit_id` int(10) unsigned DEFAULT NULL,
  `staff_id` smallint(5) unsigned NOT NULL DEFAULT 0,
  `date_dt` datetime DEFAULT NULL,
  `action_type` varchar(255) DEFAULT NULL,
  `affected_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36466 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `digicert_reviews` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `review` text DEFAULT NULL,
  `nickname` varchar(20) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `status` enum('pending','approved','rejected') DEFAULT 'pending',
  `ip_address` int(10) unsigned DEFAULT NULL,
  `date_time` datetime DEFAULT NULL,
  `stars_overall` tinyint(3) unsigned DEFAULT NULL,
  `stars_features` tinyint(3) unsigned DEFAULT NULL,
  `stars_support` tinyint(3) unsigned DEFAULT NULL,
  `stars_experience` tinyint(3) unsigned DEFAULT NULL,
  `stars_issuance_speed` tinyint(3) unsigned DEFAULT NULL,
  `recommend` tinyint(3) unsigned DEFAULT NULL,
  `helpful` smallint(5) unsigned DEFAULT 0,
  `unhelpful` smallint(5) unsigned DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18027 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `digiloot` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `digiloot_details` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `loot_id` smallint(5) unsigned DEFAULT NULL,
  `size` varchar(10) DEFAULT NULL,
  `color` varchar(20) DEFAULT NULL,
  `stock` smallint(5) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `digiloot_orders` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned DEFAULT NULL,
  `acct_id` int(10) unsigned DEFAULT NULL,
  `loot_id` smallint(5) unsigned DEFAULT NULL,
  `loot_details_id` smallint(5) unsigned DEFAULT NULL,
  `date_time` datetime DEFAULT NULL,
  `status` varchar(20) DEFAULT 'pending',
  `note_to_customer` text DEFAULT NULL,
  `reason` text DEFAULT NULL,
  `staff_id` int(10) unsigned DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `address1` varchar(255) DEFAULT NULL,
  `address2` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `state` varchar(25) DEFAULT NULL,
  `postal_code` varchar(15) DEFAULT NULL,
  `country` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_acct_id` (`acct_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1249 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `direct_accredited` (
  `direct_trust_identifier` varchar(45) NOT NULL,
  `status` tinyint(2) DEFAULT NULL,
  `status_changed` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`direct_trust_identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `disable_ou_script_accounts_affected` (
  `account_id` int(10) unsigned NOT NULL,
  `phase` int(11) NOT NULL,
  `description` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `discount_rates` (
  `id` int(5) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL DEFAULT '',
  `universal` tinyint(1) NOT NULL DEFAULT 0,
  `rates` text NOT NULL,
  `discount_duration_days` int(11) DEFAULT NULL,
  `percent_discount` tinyint(4) NOT NULL DEFAULT 0,
  `percent_discount_products` varchar(50) NOT NULL DEFAULT '0',
  `percent_discount_lifetime` varchar(20) NOT NULL DEFAULT '0',
  `description` text NOT NULL,
  `created_by_staff_id` int(11) NOT NULL,
  `currency` char(3) CHARACTER SET ascii NOT NULL DEFAULT 'USD',
  `manage_code` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_manage_code` (`manage_code`)
) ENGINE=InnoDB AUTO_INCREMENT=15893 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `discount_types` (
  `id` tinyint(3) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `discovery_api_keys` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `discovery_api_key` varchar(32) DEFAULT NULL,
  `acct_id` int(6) NOT NULL DEFAULT 0,
  `max_ip_count` int(11) NOT NULL DEFAULT 1024,
  `customer_name` varchar(150) DEFAULT NULL,
  `customer_organization` varchar(150) DEFAULT NULL,
  `customer_email` varchar(100) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `send_emails` tinyint(4) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `discovery_api_key` (`discovery_api_key`),
  KEY `acct_id` (`acct_id`)
) ENGINE=InnoDB AUTO_INCREMENT=54953 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `discovery_certs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `discovery_api_key_id` int(11) NOT NULL,
  `order_id` int(8) unsigned zerofill NOT NULL DEFAULT 00000000,
  `product_id` int(11) DEFAULT NULL,
  `sha1_thumbprint` varchar(40) DEFAULT NULL,
  `valid_from` date NOT NULL DEFAULT '0000-00-00',
  `valid_till` date NOT NULL DEFAULT '0000-00-00',
  `keysize` int(11) DEFAULT NULL,
  `issuer` varchar(255) DEFAULT NULL,
  `common_name` varchar(255) DEFAULT NULL,
  `sans` text DEFAULT NULL,
  `org_name` varchar(255) DEFAULT NULL,
  `org_city` varchar(255) DEFAULT NULL,
  `org_state` varchar(128) DEFAULT NULL,
  `org_country` varchar(128) DEFAULT NULL,
  `send_minus_30` tinyint(1) NOT NULL DEFAULT 0,
  `send_minus_7` tinyint(1) NOT NULL DEFAULT 0,
  `sent_minus_30` tinyint(1) NOT NULL DEFAULT 0,
  `sent_minus_7` tinyint(1) NOT NULL DEFAULT 0,
  `certificate` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `discovery_api_key_id` (`discovery_api_key_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1094553 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `discovery_cert_usage` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `discovery_scan_id` int(11) DEFAULT NULL,
  `discovery_cert_id` int(11) DEFAULT NULL,
  `servers` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `discovery_scan_id` (`discovery_scan_id`),
  KEY `discovery_cert_id` (`discovery_cert_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2392351 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `discovery_scans` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `discovery_api_key_id` int(11) NOT NULL,
  `scan_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `scan_type` enum('manual','scheduled','') NOT NULL DEFAULT '',
  `scan_duration` int(11) DEFAULT NULL,
  `scan_data` longtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `discovery_api_key_id` (`discovery_api_key_id`)
) ENGINE=InnoDB AUTO_INCREMENT=113794 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `docs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `company_id` int(11) DEFAULT NULL,
  `domain_id` int(11) DEFAULT NULL,
  `contact_id` int(11) DEFAULT NULL,
  `order_id` int(11) DEFAULT NULL,
  `file_path` varchar(255) DEFAULT NULL,
  `upload_time` datetime DEFAULT NULL,
  `status` tinyint(1) DEFAULT 1,
  `staff_id` int(11) DEFAULT NULL,
  `page_current` int(11) DEFAULT NULL,
  `page_count` int(11) DEFAULT NULL,
  `doc_type_id` int(11) NOT NULL,
  `expires_time` datetime DEFAULT NULL,
  `is_perpetual` tinyint(1) NOT NULL DEFAULT 0,
  `display_name` varchar(255) DEFAULT NULL,
  `original_name` varchar(255) DEFAULT NULL,
  `file_modified_time` datetime DEFAULT NULL,
  `user_uploaded` tinyint(1) DEFAULT 0,
  `user_id` int(11) DEFAULT NULL,
  `key_index` tinyint(4) NOT NULL DEFAULT 0,
  `execution_date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_company_assertions_companies` (`company_id`),
  KEY `fk_company_assertions_domains` (`domain_id`),
  KEY `fk_assertion_docs_staff_id` (`staff_id`),
  KEY `contact_id` (`contact_id`),
  KEY `order_id` (`order_id`),
  KEY `docs_upload_time` (`upload_time`)
) ENGINE=InnoDB AUTO_INCREMENT=35595122 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `docs_unassigned` (
  `doc_id` int(11) NOT NULL DEFAULT 0,
  `staff_id` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`doc_id`),
  KEY `staff_id` (`staff_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `doc_emails` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `doc_id` int(10) unsigned NOT NULL,
  `email_address` varchar(255) DEFAULT NULL,
  `staff_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_doc_id` (`doc_id`)
) ENGINE=InnoDB AUTO_INCREMENT=339608 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `doc_history` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `doc_id` int(11) DEFAULT NULL,
  `staff_id` int(11) DEFAULT NULL,
  `action` enum('EXPIRE','NOTE','APPROVE','REJECT','CHANGE','UPLOAD') DEFAULT NULL,
  `datetime` datetime DEFAULT NULL,
  `note` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_company_assertions_docs` (`doc_id`),
  KEY `fk_company_assertions_staff` (`staff_id`)
) ENGINE=InnoDB AUTO_INCREMENT=41879159 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `doc_phone_number` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `doc_id` int(10) unsigned NOT NULL,
  `phone_number` varchar(64) DEFAULT NULL,
  `staff_id` int(10) unsigned NOT NULL,
  `phone_ext` varchar(48) DEFAULT NULL,
  `twilio_call_sid` varchar(48) DEFAULT NULL,
  `call_status_code` varchar(100) DEFAULT NULL,
  `call_status_message` varchar(100) DEFAULT NULL,
  `authenticity_pin` varchar(32) DEFAULT NULL,
  `last_update_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_doc_id` (`doc_id`)
) ENGINE=InnoDB AUTO_INCREMENT=109329 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `doc_statuses` (
  `id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `doc_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `description` text DEFAULT NULL,
  `short_name` varchar(50) DEFAULT NULL,
  `valid_time` varchar(25) DEFAULT NULL,
  `is_perpetual` tinyint(1) NOT NULL DEFAULT 0,
  `sort_order` int(10) unsigned DEFAULT 0,
  `auto_assign` enum('DOMAIN','COMPANY','CONTACT') DEFAULT NULL,
  `use_execution_date` tinyint(1) NOT NULL DEFAULT 0,
  `is_active` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `domains` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `scope` varchar(255) DEFAULT NULL,
  `company_id` int(11) NOT NULL DEFAULT 0,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `date_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `standalone` tinyint(1) NOT NULL DEFAULT 0,
  `approved_by` int(11) NOT NULL DEFAULT 0,
  `reject_notes` varchar(255) NOT NULL DEFAULT '',
  `reject_date_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `reject_staff` int(10) unsigned NOT NULL DEFAULT 0,
  `is_public` tinyint(4) NOT NULL DEFAULT 1,
  `internal_staff_id` int(10) unsigned DEFAULT NULL,
  `internal_date_time` datetime DEFAULT NULL,
  `flag` tinyint(4) NOT NULL DEFAULT 0,
  `snooze_until` datetime DEFAULT NULL,
  `alexa_rank` int(12) unsigned DEFAULT NULL,
  `namespace_protected` tinyint(4) NOT NULL DEFAULT 0,
  `pending_validation_checklist_ids` varchar(50) NOT NULL DEFAULT '',
  `validation_submit_date` datetime DEFAULT NULL,
  `checklist_modifiers` varchar(30) NOT NULL DEFAULT '',
  `dns_caa` enum('unknown','not_found','found') NOT NULL DEFAULT 'unknown',
  `dns_caa_date` date NOT NULL DEFAULT '1900-01-01',
  `allow_cname_dcv` tinyint(4) NOT NULL DEFAULT 0,
  `risk_score` smallint(5) unsigned NOT NULL DEFAULT 0,
  `dcv_method` varchar(20) DEFAULT NULL,
  `dcv_name_scope` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `company_id` (`company_id`),
  KEY `status` (`status`),
  KEY `is_public` (`is_public`),
  KEY `snooze_until` (`snooze_until`),
  KEY `pending_validation_checklist_ids` (`pending_validation_checklist_ids`),
  KEY `validation_submit_date` (`validation_submit_date`),
  KEY `date_time` (`date_time`)
) ENGINE=InnoDB AUTO_INCREMENT=2582868 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `domain_blacklists` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `domain_ra_map` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `domain_name` varchar(255) NOT NULL,
  `domain_id` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_domain_id_name` (`domain_id`,`domain_name`),
  KEY `idx_domain_name` (`domain_name`),
  KEY `idx_domain_id` (`domain_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2875202 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `domain_statuses` (
  `id` tinyint(4) NOT NULL AUTO_INCREMENT,
  `name` mediumtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `early_expired_snapshots` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `enterprise_snapshot_id` int(11) DEFAULT NULL,
  `acct_id` int(11) DEFAULT NULL,
  `container_id` int(11) DEFAULT NULL,
  `company_id` int(11) DEFAULT NULL,
  `domain_id` int(11) DEFAULT NULL,
  `snapshot_active_orders` int(11) DEFAULT NULL,
  `vip` int(11) DEFAULT NULL,
  `is_cis` int(11) DEFAULT NULL,
  `days_since_last_order_snapshot` int(11) DEFAULT NULL,
  `days_till_next_expiration_snapshot` int(11) DEFAULT NULL,
  `days_till_dcv_expires` int(11) DEFAULT NULL,
  `account_active_orders` int(11) DEFAULT NULL,
  `days_since_api_used` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `enterprise_snapshot_id` (`enterprise_snapshot_id`),
  KEY `acct_id` (`acct_id`),
  KEY `company_id` (`company_id`),
  KEY `domain_id` (`domain_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14652 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `email_machine_templates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL DEFAULT '',
  `template` text NOT NULL,
  `note_template` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `email_subscription_status` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `email_address` varchar(255) NOT NULL,
  `subscribed` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `last_updated_by_user_id` int(10) unsigned NOT NULL DEFAULT 0,
  `last_updated` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `date_created` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_email_address` (`email_address`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `email_template` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date_created` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `account_id` int(11) NOT NULL DEFAULT 0,
  `container_id` int(11) DEFAULT NULL,
  `language_code` varchar(10) NOT NULL DEFAULT 'en',
  `template_name` varchar(50) NOT NULL,
  `template_content` text DEFAULT NULL,
  `active` tinyint(4) NOT NULL DEFAULT 1,
  `descriptor` varchar(50) DEFAULT NULL,
  `whitelabel_image_url` varchar(255) DEFAULT NULL,
  `from_email` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_index` (`account_id`,`language_code`,`template_name`,`active`),
  KEY `account_id` (`account_id`),
  KEY `template_name` (`template_name`(16))
) ENGINE=InnoDB AUTO_INCREMENT=1381 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `email_tokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `token` varchar(128) NOT NULL DEFAULT '',
  `create_date` datetime DEFAULT NULL,
  `expiry_date` datetime DEFAULT NULL,
  `order_id` int(10) unsigned NOT NULL DEFAULT 0,
  `reissue_id` int(10) unsigned NOT NULL DEFAULT 0,
  `ent_client_cert_id` int(10) unsigned NOT NULL DEFAULT 0,
  `company_id` int(10) NOT NULL DEFAULT 0,
  `purpose` varchar(40) NOT NULL DEFAULT 'other',
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `reissue_id` (`reissue_id`),
  KEY `ent_client_cert_id` (`ent_client_cert_id`),
  KEY `idx_token` (`token`(6))
) ENGINE=InnoDB AUTO_INCREMENT=685071 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `email_token_common_name_map` (
  `token_id` int(10) unsigned DEFAULT NULL,
  `common_name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `enterprise_snapshots` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `company_id` int(10) unsigned NOT NULL DEFAULT 0,
  `domain_id` int(10) unsigned NOT NULL DEFAULT 0,
  `checklist_id` int(10) unsigned NOT NULL DEFAULT 0,
  `snapshot_info` text DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `validated_until` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `company_id` (`company_id`),
  KEY `domain_id` (`domain_id`)
) ENGINE=InnoDB AUTO_INCREMENT=20086813 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `ent_account_active_dates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `acct_id` int(6) unsigned zerofill NOT NULL,
  `signup_date` datetime NOT NULL,
  `deactivation_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `acct_id` (`acct_id`,`signup_date`)
) ENGINE=InnoDB AUTO_INCREMENT=23924 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `ent_account_info` (
  `acct_id` int(6) unsigned zerofill NOT NULL,
  `account_title` varchar(128) DEFAULT NULL,
  `ekey` varchar(32) NOT NULL,
  `signup_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `alt_url` varchar(255) NOT NULL,
  `branding_logo` varchar(128) DEFAULT NULL,
  `admin_email` varchar(255) DEFAULT NULL,
  `admin_email_settings` text DEFAULT NULL,
  `request_page_note` text DEFAULT NULL,
  `balance_reminder_threshold` int(11) DEFAULT 1000,
  `balance_negative_limit` int(11) DEFAULT 0,
  `role_permissions` varchar(10000) NOT NULL DEFAULT '',
  `allow_prod_change` tinyint(1) NOT NULL DEFAULT 1,
  `allow_single_limited` tinyint(1) NOT NULL DEFAULT 1,
  `allow_wildcard_limited` tinyint(1) NOT NULL DEFAULT 0,
  `allow_uc_limited` tinyint(1) NOT NULL DEFAULT 1,
  `allow_ev_limited` tinyint(1) NOT NULL DEFAULT 1,
  `allow_single_admin` tinyint(4) NOT NULL DEFAULT 1,
  `allow_wildcard_admin` tinyint(4) NOT NULL DEFAULT 0,
  `allow_uc_admin` tinyint(4) NOT NULL DEFAULT 1,
  `allow_ev_admin` tinyint(4) NOT NULL DEFAULT 1,
  `allow_single_helpdesk` tinyint(4) NOT NULL DEFAULT 1,
  `allow_wildcard_helpdesk` tinyint(4) NOT NULL DEFAULT 0,
  `allow_uc_helpdesk` tinyint(4) NOT NULL DEFAULT 1,
  `allow_ev_helpdesk` tinyint(4) NOT NULL DEFAULT 1,
  `allow_one_year_limited` tinyint(4) NOT NULL DEFAULT 1,
  `allow_two_year_limited` tinyint(4) NOT NULL DEFAULT 1,
  `allow_three_year_limited` tinyint(4) NOT NULL DEFAULT 1,
  `allow_login_requests` tinyint(4) NOT NULL DEFAULT 1,
  `allow_custom_expiration` tinyint(4) NOT NULL DEFAULT 1,
  `allow_unvalidated_approvals` tinyint(4) NOT NULL DEFAULT 0,
  `allow_client_certs` tinyint(4) NOT NULL DEFAULT 0,
  `allow_guest_requests` tinyint(64) NOT NULL DEFAULT 0,
  `client_cert_settings` set('allow','allow_client_only','allow_escrow','allow_client_private','allow_client_custom_public') NOT NULL,
  `client_cert_subroot_id` smallint(5) unsigned NOT NULL DEFAULT 34,
  `client_cert_support_phone` varchar(255) DEFAULT NULL,
  `client_cert_support_email` varchar(255) DEFAULT NULL,
  `client_cert_support_text` varchar(2500) DEFAULT NULL,
  `client_cert_api_return_url` varchar(255) DEFAULT NULL,
  `default_signature_hash` enum('sha1','sha256','sha384','sha512') NOT NULL DEFAULT 'sha1',
  `guest_request_token` varchar(50) DEFAULT NULL,
  `guest_request_ips` text DEFAULT NULL,
  `guest_request_ips_unrestricted` tinyint(1) DEFAULT 0,
  `separate_unit_funds` tinyint(4) NOT NULL DEFAULT 0,
  `ev_api_agreement_id` int(11) DEFAULT NULL,
  `allow_private_ssl` tinyint(4) NOT NULL DEFAULT 0,
  `gtld_account_enabled` tinyint(4) NOT NULL DEFAULT 0,
  `allow_wifi_in_gui` tinyint(4) NOT NULL DEFAULT 0,
  `whois_account_enabled` tinyint(4) NOT NULL DEFAULT 0,
  `default_validity` tinyint(3) unsigned DEFAULT 3,
  PRIMARY KEY (`acct_id`),
  KEY `idx_ekey` (`ekey`(6))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `ent_approval_rules` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `acct_id` int(6) unsigned zerofill NOT NULL,
  `name` varchar(255) NOT NULL,
  `sort_order` int(11) NOT NULL,
  `status` enum('active','inactive','deleted') NOT NULL,
  `created_by_id` int(11) NOT NULL,
  `cron` int(1) NOT NULL DEFAULT 0,
  `data` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2402 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `ent_client_certs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `product_id` int(10) unsigned DEFAULT NULL,
  `domain_id` int(10) unsigned NOT NULL DEFAULT 0,
  `company_id` int(10) unsigned NOT NULL DEFAULT 0,
  `common_name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `org_unit` varchar(255) DEFAULT NULL,
  `cert_profile_id` int(11) NOT NULL DEFAULT 1,
  `status` tinyint(3) unsigned NOT NULL DEFAULT 1,
  `reason` tinyint(3) unsigned NOT NULL DEFAULT 1,
  `date_requested` datetime DEFAULT NULL,
  `date_issued` datetime DEFAULT NULL,
  `lifetime` tinyint(3) unsigned DEFAULT NULL,
  `valid_from` date DEFAULT NULL,
  `valid_till` date DEFAULT NULL,
  `serial_number` varchar(128) DEFAULT NULL,
  `origin` enum('ui','api') DEFAULT 'ui',
  `renewals_left` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `renewal_record_exists` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `renewal_of_cert_id` int(10) unsigned NOT NULL DEFAULT 0,
  `approved_by` int(10) unsigned NOT NULL DEFAULT 0,
  `stat_row_id` int(10) unsigned NOT NULL DEFAULT 0,
  `ca_cert_id` smallint(6) unsigned NOT NULL DEFAULT 0,
  `receipt_id` int(10) unsigned NOT NULL DEFAULT 0,
  `email_token` varchar(32) DEFAULT NULL,
  `date_emailed` datetime DEFAULT NULL,
  `ca_order_id` int(10) unsigned NOT NULL DEFAULT 0,
  `csr` text DEFAULT NULL,
  `signature_hash` enum('sha1','sha256','sha384','sha512') NOT NULL DEFAULT 'sha1',
  `reissued_cert_id` int(10) unsigned NOT NULL DEFAULT 0,
  `reissue_email_sent` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `agreement_id` int(10) unsigned NOT NULL DEFAULT 0,
  `inpriva_email_validated` tinyint(4) NOT NULL DEFAULT 0,
  `is_out_of_contract` tinyint(1) NOT NULL DEFAULT 0,
  `user_id` int(10) unsigned DEFAULT NULL,
  `order_tracker_id` int(10) unsigned DEFAULT NULL,
  `thumbprint` varchar(40) DEFAULT NULL,
  `certificate_tracker_id` int(10) unsigned DEFAULT NULL,
  `unique_id` varchar(10) NOT NULL DEFAULT '',
  `pay_type` varchar(4) DEFAULT NULL,
  `disable_issuance_email` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `dns_names` text DEFAULT NULL,
  `additional_template_data` text DEFAULT NULL,
  `note` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `domain_id` (`domain_id`),
  KEY `company_id` (`company_id`),
  KEY `ent_client_certs_valid_from` (`valid_from`),
  KEY `is_out_of_contract` (`is_out_of_contract`),
  KEY `status` (`status`),
  KEY `order_tracker_id` (`order_tracker_id`),
  KEY `certificate_tracker_id_idx` (`certificate_tracker_id`),
  KEY `idx_reissued_cert_id` (`reissued_cert_id`),
  KEY `ix_renewal_id` (`renewal_of_cert_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1267593 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `ent_client_cert_data` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `client_cert_id` int(11) NOT NULL,
  `data` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8030 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `ent_client_cert_recovery_requests` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ent_client_cert_id` int(10) unsigned NOT NULL,
  `account_admin_id` int(10) unsigned NOT NULL,
  `recovery_admin_id` int(10) unsigned NOT NULL,
  `email_token` varchar(100) NOT NULL,
  `date_time` datetime NOT NULL,
  `recover_date_time` datetime NOT NULL,
  PRIMARY KEY (`id`,`email_token`),
  UNIQUE KEY `email_token` (`email_token`)
) ENGINE=InnoDB AUTO_INCREMENT=1921 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `ent_requests` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `acct_id` int(6) unsigned zerofill NOT NULL,
  `unit_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `alt_user_id` int(10) unsigned NOT NULL,
  `order_id` int(8) unsigned zerofill NOT NULL,
  `old_order_id` int(8) unsigned zerofill NOT NULL,
  `company_id` int(11) NOT NULL DEFAULT 0,
  `request_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `ip_address` varchar(15) NOT NULL,
  `action` enum('issue','revoke','renew','reissue','duplicate','new user') NOT NULL,
  `csr` text NOT NULL,
  `serversw` smallint(5) NOT NULL,
  `licenses` tinyint(4) NOT NULL,
  `common_names` text NOT NULL,
  `org_unit` varchar(255) NOT NULL,
  `lifetime` tinyint(4) NOT NULL,
  `product_id` int(11) NOT NULL,
  `status` set('pending','approved','rejected','preapproved') DEFAULT NULL,
  `mtime` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `comments` text NOT NULL,
  `admin_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `admin_id` int(10) unsigned DEFAULT NULL,
  `admin_note` text DEFAULT NULL,
  `auto_renew` tinyint(4) DEFAULT 0,
  `auto_renew_email_sent` tinyint(4) DEFAULT 0,
  `allow_unit_access` tinyint(1) NOT NULL DEFAULT 0,
  `valid_till` date NOT NULL DEFAULT '0000-00-00',
  `short_issue` date NOT NULL DEFAULT '0000-00-00',
  `signature_hash` enum('sha1','sha256','sha384','sha512') NOT NULL DEFAULT 'sha1',
  `root_path` enum('digicert','entrust','cybertrust','comodo') NOT NULL DEFAULT 'entrust',
  `grid_service_name` varchar(255) DEFAULT NULL,
  `promo_code` varchar(50) NOT NULL,
  `custom_fields` mediumtext DEFAULT NULL,
  `additional_emails` text DEFAULT NULL,
  `guest_request_name` varchar(255) DEFAULT NULL,
  `guest_request_email` varchar(255) DEFAULT NULL,
  `ip_outside_range` tinyint(1) DEFAULT 0,
  `order_users` varchar(255) DEFAULT NULL,
  `agreement_id` int(10) unsigned DEFAULT NULL,
  `ca_cert_id` smallint(4) unsigned DEFAULT NULL,
  `wifi_data` text DEFAULT NULL,
  `product_addons` text DEFAULT NULL,
  `ssl_profile_option` enum('data_encipherment','secure_email_eku') DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `acct_id` (`acct_id`),
  KEY `user_id` (`user_id`),
  KEY `order_id` (`order_id`),
  KEY `status` (`status`),
  KEY `unit_id` (`unit_id`),
  KEY `old_order_id` (`old_order_id`),
  KEY `company_id` (`company_id`)
) ENGINE=InnoDB AUTO_INCREMENT=720937 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `ent_request_docs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `file_path` varchar(255) DEFAULT NULL,
  `original_name` varchar(96) DEFAULT NULL,
  `upload_time` datetime DEFAULT '1900-01-01 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30022 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `ent_subdomains` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `domain_id` int(11) DEFAULT NULL,
  `subdomain` varchar(255) NOT NULL,
  `ctime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `domain_id` (`domain_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1012202 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `ent_units` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `acct_id` int(6) unsigned zerofill DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `allowed_domains` text NOT NULL,
  `moved_to_container_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `acct_id` (`acct_id`)
) ENGINE=InnoDB AUTO_INCREMENT=31585 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `ev_company_agreements` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `verified_contact_id` int(10) unsigned NOT NULL DEFAULT 0,
  `company_id` int(10) unsigned NOT NULL DEFAULT 0,
  `date_time` datetime NOT NULL,
  `ip_address` varchar(15) NOT NULL,
  `agreement_id` int(10) unsigned NOT NULL DEFAULT 0,
  `status` enum('active','inactive') DEFAULT 'active',
  `verified_contact_snapshot_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `company_id` (`company_id`),
  KEY `verified_contact_id` (`verified_contact_id`),
  KEY `status` (`status`),
  KEY `verified_contact_snapshot_id` (`verified_contact_snapshot_id`)
) ENGINE=InnoDB AUTO_INCREMENT=78900 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `ev_contacts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) NOT NULL,
  `company_id` int(11) NOT NULL,
  `role_id` tinyint(1) NOT NULL,
  `firstname` varchar(64) NOT NULL,
  `lastname` varchar(64) NOT NULL,
  `email` varchar(255) NOT NULL,
  `job_title` varchar(64) NOT NULL,
  `telephone` varchar(32) NOT NULL,
  `master_agreement_id` int(11) NOT NULL,
  `token` varchar(200) NOT NULL,
  `token_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `company_role` (`company_id`,`role_id`),
  KEY `user_id` (`user_id`),
  KEY `master_agreement_id_email` (`master_agreement_id`,`email`)
) ENGINE=InnoDB AUTO_INCREMENT=10795 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `ev_contacts_temp` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(8) unsigned zerofill NOT NULL,
  `role_id` tinyint(1) NOT NULL,
  `firstname` varchar(128) NOT NULL,
  `lastname` varchar(128) NOT NULL,
  `job_title` varchar(128) NOT NULL,
  `email` varchar(255) NOT NULL,
  `telephone` varchar(32) NOT NULL,
  `company_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `role_id` (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11995 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `ev_master_agreements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `company_id` int(11) NOT NULL,
  `date_signed` date NOT NULL,
  `date_entered` datetime NOT NULL,
  `valid_till` date NOT NULL,
  `doc_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `company_id` (`company_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2334 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `extended_order_info` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(10) unsigned NOT NULL,
  `valid_till` date DEFAULT NULL,
  `is_longer_validity_order` tinyint(1) DEFAULT 0,
  `auto_reissue` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_order_id` (`order_id`),
  KEY `ix_valid_till` (`valid_till`)
) ENGINE=InnoDB AUTO_INCREMENT=7667058 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `external_service_lookups` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` int(10) unsigned NOT NULL,
  `external_id` varchar(255) NOT NULL,
  `service` varchar(255) NOT NULL,
  `date_created` datetime NOT NULL DEFAULT current_timestamp(),
  `date_updated` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `external_service_lookups_account_id_idx` (`account_id`),
  KEY `external_service_lookups_service_id_idx` (`external_id`),
  KEY `external_service_lookups_service_idx` (`service`)
) ENGINE=InnoDB AUTO_INCREMENT=22050 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `feature` (
  `id` int(10) unsigned NOT NULL,
  `date_created` datetime DEFAULT NULL,
  `feature_name` varchar(255) NOT NULL,
  `display_name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `display_name_UNIQUE` (`display_name`),
  UNIQUE KEY `feature_name_UNIQUE` (`feature_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `file` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `extension` varchar(16) DEFAULT NULL,
  `path` varchar(255) DEFAULT NULL,
  `size` int(10) unsigned NOT NULL,
  `is_temporary` tinyint(4) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=243564 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `flags` (
  `id` tinyint(1) NOT NULL AUTO_INCREMENT,
  `number` tinyint(1) NOT NULL DEFAULT 0,
  `color` varchar(16) NOT NULL DEFAULT '',
  `description` varchar(128) NOT NULL DEFAULT '',
  `color_code` varchar(7) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`),
  KEY `color` (`color`),
  KEY `description` (`description`),
  KEY `color_code` (`color_code`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `followup_statuses` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `geo_address_override` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL DEFAULT current_timestamp(),
  `staff_id` int(10) unsigned NOT NULL,
  `company_id` int(10) unsigned NOT NULL,
  `order_id` int(11) DEFAULT NULL,
  `org_address` varchar(500) NOT NULL,
  `description` varchar(500) NOT NULL,
  `audited_date` datetime DEFAULT NULL,
  `audited_by` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`staff_id`),
  KEY `idx_company_id` (`company_id`),
  KEY `idx_order_id` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2583 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `geo_country_regions` (
  `country` varchar(2) NOT NULL DEFAULT '',
  `country_name` varchar(255) DEFAULT NULL,
  `region` varchar(255) DEFAULT NULL,
  `language` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`country`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `guest_request` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `requester_name` varchar(75) NOT NULL,
  `requester_email` varchar(75) NOT NULL,
  `request_date` datetime NOT NULL,
  `approve_date` datetime DEFAULT NULL,
  `container_id` int(11) NOT NULL,
  `note` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `hardenize_accounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(10) unsigned NOT NULL,
  `account_name` varchar(16) NOT NULL,
  `status` varchar(16) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `last_updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_id` (`account_id`),
  KEY `idx_account_id` (`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=446 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `hardenize_ct_notification_status` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `email_type` varchar(100) DEFAULT NULL,
  `email_status` tinyint(1) DEFAULT NULL,
  `api_request` text DEFAULT NULL,
  `email_recipients` varchar(100) DEFAULT NULL,
  `notification_trigger_time` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_account_id_email_type_notification_time` (`account_id`,`email_type`,`notification_trigger_time`)
) ENGINE=InnoDB AUTO_INCREMENT=1609 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `hardenize_order_ct_monitoring_status` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `order_id` bigint(20) NOT NULL,
  `hostname` varchar(1024) NOT NULL,
  `ct_monitoring_status` tinyint(1) DEFAULT NULL,
  `date_created` datetime NOT NULL DEFAULT current_timestamp(),
  `last_updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_order_id` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2177 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `hardware_order_extras` (
  `order_id` int(8) unsigned zerofill NOT NULL,
  `ship_name` varchar(128) DEFAULT NULL,
  `ship_addr1` varchar(128) DEFAULT NULL,
  `ship_addr2` varchar(128) DEFAULT NULL,
  `ship_city` varchar(128) DEFAULT NULL,
  `ship_state` varchar(128) DEFAULT NULL,
  `ship_zip` varchar(40) DEFAULT NULL,
  `ship_country` varchar(128) DEFAULT NULL,
  `ship_method` enum('STANDARD','EXPEDITED') DEFAULT NULL,
  `device_manufacturer` varchar(128) DEFAULT NULL,
  `device_serial` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `hardware_platforms` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `display_name` varchar(100) NOT NULL DEFAULT '',
  `product_name` varchar(100) NOT NULL DEFAULT '',
  `model` varchar(50) NOT NULL DEFAULT '',
  `manufacturer` varchar(100) NOT NULL DEFAULT '',
  `sort_order` int(11) NOT NULL DEFAULT 100,
  `driver_url` varchar(200) NOT NULL DEFAULT '',
  `device_type` enum('token','hsm') NOT NULL DEFAULT 'token',
  `fips_certified` varchar(20) NOT NULL DEFAULT '',
  `common_criteria_certified` varchar(30) NOT NULL DEFAULT '',
  `enabled_for_product` set('evcode','ds') NOT NULL DEFAULT 'evcode,ds',
  PRIMARY KEY (`id`),
  KEY `device_type` (`fips_certified`),
  KEY `common_criteria_certified` (`common_criteria_certified`),
  KEY `product_name` (`product_name`),
  KEY `manufacturer` (`manufacturer`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `hardware_ship_info` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(8) unsigned zerofill NOT NULL DEFAULT 00000000,
  `status` enum('pending','created','shipped','received') NOT NULL DEFAULT 'pending',
  `tracking_number` varchar(100) DEFAULT NULL,
  `date_mailed` datetime DEFAULT NULL,
  `date_received` datetime DEFAULT NULL,
  `hardware_otp` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=15093 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `hardware_token_info` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(8) unsigned zerofill NOT NULL DEFAULT 00000000,
  `init_code` varchar(128) NOT NULL,
  `status` enum('active','used','rejected') NOT NULL DEFAULT 'active',
  `date_generated` datetime DEFAULT NULL,
  `token_platform_id` int(11) NOT NULL DEFAULT 0,
  `token_info` text NOT NULL,
  `created_by_customer` tinyint(1) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `init_code` (`init_code`)
) ENGINE=InnoDB AUTO_INCREMENT=41174 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `heartbleed_certs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `acct_id` int(6) unsigned zerofill NOT NULL DEFAULT 000000,
  `order_id` int(8) unsigned zerofill NOT NULL DEFAULT 00000000,
  `status` enum('patch','replace','install','revoke','complete') NOT NULL DEFAULT 'patch',
  `serial_number` varchar(36) NOT NULL DEFAULT '',
  `thumbprint` varchar(42) NOT NULL DEFAULT '',
  `host_name` varchar(128) NOT NULL DEFAULT '',
  `ip_address` varchar(15) NOT NULL DEFAULT '',
  `port` smallint(5) unsigned NOT NULL DEFAULT 443,
  `valid_till` date NOT NULL DEFAULT '1900-01-01',
  `create_date` datetime NOT NULL DEFAULT '1900-01-01 00:00:00',
  `last_vulnerable` datetime NOT NULL DEFAULT '1900-01-01 00:00:00',
  `last_scanned` datetime NOT NULL DEFAULT '1900-01-01 00:00:00',
  `hash1` int(10) unsigned NOT NULL DEFAULT 0,
  `hash2` int(10) unsigned NOT NULL DEFAULT 0,
  `hash3` int(10) unsigned NOT NULL DEFAULT 0,
  `hash4` int(10) unsigned NOT NULL DEFAULT 0,
  `hash5` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `serial_number` (`serial_number`(8)),
  KEY `thumbprint` (`thumbprint`(8)),
  KEY `hash1` (`hash1`),
  KEY `host_lookup` (`ip_address`(6),`host_name`(4)),
  KEY `acct_id` (`acct_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14320 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `high_risk_clues` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `field_name` enum('email','org_name','country','contact_name','phone','domain','general_keyword','ip_address','whois') DEFAULT NULL,
  `match_type` enum('contains','startswith','endswith','regex','equals','slim_org_match') NOT NULL DEFAULT 'equals',
  `value` varchar(200) NOT NULL,
  `risk_score` int(11) NOT NULL DEFAULT 10,
  `created_by_staff_id` int(11) NOT NULL DEFAULT 0,
  `date_added` datetime NOT NULL,
  `reason` varchar(200) DEFAULT NULL,
  `limited_to_products` varchar(255) NOT NULL DEFAULT '',
  `limited_to_org_types` varchar(255) NOT NULL DEFAULT '',
  `status` enum('active','deleted') DEFAULT 'active',
  PRIMARY KEY (`id`),
  UNIQUE KEY `field_name_2` (`field_name`,`match_type`,`value`),
  KEY `field_name` (`field_name`),
  KEY `match_type` (`match_type`),
  KEY `value` (`value`)
) ENGINE=InnoDB AUTO_INCREMENT=5347 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `high_risk_clues_whitelist` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `high_risk_clue_id` int(10) unsigned NOT NULL,
  `account_id` int(10) unsigned NOT NULL,
  `is_active` tinyint(3) unsigned NOT NULL DEFAULT 1,
  `date_created` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `created_staff_id` smallint(5) unsigned NOT NULL,
  `date_inactivated` timestamp NULL DEFAULT NULL,
  `inactivated_staff_id` smallint(5) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `high_risk_clue_id` (`high_risk_clue_id`),
  KEY `account_id` (`account_id`),
  KEY `is_active` (`is_active`)
) ENGINE=InnoDB AUTO_INCREMENT=1577 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `hisp_account_extras` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `acct_id` int(11) DEFAULT NULL,
  `is_ra` int(1) NOT NULL DEFAULT 0,
  `accredited_roots` varchar(255) DEFAULT NULL,
  `non_accredited_root` int(11) DEFAULT NULL,
  `direct_trust_identifier` varchar(255) DEFAULT NULL,
  `accredited` tinyint(4) DEFAULT 0,
  `declaration_of_id_path` varchar(255) NOT NULL,
  `declaration_of_id_name` varchar(255) NOT NULL,
  `declaration_of_id_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `validation_contact` enum('isso','applicant','org_contact','hisp_contact') NOT NULL DEFAULT 'isso',
  `pre_validation_contact` enum('org_contact','hisp_contact') NOT NULL DEFAULT 'hisp_contact',
  `validation_level` enum('standard','minimum') DEFAULT 'standard',
  `single_use` int(1) DEFAULT 0,
  `use_npi` int(1) DEFAULT 0,
  `show_case_notes` tinyint(4) DEFAULT 0,
  `use_experian` int(1) DEFAULT 0,
  `products` set('address','org','device','fbca_address') DEFAULT 'address,org,device',
  PRIMARY KEY (`id`),
  UNIQUE KEY `acct_id` (`acct_id`),
  KEY `direct_trust_identifier` (`direct_trust_identifier`)
) ENGINE=InnoDB AUTO_INCREMENT=118 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `hisp_company_extras` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `company_id` int(11) NOT NULL,
  `agreement_id` int(11) DEFAULT NULL,
  `agreement_user_id` int(11) DEFAULT NULL,
  `ent_request_id` int(11) DEFAULT NULL,
  `level` enum('basic','medium') DEFAULT 'basic',
  `sole_proprietor` int(1) DEFAULT NULL,
  `hipaa_type` enum('covered','associate','other','notapplicable','notdeclared','patient') DEFAULT NULL,
  `accredited_root` int(11) DEFAULT 88,
  `validation_contact` enum('isso','applicant','org_contact','hisp_contact') NOT NULL DEFAULT 'isso',
  `pre_validation_contact` enum('org_contact','hisp_contact') NOT NULL DEFAULT 'hisp_contact',
  `declaration_of_id_path` varchar(255) NOT NULL,
  `declaration_of_id_name` varchar(255) NOT NULL,
  `declaration_of_id_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `single_use` int(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_company` (`company_id`),
  KEY `ent_request_id` (`ent_request_id`)
) ENGINE=InnoDB AUTO_INCREMENT=102805 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `hisp_ent_request_extras` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ent_request_id` int(11) DEFAULT NULL,
  `isso_id` int(11) DEFAULT NULL,
  `representative_id` int(11) DEFAULT NULL,
  `verified_contact_id` int(11) DEFAULT NULL,
  `level` enum('basic','medium') DEFAULT 'basic',
  `subject_individual_id` int(11) DEFAULT NULL,
  `ca_cert_id_deprecated` int(11) NOT NULL DEFAULT 0,
  `domain` text DEFAULT NULL,
  `subdomain` text DEFAULT NULL,
  `contact_email` varchar(255) DEFAULT NULL,
  `direct_email` varchar(255) DEFAULT NULL,
  `hipaa_type` enum('covered','associate','other','notapplicable','notdeclared','patient') DEFAULT NULL,
  `csr2` text DEFAULT NULL,
  `npi_id` int(11) DEFAULT NULL,
  `include_address` tinyint(1) DEFAULT NULL,
  `group_cert` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ent_request_id` (`ent_request_id`),
  KEY `npi_id` (`npi_id`)
) ENGINE=InnoDB AUTO_INCREMENT=269089 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `hisp_public_keys` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `acct_id` int(11) DEFAULT NULL,
  `type` set('encryption','signing','dual') DEFAULT NULL,
  `hash1` int(10) unsigned DEFAULT NULL,
  `hash2` int(10) unsigned DEFAULT NULL,
  `hash3` int(10) unsigned DEFAULT NULL,
  `hash4` int(10) unsigned DEFAULT NULL,
  `hash5` int(10) unsigned DEFAULT NULL,
  `issued_date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index2` (`acct_id`,`hash1`,`hash2`,`hash3`,`hash4`,`hash5`)
) ENGINE=InnoDB AUTO_INCREMENT=246779 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `hisp_user_extras` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `addr1` varchar(128) DEFAULT NULL,
  `addr2` varchar(128) DEFAULT NULL,
  `city` varchar(128) DEFAULT NULL,
  `state` varchar(128) DEFAULT NULL,
  `zip` varchar(40) DEFAULT NULL,
  `country` varchar(2) DEFAULT NULL,
  `agreement_id` int(11) DEFAULT NULL,
  `agreement_date` datetime DEFAULT NULL,
  `alternate_email` varchar(255) DEFAULT NULL,
  `level` set('basic','medium') DEFAULT 'basic',
  `access_certs` tinyint(1) DEFAULT 0,
  `isso` tinyint(1) DEFAULT 0,
  `representative` tinyint(1) DEFAULT 0,
  `trusted_agent` tinyint(1) DEFAULT 0,
  `all_hcos` tinyint(1) DEFAULT 0,
  `written_agreement` tinyint(1) DEFAULT 0,
  `ta_written_agreement` tinyint(1) DEFAULT 0,
  `encrypted_data` text NOT NULL,
  `user_completed` int(1) DEFAULT 0,
  `verification_method` enum('experian','doid') DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=137548 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `i18n_languages` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name_in_english` varchar(255) NOT NULL DEFAULT '',
  `name_in_language` varchar(255) NOT NULL,
  `abbreviation` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `abbr` (`abbreviation`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `imperva_block_ip_rules` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ip_address` varchar(40) NOT NULL DEFAULT '',
  `imperva_rule_id` int(11) NOT NULL,
  `created_time` datetime NOT NULL DEFAULT current_timestamp(),
  `disabled_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `imperva_rule_id` (`imperva_rule_id`),
  KEY `disabled_time` (`disabled_time`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `incentive_plans` (
  `id` tinyint(4) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `incident_communications_report_cache` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` int(10) unsigned DEFAULT NULL,
  `company_id` int(10) unsigned DEFAULT NULL,
  `company_name` varchar(256) DEFAULT NULL,
  `order_id` int(8) unsigned DEFAULT NULL,
  `reissue_id` int(11) DEFAULT NULL,
  `duplicate_id` int(11) DEFAULT NULL,
  `serial_number` varchar(36) DEFAULT NULL,
  `common_name` varchar(128) DEFAULT NULL,
  `sans` text DEFAULT NULL,
  `product_name` varchar(128) DEFAULT NULL,
  `valid_from` datetime DEFAULT NULL,
  `valid_to` datetime DEFAULT NULL,
  `revoked_status` varchar(16) DEFAULT NULL,
  `revoked_time` datetime DEFAULT NULL,
  `certificate_pem` mediumtext DEFAULT NULL,
  `primary_company_id` int(10) unsigned DEFAULT NULL,
  `account_class` varchar(50) DEFAULT NULL,
  `account_rep_name` varchar(256) DEFAULT NULL,
  `account_rep_email` varchar(256) DEFAULT NULL,
  `account_rep_phone` varchar(256) DEFAULT NULL,
  `order_org_contact_name` varchar(256) DEFAULT NULL,
  `order_org_contact_email` varchar(256) DEFAULT NULL,
  `order_org_contact_phone` varchar(256) DEFAULT NULL,
  `order_tech_contact_name` varchar(256) DEFAULT NULL,
  `order_tech_contact_email` varchar(256) DEFAULT NULL,
  `order_tech_contact_phone` varchar(256) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `staff_id` int(10) unsigned NOT NULL,
  `is_certcentral` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_order_reissue_duplicate` (`order_id`,`reissue_id`,`duplicate_id`),
  KEY `idx_account_id` (`account_id`),
  KEY `idx_serial_number` (`serial_number`),
  KEY `idx_order_id` (`order_id`),
  KEY `idx_date_created` (`date_created`)
) ENGINE=InnoDB AUTO_INCREMENT=398 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `intermediates` (
  `ca_cert_id` int(11) NOT NULL,
  `external_id` varchar(16) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT current_timestamp(),
  `type` enum('ev','ov','direct') DEFAULT NULL,
  `accredited` int(1) DEFAULT 0,
  `active` int(1) DEFAULT 1,
  `always_available` int(1) DEFAULT 1,
  `fbca` tinyint(4) DEFAULT 1,
  PRIMARY KEY (`ca_cert_id`),
  UNIQUE KEY `external_id` (`external_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `invoice` (
  `id` int(4) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `acct_id` int(6) unsigned zerofill NOT NULL DEFAULT 000000,
  `status` int(1) NOT NULL DEFAULT 1,
  `void` int(1) NOT NULL DEFAULT 0,
  `po_id` int(6) NOT NULL,
  `po_number` varchar(32) NOT NULL,
  `date` datetime NOT NULL,
  `terms` int(2) NOT NULL DEFAULT 10,
  `terms_eom` tinyint(4) DEFAULT 0,
  `date_due` datetime NOT NULL,
  `customer_contact` varchar(128) NOT NULL,
  `customer_contact_email` varchar(255) DEFAULT NULL,
  `technical_contact` varchar(128) NOT NULL,
  `invoice_name` varchar(128) NOT NULL,
  `invoice_address_1` varchar(64) NOT NULL,
  `invoice_address_2` varchar(64) DEFAULT NULL,
  `invoice_city` varchar(64) NOT NULL,
  `invoice_state` varchar(64) NOT NULL,
  `invoice_country` varchar(2) NOT NULL,
  `invoice_zip` varchar(10) DEFAULT NULL,
  `invoice_telephone` varchar(32) NOT NULL DEFAULT '',
  `invoice_telephone_ext` varchar(16) NOT NULL DEFAULT '',
  `invoice_amount` decimal(10,2) DEFAULT 0.00,
  `amount_owed` decimal(10,2) DEFAULT NULL,
  `has_history` int(1) DEFAULT 0,
  `notice_sent` tinyint(3) unsigned DEFAULT 0,
  `void_date` datetime DEFAULT NULL,
  `void_staff_id` int(10) unsigned DEFAULT NULL,
  `void_reason` text DEFAULT NULL,
  `notes` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `po_id` (`po_id`),
  KEY `acct_id` (`acct_id`)
) ENGINE=InnoDB AUTO_INCREMENT=192344 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `invoice_audit` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `action_id` int(10) unsigned DEFAULT NULL,
  `field_name` varchar(50) DEFAULT NULL,
  `old_value` varchar(255) DEFAULT NULL,
  `new_value` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3449278 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `invoice_audit_action` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `invoice_id` int(10) unsigned DEFAULT NULL,
  `staff_id` smallint(5) unsigned NOT NULL DEFAULT 0,
  `date_dt` datetime DEFAULT NULL,
  `action_type` varchar(255) DEFAULT NULL,
  `affected_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=568046 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `invoice_deposits` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `deposit_date` datetime DEFAULT NULL,
  `staff_id` int(10) unsigned NOT NULL DEFAULT 0,
  `payment_medium` varchar(12) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36180 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `invoice_history` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `invoice_id` int(8) NOT NULL,
  `note_date` datetime NOT NULL,
  `staff_id` int(10) unsigned NOT NULL DEFAULT 0,
  `payment_medium` varchar(45) DEFAULT NULL,
  `void` int(1) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `memo` text DEFAULT NULL,
  `amount_paid` decimal(10,2) DEFAULT NULL,
  `new_balance` decimal(10,2) DEFAULT NULL,
  `deposit_id` int(1) DEFAULT 0,
  `deposit_date` date DEFAULT NULL,
  `wire_fees_graced` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `invoice_id_idx` (`invoice_id`)
) ENGINE=InnoDB AUTO_INCREMENT=139579 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `invoice_nightly_report` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `count_over_100` int(5) NOT NULL DEFAULT 0,
  `value_over_100` decimal(10,2) NOT NULL DEFAULT 0.00,
  `percent_count_over_100` decimal(3,1) NOT NULL DEFAULT 0.0,
  `value_percent_over_100` decimal(3,1) NOT NULL DEFAULT 0.0,
  `count_over_50` int(5) NOT NULL DEFAULT 0,
  `value_over_50` decimal(10,2) NOT NULL DEFAULT 0.00,
  `percent_count_over_50` decimal(3,1) NOT NULL DEFAULT 0.0,
  `value_percent_over_50` decimal(3,1) NOT NULL DEFAULT 0.0,
  `count_over_20` int(5) NOT NULL DEFAULT 0,
  `value_over_20` decimal(10,2) NOT NULL DEFAULT 0.00,
  `percent_count_over_20` decimal(3,1) NOT NULL DEFAULT 0.0,
  `value_percent_over_20` decimal(3,1) NOT NULL DEFAULT 0.0,
  `total_open_invoices` int(5) NOT NULL DEFAULT 0,
  `total_open_value` decimal(10,2) NOT NULL DEFAULT 0.00,
  `funds_received` decimal(10,2) NOT NULL DEFAULT 0.00,
  `invoiced_today` decimal(10,2) NOT NULL DEFAULT 0.00,
  `received_today` decimal(10,2) NOT NULL DEFAULT 0.00,
  `currency` char(3) CHARACTER SET ascii NOT NULL DEFAULT 'USD',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10233 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `invoice_products` (
  `id` int(4) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `invoice_id` int(4) unsigned NOT NULL DEFAULT 0,
  `quantity` int(4) NOT NULL DEFAULT 0,
  `product` varchar(64) NOT NULL DEFAULT '',
  `years` tinyint(1) NOT NULL DEFAULT 0,
  `servers` int(4) NOT NULL DEFAULT 0,
  `license` enum('single','unlimited') NOT NULL DEFAULT 'single',
  `cred_amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `order_id` int(8) unsigned zerofill NOT NULL DEFAULT 00000000,
  `amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `order_ids` int(8) unsigned zerofill NOT NULL DEFAULT 00000000,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `invoice_statuses` (
  `id` tinyint(4) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  `short_name` varchar(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `ip_access` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime DEFAULT NULL,
  `acct_id` int(6) unsigned zerofill NOT NULL DEFAULT 000000,
  `container_id` int(11) DEFAULT NULL,
  `ent_unit_id` int(11) unsigned NOT NULL DEFAULT 0,
  `user_id` int(10) unsigned NOT NULL DEFAULT 0,
  `scope_container_id` int(11) DEFAULT NULL,
  `ip_address` varchar(15) NOT NULL DEFAULT '',
  `ip_address_end` varchar(15) NOT NULL DEFAULT '',
  `description` varchar(255) DEFAULT '',
  `guest_request_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_guest_request_id` (`guest_request_id`),
  KEY `acct_id` (`acct_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11167 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `key_recovery_admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_account` (`user_id`,`account_id`),
  KEY `account_id` (`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `legal_policies_hooks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL DEFAULT '',
  `link_text` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `legal_policies_links` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `link` text NOT NULL,
  `percentage` tinyint(3) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `logo_docs` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `hash` varchar(75) DEFAULT NULL,
  `doc_id` int(11) DEFAULT NULL,
  `company_id` int(11) DEFAULT NULL,
  `trademark_country_code` varchar(25) DEFAULT NULL,
  `trademark_office_url` varchar(25) DEFAULT NULL,
  `trademark_registration_number` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=320 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `log_account_settings_change` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_time` datetime NOT NULL DEFAULT current_timestamp() COMMENT 'The date and time of the account settings change',
  `ip_address` varchar(15) NOT NULL COMMENT 'The IP address that the user was using when they made the change',
  `staff_id` int(10) unsigned DEFAULT NULL COMMENT 'The staff id of the adminarea staff user who made the account settings change',
  `user_id` int(10) unsigned DEFAULT NULL COMMENT 'The user id of the customer who made the account settings change',
  `username` varchar(255) NOT NULL COMMENT 'The username of the adminarea user who made the account setting change',
  `account_id` int(10) unsigned NOT NULL COMMENT 'The id of the account that was affected',
  `setting` varchar(50) NOT NULL COMMENT 'A text tag that identifies the setting that was changed',
  `fieldname` varchar(50) NOT NULL COMMENT 'The database fieldname that was changed table.field',
  `old_value` varchar(255) NOT NULL COMMENT 'The previous value of the setting',
  `new_value` varchar(255) NOT NULL COMMENT 'The new value of the setting',
  `description` tinytext NOT NULL COMMENT 'A human readable description of the change',
  `note` tinytext DEFAULT NULL COMMENT 'An optional note explaining the change if the UI prompts for it',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `staff_id` (`staff_id`) USING BTREE,
  KEY `account_id` (`account_id`) USING BTREE,
  KEY `setting` (`setting`) USING BTREE,
  KEY `date_time` (`date_time`) USING BTREE,
  KEY `user_id` (`user_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7248 DEFAULT CHARSET=utf8 COMMENT='This table is used to track changes to account settings made through adminarea by DigiCert staff members or by customers through the CertCentral API or UI.';

CREATE TABLE IF NOT EXISTS `log_admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `staff_id` int(11) NOT NULL DEFAULT 0,
  `username` varchar(128) NOT NULL DEFAULT '',
  `date_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `ip_address` varchar(15) NOT NULL DEFAULT '',
  `description` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `log_admin_ip_address` (`ip_address`(6)),
  KEY `log_admin_description` (`description`(10)),
  KEY `staff_id` (`staff_id`)
) ENGINE=InnoDB AUTO_INCREMENT=56830412 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `log_email_clicks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uxtime` int(10) unsigned NOT NULL,
  `email_id` int(10) unsigned NOT NULL,
  `action` varchar(16) DEFAULT NULL,
  `email_description` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `email_id` (`email_id`),
  KEY `uxtime` (`uxtime`)
) ENGINE=InnoDB AUTO_INCREMENT=352236 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `log_email_opens` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uxtime` int(10) unsigned NOT NULL,
  `email_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `email_id` (`email_id`),
  KEY `uxtime` (`uxtime`)
) ENGINE=InnoDB AUTO_INCREMENT=3034760 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `log_email_templates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `language` varchar(2) NOT NULL DEFAULT '',
  `template` varchar(48) NOT NULL DEFAULT '',
  `tracking_hash` varchar(8) NOT NULL DEFAULT '',
  `acct_id` int(10) unsigned NOT NULL DEFAULT 0,
  `order_id` int(10) unsigned NOT NULL DEFAULT 0,
  `to` varchar(128) NOT NULL DEFAULT '',
  `data` mediumtext DEFAULT NULL,
  `extras` mediumtext DEFAULT NULL,
  `staff_id` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `template` (`template`(8)),
  KEY `date_time` (`date_time`)
) ENGINE=InnoDB AUTO_INCREMENT=125767171 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `log_forgot` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ip_address` varchar(15) NOT NULL DEFAULT '',
  `ip_country` char(2) DEFAULT NULL,
  `date_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `user_id` int(11) NOT NULL DEFAULT 0,
  `username` varchar(128) NOT NULL DEFAULT '',
  `result` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ip_address` (`ip_address`),
  KEY `date_time` (`date_time`)
) ENGINE=InnoDB AUTO_INCREMENT=122409 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `log_manual` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `staff_id` smallint(5) unsigned NOT NULL DEFAULT 0,
  `time_performed` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `log_action` int(4) unsigned zerofill NOT NULL DEFAULT 0000,
  `notes` text NOT NULL,
  `ip` varchar(15) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1294 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `manual_dcv` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `domain_public_id` varchar(255) NOT NULL,
  `dcv_type` varchar(255) DEFAULT NULL,
  `contact_info` text DEFAULT NULL,
  `screenshot_doc_id` varchar(255) DEFAULT NULL,
  `auth_doc_id` varchar(255) DEFAULT NULL,
  `staff_id_first_auth` int(11) DEFAULT NULL,
  `staff_id_second_auth` int(11) DEFAULT NULL,
  `first_auth_date` datetime NOT NULL,
  `second_auth_date` datetime DEFAULT NULL,
  `reject_date` datetime DEFAULT NULL,
  `random_value_doc_id` varchar(255) DEFAULT NULL,
  `random_value` varchar(100) DEFAULT NULL,
  `validation_url` varchar(3000) DEFAULT NULL,
  `audited_date` datetime DEFAULT NULL,
  `audited_by` int(10) unsigned DEFAULT NULL,
  `is_ip_address` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `ix_domain_public_id` (`domain_public_id`(8)),
  KEY `idx_dcv_type` (`dcv_type`),
  KEY `idx_first_auth` (`staff_id_first_auth`),
  KEY `idx_second_auth` (`staff_id_second_auth`),
  KEY `idx_is_ip` (`is_ip_address`)
) ENGINE=InnoDB AUTO_INCREMENT=136299 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `metadata` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `account_id` int(10) unsigned NOT NULL,
  `label` varchar(100) NOT NULL,
  `is_required` tinyint(1) NOT NULL DEFAULT 0,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `data_type` varchar(20) DEFAULT NULL,
  `description` varchar(512) DEFAULT NULL,
  `drop_down_options` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_account_id_label` (`account_id`,`label`)
) ENGINE=InnoDB AUTO_INCREMENT=7194 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `netsuite_invoice` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` int(10) unsigned NOT NULL,
  `container_id` int(10) unsigned NOT NULL,
  `date_created` datetime NOT NULL,
  `ns_so_internal_id` int(10) unsigned DEFAULT 0,
  `ns_inv_internal_id` int(10) unsigned DEFAULT 0,
  `ns_invoice_number` varchar(20) NOT NULL DEFAULT '',
  `ns_created_date` datetime DEFAULT NULL,
  `cc_invoice_id` int(10) unsigned NOT NULL COMMENT 'invoice.id',
  `item_subtotal` decimal(17,2) NOT NULL DEFAULT 0.00,
  `tax_subtotal` decimal(17,2) NOT NULL DEFAULT 0.00,
  `invoice_total` decimal(17,2) NOT NULL DEFAULT 0.00,
  `amount_remaining` decimal(17,2) NOT NULL DEFAULT 0.00,
  `invoice_email` varchar(192) NOT NULL DEFAULT '',
  `invoice_creation_type` enum('auto_invoice','invoice_for_po','wire_transfer_invoice') DEFAULT NULL,
  `invoice_memo` varchar(255) NOT NULL DEFAULT '',
  `currency` varchar(3) NOT NULL DEFAULT 'USD',
  `terms` enum('NET 30 EOM','NET 30','NET 45 EOM','NET 45','NET 60 EOM','NET 60','NET 90 EOM','NET 90') NOT NULL DEFAULT 'NET 30',
  `payment_method` enum('other','ns-invoice-payment','wire-transfer') NOT NULL DEFAULT 'other',
  `payment_status` enum('UNPAID','PAID') NOT NULL DEFAULT 'UNPAID',
  `cancel_date` datetime NOT NULL DEFAULT '1900-01-01 00:00:00',
  `payment_recorded_date` datetime NOT NULL DEFAULT '1900-01-01 00:00:00',
  `refund_required` tinyint(4) NOT NULL DEFAULT 0,
  `refund_completed` tinyint(4) NOT NULL DEFAULT 0,
  `netsuite_invoice_pdf_url` varchar(255) NOT NULL DEFAULT '',
  `voucher_order_id` int(10) unsigned DEFAULT 0,
  `ns_inv_due_date` datetime DEFAULT NULL,
  `ns_tran_date` datetime DEFAULT NULL,
  `receipt_id` int(10) unsigned NOT NULL,
  `billing_attention` varchar(255) NOT NULL DEFAULT '',
  `billing_org_name` varchar(255) NOT NULL DEFAULT '',
  `billing_addr1` varchar(255) NOT NULL DEFAULT '',
  `billing_addr2` varchar(255) NOT NULL DEFAULT '',
  `billing_city` varchar(128) NOT NULL DEFAULT '',
  `billing_state` varchar(64) NOT NULL DEFAULT '',
  `billing_zip` varchar(32) NOT NULL DEFAULT '',
  `billing_telephone` varchar(32) NOT NULL DEFAULT '',
  `billing_country` varchar(2) NOT NULL DEFAULT '',
  `customer_po_request_id` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `date_created` (`date_created`),
  KEY `account_id` (`account_id`),
  KEY `payment_status` (`payment_status`),
  KEY `ns_inv_internal_id` (`ns_inv_internal_id`),
  KEY `cc_invoice_id` (`cc_invoice_id`),
  KEY `idx_voucher_order_id` (`voucher_order_id`),
  KEY `idx_customer_po_request_id` (`customer_po_request_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10316 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `netsuite_invoice_item` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `netsuite_invoice_id` int(10) unsigned NOT NULL,
  `item_amount` decimal(17,2) NOT NULL DEFAULT 0.00,
  `product_id` int(11) NOT NULL DEFAULT 0,
  `sales_stat_id` int(11) NOT NULL DEFAULT 0,
  `order_id` int(11) NOT NULL DEFAULT 0,
  `reissue_id` int(10) unsigned DEFAULT 0 COMMENT 'customer_order_reissue_history.id',
  `order_transaction_id` int(10) unsigned DEFAULT 0,
  `validity_years` int(10) unsigned DEFAULT NULL,
  `validity_days` smallint(5) unsigned DEFAULT 0,
  `voucher_code_id` int(10) unsigned DEFAULT 0,
  `no_of_fqdns` tinyint(3) unsigned DEFAULT 0,
  `no_of_wildcards` tinyint(3) unsigned DEFAULT 0,
  `use_san_package` tinyint(1) DEFAULT NULL,
  `group_id` int(10) unsigned DEFAULT 0,
  `ns_external_product_id` varchar(32) DEFAULT NULL,
  `item_tax_amount` decimal(17,2) NOT NULL DEFAULT 0.00,
  `effective_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  `quantity` smallint(5) unsigned DEFAULT 0,
  `issuance_recorded` tinyint(3) unsigned DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `netsuite_invoice_id` (`netsuite_invoice_id`),
  KEY `sales_stat_id` (`sales_stat_id`),
  KEY `order_id` (`order_id`),
  KEY `reissue_id` (`reissue_id`),
  KEY `order_transaction_id` (`order_transaction_id`),
  KEY `idx_voucher_code_id` (`voucher_code_id`),
  KEY `idx_ns_external_product_id` (`ns_external_product_id`),
  KEY `idx_issuance_recorded` (`issuance_recorded`)
) ENGINE=InnoDB AUTO_INCREMENT=10558 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `netsuite_tax_transaction` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL DEFAULT current_timestamp(),
  `account_id` int(10) unsigned NOT NULL,
  `container_id` int(10) unsigned DEFAULT NULL,
  `tax_amount` decimal(18,2) NOT NULL,
  `start_date` datetime NOT NULL,
  `acct_adjust_id` int(10) unsigned NOT NULL,
  `order_id` int(8) unsigned NOT NULL DEFAULT 0,
  `voucher_order_id` int(10) unsigned NOT NULL DEFAULT 0,
  `currency` varchar(3) NOT NULL DEFAULT 'USD',
  PRIMARY KEY (`id`),
  KEY `ix_account_id` (`account_id`),
  KEY `ix_container_id` (`container_id`),
  KEY `ix_order_id` (`order_id`),
  KEY `ix_acct_adjust_id` (`acct_adjust_id`),
  KEY `ix_date_created` (`date_created`),
  KEY `ix_voucher_order_id` (`voucher_order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16370 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `netsuite_transaction` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `order_date` datetime NOT NULL COMMENT 'The date the original order was placed, whether or not it was issued',
  `start_date` datetime NOT NULL COMMENT 'The issue date (col_date) of the first certificate on the order, or in case of vouchers the transaction date',
  `end_date` date DEFAULT '0000-00-00' COMMENT 'For certs, should contain cert expiry date. For vouchers, col_date +1year. For multi-year plans, extended_order_info.valid_till',
  `account_id` int(10) unsigned NOT NULL COMMENT 'The account_id, except when a subaccount_order_transaction exists... then should contain billed_account_id',
  `container_id` int(10) unsigned DEFAULT NULL COMMENT 'The container_id, except when a subaccount_order_transaction exists... then it should contain the container_id for the billed_account_id. For non-container accounts (Direct Health) must be NULL.',
  `order_id` int(8) unsigned NOT NULL DEFAULT 0 COMMENT 'Must be populated for all orders and client_certs',
  `voucher_order_id` int(10) unsigned NOT NULL DEFAULT 0,
  `gross_amount` decimal(18,2) NOT NULL COMMENT 'Positive or negative, but should never be 0. Do not insert a netsuite_transaction record if the amount is $0',
  `tax_amount` decimal(18,2) NOT NULL COMMENT 'Calculated tax amount',
  `total_amount` decimal(18,2) NOT NULL COMMENT 'Sum of gross_amount + tax_amount',
  `currency` varchar(3) NOT NULL DEFAULT 'USD' COMMENT 'The currency for gross_amount, tax_amount, and total_amount',
  `product_id` int(11) DEFAULT NULL COMMENT 'The product_id of the transaction.',
  `type` enum('order','rejection','refund','invoice-refund') NOT NULL DEFAULT 'order' COMMENT 'Transaction type',
  `pay_type` enum('acct-credit','credit-card','wire-deposit','check-deposit','po-deposit') DEFAULT NULL COMMENT 'Payment Method used for this transaction',
  `parent_transaction_id` int(10) unsigned DEFAULT NULL COMMENT 'This field is not sent to NetSuite, but helps track the original netsuite_transaction id for refunds/revokes',
  `receipt_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'This field is not sent to NetSuite, but is stored to facilitate tracking and debugging any issues that could arise',
  PRIMARY KEY (`id`),
  KEY `ix_account_id` (`account_id`),
  KEY `ix_container_id` (`container_id`),
  KEY `ix_order_id` (`order_id`),
  KEY `ix_parent_transaction_id` (`parent_transaction_id`),
  KEY `ix_receipt_id` (`receipt_id`),
  KEY `ix_date_created` (`date_created`),
  KEY `ix_voucher_order_id` (`voucher_order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=507120 DEFAULT CHARSET=utf8 COMMENT='This table is used to record financial transactions that need to be integrated to and recorded in NetSuite.';

CREATE TABLE IF NOT EXISTS `notes_deleted` (
  `id` int(10) unsigned NOT NULL,
  `acct_id` int(10) unsigned DEFAULT NULL,
  `order_id` int(10) unsigned DEFAULT NULL,
  `company_id` int(10) unsigned DEFAULT NULL,
  `domain_id` int(10) unsigned DEFAULT NULL,
  `reissue_id` int(10) unsigned DEFAULT NULL,
  `staff_id` int(10) unsigned DEFAULT NULL,
  `date_time` datetime NOT NULL,
  `sticky` int(11) DEFAULT NULL,
  `note` text NOT NULL,
  `del_date_time` datetime NOT NULL,
  `del_staff_id` int(10) unsigned DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `notes_shared` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `acct_id` int(10) unsigned NOT NULL DEFAULT 0,
  `order_id` int(10) unsigned NOT NULL DEFAULT 0,
  `company_id` int(10) unsigned NOT NULL DEFAULT 0,
  `domain_id` int(10) unsigned NOT NULL DEFAULT 0,
  `reissue_id` int(10) unsigned NOT NULL DEFAULT 0,
  `staff_id` int(10) unsigned NOT NULL DEFAULT 0,
  `date_time` datetime NOT NULL,
  `sticky` int(11) NOT NULL DEFAULT 0,
  `is_support` tinyint(4) NOT NULL DEFAULT 0,
  `is_suspension_reason` tinyint(1) NOT NULL DEFAULT 0,
  `note` text NOT NULL,
  `container_id` int(10) unsigned NOT NULL DEFAULT 0,
  `notetype` varchar(45) NOT NULL DEFAULT 'order',
  `important` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `date_time` (`date_time`),
  KEY `fk_company_assertions_acct` (`acct_id`),
  KEY `fk_company_assertions_order` (`order_id`),
  KEY `fk_company_assertions_companies` (`company_id`),
  KEY `fk_company_assertions_domains` (`domain_id`),
  KEY `fk_company_assertions_reissues` (`reissue_id`),
  KEY `staff_id` (`staff_id`),
  KEY `container_id` (`container_id`)
) ENGINE=InnoDB AUTO_INCREMENT=28420045 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `notifications` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `staff_id` int(11) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `notification` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `npi` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `npi` varchar(10) NOT NULL,
  `verified_contact_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `company_id` int(11) DEFAULT NULL,
  `acct_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `acct_id` (`acct_id`,`npi`)
) ENGINE=InnoDB AUTO_INCREMENT=670 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `nrnotes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(8) unsigned zerofill DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `note` text DEFAULT NULL,
  `staff_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `date_index` (`date`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=463645 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `oem_accounts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `account_id` int(10) unsigned NOT NULL,
  `account_type` varchar(45) DEFAULT NULL,
  `oem_account_id` varchar(45) DEFAULT NULL,
  `master_account_id` int(10) DEFAULT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'inactive',
  `migrated_date` timestamp NULL DEFAULT NULL,
  `auto_import_certificates` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `migration_complete` tinyint(1) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_account_id` (`account_id`),
  KEY `idx_oem_master_account_id` (`oem_account_id`,`master_account_id`),
  KEY `idx_account_status` (`status`),
  KEY `idx_migration_complete` (`migration_complete`)
) ENGINE=InnoDB AUTO_INCREMENT=1244384 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `oem_order_migration_queue` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` int(10) unsigned NOT NULL,
  `date_created` datetime NOT NULL DEFAULT current_timestamp(),
  `start_time` datetime DEFAULT NULL,
  `completed_time` datetime DEFAULT NULL,
  `orders_migrated` int(10) unsigned NOT NULL DEFAULT 0,
  `exception_thrown` tinyint(4) NOT NULL DEFAULT 0,
  `total_pages` int(11) NOT NULL DEFAULT 0,
  `current_page` int(11) NOT NULL DEFAULT 0,
  `last_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `start_on_page` int(11) NOT NULL DEFAULT 0,
  `bookmark` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `ix_date_created` (`date_created`),
  KEY `ix_account` (`account_id`),
  KEY `ix_completed` (`completed_time`)
) ENGINE=InnoDB AUTO_INCREMENT=3101834 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `oem_orgs_sent_to_validation` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `organization_id` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2954 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `orders` (
  `id` int(8) unsigned zerofill NOT NULL,
  `last_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `po_id` int(4) unsigned zerofill NOT NULL DEFAULT 0000,
  `reseller_id` int(6) unsigned zerofill NOT NULL DEFAULT 000000,
  `user_id` int(11) unsigned DEFAULT 0,
  `company_id` int(11) NOT NULL DEFAULT 0,
  `domain_id` int(11) NOT NULL DEFAULT 0,
  `common_name` varchar(255) NOT NULL DEFAULT '',
  `org_unit` varchar(255) NOT NULL,
  `org_contact_id` int(11) NOT NULL DEFAULT 0,
  `tech_contact_id` int(11) NOT NULL DEFAULT 0,
  `product_id` int(11) DEFAULT NULL,
  `trial` tinyint(4) NOT NULL DEFAULT 0,
  `origin` enum('retail','enterprise') DEFAULT 'retail',
  `value` decimal(10,2) DEFAULT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 1,
  `reason` tinyint(4) NOT NULL DEFAULT 1,
  `date_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `lifetime` tinyint(4) NOT NULL DEFAULT 0,
  `servers` int(4) NOT NULL DEFAULT 0,
  `addons` varchar(255) NOT NULL,
  `csr` text NOT NULL,
  `serversw` smallint(5) NOT NULL DEFAULT 0,
  `pay_type` varchar(4) NOT NULL DEFAULT '1',
  `do_not_charge_cc` tinyint(4) DEFAULT 0,
  `ca_order_id` int(11) NOT NULL DEFAULT 0,
  `ca_apply_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `ca_status` smallint(6) NOT NULL DEFAULT 0,
  `ca_collect_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `ca_error_msg` varchar(255) NOT NULL DEFAULT '',
  `valid_from` date NOT NULL DEFAULT '0000-00-00',
  `valid_till` date NOT NULL DEFAULT '0000-00-00',
  `short_issue` date NOT NULL DEFAULT '0000-00-00',
  `extra_days` int(11) NOT NULL,
  `serial_number` varchar(128) NOT NULL,
  `is_renewed` tinyint(1) NOT NULL DEFAULT 0,
  `renewed_order_id` int(8) unsigned zerofill NOT NULL DEFAULT 00000000,
  `is_first_order` tinyint(1) NOT NULL DEFAULT 0,
  `upgrade` tinyint(4) NOT NULL DEFAULT 0,
  `flag` tinyint(1) NOT NULL DEFAULT 0,
  `send_minus_104` tinyint(1) DEFAULT 1,
  `send_minus_90` tinyint(1) NOT NULL DEFAULT 0,
  `send_minus_60` tinyint(1) NOT NULL DEFAULT 1,
  `send_minus_30` tinyint(1) NOT NULL DEFAULT 1,
  `send_minus_7` tinyint(1) NOT NULL DEFAULT 1,
  `send_minus_3` tinyint(1) DEFAULT 1,
  `send_plus_7` tinyint(1) NOT NULL DEFAULT 1,
  `make_renewal_calls` tinyint(1) NOT NULL DEFAULT 1,
  `minus_104_sent` tinyint(1) DEFAULT 0,
  `minus_90_sent` tinyint(1) NOT NULL DEFAULT 0,
  `minus_60_sent` tinyint(1) NOT NULL DEFAULT 0,
  `minus_30_sent` tinyint(1) NOT NULL DEFAULT 0,
  `minus_7_sent` tinyint(1) NOT NULL DEFAULT 0,
  `minus_3_sent` tinyint(1) DEFAULT 0,
  `plus_7_sent` tinyint(1) NOT NULL DEFAULT 0,
  `send_renewal_notices` tinyint(1) NOT NULL DEFAULT 1,
  `in_progress` tinyint(1) NOT NULL DEFAULT 0,
  `comodo_submitted` tinyint(1) NOT NULL DEFAULT 0,
  `followup_status` tinyint(4) NOT NULL DEFAULT 1,
  `followup_date` date NOT NULL,
  `snooze_until` datetime DEFAULT '2000-01-01 00:00:00',
  `ip_address` varchar(15) NOT NULL DEFAULT '',
  `approved_by` int(11) NOT NULL DEFAULT 0,
  `approved_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `take_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `issuing_ca` varchar(64) NOT NULL DEFAULT 'digicertca',
  `promo_code` varchar(17) NOT NULL,
  `show_addr_on_seal` tinyint(1) NOT NULL DEFAULT 0,
  `post_order_done` tinyint(1) NOT NULL DEFAULT 0,
  `stat_row_id` int(11) NOT NULL DEFAULT 0,
  `names_stat_row_id` int(11) NOT NULL DEFAULT 0,
  `test_order` tinyint(1) NOT NULL DEFAULT 0,
  `hide` tinyint(1) NOT NULL DEFAULT 0,
  `vip` tinyint(1) NOT NULL DEFAULT 0,
  `ca_cert_id` smallint(4) NOT NULL DEFAULT 33,
  `plus_feature` tinyint(4) DEFAULT 0,
  `whois_status` tinyint(4) NOT NULL DEFAULT 0,
  `mark_audit` tinyint(1) NOT NULL DEFAULT 0,
  `internal_audit` int(10) unsigned DEFAULT 0,
  `internal_audit_date` datetime DEFAULT NULL,
  `receipt_id` int(10) NOT NULL DEFAULT 0,
  `root_path` enum('digicert','entrust','cybertrust','comodo') DEFAULT 'digicert',
  `root_path_orig` enum('digicert','entrust','cybertrust','comodo') DEFAULT 'digicert',
  `order_options` set('hide_street_address','easy_ev','renew_90_days','auto_renew','show_street_address') DEFAULT NULL,
  `timezone_id` smallint(6) NOT NULL DEFAULT 0,
  `risk_score` smallint(5) unsigned DEFAULT NULL,
  `agreement_id` int(10) unsigned NOT NULL DEFAULT 0,
  `cs_provisioning_method` enum('none','ship_token','client_app','email','api') NOT NULL DEFAULT 'none',
  `checklist_modifiers` varchar(30) NOT NULL,
  `signature_hash` enum('sha1','sha256','sha384','sha512') NOT NULL DEFAULT 'sha1',
  `reached` tinyint(4) NOT NULL DEFAULT 0,
  `gtld_status` tinyint(3) unsigned DEFAULT NULL,
  `certificate_tracker_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `po_id` (`po_id`),
  KEY `reselling_partner_id` (`reseller_id`),
  KEY `domain_id` (`domain_id`),
  KEY `org_contact_id` (`org_contact_id`),
  KEY `product_id` (`product_id`),
  KEY `status` (`status`),
  KEY `reason` (`reason`),
  KEY `date_time` (`date_time`),
  KEY `serversw` (`serversw`),
  KEY `renewed_order_id` (`renewed_order_id`),
  KEY `flag` (`flag`),
  KEY `stat_row_id` (`stat_row_id`),
  KEY `followup_date` (`followup_date`),
  KEY `orders_send_renewal_notices` (`send_renewal_notices`),
  KEY `orders_valid_till` (`valid_till`),
  KEY `order_serial` (`serial_number`(10)),
  KEY `orders_user_id` (`user_id`),
  KEY `orders_snooze` (`snooze_until`),
  KEY `orders_company_id` (`company_id`),
  KEY `in_progress` (`in_progress`),
  KEY `receipt_id` (`receipt_id`),
  KEY `last_updated` (`last_updated`),
  KEY `orders_valid_from` (`valid_from`),
  KEY `certificate_tracker_id` (`certificate_tracker_id`),
  KEY `orders_approved_by` (`approved_by`),
  KEY `common_name` (`common_name`(14))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `orders_declined` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `acct_id` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `common_name` varchar(200) DEFAULT NULL,
  `visible` tinyint(4) NOT NULL DEFAULT 1,
  `suspicious` enum('stolen_or_lost','bank_has_questions','general_decline','') DEFAULT '',
  `ip_address` varchar(15) DEFAULT '',
  `ip_address_int` int(10) unsigned DEFAULT NULL,
  `cc_error_msg` varchar(255) DEFAULT '',
  `cc_info` varchar(16) NOT NULL DEFAULT '',
  `note` text DEFAULT NULL,
  `note_timestamp` datetime DEFAULT NULL,
  `note_staff_id` int(11) DEFAULT NULL,
  `session_info` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ip_address` (`ip_address`),
  KEY `visible` (`visible`),
  KEY `acct_id` (`acct_id`),
  KEY `cc_error_msg` (`cc_error_msg`(32)),
  KEY `common_name` (`common_name`(12))
) ENGINE=InnoDB AUTO_INCREMENT=1329756 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_action_queue` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `container_id` int(10) unsigned NOT NULL,
  `date_created` datetime NOT NULL,
  `order_tracker_id` int(10) unsigned NOT NULL,
  `action_type` tinyint(3) unsigned NOT NULL,
  `action_status` tinyint(3) unsigned NOT NULL,
  `requester_user_id` int(10) unsigned NOT NULL,
  `reviewer_user_id` int(10) unsigned NOT NULL DEFAULT 0,
  `processor_user_id` int(10) unsigned DEFAULT NULL,
  `date_processed` datetime DEFAULT NULL,
  `certificate_id` int(10) unsigned DEFAULT NULL,
  `comments` varchar(255) DEFAULT NULL,
  `processor_comment` varchar(255) DEFAULT NULL,
  `guest_requester_first_name` varchar(255) DEFAULT NULL,
  `guest_requester_last_name` varchar(255) DEFAULT NULL,
  `guest_requester_email` varchar(255) DEFAULT NULL,
  `date_reviewed` datetime DEFAULT NULL,
  `order_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_container_id_action_status` (`container_id`,`action_status`),
  KEY `ix_order_tracker_id` (`order_tracker_id`),
  KEY `action_status` (`action_status`),
  KEY `ix_requester_user_id` (`requester_user_id`),
  KEY `ix_order_id` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11491497 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_api_key_map` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(10) unsigned NOT NULL,
  `api_permission_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_order_id` (`order_id`),
  KEY `idx_api_permission_id` (`api_permission_id`)
) ENGINE=InnoDB AUTO_INCREMENT=112426760 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_approvals` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(8) unsigned zerofill NOT NULL,
  `reissue_id` int(11) NOT NULL DEFAULT 0,
  `verified_contact_id` int(10) unsigned NOT NULL,
  `date_time` datetime NOT NULL,
  `ip_address` varchar(15) NOT NULL,
  `order_details` text NOT NULL,
  `origin` enum('email','phone') NOT NULL DEFAULT 'email',
  `staff_id` int(11) NOT NULL DEFAULT 0,
  `staff_note` text NOT NULL,
  `status` enum('active','inactive') DEFAULT 'active',
  `verified_contact_snapshot_id` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `verified_contact_id` (`verified_contact_id`),
  KEY `status` (`status`),
  KEY `verified_contact_snapshot_id` (`verified_contact_snapshot_id`),
  KEY `reissue_id` (`reissue_id`)
) ENGINE=InnoDB AUTO_INCREMENT=763143 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_approvals_oem` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cert_id` varchar(32) NOT NULL,
  `verified_contact_id` int(10) unsigned NOT NULL,
  `date_time` datetime NOT NULL,
  `ip_address` varchar(15) NOT NULL,
  `origin` enum('email','phone') NOT NULL DEFAULT 'email',
  `order_approvals_oem_invite_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cert_id_idx` (`cert_id`)
) ENGINE=InnoDB AUTO_INCREMENT=18222 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_approvals_oem_delegation` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `organization_id` int(10) unsigned NOT NULL,
  `verified_contact_id` int(10) unsigned NOT NULL,
  `created_by_staff_id` int(10) unsigned NOT NULL,
  `date_created` datetime NOT NULL,
  `note` text DEFAULT NULL,
  `ip_address` varchar(255) DEFAULT NULL,
  `approver_name` varchar(130) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_verified_contact_id` (`verified_contact_id`),
  KEY `idx_organization_id` (`organization_id`)
) ENGINE=InnoDB AUTO_INCREMENT=87953 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_approvals_oem_delegation_invites` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `organization_id` int(10) unsigned NOT NULL,
  `verified_contact_id` int(10) unsigned NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `sent_by_staff_id` int(10) unsigned NOT NULL,
  `date_sent` datetime NOT NULL,
  `order_approvals_oem_delegation_id` int(11) DEFAULT NULL,
  `token` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_verified_contact_id` (`verified_contact_id`)
) ENGINE=InnoDB AUTO_INCREMENT=49537 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_approvals_oem_invites` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cert_id` varchar(32) NOT NULL,
  `verified_contact_id` int(10) unsigned NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `sent_by_staff_id` int(10) unsigned DEFAULT NULL,
  `date_sent` datetime NOT NULL,
  `token` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cert_id_idx` (`cert_id`)
) ENGINE=InnoDB AUTO_INCREMENT=46084 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_benefits` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(10) unsigned NOT NULL,
  `actual_price` decimal(10,2) DEFAULT 0.00,
  `discount_percent` decimal(5,2) DEFAULT 0.00,
  `validity_benefit_days` smallint(5) unsigned DEFAULT NULL,
  `benefits` text DEFAULT NULL,
  `benefits_data` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_order_id` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1128 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_cert_transparency` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(10) unsigned DEFAULT NULL,
  `date_disabled` datetime DEFAULT NULL,
  `date_enabled` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=920036 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_checkmarks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(10) unsigned NOT NULL,
  `reissue_id` int(10) unsigned DEFAULT NULL,
  `checkmark_id` int(10) unsigned NOT NULL,
  `date_created` datetime NOT NULL,
  `checklist_step_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_checkmarks_order_id_idx` (`order_id`),
  KEY `order_checkmarks_checkmark_id_idx` (`checkmark_id`)
) ENGINE=InnoDB AUTO_INCREMENT=538858219 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_common_names_snapshots` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `order_id` int(10) unsigned NOT NULL,
  `reissue_id` int(10) unsigned DEFAULT NULL,
  `common_name_id` int(10) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `is_common_name` tinyint(1) NOT NULL DEFAULT 0,
  `active` tinyint(1) DEFAULT NULL,
  `domain_id` int(10) unsigned DEFAULT NULL,
  `approve_id` int(10) unsigned DEFAULT NULL,
  `status` enum('active','inactive','pending') DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_common_names_snapshots_order_id_idx` (`order_id`),
  KEY `domain_id` (`domain_id`),
  KEY `common_name_id` (`common_name_id`)
) ENGINE=InnoDB AUTO_INCREMENT=99331949 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_company_snapshots` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `order_id` int(10) unsigned NOT NULL,
  `reissue_id` int(10) unsigned DEFAULT NULL,
  `company_id` int(10) unsigned NOT NULL,
  `acct_id` int(6) unsigned DEFAULT NULL,
  `org_contact_id` int(11) DEFAULT NULL,
  `tech_contact_id` int(11) DEFAULT NULL,
  `bill_contact_id` int(11) DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `ev_status` tinyint(4) DEFAULT NULL,
  `org_name` varchar(255) DEFAULT NULL,
  `org_type` int(10) DEFAULT NULL,
  `org_assumed_name` varchar(255) DEFAULT NULL,
  `org_unit` varchar(64) DEFAULT NULL,
  `org_addr1` varchar(128) DEFAULT NULL,
  `org_addr2` varchar(128) DEFAULT NULL,
  `org_zip` varchar(40) DEFAULT NULL,
  `org_city` varchar(128) DEFAULT NULL,
  `org_state` varchar(128) DEFAULT NULL,
  `org_country` varchar(2) DEFAULT NULL,
  `org_email` varchar(128) DEFAULT NULL,
  `telephone` varchar(32) DEFAULT NULL,
  `org_reg_num` varchar(200) DEFAULT NULL,
  `jur_city` varchar(128) DEFAULT NULL,
  `jur_state` varchar(128) DEFAULT NULL,
  `jur_country` varchar(2) DEFAULT NULL,
  `incorp_agency` varchar(255) DEFAULT NULL,
  `master_agreement_sent` tinyint(1) DEFAULT NULL,
  `locked` tinyint(1) DEFAULT NULL,
  `validated_until` datetime DEFAULT NULL,
  `ov_validated_until` datetime DEFAULT NULL,
  `ev_validated_until` datetime DEFAULT NULL,
  `active` tinyint(4) DEFAULT 1,
  `public_phone` varchar(32) DEFAULT NULL,
  `public_email` varchar(128) DEFAULT NULL,
  `ascii_name` varchar(255) DEFAULT NULL,
  `address_validated_date` datetime DEFAULT NULL,
  `incorp_agency_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_company_snapshots_order_id_idx` (`order_id`),
  KEY `ix_company_id` (`company_id`),
  KEY `idx_account_id` (`acct_id`),
  KEY `incorp_agency_id` (`incorp_agency_id`)
) ENGINE=InnoDB AUTO_INCREMENT=34038823 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_duplicates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(8) unsigned zerofill NOT NULL DEFAULT 00000000,
  `sub_id` int(3) unsigned zerofill NOT NULL DEFAULT 000,
  `ca_order_id` varchar(18) NOT NULL,
  `date_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `staff_id` int(11) NOT NULL DEFAULT 0,
  `status` tinyint(4) NOT NULL DEFAULT 1,
  `collected` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `serial_number` varchar(128) NOT NULL,
  `csr` text NOT NULL,
  `serversw` smallint(5) NOT NULL DEFAULT 0,
  `sans` text NOT NULL,
  `common_name` varchar(255) NOT NULL,
  `org_unit` varchar(100) DEFAULT NULL,
  `ca_cert_id` smallint(6) NOT NULL DEFAULT 33,
  `revoked` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `hidden` tinyint(4) DEFAULT 0,
  `thumbprint` varchar(40) DEFAULT '',
  `customer_note` text DEFAULT NULL,
  `signature_hash` enum('sha1','sha256','sha384','sha512') NOT NULL DEFAULT 'sha1',
  `root_path` enum('digicert','entrust','cybertrust','comodo') NOT NULL DEFAULT 'entrust',
  `data_encipherment` tinyint(4) NOT NULL DEFAULT 0,
  `string_type` enum('PS','T61','UTF8','AUTO') NOT NULL DEFAULT 'AUTO',
  `in_progress` tinyint(1) NOT NULL DEFAULT 0,
  `certificate_tracker_id` int(10) unsigned DEFAULT NULL,
  `csr_key_type` varchar(3) NOT NULL DEFAULT '',
  `request_id` int(11) DEFAULT NULL,
  `type` set('other','encryption','signing') DEFAULT 'other',
  `user_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `addl_uc_order_id` (`order_id`),
  KEY `addl_uc_hidden` (`hidden`),
  KEY `collected_index` (`collected`),
  KEY `certificate_tracker_id` (`certificate_tracker_id`),
  KEY `request_id` (`request_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1406710 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_extras` (
  `order_id` int(8) unsigned zerofill NOT NULL,
  `asa_option` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `unit_id` int(10) unsigned NOT NULL DEFAULT 0,
  `allow_unit_access` tinyint(1) NOT NULL DEFAULT 0,
  `thumbprint` varchar(40) DEFAULT '',
  `ent_check1_staff_id` int(11) DEFAULT NULL,
  `ent_check2_staff_id` int(11) DEFAULT NULL,
  `additional_emails` text DEFAULT NULL,
  `wildcard_sans` text DEFAULT NULL,
  `dc_guid` varchar(64) NOT NULL DEFAULT '',
  `key_usage` varchar(96) NOT NULL DEFAULT '',
  `show_phone` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `show_email` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `show_address` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `cert_registration_number` varchar(128) NOT NULL,
  `is_out_of_contract` tinyint(1) NOT NULL DEFAULT 0,
  `direct_hipaa_type` enum('covered','associate','other') DEFAULT NULL,
  `wifi_option` enum('logo','friendlyname','both') DEFAULT NULL,
  `service_name` varchar(32) NOT NULL DEFAULT '',
  `ssl_profile_option` varchar(32) NOT NULL DEFAULT '',
  `subject_email` varchar(128) NOT NULL DEFAULT '',
  `custom_renewal_message` text DEFAULT NULL,
  `disable_renewal_notifications` tinyint(1) NOT NULL DEFAULT 0,
  `disable_issuance_email` tinyint(3) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`order_id`),
  KEY `ent_check1_staff_id` (`ent_check1_staff_id`),
  KEY `ent_check2_staff_id` (`ent_check2_staff_id`),
  KEY `unit_id` (`unit_id`),
  KEY `is_out_of_contract` (`is_out_of_contract`),
  KEY `idx_disable_renewal_notifications` (`disable_renewal_notifications`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_guest_access` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` int(10) unsigned NOT NULL,
  `order_id` int(10) unsigned NOT NULL,
  `fqdn` varchar(256) NOT NULL,
  `date_created` datetime NOT NULL,
  `email` varchar(256) NOT NULL,
  `hashkey` varchar(128) NOT NULL,
  `fqdn_linked_orders` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25272 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_high_risk_clues_map` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `high_risk_clues_id` int(11) DEFAULT NULL,
  `order_id` int(11) DEFAULT NULL,
  `reference_id` int(11) DEFAULT NULL,
  `reason_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `origin` enum('DigiCert','other') DEFAULT 'DigiCert',
  PRIMARY KEY (`id`),
  KEY `high_risk_clues_id` (`high_risk_clues_id`),
  KEY `order_id` (`order_id`,`reference_id`)
) ENGINE=InnoDB AUTO_INCREMENT=675 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_iceberg` (
  `order_id` int(8) unsigned zerofill NOT NULL DEFAULT 00000000,
  `json` text DEFAULT NULL,
  `incoming_email_sent` tinyint(4) NOT NULL DEFAULT 0,
  `issuance_email_sent` tinyint(4) NOT NULL DEFAULT 0,
  `insert_date` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_ids` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=125139768 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_installer_token` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `token` varchar(45) NOT NULL,
  `order_id` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `sub_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_token` (`token`),
  KEY `idx_order_id` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13382179 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_install_notes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(10) unsigned NOT NULL,
  `date_time` datetime DEFAULT NULL,
  `install_status` varchar(50) DEFAULT NULL,
  `install_data` text DEFAULT NULL,
  `staff_id` int(11) DEFAULT NULL,
  `staff_note` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7501390 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_install_status` (
  `order_id` int(10) unsigned NOT NULL,
  `install_status` varchar(40) DEFAULT 'unchecked',
  `followup_status` enum('pending','complete') NOT NULL DEFAULT 'pending',
  `date_last_checked` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `snooze_until` datetime DEFAULT NULL,
  `sent_email` tinyint(4) DEFAULT NULL,
  `extra_info` text DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  KEY `install_status` (`install_status`),
  KEY `followup_status` (`followup_status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_metadata` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `order_id` int(10) unsigned NOT NULL,
  `metadata_id` int(10) unsigned NOT NULL,
  `value` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_item_metadata_id` (`order_id`,`metadata_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3095254 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_origin_cookies` (
  `order_id` int(10) unsigned NOT NULL,
  `acct_id` int(10) unsigned DEFAULT NULL,
  `origin` varchar(255) DEFAULT NULL,
  `date_recorded` datetime DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  KEY `acct_id` (`acct_id`),
  KEY `date_recorded` (`date_recorded`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_pay_types` (
  `id` tinyint(4) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL DEFAULT '',
  `nb_abbr` varchar(8) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_price_computation` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(10) unsigned NOT NULL,
  `account_id` int(10) unsigned NOT NULL,
  `actual_price` decimal(10,2) DEFAULT 0.00,
  `computed_price` decimal(10,2) DEFAULT 0.00,
  `revenue` decimal(12,2) DEFAULT 0.00,
  PRIMARY KEY (`id`),
  KEY `ix_order_id` (`order_id`),
  KEY `ix_account_id` (`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9619012 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_price_recalculation` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` int(10) unsigned NOT NULL,
  `created` datetime NOT NULL DEFAULT current_timestamp(),
  `start_time` datetime DEFAULT NULL,
  `completed_time` datetime DEFAULT NULL,
  `orders_updated` int(10) unsigned NOT NULL DEFAULT 0,
  `status` enum('pending','running','completed','incomplete','stopped') NOT NULL DEFAULT 'pending',
  `last_updated_order` int(10) unsigned NOT NULL DEFAULT 0,
  `last_update_time` datetime DEFAULT current_timestamp(),
  `generate_report` tinyint(4) DEFAULT 0,
  `from_date` date DEFAULT curdate(),
  `to_date` date DEFAULT curdate(),
  PRIMARY KEY (`id`),
  KEY `idx_status` (`status`),
  KEY `idx_account_id` (`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=252 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_renewal_notices` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(10) unsigned NOT NULL,
  `minus_90_sent` tinyint(1) NOT NULL DEFAULT 0,
  `minus_60_sent` tinyint(1) NOT NULL DEFAULT 0,
  `minus_30_sent` tinyint(1) NOT NULL DEFAULT 0,
  `minus_7_sent` tinyint(1) NOT NULL DEFAULT 0,
  `minus_3_sent` tinyint(1) NOT NULL DEFAULT 0,
  `plus_7_sent` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_order_id` (`order_id`),
  KEY `ix_minus_90_sent` (`minus_90_sent`),
  KEY `ix_minus_60_sent` (`minus_60_sent`),
  KEY `ix_minus_30_sent` (`minus_30_sent`),
  KEY `ix_minus_7_sent` (`minus_7_sent`),
  KEY `ix_minus_3_sent` (`minus_3_sent`),
  KEY `ix_plus_7_sent` (`plus_7_sent`)
) ENGINE=InnoDB AUTO_INCREMENT=16998435 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_renewal_stats` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(10) unsigned DEFAULT NULL,
  `ctime` timestamp NOT NULL DEFAULT '2000-01-01 07:00:00',
  `mtime` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `renewal_disposition` enum('renewed_with_us','still_has_our_expired_cert','competitor_cert','doesnt_resolve','unable_to_connect','no_certificate_found','invalid_name','private_ip','self_signed_cert','untrusted_or_unknown_ca','') NOT NULL DEFAULT '',
  `product_id` int(11) DEFAULT NULL,
  `valid_till` date NOT NULL DEFAULT '0000-00-00',
  `new_order_id` int(8) unsigned zerofill NOT NULL,
  `new_acct_id` int(6) unsigned zerofill NOT NULL DEFAULT 000000,
  `new_valid_from` date NOT NULL DEFAULT '0000-00-00',
  `new_valid_till` date NOT NULL DEFAULT '0000-00-00',
  `new_issuer_name` varchar(64) NOT NULL DEFAULT '',
  `new_ca_group` varchar(64) NOT NULL DEFAULT '',
  `new_product_type` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `order_id` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17231001 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_request` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `order_tracker_id` int(10) unsigned NOT NULL,
  `order_action_queue_id` int(10) unsigned NOT NULL,
  `status` tinyint(3) unsigned NOT NULL,
  `reason` tinyint(3) unsigned NOT NULL,
  `product_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `organization_id` int(10) unsigned NOT NULL,
  `agreement_id` int(10) unsigned NOT NULL,
  `cert_profile_id` int(10) unsigned DEFAULT NULL,
  `organization_unit` varchar(255) DEFAULT NULL,
  `lifetime` int(10) unsigned NOT NULL,
  `csr` text DEFAULT NULL,
  `common_name` varchar(255) NOT NULL,
  `dns_names` text NOT NULL,
  `server_platform_id` int(11) DEFAULT NULL,
  `ip_address` varchar(15) DEFAULT NULL,
  `ca_cert_id` int(10) unsigned DEFAULT NULL,
  `signature_hash` varchar(15) NOT NULL,
  `key_size` smallint(5) unsigned DEFAULT NULL,
  `root_path` varchar(20) NOT NULL,
  `email` varchar(1024) DEFAULT NULL,
  `origin` varchar(30) DEFAULT NULL,
  `service_name` varchar(150) DEFAULT NULL,
  `custom_expiration_date` datetime DEFAULT NULL,
  `renewal_of_order_id` int(11) DEFAULT NULL,
  `extra_input` text DEFAULT NULL,
  `cs_provisioning_method` varchar(15) NOT NULL DEFAULT 'none',
  `addons` varchar(255) DEFAULT NULL,
  `auto_renew` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `additional_emails` text DEFAULT NULL,
  `user_assignments` varchar(255) DEFAULT NULL,
  `promo_code` varchar(100) DEFAULT NULL,
  `receipt_id` int(11) DEFAULT NULL,
  `is_out_of_contract` tinyint(3) NOT NULL DEFAULT 0,
  `disable_renewal_notifications` tinyint(1) NOT NULL DEFAULT 0,
  `order_validation_notes` varchar(2000) DEFAULT NULL,
  `disable_issuance_email` tinyint(3) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `ix_order_tracker_id` (`order_tracker_id`),
  KEY `order_action_queue_id` (`order_action_queue_id`),
  KEY `idx_renewal_of_order_id` (`renewal_of_order_id`),
  KEY `receipt_id` (`receipt_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10550915 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_request_extras` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `order_request_id` int(10) unsigned NOT NULL,
  `ship_name` varchar(128) DEFAULT NULL,
  `ship_addr1` varchar(128) DEFAULT NULL,
  `ship_addr2` varchar(128) DEFAULT NULL,
  `ship_city` varchar(128) DEFAULT NULL,
  `ship_state` varchar(128) DEFAULT NULL,
  `ship_zip` varchar(40) DEFAULT NULL,
  `ship_country` varchar(128) DEFAULT NULL,
  `ship_method` enum('STANDARD','EXPEDITED') DEFAULT NULL,
  `subject_name` varchar(150) DEFAULT NULL,
  `subject_job_title` varchar(150) DEFAULT NULL,
  `subject_phone` varchar(150) DEFAULT NULL,
  `subject_email` varchar(150) DEFAULT NULL,
  `custom_renewal_message` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_order_request_id` (`order_request_id`)
) ENGINE=InnoDB AUTO_INCREMENT=110675 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_status_map` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `status_id` int(10) unsigned NOT NULL,
  `reason_id` int(10) unsigned NOT NULL,
  `customer_order_status` varchar(32) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_status_reason` (`status_id`,`reason_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_tor_service_descriptors` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(10) unsigned NOT NULL,
  `uri` varchar(2048) NOT NULL,
  `public_key` text NOT NULL,
  `date_created` datetime NOT NULL,
  `staff_id_created_by` int(10) unsigned NOT NULL,
  `date_deleted` datetime NOT NULL,
  `staff_id_deleted_by` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=455 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_tracker` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `container_id` int(10) unsigned DEFAULT NULL,
  `order_id` int(10) unsigned NOT NULL,
  `type` tinyint(3) unsigned NOT NULL,
  `product_name_id` varchar(64) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `order_id` (`order_id`),
  KEY `ix_order_id` (`order_id`),
  KEY `ix_container_id` (`container_id`)
) ENGINE=InnoDB AUTO_INCREMENT=125754161 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_transaction` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `container_id` int(10) unsigned NOT NULL,
  `order_id` int(10) unsigned NOT NULL,
  `receipt_id` int(10) unsigned DEFAULT NULL,
  `acct_adjust_id` int(10) unsigned DEFAULT NULL,
  `po_id` int(10) unsigned DEFAULT NULL,
  `amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `payment_type` varchar(50) NOT NULL,
  `transaction_date` datetime NOT NULL,
  `transaction_type` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_container_id` (`container_id`),
  KEY `ix_order_id` (`order_id`),
  KEY `ix_receipt_id` (`receipt_id`),
  KEY `ix_acct_adjust_id` (`acct_adjust_id`)
) ENGINE=InnoDB AUTO_INCREMENT=119571130 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `date_added` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`,`user_id`),
  KEY `idx_user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=118441989 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_verified_contacts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(8) unsigned zerofill NOT NULL,
  `verified_contact_id` int(11) NOT NULL,
  `checklist_role_ids` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `order_verified_contact_id` (`order_id`,`verified_contact_id`),
  KEY `verified_contact_id` (`verified_contact_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19200709 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_verified_contacts_snapshots` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `order_id` int(8) unsigned NOT NULL DEFAULT 0,
  `reissue_id` int(10) unsigned NOT NULL DEFAULT 0,
  `verified_contact_id` int(10) unsigned NOT NULL,
  `status` enum('pending','active','inactive') NOT NULL DEFAULT 'pending',
  `user_id` int(10) NOT NULL,
  `company_id` int(11) NOT NULL,
  `firstname` varchar(64) NOT NULL,
  `lastname` varchar(64) NOT NULL,
  `email` varchar(255) NOT NULL,
  `job_title` varchar(64) NOT NULL,
  `telephone` varchar(32) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `order_id_idx` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=18111911 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_verified_emails` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(6) unsigned zerofill NOT NULL,
  `verified_contact_id` int(10) unsigned NOT NULL,
  `date_verified` datetime DEFAULT NULL,
  `cert_common_name` varchar(64) NOT NULL DEFAULT '',
  `email` varchar(128) NOT NULL DEFAULT '',
  `ip_address` varchar(15) NOT NULL DEFAULT '',
  `status` enum('active','inactive') DEFAULT 'active',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4131 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_wifi_friendly_names` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL,
  `friendlyname_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1367 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_wifi_logos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(10) unsigned NOT NULL,
  `language` char(3) NOT NULL,
  `uri` text NOT NULL,
  `doc_id` int(10) unsigned DEFAULT NULL,
  `content_type` varchar(100) DEFAULT NULL,
  `date_retrieved` timestamp NULL DEFAULT NULL,
  `date_created` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1367 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `organization_contact_snapshots` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `verified_contact_id` int(10) unsigned DEFAULT NULL,
  `checklist_id` int(10) unsigned DEFAULT NULL,
  `organization_id` int(10) unsigned DEFAULT NULL,
  `snapshot_data` blob DEFAULT NULL,
  `snapshot_date` datetime DEFAULT NULL,
  `snapshot_br_version` varchar(32) DEFAULT NULL,
  `contact_valid_from` datetime DEFAULT NULL,
  `doc_valid_from` datetime DEFAULT NULL,
  `snapshot_checklist_version` varchar(16) DEFAULT NULL,
  `max_validity_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_org_checklist` (`verified_contact_id`,`checklist_id`),
  KEY `idx_verified_contact_id` (`verified_contact_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3045554 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `organization_container_assignments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `organization_id` int(11) NOT NULL,
  `container_id` int(11) NOT NULL,
  `date_created` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_organization_id` (`organization_id`),
  KEY `idx_container_id` (`container_id`)
) ENGINE=InnoDB AUTO_INCREMENT=126947 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `organization_logo` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL DEFAULT current_timestamp(),
  `organization_id` int(10) unsigned NOT NULL,
  `logo` mediumtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_org_id` (`organization_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `organization_metadata` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `organization_id` int(11) DEFAULT NULL,
  `brand` varchar(256) DEFAULT NULL,
  `context_data` varchar(256) DEFAULT NULL,
  `locale` varchar(5) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `customer_comment_template` varchar(255) DEFAULT NULL,
  `customer_comment_lang` varchar(5) DEFAULT NULL,
  `customer_comment_date` datetime DEFAULT NULL,
  `customer_comment` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_organization` (`organization_id`)
) ENGINE=InnoDB AUTO_INCREMENT=410278 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `organization_snapshots` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `organization_id` int(10) unsigned DEFAULT NULL,
  `checklist_id` int(10) unsigned DEFAULT NULL,
  `snapshot_data` blob DEFAULT NULL,
  `snapshot_date` datetime DEFAULT NULL,
  `snapshot_br_version` varchar(32) DEFAULT NULL,
  `org_valid_from` datetime DEFAULT NULL,
  `doc_valid_from` datetime DEFAULT NULL,
  `snapshot_checklist_version` varchar(16) DEFAULT NULL,
  `max_validity_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_org_checklist` (`organization_id`,`checklist_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2917340 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `organization_validation_cache` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `organization_id` int(11) DEFAULT NULL,
  `checklist_id` int(11) DEFAULT NULL,
  `valid_from` date DEFAULT NULL,
  `valid_until` date DEFAULT NULL,
  `date_created` datetime DEFAULT current_timestamp(),
  `last_updated` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_org_checklist` (`organization_id`,`checklist_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1568283 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `org_types` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `ou_account_exemptions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` int(10) unsigned NOT NULL,
  `date_created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_account_id` (`account_id`) USING HASH
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `ou_blacklist` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` int(10) unsigned NOT NULL DEFAULT 0,
  `ou_value` varchar(128) NOT NULL,
  `staff_id` int(11) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_account_ou` (`account_id`,`ou_value`)
) ENGINE=InnoDB AUTO_INCREMENT=10195 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `ou_whitelist` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` int(10) unsigned NOT NULL,
  `ou_value` varchar(128) NOT NULL,
  `staff_id` int(11) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `staff_id2` int(10) unsigned DEFAULT NULL,
  `note` text DEFAULT NULL,
  `document_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_account_value` (`account_id`,`ou_value`),
  KEY `ix_date_created` (`date_created`)
) ENGINE=InnoDB AUTO_INCREMENT=215860 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `payment_profiles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `gty_profile_id` varchar(32) NOT NULL,
  `cc_label` varchar(128) DEFAULT NULL,
  `cc_last4` varchar(4) DEFAULT NULL,
  `cc_exp_month` varchar(2) DEFAULT NULL,
  `cc_exp_year` varchar(4) DEFAULT NULL,
  `cc_type` enum('amex','visa','mastercard','discover','other','none') NOT NULL DEFAULT 'none',
  `bill_name` varchar(128) DEFAULT NULL,
  `bill_org_name` varchar(128) DEFAULT NULL,
  `bill_addr1` varchar(128) DEFAULT NULL,
  `bill_addr2` varchar(128) DEFAULT NULL,
  `bill_city` varchar(128) DEFAULT NULL,
  `bill_state` varchar(128) DEFAULT NULL,
  `bill_zip` varchar(40) DEFAULT NULL,
  `bill_country` varchar(2) DEFAULT NULL,
  `bill_email` varchar(255) DEFAULT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 1,
  `gty_status` varchar(64) NOT NULL DEFAULT '',
  `payment_gty` varchar(32) NOT NULL DEFAULT 'cybersource',
  `date_created` datetime NOT NULL,
  `new_profile_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=91342 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `direct_group` set('view_HCO','view_users','view_requests','view_certificates','view_domains','account_settings','edit_users','edit_roles','edit_users_hco','all_HCOs','all_ISSOs','all_users','request_cert','request_address_cert','request_org_cert','request_device_cert','additional_emails','approve_requests','reject_requests','edit_requests','view_certificate','add_order_notes','delete_order_notes','view_order_notes','rekey_cert','revoke_cert','cancel_order','download_cert','view_order_duplicates','deposit_funds','view_balance') DEFAULT NULL,
  `direct_group2` set('view_documents','all_documents','upload_documents','view_balance_history','edit_self','edit_HCO','edit_ISSO','view_contacts','edit_contacts','expire_documents','download_documents','edit_contacts_hco','custom_fields','delete_hco','deactivate_hco','create_users','create_contacts','approval_rules','delete_domains','approve_domains','edit_domains','add_domains','submit_domains','resend_dcv','import','case_notes','request_fbca_address_cert') DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `permissions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=94 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `permission_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `acct_id` int(11) DEFAULT NULL,
  `permission_id` int(11) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `description` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `permission_id` (`permission_id`),
  KEY `acct_id` (`acct_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `permission_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  `type` set('grant','revoke') DEFAULT NULL,
  `level` set('group','user') DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `permission_id` (`user_id`,`permission_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=37534 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `php_sessions` (
  `s_num` varchar(32) NOT NULL,
  `s_mtime` int(11) DEFAULT NULL,
  `s_ctime` int(11) DEFAULT NULL,
  `s_data` mediumtext DEFAULT NULL,
  `s_user_type` enum('cust','staff') NOT NULL DEFAULT 'cust',
  PRIMARY KEY (`s_num`),
  KEY `php_sessions_mtime` (`s_mtime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `pki_notes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(8) unsigned zerofill DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `note` text DEFAULT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_orderid` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=57142798 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `po` (
  `id` int(4) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `acct_id` int(6) unsigned zerofill NOT NULL DEFAULT 000000,
  `flag` tinyint(4) NOT NULL DEFAULT 0,
  `status` tinyint(4) NOT NULL DEFAULT 0,
  `invoice_number` int(8) DEFAULT NULL,
  `invoice_status` tinyint(1) NOT NULL DEFAULT 1,
  `notes` text DEFAULT NULL,
  `date_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `contact_name` varchar(128) NOT NULL DEFAULT '',
  `electronic_signature` varchar(128) DEFAULT NULL,
  `email` varchar(128) NOT NULL DEFAULT '',
  `telephone` varchar(32) NOT NULL DEFAULT '',
  `telephone_ext` varchar(16) NOT NULL DEFAULT '',
  `fax` varchar(32) NOT NULL DEFAULT '',
  `org_name` varchar(128) NOT NULL DEFAULT '',
  `org_addr1` varchar(128) NOT NULL DEFAULT '',
  `org_addr2` varchar(128) NOT NULL DEFAULT '',
  `org_city` varchar(64) NOT NULL DEFAULT '',
  `org_state` varchar(64) NOT NULL DEFAULT '',
  `org_country` varchar(2) NOT NULL DEFAULT '0',
  `org_zip` varchar(10) NOT NULL DEFAULT '',
  `inv_term` int(2) DEFAULT 10,
  `inv_term_eom` tinyint(4) DEFAULT 0,
  `inv_contact_name` varchar(128) NOT NULL DEFAULT '',
  `inv_email` varchar(128) NOT NULL DEFAULT '',
  `inv_telephone` varchar(32) NOT NULL DEFAULT '',
  `inv_telephone_ext` varchar(16) NOT NULL DEFAULT '',
  `inv_fax` varchar(32) NOT NULL DEFAULT '',
  `inv_org_name` varchar(128) NOT NULL DEFAULT '',
  `inv_org_addr1` varchar(128) NOT NULL DEFAULT '',
  `inv_org_addr2` varchar(128) NOT NULL DEFAULT '',
  `inv_org_city` varchar(64) NOT NULL DEFAULT '',
  `inv_org_state` varchar(64) NOT NULL DEFAULT '',
  `inv_org_country` varchar(2) NOT NULL DEFAULT '',
  `inv_org_zip` varchar(10) NOT NULL DEFAULT '',
  `po_number` varchar(32) NOT NULL DEFAULT '',
  `amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `amount_owed` decimal(10,2) DEFAULT NULL,
  `reject_notes` varchar(255) NOT NULL DEFAULT '',
  `reject_date_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `reject_staff` int(10) unsigned NOT NULL DEFAULT 0,
  `inv_send_mail` tinyint(1) NOT NULL DEFAULT 0,
  `inv_send_fax` tinyint(1) NOT NULL DEFAULT 0,
  `invoice_sent` tinyint(1) NOT NULL DEFAULT 0,
  `hard_copy_name` varchar(128) NOT NULL DEFAULT '',
  `paid_amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `paid_date_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `send_email_reminders` tinyint(4) NOT NULL DEFAULT 1,
  `send_from` int(10) unsigned DEFAULT NULL,
  `date_last_emailed` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `unit_id` int(11) NOT NULL DEFAULT 0,
  `container_id` int(10) unsigned DEFAULT NULL,
  `is_internal` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `converted_from_quote` datetime DEFAULT NULL,
  `quote_expiration_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `status` (`status`),
  KEY `invoice_status` (`invoice_status`),
  KEY `idx_acct` (`acct_id`),
  KEY `idx_invoice_number` (`invoice_number`),
  KEY `container_id` (`container_id`)
) ENGINE=InnoDB AUTO_INCREMENT=215631 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `po_audit` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `action_id` int(10) unsigned DEFAULT NULL,
  `field_name` varchar(50) DEFAULT NULL,
  `old_value` text DEFAULT NULL,
  `new_value` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1030437 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `po_audit_action` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `po_id` int(10) unsigned DEFAULT NULL,
  `staff_id` smallint(5) unsigned NOT NULL DEFAULT 0,
  `date_dt` datetime DEFAULT NULL,
  `action_type` varchar(255) DEFAULT NULL,
  `affected_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=668575 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `po_contact` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `po_id` int(10) unsigned NOT NULL,
  `name` varchar(128) DEFAULT NULL,
  `email` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_po_id` (`po_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16408 DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `po_docs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `po_id` int(4) unsigned zerofill NOT NULL DEFAULT 0000,
  `filename` varchar(128) NOT NULL DEFAULT '',
  `ctime` datetime NOT NULL,
  `notes` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_po_id` (`po_id`)
) ENGINE=InnoDB AUTO_INCREMENT=92352 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `po_flags` (
  `id` tinyint(1) NOT NULL AUTO_INCREMENT,
  `number` tinyint(1) NOT NULL DEFAULT 0,
  `color` varchar(16) NOT NULL DEFAULT '',
  `description` varchar(128) NOT NULL DEFAULT '',
  `color_code` varchar(7) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `po_invoice_statuses` (
  `id` tinyint(4) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `po_notes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `po_id` int(8) unsigned zerofill DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `note` text DEFAULT NULL,
  `staff_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `po_notes_po_id` (`po_id`),
  KEY `date_index` (`date`)
) ENGINE=InnoDB AUTO_INCREMENT=1082493 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `po_prod` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) NOT NULL DEFAULT 0,
  `order_id` int(8) unsigned zerofill NOT NULL DEFAULT 00000000,
  `years` tinyint(1) NOT NULL DEFAULT 0,
  `servers` int(4) NOT NULL DEFAULT 0,
  `license` enum('single','unlimited') NOT NULL DEFAULT 'single',
  `po_id` int(4) unsigned zerofill NOT NULL DEFAULT 0000,
  `redeemed` tinyint(1) NOT NULL DEFAULT 0,
  `status` tinyint(4) NOT NULL DEFAULT 1,
  `amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `domain` varchar(255) NOT NULL DEFAULT '',
  `cred_amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `addl_cn_price` decimal(10,2) NOT NULL DEFAULT 0.00,
  `product_name_id` varchar(64) DEFAULT NULL,
  `purchased_wildcard_names` int(10) unsigned NOT NULL DEFAULT 0,
  `addl_wc_price` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `po_id` (`po_id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2390594 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `po_prod_addons` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `po_prod_id` int(10) unsigned NOT NULL,
  `addon_id` int(10) unsigned NOT NULL,
  `amount` decimal(10,0) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `po_prod_id` (`po_prod_id`),
  KEY `po_addon_addon_id` (`addon_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13648 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `po_prod_statuses` (
  `id` tinyint(4) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `po_statuses` (
  `id` tinyint(4) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `practical_demo_tokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `domain_id` int(11) NOT NULL,
  `name_scope` varchar(255) DEFAULT NULL,
  `date_submitted` datetime DEFAULT NULL,
  `expiration_date` datetime DEFAULT NULL,
  `confirmed_date` datetime DEFAULT NULL,
  `cert_approval_id` int(11) DEFAULT NULL,
  `token_target` varchar(255) DEFAULT NULL,
  `token` varchar(255) DEFAULT NULL,
  `method` varchar(32) DEFAULT NULL,
  `scope_id` varchar(255) DEFAULT NULL,
  `container_domain_id` varchar(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_domain_id` (`domain_id`,`name_scope`),
  KEY `idx_container_domain_id` (`container_domain_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1753677 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `pre_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `public_id` varchar(255) NOT NULL,
  `date_created` datetime NOT NULL,
  `expire_date` datetime DEFAULT NULL,
  `date_processed` datetime DEFAULT NULL,
  `type` enum('SAML') NOT NULL,
  `container_id` int(11) NOT NULL,
  `order_data` text NOT NULL,
  `order_id` int(11) DEFAULT NULL,
  `person_id` varchar(255) DEFAULT NULL,
  `idp_entity_id` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `public_id_UNIQUE` (`public_id`)
) ENGINE=InnoDB AUTO_INCREMENT=90091 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `pricing_contracts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `acct_id` int(6) unsigned NOT NULL,
  `date_time` datetime NOT NULL,
  `created_by_staff_id` int(10) unsigned NOT NULL,
  `effective_date` datetime NOT NULL,
  `term_length` tinyint(4) NOT NULL,
  `end_date` datetime NOT NULL,
  `auto_renewal` tinyint(4) NOT NULL,
  `service_fee` decimal(10,2) NOT NULL,
  `service_fee_limit_type` enum('year','term','6months','quarter','month') NOT NULL DEFAULT 'year',
  `total_cert_limit` varchar(10) NOT NULL,
  `total_ssl_cert_limit` varchar(10) NOT NULL,
  `total_client_cert_limit` varchar(10) NOT NULL,
  `limit_type` enum('year','term') NOT NULL DEFAULT 'year',
  `product_limits` text DEFAULT NULL,
  `pricing_model` enum('flatfee','percert','combined','tiered','tiered_revenue','prepay','none') DEFAULT NULL,
  `discount_type` enum('none','percent_all','percent_each','fixed') NOT NULL DEFAULT 'none',
  `total_domain_limit` varchar(5) NOT NULL,
  `price_locking` enum('30_days_notice','year','term') NOT NULL DEFAULT '30_days_notice',
  `needs_cps_change_notices` tinyint(4) NOT NULL DEFAULT 0,
  `has_custom_terms` tinyint(4) NOT NULL DEFAULT 0,
  `note` text NOT NULL,
  `custom_rates` text NOT NULL,
  `percent_discount` tinyint(4) NOT NULL DEFAULT 0,
  `allowed_lifetime` enum('any','one','two','three','four','five','six') NOT NULL DEFAULT 'any',
  `current_tier` int(10) unsigned DEFAULT NULL,
  `last_annual_check` datetime DEFAULT NULL,
  `is_lifetime_tiered` tinyint(4) NOT NULL DEFAULT 0,
  `is_tier1_base_pricing` tinyint(4) NOT NULL DEFAULT 0,
  `require_click_agreement` tinyint(4) NOT NULL DEFAULT 0,
  `agreement_id` int(10) unsigned DEFAULT NULL,
  `agreement_ip` varchar(50) DEFAULT NULL,
  `agreement_user_id` int(10) unsigned DEFAULT NULL,
  `agreement_date` timestamp NULL DEFAULT NULL,
  `ela` tinyint(4) NOT NULL DEFAULT 0,
  `enterprise_support_plan` tinyint(4) NOT NULL DEFAULT 1,
  `unit_rates` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `subaccount_unit_discounts` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `acct_id` (`acct_id`),
  KEY `effective_date` (`effective_date`),
  KEY `end_date` (`end_date`),
  KEY `auto_renewal` (`auto_renewal`),
  KEY `total_domain_limit` (`total_domain_limit`),
  KEY `price_locking` (`price_locking`),
  KEY `has_custom_terms` (`has_custom_terms`)
) ENGINE=InnoDB AUTO_INCREMENT=24131 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `pricing_contract_sales_stats` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `contract_id` int(10) unsigned DEFAULT NULL,
  `sales_stat_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `pricing_contract_sales_stats_sales_stat_id` (`sales_stat_id`),
  KEY `contract_id` (`contract_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9004 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `pricing_contract_tiers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pricing_contract_id` int(10) unsigned NOT NULL,
  `max_volume` int(8) unsigned NOT NULL,
  `is_unlimited` tinyint(4) unsigned NOT NULL DEFAULT 0,
  `discount_type` enum('none','percent_all','percent_each','fixed') DEFAULT NULL,
  `custom_rates` text DEFAULT NULL,
  `percent_discount` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14088 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `private_ca_info` (
  `id` int(11) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `common_name` varchar(255) NOT NULL DEFAULT '',
  `private_ca_org_id` int(11) unsigned NOT NULL DEFAULT 0,
  `org_unit` text DEFAULT NULL,
  `signature_hash` enum('sha1','sha256','sha384','sha512') NOT NULL DEFAULT 'sha256',
  `key_size` varchar(10) NOT NULL DEFAULT '2048',
  `key_algorithm` varchar(10) NOT NULL DEFAULT 'rsa',
  `lifetime` tinyint(4) unsigned NOT NULL DEFAULT 0,
  `custom_expiration_date` datetime DEFAULT NULL,
  `custom_validity_days` int(6) unsigned DEFAULT NULL,
  `is_root` tinyint(4) unsigned NOT NULL DEFAULT 0,
  `is_cert_revocation_list` tinyint(4) unsigned DEFAULT NULL,
  `is_ocsp` tinyint(4) unsigned DEFAULT NULL,
  `cps_default` tinyint(4) unsigned DEFAULT NULL,
  `custom_cps_url` text DEFAULT NULL,
  `custom_policy_identifier` text DEFAULT NULL,
  `order_specific_message` text DEFAULT NULL,
  `root_ca_cert_id` int(11) unsigned NOT NULL DEFAULT 0,
  `root_ca_private_pki_order_id` int(11) unsigned zerofill NOT NULL DEFAULT 00000000000,
  `date_created` datetime DEFAULT NULL,
  `user_id` int(11) unsigned DEFAULT 0,
  `account_id` int(6) unsigned zerofill NOT NULL DEFAULT 000000,
  `status` varchar(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `ix_common_name` (`common_name`),
  KEY `ix_root_ca_cert_id` (`root_ca_cert_id`),
  KEY `ix_root_ca_private_pki_order_id` (`root_ca_private_pki_order_id`),
  KEY `ix_account_id` (`account_id`),
  KEY `ix_status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `private_ca_organizations` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` int(6) unsigned zerofill NOT NULL DEFAULT 000000,
  `container_id` int(11) unsigned DEFAULT NULL,
  `org_name` varchar(255) NOT NULL DEFAULT '',
  `org_city` varchar(128) NOT NULL DEFAULT '',
  `org_state` varchar(128) NOT NULL DEFAULT '',
  `org_country` varchar(2) NOT NULL DEFAULT '',
  `date_created` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_unique_acct_org` (`account_id`,`org_name`,`org_country`),
  KEY `ix_account_id` (`account_id`),
  KEY `ix_container_id` (`container_id`),
  KEY `ix_org_name` (`org_name`),
  KEY `ix_org_country` (`org_country`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `products` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(128) DEFAULT NULL,
  `simple_name` varchar(128) NOT NULL,
  `accounting_code` varchar(10) NOT NULL DEFAULT '',
  `cmd_prod_id` varchar(64) DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `has_sans` tinyint(1) NOT NULL DEFAULT 0,
  `additional_dns_names_allowed` tinyint(1) NOT NULL DEFAULT 0,
  `valid_addons` varchar(255) NOT NULL,
  `ca_product_type` enum('ssl','codesigning','client','none','ev_ssl','ov_ssl','dv_ssl') DEFAULT NULL,
  `max_lifetime` tinyint(3) unsigned NOT NULL DEFAULT 3,
  `min_lifetime` tinyint(3) unsigned NOT NULL DEFAULT 1,
  `max_days` smallint(5) unsigned DEFAULT NULL,
  `review_url` varchar(255) DEFAULT NULL,
  `review_url_text` varchar(255) DEFAULT NULL,
  `api_name` varchar(45) DEFAULT NULL,
  `api_group_name` varchar(45) DEFAULT NULL,
  `product_type` varchar(45) DEFAULT NULL,
  `description` varchar(512) DEFAULT NULL,
  `domain_blacklist_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `cmd_prod_id` (`cmd_prod_id`),
  KEY `active` (`active`),
  KEY `simple_name` (`simple_name`)
) ENGINE=InnoDB AUTO_INCREMENT=11026 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `product_api` (
  `product_api_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id` int(10) unsigned NOT NULL,
  `product_id` int(10) unsigned NOT NULL,
  `product_name_id` varchar(64) NOT NULL,
  `product_type` varchar(64) NOT NULL,
  `group_type` varchar(64) NOT NULL,
  `product_name` varchar(128) NOT NULL,
  `profile_id` int(10) unsigned DEFAULT NULL,
  `sort_order` int(10) unsigned DEFAULT 10000,
  `short_description` varchar(255) DEFAULT NULL,
  `user_interface_description` text DEFAULT NULL,
  PRIMARY KEY (`product_api_id`),
  UNIQUE KEY `idx_product_name_id` (`product_name_id`),
  KEY `idx_product_id` (`id`),
  KEY `ix_product_id` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=337 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `product_api_old` (
  `id` int(10) unsigned NOT NULL,
  `product_name_id` varchar(64) NOT NULL,
  `product_type` varchar(64) NOT NULL,
  `group_type` varchar(64) NOT NULL,
  `product_name` varchar(128) NOT NULL,
  `profile_id` int(10) unsigned DEFAULT NULL,
  `sort_order` int(10) unsigned DEFAULT 10000,
  `short_description` varchar(255) DEFAULT NULL,
  `user_interface_description` text DEFAULT NULL,
  PRIMARY KEY (`product_name_id`),
  KEY `idx_product_id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `product_rates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `product_id` int(10) unsigned DEFAULT NULL,
  `rates` text DEFAULT NULL,
  `renewal_discount` varchar(255) DEFAULT NULL,
  `addl_cn` varchar(255) DEFAULT NULL,
  `start_date` datetime NOT NULL,
  `fqdn_rates` varchar(255) DEFAULT NULL,
  `wildcard_rates` varchar(255) DEFAULT NULL,
  `currency` char(3) CHARACTER SET ascii NOT NULL DEFAULT 'USD',
  `fqdn_package_rates` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`),
  KEY `ix_currency` (`currency`)
) ENGINE=InnoDB AUTO_INCREMENT=581 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `promotion_new_customer` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `created` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_new` tinyint(1) unsigned DEFAULT NULL,
  `test_results` text DEFAULT NULL,
  `is_eligible` tinyint(1) unsigned DEFAULT NULL,
  `eligibility_notes` text DEFAULT NULL,
  `promo_code_id` int(11) unsigned DEFAULT NULL,
  `order_id` int(11) unsigned DEFAULT NULL,
  `order_price` smallint(5) unsigned DEFAULT NULL,
  `rewarded` tinyint(1) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `promo_codes` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `expiration_date` date NOT NULL,
  `num_uses` int(11) NOT NULL DEFAULT 1,
  `num_uses_per_account` int(11) NOT NULL DEFAULT 1,
  `promo_code` varchar(100) NOT NULL,
  `product_prices` text NOT NULL,
  `percent_discount` varchar(10) NOT NULL DEFAULT '0',
  `extra_days` int(11) NOT NULL,
  `lifetime` varchar(25) NOT NULL DEFAULT '0',
  `product_id` varchar(255) NOT NULL DEFAULT '0',
  `max_names` smallint(5) unsigned NOT NULL DEFAULT 0,
  `customer_name` varchar(100) NOT NULL,
  `customer_org` varchar(100) NOT NULL,
  `customer_email` varchar(100) NOT NULL,
  `customer_phone` varchar(30) NOT NULL,
  `make_permanent_discount` tinyint(4) NOT NULL DEFAULT 0,
  `note` text NOT NULL,
  `reason_id` tinyint(3) unsigned DEFAULT 0,
  `competitor_number` tinyint(3) unsigned DEFAULT NULL,
  `staff_id` int(11) NOT NULL DEFAULT 0,
  `cust_user_id` int(11) NOT NULL DEFAULT 0,
  `acct_id` int(6) unsigned NOT NULL DEFAULT 0,
  `completed` tinyint(4) NOT NULL DEFAULT 0,
  `category` varchar(50) NOT NULL,
  `order_id` int(8) unsigned zerofill NOT NULL DEFAULT 00000000,
  `receipt_id` int(10) NOT NULL DEFAULT 0,
  `stat_row_id` int(11) NOT NULL DEFAULT 0,
  `only_new_accounts` tinyint(4) NOT NULL DEFAULT 0,
  `allowed_names` varchar(200) DEFAULT NULL,
  `cert_expiration_date` date DEFAULT NULL,
  `source_page` varchar(255) DEFAULT NULL,
  `currency` char(3) CHARACTER SET ascii NOT NULL DEFAULT 'USD',
  `custom_days` int(11) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`promo_code`),
  KEY `promo_code_order_id_idx` (`order_id`),
  KEY `order_id` (`order_id`),
  KEY `receipt_id` (`receipt_id`),
  KEY `idx_acct_id` (`acct_id`)
) ENGINE=InnoDB AUTO_INCREMENT=238122 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `promo_code_extras` (
  `promo_code_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_info` text DEFAULT NULL,
  PRIMARY KEY (`promo_code_id`)
) ENGINE=InnoDB AUTO_INCREMENT=33463 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `promo_code_orders` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `promo_code_id` int(10) unsigned NOT NULL,
  `acct_id` int(6) unsigned zerofill DEFAULT NULL,
  `order_id` int(8) unsigned zerofill DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `account_index` (`acct_id`),
  KEY `order_index` (`order_id`),
  KEY `promo_code_id` (`promo_code_id`)
) ENGINE=InnoDB AUTO_INCREMENT=96893 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `promo_code_reasons` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `reason` varchar(255) NOT NULL,
  `status` varchar(20) DEFAULT 'active',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `promo_pages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `thumbnail` varchar(255) NOT NULL DEFAULT '',
  `text` mediumtext NOT NULL,
  `description` text NOT NULL,
  `name` varchar(128) NOT NULL DEFAULT '',
  `order` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `quotes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `recipientName` varchar(150) NOT NULL,
  `recipientOrgName` varchar(150) NOT NULL,
  `recipientEmail` varchar(150) NOT NULL,
  `recipientPhone` varchar(25) NOT NULL,
  `productCount` int(11) NOT NULL,
  `productDetails` text NOT NULL,
  `grandTotal` double NOT NULL,
  `token` varchar(50) NOT NULL,
  `promo_code` varchar(20) NOT NULL,
  `staff_id` int(11) NOT NULL,
  `note` text NOT NULL,
  `date_time` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `token` (`token`)
) ENGINE=InnoDB AUTO_INCREMENT=83163 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `real_id_states` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` char(50) NOT NULL,
  `real_id_compliant` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `date_last_modified` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `modified_by` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `real_id_compliant` (`real_id_compliant`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `reasons` (
  `id` tinyint(4) NOT NULL AUTO_INCREMENT,
  `status_id` tinyint(4) NOT NULL DEFAULT 0,
  `name` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `status_id` (`status_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `receipts` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `date_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `acct_amount` decimal(10,2) DEFAULT 0.00,
  `cc_amount` decimal(10,2) DEFAULT 0.00,
  `cc_last4` varchar(4) DEFAULT NULL,
  `cc_exp_date` varchar(4) DEFAULT NULL,
  `cc_type` enum('amex','visa','mastercard','discover','other','none') NOT NULL DEFAULT 'none',
  `gty_trans_id` varchar(32) DEFAULT '0',
  `gty_settlement_id` varchar(32) DEFAULT '0',
  `gty_refund_id` varchar(32) DEFAULT '0',
  `bill_name` varchar(128) DEFAULT NULL,
  `bill_org_name` varchar(128) DEFAULT NULL,
  `bill_addr1` varchar(128) DEFAULT NULL,
  `bill_addr2` varchar(128) DEFAULT NULL,
  `bill_city` varchar(128) DEFAULT NULL,
  `bill_state` varchar(128) DEFAULT NULL,
  `bill_zip` varchar(40) DEFAULT NULL,
  `bill_country` varchar(2) DEFAULT NULL,
  `bill_email` varchar(255) DEFAULT NULL,
  `gty_status` varchar(64) NOT NULL DEFAULT '',
  `gty_capture_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `gty_auth_msg` varchar(128) NOT NULL DEFAULT '',
  `gty_request_token` varchar(128) NOT NULL DEFAULT '',
  `gty_ref_code` varchar(128) NOT NULL DEFAULT '',
  `payment_gty` enum('cybersource','netbilling') NOT NULL DEFAULT 'cybersource',
  `payment_profile_id` varchar(32) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `gty_trans_id` (`gty_trans_id`),
  KEY `gty_settlement_id` (`gty_settlement_id`)
) ENGINE=InnoDB AUTO_INCREMENT=119065236 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `receipt_tax` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `receipt_id` int(10) unsigned NOT NULL,
  `tax_amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `gross_amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  PRIMARY KEY (`id`),
  KEY `ix_receipt_id` (`receipt_id`)
) ENGINE=InnoDB AUTO_INCREMENT=76497410 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `registration_authority` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` int(10) unsigned NOT NULL,
  `registration_authority_hash` varchar(128) DEFAULT NULL,
  `registration_authority_encrypted` varchar(255) DEFAULT NULL,
  `ip_ranges` varchar(255) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_account_id` (`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `reissues` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(8) unsigned zerofill NOT NULL DEFAULT 00000000,
  `status` tinyint(1) NOT NULL DEFAULT 2,
  `ca_order_id` int(11) NOT NULL DEFAULT 0,
  `cmd_prod_id` varchar(64) NOT NULL,
  `date_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `staff_id` int(11) NOT NULL DEFAULT 0,
  `auth_1_staff` int(11) NOT NULL,
  `auth_1_date_time` datetime NOT NULL,
  `auth_2_staff` int(11) NOT NULL,
  `auth_2_date_time` datetime NOT NULL,
  `csr` text NOT NULL,
  `serversw` smallint(5) NOT NULL,
  `add_cn` tinyint(2) NOT NULL,
  `reason` text NOT NULL,
  `collected` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `revoked` tinyint(1) NOT NULL DEFAULT 0,
  `reason_code` tinyint(1) NOT NULL,
  `update_expiry` tinyint(1) NOT NULL,
  `valid_till` date NOT NULL DEFAULT '0000-00-00',
  `whois_completed` tinyint(1) NOT NULL,
  `whois_staff_id` int(10) NOT NULL,
  `whois_date_time` datetime NOT NULL,
  `org_name_completed` tinyint(1) NOT NULL,
  `org_name_staff_id` int(10) NOT NULL,
  `org_name_date_time` datetime NOT NULL,
  `old_common_name` text NOT NULL,
  `new_common_name` text NOT NULL,
  `old_sans` text NOT NULL,
  `new_sans` text NOT NULL,
  `new_sans_to_validate` text DEFAULT NULL,
  `old_org_name` varchar(255) NOT NULL,
  `new_org_name` varchar(255) NOT NULL,
  `old_org_unit` varchar(128) NOT NULL,
  `new_org_unit` varchar(128) NOT NULL,
  `old_org_addr1` varchar(128) NOT NULL,
  `new_org_addr1` varchar(128) NOT NULL,
  `old_org_addr2` varchar(128) NOT NULL,
  `new_org_addr2` varchar(128) NOT NULL,
  `old_org_city` varchar(64) NOT NULL,
  `new_org_city` varchar(64) NOT NULL,
  `old_org_state` varchar(64) NOT NULL,
  `new_org_state` varchar(64) NOT NULL,
  `old_org_country` varchar(2) NOT NULL,
  `new_org_country` varchar(2) NOT NULL,
  `old_org_zip` varchar(12) NOT NULL,
  `new_org_zip` varchar(12) NOT NULL,
  `old_email` varchar(255) NOT NULL,
  `new_email` varchar(255) NOT NULL,
  `old_telephone` varchar(32) NOT NULL,
  `new_telephone` varchar(32) NOT NULL,
  `old_telephone_ext` varchar(12) NOT NULL,
  `new_telephone_ext` varchar(12) NOT NULL,
  `reject_date_time` datetime NOT NULL,
  `reject_staff_id` int(10) NOT NULL,
  `reject_reason` text NOT NULL,
  `stat_row_id` int(11) NOT NULL,
  `string_type` enum('PS','T61','UTF8','AUTO') NOT NULL DEFAULT 'AUTO',
  `ca_cert_id` smallint(6) NOT NULL DEFAULT 33,
  `origin` enum('retail','enterprise','staff') DEFAULT 'retail',
  `delay_revoke` smallint(6) NOT NULL,
  `receipt_id` int(10) NOT NULL DEFAULT 0,
  `signature_hash` enum('sha1','sha256','sha384','sha512') DEFAULT 'sha1',
  `root_path` enum('digicert','entrust','cybertrust','comodo') NOT NULL DEFAULT 'entrust',
  `no_sans` tinyint(1) NOT NULL DEFAULT 0,
  `code_signing_cert_token` varchar(32) DEFAULT NULL,
  `risk_score` smallint(5) unsigned DEFAULT NULL,
  `key_usage` varchar(150) DEFAULT NULL,
  `in_progress` tinyint(1) NOT NULL DEFAULT 0,
  `pay_type` varchar(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `stat_row_id` (`stat_row_id`),
  KEY `reissues_status` (`status`),
  KEY `collected_index` (`collected`),
  KEY `status` (`status`),
  KEY `receipt_id` (`receipt_id`),
  KEY `in_progress` (`in_progress`)
) ENGINE=InnoDB AUTO_INCREMENT=901018 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `reissue_notes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `reissue_id` int(8) unsigned zerofill DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `note` text DEFAULT NULL,
  `staff_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `reissue_notes_reissue_id` (`reissue_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10388 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `rejections` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(8) unsigned zerofill NOT NULL DEFAULT 00000000,
  `reject_notes` text NOT NULL,
  `reject_date_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `reject_staff` int(10) unsigned NOT NULL DEFAULT 0,
  `reject_stat_row_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=512443 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `reports` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `container_id` int(10) unsigned NOT NULL,
  `template_id` int(10) unsigned NOT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'requested',
  `instance_id` varchar(255) DEFAULT NULL,
  `last_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `email_sent` varchar(10) NOT NULL DEFAULT 'no',
  `url` varchar(400) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `template_id_idx` (`template_id`),
  CONSTRAINT `template_id` FOREIGN KEY (`template_id`) REFERENCES `report_templates` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1000075 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `report_schedules` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `report_id` int(10) unsigned NOT NULL,
  `frequency` enum('MONTHLY','WEEKLY','DAILY') NOT NULL,
  `parameters` varchar(45) DEFAULT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'requested',
  `instance_id` varchar(255) DEFAULT NULL,
  `last_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `report_id_idx` (`report_id`),
  CONSTRAINT `report_id` FOREIGN KEY (`report_id`) REFERENCES `reports` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1000005 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `report_templates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fields` varchar(1000) NOT NULL,
  `filters` varchar(1000) DEFAULT NULL,
  `parameters` varchar(200) DEFAULT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `last_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `query_name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1000063 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `request_auth_log` (
  `company_id` int(10) unsigned NOT NULL,
  `date_processed` datetime NOT NULL,
  `already_completed` tinyint(3) unsigned NOT NULL,
  `found_dcv` tinyint(3) unsigned DEFAULT NULL,
  `found_ov_checks` tinyint(3) unsigned DEFAULT NULL,
  `reference_dcv_id` int(10) unsigned DEFAULT NULL,
  `reference_checkmark_id` int(10) unsigned DEFAULT NULL,
  `created_checkmark_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`company_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `request_auth_tool` (
  `org_id` int(10) unsigned NOT NULL,
  `cert_approval_id` int(10) unsigned DEFAULT NULL,
  `cis_domain_id` varchar(255) DEFAULT NULL,
  `last_checked` datetime DEFAULT NULL,
  `date_found` datetime DEFAULT NULL,
  `checkmark_note` text DEFAULT NULL,
  UNIQUE KEY `org_id` (`org_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `reseller_company_types` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `reseller_seal_info` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Use UNSIGNED MEDIUMINT limits us to 16 million seals to keep us below the hash collision threshold',
  `hash` char(8) DEFAULT NULL COMMENT 'CHAR(8) with our hashing algorithm would have a collision at around 19 million hashes',
  `reseller_id` int(10) unsigned NOT NULL,
  `domains` text DEFAULT NULL,
  `created_timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  `seen_on_url` varchar(255) DEFAULT NULL,
  `seen_timestamp` timestamp NULL DEFAULT NULL,
  `seen_with_params` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `reseller_id` (`reseller_id`),
  UNIQUE KEY `hash` (`hash`)
) ENGINE=InnoDB AUTO_INCREMENT=7241 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `revokes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(8) unsigned zerofill NOT NULL DEFAULT 00000000,
  `date_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `staff_id` int(11) NOT NULL DEFAULT 0,
  `reason` text NOT NULL,
  `reason_code` tinyint(1) NOT NULL DEFAULT 0,
  `simple_reason` enum('unknown','duplicate','info_change','installation','new_provider','no_longer_needed','nonpayment','private_key','test_order','prod_change','validation') NOT NULL DEFAULT 'unknown',
  `refunded` tinyint(1) NOT NULL DEFAULT 0,
  `server_response` text NOT NULL,
  `temp_hide` tinyint(1) NOT NULL DEFAULT 0,
  `refund_code` varchar(32) NOT NULL DEFAULT '',
  `completed` tinyint(1) NOT NULL DEFAULT 0,
  `delay_revoke` int(11) NOT NULL DEFAULT 0,
  `auth_1_staff` int(11) NOT NULL DEFAULT 0,
  `auth_1_date_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `auth_2_staff` int(11) NOT NULL DEFAULT 0,
  `auth_2_date_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `confirmed_authentic` tinyint(1) NOT NULL DEFAULT 0,
  `stat_row_id` int(11) NOT NULL,
  `serial_number` varchar(64) NOT NULL,
  `type` enum('revoke','cancel') NOT NULL DEFAULT 'revoke',
  `po_id` int(11) DEFAULT NULL,
  `cc_refund_amount` decimal(10,2) DEFAULT NULL,
  `acct_refund_amount` decimal(10,2) DEFAULT NULL,
  `wire_transfer_refund_amount` decimal(10,2) DEFAULT NULL,
  `is_suspicious` tinyint(1) DEFAULT NULL,
  `high_risk_items` varchar(255) DEFAULT NULL,
  `request_received` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `order_id` (`order_id`),
  KEY `stat_row_id` (`stat_row_id`),
  KEY `serial_number` (`serial_number`),
  KEY `date_time` (`date_time`),
  KEY `completed_idx` (`completed`)
) ENGINE=InnoDB AUTO_INCREMENT=2847897 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `risky_contacts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `certificate_request_id` varchar(128) NOT NULL,
  `contact_hash` varchar(32) DEFAULT NULL,
  `firstname` int(10) unsigned NOT NULL,
  `lastname` int(10) unsigned NOT NULL,
  `email` int(10) unsigned NOT NULL,
  `telephone` int(10) unsigned NOT NULL,
  `snooze_until` datetime DEFAULT NULL,
  `status` varchar(32) NOT NULL DEFAULT 'pending',
  `staff_id` int(11) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `date_completed` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_certificate_request_id` (`certificate_request_id`),
  KEY `ix_contact_hash` (`contact_hash`),
  KEY `ix_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `risky_domains` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `public_id` varchar(35) NOT NULL,
  `account_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `risk_score` int(10) DEFAULT NULL,
  `snooze_until` datetime DEFAULT NULL,
  `completed_date` datetime DEFAULT NULL,
  `brand` varchar(256) DEFAULT NULL,
  `locale` varchar(5) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_domain_public_id` (`public_id`(8)),
  KEY `risky_domains_account_id` (`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=125443 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `risky_ou` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `certificate_request_id` varchar(128) DEFAULT NULL,
  `account_id` int(10) unsigned NOT NULL,
  `ou_value` varchar(256) NOT NULL,
  `date_created` datetime NOT NULL,
  `account_name` varchar(255) DEFAULT NULL,
  `organization_name` varchar(255) DEFAULT NULL,
  `reserved_by_staff_id` int(10) unsigned DEFAULT NULL,
  `reserved_date_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_account_value` (`account_id`,`ou_value`(255)),
  KEY `ix_certificate_request_id` (`certificate_request_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1463634 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `risk_history` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(10) unsigned DEFAULT NULL,
  `reissue_id` int(10) unsigned DEFAULT NULL,
  `company_id` int(10) unsigned NOT NULL DEFAULT 0,
  `domain_id` int(10) unsigned NOT NULL DEFAULT 0,
  `risk_score` smallint(5) unsigned DEFAULT NULL,
  `risk_factors` text DEFAULT NULL,
  `date_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `company_id` (`company_id`),
  KEY `domain_id` (`domain_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19402029 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `salesforce_account_watchlist` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `last_touched` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `acct_id` int(6) unsigned zerofill NOT NULL,
  `total_spent_before_mpki` int(11) DEFAULT NULL,
  `total_spent_since_mpki` int(11) DEFAULT NULL,
  `month_to_date_total` int(11) DEFAULT NULL,
  `month_to_date_cert_count` smallint(6) DEFAULT NULL,
  `rejected_from_watchlist` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `sf_account_guid` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `acct_id` (`acct_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1085 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `salesforce_last_upsert_times` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `type` enum('orders','contacts') DEFAULT NULL,
  `record_id` int(11) DEFAULT NULL,
  `upsert_timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `type` (`type`,`record_id`),
  KEY `sflut_record_id` (`record_id`),
  KEY `sflut_up_ts` (`upsert_timestamp`)
) ENGINE=InnoDB AUTO_INCREMENT=907046 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `salesforce_order_leads` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `last_touched` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `order_id` int(10) unsigned NOT NULL,
  `staff_id` smallint(5) unsigned NOT NULL,
  `rejected_by_sales` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `sf_lead_guid` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `sales_acct_notes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `acct_id` int(8) unsigned zerofill DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `context` varchar(25) NOT NULL,
  `note` varchar(255) DEFAULT NULL,
  `staff_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=494 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `sales_stats` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ord_date` datetime NOT NULL,
  `col_date` datetime NOT NULL,
  `units` smallint(6) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `country` varchar(2) NOT NULL,
  `reseller_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `is_renewal` tinyint(1) NOT NULL DEFAULT 0,
  `is_first_order` tinyint(1) NOT NULL DEFAULT 0,
  `order_id` int(8) unsigned zerofill NOT NULL,
  `ent_client_cert_id` int(10) unsigned NOT NULL DEFAULT 0,
  `serversw` smallint(5) NOT NULL,
  `type` enum('revoke','rejection','order','cancel') NOT NULL DEFAULT 'order',
  `origin` enum('retail','enterprise') DEFAULT 'retail',
  `lifetime` tinyint(2) NOT NULL,
  `test_order` tinyint(1) NOT NULL DEFAULT 0,
  `finance_revamp` tinyint(1) NOT NULL DEFAULT 0,
  `col_till` date DEFAULT '0000-00-00',
  `sale_type` enum('po','acct','funny','credit','unknown','bill reseller','ela','wire','subscription','voucher') DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `country` (`country`),
  KEY `reseller_id` (`reseller_id`),
  KEY `is_renewal` (`is_renewal`),
  KEY `units` (`units`),
  KEY `amount` (`amount`),
  KEY `serversw` (`serversw`),
  KEY `type` (`type`),
  KEY `ord_date` (`ord_date`),
  KEY `col_date` (`col_date`),
  KEY `lifetime` (`lifetime`),
  KEY `order_type` (`order_id`,`type`),
  KEY `test_order` (`test_order`),
  KEY `ss_origin` (`origin`),
  KEY `is_first_order` (`is_first_order`),
  KEY `ent_client_cert_id` (`ent_client_cert_id`)
) ENGINE=InnoDB AUTO_INCREMENT=213651751 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `sales_stats_audit` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `stat_row_id` int(10) DEFAULT NULL,
  `staff_id` int(10) NOT NULL,
  `memo` tinytext DEFAULT NULL,
  `modified` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14493 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `saml_assertion_log1` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `saml_response` text NOT NULL,
  `account_id` int(10) unsigned DEFAULT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  `entity_id` varchar(1024) DEFAULT NULL,
  `attributes` text DEFAULT NULL,
  `errors` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_date_created` (`date_created`),
  KEY `ix_account_id` (`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `saml_assertion_log2` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `saml_response` text NOT NULL,
  `account_id` int(10) unsigned DEFAULT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  `entity_id` varchar(1024) DEFAULT NULL,
  `attributes` text DEFAULT NULL,
  `errors` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_date_created` (`date_created`),
  KEY `ix_account_id` (`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4157 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `saml_assertion_log3` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `saml_response` text NOT NULL,
  `account_id` int(10) unsigned DEFAULT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  `entity_id` varchar(1024) DEFAULT NULL,
  `attributes` text DEFAULT NULL,
  `errors` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_date_created` (`date_created`),
  KEY `ix_account_id` (`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4588 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `saml_entity` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` int(10) unsigned NOT NULL,
  `xml_metadata` mediumtext DEFAULT NULL,
  `source_url` varchar(1024) DEFAULT NULL,
  `idp_entity_id` varchar(1024) NOT NULL,
  `idp_signon_url` varchar(1024) NOT NULL,
  `attribute_mapping` varchar(2048) DEFAULT NULL,
  `friendly_name` varchar(64) DEFAULT NULL,
  `friendly_slug` varchar(64) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `last_signon_date` datetime DEFAULT NULL,
  `last_xml_pull_date` datetime DEFAULT NULL,
  `type` varchar(16) DEFAULT NULL,
  `discoverable` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_slug` (`friendly_slug`),
  KEY `ix_account` (`account_id`),
  KEY `ix_type` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=3298 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `saml_entity_certificate` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `saml_entity_id` int(10) unsigned NOT NULL,
  `certificate` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_saml_entity_id` (`saml_entity_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7659 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `saml_guest_request` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `person_id` varchar(64) NOT NULL,
  `account_id` int(10) unsigned NOT NULL,
  `order_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_person_id` (`person_id`),
  KEY `idx_account_id` (`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=239 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `saml_login_token` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `token` varchar(255) NOT NULL,
  `created_date` datetime DEFAULT NULL,
  `expires_date` datetime DEFAULT NULL,
  `is_processed` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `token_UNIQUE` (`token`)
) ENGINE=InnoDB AUTO_INCREMENT=2635 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `seal_info` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Use UNSIGNED MEDIUMINT limits us to 16 million seals to keep us below the hash collision threshold',
  `hash` char(8) DEFAULT NULL COMMENT 'CHAR(8) with our hashing algorithm would have a collision at around 19 million hashes',
  `order_id` int(10) unsigned NOT NULL,
  `created_timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  `seen_on_url` varchar(255) DEFAULT NULL,
  `seen_timestamp` timestamp NULL DEFAULT NULL,
  `seen_with_params` varchar(255) DEFAULT NULL,
  `stored_settings` varchar(255) DEFAULT NULL,
  `organization_logo_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `order_id` (`order_id`),
  UNIQUE KEY `hash` (`hash`),
  KEY `ix_logo_id` (`organization_logo_id`)
) ENGINE=InnoDB AUTO_INCREMENT=179374 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `seal_info_deprecated` (
  `order_id` int(10) unsigned NOT NULL,
  `seen_timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  `seen_on_url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `security_questions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `question` varchar(255) NOT NULL DEFAULT '',
  `status` enum('active','retired') DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `serversw` (
  `id` smallint(5) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) DEFAULT NULL,
  `best_format` varchar(20) DEFAULT NULL,
  `sort_order` tinyint(4) unsigned DEFAULT NULL,
  `install_url` varchar(150) DEFAULT NULL,
  `csr_url` varchar(150) DEFAULT NULL,
  `cert_type` enum('server','code') NOT NULL DEFAULT 'server',
  `requires_new_csr` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `sort_order` (`sort_order`)
) ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `sf_contacts_temp` (
  `acct_id` int(6) unsigned zerofill NOT NULL DEFAULT 000000,
  `watched_id` int(11) unsigned DEFAULT 0,
  `id` int(11) unsigned NOT NULL DEFAULT 0,
  `contact_type` enum('org','tech','bill') DEFAULT NULL,
  `job_title` varchar(64) DEFAULT NULL,
  `firstname` varchar(128) DEFAULT NULL,
  `lastname` varchar(128) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `telephone` varchar(32) DEFAULT NULL,
  `telephone_ext` varchar(16) NOT NULL DEFAULT '',
  `fax` varchar(32) DEFAULT NULL,
  `org_type` tinyint(3) DEFAULT NULL,
  `org_name` varchar(255) DEFAULT NULL,
  `org_unit` varchar(64) DEFAULT NULL,
  `org_addr1` varchar(128) DEFAULT NULL,
  `org_addr2` varchar(128) DEFAULT NULL,
  `org_zip` varchar(40) DEFAULT NULL,
  `org_city` varchar(128) DEFAULT NULL,
  `org_state` varchar(128) DEFAULT NULL,
  `org_country` varchar(2) DEFAULT NULL,
  `org_reg_num` varchar(25) DEFAULT NULL,
  `org_duns_num` varchar(32) DEFAULT NULL,
  `opt_in_news` tinyint(1) NOT NULL DEFAULT 0,
  `usable_org_name` varchar(255) NOT NULL DEFAULT '',
  `timezone` varchar(40) DEFAULT NULL,
  `i18n_language_id` tinyint(4) unsigned DEFAULT 1,
  `last_updated` timestamp NULL DEFAULT NULL,
  `sf_guid` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `acct_id` (`acct_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `sf_orders_temp` (
  `acct_id` int(6) unsigned zerofill NOT NULL DEFAULT 000000,
  `org_name` varchar(255) NOT NULL DEFAULT '',
  `id` int(8) unsigned zerofill NOT NULL,
  `date_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `common_name` varchar(255) NOT NULL DEFAULT '',
  `status` tinyint(4) NOT NULL DEFAULT 1,
  `reason` tinyint(4) NOT NULL DEFAULT 1,
  `lifetime` tinyint(4) NOT NULL DEFAULT 0,
  `product_id` int(11) DEFAULT NULL,
  `is_renewed` tinyint(1) NOT NULL DEFAULT 0,
  `renewed_order_id` int(8) unsigned zerofill NOT NULL DEFAULT 00000000,
  `is_first_order` tinyint(1) NOT NULL DEFAULT 0,
  `valid_till` date NOT NULL DEFAULT '0000-00-00',
  `ca_collect_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `value` decimal(10,2) DEFAULT NULL,
  `sf_guid` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `acct_id` (`acct_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `signing_timestamp_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(8) unsigned zerofill NOT NULL,
  `order_timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=179907 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `siteseallink` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `language` char(5) NOT NULL DEFAULT 'en_US',
  `link` varchar(64) NOT NULL DEFAULT '0',
  `percentage` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `type` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=241 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `siteseallinkproducts` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `type_id` tinyint(3) unsigned DEFAULT NULL,
  `product_id` smallint(5) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `siteseallinktype` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `siteseallinkurl` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `language` char(5) NOT NULL DEFAULT 'en_US',
  `link` varchar(192) NOT NULL DEFAULT '',
  `percentage` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `type` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=133 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `staff` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `firstname` varchar(50) DEFAULT NULL,
  `lastname` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `username` varchar(120) DEFAULT NULL,
  `dotname` varchar(60) DEFAULT NULL,
  `staff_role_id` smallint(6) NOT NULL DEFAULT 200,
  `hashpass` varchar(128) NOT NULL DEFAULT '',
  `newpass` tinyint(4) DEFAULT 1,
  `status` enum('active','inactive','deleted','locked out') DEFAULT 'active',
  `ip_access` text NOT NULL,
  `last_pw_change` date NOT NULL DEFAULT '0000-00-00',
  `failed_attempts` tinyint(1) NOT NULL DEFAULT 0,
  `phone_extension` varchar(4) DEFAULT NULL,
  `staff_direct_phone` varchar(20) DEFAULT NULL,
  `settings` set('timecard_required','prompt_for_time','track_time_daily','track_time_weekly','account_rep','account_dev','account_client_mgr') DEFAULT NULL,
  `photo_file_id` int(10) unsigned DEFAULT NULL,
  `hire_date` date DEFAULT NULL,
  `risk_approval_threshold` smallint(5) NOT NULL DEFAULT 0,
  `queue_status` int(11) DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2526 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `staff_background_info` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `staff_id` int(10) unsigned NOT NULL,
  `token` varchar(128) NOT NULL,
  `provider_name` varchar(255) NOT NULL,
  `provider_email` varchar(255) NOT NULL,
  `provider_employer` varchar(255) NOT NULL,
  `candidate_name` varchar(255) NOT NULL,
  `requested_date` datetime DEFAULT NULL,
  `completed` tinyint(1) DEFAULT 0,
  `completed_date` datetime DEFAULT NULL,
  `hidden` tinyint(1) DEFAULT 0,
  `hidden_date` datetime DEFAULT NULL,
  `datum_provider_role` varchar(255) DEFAULT '',
  `datum_how_long_known` varchar(255) DEFAULT '',
  `datum_employment_dates` varchar(255) DEFAULT '',
  `datum_compensation` varchar(255) DEFAULT '',
  `datum_responsibilities` text DEFAULT NULL,
  `datum_leadership` text DEFAULT NULL,
  `datum_promotion` varchar(255) DEFAULT '',
  `datum_rehire` tinyint(1) DEFAULT NULL,
  `datum_rehire_ex` varchar(255) DEFAULT '',
  `datum_strengths` text DEFAULT NULL,
  `datum_accomplishments` text DEFAULT NULL,
  `datum_rel_coworkers` varchar(255) DEFAULT '',
  `datum_rel_supervisor` varchar(255) DEFAULT '',
  `datum_rel_customers` varchar(255) DEFAULT '',
  `datum_rate_verbal` int(11) DEFAULT NULL,
  `datum_rate_written` int(11) DEFAULT NULL,
  `datum_schedule` varchar(255) DEFAULT '',
  `datum_attendance` varchar(255) DEFAULT '',
  `datum_overtime` varchar(255) DEFAULT '',
  `datum_pressure` varchar(255) DEFAULT '',
  `datum_character` text DEFAULT NULL,
  `datum_misc` text DEFAULT NULL,
  `datum_weaknesses` text DEFAULT NULL,
  `datum_compare_peers` text DEFAULT NULL,
  `datum_recommend` text DEFAULT NULL,
  `datum_work_again` text DEFAULT NULL,
  `datum_sales_v_service` text DEFAULT NULL,
  `datum_presentation` text DEFAULT NULL,
  `datum_deadlines` text DEFAULT NULL,
  `datum_right_v_on_time` text DEFAULT NULL,
  `datum_other` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_bginfo_token` (`token`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `staff_client_certs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `staff_id` int(11) NOT NULL DEFAULT 0,
  `create_date` date NOT NULL DEFAULT '1900-01-01',
  `expiry_date` date NOT NULL DEFAULT '1900-01-01',
  `common_name` varchar(64) NOT NULL DEFAULT '',
  `email` varchar(255) NOT NULL DEFAULT '',
  `org_unit` varchar(128) NOT NULL DEFAULT '',
  `serial_number` varchar(64) NOT NULL DEFAULT '',
  `revoked` tinyint(4) NOT NULL DEFAULT 0,
  `signature_hash` set('unknown','sha1','sha256','sha384','sha512','sha256ecdsa','sha384ecdsa') NOT NULL DEFAULT 'unknown',
  `encrypted_key` mediumtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `staff_id` (`staff_id`),
  KEY `serial_number` (`serial_number`(6))
) ENGINE=InnoDB AUTO_INCREMENT=2388 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `staff_ip_access` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` date DEFAULT '1900-01-01',
  `ip_address` varchar(15) NOT NULL DEFAULT '',
  `ip_address_end` varchar(15) NOT NULL DEFAULT '',
  `description` varchar(255) DEFAULT '',
  `allow_my_docs_polling` tinyint(3) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `staff_otp_cache` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `device_id` int(11) DEFAULT NULL,
  `staff_id` int(11) DEFAULT NULL,
  `otp` varchar(32) DEFAULT NULL,
  `date_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3545929 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `staff_otp_deleted` (
  `id` int(10) unsigned NOT NULL,
  `staff_id` int(11) DEFAULT NULL,
  `device_key` varchar(255) DEFAULT NULL,
  `shared_secret` varchar(255) DEFAULT NULL,
  `device_description` varchar(255) DEFAULT NULL,
  `ctime` datetime DEFAULT NULL,
  `algorithm` enum('motp','oath-hotp') NOT NULL DEFAULT 'motp',
  `failed_attempts` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `staff_otp_devices` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `staff_id` int(11) DEFAULT NULL,
  `device_key` varchar(255) DEFAULT NULL,
  `shared_secret` varchar(255) DEFAULT NULL,
  `device_description` varchar(255) DEFAULT NULL,
  `ctime` datetime DEFAULT NULL,
  `algorithm` enum('motp','oath-hotp') NOT NULL DEFAULT 'motp',
  `failed_attempts` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2117 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `staff_permission_failures` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `staff_id` smallint(6) NOT NULL DEFAULT 0,
  `date_time` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `permission` varchar(255) NOT NULL DEFAULT '',
  `request_uri` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16602 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `staff_permission_import` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `role_name` varchar(255) NOT NULL DEFAULT '',
  `permission` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `staff_permission_snapshots` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `staff_roles_snapshot` mediumtext DEFAULT NULL,
  `staff_permissions_snapshot` mediumtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `date_time_idx` (`date_time`)
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `staff_phone_devices` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_time` datetime DEFAULT NULL,
  `staff_id` int(10) unsigned NOT NULL DEFAULT 0,
  `device_user` varchar(64) NOT NULL DEFAULT '0',
  `device_pass` varchar(128) NOT NULL DEFAULT '0',
  `device_token` varchar(64) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `staff_id` (`staff_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1482 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `staff_pw_changes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `staff_id` int(11) NOT NULL DEFAULT 0,
  `date` date NOT NULL DEFAULT '0000-00-00',
  `hashpass` varchar(128) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6164 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `staff_roles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `role_name` varchar(64) NOT NULL DEFAULT '',
  `department` varchar(64) NOT NULL DEFAULT '',
  `summary` varchar(255) NOT NULL DEFAULT '',
  `base_role_id` smallint(6) NOT NULL DEFAULT 0,
  `is_base_role` tinyint(4) NOT NULL DEFAULT 0,
  `permissions` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=286 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `staff_role_descendant_map` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `staff_role_id` int(10) unsigned NOT NULL,
  `descendant_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=196 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `staff_shift` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `staff_id` int(10) unsigned DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `staff_date_idx` (`staff_id`,`start_date`,`end_date`)
) ENGINE=InnoDB AUTO_INCREMENT=93 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `staff_shift_day` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `shift_id` smallint(5) unsigned DEFAULT NULL,
  `day` tinyint(3) unsigned DEFAULT NULL,
  `start_hour` tinyint(3) unsigned DEFAULT NULL,
  `end_hour` tinyint(3) unsigned DEFAULT NULL,
  `start_min` tinyint(3) unsigned DEFAULT NULL,
  `end_min` tinyint(3) unsigned DEFAULT NULL,
  `extension` varchar(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `shift_id_idx` (`shift_id`)
) ENGINE=InnoDB AUTO_INCREMENT=432 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `staff_tags` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `staff_id` int(11) NOT NULL,
  `tag` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4188 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `standing_approval_invitations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `acct_id` int(11) NOT NULL,
  `email` varchar(128) NOT NULL,
  `org_name` varchar(255) DEFAULT NULL,
  `token` varchar(32) NOT NULL,
  `date_time` datetime DEFAULT NULL,
  `status` enum('active','deleted') NOT NULL DEFAULT 'active',
  `standing_cert_approval_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `standing_cert_approvals` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `acct_id` int(11) NOT NULL,
  `origin` enum('email','phone') DEFAULT NULL,
  `approver_name` varchar(255) NOT NULL DEFAULT '',
  `approver_email` varchar(255) DEFAULT NULL,
  `approver_phone` varchar(255) DEFAULT NULL,
  `approver_ip` varchar(15) NOT NULL DEFAULT '',
  `org_name` varchar(255) DEFAULT NULL,
  `staff_id` int(11) NOT NULL DEFAULT 0,
  `staff_note` text DEFAULT NULL,
  `ctime` datetime DEFAULT NULL,
  `agreement_id` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `statuses` (
  `id` tinyint(4) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `subaccount_invite` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `date_created` datetime DEFAULT NULL,
  `last_sent_date` datetime DEFAULT NULL,
  `date_used` datetime DEFAULT NULL,
  `status` varchar(16) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `parent_account_id` int(10) unsigned zerofill NOT NULL,
  `token` varchar(255) NOT NULL,
  `subaccount_id` int(10) unsigned zerofill DEFAULT NULL,
  `subaccount_type` varchar(64) NOT NULL,
  `invite_note` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_token` (`token`),
  KEY `idx_date_created` (`date_created`)
) ENGINE=InnoDB AUTO_INCREMENT=641 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `subaccount_order_transaction` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(10) unsigned NOT NULL,
  `billed_account_id` int(10) unsigned NOT NULL,
  `account_id` int(10) unsigned NOT NULL,
  `container_id` int(10) unsigned NOT NULL,
  `price` decimal(10,2) DEFAULT 0.00,
  `order_price` decimal(10,2) DEFAULT 0.00,
  `currency` char(3) NOT NULL DEFAULT 'USD',
  `receipt_id` int(10) unsigned DEFAULT 0,
  `acct_adjust_id` int(10) unsigned DEFAULT 0,
  `order_transaction_id` int(10) unsigned DEFAULT 0,
  `transaction_date` datetime DEFAULT current_timestamp(),
  `transaction_type` varchar(32) DEFAULT NULL,
  `balance` decimal(10,2) DEFAULT 0.00,
  PRIMARY KEY (`id`),
  KEY `idx_billed_account_id` (`billed_account_id`),
  KEY `idx_account_id` (`account_id`),
  KEY `idx_container_id` (`container_id`),
  KEY `ix_order_id` (`order_id`),
  KEY `idx_order_transaction_id` (`order_transaction_id`),
  KEY `idx_acct_adjust_id` (`acct_adjust_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16168628 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `subaccount_product_rates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` int(10) unsigned NOT NULL,
  `parent_account_id` int(10) unsigned NOT NULL,
  `product_rates` text NOT NULL,
  `client_cert_rates` text DEFAULT NULL,
  `currency` char(3) NOT NULL DEFAULT 'USD',
  `user_id` int(10) unsigned NOT NULL,
  `date_created` datetime NOT NULL DEFAULT current_timestamp(),
  `last_updated` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_account_id` (`account_id`),
  KEY `ix_parent_account_id` (`parent_account_id`),
  KEY `ix_currency` (`currency`)
) ENGINE=InnoDB AUTO_INCREMENT=143939 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `support_email_random_values` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `date_expired` datetime DEFAULT NULL,
  `date_completed` datetime DEFAULT NULL,
  `organization_id` int(10) unsigned DEFAULT NULL,
  `domain_id` varchar(128) DEFAULT NULL,
  `doc_id` int(10) unsigned DEFAULT NULL,
  `email_address` varchar(255) NOT NULL,
  `staff_id` int(10) unsigned NOT NULL,
  `random_value` varchar(128) NOT NULL,
  `type` varchar(32) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_random_value` (`random_value`) USING HASH
) ENGINE=InnoDB AUTO_INCREMENT=420565 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `symc_order_notes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `symc_order_id` varchar(32) DEFAULT NULL,
  `staff_id` int(10) unsigned NOT NULL DEFAULT 0,
  `date_time` datetime NOT NULL,
  `note` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `date_time` (`date_time`),
  KEY `order_id_idx` (`symc_order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=419446 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `tfa_accounts` (
  `acct_id` int(11) unsigned NOT NULL,
  `last_enabled` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`acct_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `tfa_requirements` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `acct_id` int(8) NOT NULL DEFAULT 0,
  `container_id` int(11) unsigned DEFAULT NULL,
  `auth_type` enum('google_auth','client_cert') CHARACTER SET latin1 NOT NULL DEFAULT 'google_auth',
  `scope_type` enum('account','role','user','container') NOT NULL DEFAULT 'user',
  `scope_container_id` int(11) unsigned DEFAULT NULL,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `role` varchar(20) NOT NULL,
  `date_added` datetime NOT NULL,
  `forced_by_digicert` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `acct_id` (`acct_id`),
  KEY `auth_type` (`auth_type`),
  KEY `scope_type` (`scope_type`),
  KEY `user_id` (`user_id`),
  KEY `role` (`role`),
  KEY `forced_by_digicert` (`forced_by_digicert`)
) ENGINE=InnoDB AUTO_INCREMENT=16499 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `tool_logs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `host` varchar(255) DEFAULT NULL,
  `tool` varchar(25) DEFAULT NULL,
  `time_requested` datetime DEFAULT NULL,
  `ip1` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `ip2` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `ip3` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `ip4` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `data` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `host` (`host`(12),`tool`(2))
) ENGINE=InnoDB AUTO_INCREMENT=1939427 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `ui_stored_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `date_created` timestamp NOT NULL DEFAULT current_timestamp(),
  `date_modified` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `name` varchar(64) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_user_name` (`user_id`,`name`)
) ENGINE=InnoDB AUTO_INCREMENT=109305 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `unborn_orders` (
  `sessionid` varchar(64) NOT NULL,
  `last_hit` datetime DEFAULT NULL,
  `order_data` text DEFAULT NULL,
  PRIMARY KEY (`sessionid`),
  KEY `idx_last_hit` (`last_hit`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `unit_bundles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` int(10) unsigned NOT NULL,
  `contract_id` int(10) unsigned NOT NULL,
  `deal_id` varchar(10) DEFAULT NULL,
  `staff_id` int(10) unsigned NOT NULL,
  `product_id` int(10) unsigned NOT NULL,
  `total_units` decimal(10,2) unsigned DEFAULT 0.00,
  `remaining_units` decimal(10,2) unsigned DEFAULT 0.00,
  `date_time` datetime DEFAULT current_timestamp(),
  `start_date` datetime NOT NULL,
  `end_date` datetime NOT NULL,
  `note` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `account_id` (`account_id`),
  KEY `contract_id` (`contract_id`),
  KEY `product_id` (`product_id`),
  KEY `start_date` (`start_date`),
  KEY `end_date` (`end_date`)
) ENGINE=InnoDB AUTO_INCREMENT=42121 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `unit_order` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `created_date` datetime NOT NULL DEFAULT current_timestamp(),
  `account_id` int(10) unsigned NOT NULL,
  `unit_account_id` int(10) unsigned DEFAULT NULL,
  `unit_contract_id` int(10) unsigned DEFAULT NULL,
  `status` varchar(32) NOT NULL,
  `cost` decimal(10,2) NOT NULL DEFAULT 0.00,
  `expiration_date` date NOT NULL,
  `notes` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_account_id` (`account_id`),
  KEY `idx_unit_account_id` (`unit_account_id`),
  KEY `idx_expiration_date` (`expiration_date`),
  KEY `idx_status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=2235 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `unit_order_bundle` (
  `unit_order_id` int(10) unsigned NOT NULL,
  `product_name_id` varchar(255) NOT NULL,
  `units` int(10) unsigned NOT NULL DEFAULT 0,
  `cost` decimal(10,2) NOT NULL DEFAULT 0.00,
  KEY `idx_unit_order_id` (`unit_order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `unit_order_transaction` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `unit_order_id` int(10) unsigned NOT NULL,
  `account_id` int(10) unsigned NOT NULL,
  `container_id` int(10) unsigned DEFAULT NULL,
  `acct_adjust_id` int(10) unsigned NOT NULL,
  `amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `tax_amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `currency` char(3) NOT NULL DEFAULT 'USD',
  `payment_type` enum('balance') NOT NULL DEFAULT 'balance',
  `transaction_date` datetime NOT NULL DEFAULT current_timestamp(),
  `transaction_type` enum('order','refund') NOT NULL DEFAULT 'order',
  PRIMARY KEY (`id`),
  KEY `idx_account_id` (`account_id`),
  KEY `idx_acct_adjust_id` (`acct_adjust_id`),
  KEY `idx_unit_id` (`unit_order_id`),
  KEY `ix_transaction_date` (`transaction_date`)
) ENGINE=InnoDB AUTO_INCREMENT=1236 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `upgrade_options` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `number` tinyint(4) NOT NULL DEFAULT 0,
  `name` varchar(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `acct_id` int(6) unsigned zerofill NOT NULL DEFAULT 000000,
  `firstname` varchar(128) DEFAULT NULL,
  `lastname` varchar(128) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `username` varchar(64) DEFAULT NULL,
  `job_title` varchar(64) DEFAULT NULL,
  `telephone` varchar(32) DEFAULT NULL,
  `telephone_extension` varchar(32) DEFAULT NULL,
  `hashpass` varchar(128) NOT NULL DEFAULT '',
  `newpass` tinyint(4) DEFAULT 1,
  `opt_in_news` tinyint(1) DEFAULT 0,
  `is_master` tinyint(1) DEFAULT 0,
  `super_access` tinyint(1) NOT NULL DEFAULT 0,
  `reseller_access` tinyint(1) NOT NULL DEFAULT 0,
  `basic_access` tinyint(1) NOT NULL DEFAULT 1,
  `recovery_admin` tinyint(1) NOT NULL DEFAULT 0,
  `status` enum('active','inactive','deleted') NOT NULL DEFAULT 'active',
  `secret_question` int(11) NOT NULL DEFAULT 0,
  `secret_answer` varchar(255) NOT NULL DEFAULT '',
  `first_ip` varchar(15) DEFAULT NULL,
  `ctime` datetime DEFAULT NULL,
  `role` varchar(200) NOT NULL,
  `ent_role` varchar(200) DEFAULT 'limited',
  `ent_unit_id` int(10) unsigned DEFAULT 0,
  `token` varchar(32) DEFAULT NULL,
  `token_time` datetime NOT NULL DEFAULT '1900-00-00 00:00:00',
  `last_verified` datetime DEFAULT '1900-00-00 00:00:00',
  `forgot_block` tinyint(4) NOT NULL DEFAULT 0,
  `consecutive_failed_logins` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `i18n_language_id` tinyint(4) unsigned DEFAULT 1,
  `agent_agreement_id` int(11) NOT NULL,
  `agent_agreement_date` datetime DEFAULT NULL,
  `last_password_change` datetime NOT NULL,
  `account_summary_email_frequency` enum('never','monthly','quarterly') NOT NULL DEFAULT 'never',
  `tfa_phone_number` varchar(40) NOT NULL,
  `is_limited_admin` tinyint(3) NOT NULL DEFAULT 0,
  `container_id` int(10) unsigned DEFAULT NULL,
  `default_payment_profile_id` int(11) DEFAULT 0,
  `last_login_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  KEY `acct_id` (`acct_id`),
  KEY `idx_email` (`email`(12)),
  KEY `token` (`token`(8)),
  KEY `container_id` (`container_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2027503 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `users_requiring_password_reset` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `reason` varchar(64) DEFAULT NULL,
  `date_created` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `ix_user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4103 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `user_company` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `company_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`company_id`),
  KEY `company_id` (`company_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1888631 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `user_contact_info` (
  `user_id` int(10) unsigned NOT NULL,
  `field` varchar(32) NOT NULL,
  `value` varchar(255) NOT NULL,
  KEY `user_id` (`user_id`),
  KEY `field` (`field`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `user_container_assignments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `container_id` int(11) NOT NULL,
  `date_created` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_container_id` (`container_id`)
) ENGINE=InnoDB AUTO_INCREMENT=38624 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `user_ent_units` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `unit_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id_idx` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=57139 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `user_google_auth_cache` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `device_id` int(11) NOT NULL DEFAULT 0,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `otp` varchar(50) NOT NULL,
  `date_time` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `device_id` (`device_id`),
  KEY `otp` (`otp`),
  KEY `date_time` (`date_time`)
) ENGINE=InnoDB AUTO_INCREMENT=471693 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `user_google_auth_devices` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `acct_id` int(8) unsigned NOT NULL DEFAULT 0,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `date_added` datetime NOT NULL,
  `date_last_used` datetime NOT NULL,
  `encrypted_secret_key` varchar(255) NOT NULL,
  `failed_attempts` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `acct_id` (`acct_id`)
) ENGINE=InnoDB AUTO_INCREMENT=29568 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `user_invite` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `date_accepted` datetime DEFAULT NULL,
  `date_processed` datetime DEFAULT NULL,
  `last_sent_date` datetime DEFAULT NULL,
  `status` varchar(16) NOT NULL,
  `invite_key` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `user_id` int(11) NOT NULL,
  `container_id` int(11) NOT NULL,
  `processor_user_id` int(11) DEFAULT NULL,
  `created_user_id` int(11) DEFAULT NULL,
  `requested_firstname` varchar(128) DEFAULT NULL,
  `requested_lastname` varchar(128) DEFAULT NULL,
  `requested_username` varchar(64) DEFAULT NULL,
  `requested_job_title` varchar(128) DEFAULT NULL,
  `requested_telephone` varchar(32) DEFAULT NULL,
  `requested_hashpass` varchar(128) NOT NULL DEFAULT '',
  `requested_secret_question` int(11) DEFAULT NULL,
  `requested_secret_answer` varchar(255) DEFAULT NULL,
  `invite_note` varchar(255) DEFAULT NULL,
  `processor_comment` varchar(255) DEFAULT NULL,
  `is_sso_only` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_user_invites_key` (`invite_key`) USING HASH,
  KEY `ix_container_id_user_id` (`container_id`,`user_id`),
  KEY `user_invite_username` (`requested_username`)
) ENGINE=InnoDB AUTO_INCREMENT=66141628 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `user_tfa_client_certs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `acct_id` int(8) unsigned NOT NULL DEFAULT 0,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `date_added` datetime NOT NULL,
  `date_last_used` datetime NOT NULL,
  `thumbprint` varchar(40) NOT NULL DEFAULT '',
  `expire_date` datetime NOT NULL,
  `issuer_dn` varchar(100) NOT NULL,
  `ca_order_id` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `acct_id` (`acct_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6585 DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `validation_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `sub_of` int(11) NOT NULL DEFAULT 0,
  `ia_qiis` tinyint(1) NOT NULL DEFAULT 1,
  `approved_staff` smallint(2) unsigned NOT NULL DEFAULT 0,
  `approved_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `ia_qiis` (`ia_qiis`)
) ENGINE=InnoDB AUTO_INCREMENT=2291 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `validation_contexts` (
  `item_id` int(11) NOT NULL,
  `context` varchar(40) DEFAULT NULL,
  `sort_order` tinyint(4) DEFAULT NULL,
  KEY `contexts_item_id` (`item_id`),
  KEY `contexts_context` (`context`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `validation_docs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `v_id` int(4) unsigned zerofill NOT NULL DEFAULT 0000,
  `filename` varchar(128) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `v_id` (`v_id`)
) ENGINE=InnoDB AUTO_INCREMENT=322 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `validation_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category` int(11) NOT NULL DEFAULT 0,
  `contexts` varchar(150) NOT NULL DEFAULT '',
  `scope` mediumtext NOT NULL,
  `country` varchar(150) NOT NULL,
  `state` varchar(150) NOT NULL,
  `city` varchar(150) NOT NULL,
  `sort_order` tinyint(4) DEFAULT NULL,
  `title` varchar(255) NOT NULL DEFAULT '',
  `url` varchar(1000) NOT NULL DEFAULT '',
  `email` varchar(255) NOT NULL DEFAULT '',
  `telephone` varchar(64) NOT NULL DEFAULT '',
  `fax` varchar(64) NOT NULL DEFAULT '',
  `snail_mail` text NOT NULL,
  `description` text NOT NULL,
  `ia_qiis` tinyint(1) NOT NULL DEFAULT 1,
  `username` varchar(128) NOT NULL,
  `password` varchar(128) NOT NULL,
  `submitted_staff` smallint(2) unsigned NOT NULL DEFAULT 0,
  `submitted_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `ov_approved_staff_1` smallint(2) unsigned NOT NULL DEFAULT 0,
  `ov_approved_time_1` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `ov_approved_staff_2` smallint(2) unsigned NOT NULL DEFAULT 0,
  `ov_approved_time_2` datetime NOT NULL,
  `ev_approved_staff_1` smallint(2) unsigned NOT NULL DEFAULT 0,
  `ev_approved_time_1` datetime NOT NULL,
  `ev_approved_staff_2` smallint(2) unsigned NOT NULL DEFAULT 0,
  `ev_approved_time_2` datetime NOT NULL,
  `post_params` mediumtext DEFAULT NULL,
  `disable_joi_state_province` tinyint(1) DEFAULT 0,
  `disable_joi_locality` tinyint(1) DEFAULT 0,
  `joi_reg_num_patterns` text DEFAULT NULL,
  `ov_status` varchar(16) NOT NULL DEFAULT 'new',
  `ev_status` varchar(16) NOT NULL DEFAULT 'new',
  `joi_reg_num_regex_vals` text DEFAULT '',
  `enforce_regex_check` tinyint(1) DEFAULT 1,
  `last_disclosed` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `is_disclosed` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `category` (`category`)
) ENGINE=InnoDB AUTO_INCREMENT=17622 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `validation_items_history` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `validation_item_id` int(11) NOT NULL,
  `item_json` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `is_archived` tinyint(1) NOT NULL DEFAULT 0,
  `date_updated` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_validation_item_id` (`validation_item_id`),
  KEY `idx_date_updated` (`date_updated`)
) ENGINE=InnoDB AUTO_INCREMENT=9301 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `validation_item_urls` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `validation_item_id` int(11) NOT NULL,
  `url` varchar(1000) NOT NULL DEFAULT '',
  `date_created` datetime NOT NULL DEFAULT current_timestamp(),
  `last_updated` datetime NOT NULL DEFAULT current_timestamp(),
  `staff_id` int(10) unsigned NOT NULL,
  `is_archived` tinyint(1) NOT NULL DEFAULT 0,
  `archived_reason` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `idx_validation_item_id` (`validation_item_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19283 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `validation_notes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `v_id` int(8) unsigned zerofill DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `note` text DEFAULT NULL,
  `staff_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `v_id` (`v_id`)
) ENGINE=InnoDB AUTO_INCREMENT=124 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `valid_dupe_accts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `acct_id` int(6) unsigned zerofill NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=135 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `verified_contacts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `status` enum('pending','active','inactive') NOT NULL DEFAULT 'pending',
  `user_id` int(10) NOT NULL,
  `company_id` int(11) NOT NULL,
  `acct_id` int(8) NOT NULL DEFAULT 0,
  `firstname` varchar(64) NOT NULL,
  `lastname` varchar(64) NOT NULL,
  `email` varchar(255) NOT NULL,
  `job_title` varchar(64) NOT NULL,
  `telephone` varchar(32) NOT NULL,
  `token` varchar(200) NOT NULL,
  `token_date` datetime DEFAULT NULL,
  `encrypted_data` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `status` (`status`),
  KEY `company_id` (`company_id`),
  KEY `firstname` (`firstname`),
  KEY `lastname` (`lastname`),
  KEY `token` (`token`),
  KEY `acct_id` (`acct_id`)
) ENGINE=InnoDB AUTO_INCREMENT=811131 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `verified_contact_roles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `verified_contact_id` int(11) NOT NULL DEFAULT 0,
  `checklist_role_id` int(11) NOT NULL DEFAULT 0,
  `valid_till_date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `verified_contact_id` (`verified_contact_id`),
  KEY `checklist_role_id` (`checklist_role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3450583 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `virtual_account` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `bank_number` char(4) NOT NULL,
  `branch_number` char(3) NOT NULL,
  `virtual_account_number` char(7) NOT NULL,
  `virtual_account_type` char(1) NOT NULL,
  `account_registration_date` datetime DEFAULT NULL,
  `using_start_date` datetime DEFAULT NULL,
  `account_id` int(10) unsigned DEFAULT NULL,
  `container_id` int(10) unsigned DEFAULT NULL,
  `status` varchar(2) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `staff_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_virtual_account_1` (`account_id`,`container_id`),
  KEY `idx_virtual_account_2` (`bank_number`,`branch_number`,`status`,`update_date`)
) ENGINE=InnoDB AUTO_INCREMENT=100001 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `virtual_account_bank_master` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `bank_number` char(4) NOT NULL,
  `branch_number` char(3) NOT NULL,
  `bank_name` varchar(64) NOT NULL,
  `branch_name` varchar(64) NOT NULL,
  `account_name` varchar(64) NOT NULL,
  `update_date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_virtual_account_bank_master` (`bank_number`,`branch_number`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `virtual_account_history` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `virtual_account_id` int(10) unsigned NOT NULL,
  `bank_number` char(4) NOT NULL,
  `branch_number` char(3) NOT NULL,
  `virtual_account_number` char(7) NOT NULL,
  `virtual_account_type` char(1) NOT NULL,
  `using_start_date` datetime DEFAULT NULL,
  `account_id` int(10) unsigned DEFAULT NULL,
  `container_id` int(10) unsigned DEFAULT NULL,
  `status` varchar(2) NOT NULL,
  `update_date` datetime NOT NULL,
  `staff_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31121 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `virtual_account_release` (
  `virtual_account_id` int(10) unsigned NOT NULL,
  `account_id` int(10) unsigned NOT NULL,
  `update_date` datetime NOT NULL,
  PRIMARY KEY (`virtual_account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `voucher_code` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `voucher_order_id` int(10) unsigned NOT NULL,
  `code` varchar(64) NOT NULL,
  `account_id` int(10) unsigned DEFAULT NULL,
  `product_name_id` varchar(255) NOT NULL,
  `no_of_fqdns` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `no_of_wildcards` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `shipping_method` tinyint(3) unsigned DEFAULT NULL,
  `validity_days` smallint(5) unsigned DEFAULT NULL,
  `validity_years` tinyint(3) unsigned DEFAULT NULL,
  `created_date` datetime NOT NULL DEFAULT current_timestamp(),
  `start_date` date DEFAULT NULL,
  `expiry_date` date DEFAULT NULL,
  `use_san_package` tinyint(1) DEFAULT NULL,
  `status` varchar(32) NOT NULL,
  `group_id` smallint(5) unsigned NOT NULL DEFAULT 1,
  `cost` decimal(10,2) NOT NULL DEFAULT 0.00,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_voucher_code` (`code`),
  KEY `idx_account_id` (`account_id`),
  KEY `idx_status` (`status`),
  KEY `idx_group_id` (`group_id`),
  KEY `idx_vo_id` (`voucher_order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=31617 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `voucher_code_orders` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `voucher_code_id` int(10) unsigned DEFAULT NULL,
  `order_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_order_id` (`order_id`),
  KEY `idx_voucher_code_id` (`voucher_code_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19888 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `voucher_code_reissued` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `voucher_code_id` int(10) unsigned NOT NULL,
  `reissued_code` varchar(64) NOT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  `created_date` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_reissued_code` (`reissued_code`),
  KEY `idx_voucher_code_id` (`voucher_code_id`),
  KEY `idx_user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `voucher_order` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `created_date` datetime NOT NULL DEFAULT current_timestamp(),
  `account_id` int(10) unsigned NOT NULL,
  `status` varchar(32) NOT NULL,
  `cost` decimal(10,2) NOT NULL DEFAULT 0.00,
  `cost_plus_tax` decimal(18,2) NOT NULL DEFAULT 0.00,
  `name` varchar(128) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `expiration_date` date NOT NULL,
  `codes_count` smallint(5) unsigned NOT NULL DEFAULT 0,
  `redeemed_count` smallint(5) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `idx_account_id` (`account_id`),
  KEY `idx_expiration_date` (`expiration_date`)
) ENGINE=InnoDB AUTO_INCREMENT=18162 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `voucher_order_transaction` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `voucher_order_id` int(10) unsigned DEFAULT NULL,
  `account_id` int(10) NOT NULL,
  `container_id` int(10) unsigned DEFAULT NULL,
  `receipt_id` int(10) unsigned DEFAULT NULL,
  `acct_adjust_id` int(10) unsigned DEFAULT NULL,
  `invoice_id` int(10) unsigned DEFAULT 0,
  `amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `currency` char(3) NOT NULL DEFAULT 'USD',
  `payment_type` varchar(50) NOT NULL,
  `transaction_date` datetime NOT NULL DEFAULT current_timestamp(),
  `transaction_type` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_account_id` (`account_id`),
  KEY `idx_acct_ajust_id` (`acct_adjust_id`),
  KEY `idx_receipt_id` (`receipt_id`),
  KEY `idx_vo_id` (`voucher_order_id`),
  KEY `ix_transaction_date` (`transaction_date`),
  KEY `idx_invoice_id` (`invoice_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17688 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `voucher_receipt_tax` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `receipt_id` int(10) unsigned NOT NULL DEFAULT 0,
  `voucher_order_id` int(10) unsigned NOT NULL DEFAULT 0,
  `group_id` smallint(5) unsigned NOT NULL DEFAULT 0,
  `product_id` int(11) NOT NULL DEFAULT 0,
  `quantity` smallint(5) unsigned NOT NULL DEFAULT 0,
  `tax_amount` decimal(18,2) NOT NULL DEFAULT 0.00,
  `gross_amount` decimal(18,2) NOT NULL DEFAULT 0.00,
  PRIMARY KEY (`id`),
  KEY `ix_receipt_id` (`receipt_id`),
  KEY `ix_voucher_order_id` (`voucher_order_id`),
  KEY `ix_group_id` (`group_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1942 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `vt_api_call` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` date DEFAULT NULL,
  `api_count` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=269921 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `vt_report_data` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` varchar(255) DEFAULT NULL,
  `order_status` varchar(255) DEFAULT NULL,
  `report_status` varchar(255) DEFAULT NULL,
  `scan_date` date DEFAULT NULL,
  `serial_number` varchar(255) DEFAULT NULL,
  `file_hashes` varchar(255) DEFAULT NULL,
  `data` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5531 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `vt_report_query` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `query_name` varchar(50) NOT NULL DEFAULT '',
  `query_type` varchar(10) NOT NULL DEFAULT 'POSTAUTH',
  `query_text` text DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `changed_by` varchar(45) DEFAULT NULL,
  `comments` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `weak_keys` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ip` varchar(16) DEFAULT NULL,
  `page` varchar(64) DEFAULT NULL,
  `username` varchar(64) DEFAULT NULL,
  `acct_id` int(11) DEFAULT NULL,
  `csr` text DEFAULT NULL,
  `date_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=199 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `weak_keys_all` (
  `id` int(11) NOT NULL,
  `keysize` smallint(5) unsigned NOT NULL DEFAULT 0,
  `seed` smallint(5) unsigned NOT NULL DEFAULT 0,
  `seed_type` enum('rnd','nornd','noreadrnd','') NOT NULL DEFAULT '',
  `arch` enum('ppc64','i386','x86_64','') NOT NULL DEFAULT '',
  `hash1` int(10) unsigned NOT NULL DEFAULT 0,
  `hash2` int(10) unsigned NOT NULL DEFAULT 0,
  `hash3` int(10) unsigned NOT NULL DEFAULT 0,
  `hash4` int(10) unsigned NOT NULL DEFAULT 0,
  `hash5` int(10) unsigned NOT NULL DEFAULT 0,
  KEY `weak_keys_all_hash1` (`hash1`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `whois_batch` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime DEFAULT NULL,
  `account_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `product_id` int(10) unsigned NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=83 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `whois_cache` (
  `domain` varchar(255) NOT NULL,
  `emails` text DEFAULT NULL,
  `whois_output` text DEFAULT NULL,
  `cache_time` datetime DEFAULT NULL,
  `alexa_rank` int(11) DEFAULT NULL,
  PRIMARY KEY (`domain`),
  KEY `cache_time` (`cache_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `whois_contact` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime DEFAULT NULL,
  `whois_record_id` int(10) unsigned NOT NULL,
  `contact_type` varchar(50) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `address_country` varchar(255) DEFAULT NULL,
  `phone` varchar(30) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `clean_phone` varchar(255) DEFAULT NULL,
  `phone_extension` varchar(255) DEFAULT NULL,
  `raa_type` varchar(255) DEFAULT NULL,
  `se_exists` int(1) DEFAULT NULL,
  `se_allowed_chars` int(1) DEFAULT NULL,
  `se_at_char` int(1) DEFAULT NULL,
  `se_domain` int(1) DEFAULT NULL,
  `se_local` int(1) DEFAULT NULL,
  `se_format` int(1) DEFAULT NULL,
  `se_resolvable` int(1) DEFAULT NULL,
  `se_syn_success` int(1) DEFAULT NULL,
  `se_anomaly_detected` int(1) DEFAULT NULL,
  `oe_valid` int(1) DEFAULT NULL,
  `oe_server` int(1) DEFAULT NULL,
  `st_exists` int(1) DEFAULT NULL,
  `st_cc_present` int(1) DEFAULT NULL,
  `st_cc_format` int(1) DEFAULT NULL,
  `st_not_short` int(1) DEFAULT NULL,
  `st_not_long` int(1) DEFAULT NULL,
  `st_allowed_length` int(1) DEFAULT NULL,
  `st_allowed_chars` int(1) DEFAULT NULL,
  `st_extension_present` int(1) DEFAULT NULL,
  `st_extension_char` int(1) DEFAULT NULL,
  `st_extension_format` int(1) DEFAULT NULL,
  `st_2009_success` int(1) DEFAULT NULL,
  `st_2013_success` int(1) DEFAULT NULL,
  `st_syn_success` int(1) DEFAULT NULL,
  `ot_valid` int(1) DEFAULT NULL,
  `ot_dial_early` int(1) DEFAULT NULL,
  `ot_connected` int(1) DEFAULT NULL,
  `ot_busy` int(1) DEFAULT NULL,
  `ot_disconnected` int(1) DEFAULT NULL,
  `ot_all_circuits` int(1) DEFAULT NULL,
  `ot_invalid` int(1) DEFAULT NULL,
  `ot_success` int(1) DEFAULT NULL,
  `se_2009_success` tinyint(4) DEFAULT NULL,
  `se_2013_success` tinyint(4) DEFAULT NULL,
  `st_prepended_zero` int(1) DEFAULT NULL,
  `early_phone` varchar(50) DEFAULT NULL,
  `st_op_syn_success` int(1) DEFAULT NULL,
  `ot_non_digit_char` int(1) DEFAULT NULL,
  `st_local_zero` int(1) DEFAULT NULL,
  `ot_2009_success` int(1) DEFAULT NULL,
  `ot_2013_success` int(1) DEFAULT NULL,
  `ot_retries` tinyint(4) DEFAULT 0,
  `oe_blocked` tinyint(4) DEFAULT NULL,
  `oe_2009_success` tinyint(4) DEFAULT NULL,
  `oe_2013_success` tinyint(4) DEFAULT NULL,
  `oe_success` tinyint(4) DEFAULT NULL,
  `email_domain_part` varchar(255) DEFAULT NULL,
  `email_local_part` varchar(255) DEFAULT NULL,
  `address_city` varchar(255) DEFAULT NULL,
  `address_state` varchar(255) DEFAULT NULL,
  `address_zip` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_whois_record_id` (`whois_record_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1091470 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `whois_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `doc_id` int(11) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `org_name` varchar(255) DEFAULT NULL,
  `staff_id` int(11) DEFAULT 0,
  `whois_type` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `doc_id` (`doc_id`)
) ENGINE=InnoDB AUTO_INCREMENT=555410 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `whois_record` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime DEFAULT NULL,
  `domain` varchar(255) DEFAULT NULL,
  `batch_id` int(10) unsigned NOT NULL DEFAULT 0,
  `product_id` int(10) unsigned NOT NULL,
  `date_completed` datetime DEFAULT NULL,
  `approved_staff_id` int(10) unsigned DEFAULT NULL,
  `open_date` datetime DEFAULT NULL,
  `open_by_staff_id` int(10) unsigned DEFAULT NULL,
  `original_record` text DEFAULT NULL,
  `whois_date_created` varchar(255) DEFAULT NULL,
  `whois_date_updated` varchar(255) DEFAULT NULL,
  `raa_gfather` int(1) DEFAULT NULL,
  `ot_common` int(1) DEFAULT NULL,
  `oe_duplicates` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `domain` (`domain`(8)),
  KEY `ix_batch_id` (`batch_id`),
  KEY `date_completed` (`date_completed`)
) ENGINE=InnoDB AUTO_INCREMENT=363824 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `wifi_friendlynames` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `language` char(3) NOT NULL,
  `friendlyname` text NOT NULL,
  `encoded_friendlyname` text DEFAULT NULL,
  `verified_contact_id` int(11) NOT NULL,
  `date_created` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=216 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `wip_queue` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `position` bigint(20) DEFAULT NULL,
  `entity_type` varchar(50) NOT NULL,
  `entity_id` int(11) NOT NULL,
  `reissue_id` int(11) DEFAULT NULL,
  `checklist_id` int(11) DEFAULT NULL,
  `priority` tinyint(4) DEFAULT 1,
  `created_date` datetime NOT NULL,
  `sleep_until` datetime DEFAULT NULL,
  `dibs_date` datetime DEFAULT NULL,
  `dibs_staff_id` int(11) DEFAULT NULL,
  `origin` varchar(50) DEFAULT NULL,
  `work_type` varchar(50) DEFAULT NULL,
  `work_status` varchar(50) DEFAULT NULL,
  `product_group` varchar(50) DEFAULT NULL,
  `org_country` varchar(50) DEFAULT NULL,
  `untouched` tinyint(4) DEFAULT 1,
  `parent_reservation_id` int(11) DEFAULT NULL,
  `last_checked` timestamp NULL DEFAULT NULL,
  `BRAND` varchar(25) DEFAULT NULL,
  `timezone` varchar(50) DEFAULT '',
  `premium` tinyint(4) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `idx_priority` (`priority`),
  KEY `idx_entity_id` (`entity_id`),
  KEY `idx_dibs_staff_id` (`dibs_staff_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8773472 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `wip_queue_assignment_definition` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `work_types` varchar(255) DEFAULT NULL,
  `work_statuses` varchar(255) DEFAULT NULL,
  `product_groups` varchar(255) DEFAULT NULL,
  `origins` varchar(255) DEFAULT NULL,
  `org_countries` varchar(255) DEFAULT NULL,
  `brands` varchar(255) DEFAULT NULL,
  `exclude_org_countries` varchar(255) DEFAULT NULL,
  `business_hours_only` tinyint(4) NOT NULL DEFAULT 0,
  `account_ids` varchar(255) DEFAULT NULL,
  `premium` varchar(3) NOT NULL DEFAULT '*',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=328 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `wip_queue_assignment_templates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `assignment_json` text NOT NULL,
  `date_created` datetime NOT NULL,
  `created_by_staff_id` int(10) unsigned DEFAULT NULL,
  `date_last_modified` datetime DEFAULT NULL,
  `last_modified_by_staff_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `wip_queue_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `wip_queue_id` int(11) DEFAULT NULL,
  `staff_id` int(11) DEFAULT NULL,
  `event` varchar(255) DEFAULT NULL,
  `timestamp` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `wip_queue_id` (`wip_queue_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3641487 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `wip_queue_reports` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `staff_id` int(11) DEFAULT NULL,
  `group_by` varchar(255) DEFAULT NULL,
  `sorted_group_by` varchar(255) DEFAULT NULL,
  `chart_type` varchar(255) DEFAULT NULL,
  `include_total` tinyint(4) DEFAULT NULL,
  `filters` text DEFAULT NULL,
  `last_result` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `wip_queue_report_preferences` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `wip_queue_report_id` int(11) NOT NULL,
  `staff_id` int(11) NOT NULL,
  `star` tinyint(4) DEFAULT 0,
  `hide` tinyint(4) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_report_staff` (`wip_queue_report_id`,`staff_id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `wip_queue_staff_assignments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `staff_id` int(11) NOT NULL,
  `wip_queue_assignment_definition_id` int(11) NOT NULL,
  `priority` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=54487 DEFAULT CHARSET=utf8;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

CREATE TABLE IF NOT EXISTS `access_permission` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `name` varchar(255) NOT NULL,
  `scope` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `access_permission_feature_map` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `access_permission_id` int(10) unsigned NOT NULL,
  `feature_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `access_role` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(512) DEFAULT NULL,
  `internal_description` varchar(512) DEFAULT NULL,
  `api_role` tinyint(4) NOT NULL DEFAULT 0,
  `is_admin` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=130584 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `access_role_permission` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `access_role_id` int(10) unsigned NOT NULL,
  `access_permission_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_access_role_id_permission_id` (`access_role_id`,`access_permission_id`)
) ENGINE=InnoDB AUTO_INCREMENT=540 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `access_user_role_map` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `access_role_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_user_id_access_role_id` (`user_id`,`access_role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=768661 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `accounts` (
  `id` int(6) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `type` enum('retail','enterprise','grid','hisp') NOT NULL DEFAULT 'retail',
  `acct_type` tinyint(1) DEFAULT 0,
  `acct_class_id` smallint(5) unsigned DEFAULT 1,
  `acct_status` tinyint(1) DEFAULT 0,
  `is_enterprise` tinyint(1) NOT NULL DEFAULT 0,
  `reseller_id` int(11) NOT NULL DEFAULT 0,
  `primary_company_id` int(11) NOT NULL DEFAULT 0,
  `discount_id` int(5) unsigned zerofill DEFAULT 00000,
  `acct_create_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `allow_trial` tinyint(1) NOT NULL DEFAULT 0,
  `show_addr_on_seal` tinyint(1) NOT NULL DEFAULT 0,
  `renewal_notice_email` varchar(50) NOT NULL DEFAULT '60' COMMENT 'Number of days before the expiration of certificates to send a renewal email',
  `renewal_notice_phone` varchar(50) NOT NULL DEFAULT '30' COMMENT 'Number of days before the expiration of certificates to call to remind about renewal.',
  `vip` tinyint(1) NOT NULL DEFAULT 0,
  `send_minus_104` tinyint(1) DEFAULT 1,
  `send_minus_90` tinyint(1) DEFAULT 1,
  `send_minus_60` tinyint(1) DEFAULT 1,
  `send_minus_30` tinyint(1) DEFAULT 1,
  `send_minus_7` tinyint(1) DEFAULT 1,
  `send_minus_3` tinyint(1) DEFAULT 1,
  `send_plus_7` tinyint(1) DEFAULT 1,
  `make_renewal_calls` tinyint(1) DEFAULT 1,
  `receipt_note` text DEFAULT NULL,
  `cert_format` enum('attachment','plaintext') DEFAULT 'attachment',
  `default_root_path` enum('digicert','entrust','cybertrust') DEFAULT 'digicert',
  `compat_root_path` enum('entrust','cybertrust') NOT NULL DEFAULT 'cybertrust',
  `prefer_global_root` tinyint(4) DEFAULT 1,
  `account_options` set('limit_dcvs','reissue_no_revoke','is_mvp_enabled','no_auto_dcv','hide_subscriber_agreement','ip_locked','dc_guid_allowed','no_collect_email','also_email_unit_members','dont_prefill_deposit_info','allow_cname_dcvs','key_usage_critical_false','po_disabled','no_invoice_email','no_invoice_mail','basic_constraints_critical_false','session_roaming','no_autofill_po_billto','ev_cs_device_locking','default_no_admin_dcvs','dcv_only_show_approvable','force_no_admin_dcvs','_wc_sans','has_limited_admins','ssl_data_encipherment_option','ssl_radius_eku_option','no_auto_invoice','use_org_unit','cloud_retail_api','im_session','restrict_manual_dcvs','no_auto_resend_dcv') DEFAULT NULL,
  `account_tags` varchar(100) DEFAULT '',
  `max_referrals` int(11) NOT NULL DEFAULT 3,
  `acct_death_date` date DEFAULT NULL,
  `gsa` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `max_uc_names` smallint(3) unsigned NOT NULL DEFAULT 0,
  `i18n_language_id` tinyint(4) unsigned DEFAULT 1,
  `namespace_protected` tinyint(4) NOT NULL DEFAULT 0,
  `acct_rep_staff_id` int(10) unsigned DEFAULT 0,
  `dev_staff_id` int(10) unsigned DEFAULT NULL,
  `client_mgr_staff_id` int(10) unsigned DEFAULT NULL,
  `force_password_change_days` smallint(5) unsigned NOT NULL DEFAULT 0,
  `enabled_apis` set('client_cert_api','advanced_api','grid_api','wildcard_api','shopify_api','yahoo_api','simple_api','retail_api','inpriva_api','direct_api','hisp_api','fbca_api','gtld_api') DEFAULT NULL,
  `first_order_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `invoice_notes` text DEFAULT NULL,
  `ssl_ca_cert_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_testing` tinyint(4) NOT NULL DEFAULT 0,
  `balance_negative_limit` int(11) DEFAULT NULL,
  `balance_reminder_threshold` int(11) DEFAULT NULL,
  `cert_transparency` enum('default','on','logonly','ocsp','embed','off') NOT NULL DEFAULT 'embed',
  `use_existing_commission_rate` tinyint(4) NOT NULL DEFAULT 0,
  `partner_user_id` int(11) NOT NULL DEFAULT 0,
  `tfa_enabled` tinyint(4) NOT NULL DEFAULT 0,
  `tfa_show_remember_checkbox` tinyint(4) NOT NULL DEFAULT 0,
  `show_hidden_products` varchar(255) DEFAULT NULL,
  `has_limited_admins` tinyint(3) NOT NULL DEFAULT 0,
  `require_agreement` tinyint(3) NOT NULL DEFAULT 0,
  `agreement_id` int(10) unsigned DEFAULT NULL,
  `agreement_ip` varchar(50) DEFAULT NULL,
  `agreement_user_id` int(10) unsigned DEFAULT NULL,
  `agreement_date` timestamp NULL DEFAULT NULL,
  `express_installer` tinyint(4) DEFAULT 0,
  `is_cert_central` tinyint(4) DEFAULT 0,
  `last_note_date` datetime DEFAULT NULL,
  `display_rep` tinyint(4) DEFAULT 1,
  `acct_origin` set('digi','vz','azr','certcent','venafi','google','marketing') DEFAULT 'digi',
  `lead_source` varchar(255) DEFAULT NULL,
  `zero_balance_email` tinyint(4) DEFAULT 1,
  `test_cert_lifetime` int(11) DEFAULT 3,
  PRIMARY KEY (`id`),
  KEY `accounts_create_date` (`acct_create_date`),
  KEY `accounts_is_enterprise` (`is_enterprise`),
  KEY `accounts_renewal_notice_phone` (`renewal_notice_phone`(5)),
  KEY `reseller` (`id`,`reseller_id`),
  KEY `acct_type` (`acct_type`),
  KEY `primary_company_id` (`primary_company_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1588884 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `account_agreement_audit_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `agreement_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `ip_address` varchar(40) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2301297 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `account_agreement_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `agreement_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `ip_address` varchar(40) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `account_agreement_idx` (`account_id`,`agreement_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2493750 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `account_auth_key` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` int(10) unsigned NOT NULL,
  `auth_key_id` varchar(64) NOT NULL,
  `is_active` tinyint(3) unsigned NOT NULL DEFAULT 1,
  `date_created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_account_id` (`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1717 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `account_ca_map` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `ca_cert_id` int(11) NOT NULL,
  `csr_type` enum('any','rsa','ecc') NOT NULL DEFAULT 'any',
  `signature_hash` enum('any','sha1','sha2-any','sha256','sha384','sha512') NOT NULL DEFAULT 'any',
  PRIMARY KEY (`id`),
  KEY `account_id` (`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=241 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `account_class_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `account_class_id` int(11) NOT NULL,
  `old_account_class_id` int(11) NOT NULL,
  `staff_id` int(11) NOT NULL,
  `change_time` datetime DEFAULT NULL,
  `acct_rep_staff_id` int(11) DEFAULT NULL,
  `old_acct_rep_staff_id` int(11) DEFAULT NULL,
  `dev_staff_id` int(11) DEFAULT NULL,
  `old_dev_staff_id` int(11) DEFAULT NULL,
  `client_mgr_staff_id` int(11) DEFAULT NULL,
  `old_client_mgr_staff_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_account_id` (`account_id`),
  KEY `idx_staff_id` (`staff_id`)
) ENGINE=InnoDB AUTO_INCREMENT=38334 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `account_client_ca_profiles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `acct_id` int(6) unsigned NOT NULL,
  `product_id` int(10) unsigned NOT NULL,
  `cert_template_id` int(10) unsigned NOT NULL,
  `ca_cert_id` smallint(5) unsigned NOT NULL,
  `legacy_ca_cert_id` smallint(5) unsigned NOT NULL,
  `is_private` tinyint(3) unsigned NOT NULL,
  `is_active` tinyint(3) unsigned NOT NULL,
  `is_email_domain_validation_required` tinyint(3) unsigned NOT NULL,
  `is_email_delivery_required` tinyint(3) unsigned NOT NULL,
  `max_lifetime` tinyint(3) unsigned NOT NULL,
  `internal_description` varchar(255) DEFAULT NULL,
  `display_sort_id` smallint(6) NOT NULL DEFAULT 0,
  `api_id` varchar(255) DEFAULT NULL,
  `container_id` int(10) unsigned DEFAULT NULL,
  `api_group_name` varchar(45) DEFAULT NULL,
  `unique_common_name_required` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `ascii_sanitize_request` tinyint(3) DEFAULT 0,
  `api_delivery_only` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `allow_sans` tinyint(3) unsigned DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `api_id_UNIQUE` (`api_id`),
  KEY `acct_id` (`acct_id`),
  KEY `cert_template_id` (`cert_template_id`)
) ENGINE=InnoDB AUTO_INCREMENT=260 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `account_commission_rates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `acct_id` int(10) unsigned DEFAULT NULL,
  `commission_id` int(10) unsigned DEFAULT NULL,
  `date_started` date DEFAULT NULL,
  `date_ended` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12514 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `account_descendant_map` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int(10) unsigned NOT NULL,
  `child_id` int(10) unsigned NOT NULL,
  `child_account_level` int(10) unsigned NOT NULL DEFAULT 1,
  `managed_by_user_id` int(10) unsigned DEFAULT NULL,
  `child_name` varchar(64) DEFAULT NULL,
  `hidden` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_parent_id_child_id` (`parent_id`,`child_id`),
  UNIQUE KEY `ix_child_id_parent_id` (`child_id`,`parent_id`),
  KEY `ix_account_level` (`child_account_level`),
  KEY `ix_account_manager` (`managed_by_user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=32689 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `account_discount_rate_expirations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL DEFAULT 0,
  `discount_id` int(11) NOT NULL DEFAULT 0,
  `expiration_date` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_account_id` (`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=34343 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `account_funds` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` int(10) unsigned NOT NULL,
  `container_id` int(10) unsigned NOT NULL,
  `acct_adjust_id` int(10) unsigned NOT NULL,
  `created` datetime NOT NULL DEFAULT current_timestamp(),
  `expiration` datetime NOT NULL DEFAULT current_timestamp(),
  `started` datetime DEFAULT NULL,
  `amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `balance` decimal(10,2) NOT NULL DEFAULT 0.00,
  `status` enum('active','consumed','expired') NOT NULL DEFAULT 'active',
  PRIMARY KEY (`id`),
  KEY `idx_account_id` (`account_id`),
  KEY `idx_container_id` (`container_id`),
  KEY `idx_status` (`status`),
  KEY `idx_expiration` (`expiration`),
  KEY `idx_acct_adjust_id` (`acct_adjust_id`)
) ENGINE=InnoDB AUTO_INCREMENT=124870 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `account_funds_expiry_notices` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `account_funds_id` int(10) unsigned NOT NULL,
  `minus_0_sent` tinyint(1) NOT NULL DEFAULT 0,
  `minus_3_sent` tinyint(1) NOT NULL DEFAULT 0,
  `minus_7_sent` tinyint(1) NOT NULL DEFAULT 0,
  `minus_14_sent` tinyint(1) NOT NULL DEFAULT 0,
  `minus_30_sent` tinyint(1) NOT NULL DEFAULT 0,
  `minus_60_sent` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_account_funds_id` (`account_funds_id`),
  KEY `idx_minus_0_sent` (`minus_0_sent`),
  KEY `idx_minus_3_sent` (`minus_3_sent`),
  KEY `idx_minus_7_sent` (`minus_7_sent`),
  KEY `idx_minus_14_sent` (`minus_14_sent`),
  KEY `idx_minus_30_sent` (`minus_30_sent`),
  KEY `idx_minus_60_sent` (`minus_60_sent`)
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `account_modification` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(40) NOT NULL DEFAULT '',
  `description` varchar(100) DEFAULT NULL,
  `configuration` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `account_origin_cookies` (
  `acct_id` int(6) unsigned zerofill NOT NULL,
  `utmv` varchar(255) DEFAULT NULL,
  `initial_page` varchar(255) DEFAULT NULL COMMENT 'The url for the landing page.',
  `referer` varchar(255) DEFAULT NULL COMMENT 'The url that referred the user to the landing page.',
  `search_term` varchar(100) DEFAULT NULL,
  `query_string` varchar(100) DEFAULT NULL,
  `date_recorded` datetime DEFAULT NULL,
  `medium` varchar(64) DEFAULT NULL,
  `source` varchar(64) DEFAULT NULL,
  `campaign` varchar(64) DEFAULT NULL,
  `date_landed` datetime DEFAULT NULL COMMENT 'The date the landing page was hit.',
  `ip` varchar(45) DEFAULT NULL COMMENT 'The IP address of the user who created the account. IPv4 (15 chars), IPv6 (39 chars) IPv6 notation for IPv4 (45 chars)',
  PRIMARY KEY (`acct_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `account_ou_cert_request_map` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` int(10) unsigned NOT NULL,
  `ou_value` varchar(255) NOT NULL,
  `certificate_request_id` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_account_ou_cert_request` (`account_id`,`ou_value`,`certificate_request_id`),
  KEY `ix_ou_value` (`ou_value`)
) ENGINE=InnoDB AUTO_INCREMENT=644336 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `account_private_ca_certs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `acct_id` int(6) unsigned NOT NULL,
  `ca_cert_id` smallint(5) unsigned NOT NULL,
  `container_id` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `acct_ca_cert_id` (`acct_id`,`ca_cert_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2243 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `account_product_map` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `product_name_id` varchar(64) NOT NULL,
  `require_tos` tinyint(4) NOT NULL DEFAULT 1,
  `date_created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_account_product` (`account_id`,`product_name_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15817743 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `account_reseller_info` (
  `acct_id` int(6) unsigned zerofill NOT NULL DEFAULT 000000,
  `max_partner_discount` tinyint(3) unsigned NOT NULL DEFAULT 10,
  `existing_customer_commission_rate` tinyint(3) unsigned NOT NULL DEFAULT 10,
  `commission_id` int(5) unsigned NOT NULL DEFAULT 0,
  `incentive_plan` tinyint(4) NOT NULL DEFAULT 0,
  `flag` tinyint(2) NOT NULL DEFAULT 0,
  `rsl_effective_date` date NOT NULL DEFAULT '0000-00-00',
  `rsl_cancel_date` date NOT NULL DEFAULT '0000-00-00',
  `rsl_cancel_reason` text NOT NULL,
  `rsl_reject_reason` text NOT NULL,
  `rsl_agreement_id` int(10) unsigned NOT NULL DEFAULT 0,
  `rsl_apply_date` date NOT NULL DEFAULT '0000-00-00',
  `rsl_pay_type` enum('acct_credit','check') NOT NULL DEFAULT 'acct_credit',
  `allowed_products` varchar(255) NOT NULL,
  `domain` varchar(255) DEFAULT NULL,
  `company_type_id` tinyint(3) unsigned DEFAULT NULL,
  `company_type_other` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`acct_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `account_settings` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL DEFAULT current_timestamp(),
  `account_id` int(10) unsigned NOT NULL,
  `name` varchar(64) NOT NULL,
  `value` text DEFAULT NULL,
  `read_only` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_account_id_name` (`account_id`,`name`),
  KEY `idx_name` (`name`(11))
) ENGINE=InnoDB AUTO_INCREMENT=1200387 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `acct_adjust` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `acct_id` int(6) unsigned zerofill NOT NULL DEFAULT 000000,
  `unit_id` int(11) unsigned NOT NULL DEFAULT 0,
  `order_id` int(8) unsigned zerofill NOT NULL DEFAULT 00000000,
  `ent_client_cert_id` int(10) NOT NULL DEFAULT 0,
  `adjust_type` tinyint(3) DEFAULT NULL,
  `amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `staff_id` int(10) NOT NULL DEFAULT 0,
  `note` mediumtext DEFAULT NULL,
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `balance_after` decimal(10,2) NOT NULL DEFAULT 0.00,
  `balance_breakdown` mediumtext DEFAULT NULL,
  `receipt_id` int(10) NOT NULL DEFAULT 0,
  `confirmed` tinyint(1) NOT NULL DEFAULT 1,
  `confirmed_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `confirmed_staff` int(10) NOT NULL DEFAULT 5,
  `prev_type` tinyint(3) DEFAULT NULL,
  `confirm_note` mediumtext DEFAULT NULL,
  `po_id` int(10) unsigned DEFAULT NULL,
  `container_id` int(10) unsigned DEFAULT NULL,
  `netsuite_invoice_id` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `acct_id` (`acct_id`),
  KEY `receipt_id` (`receipt_id`),
  KEY `unit_id` (`unit_id`),
  KEY `idx_order_id` (`order_id`),
  KEY `idx_container_id` (`container_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4578949 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `acct_classes` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `tier` enum('Retail Accounts','Managed Accounts') DEFAULT 'Retail Accounts',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `acct_docs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `acct_id` int(6) unsigned zerofill NOT NULL DEFAULT 000000,
  `filename` varchar(128) NOT NULL DEFAULT '',
  `upload_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `status` tinyint(3) NOT NULL DEFAULT 1,
  `notes` varchar(255) NOT NULL DEFAULT '',
  `is_new` tinyint(1) NOT NULL DEFAULT 1,
  `type` varchar(30) NOT NULL DEFAULT 'agreement',
  `staff_id` int(11) NOT NULL DEFAULT 0,
  `contract_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `acct_docs_a_id_idx` (`acct_id`)
) ENGINE=InnoDB AUTO_INCREMENT=42109 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `acct_flags` (
  `id` tinyint(1) NOT NULL AUTO_INCREMENT,
  `number` tinyint(1) NOT NULL DEFAULT 0,
  `color` varchar(16) NOT NULL DEFAULT '',
  `description` varchar(128) NOT NULL DEFAULT '',
  `color_code` varchar(7) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `acct_notes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `acct_id` int(8) unsigned zerofill DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `note` text DEFAULT NULL,
  `staff_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `acct_id` (`acct_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14205 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `acct_statuses` (
  `id` tinyint(3) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `acct_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` mediumtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `acct_units_adjust` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` int(10) unsigned NOT NULL,
  `contract_id` int(10) unsigned NOT NULL,
  `unit_bundle_id` int(11) DEFAULT NULL,
  `product_id` int(10) unsigned NOT NULL,
  `order_id` int(10) unsigned NOT NULL,
  `cert_tracker_id` int(10) unsigned DEFAULT NULL,
  `adjust_type` int(10) unsigned NOT NULL,
  `amount` decimal(10,2) DEFAULT 0.00,
  `server_license` int(10) unsigned NOT NULL,
  `staff_id` int(10) unsigned NOT NULL,
  `note` text DEFAULT NULL,
  `created` datetime NOT NULL DEFAULT current_timestamp(),
  `balance_after` decimal(10,2) DEFAULT 0.00,
  `container_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_account_id` (`account_id`),
  KEY `ix_product_id` (`product_id`),
  KEY `ix_order_id` (`order_id`),
  KEY `ix_contract_id` (`contract_id`),
  KEY `ix_unit_bundle_id` (`unit_bundle_id`)
) ENGINE=InnoDB AUTO_INCREMENT=475380 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `acme_api_keys` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `api_permission_id` int(10) unsigned NOT NULL,
  `url_mask` varchar(10) DEFAULT NULL,
  `organization_id` int(10) NOT NULL,
  `product_name_id` varchar(64) NOT NULL,
  `validity_days` int(10) unsigned DEFAULT NULL,
  `validity_years` int(10) unsigned DEFAULT NULL,
  `ssl_profile_option` varchar(32) DEFAULT NULL,
  `container_id` int(10) unsigned DEFAULT NULL,
  `eab_kid` varchar(255) DEFAULT NULL,
  `eab_hmac` varchar(255) DEFAULT NULL,
  `ca_cert_id` varchar(255) DEFAULT NULL,
  `order_validity_days` int(11) DEFAULT NULL,
  `order_validity_years` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_api_permission_id` (`api_permission_id`) USING HASH,
  KEY `ix_container_id` (`container_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4413 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `acme_metadata` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `acme_api_key_id` int(10) unsigned NOT NULL,
  `metadata_id` int(10) unsigned NOT NULL,
  `value` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_acme_api_key_metadata` (`acme_api_key_id`,`metadata_id`)
) ENGINE=InnoDB AUTO_INCREMENT=766 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `additional_order_info` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(10) unsigned NOT NULL,
  `option_name` enum('server_licenses','legacy_product_name','symc_order_id','san_packages','voucher_id','va_status','guest_access') COLLATE utf8mb4_bin NOT NULL,
  `option_value_str` text COLLATE utf8mb4_bin NOT NULL,
  `option_value_int` int(11) unsigned DEFAULT NULL,
  `date_created` datetime NOT NULL DEFAULT current_timestamp(),
  `last_updated` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_order_id_option_name` (`order_id`,`option_name`),
  KEY `ix_order_id` (`order_id`),
  KEY `ix_option_name` (`option_name`),
  KEY `ix_option_value_int` (`option_value_int`)
) ENGINE=InnoDB AUTO_INCREMENT=9198282 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='Order Options Table. One to Many on order_id';

CREATE TABLE IF NOT EXISTS `adjust_types` (
  `id` tinyint(3) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL DEFAULT '',
  `description` varchar(255) NOT NULL DEFAULT '',
  `admin_only` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `agreements` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(50) NOT NULL DEFAULT 'normal_subscriber',
  `acct_id` int(11) NOT NULL DEFAULT 0,
  `effective_date` datetime NOT NULL,
  `end_date` datetime DEFAULT NULL,
  `condition` varchar(50) NOT NULL,
  `text` text NOT NULL,
  `text_es` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `alert` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `account_id` int(11) NOT NULL DEFAULT 0,
  `category` varchar(64) NOT NULL,
  `message` text NOT NULL,
  `start_date` datetime NOT NULL,
  `expiration_date` datetime NOT NULL,
  `display_filters` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_account_id` (`account_id`),
  KEY `idx_expiration_date` (`expiration_date`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `alert_dismissal` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `alert_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_alert_id` (`alert_id`),
  KEY `idx_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `allowed_saml_products` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_name_id` varchar(255) NOT NULL,
  `date_created` datetime NOT NULL,
  `account_id` int(11) DEFAULT NULL,
  `allowed_lifetimes` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `product_name_id_UNIQUE` (`product_name_id`,`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1064 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `api_calls` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `acct_id` int(6) unsigned zerofill NOT NULL DEFAULT 000000,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `action` varchar(32) DEFAULT NULL,
  `ip_address` varchar(15) NOT NULL DEFAULT '',
  `date_time` datetime DEFAULT NULL,
  `data` mediumtext DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=338779 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `api_call_log` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` int(11) unsigned NOT NULL,
  `user_id` int(11) unsigned NOT NULL,
  `api` enum('REST') NOT NULL DEFAULT 'REST',
  `api_key` varchar(255) DEFAULT NULL,
  `remote_ip` int(10) unsigned NOT NULL,
  `call_time` datetime NOT NULL,
  `duration` float(6,2) DEFAULT NULL,
  `method` varchar(15) NOT NULL DEFAULT 'GET',
  `request_url` varchar(125) NOT NULL DEFAULT '',
  `request_headers` text DEFAULT NULL,
  `request_body` text DEFAULT NULL,
  `response_code` int(3) NOT NULL,
  `response_headers` text DEFAULT NULL,
  `response_body` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `acl_account_id` (`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4067969 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `api_log_cc_v2` (
  `hash_id` bigint(20) unsigned NOT NULL,
  `transaction_date` date NOT NULL DEFAULT '0000-00-00',
  `controller` varchar(255) DEFAULT NULL,
  `methods` varchar(16) NOT NULL DEFAULT '',
  `route` varchar(192) NOT NULL DEFAULT '',
  `content_type` varchar(64) NOT NULL DEFAULT '',
  `transaction_count` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`hash_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `api_permissions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `acct_id` int(6) unsigned zerofill NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `hashed_api_key` varchar(255) NOT NULL DEFAULT '',
  `create_date` datetime DEFAULT NULL,
  `last_used_date` datetime DEFAULT NULL,
  `name` varchar(200) DEFAULT NULL,
  `status` enum('active','revoked') DEFAULT 'active',
  `external_id` varchar(255) DEFAULT NULL,
  `key_type` enum('permanent','temporary','acme') NOT NULL DEFAULT 'permanent',
  `validity_minutes` int(11) NOT NULL DEFAULT 0,
  `access_role_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `external_id_UNIQUE` (`external_id`),
  KEY `acct_id` (`acct_id`),
  KEY `user_id` (`user_id`),
  KEY `idx_key_type` (`key_type`) USING HASH
) ENGINE=InnoDB AUTO_INCREMENT=1336655 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `api_permissions_old` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `acct_id` int(6) unsigned zerofill NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `hashed_api_key` varchar(255) NOT NULL DEFAULT '',
  `create_date` datetime DEFAULT NULL,
  `last_used_date` datetime DEFAULT NULL,
  `name` varchar(200) DEFAULT NULL,
  `status` enum('active','revoked') DEFAULT 'active',
  `external_id` varchar(255) DEFAULT NULL,
  `key_type` enum('permanent','temporary','acme') NOT NULL DEFAULT 'permanent',
  `validity_minutes` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `external_id_UNIQUE` (`external_id`),
  KEY `acct_id` (`acct_id`),
  KEY `user_id` (`user_id`),
  KEY `idx_key_type` (`key_type`) USING HASH
) ENGINE=InnoDB AUTO_INCREMENT=1206096 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `audit_bad_address_orders` (
  `order_id` int(10) unsigned NOT NULL,
  `status` varchar(16) NOT NULL DEFAULT 'new',
  `revoked` tinyint(4) NOT NULL DEFAULT 0,
  `reissued` tinyint(4) NOT NULL DEFAULT 0,
  `address_fixed` tinyint(4) NOT NULL DEFAULT 0,
  `prevalidation_expired` tinyint(4) NOT NULL DEFAULT 0,
  `needs_revoke` varchar(16) DEFAULT NULL,
  `batch_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `bad_internal_names` (
  `order_id` int(10) unsigned DEFAULT NULL,
  `last_checked_order` int(10) unsigned DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `blacklisted_domains` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `domain_blacklist_id` int(11) unsigned NOT NULL,
  `match_type` enum('base_domain','extracted_base_domain') NOT NULL,
  `indexed_domain` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `domain_blacklist_id` (`domain_blacklist_id`),
  KEY `indexed_domain` (`indexed_domain`(8))
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `blacklist_cache_dates` (
  `blacklist_name` varchar(100) NOT NULL,
  `date_last_cached` datetime DEFAULT NULL,
  PRIMARY KEY (`blacklist_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `blacklist_consolidated` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `source` varchar(128) NOT NULL,
  `type` varchar(16) NOT NULL DEFAULT '',
  `name` varchar(512) NOT NULL,
  `slim_name` varchar(512) NOT NULL,
  `country_code` varchar(2) NOT NULL DEFAULT '',
  `is_aka` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `ix_slim_name` (`slim_name`(255))
) ENGINE=InnoDB AUTO_INCREMENT=29394 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `blacklist_denied_persons` (
  `name` varchar(255) NOT NULL,
  `slim_name` varchar(255) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `country` char(2) NOT NULL,
  `postal_code` varchar(50) DEFAULT NULL,
  KEY `name` (`name`),
  KEY `country` (`country`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `blacklist_ecfr_orgs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `country` varchar(255) DEFAULT NULL,
  `org_name` text DEFAULT NULL,
  `slim_name` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1611 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `blacklist_ip` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ip` varchar(15) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `blacklist_millersmiles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `date_reported` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_name` (`name`(10))
) ENGINE=InnoDB AUTO_INCREMENT=441904 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `blacklist_phishtank` (
  `phish_id` int(10) DEFAULT NULL,
  `url` text DEFAULT NULL,
  `phish_detail_url` text DEFAULT NULL,
  `submission_time` datetime DEFAULT NULL,
  `verified` tinyint(4) DEFAULT NULL,
  `verification_time` datetime DEFAULT NULL,
  `online` tinyint(4) DEFAULT NULL,
  `target` text DEFAULT NULL,
  `target_slim_name` varchar(200) DEFAULT NULL,
  `base_domain` text DEFAULT NULL,
  KEY `target_slim_name` (`target_slim_name`(12)),
  KEY `base_domain` (`base_domain`(12))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `blacklist_sdn_akas` (
  `id` int(10) unsigned NOT NULL,
  `person_id` int(10) unsigned DEFAULT NULL,
  `aka` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_aka` (`aka`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `blacklist_sdn_orgs` (
  `id` int(10) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `blacklist_sdn_org_akas` (
  `id` int(10) unsigned NOT NULL,
  `person_id` int(10) unsigned DEFAULT NULL,
  `aka` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_aka` (`aka`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `blacklist_sdn_persons` (
  `id` int(10) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `boomi_account_updates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` int(10) unsigned NOT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_account_id` (`account_id`),
  KEY `idx_date_updates` (`date_updated`)
) ENGINE=InnoDB AUTO_INCREMENT=90680 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `boomi_po_updates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `po_id` int(10) unsigned NOT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_po_id` (`po_id`),
  KEY `idx_date_updates` (`date_updated`)
) ENGINE=InnoDB AUTO_INCREMENT=166500 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `canned_notes` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ordering` int(11) NOT NULL DEFAULT 0,
  `category` varchar(50) NOT NULL DEFAULT '',
  `text` varchar(255) NOT NULL DEFAULT '',
  `date_updated` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  `date_deleted` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `case_notes` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` timestamp NOT NULL DEFAULT current_timestamp(),
  `order_id` int(11) unsigned NOT NULL,
  `staff_id` int(11) unsigned NOT NULL,
  `order_action_requested` tinyint(3) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=26966 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `case_note_canned_notes` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `case_note_id` int(11) unsigned NOT NULL,
  `canned_note_id` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=40538 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `ca_calls` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `call_type` varchar(255) NOT NULL DEFAULT '',
  `common_name` varchar(255) NOT NULL DEFAULT '',
  `date_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `order_id` int(8) NOT NULL DEFAULT 0,
  `data` mediumtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `ca_calls_air_gap` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(8) unsigned zerofill NOT NULL DEFAULT 00000000,
  `reissue_id` int(11) NOT NULL DEFAULT 0,
  `duplicate_id` int(11) NOT NULL DEFAULT 0,
  `ent_client_cert_id` int(11) NOT NULL DEFAULT 0,
  `call_type` varchar(255) NOT NULL DEFAULT '',
  `common_name` varchar(255) NOT NULL DEFAULT '',
  `date_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `request_data` mediumtext NOT NULL,
  `response_data` mediumtext NOT NULL,
  `request_id` varchar(50) NOT NULL DEFAULT '0',
  `downloaded_date_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `uploaded_date_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `completed_date_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `ca_cert_info` (
  `ca_cert_id` smallint(5) unsigned NOT NULL,
  `subject_common_name` varchar(255) NOT NULL,
  `subject_org_name` varchar(255) NOT NULL,
  `issuer_common_name` varchar(255) NOT NULL,
  `valid_from` varchar(19) NOT NULL DEFAULT '',
  `valid_to` varchar(19) NOT NULL DEFAULT '',
  `serial_number` varchar(64) NOT NULL,
  `thumbprint` char(40) NOT NULL,
  `signature_hash` varchar(64) NOT NULL,
  `is_private` tinyint(3) unsigned NOT NULL,
  `is_root` tinyint(3) unsigned NOT NULL,
  `issuer_ca_cert_id` smallint(5) unsigned NOT NULL,
  `pem` text NOT NULL,
  `external_id` varchar(40) NOT NULL DEFAULT '',
  `flags` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`ca_cert_id`),
  UNIQUE KEY `serial_number_UNIQUE` (`serial_number`),
  UNIQUE KEY `thumbprint_UNIQUE` (`thumbprint`),
  KEY `flags` (`flags`(12))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `ca_cert_templates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `ca_template_data` text DEFAULT NULL,
  `ui_template_data` text DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `is_key_escrow` tinyint(3) unsigned NOT NULL,
  `private_only` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `ca_intermediates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `thumbprint` varchar(128) NOT NULL DEFAULT '',
  `common_name` varchar(100) NOT NULL DEFAULT '',
  `pem` mediumtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `thumbprint` (`thumbprint`)
) ENGINE=InnoDB AUTO_INCREMENT=1153 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `ca_issued_certs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(8) unsigned zerofill NOT NULL DEFAULT 00000000,
  `reissue_id` int(11) NOT NULL DEFAULT 0,
  `duplicate_id` int(11) NOT NULL DEFAULT 0,
  `ent_client_cert_id` int(11) NOT NULL DEFAULT 0,
  `ctime` timestamp NOT NULL DEFAULT current_timestamp(),
  `common_name` varchar(128) NOT NULL DEFAULT '',
  `valid_from` date NOT NULL DEFAULT '0000-00-00',
  `valid_till` date NOT NULL DEFAULT '0000-00-00',
  `keysize` int(11) NOT NULL DEFAULT 0,
  `serial_number` varchar(36) NOT NULL DEFAULT '',
  `thumbprint` varchar(42) NOT NULL DEFAULT '',
  `ca_order_id` varchar(20) NOT NULL DEFAULT '',
  `sans` text NOT NULL,
  `chain` varchar(32) DEFAULT NULL,
  `pem` mediumtext DEFAULT NULL,
  `ca_cert_id` smallint(6) NOT NULL DEFAULT 0,
  `last_seen` date NOT NULL DEFAULT '1900-01-01',
  `last_seen_ocsp` date NOT NULL DEFAULT '1900-01-01',
  `key_type` enum('ecc','rsa','dsa','dh','') NOT NULL DEFAULT '',
  `sig` enum('','sha1WithRSAEncryption','sha224WithRSAEncryption','sha256WithRSAEncryption','sha384WithRSAEncryption','sha512WithRSAEncryption','sha384ECDSA','sha256ECDSA') NOT NULL DEFAULT '',
  `revoked` tinyint(3) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `ent_client_cert_id` (`ent_client_cert_id`),
  KEY `thumbprint` (`thumbprint`(8)),
  KEY `serial_number` (`serial_number`(8)),
  KEY `ca_order_id` (`ca_order_id`(8)),
  KEY `_idx_valid_till` (`valid_till`),
  KEY `_idx_ctime` (`ctime`)
) ENGINE=InnoDB AUTO_INCREMENT=28029363 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `certcentral_conversion_data_cache` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` int(10) unsigned NOT NULL,
  `account_name` varchar(256) DEFAULT NULL,
  `master_user_email` varchar(256) DEFAULT NULL,
  `master_user_firstname` varchar(64) DEFAULT NULL,
  `master_user_lastname` varchar(64) DEFAULT NULL,
  `account_rep` varchar(64) DEFAULT NULL,
  `account_manager` varchar(64) DEFAULT NULL,
  `conversion_blockers` varchar(1024) DEFAULT NULL,
  `conversion_warnings` varchar(1024) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `active_orders` int(10) unsigned NOT NULL DEFAULT 0,
  `active_client_certs` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_account_id` (`account_id`),
  KEY `idx_date_created` (`date_created`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `certificate_notes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `certificate_tracker_id` int(11) NOT NULL,
  `text` text DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_certificate_tracker_id` (`certificate_tracker_id`)
) ENGINE=InnoDB AUTO_INCREMENT=978986 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `certificate_reissue_notices` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `certificate_tracker_id` int(10) unsigned NOT NULL,
  `minus_90_sent` tinyint(1) NOT NULL DEFAULT 0,
  `minus_60_sent` tinyint(1) NOT NULL DEFAULT 0,
  `minus_30_sent` tinyint(1) NOT NULL DEFAULT 0,
  `minus_7_sent` tinyint(1) NOT NULL DEFAULT 0,
  `minus_3_sent` tinyint(1) NOT NULL DEFAULT 0,
  `plus_7_sent` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `certificate_tracker_id` (`certificate_tracker_id`),
  KEY `minus_90_sent` (`minus_90_sent`),
  KEY `minus_60_sent` (`minus_60_sent`),
  KEY `minus_30_sent` (`minus_30_sent`),
  KEY `minus_7_sent` (`minus_7_sent`),
  KEY `minus_3_sent` (`minus_3_sent`),
  KEY `plus_7_sent` (`plus_7_sent`)
) ENGINE=InnoDB AUTO_INCREMENT=13820 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `certificate_tracker` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `type` tinyint(3) unsigned NOT NULL,
  `public_id` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_public_id` (`public_id`(6))
) ENGINE=InnoDB AUTO_INCREMENT=125977622 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `cert_approvals` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `domain_id` int(11) NOT NULL,
  `name_scope` varchar(255) NOT NULL,
  `standing` enum('yes','no','canceled') NOT NULL,
  `origin` enum('dcv','dal','phone','internal','clone','cname','demo','direct','txt','standing_email','standing_phone') DEFAULT NULL,
  `approver_name` varchar(255) NOT NULL DEFAULT '',
  `approver_email` varchar(255) NOT NULL DEFAULT '',
  `approver_ip` varchar(15) NOT NULL DEFAULT '',
  `staff_id` int(11) NOT NULL DEFAULT 0,
  `staff_note` text DEFAULT NULL,
  `doc_id` int(11) DEFAULT 0,
  `ctime` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `mtime` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `agreement_id` tinyint(4) NOT NULL DEFAULT 0,
  `clone_id` int(11) DEFAULT NULL,
  `approver_dcv_token` varchar(32) DEFAULT NULL,
  `standing_cert_approval_id` int(11) DEFAULT NULL,
  `manual` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `domain_id` (`domain_id`),
  KEY `name_scope` (`name_scope`),
  KEY `standing` (`standing`)
) ENGINE=InnoDB AUTO_INCREMENT=4034520 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `cert_inspector_access_tokens` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `token` varchar(32) NOT NULL DEFAULT '',
  `email` varchar(100) NOT NULL DEFAULT '',
  `firstname` varchar(150) NOT NULL DEFAULT '',
  `lastname` varchar(150) NOT NULL DEFAULT '',
  `organization` varchar(150) NOT NULL DEFAULT '',
  `phone` varchar(25) DEFAULT NULL,
  `phone_extension` varchar(12) DEFAULT NULL,
  `token_first_generated` timestamp NOT NULL DEFAULT current_timestamp(),
  `account_created` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `certificate_inspector_download_2` (`token`),
  UNIQUE KEY `customer_email` (`email`),
  KEY `certificate_inspector_download_token` (`token`)
) ENGINE=InnoDB AUTO_INCREMENT=20263 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `checkboxes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `reference` varchar(50) DEFAULT NULL,
  `name` varchar(1024) NOT NULL,
  `description` text DEFAULT NULL,
  `type` enum('DOMAIN','COMPANY','CONTACT') DEFAULT NULL,
  `note_required` tinyint(1) NOT NULL DEFAULT 0,
  `note_template` text DEFAULT NULL,
  `special_purpose` enum('gtld_reject') DEFAULT NULL,
  `default_valid_time` varchar(45) DEFAULT NULL,
  `hook` varchar(100) DEFAULT NULL,
  `read_only` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `type` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=1814 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `checkbox_customer_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `message` varchar(2048) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `checkbox_customer_statuses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `checklist_name_id` int(11) DEFAULT NULL COMMENT 'This column allows us to make rejection/other step status messages that are specific to a checklist_name_id.  Excluding a checklist_name_id allows status codes to be reused across multiple checklists which all include some checklist_step_id where they all',
  `checklist_step_id` int(11) NOT NULL,
  `checkbox_id` int(11) DEFAULT NULL,
  `special_purpose` enum('gtld_reject','gtld_approved') DEFAULT NULL,
  `active` tinyint(1) NOT NULL,
  `customer_status_code` int(11) NOT NULL COMMENT 'Allows the API to pass back standard ''reason codes'' along with the status messages.  Note that you could hypothetically have 2 messages with different message texts (customer_message) for human consumption, but whose semantic meaning for automated systems',
  `checkbox_customer_message_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `CHECKLIST_STEP` (`checklist_step_id`,`active`)
) ENGINE=InnoDB AUTO_INCREMENT=165 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `checkbox_docs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `checkbox_id` int(10) unsigned NOT NULL,
  `doc_type_id` int(10) unsigned NOT NULL,
  `name` varchar(100) NOT NULL DEFAULT '',
  `description` text DEFAULT NULL,
  `num_required` tinyint(3) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `fk_assertion_docs_assertions` (`checkbox_id`),
  KEY `fk_assertion_docs_doc_types` (`doc_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1070 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `checklists` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `checklist_name_id` int(11) NOT NULL,
  `checklist_step_id` int(11) DEFAULT NULL,
  `checkbox_id` int(11) NOT NULL,
  `org_type_id` int(10) unsigned DEFAULT NULL,
  `modifier_id` int(10) unsigned DEFAULT NULL,
  `checklist_role_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_active` tinyint(1) NOT NULL DEFAULT 0,
  `sort_order` tinyint(3) unsigned DEFAULT 100,
  `date_created` datetime DEFAULT NULL,
  `date_inactivated` datetime DEFAULT NULL,
  `valid_months` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_checklist_assertions_assertions` (`checkbox_id`),
  KEY `fk_checklist_assertions_assertion_groups` (`checklist_step_id`),
  KEY `fk_checklist_assertions_checklist_modifiers` (`modifier_id`),
  KEY `fk_checklist_checklist_role_id` (`checklist_role_id`),
  KEY `is_active` (`is_active`),
  KEY `org_type_id` (`org_type_id`),
  KEY `checklist_name_id` (`checklist_name_id`),
  KEY `modifier_id` (`modifier_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1107 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `checklist_cache` (
  `order_id` int(11) NOT NULL DEFAULT 0,
  `checklist_id` int(11) NOT NULL DEFAULT 0,
  `company_id` int(11) NOT NULL DEFAULT 0,
  `domain_id` int(11) NOT NULL DEFAULT 0,
  `last_checked` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `status` enum('unknown','in_progress','first_auth_done','second_auth_done','issue_ready') NOT NULL DEFAULT 'unknown',
  `whats_left_counts` varchar(255) NOT NULL DEFAULT '',
  `whats_left_json` text DEFAULT NULL,
  PRIMARY KEY (`order_id`,`company_id`,`domain_id`,`checklist_id`),
  KEY `domain_id` (`domain_id`),
  KEY `checklist_id` (`checklist_id`,`company_id`,`domain_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `checklist_modifiers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `description` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `checklist_roles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `checklist_steps` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `reference` varchar(50) DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `sort_order` smallint(3) unsigned DEFAULT 100,
  `customer_friendly_name` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1019 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `checkmarks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `checkbox_id` int(10) unsigned NOT NULL,
  `company_id` int(10) unsigned DEFAULT NULL,
  `domain_id` int(10) unsigned DEFAULT NULL,
  `contact_id` int(10) DEFAULT NULL,
  `checkmark_status_id` int(10) unsigned NOT NULL,
  `first_approval_staff_id` int(10) unsigned DEFAULT NULL,
  `first_approval_date_time` datetime DEFAULT NULL,
  `second_approval_staff_id` int(10) unsigned DEFAULT NULL,
  `second_approval_date_time` datetime DEFAULT NULL,
  `audit_staff_id` int(10) unsigned DEFAULT NULL,
  `audit_date_time` datetime DEFAULT NULL,
  `review_note` text DEFAULT NULL,
  `date_expires` datetime NOT NULL,
  `rejected_staff_id` int(10) unsigned DEFAULT NULL,
  `rejected_date_time` datetime DEFAULT NULL,
  `checkbox_customer_status_id` int(11) DEFAULT NULL COMMENT 'A customer message (with optional API status code) for this checkmark.  Currently used to include a customer-friendly "reject reason" for gTLD''s.',
  PRIMARY KEY (`id`),
  KEY `fk_company_assertions_assertions` (`checkbox_id`),
  KEY `fk_company_assertions_companies` (`company_id`),
  KEY `fk_company_assertions_domains` (`domain_id`),
  KEY `fk_company_assertions_staff` (`first_approval_staff_id`),
  KEY `fk_company_assertions_staff1` (`second_approval_staff_id`),
  KEY `fk_company_assertions_assertion_statuses` (`checkmark_status_id`),
  KEY `checkmarks_date_expires` (`date_expires`),
  KEY `fk_checkmarks_contact_id` (`contact_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15048709 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `checkmark_amendments` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `checklist_step_id` int(10) unsigned NOT NULL,
  `old_checkmark_id` int(10) unsigned NOT NULL,
  `new_checkmark_id` int(10) unsigned DEFAULT NULL,
  `staff_id` int(10) unsigned NOT NULL,
  `note` text NOT NULL,
  `date_created` datetime NOT NULL,
  `date_completed` datetime DEFAULT NULL,
  `approved_staff_id` int(10) unsigned NOT NULL,
  `date_approved` datetime DEFAULT NULL,
  `cancelled_staff_id` int(11) DEFAULT NULL,
  `date_cancelled` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `old_idx` (`old_checkmark_id`)
) ENGINE=InnoDB AUTO_INCREMENT=22106 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `checkmark_docs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `checkmark_id` int(10) unsigned NOT NULL,
  `document_id` int(11) NOT NULL,
  `created_by_staff_id` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_company_assertion_docs_company_assertions` (`checkmark_id`),
  KEY `fk_company_assertion_docs_documents` (`document_id`),
  KEY `fk_company_assertion_docs_staff` (`created_by_staff_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13406296 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `checkmark_notes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `checkmark_id` int(10) unsigned NOT NULL,
  `staff_id` int(10) unsigned NOT NULL,
  `date_created` datetime NOT NULL,
  `note` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_checkmark_notes_checkmarks` (`checkmark_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3225556 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `client_cert_email` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ent_client_cert_id` int(10) unsigned NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_token_id` int(10) unsigned DEFAULT NULL,
  `date_emailed` datetime DEFAULT NULL,
  `date_validated` datetime DEFAULT NULL,
  `date_created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_ent_client_cert_id` (`ent_client_cert_id`)
) ENGINE=InnoDB AUTO_INCREMENT=905410 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `client_cert_renewal_notices` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ent_client_cert_id` int(11) DEFAULT NULL,
  `order_id` int(11) NOT NULL,
  `minus_90_sent` tinyint(1) NOT NULL DEFAULT 0,
  `minus_60_sent` tinyint(1) NOT NULL DEFAULT 0,
  `minus_30_sent` tinyint(1) NOT NULL DEFAULT 0,
  `minus_7_sent` tinyint(1) NOT NULL DEFAULT 0,
  `minus_3_sent` tinyint(1) NOT NULL DEFAULT 0,
  `plus_7_sent` tinyint(1) NOT NULL DEFAULT 0,
  `disable_renewal_notifications` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_order_id` (`order_id`),
  KEY `idx_ent_client_cert_id` (`ent_client_cert_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13233 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `cobranding_images` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` int(11) DEFAULT NULL,
  `reseller_id` int(10) unsigned DEFAULT NULL,
  `filename` varchar(150) DEFAULT NULL,
  `image_type` tinyint(3) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `cobranding_image_types` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `commissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `reseller_id` int(6) unsigned zerofill NOT NULL DEFAULT 000000,
  `month` tinyint(2) unsigned zerofill NOT NULL DEFAULT 00,
  `year` mediumint(4) NOT NULL DEFAULT 0,
  `calculated_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `num_orders` int(11) NOT NULL DEFAULT 0,
  `order_total` decimal(10,2) NOT NULL DEFAULT 0.00,
  `percentage` tinyint(2) NOT NULL DEFAULT 10,
  `paid_amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `paid_bonus` decimal(10,2) NOT NULL,
  `paid_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `paid_memo` varchar(255) NOT NULL DEFAULT '',
  `rates` text NOT NULL,
  `universal` tinyint(1) NOT NULL DEFAULT 0,
  `rate_id` int(5) unsigned zerofill NOT NULL DEFAULT 00000,
  `currency` char(3) CHARACTER SET ascii NOT NULL DEFAULT 'USD',
  PRIMARY KEY (`id`),
  UNIQUE KEY `reseller_id` (`reseller_id`,`month`,`year`)
) ENGINE=InnoDB AUTO_INCREMENT=70202 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `commission_adjustments` (
  `id` int(8) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `order_id` int(8) unsigned NOT NULL,
  `normal_commission_date` date NOT NULL,
  `adjusted_commission_date` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=572 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `commission_rates` (
  `id` int(5) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL DEFAULT '',
  `universal` tinyint(1) NOT NULL DEFAULT 0,
  `rates` text NOT NULL,
  `effective_date` date NOT NULL DEFAULT '0000-00-00',
  `expiration_date` date DEFAULT '0000-00-00',
  `expired` binary(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=183 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `common_names` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(8) unsigned zerofill NOT NULL,
  `common_name` varchar(255) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `domain_id` int(11) NOT NULL,
  `approve_id` int(11) NOT NULL DEFAULT 0,
  `status` enum('active','inactive','pending') DEFAULT 'active',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `domain_id` (`domain_id`),
  KEY `active` (`active`),
  KEY `common_names_approve_id` (`approve_id`),
  KEY `common_names_status` (`status`),
  KEY `common_name` (`common_name`(18))
) ENGINE=InnoDB AUTO_INCREMENT=48094078 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `companies` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `acct_id` int(6) unsigned zerofill NOT NULL DEFAULT 000000,
  `container_id` int(10) unsigned DEFAULT NULL,
  `org_contact_id` int(11) NOT NULL DEFAULT 0,
  `tech_contact_id` int(11) NOT NULL DEFAULT 0,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `ev_status` tinyint(4) NOT NULL DEFAULT 1,
  `org_name` varchar(255) NOT NULL DEFAULT '',
  `org_type` int(10) NOT NULL DEFAULT 1,
  `org_assumed_name` varchar(255) NOT NULL DEFAULT '',
  `org_addr1` varchar(128) NOT NULL DEFAULT '',
  `org_addr2` varchar(128) NOT NULL DEFAULT '',
  `org_zip` varchar(40) NOT NULL DEFAULT '',
  `org_city` varchar(128) NOT NULL DEFAULT '',
  `org_state` varchar(128) NOT NULL DEFAULT '',
  `org_country` varchar(2) NOT NULL DEFAULT '',
  `org_email` varchar(128) NOT NULL,
  `telephone` varchar(32) NOT NULL DEFAULT '',
  `org_reg_num` varchar(200) NOT NULL DEFAULT '',
  `jur_city` varchar(128) NOT NULL DEFAULT '',
  `jur_state` varchar(128) NOT NULL DEFAULT '',
  `jur_country` varchar(2) NOT NULL DEFAULT '',
  `incorp_agency` varchar(255) NOT NULL DEFAULT '',
  `master_agreement_sent` tinyint(1) NOT NULL DEFAULT 0,
  `locked` tinyint(1) NOT NULL DEFAULT 0,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `ov_validated_until` datetime DEFAULT NULL,
  `ev_validated_until` datetime DEFAULT NULL,
  `public_phone` varchar(32) NOT NULL DEFAULT '',
  `public_email` varchar(128) NOT NULL DEFAULT '',
  `namespace_protected` tinyint(4) NOT NULL DEFAULT 0,
  `slim_org_name` varchar(255) NOT NULL DEFAULT '',
  `pending_validation_checklist_ids` varchar(50) NOT NULL,
  `validation_submit_date` datetime DEFAULT NULL,
  `reject_notes` varchar(255) NOT NULL DEFAULT '',
  `reject_date_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `reject_staff` int(10) unsigned NOT NULL DEFAULT 0,
  `flag` tinyint(4) NOT NULL DEFAULT 0,
  `snooze_until` datetime DEFAULT NULL,
  `checklist_modifiers` varchar(30) NOT NULL,
  `ascii_name` varchar(255) DEFAULT NULL,
  `risk_score` smallint(5) unsigned NOT NULL DEFAULT 0,
  `incorp_agency_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `acct_id` (`acct_id`),
  KEY `org_contact_id` (`org_contact_id`),
  KEY `tech_contact_id` (`tech_contact_id`),
  KEY `status` (`status`),
  KEY `companies_org_name` (`org_name`),
  KEY `companies_org_state` (`org_state`),
  KEY `companies_org_country` (`org_country`),
  KEY `companies_jur_state` (`jur_state`),
  KEY `companies_jur_country` (`jur_country`),
  KEY `active` (`active`),
  KEY `org_type` (`org_type`),
  KEY `slim_org_name` (`slim_org_name`),
  KEY `pending_validation_checklist_ids` (`pending_validation_checklist_ids`),
  KEY `validation_submit_date` (`validation_submit_date`),
  KEY `container_id` (`container_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1400846 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `companies_statuses` (
  `id` tinyint(1) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `company_history` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `company_id` int(10) unsigned DEFAULT NULL,
  `staff_id` int(10) unsigned DEFAULT NULL,
  `datetime` datetime DEFAULT NULL,
  `field_name` varchar(255) DEFAULT NULL,
  `old_value` varchar(255) DEFAULT NULL,
  `new_value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_company_assertion_docs_staff` (`staff_id`),
  KEY `fk_company_assertions_companies` (`company_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4010636 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `company_intermediates` (
  `acct_id` int(11) NOT NULL,
  `ca_cert_id` int(11) NOT NULL,
  PRIMARY KEY (`acct_id`,`ca_cert_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `company_subdomains` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `domain_id` int(11) DEFAULT NULL,
  `company_id` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `status` enum('requested','approved','declined') DEFAULT 'requested',
  `ctime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `company_index` (`company_id`,`name`),
  KEY `domain_index` (`domain_id`)
) ENGINE=InnoDB AUTO_INCREMENT=132750 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `company_types` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `contacts` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `job_title` varchar(64) DEFAULT NULL,
  `firstname` varchar(128) DEFAULT NULL,
  `lastname` varchar(128) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `telephone` varchar(32) DEFAULT NULL,
  `telephone_ext` varchar(16) NOT NULL DEFAULT '',
  `fax` varchar(32) DEFAULT NULL,
  `i18n_language_id` tinyint(4) unsigned DEFAULT 1,
  `last_updated` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  `container_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `firstname` (`firstname`),
  KEY `lastname` (`lastname`),
  KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2529882 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `contact_map` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) DEFAULT NULL,
  `organization_id` int(11) DEFAULT NULL,
  `contact_id` int(11) DEFAULT NULL,
  `verified_contact_id` int(11) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_contact` (`contact_id`),
  KEY `idx_organization_id` (`organization_id`)
) ENGINE=InnoDB AUTO_INCREMENT=993697 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `contact_whitelist` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `contact_hash` varchar(32) DEFAULT NULL,
  `staff_id` int(11) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `account_id` int(10) unsigned DEFAULT NULL,
  `firstname` varchar(64) DEFAULT NULL,
  `lastname` varchar(64) DEFAULT NULL,
  `email` varchar(128) DEFAULT NULL,
  `phone` varchar(64) DEFAULT NULL,
  `phone_extension` varchar(64) DEFAULT NULL,
  `fax` varchar(64) DEFAULT NULL,
  `job_title` varchar(64) DEFAULT NULL,
  `staff_id2` int(10) unsigned DEFAULT NULL,
  `note` text DEFAULT NULL,
  `document_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_contact_hash` (`contact_hash`),
  KEY `ix_date_created` (`date_created`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `container` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `public_id` varchar(32) NOT NULL,
  `parent_id` int(10) unsigned DEFAULT NULL,
  `tree_level` smallint(5) unsigned NOT NULL,
  `account_id` int(10) unsigned NOT NULL,
  `container_template_id` int(10) unsigned NOT NULL,
  `logo_file_id` int(10) unsigned DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `is_active` tinyint(3) unsigned NOT NULL,
  `user_agreement_id` int(11) DEFAULT NULL,
  `ekey` varchar(32) DEFAULT NULL,
  `allowed_domain_names` text DEFAULT NULL,
  `type` varchar(16) NOT NULL DEFAULT 'standard',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_public_id` (`public_id`),
  KEY `ix_account_id` (`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=536799 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `container_ca_map` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `container_id` int(11) unsigned NOT NULL,
  `product_name_id` varchar(255) NOT NULL,
  `ca_cert_id` int(11) unsigned NOT NULL,
  `csr_type` enum('any','rsa','ecc') NOT NULL DEFAULT 'any',
  `signature_hash` enum('any','sha1','sha2-any','sha256','sha384','sha512') NOT NULL DEFAULT 'any',
  PRIMARY KEY (`id`),
  KEY `ix_container_product` (`container_id`,`product_name_id`)
) ENGINE=InnoDB AUTO_INCREMENT=42507 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `container_descendant_map` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `container_id` int(10) unsigned NOT NULL,
  `descendant_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_container_id_descendant_id` (`container_id`,`descendant_id`),
  UNIQUE KEY `ix_descendant_id_container_id` (`descendant_id`,`container_id`)
) ENGINE=InnoDB AUTO_INCREMENT=504120 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `container_domain` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `container_id` int(10) unsigned NOT NULL,
  `domain_id` int(10) unsigned DEFAULT NULL,
  `subdomain_id` int(10) unsigned DEFAULT NULL,
  `is_active` tinyint(4) DEFAULT 1,
  `organization_id` int(10) unsigned DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `status` varchar(16) DEFAULT NULL,
  `full_domain_view` tinyint(1) DEFAULT 0,
  `dcv_method` varchar(16) DEFAULT NULL,
  `dcv_name_scope` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_container_id` (`container_id`),
  KEY `ix_domain_id` (`domain_id`),
  KEY `ix_subdomain_id` (`subdomain_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3381413 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `container_guest_key` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `container_id` int(10) unsigned NOT NULL,
  `date_created` datetime NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `key` varchar(64) NOT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `validity_periods` set('1','2','3','custom') NOT NULL DEFAULT '',
  `mpki_token` varchar(50) DEFAULT NULL,
  `org_permission` enum('both','existing','new') DEFAULT NULL,
  `domain_permission` tinyint(1) unsigned NOT NULL DEFAULT 1,
  `contact_permission` tinyint(1) unsigned NOT NULL DEFAULT 1,
  `txn_summary_permission` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `language_preference` tinyint(4) unsigned NOT NULL DEFAULT 1,
  `expand_cert_opts` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `dcv_method_permission` tinyint(1) unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_key` (`key`)
) ENGINE=InnoDB AUTO_INCREMENT=93182 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `container_guest_key_product_map` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `guest_key_id` int(10) unsigned NOT NULL,
  `product_name_id` varchar(64) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_guest_key_id_product_name_id` (`guest_key_id`,`product_name_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14534 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `container_oem_ica_map` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `container_id` int(10) unsigned NOT NULL,
  `product_name_id` varchar(255) NOT NULL,
  `custom_ica` varchar(64) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_container_product` (`container_id`,`product_name_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3796 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `container_permission_override` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `account_id` int(10) unsigned NOT NULL,
  `container_template_id` int(11) NOT NULL DEFAULT 0,
  `container_id` int(11) NOT NULL DEFAULT 0,
  `access_permission_id` int(10) unsigned NOT NULL,
  `scope` tinyint(3) unsigned DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_account_template_container_permission_id` (`account_id`,`container_template_id`,`container_id`,`access_permission_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7980987 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `container_product_restrictions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `container_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL DEFAULT 0,
  `product_name_id` varchar(64) NOT NULL,
  `allowed_hashes` varchar(250) NOT NULL DEFAULT 'any',
  `allowed_intermediates` varchar(250) NOT NULL DEFAULT 'any',
  `default_intermediate` varchar(12) DEFAULT NULL,
  `allowed_lifetimes` varchar(50) NOT NULL DEFAULT 'any',
  `allow_auto_renew` tinyint(3) unsigned NOT NULL DEFAULT 1,
  `allowed_fqdns` smallint(5) unsigned DEFAULT NULL,
  `allowed_wildcards` smallint(5) unsigned DEFAULT NULL,
  `ct_log_option` enum('per_cert','always','never') DEFAULT NULL,
  `allow_auto_reissue` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `ix_container_id_role_id` (`container_id`,`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=443171 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `container_settings` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime DEFAULT NULL,
  `container_id` int(11) unsigned DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `value` text DEFAULT NULL,
  `allow_override` tinyint(3) unsigned NOT NULL DEFAULT 1,
  `read_only` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `inheritable` tinyint(3) unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE KEY `un_container_id_name` (`container_id`,`name`),
  KEY `ix_container` (`container_id`),
  KEY `name_idx` (`name`(11))
) ENGINE=InnoDB AUTO_INCREMENT=2502154 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `container_template` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `account_id` int(10) unsigned DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `internal_description` varchar(1024) DEFAULT NULL,
  `is_primary` tinyint(3) unsigned NOT NULL,
  `agreement_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25331 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `container_template_access_role_map` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `template_id` int(10) unsigned DEFAULT NULL,
  `access_role_id` int(10) unsigned NOT NULL,
  `account_id` int(11) NOT NULL DEFAULT 0,
  `active` tinyint(3) unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_template_access_role_account_id` (`template_id`,`access_role_id`,`account_id`),
  KEY `ix_account_id` (`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1699577 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `container_template_feature_map` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `container_template_id` int(10) unsigned NOT NULL,
  `feature_id` int(10) unsigned NOT NULL,
  `feature_scope` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_container_template_id_feature_id_feature_scope` (`container_template_id`,`feature_id`,`feature_scope`)
) ENGINE=InnoDB AUTO_INCREMENT=719 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `container_template_map` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `container_template_id` int(10) unsigned NOT NULL,
  `mapped_template_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `container_template_permission_map` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `container_template_id` int(10) unsigned NOT NULL,
  `access_permission_id` int(10) unsigned NOT NULL,
  `scope` tinyint(3) unsigned DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_container_template_id_permission_id` (`container_template_id`,`access_permission_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3814 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `container_template_product_map` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `template_id` int(10) unsigned NOT NULL,
  `product_name_id` varchar(64) NOT NULL,
  `require_tos` tinyint(3) unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_template_id_product_name_id` (`template_id`,`product_name_id`)
) ENGINE=InnoDB AUTO_INCREMENT=631 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `countries` (
  `id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `abbrev` varchar(2) NOT NULL DEFAULT '',
  `upper_abbrev` varchar(2) NOT NULL DEFAULT '',
  `name` varchar(128) DEFAULT NULL,
  `sort_order` tinyint(4) NOT NULL DEFAULT 4,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `allow_ev` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `abbrev` (`abbrev`),
  KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=247 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `country_alias` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime DEFAULT NULL,
  `display` tinyint(4) DEFAULT 0,
  `alias` varchar(255) NOT NULL,
  `phone_code` varchar(3) NOT NULL,
  `parent_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_phone_code` (`phone_code`)
) ENGINE=InnoDB AUTO_INCREMENT=2139 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `country_code` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `phone_code` varchar(3) NOT NULL,
  `regex_validation` varchar(30) DEFAULT NULL,
  `allowed_lengths` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_phone_code` (`phone_code`)
) ENGINE=InnoDB AUTO_INCREMENT=222 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `credited_certs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `acct_id` int(10) unsigned DEFAULT NULL,
  `date_credited` date DEFAULT NULL,
  `any_other` smallint(5) unsigned DEFAULT NULL,
  `any_ssl` smallint(5) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `current_standard_pricing` (
  `currency` char(3) NOT NULL,
  `standard_pricing` text NOT NULL,
  `last_updated` datetime NOT NULL,
  PRIMARY KEY (`currency`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `customer_order` (
  `id` int(10) unsigned NOT NULL,
  `product_name_id` int(10) unsigned NOT NULL,
  `account_id` int(10) unsigned NOT NULL,
  `container_id` int(10) unsigned NOT NULL,
  `status` enum('pending','reissue_pending','issued','revoked','rejected','canceled','waiting_pickup') NOT NULL DEFAULT 'pending',
  `ip_address` varchar(15) CHARACTER SET ascii DEFAULT NULL,
  `certificate_tracker_id` int(10) unsigned NOT NULL DEFAULT 0,
  `customer_order_id` varchar(64) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `date_issued` datetime DEFAULT NULL,
  `status_last_updated` datetime DEFAULT NULL,
  `user_id` int(10) unsigned DEFAULT 0,
  `auto_renew` tinyint(1) NOT NULL DEFAULT 0,
  `renewed_order_id` int(10) unsigned DEFAULT NULL,
  `is_renewed` tinyint(1) NOT NULL DEFAULT 0,
  `disable_renewal_notifications` tinyint(1) NOT NULL DEFAULT 0,
  `disable_issuance_email` tinyint(1) NOT NULL DEFAULT 0,
  `ssl_profile_option` varchar(32) CHARACTER SET ascii DEFAULT NULL,
  `additional_emails` text DEFAULT NULL,
  `custom_renewal_message` text DEFAULT NULL,
  `additional_template_data` text DEFAULT NULL,
  `order_options` text DEFAULT NULL,
  `cs_provisioning_method` enum('client_app','email','ship_token','none') DEFAULT NULL,
  `dcv_method` varchar(16) CHARACTER SET ascii DEFAULT NULL,
  `common_name` varchar(255) DEFAULT NULL,
  `organization_units` text DEFAULT NULL,
  `organization_id` int(10) unsigned DEFAULT NULL,
  `dns_names` text DEFAULT NULL,
  `csr` text DEFAULT NULL,
  `signature_hash` varchar(8) CHARACTER SET ascii DEFAULT NULL,
  `validity_years` int(10) unsigned NOT NULL,
  `date_valid_from` date DEFAULT NULL,
  `date_valid_till` date DEFAULT NULL,
  `serial_number` varchar(128) CHARACTER SET ascii DEFAULT NULL,
  `thumbprint` varchar(40) CHARACTER SET ascii DEFAULT NULL,
  `ca_cert_id` int(10) unsigned NOT NULL,
  `plus_feature` tinyint(1) DEFAULT NULL,
  `service_name` varchar(32) DEFAULT NULL,
  `server_platform_id` int(11) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `cost` decimal(10,2) DEFAULT NULL,
  `purchased_dns_names` int(10) unsigned NOT NULL DEFAULT 0,
  `purchased_wildcard_names` int(10) unsigned NOT NULL DEFAULT 0,
  `pay_type` varchar(4) CHARACTER SET ascii NOT NULL DEFAULT 'A',
  `stat_row_id` int(10) unsigned DEFAULT NULL,
  `names_stat_row_id` int(10) unsigned DEFAULT NULL,
  `wildcard_names_stat_row_id` int(10) unsigned DEFAULT NULL,
  `receipt_id` int(10) unsigned DEFAULT NULL,
  `agreement_id` int(10) unsigned DEFAULT NULL,
  `is_out_of_contract` tinyint(1) NOT NULL DEFAULT 0,
  `locale` varchar(8) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_account_id` (`account_id`),
  KEY `ix_product_name_id` (`product_name_id`),
  KEY `ix_container_id` (`container_id`),
  KEY `ix_date_created` (`date_created`),
  KEY `ix_status_last_updated` (`status_last_updated`),
  KEY `ix_common_name` (`common_name`(16)),
  KEY `ix_organization_id` (`organization_id`),
  KEY `ix_validity_years` (`validity_years`),
  KEY `ix_valid_till` (`date_valid_till`),
  KEY `ix_receipt_id` (`receipt_id`),
  KEY `id_certificate_tracker_id` (`certificate_tracker_id`),
  KEY `id_thumbprint` (`thumbprint`(10)),
  KEY `ix_customer_order_id` (`customer_order_id`(8)),
  KEY `ix_serial_number` (`serial_number`(8)),
  KEY `ix_renewed_order_id` (`renewed_order_id`),
  KEY `ix_user_id` (`user_id`),
  KEY `ix_ca_cert_id` (`ca_cert_id`),
  KEY `ix_dcv_method` (`dcv_method`),
  KEY `ix_date_issued` (`date_issued`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `customer_order_contact` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(10) unsigned NOT NULL,
  `firstname` varchar(128) DEFAULT NULL,
  `lastname` varchar(128) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `telephone` varchar(32) DEFAULT NULL,
  `job_title` varchar(64) DEFAULT NULL,
  `contact_type` varchar(32) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `last_updated` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_order_id` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=33248624 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `customer_order_domain` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(10) unsigned NOT NULL,
  `domain_name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_order_id` (`order_id`),
  KEY `ix_domain_name` (`domain_name`)
) ENGINE=InnoDB AUTO_INCREMENT=226816734 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `customer_order_email` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(10) unsigned NOT NULL,
  `email` varchar(255) NOT NULL,
  `date_created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_order_id` (`order_id`),
  KEY `ix_email` (`email`),
  KEY `ix_date_created` (`date_created`)
) ENGINE=InnoDB AUTO_INCREMENT=949432 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `customer_order_reissue_history` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(10) unsigned NOT NULL,
  `legacy_reissue_id` int(10) unsigned DEFAULT NULL,
  `legacy_client_cert_id` int(10) unsigned DEFAULT NULL,
  `is_original_order` tinyint(4) NOT NULL DEFAULT 0,
  `status` enum('pending','reissue_pending','issued','revoked','rejected','canceled') NOT NULL DEFAULT 'pending',
  `ip_address` varchar(15) CHARACTER SET ascii DEFAULT NULL,
  `certificate_tracker_id` int(10) unsigned DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `date_issued` datetime DEFAULT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  `additional_template_data` text DEFAULT NULL,
  `order_options` text DEFAULT NULL,
  `dcv_method` varchar(16) CHARACTER SET ascii DEFAULT NULL,
  `common_name` varchar(255) DEFAULT NULL,
  `organization_units` text DEFAULT NULL,
  `organization_id` int(10) unsigned DEFAULT NULL,
  `dns_names` text DEFAULT NULL,
  `csr` text DEFAULT NULL,
  `signature_hash` varchar(8) CHARACTER SET ascii DEFAULT NULL,
  `date_valid_from` date DEFAULT NULL,
  `date_valid_till` date DEFAULT NULL,
  `serial_number` varchar(128) CHARACTER SET ascii DEFAULT NULL,
  `thumbprint` varchar(40) CHARACTER SET ascii DEFAULT NULL,
  `ca_cert_id` int(10) unsigned NOT NULL,
  `service_name` varchar(32) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `cost` decimal(10,2) DEFAULT NULL,
  `purchased_dns_names` int(10) unsigned DEFAULT NULL,
  `pay_type` varchar(4) CHARACTER SET ascii NOT NULL DEFAULT 'A',
  `stat_row_id` int(10) unsigned DEFAULT NULL,
  `names_stat_row_id` int(10) unsigned DEFAULT NULL,
  `receipt_id` int(10) unsigned DEFAULT NULL,
  `agreement_id` int(10) unsigned DEFAULT NULL,
  `is_out_of_contract` tinyint(1) NOT NULL DEFAULT 0,
  `purchased_wildcard_names` int(10) unsigned DEFAULT NULL,
  `wildcard_names_stat_row_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_order_id` (`order_id`),
  KEY `ix_legacy_reissue_id` (`legacy_reissue_id`),
  KEY `ix_legacy_client_cert_id` (`legacy_client_cert_id`),
  KEY `ix_certificate_tracker_id` (`certificate_tracker_id`),
  KEY `ix_receipt_id` (`receipt_id`),
  KEY `ix_date_created` (`date_created`)
) ENGINE=InnoDB AUTO_INCREMENT=5729768 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `customer_po_request` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` int(10) unsigned NOT NULL,
  `container_id` int(10) unsigned NOT NULL,
  `date_created` datetime NOT NULL,
  `approval_status` enum('pending','approved','rejected') DEFAULT 'pending',
  `review_staff_id` mediumint(8) unsigned NOT NULL,
  `cust_po_number` varchar(96) DEFAULT '',
  `bill_to_email` varchar(128) NOT NULL DEFAULT '',
  `amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `currency` varchar(3) NOT NULL DEFAULT '',
  `reject_notes` varchar(255) NOT NULL DEFAULT '',
  `reject_date_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `vat_number` varchar(128) NOT NULL DEFAULT '',
  `billing_contact_name` varchar(128) NOT NULL DEFAULT '',
  `billing_org_name` varchar(128) NOT NULL DEFAULT '',
  `billing_org_addr1` varchar(128) NOT NULL DEFAULT '',
  `billing_org_addr2` varchar(128) NOT NULL DEFAULT '',
  `billing_org_city` varchar(64) NOT NULL DEFAULT '',
  `billing_org_state` varchar(64) NOT NULL DEFAULT '',
  `billing_org_zip` varchar(10) NOT NULL DEFAULT '',
  `billing_org_country` varchar(2) NOT NULL DEFAULT '0',
  `billing_telephone` varchar(32) NOT NULL DEFAULT '',
  `hard_copy_path` varchar(255) DEFAULT '',
  `hard_copy_date` datetime DEFAULT NULL,
  `customer_notes` varchar(512) DEFAULT NULL,
  `additional_emails` varchar(512) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `account_id` (`account_id`),
  KEY `container_id` (`container_id`),
  KEY `date_created` (`date_created`),
  KEY `approval_status` (`approval_status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `custom_fields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `acct_id` int(6) unsigned DEFAULT NULL,
  `identifier` int(11) NOT NULL,
  `reference` enum('company','user_contact','address_request','device_request','org_request','fbca_address_request') NOT NULL,
  `name` varchar(50) NOT NULL,
  `description` varchar(500) DEFAULT NULL,
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  PRIMARY KEY (`id`),
  UNIQUE KEY `acct_id` (`acct_id`,`identifier`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `custom_renewal_notices` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `body` text DEFAULT NULL,
  `notice_level` enum('account','order','unit') DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1524 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `custom_renewal_notice_accounts` (
  `id` int(10) unsigned NOT NULL,
  `custom_renewal_notice_id` mediumint(8) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `custom_renewal_notice_ent_requests` (
  `id` int(10) unsigned NOT NULL,
  `custom_renewal_notice_id` mediumint(8) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `custom_renewal_notice_ent_units` (
  `id` int(10) unsigned NOT NULL,
  `custom_renewal_notice_id` mediumint(8) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `custom_renewal_notice_orders` (
  `id` int(10) unsigned NOT NULL,
  `custom_renewal_notice_id` mediumint(8) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `custom_values` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `custom_field_id` int(11) NOT NULL,
  `reference_id` int(11) NOT NULL,
  `value` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `reference_id` (`reference_id`,`custom_field_id`),
  KEY `value` (`value`)
) ENGINE=InnoDB AUTO_INCREMENT=94126 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `cust_audit_log` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `parent_log_id` int(11) unsigned DEFAULT NULL,
  `date_time` datetime NOT NULL,
  `acct_id` int(6) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `ip_address` int(10) unsigned NOT NULL,
  `ip_country` char(2) DEFAULT NULL,
  `action_status` enum('failed','successful') DEFAULT NULL,
  `action` varchar(50) NOT NULL,
  `target_type` varchar(50) NOT NULL DEFAULT '',
  `target_id` int(11) unsigned NOT NULL,
  `message` varchar(1500) DEFAULT NULL,
  `staff_id` smallint(5) unsigned DEFAULT NULL,
  `origin` enum('ui','api') NOT NULL DEFAULT 'ui',
  `container_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `parent_log_id` (`parent_log_id`),
  KEY `acct_id` (`acct_id`),
  KEY `date_time` (`date_time`),
  KEY `ip_address` (`ip_address`),
  KEY `container_id` (`container_id`),
  KEY `cust_audit_log_user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=192761791 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `cust_audit_log_notifications` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `acct_id` int(11) unsigned NOT NULL DEFAULT 0,
  `container_id` int(10) unsigned DEFAULT NULL,
  `user_id` int(11) unsigned NOT NULL DEFAULT 0,
  `email_address` varchar(255) DEFAULT NULL,
  `cat_cert_issuance` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `cat_user_changes` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `cat_logins` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `cat_bad_ip_logins` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `cat_cert_revoke` tinyint(1) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `ix_acct_id` (`acct_id`),
  KEY `ix_container_id` (`container_id`),
  KEY `ix_user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3316 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `data_deleted` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `table` varchar(64) DEFAULT NULL,
  `record_id` int(10) unsigned DEFAULT NULL,
  `description` varchar(128) DEFAULT NULL,
  `date_time` datetime DEFAULT NULL,
  `data` mediumtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `record_id` (`record_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2487359 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `dcj_accounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date_created` datetime DEFAULT current_timestamp(),
  `account_id` int(11) NOT NULL,
  `portal` enum('storefront','geostorefront','geocenter') NOT NULL,
  `portal_tech_email` varchar(256) CHARACTER SET ascii NOT NULL,
  `user_id` int(11) NOT NULL,
  `is_master` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_portal_portal_tech_email` (`portal`,`portal_tech_email`),
  KEY `idx_account_id` (`account_id`),
  KEY `idx_is_master` (`is_master`)
) ENGINE=InnoDB AUTO_INCREMENT=28743 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `dcj_certificates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date_created` datetime DEFAULT current_timestamp(),
  `portal` enum('storefront','geostorefront','geocenter') NOT NULL,
  `portal_tech_email` varchar(256) CHARACTER SET ascii NOT NULL,
  `serial_number` varchar(128) CHARACTER SET ascii NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  `error_description` varchar(1024) DEFAULT NULL,
  `last_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `serial_number` (`serial_number`),
  KEY `idx_portal_portal_tech_email` (`portal`,`portal_tech_email`),
  KEY `idx_status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=94198 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `dcj_coupon_list` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `coupon_number` varchar(16) NOT NULL,
  `product_name` varchar(256) DEFAULT NULL,
  `coupon_price` varchar(45) DEFAULT NULL,
  `coupon_consumed_person_id` varchar(45) DEFAULT NULL,
  `coupon_consumed_date` datetime DEFAULT NULL,
  `coupon_status` varchar(45) DEFAULT NULL,
  `common_name` varchar(256) DEFAULT NULL,
  `cert_enrollment_date` datetime DEFAULT NULL,
  `cert_valid_period` varchar(45) DEFAULT NULL,
  `cert_enrollment_company_name` varchar(256) DEFAULT NULL,
  `cert_enrollment_company_address` varchar(256) DEFAULT NULL,
  `cert_enrollment_company_postcode` varchar(45) DEFAULT NULL,
  `cert_enrollment_company_phone_number` varchar(256) DEFAULT NULL,
  `cert_enrollment_company_department_name` varchar(256) DEFAULT NULL,
  `cert_enrollment_company_contact_person_email_address` varchar(256) DEFAULT NULL,
  `cert_enrollment_company_contact_person_name` varchar(256) DEFAULT NULL,
  `tech_company_name` varchar(256) DEFAULT NULL,
  `tech_company_department_name` varchar(256) DEFAULT NULL,
  `tech_company_tech_contact_email` varchar(256) DEFAULT NULL,
  `tech_company_tech_person_name` varchar(256) DEFAULT NULL,
  `admin_company_name` varchar(256) DEFAULT NULL,
  `admin_company_department_name` varchar(256) DEFAULT NULL,
  `admin_company_admin_email` varchar(256) DEFAULT NULL,
  `admin_company_admin_name` varchar(256) DEFAULT NULL,
  `coupon_management_number` varchar(256) DEFAULT NULL,
  `coupon_type` varchar(45) DEFAULT NULL,
  `coupon_given_partner_id` int(10) unsigned DEFAULT NULL,
  `coupon_start_date` datetime DEFAULT NULL,
  `coupon_date_valid_till` datetime DEFAULT NULL,
  `coupon_giver_id` int(10) unsigned DEFAULT NULL,
  `coupon_given_date` datetime DEFAULT NULL,
  `coupon_approver_id` int(10) unsigned DEFAULT NULL,
  `coupon_approval_date` datetime DEFAULT NULL,
  `partner_id` int(10) unsigned DEFAULT NULL,
  `partner_name` varchar(256) DEFAULT NULL,
  `partner_address` varchar(256) DEFAULT NULL,
  `partner_post_code` varchar(45) DEFAULT NULL,
  `partner_telephone_number` varchar(45) DEFAULT NULL,
  `partner_fax_number` varchar(45) DEFAULT NULL,
  `partner_email` varchar(256) DEFAULT NULL,
  `giver_id` int(10) unsigned DEFAULT NULL,
  `giver_permission` varchar(45) DEFAULT NULL,
  `giver_name` varchar(256) DEFAULT NULL,
  `giver_email` varchar(256) DEFAULT NULL,
  `approver_id` int(10) unsigned DEFAULT NULL,
  `approver_permission` varchar(256) DEFAULT NULL,
  `approver_name` varchar(256) DEFAULT NULL,
  `approver_email` varchar(256) DEFAULT NULL,
  `crm_product_id` int(10) unsigned DEFAULT NULL,
  `sf_product_id` int(10) unsigned DEFAULT NULL,
  `shop_id` int(10) unsigned DEFAULT NULL,
  `product_price` varchar(256) DEFAULT NULL,
  `product_displayed_name` varchar(256) DEFAULT NULL,
  `product_campaign_flag` int(1) unsigned DEFAULT NULL,
  `product_note` varchar(256) DEFAULT NULL,
  `product_enrollment_required_flag` int(1) unsigned DEFAULT NULL,
  `product_multiple_purchase_flag` int(1) unsigned DEFAULT NULL,
  `product_price_type` varchar(256) DEFAULT NULL,
  `product_registered_date` datetime DEFAULT NULL,
  `product_registerant_id` int(10) unsigned DEFAULT NULL,
  `product_updated_date` datetime DEFAULT NULL,
  `product_updater_id` int(10) unsigned DEFAULT NULL,
  `account_id` int(10) unsigned DEFAULT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  `voucher_code_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `coupon_number` (`coupon_number`),
  KEY `idx_voucher_code_id` (`voucher_code_id`)
) ENGINE=InnoDB AUTO_INCREMENT=22386 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `dcj_order_migration_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date_created` datetime DEFAULT current_timestamp(),
  `account_id` int(11) NOT NULL,
  `start_time` datetime DEFAULT NULL,
  `completed_time` datetime DEFAULT NULL,
  `user_id` int(11) DEFAULT 0,
  `staff_id` int(11) DEFAULT 0,
  `last_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_account_id` (`account_id`),
  KEY `idx_date_created` (`date_created`),
  KEY `idx_completed` (`completed_time`)
) ENGINE=InnoDB AUTO_INCREMENT=30364 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `dcv_audit_data` (
  `order_id` int(10) unsigned NOT NULL,
  `duplicate_id` int(10) unsigned DEFAULT NULL,
  `reissue_id` int(10) unsigned DEFAULT NULL,
  `date_issued` datetime NOT NULL,
  `date_expires` datetime NOT NULL,
  `serial_number` char(42) DEFAULT NULL,
  `product_id` smallint(5) unsigned NOT NULL,
  `product_name` char(50) NOT NULL,
  `root_path` enum('digicert','entrust','cybertrust','comodo') NOT NULL,
  `ca_cert_id` int(10) unsigned NOT NULL,
  `is_missing_dcvs` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `remediation_dcv_date` datetime DEFAULT NULL,
  `remediation_days` smallint(6) DEFAULT NULL,
  `pem` mediumtext DEFAULT NULL,
  `chain` varchar(32) DEFAULT NULL,
  UNIQUE KEY `duplicate_id` (`duplicate_id`),
  UNIQUE KEY `reissue_id` (`reissue_id`),
  UNIQUE KEY `order_id_duplicate_id` (`order_id`,`duplicate_id`),
  UNIQUE KEY `order_id_reissue_id` (`order_id`,`reissue_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `dcv_cache` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `domain_id` int(10) unsigned NOT NULL,
  `date_created` datetime NOT NULL,
  `order_id` int(10) unsigned NOT NULL DEFAULT 0,
  `domain_name` varchar(255) NOT NULL,
  `include_subdomains` tinyint(4) NOT NULL DEFAULT 1,
  `dcv_method` varchar(255) NOT NULL,
  `approver_name` varchar(255) NOT NULL DEFAULT '',
  `approver_email` varchar(255) NOT NULL DEFAULT '',
  `validation_date` datetime DEFAULT NULL,
  `staff_id` int(10) unsigned NOT NULL DEFAULT 0,
  `staff_note` text DEFAULT NULL,
  `document_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_clone` tinyint(4) NOT NULL DEFAULT 0,
  `cert_tracker_id` int(10) unsigned DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `domain_id` (`domain_id`,`domain_name`,`include_subdomains`,`cert_tracker_id`),
  KEY `idx_date_create` (`date_created`),
  KEY `idx_domain_id` (`domain_id`),
  KEY `idx_order_id` (`order_id`),
  KEY `idx_domain_name` (`include_subdomains`,`domain_name`),
  KEY `idx_validation_date` (`validation_date`)
) ENGINE=InnoDB AUTO_INCREMENT=22343983 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `dcv_cache_old` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `domain_id` int(10) unsigned NOT NULL,
  `date_created` datetime NOT NULL,
  `order_id` int(10) unsigned NOT NULL DEFAULT 0,
  `domain_name` varchar(255) NOT NULL,
  `include_subdomains` tinyint(4) NOT NULL DEFAULT 1,
  `dcv_method` varchar(255) NOT NULL,
  `approver_name` varchar(255) NOT NULL DEFAULT '',
  `approver_email` varchar(255) NOT NULL DEFAULT '',
  `validation_date` datetime DEFAULT NULL,
  `staff_id` int(10) unsigned NOT NULL DEFAULT 0,
  `staff_note` text DEFAULT NULL,
  `document_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_clone` tinyint(4) NOT NULL DEFAULT 0,
  `cert_tracker_id` int(10) unsigned DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `idx_date_create` (`date_created`),
  KEY `idx_domain_id` (`domain_id`),
  KEY `idx_order_id` (`order_id`),
  KEY `idx_domain_name` (`include_subdomains`,`domain_name`),
  KEY `idx_validation_date` (`validation_date`)
) ENGINE=InnoDB AUTO_INCREMENT=21800273 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `dcv_email_blocklist` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(50) NOT NULL,
  `notes` varchar(200) DEFAULT NULL,
  `created_by_staff_id` int(11) NOT NULL DEFAULT 0,
  `date_added` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=117 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `dcv_email_sent` (
  `dcv_history_id` int(10) unsigned NOT NULL,
  `email_address` varchar(255) NOT NULL,
  PRIMARY KEY (`dcv_history_id`,`email_address`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `dcv_expire_cache` (
  `cert_approval_id` int(11) DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  `reason` varchar(255) DEFAULT NULL,
  `result` varchar(50) DEFAULT NULL,
  UNIQUE KEY `cert_approval_id_idx` (`cert_approval_id`),
  KEY `result_idx` (`result`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `dcv_invitations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(128) NOT NULL,
  `token` varchar(32) NOT NULL,
  `order_id` int(8) unsigned zerofill NOT NULL,
  `reissue_id` int(8) unsigned DEFAULT 0,
  `domain_id` int(11) NOT NULL,
  `name_scope` varchar(255) DEFAULT NULL,
  `date_time` datetime DEFAULT NULL,
  `status` enum('active','deleted') NOT NULL DEFAULT 'active',
  `source` varchar(20) DEFAULT NULL,
  `email_name_scope` varchar(255) DEFAULT NULL,
  `container_domain_id` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `email` (`email`(8)),
  KEY `token` (`token`(8)),
  KEY `order_id` (`order_id`),
  KEY `domain_id` (`domain_id`),
  KEY `dcv_invitations_reissue_id` (`reissue_id`),
  KEY `container_domain_id_idx` (`container_domain_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10629088 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `dcv_queue` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(8) unsigned zerofill NOT NULL,
  `domain_id` int(11) unsigned NOT NULL,
  `sent` tinyint(1) NOT NULL DEFAULT 0,
  `staff` int(10) unsigned NOT NULL DEFAULT 0,
  `date_sent` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `dcv_reverify` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `domain_id` int(11) NOT NULL,
  `dibs_staff_id` int(11) DEFAULT NULL,
  `dibs_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8169 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `dcv_reverify_results` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `domain_id` int(11) NOT NULL,
  `result` varchar(100) DEFAULT NULL,
  `staff_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12052 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `dcv_sort_cache` (
  `domain_id` int(11) DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  `reason` varchar(255) DEFAULT NULL,
  `category` varchar(50) DEFAULT NULL,
  `resolution` varchar(50) DEFAULT NULL,
  `meta_data` text DEFAULT NULL,
  UNIQUE KEY `domain_id_idx` (`domain_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `dcv_tokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `domain_id` int(11) NOT NULL,
  `method` enum('cname') NOT NULL DEFAULT 'cname',
  `token` varchar(64) NOT NULL,
  `verification_value` varchar(253) NOT NULL,
  `order_id` int(8) unsigned zerofill NOT NULL,
  `reissue_id` int(8) unsigned DEFAULT 0,
  `date_time` datetime DEFAULT NULL,
  `status` enum('active','deleted') NOT NULL DEFAULT 'active',
  `container_domain_id` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `domain_id` (`domain_id`),
  KEY `method` (`method`),
  KEY `token` (`token`(8)),
  KEY `order_id` (`order_id`),
  KEY `dcv_tokens_reissue_id` (`reissue_id`),
  KEY `idx_container_domain_id` (`container_domain_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1568 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `deleted_subdomains` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` int(10) unsigned NOT NULL,
  `container_id` int(10) unsigned NOT NULL,
  `reversion_sql` mediumtext NOT NULL,
  `cleanup_event_time` datetime NOT NULL,
  `date_created` datetime NOT NULL,
  `date_reverted` datetime DEFAULT NULL,
  `created_by_staff_id` int(10) unsigned NOT NULL,
  `reverted_by_staff_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=714 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `deposit_audit` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `action_id` int(10) unsigned DEFAULT NULL,
  `field_name` varchar(50) DEFAULT NULL,
  `old_value` varchar(255) DEFAULT NULL,
  `new_value` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=72797 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `deposit_audit_action` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `deposit_id` int(10) unsigned DEFAULT NULL,
  `staff_id` smallint(5) unsigned NOT NULL DEFAULT 0,
  `date_dt` datetime DEFAULT NULL,
  `action_type` varchar(255) DEFAULT NULL,
  `affected_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36466 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `digicert_reviews` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `review` text DEFAULT NULL,
  `nickname` varchar(20) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `status` enum('pending','approved','rejected') DEFAULT 'pending',
  `ip_address` int(10) unsigned DEFAULT NULL,
  `date_time` datetime DEFAULT NULL,
  `stars_overall` tinyint(3) unsigned DEFAULT NULL,
  `stars_features` tinyint(3) unsigned DEFAULT NULL,
  `stars_support` tinyint(3) unsigned DEFAULT NULL,
  `stars_experience` tinyint(3) unsigned DEFAULT NULL,
  `stars_issuance_speed` tinyint(3) unsigned DEFAULT NULL,
  `recommend` tinyint(3) unsigned DEFAULT NULL,
  `helpful` smallint(5) unsigned DEFAULT 0,
  `unhelpful` smallint(5) unsigned DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18027 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `digiloot` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `digiloot_details` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `loot_id` smallint(5) unsigned DEFAULT NULL,
  `size` varchar(10) DEFAULT NULL,
  `color` varchar(20) DEFAULT NULL,
  `stock` smallint(5) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `digiloot_orders` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned DEFAULT NULL,
  `acct_id` int(10) unsigned DEFAULT NULL,
  `loot_id` smallint(5) unsigned DEFAULT NULL,
  `loot_details_id` smallint(5) unsigned DEFAULT NULL,
  `date_time` datetime DEFAULT NULL,
  `status` varchar(20) DEFAULT 'pending',
  `note_to_customer` text DEFAULT NULL,
  `reason` text DEFAULT NULL,
  `staff_id` int(10) unsigned DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `address1` varchar(255) DEFAULT NULL,
  `address2` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `state` varchar(25) DEFAULT NULL,
  `postal_code` varchar(15) DEFAULT NULL,
  `country` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_acct_id` (`acct_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1249 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `direct_accredited` (
  `direct_trust_identifier` varchar(45) NOT NULL,
  `status` tinyint(2) DEFAULT NULL,
  `status_changed` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`direct_trust_identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `disable_ou_script_accounts_affected` (
  `account_id` int(10) unsigned NOT NULL,
  `phase` int(11) NOT NULL,
  `description` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `discount_rates` (
  `id` int(5) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL DEFAULT '',
  `universal` tinyint(1) NOT NULL DEFAULT 0,
  `rates` text NOT NULL,
  `discount_duration_days` int(11) DEFAULT NULL,
  `percent_discount` tinyint(4) NOT NULL DEFAULT 0,
  `percent_discount_products` varchar(50) NOT NULL DEFAULT '0',
  `percent_discount_lifetime` varchar(20) NOT NULL DEFAULT '0',
  `description` text NOT NULL,
  `created_by_staff_id` int(11) NOT NULL,
  `currency` char(3) CHARACTER SET ascii NOT NULL DEFAULT 'USD',
  `manage_code` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_manage_code` (`manage_code`)
) ENGINE=InnoDB AUTO_INCREMENT=15893 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `discount_types` (
  `id` tinyint(3) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `discovery_api_keys` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `discovery_api_key` varchar(32) DEFAULT NULL,
  `acct_id` int(6) NOT NULL DEFAULT 0,
  `max_ip_count` int(11) NOT NULL DEFAULT 1024,
  `customer_name` varchar(150) DEFAULT NULL,
  `customer_organization` varchar(150) DEFAULT NULL,
  `customer_email` varchar(100) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `send_emails` tinyint(4) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `discovery_api_key` (`discovery_api_key`),
  KEY `acct_id` (`acct_id`)
) ENGINE=InnoDB AUTO_INCREMENT=54953 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `discovery_certs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `discovery_api_key_id` int(11) NOT NULL,
  `order_id` int(8) unsigned zerofill NOT NULL DEFAULT 00000000,
  `product_id` int(11) DEFAULT NULL,
  `sha1_thumbprint` varchar(40) DEFAULT NULL,
  `valid_from` date NOT NULL DEFAULT '0000-00-00',
  `valid_till` date NOT NULL DEFAULT '0000-00-00',
  `keysize` int(11) DEFAULT NULL,
  `issuer` varchar(255) DEFAULT NULL,
  `common_name` varchar(255) DEFAULT NULL,
  `sans` text DEFAULT NULL,
  `org_name` varchar(255) DEFAULT NULL,
  `org_city` varchar(255) DEFAULT NULL,
  `org_state` varchar(128) DEFAULT NULL,
  `org_country` varchar(128) DEFAULT NULL,
  `send_minus_30` tinyint(1) NOT NULL DEFAULT 0,
  `send_minus_7` tinyint(1) NOT NULL DEFAULT 0,
  `sent_minus_30` tinyint(1) NOT NULL DEFAULT 0,
  `sent_minus_7` tinyint(1) NOT NULL DEFAULT 0,
  `certificate` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `discovery_api_key_id` (`discovery_api_key_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1094553 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `discovery_cert_usage` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `discovery_scan_id` int(11) DEFAULT NULL,
  `discovery_cert_id` int(11) DEFAULT NULL,
  `servers` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `discovery_scan_id` (`discovery_scan_id`),
  KEY `discovery_cert_id` (`discovery_cert_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2392351 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `discovery_scans` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `discovery_api_key_id` int(11) NOT NULL,
  `scan_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `scan_type` enum('manual','scheduled','') NOT NULL DEFAULT '',
  `scan_duration` int(11) DEFAULT NULL,
  `scan_data` longtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `discovery_api_key_id` (`discovery_api_key_id`)
) ENGINE=InnoDB AUTO_INCREMENT=113794 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `docs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `company_id` int(11) DEFAULT NULL,
  `domain_id` int(11) DEFAULT NULL,
  `contact_id` int(11) DEFAULT NULL,
  `order_id` int(11) DEFAULT NULL,
  `file_path` varchar(255) DEFAULT NULL,
  `upload_time` datetime DEFAULT NULL,
  `status` tinyint(1) DEFAULT 1,
  `staff_id` int(11) DEFAULT NULL,
  `page_current` int(11) DEFAULT NULL,
  `page_count` int(11) DEFAULT NULL,
  `doc_type_id` int(11) NOT NULL,
  `expires_time` datetime DEFAULT NULL,
  `is_perpetual` tinyint(1) NOT NULL DEFAULT 0,
  `display_name` varchar(255) DEFAULT NULL,
  `original_name` varchar(255) DEFAULT NULL,
  `file_modified_time` datetime DEFAULT NULL,
  `user_uploaded` tinyint(1) DEFAULT 0,
  `user_id` int(11) DEFAULT NULL,
  `key_index` tinyint(4) NOT NULL DEFAULT 0,
  `execution_date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_company_assertions_companies` (`company_id`),
  KEY `fk_company_assertions_domains` (`domain_id`),
  KEY `fk_assertion_docs_staff_id` (`staff_id`),
  KEY `contact_id` (`contact_id`),
  KEY `order_id` (`order_id`),
  KEY `docs_upload_time` (`upload_time`)
) ENGINE=InnoDB AUTO_INCREMENT=35595122 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `docs_unassigned` (
  `doc_id` int(11) NOT NULL DEFAULT 0,
  `staff_id` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`doc_id`),
  KEY `staff_id` (`staff_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `doc_emails` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `doc_id` int(10) unsigned NOT NULL,
  `email_address` varchar(255) DEFAULT NULL,
  `staff_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_doc_id` (`doc_id`)
) ENGINE=InnoDB AUTO_INCREMENT=339608 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `doc_history` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `doc_id` int(11) DEFAULT NULL,
  `staff_id` int(11) DEFAULT NULL,
  `action` enum('EXPIRE','NOTE','APPROVE','REJECT','CHANGE','UPLOAD') DEFAULT NULL,
  `datetime` datetime DEFAULT NULL,
  `note` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_company_assertions_docs` (`doc_id`),
  KEY `fk_company_assertions_staff` (`staff_id`)
) ENGINE=InnoDB AUTO_INCREMENT=41879159 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `doc_phone_number` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `doc_id` int(10) unsigned NOT NULL,
  `phone_number` varchar(64) DEFAULT NULL,
  `staff_id` int(10) unsigned NOT NULL,
  `phone_ext` varchar(48) DEFAULT NULL,
  `twilio_call_sid` varchar(48) DEFAULT NULL,
  `call_status_code` varchar(100) DEFAULT NULL,
  `call_status_message` varchar(100) DEFAULT NULL,
  `authenticity_pin` varchar(32) DEFAULT NULL,
  `last_update_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_doc_id` (`doc_id`)
) ENGINE=InnoDB AUTO_INCREMENT=109329 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `doc_statuses` (
  `id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `doc_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `description` text DEFAULT NULL,
  `short_name` varchar(50) DEFAULT NULL,
  `valid_time` varchar(25) DEFAULT NULL,
  `is_perpetual` tinyint(1) NOT NULL DEFAULT 0,
  `sort_order` int(10) unsigned DEFAULT 0,
  `auto_assign` enum('DOMAIN','COMPANY','CONTACT') DEFAULT NULL,
  `use_execution_date` tinyint(1) NOT NULL DEFAULT 0,
  `is_active` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `domains` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `scope` varchar(255) DEFAULT NULL,
  `company_id` int(11) NOT NULL DEFAULT 0,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `date_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `standalone` tinyint(1) NOT NULL DEFAULT 0,
  `approved_by` int(11) NOT NULL DEFAULT 0,
  `reject_notes` varchar(255) NOT NULL DEFAULT '',
  `reject_date_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `reject_staff` int(10) unsigned NOT NULL DEFAULT 0,
  `is_public` tinyint(4) NOT NULL DEFAULT 1,
  `internal_staff_id` int(10) unsigned DEFAULT NULL,
  `internal_date_time` datetime DEFAULT NULL,
  `flag` tinyint(4) NOT NULL DEFAULT 0,
  `snooze_until` datetime DEFAULT NULL,
  `alexa_rank` int(12) unsigned DEFAULT NULL,
  `namespace_protected` tinyint(4) NOT NULL DEFAULT 0,
  `pending_validation_checklist_ids` varchar(50) NOT NULL DEFAULT '',
  `validation_submit_date` datetime DEFAULT NULL,
  `checklist_modifiers` varchar(30) NOT NULL DEFAULT '',
  `dns_caa` enum('unknown','not_found','found') NOT NULL DEFAULT 'unknown',
  `dns_caa_date` date NOT NULL DEFAULT '1900-01-01',
  `allow_cname_dcv` tinyint(4) NOT NULL DEFAULT 0,
  `risk_score` smallint(5) unsigned NOT NULL DEFAULT 0,
  `dcv_method` varchar(20) DEFAULT NULL,
  `dcv_name_scope` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `company_id` (`company_id`),
  KEY `status` (`status`),
  KEY `is_public` (`is_public`),
  KEY `snooze_until` (`snooze_until`),
  KEY `pending_validation_checklist_ids` (`pending_validation_checklist_ids`),
  KEY `validation_submit_date` (`validation_submit_date`),
  KEY `date_time` (`date_time`)
) ENGINE=InnoDB AUTO_INCREMENT=2582868 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `domain_blacklists` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `domain_ra_map` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `domain_name` varchar(255) NOT NULL,
  `domain_id` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_domain_id_name` (`domain_id`,`domain_name`),
  KEY `idx_domain_name` (`domain_name`),
  KEY `idx_domain_id` (`domain_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2875202 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `domain_statuses` (
  `id` tinyint(4) NOT NULL AUTO_INCREMENT,
  `name` mediumtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `early_expired_snapshots` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `enterprise_snapshot_id` int(11) DEFAULT NULL,
  `acct_id` int(11) DEFAULT NULL,
  `container_id` int(11) DEFAULT NULL,
  `company_id` int(11) DEFAULT NULL,
  `domain_id` int(11) DEFAULT NULL,
  `snapshot_active_orders` int(11) DEFAULT NULL,
  `vip` int(11) DEFAULT NULL,
  `is_cis` int(11) DEFAULT NULL,
  `days_since_last_order_snapshot` int(11) DEFAULT NULL,
  `days_till_next_expiration_snapshot` int(11) DEFAULT NULL,
  `days_till_dcv_expires` int(11) DEFAULT NULL,
  `account_active_orders` int(11) DEFAULT NULL,
  `days_since_api_used` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `enterprise_snapshot_id` (`enterprise_snapshot_id`),
  KEY `acct_id` (`acct_id`),
  KEY `company_id` (`company_id`),
  KEY `domain_id` (`domain_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14652 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `email_machine_templates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL DEFAULT '',
  `template` text NOT NULL,
  `note_template` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `email_subscription_status` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `email_address` varchar(255) NOT NULL,
  `subscribed` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `last_updated_by_user_id` int(10) unsigned NOT NULL DEFAULT 0,
  `last_updated` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `date_created` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_email_address` (`email_address`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `email_template` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date_created` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `account_id` int(11) NOT NULL DEFAULT 0,
  `container_id` int(11) DEFAULT NULL,
  `language_code` varchar(10) NOT NULL DEFAULT 'en',
  `template_name` varchar(50) NOT NULL,
  `template_content` text DEFAULT NULL,
  `active` tinyint(4) NOT NULL DEFAULT 1,
  `descriptor` varchar(50) DEFAULT NULL,
  `whitelabel_image_url` varchar(255) DEFAULT NULL,
  `from_email` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_index` (`account_id`,`language_code`,`template_name`,`active`),
  KEY `account_id` (`account_id`),
  KEY `template_name` (`template_name`(16))
) ENGINE=InnoDB AUTO_INCREMENT=1381 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `email_tokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `token` varchar(128) NOT NULL DEFAULT '',
  `create_date` datetime DEFAULT NULL,
  `expiry_date` datetime DEFAULT NULL,
  `order_id` int(10) unsigned NOT NULL DEFAULT 0,
  `reissue_id` int(10) unsigned NOT NULL DEFAULT 0,
  `ent_client_cert_id` int(10) unsigned NOT NULL DEFAULT 0,
  `company_id` int(10) NOT NULL DEFAULT 0,
  `purpose` varchar(40) NOT NULL DEFAULT 'other',
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `reissue_id` (`reissue_id`),
  KEY `ent_client_cert_id` (`ent_client_cert_id`),
  KEY `idx_token` (`token`(6))
) ENGINE=InnoDB AUTO_INCREMENT=685071 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `email_token_common_name_map` (
  `token_id` int(10) unsigned DEFAULT NULL,
  `common_name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `enterprise_snapshots` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `company_id` int(10) unsigned NOT NULL DEFAULT 0,
  `domain_id` int(10) unsigned NOT NULL DEFAULT 0,
  `checklist_id` int(10) unsigned NOT NULL DEFAULT 0,
  `snapshot_info` text DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `validated_until` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `company_id` (`company_id`),
  KEY `domain_id` (`domain_id`)
) ENGINE=InnoDB AUTO_INCREMENT=20086813 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `ent_account_active_dates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `acct_id` int(6) unsigned zerofill NOT NULL,
  `signup_date` datetime NOT NULL,
  `deactivation_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `acct_id` (`acct_id`,`signup_date`)
) ENGINE=InnoDB AUTO_INCREMENT=23924 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `ent_account_info` (
  `acct_id` int(6) unsigned zerofill NOT NULL,
  `account_title` varchar(128) DEFAULT NULL,
  `ekey` varchar(32) NOT NULL,
  `signup_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `alt_url` varchar(255) NOT NULL,
  `branding_logo` varchar(128) DEFAULT NULL,
  `admin_email` varchar(255) DEFAULT NULL,
  `admin_email_settings` text DEFAULT NULL,
  `request_page_note` text DEFAULT NULL,
  `balance_reminder_threshold` int(11) DEFAULT 1000,
  `balance_negative_limit` int(11) DEFAULT 0,
  `role_permissions` varchar(10000) NOT NULL DEFAULT '',
  `allow_prod_change` tinyint(1) NOT NULL DEFAULT 1,
  `allow_single_limited` tinyint(1) NOT NULL DEFAULT 1,
  `allow_wildcard_limited` tinyint(1) NOT NULL DEFAULT 0,
  `allow_uc_limited` tinyint(1) NOT NULL DEFAULT 1,
  `allow_ev_limited` tinyint(1) NOT NULL DEFAULT 1,
  `allow_single_admin` tinyint(4) NOT NULL DEFAULT 1,
  `allow_wildcard_admin` tinyint(4) NOT NULL DEFAULT 0,
  `allow_uc_admin` tinyint(4) NOT NULL DEFAULT 1,
  `allow_ev_admin` tinyint(4) NOT NULL DEFAULT 1,
  `allow_single_helpdesk` tinyint(4) NOT NULL DEFAULT 1,
  `allow_wildcard_helpdesk` tinyint(4) NOT NULL DEFAULT 0,
  `allow_uc_helpdesk` tinyint(4) NOT NULL DEFAULT 1,
  `allow_ev_helpdesk` tinyint(4) NOT NULL DEFAULT 1,
  `allow_one_year_limited` tinyint(4) NOT NULL DEFAULT 1,
  `allow_two_year_limited` tinyint(4) NOT NULL DEFAULT 1,
  `allow_three_year_limited` tinyint(4) NOT NULL DEFAULT 1,
  `allow_login_requests` tinyint(4) NOT NULL DEFAULT 1,
  `allow_custom_expiration` tinyint(4) NOT NULL DEFAULT 1,
  `allow_unvalidated_approvals` tinyint(4) NOT NULL DEFAULT 0,
  `allow_client_certs` tinyint(4) NOT NULL DEFAULT 0,
  `allow_guest_requests` tinyint(64) NOT NULL DEFAULT 0,
  `client_cert_settings` set('allow','allow_client_only','allow_escrow','allow_client_private','allow_client_custom_public') NOT NULL,
  `client_cert_subroot_id` smallint(5) unsigned NOT NULL DEFAULT 34,
  `client_cert_support_phone` varchar(255) DEFAULT NULL,
  `client_cert_support_email` varchar(255) DEFAULT NULL,
  `client_cert_support_text` varchar(2500) DEFAULT NULL,
  `client_cert_api_return_url` varchar(255) DEFAULT NULL,
  `default_signature_hash` enum('sha1','sha256','sha384','sha512') NOT NULL DEFAULT 'sha1',
  `guest_request_token` varchar(50) DEFAULT NULL,
  `guest_request_ips` text DEFAULT NULL,
  `guest_request_ips_unrestricted` tinyint(1) DEFAULT 0,
  `separate_unit_funds` tinyint(4) NOT NULL DEFAULT 0,
  `ev_api_agreement_id` int(11) DEFAULT NULL,
  `allow_private_ssl` tinyint(4) NOT NULL DEFAULT 0,
  `gtld_account_enabled` tinyint(4) NOT NULL DEFAULT 0,
  `allow_wifi_in_gui` tinyint(4) NOT NULL DEFAULT 0,
  `whois_account_enabled` tinyint(4) NOT NULL DEFAULT 0,
  `default_validity` tinyint(3) unsigned DEFAULT 3,
  PRIMARY KEY (`acct_id`),
  KEY `idx_ekey` (`ekey`(6))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `ent_approval_rules` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `acct_id` int(6) unsigned zerofill NOT NULL,
  `name` varchar(255) NOT NULL,
  `sort_order` int(11) NOT NULL,
  `status` enum('active','inactive','deleted') NOT NULL,
  `created_by_id` int(11) NOT NULL,
  `cron` int(1) NOT NULL DEFAULT 0,
  `data` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2402 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `ent_client_certs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `product_id` int(10) unsigned DEFAULT NULL,
  `domain_id` int(10) unsigned NOT NULL DEFAULT 0,
  `company_id` int(10) unsigned NOT NULL DEFAULT 0,
  `common_name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `org_unit` varchar(255) DEFAULT NULL,
  `cert_profile_id` int(11) NOT NULL DEFAULT 1,
  `status` tinyint(3) unsigned NOT NULL DEFAULT 1,
  `reason` tinyint(3) unsigned NOT NULL DEFAULT 1,
  `date_requested` datetime DEFAULT NULL,
  `date_issued` datetime DEFAULT NULL,
  `lifetime` tinyint(3) unsigned DEFAULT NULL,
  `valid_from` date DEFAULT NULL,
  `valid_till` date DEFAULT NULL,
  `serial_number` varchar(128) DEFAULT NULL,
  `origin` enum('ui','api') DEFAULT 'ui',
  `renewals_left` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `renewal_record_exists` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `renewal_of_cert_id` int(10) unsigned NOT NULL DEFAULT 0,
  `approved_by` int(10) unsigned NOT NULL DEFAULT 0,
  `stat_row_id` int(10) unsigned NOT NULL DEFAULT 0,
  `ca_cert_id` smallint(6) unsigned NOT NULL DEFAULT 0,
  `receipt_id` int(10) unsigned NOT NULL DEFAULT 0,
  `email_token` varchar(32) DEFAULT NULL,
  `date_emailed` datetime DEFAULT NULL,
  `ca_order_id` int(10) unsigned NOT NULL DEFAULT 0,
  `csr` text DEFAULT NULL,
  `signature_hash` enum('sha1','sha256','sha384','sha512') NOT NULL DEFAULT 'sha1',
  `reissued_cert_id` int(10) unsigned NOT NULL DEFAULT 0,
  `reissue_email_sent` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `agreement_id` int(10) unsigned NOT NULL DEFAULT 0,
  `inpriva_email_validated` tinyint(4) NOT NULL DEFAULT 0,
  `is_out_of_contract` tinyint(1) NOT NULL DEFAULT 0,
  `user_id` int(10) unsigned DEFAULT NULL,
  `order_tracker_id` int(10) unsigned DEFAULT NULL,
  `thumbprint` varchar(40) DEFAULT NULL,
  `certificate_tracker_id` int(10) unsigned DEFAULT NULL,
  `unique_id` varchar(10) NOT NULL DEFAULT '',
  `pay_type` varchar(4) DEFAULT NULL,
  `disable_issuance_email` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `dns_names` text DEFAULT NULL,
  `additional_template_data` text DEFAULT NULL,
  `note` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `domain_id` (`domain_id`),
  KEY `company_id` (`company_id`),
  KEY `ent_client_certs_valid_from` (`valid_from`),
  KEY `is_out_of_contract` (`is_out_of_contract`),
  KEY `status` (`status`),
  KEY `order_tracker_id` (`order_tracker_id`),
  KEY `certificate_tracker_id_idx` (`certificate_tracker_id`),
  KEY `idx_reissued_cert_id` (`reissued_cert_id`),
  KEY `ix_renewal_id` (`renewal_of_cert_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1267593 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `ent_client_cert_data` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `client_cert_id` int(11) NOT NULL,
  `data` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8030 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `ent_client_cert_recovery_requests` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ent_client_cert_id` int(10) unsigned NOT NULL,
  `account_admin_id` int(10) unsigned NOT NULL,
  `recovery_admin_id` int(10) unsigned NOT NULL,
  `email_token` varchar(100) NOT NULL,
  `date_time` datetime NOT NULL,
  `recover_date_time` datetime NOT NULL,
  PRIMARY KEY (`id`,`email_token`),
  UNIQUE KEY `email_token` (`email_token`)
) ENGINE=InnoDB AUTO_INCREMENT=1921 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `ent_requests` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `acct_id` int(6) unsigned zerofill NOT NULL,
  `unit_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `alt_user_id` int(10) unsigned NOT NULL,
  `order_id` int(8) unsigned zerofill NOT NULL,
  `old_order_id` int(8) unsigned zerofill NOT NULL,
  `company_id` int(11) NOT NULL DEFAULT 0,
  `request_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `ip_address` varchar(15) NOT NULL,
  `action` enum('issue','revoke','renew','reissue','duplicate','new user') NOT NULL,
  `csr` text NOT NULL,
  `serversw` smallint(5) NOT NULL,
  `licenses` tinyint(4) NOT NULL,
  `common_names` text NOT NULL,
  `org_unit` varchar(255) NOT NULL,
  `lifetime` tinyint(4) NOT NULL,
  `product_id` int(11) NOT NULL,
  `status` set('pending','approved','rejected','preapproved') DEFAULT NULL,
  `mtime` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `comments` text NOT NULL,
  `admin_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `admin_id` int(10) unsigned DEFAULT NULL,
  `admin_note` text DEFAULT NULL,
  `auto_renew` tinyint(4) DEFAULT 0,
  `auto_renew_email_sent` tinyint(4) DEFAULT 0,
  `allow_unit_access` tinyint(1) NOT NULL DEFAULT 0,
  `valid_till` date NOT NULL DEFAULT '0000-00-00',
  `short_issue` date NOT NULL DEFAULT '0000-00-00',
  `signature_hash` enum('sha1','sha256','sha384','sha512') NOT NULL DEFAULT 'sha1',
  `root_path` enum('digicert','entrust','cybertrust','comodo') NOT NULL DEFAULT 'entrust',
  `grid_service_name` varchar(255) DEFAULT NULL,
  `promo_code` varchar(50) NOT NULL,
  `custom_fields` mediumtext DEFAULT NULL,
  `additional_emails` text DEFAULT NULL,
  `guest_request_name` varchar(255) DEFAULT NULL,
  `guest_request_email` varchar(255) DEFAULT NULL,
  `ip_outside_range` tinyint(1) DEFAULT 0,
  `order_users` varchar(255) DEFAULT NULL,
  `agreement_id` int(10) unsigned DEFAULT NULL,
  `ca_cert_id` smallint(4) unsigned DEFAULT NULL,
  `wifi_data` text DEFAULT NULL,
  `product_addons` text DEFAULT NULL,
  `ssl_profile_option` enum('data_encipherment','secure_email_eku') DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `acct_id` (`acct_id`),
  KEY `user_id` (`user_id`),
  KEY `order_id` (`order_id`),
  KEY `status` (`status`),
  KEY `unit_id` (`unit_id`),
  KEY `old_order_id` (`old_order_id`),
  KEY `company_id` (`company_id`)
) ENGINE=InnoDB AUTO_INCREMENT=720937 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `ent_request_docs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `file_path` varchar(255) DEFAULT NULL,
  `original_name` varchar(96) DEFAULT NULL,
  `upload_time` datetime DEFAULT '1900-01-01 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30022 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `ent_subdomains` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `domain_id` int(11) DEFAULT NULL,
  `subdomain` varchar(255) NOT NULL,
  `ctime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `domain_id` (`domain_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1012202 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `ent_units` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `acct_id` int(6) unsigned zerofill DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `allowed_domains` text NOT NULL,
  `moved_to_container_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `acct_id` (`acct_id`)
) ENGINE=InnoDB AUTO_INCREMENT=31585 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `ev_company_agreements` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `verified_contact_id` int(10) unsigned NOT NULL DEFAULT 0,
  `company_id` int(10) unsigned NOT NULL DEFAULT 0,
  `date_time` datetime NOT NULL,
  `ip_address` varchar(15) NOT NULL,
  `agreement_id` int(10) unsigned NOT NULL DEFAULT 0,
  `status` enum('active','inactive') DEFAULT 'active',
  `verified_contact_snapshot_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `company_id` (`company_id`),
  KEY `verified_contact_id` (`verified_contact_id`),
  KEY `status` (`status`),
  KEY `verified_contact_snapshot_id` (`verified_contact_snapshot_id`)
) ENGINE=InnoDB AUTO_INCREMENT=78900 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `ev_contacts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) NOT NULL,
  `company_id` int(11) NOT NULL,
  `role_id` tinyint(1) NOT NULL,
  `firstname` varchar(64) NOT NULL,
  `lastname` varchar(64) NOT NULL,
  `email` varchar(255) NOT NULL,
  `job_title` varchar(64) NOT NULL,
  `telephone` varchar(32) NOT NULL,
  `master_agreement_id` int(11) NOT NULL,
  `token` varchar(200) NOT NULL,
  `token_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `company_role` (`company_id`,`role_id`),
  KEY `user_id` (`user_id`),
  KEY `master_agreement_id_email` (`master_agreement_id`,`email`)
) ENGINE=InnoDB AUTO_INCREMENT=10795 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `ev_contacts_temp` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(8) unsigned zerofill NOT NULL,
  `role_id` tinyint(1) NOT NULL,
  `firstname` varchar(128) NOT NULL,
  `lastname` varchar(128) NOT NULL,
  `job_title` varchar(128) NOT NULL,
  `email` varchar(255) NOT NULL,
  `telephone` varchar(32) NOT NULL,
  `company_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `role_id` (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11995 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `ev_master_agreements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `company_id` int(11) NOT NULL,
  `date_signed` date NOT NULL,
  `date_entered` datetime NOT NULL,
  `valid_till` date NOT NULL,
  `doc_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `company_id` (`company_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2334 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `extended_order_info` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(10) unsigned NOT NULL,
  `valid_till` date DEFAULT NULL,
  `is_longer_validity_order` tinyint(1) DEFAULT 0,
  `auto_reissue` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_order_id` (`order_id`),
  KEY `ix_valid_till` (`valid_till`)
) ENGINE=InnoDB AUTO_INCREMENT=7667058 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `external_service_lookups` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` int(10) unsigned NOT NULL,
  `external_id` varchar(255) NOT NULL,
  `service` varchar(255) NOT NULL,
  `date_created` datetime NOT NULL DEFAULT current_timestamp(),
  `date_updated` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `external_service_lookups_account_id_idx` (`account_id`),
  KEY `external_service_lookups_service_id_idx` (`external_id`),
  KEY `external_service_lookups_service_idx` (`service`)
) ENGINE=InnoDB AUTO_INCREMENT=22050 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `feature` (
  `id` int(10) unsigned NOT NULL,
  `date_created` datetime DEFAULT NULL,
  `feature_name` varchar(255) NOT NULL,
  `display_name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `display_name_UNIQUE` (`display_name`),
  UNIQUE KEY `feature_name_UNIQUE` (`feature_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `file` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `extension` varchar(16) DEFAULT NULL,
  `path` varchar(255) DEFAULT NULL,
  `size` int(10) unsigned NOT NULL,
  `is_temporary` tinyint(4) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=243564 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `flags` (
  `id` tinyint(1) NOT NULL AUTO_INCREMENT,
  `number` tinyint(1) NOT NULL DEFAULT 0,
  `color` varchar(16) NOT NULL DEFAULT '',
  `description` varchar(128) NOT NULL DEFAULT '',
  `color_code` varchar(7) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`),
  KEY `color` (`color`),
  KEY `description` (`description`),
  KEY `color_code` (`color_code`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `followup_statuses` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `geo_address_override` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL DEFAULT current_timestamp(),
  `staff_id` int(10) unsigned NOT NULL,
  `company_id` int(10) unsigned NOT NULL,
  `order_id` int(11) DEFAULT NULL,
  `org_address` varchar(500) NOT NULL,
  `description` varchar(500) NOT NULL,
  `audited_date` datetime DEFAULT NULL,
  `audited_by` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`staff_id`),
  KEY `idx_company_id` (`company_id`),
  KEY `idx_order_id` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2583 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `geo_country_regions` (
  `country` varchar(2) NOT NULL DEFAULT '',
  `country_name` varchar(255) DEFAULT NULL,
  `region` varchar(255) DEFAULT NULL,
  `language` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`country`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `guest_request` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `requester_name` varchar(75) NOT NULL,
  `requester_email` varchar(75) NOT NULL,
  `request_date` datetime NOT NULL,
  `approve_date` datetime DEFAULT NULL,
  `container_id` int(11) NOT NULL,
  `note` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `hardenize_accounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(10) unsigned NOT NULL,
  `account_name` varchar(16) NOT NULL,
  `status` varchar(16) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `last_updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_id` (`account_id`),
  KEY `idx_account_id` (`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=446 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `hardenize_ct_notification_status` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `email_type` varchar(100) DEFAULT NULL,
  `email_status` tinyint(1) DEFAULT NULL,
  `api_request` text DEFAULT NULL,
  `email_recipients` varchar(100) DEFAULT NULL,
  `notification_trigger_time` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_account_id_email_type_notification_time` (`account_id`,`email_type`,`notification_trigger_time`)
) ENGINE=InnoDB AUTO_INCREMENT=1609 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `hardenize_order_ct_monitoring_status` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `order_id` bigint(20) NOT NULL,
  `hostname` varchar(1024) NOT NULL,
  `ct_monitoring_status` tinyint(1) DEFAULT NULL,
  `date_created` datetime NOT NULL DEFAULT current_timestamp(),
  `last_updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_order_id` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2177 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `hardware_order_extras` (
  `order_id` int(8) unsigned zerofill NOT NULL,
  `ship_name` varchar(128) DEFAULT NULL,
  `ship_addr1` varchar(128) DEFAULT NULL,
  `ship_addr2` varchar(128) DEFAULT NULL,
  `ship_city` varchar(128) DEFAULT NULL,
  `ship_state` varchar(128) DEFAULT NULL,
  `ship_zip` varchar(40) DEFAULT NULL,
  `ship_country` varchar(128) DEFAULT NULL,
  `ship_method` enum('STANDARD','EXPEDITED') DEFAULT NULL,
  `device_manufacturer` varchar(128) DEFAULT NULL,
  `device_serial` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `hardware_platforms` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `display_name` varchar(100) NOT NULL DEFAULT '',
  `product_name` varchar(100) NOT NULL DEFAULT '',
  `model` varchar(50) NOT NULL DEFAULT '',
  `manufacturer` varchar(100) NOT NULL DEFAULT '',
  `sort_order` int(11) NOT NULL DEFAULT 100,
  `driver_url` varchar(200) NOT NULL DEFAULT '',
  `device_type` enum('token','hsm') NOT NULL DEFAULT 'token',
  `fips_certified` varchar(20) NOT NULL DEFAULT '',
  `common_criteria_certified` varchar(30) NOT NULL DEFAULT '',
  `enabled_for_product` set('evcode','ds') NOT NULL DEFAULT 'evcode,ds',
  PRIMARY KEY (`id`),
  KEY `device_type` (`fips_certified`),
  KEY `common_criteria_certified` (`common_criteria_certified`),
  KEY `product_name` (`product_name`),
  KEY `manufacturer` (`manufacturer`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `hardware_ship_info` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(8) unsigned zerofill NOT NULL DEFAULT 00000000,
  `status` enum('pending','created','shipped','received') NOT NULL DEFAULT 'pending',
  `tracking_number` varchar(100) DEFAULT NULL,
  `date_mailed` datetime DEFAULT NULL,
  `date_received` datetime DEFAULT NULL,
  `hardware_otp` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=15093 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `hardware_token_info` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(8) unsigned zerofill NOT NULL DEFAULT 00000000,
  `init_code` varchar(128) NOT NULL,
  `status` enum('active','used','rejected') NOT NULL DEFAULT 'active',
  `date_generated` datetime DEFAULT NULL,
  `token_platform_id` int(11) NOT NULL DEFAULT 0,
  `token_info` text NOT NULL,
  `created_by_customer` tinyint(1) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `init_code` (`init_code`)
) ENGINE=InnoDB AUTO_INCREMENT=41174 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `heartbleed_certs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `acct_id` int(6) unsigned zerofill NOT NULL DEFAULT 000000,
  `order_id` int(8) unsigned zerofill NOT NULL DEFAULT 00000000,
  `status` enum('patch','replace','install','revoke','complete') NOT NULL DEFAULT 'patch',
  `serial_number` varchar(36) NOT NULL DEFAULT '',
  `thumbprint` varchar(42) NOT NULL DEFAULT '',
  `host_name` varchar(128) NOT NULL DEFAULT '',
  `ip_address` varchar(15) NOT NULL DEFAULT '',
  `port` smallint(5) unsigned NOT NULL DEFAULT 443,
  `valid_till` date NOT NULL DEFAULT '1900-01-01',
  `create_date` datetime NOT NULL DEFAULT '1900-01-01 00:00:00',
  `last_vulnerable` datetime NOT NULL DEFAULT '1900-01-01 00:00:00',
  `last_scanned` datetime NOT NULL DEFAULT '1900-01-01 00:00:00',
  `hash1` int(10) unsigned NOT NULL DEFAULT 0,
  `hash2` int(10) unsigned NOT NULL DEFAULT 0,
  `hash3` int(10) unsigned NOT NULL DEFAULT 0,
  `hash4` int(10) unsigned NOT NULL DEFAULT 0,
  `hash5` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `serial_number` (`serial_number`(8)),
  KEY `thumbprint` (`thumbprint`(8)),
  KEY `hash1` (`hash1`),
  KEY `host_lookup` (`ip_address`(6),`host_name`(4)),
  KEY `acct_id` (`acct_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14320 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `high_risk_clues` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `field_name` enum('email','org_name','country','contact_name','phone','domain','general_keyword','ip_address','whois') DEFAULT NULL,
  `match_type` enum('contains','startswith','endswith','regex','equals','slim_org_match') NOT NULL DEFAULT 'equals',
  `value` varchar(200) NOT NULL,
  `risk_score` int(11) NOT NULL DEFAULT 10,
  `created_by_staff_id` int(11) NOT NULL DEFAULT 0,
  `date_added` datetime NOT NULL,
  `reason` varchar(200) DEFAULT NULL,
  `limited_to_products` varchar(255) NOT NULL DEFAULT '',
  `limited_to_org_types` varchar(255) NOT NULL DEFAULT '',
  `status` enum('active','deleted') DEFAULT 'active',
  PRIMARY KEY (`id`),
  UNIQUE KEY `field_name_2` (`field_name`,`match_type`,`value`),
  KEY `field_name` (`field_name`),
  KEY `match_type` (`match_type`),
  KEY `value` (`value`)
) ENGINE=InnoDB AUTO_INCREMENT=5347 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `high_risk_clues_whitelist` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `high_risk_clue_id` int(10) unsigned NOT NULL,
  `account_id` int(10) unsigned NOT NULL,
  `is_active` tinyint(3) unsigned NOT NULL DEFAULT 1,
  `date_created` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `created_staff_id` smallint(5) unsigned NOT NULL,
  `date_inactivated` timestamp NULL DEFAULT NULL,
  `inactivated_staff_id` smallint(5) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `high_risk_clue_id` (`high_risk_clue_id`),
  KEY `account_id` (`account_id`),
  KEY `is_active` (`is_active`)
) ENGINE=InnoDB AUTO_INCREMENT=1577 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `hisp_account_extras` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `acct_id` int(11) DEFAULT NULL,
  `is_ra` int(1) NOT NULL DEFAULT 0,
  `accredited_roots` varchar(255) DEFAULT NULL,
  `non_accredited_root` int(11) DEFAULT NULL,
  `direct_trust_identifier` varchar(255) DEFAULT NULL,
  `accredited` tinyint(4) DEFAULT 0,
  `declaration_of_id_path` varchar(255) NOT NULL,
  `declaration_of_id_name` varchar(255) NOT NULL,
  `declaration_of_id_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `validation_contact` enum('isso','applicant','org_contact','hisp_contact') NOT NULL DEFAULT 'isso',
  `pre_validation_contact` enum('org_contact','hisp_contact') NOT NULL DEFAULT 'hisp_contact',
  `validation_level` enum('standard','minimum') DEFAULT 'standard',
  `single_use` int(1) DEFAULT 0,
  `use_npi` int(1) DEFAULT 0,
  `show_case_notes` tinyint(4) DEFAULT 0,
  `use_experian` int(1) DEFAULT 0,
  `products` set('address','org','device','fbca_address') DEFAULT 'address,org,device',
  PRIMARY KEY (`id`),
  UNIQUE KEY `acct_id` (`acct_id`),
  KEY `direct_trust_identifier` (`direct_trust_identifier`)
) ENGINE=InnoDB AUTO_INCREMENT=118 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `hisp_company_extras` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `company_id` int(11) NOT NULL,
  `agreement_id` int(11) DEFAULT NULL,
  `agreement_user_id` int(11) DEFAULT NULL,
  `ent_request_id` int(11) DEFAULT NULL,
  `level` enum('basic','medium') DEFAULT 'basic',
  `sole_proprietor` int(1) DEFAULT NULL,
  `hipaa_type` enum('covered','associate','other','notapplicable','notdeclared','patient') DEFAULT NULL,
  `accredited_root` int(11) DEFAULT 88,
  `validation_contact` enum('isso','applicant','org_contact','hisp_contact') NOT NULL DEFAULT 'isso',
  `pre_validation_contact` enum('org_contact','hisp_contact') NOT NULL DEFAULT 'hisp_contact',
  `declaration_of_id_path` varchar(255) NOT NULL,
  `declaration_of_id_name` varchar(255) NOT NULL,
  `declaration_of_id_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `single_use` int(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_company` (`company_id`),
  KEY `ent_request_id` (`ent_request_id`)
) ENGINE=InnoDB AUTO_INCREMENT=102805 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `hisp_ent_request_extras` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ent_request_id` int(11) DEFAULT NULL,
  `isso_id` int(11) DEFAULT NULL,
  `representative_id` int(11) DEFAULT NULL,
  `verified_contact_id` int(11) DEFAULT NULL,
  `level` enum('basic','medium') DEFAULT 'basic',
  `subject_individual_id` int(11) DEFAULT NULL,
  `ca_cert_id_deprecated` int(11) NOT NULL DEFAULT 0,
  `domain` text DEFAULT NULL,
  `subdomain` text DEFAULT NULL,
  `contact_email` varchar(255) DEFAULT NULL,
  `direct_email` varchar(255) DEFAULT NULL,
  `hipaa_type` enum('covered','associate','other','notapplicable','notdeclared','patient') DEFAULT NULL,
  `csr2` text DEFAULT NULL,
  `npi_id` int(11) DEFAULT NULL,
  `include_address` tinyint(1) DEFAULT NULL,
  `group_cert` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ent_request_id` (`ent_request_id`),
  KEY `npi_id` (`npi_id`)
) ENGINE=InnoDB AUTO_INCREMENT=269089 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `hisp_public_keys` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `acct_id` int(11) DEFAULT NULL,
  `type` set('encryption','signing','dual') DEFAULT NULL,
  `hash1` int(10) unsigned DEFAULT NULL,
  `hash2` int(10) unsigned DEFAULT NULL,
  `hash3` int(10) unsigned DEFAULT NULL,
  `hash4` int(10) unsigned DEFAULT NULL,
  `hash5` int(10) unsigned DEFAULT NULL,
  `issued_date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index2` (`acct_id`,`hash1`,`hash2`,`hash3`,`hash4`,`hash5`)
) ENGINE=InnoDB AUTO_INCREMENT=246779 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `hisp_user_extras` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `addr1` varchar(128) DEFAULT NULL,
  `addr2` varchar(128) DEFAULT NULL,
  `city` varchar(128) DEFAULT NULL,
  `state` varchar(128) DEFAULT NULL,
  `zip` varchar(40) DEFAULT NULL,
  `country` varchar(2) DEFAULT NULL,
  `agreement_id` int(11) DEFAULT NULL,
  `agreement_date` datetime DEFAULT NULL,
  `alternate_email` varchar(255) DEFAULT NULL,
  `level` set('basic','medium') DEFAULT 'basic',
  `access_certs` tinyint(1) DEFAULT 0,
  `isso` tinyint(1) DEFAULT 0,
  `representative` tinyint(1) DEFAULT 0,
  `trusted_agent` tinyint(1) DEFAULT 0,
  `all_hcos` tinyint(1) DEFAULT 0,
  `written_agreement` tinyint(1) DEFAULT 0,
  `ta_written_agreement` tinyint(1) DEFAULT 0,
  `encrypted_data` text NOT NULL,
  `user_completed` int(1) DEFAULT 0,
  `verification_method` enum('experian','doid') DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=137548 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `i18n_languages` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name_in_english` varchar(255) NOT NULL DEFAULT '',
  `name_in_language` varchar(255) NOT NULL,
  `abbreviation` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `abbr` (`abbreviation`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `imperva_block_ip_rules` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ip_address` varchar(40) NOT NULL DEFAULT '',
  `imperva_rule_id` int(11) NOT NULL,
  `created_time` datetime NOT NULL DEFAULT current_timestamp(),
  `disabled_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `imperva_rule_id` (`imperva_rule_id`),
  KEY `disabled_time` (`disabled_time`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `incentive_plans` (
  `id` tinyint(4) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `incident_communications_report_cache` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` int(10) unsigned DEFAULT NULL,
  `company_id` int(10) unsigned DEFAULT NULL,
  `company_name` varchar(256) DEFAULT NULL,
  `order_id` int(8) unsigned DEFAULT NULL,
  `reissue_id` int(11) DEFAULT NULL,
  `duplicate_id` int(11) DEFAULT NULL,
  `serial_number` varchar(36) DEFAULT NULL,
  `common_name` varchar(128) DEFAULT NULL,
  `sans` text DEFAULT NULL,
  `product_name` varchar(128) DEFAULT NULL,
  `valid_from` datetime DEFAULT NULL,
  `valid_to` datetime DEFAULT NULL,
  `revoked_status` varchar(16) DEFAULT NULL,
  `revoked_time` datetime DEFAULT NULL,
  `certificate_pem` mediumtext DEFAULT NULL,
  `primary_company_id` int(10) unsigned DEFAULT NULL,
  `account_class` varchar(50) DEFAULT NULL,
  `account_rep_name` varchar(256) DEFAULT NULL,
  `account_rep_email` varchar(256) DEFAULT NULL,
  `account_rep_phone` varchar(256) DEFAULT NULL,
  `order_org_contact_name` varchar(256) DEFAULT NULL,
  `order_org_contact_email` varchar(256) DEFAULT NULL,
  `order_org_contact_phone` varchar(256) DEFAULT NULL,
  `order_tech_contact_name` varchar(256) DEFAULT NULL,
  `order_tech_contact_email` varchar(256) DEFAULT NULL,
  `order_tech_contact_phone` varchar(256) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `staff_id` int(10) unsigned NOT NULL,
  `is_certcentral` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_order_reissue_duplicate` (`order_id`,`reissue_id`,`duplicate_id`),
  KEY `idx_account_id` (`account_id`),
  KEY `idx_serial_number` (`serial_number`),
  KEY `idx_order_id` (`order_id`),
  KEY `idx_date_created` (`date_created`)
) ENGINE=InnoDB AUTO_INCREMENT=398 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `intermediates` (
  `ca_cert_id` int(11) NOT NULL,
  `external_id` varchar(16) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT current_timestamp(),
  `type` enum('ev','ov','direct') DEFAULT NULL,
  `accredited` int(1) DEFAULT 0,
  `active` int(1) DEFAULT 1,
  `always_available` int(1) DEFAULT 1,
  `fbca` tinyint(4) DEFAULT 1,
  PRIMARY KEY (`ca_cert_id`),
  UNIQUE KEY `external_id` (`external_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `invoice` (
  `id` int(4) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `acct_id` int(6) unsigned zerofill NOT NULL DEFAULT 000000,
  `status` int(1) NOT NULL DEFAULT 1,
  `void` int(1) NOT NULL DEFAULT 0,
  `po_id` int(6) NOT NULL,
  `po_number` varchar(32) NOT NULL,
  `date` datetime NOT NULL,
  `terms` int(2) NOT NULL DEFAULT 10,
  `terms_eom` tinyint(4) DEFAULT 0,
  `date_due` datetime NOT NULL,
  `customer_contact` varchar(128) NOT NULL,
  `customer_contact_email` varchar(255) DEFAULT NULL,
  `technical_contact` varchar(128) NOT NULL,
  `invoice_name` varchar(128) NOT NULL,
  `invoice_address_1` varchar(64) NOT NULL,
  `invoice_address_2` varchar(64) DEFAULT NULL,
  `invoice_city` varchar(64) NOT NULL,
  `invoice_state` varchar(64) NOT NULL,
  `invoice_country` varchar(2) NOT NULL,
  `invoice_zip` varchar(10) DEFAULT NULL,
  `invoice_telephone` varchar(32) NOT NULL DEFAULT '',
  `invoice_telephone_ext` varchar(16) NOT NULL DEFAULT '',
  `invoice_amount` decimal(10,2) DEFAULT 0.00,
  `amount_owed` decimal(10,2) DEFAULT NULL,
  `has_history` int(1) DEFAULT 0,
  `notice_sent` tinyint(3) unsigned DEFAULT 0,
  `void_date` datetime DEFAULT NULL,
  `void_staff_id` int(10) unsigned DEFAULT NULL,
  `void_reason` text DEFAULT NULL,
  `notes` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `po_id` (`po_id`),
  KEY `acct_id` (`acct_id`)
) ENGINE=InnoDB AUTO_INCREMENT=192344 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `invoice_audit` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `action_id` int(10) unsigned DEFAULT NULL,
  `field_name` varchar(50) DEFAULT NULL,
  `old_value` varchar(255) DEFAULT NULL,
  `new_value` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3449278 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `invoice_audit_action` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `invoice_id` int(10) unsigned DEFAULT NULL,
  `staff_id` smallint(5) unsigned NOT NULL DEFAULT 0,
  `date_dt` datetime DEFAULT NULL,
  `action_type` varchar(255) DEFAULT NULL,
  `affected_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=568046 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `invoice_deposits` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `deposit_date` datetime DEFAULT NULL,
  `staff_id` int(10) unsigned NOT NULL DEFAULT 0,
  `payment_medium` varchar(12) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36180 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `invoice_history` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `invoice_id` int(8) NOT NULL,
  `note_date` datetime NOT NULL,
  `staff_id` int(10) unsigned NOT NULL DEFAULT 0,
  `payment_medium` varchar(45) DEFAULT NULL,
  `void` int(1) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `memo` text DEFAULT NULL,
  `amount_paid` decimal(10,2) DEFAULT NULL,
  `new_balance` decimal(10,2) DEFAULT NULL,
  `deposit_id` int(1) DEFAULT 0,
  `deposit_date` date DEFAULT NULL,
  `wire_fees_graced` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `invoice_id_idx` (`invoice_id`)
) ENGINE=InnoDB AUTO_INCREMENT=139579 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `invoice_nightly_report` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `count_over_100` int(5) NOT NULL DEFAULT 0,
  `value_over_100` decimal(10,2) NOT NULL DEFAULT 0.00,
  `percent_count_over_100` decimal(3,1) NOT NULL DEFAULT 0.0,
  `value_percent_over_100` decimal(3,1) NOT NULL DEFAULT 0.0,
  `count_over_50` int(5) NOT NULL DEFAULT 0,
  `value_over_50` decimal(10,2) NOT NULL DEFAULT 0.00,
  `percent_count_over_50` decimal(3,1) NOT NULL DEFAULT 0.0,
  `value_percent_over_50` decimal(3,1) NOT NULL DEFAULT 0.0,
  `count_over_20` int(5) NOT NULL DEFAULT 0,
  `value_over_20` decimal(10,2) NOT NULL DEFAULT 0.00,
  `percent_count_over_20` decimal(3,1) NOT NULL DEFAULT 0.0,
  `value_percent_over_20` decimal(3,1) NOT NULL DEFAULT 0.0,
  `total_open_invoices` int(5) NOT NULL DEFAULT 0,
  `total_open_value` decimal(10,2) NOT NULL DEFAULT 0.00,
  `funds_received` decimal(10,2) NOT NULL DEFAULT 0.00,
  `invoiced_today` decimal(10,2) NOT NULL DEFAULT 0.00,
  `received_today` decimal(10,2) NOT NULL DEFAULT 0.00,
  `currency` char(3) CHARACTER SET ascii NOT NULL DEFAULT 'USD',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10233 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `invoice_products` (
  `id` int(4) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `invoice_id` int(4) unsigned NOT NULL DEFAULT 0,
  `quantity` int(4) NOT NULL DEFAULT 0,
  `product` varchar(64) NOT NULL DEFAULT '',
  `years` tinyint(1) NOT NULL DEFAULT 0,
  `servers` int(4) NOT NULL DEFAULT 0,
  `license` enum('single','unlimited') NOT NULL DEFAULT 'single',
  `cred_amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `order_id` int(8) unsigned zerofill NOT NULL DEFAULT 00000000,
  `amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `order_ids` int(8) unsigned zerofill NOT NULL DEFAULT 00000000,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `invoice_statuses` (
  `id` tinyint(4) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  `short_name` varchar(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `ip_access` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime DEFAULT NULL,
  `acct_id` int(6) unsigned zerofill NOT NULL DEFAULT 000000,
  `container_id` int(11) DEFAULT NULL,
  `ent_unit_id` int(11) unsigned NOT NULL DEFAULT 0,
  `user_id` int(10) unsigned NOT NULL DEFAULT 0,
  `scope_container_id` int(11) DEFAULT NULL,
  `ip_address` varchar(15) NOT NULL DEFAULT '',
  `ip_address_end` varchar(15) NOT NULL DEFAULT '',
  `description` varchar(255) DEFAULT '',
  `guest_request_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_guest_request_id` (`guest_request_id`),
  KEY `acct_id` (`acct_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11167 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `key_recovery_admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_account` (`user_id`,`account_id`),
  KEY `account_id` (`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `legal_policies_hooks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL DEFAULT '',
  `link_text` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `legal_policies_links` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `link` text NOT NULL,
  `percentage` tinyint(3) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `logo_docs` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `hash` varchar(75) DEFAULT NULL,
  `doc_id` int(11) DEFAULT NULL,
  `company_id` int(11) DEFAULT NULL,
  `trademark_country_code` varchar(25) DEFAULT NULL,
  `trademark_office_url` varchar(25) DEFAULT NULL,
  `trademark_registration_number` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=320 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `log_account_settings_change` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_time` datetime NOT NULL DEFAULT current_timestamp() COMMENT 'The date and time of the account settings change',
  `ip_address` varchar(15) NOT NULL COMMENT 'The IP address that the user was using when they made the change',
  `staff_id` int(10) unsigned DEFAULT NULL COMMENT 'The staff id of the adminarea staff user who made the account settings change',
  `user_id` int(10) unsigned DEFAULT NULL COMMENT 'The user id of the customer who made the account settings change',
  `username` varchar(255) NOT NULL COMMENT 'The username of the adminarea user who made the account setting change',
  `account_id` int(10) unsigned NOT NULL COMMENT 'The id of the account that was affected',
  `setting` varchar(50) NOT NULL COMMENT 'A text tag that identifies the setting that was changed',
  `fieldname` varchar(50) NOT NULL COMMENT 'The database fieldname that was changed table.field',
  `old_value` varchar(255) NOT NULL COMMENT 'The previous value of the setting',
  `new_value` varchar(255) NOT NULL COMMENT 'The new value of the setting',
  `description` tinytext NOT NULL COMMENT 'A human readable description of the change',
  `note` tinytext DEFAULT NULL COMMENT 'An optional note explaining the change if the UI prompts for it',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `staff_id` (`staff_id`) USING BTREE,
  KEY `account_id` (`account_id`) USING BTREE,
  KEY `setting` (`setting`) USING BTREE,
  KEY `date_time` (`date_time`) USING BTREE,
  KEY `user_id` (`user_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7248 DEFAULT CHARSET=utf8 COMMENT='This table is used to track changes to account settings made through adminarea by DigiCert staff members or by customers through the CertCentral API or UI.';

CREATE TABLE IF NOT EXISTS `log_admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `staff_id` int(11) NOT NULL DEFAULT 0,
  `username` varchar(128) NOT NULL DEFAULT '',
  `date_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `ip_address` varchar(15) NOT NULL DEFAULT '',
  `description` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `log_admin_ip_address` (`ip_address`(6)),
  KEY `log_admin_description` (`description`(10)),
  KEY `staff_id` (`staff_id`)
) ENGINE=InnoDB AUTO_INCREMENT=56830412 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `log_email_clicks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uxtime` int(10) unsigned NOT NULL,
  `email_id` int(10) unsigned NOT NULL,
  `action` varchar(16) DEFAULT NULL,
  `email_description` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `email_id` (`email_id`),
  KEY `uxtime` (`uxtime`)
) ENGINE=InnoDB AUTO_INCREMENT=352236 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `log_email_opens` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uxtime` int(10) unsigned NOT NULL,
  `email_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `email_id` (`email_id`),
  KEY `uxtime` (`uxtime`)
) ENGINE=InnoDB AUTO_INCREMENT=3034760 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `log_email_templates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `language` varchar(2) NOT NULL DEFAULT '',
  `template` varchar(48) NOT NULL DEFAULT '',
  `tracking_hash` varchar(8) NOT NULL DEFAULT '',
  `acct_id` int(10) unsigned NOT NULL DEFAULT 0,
  `order_id` int(10) unsigned NOT NULL DEFAULT 0,
  `to` varchar(128) NOT NULL DEFAULT '',
  `data` mediumtext DEFAULT NULL,
  `extras` mediumtext DEFAULT NULL,
  `staff_id` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `template` (`template`(8)),
  KEY `date_time` (`date_time`)
) ENGINE=InnoDB AUTO_INCREMENT=125767171 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `log_forgot` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ip_address` varchar(15) NOT NULL DEFAULT '',
  `ip_country` char(2) DEFAULT NULL,
  `date_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `user_id` int(11) NOT NULL DEFAULT 0,
  `username` varchar(128) NOT NULL DEFAULT '',
  `result` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ip_address` (`ip_address`),
  KEY `date_time` (`date_time`)
) ENGINE=InnoDB AUTO_INCREMENT=122409 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `log_manual` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `staff_id` smallint(5) unsigned NOT NULL DEFAULT 0,
  `time_performed` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `log_action` int(4) unsigned zerofill NOT NULL DEFAULT 0000,
  `notes` text NOT NULL,
  `ip` varchar(15) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1294 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `manual_dcv` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `domain_public_id` varchar(255) NOT NULL,
  `dcv_type` varchar(255) DEFAULT NULL,
  `contact_info` text DEFAULT NULL,
  `screenshot_doc_id` varchar(255) DEFAULT NULL,
  `auth_doc_id` varchar(255) DEFAULT NULL,
  `staff_id_first_auth` int(11) DEFAULT NULL,
  `staff_id_second_auth` int(11) DEFAULT NULL,
  `first_auth_date` datetime NOT NULL,
  `second_auth_date` datetime DEFAULT NULL,
  `reject_date` datetime DEFAULT NULL,
  `random_value_doc_id` varchar(255) DEFAULT NULL,
  `random_value` varchar(100) DEFAULT NULL,
  `validation_url` varchar(3000) DEFAULT NULL,
  `audited_date` datetime DEFAULT NULL,
  `audited_by` int(10) unsigned DEFAULT NULL,
  `is_ip_address` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `ix_domain_public_id` (`domain_public_id`(8)),
  KEY `idx_dcv_type` (`dcv_type`),
  KEY `idx_first_auth` (`staff_id_first_auth`),
  KEY `idx_second_auth` (`staff_id_second_auth`),
  KEY `idx_is_ip` (`is_ip_address`)
) ENGINE=InnoDB AUTO_INCREMENT=136299 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `metadata` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `account_id` int(10) unsigned NOT NULL,
  `label` varchar(100) NOT NULL,
  `is_required` tinyint(1) NOT NULL DEFAULT 0,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `data_type` varchar(20) DEFAULT NULL,
  `description` varchar(512) DEFAULT NULL,
  `drop_down_options` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_account_id_label` (`account_id`,`label`)
) ENGINE=InnoDB AUTO_INCREMENT=7194 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `netsuite_invoice` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` int(10) unsigned NOT NULL,
  `container_id` int(10) unsigned NOT NULL,
  `date_created` datetime NOT NULL,
  `ns_so_internal_id` int(10) unsigned DEFAULT 0,
  `ns_inv_internal_id` int(10) unsigned DEFAULT 0,
  `ns_invoice_number` varchar(20) NOT NULL DEFAULT '',
  `ns_created_date` datetime DEFAULT NULL,
  `cc_invoice_id` int(10) unsigned NOT NULL COMMENT 'invoice.id',
  `item_subtotal` decimal(17,2) NOT NULL DEFAULT 0.00,
  `tax_subtotal` decimal(17,2) NOT NULL DEFAULT 0.00,
  `invoice_total` decimal(17,2) NOT NULL DEFAULT 0.00,
  `amount_remaining` decimal(17,2) NOT NULL DEFAULT 0.00,
  `invoice_email` varchar(192) NOT NULL DEFAULT '',
  `invoice_creation_type` enum('auto_invoice','invoice_for_po','wire_transfer_invoice') DEFAULT NULL,
  `invoice_memo` varchar(255) NOT NULL DEFAULT '',
  `currency` varchar(3) NOT NULL DEFAULT 'USD',
  `terms` enum('NET 30 EOM','NET 30','NET 45 EOM','NET 45','NET 60 EOM','NET 60','NET 90 EOM','NET 90') NOT NULL DEFAULT 'NET 30',
  `payment_method` enum('other','ns-invoice-payment','wire-transfer') NOT NULL DEFAULT 'other',
  `payment_status` enum('UNPAID','PAID') NOT NULL DEFAULT 'UNPAID',
  `cancel_date` datetime NOT NULL DEFAULT '1900-01-01 00:00:00',
  `payment_recorded_date` datetime NOT NULL DEFAULT '1900-01-01 00:00:00',
  `refund_required` tinyint(4) NOT NULL DEFAULT 0,
  `refund_completed` tinyint(4) NOT NULL DEFAULT 0,
  `netsuite_invoice_pdf_url` varchar(255) NOT NULL DEFAULT '',
  `voucher_order_id` int(10) unsigned DEFAULT 0,
  `ns_inv_due_date` datetime DEFAULT NULL,
  `ns_tran_date` datetime DEFAULT NULL,
  `receipt_id` int(10) unsigned NOT NULL,
  `billing_attention` varchar(255) NOT NULL DEFAULT '',
  `billing_org_name` varchar(255) NOT NULL DEFAULT '',
  `billing_addr1` varchar(255) NOT NULL DEFAULT '',
  `billing_addr2` varchar(255) NOT NULL DEFAULT '',
  `billing_city` varchar(128) NOT NULL DEFAULT '',
  `billing_state` varchar(64) NOT NULL DEFAULT '',
  `billing_zip` varchar(32) NOT NULL DEFAULT '',
  `billing_telephone` varchar(32) NOT NULL DEFAULT '',
  `billing_country` varchar(2) NOT NULL DEFAULT '',
  `customer_po_request_id` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `date_created` (`date_created`),
  KEY `account_id` (`account_id`),
  KEY `payment_status` (`payment_status`),
  KEY `ns_inv_internal_id` (`ns_inv_internal_id`),
  KEY `cc_invoice_id` (`cc_invoice_id`),
  KEY `idx_voucher_order_id` (`voucher_order_id`),
  KEY `idx_customer_po_request_id` (`customer_po_request_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10316 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `netsuite_invoice_item` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `netsuite_invoice_id` int(10) unsigned NOT NULL,
  `item_amount` decimal(17,2) NOT NULL DEFAULT 0.00,
  `product_id` int(11) NOT NULL DEFAULT 0,
  `sales_stat_id` int(11) NOT NULL DEFAULT 0,
  `order_id` int(11) NOT NULL DEFAULT 0,
  `reissue_id` int(10) unsigned DEFAULT 0 COMMENT 'customer_order_reissue_history.id',
  `order_transaction_id` int(10) unsigned DEFAULT 0,
  `validity_years` int(10) unsigned DEFAULT NULL,
  `validity_days` smallint(5) unsigned DEFAULT 0,
  `voucher_code_id` int(10) unsigned DEFAULT 0,
  `no_of_fqdns` tinyint(3) unsigned DEFAULT 0,
  `no_of_wildcards` tinyint(3) unsigned DEFAULT 0,
  `use_san_package` tinyint(1) DEFAULT NULL,
  `group_id` int(10) unsigned DEFAULT 0,
  `ns_external_product_id` varchar(32) DEFAULT NULL,
  `item_tax_amount` decimal(17,2) NOT NULL DEFAULT 0.00,
  `effective_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  `quantity` smallint(5) unsigned DEFAULT 0,
  `issuance_recorded` tinyint(3) unsigned DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `netsuite_invoice_id` (`netsuite_invoice_id`),
  KEY `sales_stat_id` (`sales_stat_id`),
  KEY `order_id` (`order_id`),
  KEY `reissue_id` (`reissue_id`),
  KEY `order_transaction_id` (`order_transaction_id`),
  KEY `idx_voucher_code_id` (`voucher_code_id`),
  KEY `idx_ns_external_product_id` (`ns_external_product_id`),
  KEY `idx_issuance_recorded` (`issuance_recorded`)
) ENGINE=InnoDB AUTO_INCREMENT=10558 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `netsuite_tax_transaction` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL DEFAULT current_timestamp(),
  `account_id` int(10) unsigned NOT NULL,
  `container_id` int(10) unsigned DEFAULT NULL,
  `tax_amount` decimal(18,2) NOT NULL,
  `start_date` datetime NOT NULL,
  `acct_adjust_id` int(10) unsigned NOT NULL,
  `order_id` int(8) unsigned NOT NULL DEFAULT 0,
  `voucher_order_id` int(10) unsigned NOT NULL DEFAULT 0,
  `currency` varchar(3) NOT NULL DEFAULT 'USD',
  PRIMARY KEY (`id`),
  KEY `ix_account_id` (`account_id`),
  KEY `ix_container_id` (`container_id`),
  KEY `ix_order_id` (`order_id`),
  KEY `ix_acct_adjust_id` (`acct_adjust_id`),
  KEY `ix_date_created` (`date_created`),
  KEY `ix_voucher_order_id` (`voucher_order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16370 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `netsuite_transaction` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `order_date` datetime NOT NULL COMMENT 'The date the original order was placed, whether or not it was issued',
  `start_date` datetime NOT NULL COMMENT 'The issue date (col_date) of the first certificate on the order, or in case of vouchers the transaction date',
  `end_date` date DEFAULT '0000-00-00' COMMENT 'For certs, should contain cert expiry date. For vouchers, col_date +1year. For multi-year plans, extended_order_info.valid_till',
  `account_id` int(10) unsigned NOT NULL COMMENT 'The account_id, except when a subaccount_order_transaction exists... then should contain billed_account_id',
  `container_id` int(10) unsigned DEFAULT NULL COMMENT 'The container_id, except when a subaccount_order_transaction exists... then it should contain the container_id for the billed_account_id. For non-container accounts (Direct Health) must be NULL.',
  `order_id` int(8) unsigned NOT NULL DEFAULT 0 COMMENT 'Must be populated for all orders and client_certs',
  `voucher_order_id` int(10) unsigned NOT NULL DEFAULT 0,
  `gross_amount` decimal(18,2) NOT NULL COMMENT 'Positive or negative, but should never be 0. Do not insert a netsuite_transaction record if the amount is $0',
  `tax_amount` decimal(18,2) NOT NULL COMMENT 'Calculated tax amount',
  `total_amount` decimal(18,2) NOT NULL COMMENT 'Sum of gross_amount + tax_amount',
  `currency` varchar(3) NOT NULL DEFAULT 'USD' COMMENT 'The currency for gross_amount, tax_amount, and total_amount',
  `product_id` int(11) DEFAULT NULL COMMENT 'The product_id of the transaction.',
  `type` enum('order','rejection','refund','invoice-refund') NOT NULL DEFAULT 'order' COMMENT 'Transaction type',
  `pay_type` enum('acct-credit','credit-card','wire-deposit','check-deposit','po-deposit') DEFAULT NULL COMMENT 'Payment Method used for this transaction',
  `parent_transaction_id` int(10) unsigned DEFAULT NULL COMMENT 'This field is not sent to NetSuite, but helps track the original netsuite_transaction id for refunds/revokes',
  `receipt_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'This field is not sent to NetSuite, but is stored to facilitate tracking and debugging any issues that could arise',
  PRIMARY KEY (`id`),
  KEY `ix_account_id` (`account_id`),
  KEY `ix_container_id` (`container_id`),
  KEY `ix_order_id` (`order_id`),
  KEY `ix_parent_transaction_id` (`parent_transaction_id`),
  KEY `ix_receipt_id` (`receipt_id`),
  KEY `ix_date_created` (`date_created`),
  KEY `ix_voucher_order_id` (`voucher_order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=507120 DEFAULT CHARSET=utf8 COMMENT='This table is used to record financial transactions that need to be integrated to and recorded in NetSuite.';

CREATE TABLE IF NOT EXISTS `notes_deleted` (
  `id` int(10) unsigned NOT NULL,
  `acct_id` int(10) unsigned DEFAULT NULL,
  `order_id` int(10) unsigned DEFAULT NULL,
  `company_id` int(10) unsigned DEFAULT NULL,
  `domain_id` int(10) unsigned DEFAULT NULL,
  `reissue_id` int(10) unsigned DEFAULT NULL,
  `staff_id` int(10) unsigned DEFAULT NULL,
  `date_time` datetime NOT NULL,
  `sticky` int(11) DEFAULT NULL,
  `note` text NOT NULL,
  `del_date_time` datetime NOT NULL,
  `del_staff_id` int(10) unsigned DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `notes_shared` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `acct_id` int(10) unsigned NOT NULL DEFAULT 0,
  `order_id` int(10) unsigned NOT NULL DEFAULT 0,
  `company_id` int(10) unsigned NOT NULL DEFAULT 0,
  `domain_id` int(10) unsigned NOT NULL DEFAULT 0,
  `reissue_id` int(10) unsigned NOT NULL DEFAULT 0,
  `staff_id` int(10) unsigned NOT NULL DEFAULT 0,
  `date_time` datetime NOT NULL,
  `sticky` int(11) NOT NULL DEFAULT 0,
  `is_support` tinyint(4) NOT NULL DEFAULT 0,
  `is_suspension_reason` tinyint(1) NOT NULL DEFAULT 0,
  `note` text NOT NULL,
  `container_id` int(10) unsigned NOT NULL DEFAULT 0,
  `notetype` varchar(45) NOT NULL DEFAULT 'order',
  `important` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `date_time` (`date_time`),
  KEY `fk_company_assertions_acct` (`acct_id`),
  KEY `fk_company_assertions_order` (`order_id`),
  KEY `fk_company_assertions_companies` (`company_id`),
  KEY `fk_company_assertions_domains` (`domain_id`),
  KEY `fk_company_assertions_reissues` (`reissue_id`),
  KEY `staff_id` (`staff_id`),
  KEY `container_id` (`container_id`)
) ENGINE=InnoDB AUTO_INCREMENT=28420045 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `notifications` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `staff_id` int(11) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `notification` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `npi` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `npi` varchar(10) NOT NULL,
  `verified_contact_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `company_id` int(11) DEFAULT NULL,
  `acct_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `acct_id` (`acct_id`,`npi`)
) ENGINE=InnoDB AUTO_INCREMENT=670 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `nrnotes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(8) unsigned zerofill DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `note` text DEFAULT NULL,
  `staff_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `date_index` (`date`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=463645 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `oem_accounts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `account_id` int(10) unsigned NOT NULL,
  `account_type` varchar(45) DEFAULT NULL,
  `oem_account_id` varchar(45) DEFAULT NULL,
  `master_account_id` int(10) DEFAULT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'inactive',
  `migrated_date` timestamp NULL DEFAULT NULL,
  `auto_import_certificates` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `migration_complete` tinyint(1) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_account_id` (`account_id`),
  KEY `idx_oem_master_account_id` (`oem_account_id`,`master_account_id`),
  KEY `idx_account_status` (`status`),
  KEY `idx_migration_complete` (`migration_complete`)
) ENGINE=InnoDB AUTO_INCREMENT=1244384 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `oem_order_migration_queue` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` int(10) unsigned NOT NULL,
  `date_created` datetime NOT NULL DEFAULT current_timestamp(),
  `start_time` datetime DEFAULT NULL,
  `completed_time` datetime DEFAULT NULL,
  `orders_migrated` int(10) unsigned NOT NULL DEFAULT 0,
  `exception_thrown` tinyint(4) NOT NULL DEFAULT 0,
  `total_pages` int(11) NOT NULL DEFAULT 0,
  `current_page` int(11) NOT NULL DEFAULT 0,
  `last_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `start_on_page` int(11) NOT NULL DEFAULT 0,
  `bookmark` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `ix_date_created` (`date_created`),
  KEY `ix_account` (`account_id`),
  KEY `ix_completed` (`completed_time`)
) ENGINE=InnoDB AUTO_INCREMENT=3101834 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `oem_orgs_sent_to_validation` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `organization_id` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2954 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `orders` (
  `id` int(8) unsigned zerofill NOT NULL,
  `last_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `po_id` int(4) unsigned zerofill NOT NULL DEFAULT 0000,
  `reseller_id` int(6) unsigned zerofill NOT NULL DEFAULT 000000,
  `user_id` int(11) unsigned DEFAULT 0,
  `company_id` int(11) NOT NULL DEFAULT 0,
  `domain_id` int(11) NOT NULL DEFAULT 0,
  `common_name` varchar(255) NOT NULL DEFAULT '',
  `org_unit` varchar(255) NOT NULL,
  `org_contact_id` int(11) NOT NULL DEFAULT 0,
  `tech_contact_id` int(11) NOT NULL DEFAULT 0,
  `product_id` int(11) DEFAULT NULL,
  `trial` tinyint(4) NOT NULL DEFAULT 0,
  `origin` enum('retail','enterprise') DEFAULT 'retail',
  `value` decimal(10,2) DEFAULT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 1,
  `reason` tinyint(4) NOT NULL DEFAULT 1,
  `date_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `lifetime` tinyint(4) NOT NULL DEFAULT 0,
  `servers` int(4) NOT NULL DEFAULT 0,
  `addons` varchar(255) NOT NULL,
  `csr` text NOT NULL,
  `serversw` smallint(5) NOT NULL DEFAULT 0,
  `pay_type` varchar(4) NOT NULL DEFAULT '1',
  `do_not_charge_cc` tinyint(4) DEFAULT 0,
  `ca_order_id` int(11) NOT NULL DEFAULT 0,
  `ca_apply_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `ca_status` smallint(6) NOT NULL DEFAULT 0,
  `ca_collect_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `ca_error_msg` varchar(255) NOT NULL DEFAULT '',
  `valid_from` date NOT NULL DEFAULT '0000-00-00',
  `valid_till` date NOT NULL DEFAULT '0000-00-00',
  `short_issue` date NOT NULL DEFAULT '0000-00-00',
  `extra_days` int(11) NOT NULL,
  `serial_number` varchar(128) NOT NULL,
  `is_renewed` tinyint(1) NOT NULL DEFAULT 0,
  `renewed_order_id` int(8) unsigned zerofill NOT NULL DEFAULT 00000000,
  `is_first_order` tinyint(1) NOT NULL DEFAULT 0,
  `upgrade` tinyint(4) NOT NULL DEFAULT 0,
  `flag` tinyint(1) NOT NULL DEFAULT 0,
  `send_minus_104` tinyint(1) DEFAULT 1,
  `send_minus_90` tinyint(1) NOT NULL DEFAULT 0,
  `send_minus_60` tinyint(1) NOT NULL DEFAULT 1,
  `send_minus_30` tinyint(1) NOT NULL DEFAULT 1,
  `send_minus_7` tinyint(1) NOT NULL DEFAULT 1,
  `send_minus_3` tinyint(1) DEFAULT 1,
  `send_plus_7` tinyint(1) NOT NULL DEFAULT 1,
  `make_renewal_calls` tinyint(1) NOT NULL DEFAULT 1,
  `minus_104_sent` tinyint(1) DEFAULT 0,
  `minus_90_sent` tinyint(1) NOT NULL DEFAULT 0,
  `minus_60_sent` tinyint(1) NOT NULL DEFAULT 0,
  `minus_30_sent` tinyint(1) NOT NULL DEFAULT 0,
  `minus_7_sent` tinyint(1) NOT NULL DEFAULT 0,
  `minus_3_sent` tinyint(1) DEFAULT 0,
  `plus_7_sent` tinyint(1) NOT NULL DEFAULT 0,
  `send_renewal_notices` tinyint(1) NOT NULL DEFAULT 1,
  `in_progress` tinyint(1) NOT NULL DEFAULT 0,
  `comodo_submitted` tinyint(1) NOT NULL DEFAULT 0,
  `followup_status` tinyint(4) NOT NULL DEFAULT 1,
  `followup_date` date NOT NULL,
  `snooze_until` datetime DEFAULT '2000-01-01 00:00:00',
  `ip_address` varchar(15) NOT NULL DEFAULT '',
  `approved_by` int(11) NOT NULL DEFAULT 0,
  `approved_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `take_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `issuing_ca` varchar(64) NOT NULL DEFAULT 'digicertca',
  `promo_code` varchar(17) NOT NULL,
  `show_addr_on_seal` tinyint(1) NOT NULL DEFAULT 0,
  `post_order_done` tinyint(1) NOT NULL DEFAULT 0,
  `stat_row_id` int(11) NOT NULL DEFAULT 0,
  `names_stat_row_id` int(11) NOT NULL DEFAULT 0,
  `test_order` tinyint(1) NOT NULL DEFAULT 0,
  `hide` tinyint(1) NOT NULL DEFAULT 0,
  `vip` tinyint(1) NOT NULL DEFAULT 0,
  `ca_cert_id` smallint(4) NOT NULL DEFAULT 33,
  `plus_feature` tinyint(4) DEFAULT 0,
  `whois_status` tinyint(4) NOT NULL DEFAULT 0,
  `mark_audit` tinyint(1) NOT NULL DEFAULT 0,
  `internal_audit` int(10) unsigned DEFAULT 0,
  `internal_audit_date` datetime DEFAULT NULL,
  `receipt_id` int(10) NOT NULL DEFAULT 0,
  `root_path` enum('digicert','entrust','cybertrust','comodo') DEFAULT 'digicert',
  `root_path_orig` enum('digicert','entrust','cybertrust','comodo') DEFAULT 'digicert',
  `order_options` set('hide_street_address','easy_ev','renew_90_days','auto_renew','show_street_address') DEFAULT NULL,
  `timezone_id` smallint(6) NOT NULL DEFAULT 0,
  `risk_score` smallint(5) unsigned DEFAULT NULL,
  `agreement_id` int(10) unsigned NOT NULL DEFAULT 0,
  `cs_provisioning_method` enum('none','ship_token','client_app','email','api') NOT NULL DEFAULT 'none',
  `checklist_modifiers` varchar(30) NOT NULL,
  `signature_hash` enum('sha1','sha256','sha384','sha512') NOT NULL DEFAULT 'sha1',
  `reached` tinyint(4) NOT NULL DEFAULT 0,
  `gtld_status` tinyint(3) unsigned DEFAULT NULL,
  `certificate_tracker_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `po_id` (`po_id`),
  KEY `reselling_partner_id` (`reseller_id`),
  KEY `domain_id` (`domain_id`),
  KEY `org_contact_id` (`org_contact_id`),
  KEY `product_id` (`product_id`),
  KEY `status` (`status`),
  KEY `reason` (`reason`),
  KEY `date_time` (`date_time`),
  KEY `serversw` (`serversw`),
  KEY `renewed_order_id` (`renewed_order_id`),
  KEY `flag` (`flag`),
  KEY `stat_row_id` (`stat_row_id`),
  KEY `followup_date` (`followup_date`),
  KEY `orders_send_renewal_notices` (`send_renewal_notices`),
  KEY `orders_valid_till` (`valid_till`),
  KEY `order_serial` (`serial_number`(10)),
  KEY `orders_user_id` (`user_id`),
  KEY `orders_snooze` (`snooze_until`),
  KEY `orders_company_id` (`company_id`),
  KEY `in_progress` (`in_progress`),
  KEY `receipt_id` (`receipt_id`),
  KEY `last_updated` (`last_updated`),
  KEY `orders_valid_from` (`valid_from`),
  KEY `certificate_tracker_id` (`certificate_tracker_id`),
  KEY `orders_approved_by` (`approved_by`),
  KEY `common_name` (`common_name`(14))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `orders_declined` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `acct_id` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `common_name` varchar(200) DEFAULT NULL,
  `visible` tinyint(4) NOT NULL DEFAULT 1,
  `suspicious` enum('stolen_or_lost','bank_has_questions','general_decline','') DEFAULT '',
  `ip_address` varchar(15) DEFAULT '',
  `ip_address_int` int(10) unsigned DEFAULT NULL,
  `cc_error_msg` varchar(255) DEFAULT '',
  `cc_info` varchar(16) NOT NULL DEFAULT '',
  `note` text DEFAULT NULL,
  `note_timestamp` datetime DEFAULT NULL,
  `note_staff_id` int(11) DEFAULT NULL,
  `session_info` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ip_address` (`ip_address`),
  KEY `visible` (`visible`),
  KEY `acct_id` (`acct_id`),
  KEY `cc_error_msg` (`cc_error_msg`(32)),
  KEY `common_name` (`common_name`(12))
) ENGINE=InnoDB AUTO_INCREMENT=1329756 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_action_queue` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `container_id` int(10) unsigned NOT NULL,
  `date_created` datetime NOT NULL,
  `order_tracker_id` int(10) unsigned NOT NULL,
  `action_type` tinyint(3) unsigned NOT NULL,
  `action_status` tinyint(3) unsigned NOT NULL,
  `requester_user_id` int(10) unsigned NOT NULL,
  `reviewer_user_id` int(10) unsigned NOT NULL DEFAULT 0,
  `processor_user_id` int(10) unsigned DEFAULT NULL,
  `date_processed` datetime DEFAULT NULL,
  `certificate_id` int(10) unsigned DEFAULT NULL,
  `comments` varchar(255) DEFAULT NULL,
  `processor_comment` varchar(255) DEFAULT NULL,
  `guest_requester_first_name` varchar(255) DEFAULT NULL,
  `guest_requester_last_name` varchar(255) DEFAULT NULL,
  `guest_requester_email` varchar(255) DEFAULT NULL,
  `date_reviewed` datetime DEFAULT NULL,
  `order_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_container_id_action_status` (`container_id`,`action_status`),
  KEY `ix_order_tracker_id` (`order_tracker_id`),
  KEY `action_status` (`action_status`),
  KEY `ix_requester_user_id` (`requester_user_id`),
  KEY `ix_order_id` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11491497 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_api_key_map` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(10) unsigned NOT NULL,
  `api_permission_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_order_id` (`order_id`),
  KEY `idx_api_permission_id` (`api_permission_id`)
) ENGINE=InnoDB AUTO_INCREMENT=112426760 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_approvals` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(8) unsigned zerofill NOT NULL,
  `reissue_id` int(11) NOT NULL DEFAULT 0,
  `verified_contact_id` int(10) unsigned NOT NULL,
  `date_time` datetime NOT NULL,
  `ip_address` varchar(15) NOT NULL,
  `order_details` text NOT NULL,
  `origin` enum('email','phone') NOT NULL DEFAULT 'email',
  `staff_id` int(11) NOT NULL DEFAULT 0,
  `staff_note` text NOT NULL,
  `status` enum('active','inactive') DEFAULT 'active',
  `verified_contact_snapshot_id` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `verified_contact_id` (`verified_contact_id`),
  KEY `status` (`status`),
  KEY `verified_contact_snapshot_id` (`verified_contact_snapshot_id`),
  KEY `reissue_id` (`reissue_id`)
) ENGINE=InnoDB AUTO_INCREMENT=763143 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_approvals_oem` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cert_id` varchar(32) NOT NULL,
  `verified_contact_id` int(10) unsigned NOT NULL,
  `date_time` datetime NOT NULL,
  `ip_address` varchar(15) NOT NULL,
  `origin` enum('email','phone') NOT NULL DEFAULT 'email',
  `order_approvals_oem_invite_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cert_id_idx` (`cert_id`)
) ENGINE=InnoDB AUTO_INCREMENT=18222 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_approvals_oem_delegation` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `organization_id` int(10) unsigned NOT NULL,
  `verified_contact_id` int(10) unsigned NOT NULL,
  `created_by_staff_id` int(10) unsigned NOT NULL,
  `date_created` datetime NOT NULL,
  `note` text DEFAULT NULL,
  `ip_address` varchar(255) DEFAULT NULL,
  `approver_name` varchar(130) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_verified_contact_id` (`verified_contact_id`),
  KEY `idx_organization_id` (`organization_id`)
) ENGINE=InnoDB AUTO_INCREMENT=87953 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_approvals_oem_delegation_invites` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `organization_id` int(10) unsigned NOT NULL,
  `verified_contact_id` int(10) unsigned NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `sent_by_staff_id` int(10) unsigned NOT NULL,
  `date_sent` datetime NOT NULL,
  `order_approvals_oem_delegation_id` int(11) DEFAULT NULL,
  `token` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_verified_contact_id` (`verified_contact_id`)
) ENGINE=InnoDB AUTO_INCREMENT=49537 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_approvals_oem_invites` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cert_id` varchar(32) NOT NULL,
  `verified_contact_id` int(10) unsigned NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `sent_by_staff_id` int(10) unsigned DEFAULT NULL,
  `date_sent` datetime NOT NULL,
  `token` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cert_id_idx` (`cert_id`)
) ENGINE=InnoDB AUTO_INCREMENT=46084 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_benefits` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(10) unsigned NOT NULL,
  `actual_price` decimal(10,2) DEFAULT 0.00,
  `discount_percent` decimal(5,2) DEFAULT 0.00,
  `validity_benefit_days` smallint(5) unsigned DEFAULT NULL,
  `benefits` text DEFAULT NULL,
  `benefits_data` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_order_id` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1128 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_cert_transparency` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(10) unsigned DEFAULT NULL,
  `date_disabled` datetime DEFAULT NULL,
  `date_enabled` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=920036 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_checkmarks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(10) unsigned NOT NULL,
  `reissue_id` int(10) unsigned DEFAULT NULL,
  `checkmark_id` int(10) unsigned NOT NULL,
  `date_created` datetime NOT NULL,
  `checklist_step_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_checkmarks_order_id_idx` (`order_id`),
  KEY `order_checkmarks_checkmark_id_idx` (`checkmark_id`)
) ENGINE=InnoDB AUTO_INCREMENT=538858219 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_common_names_snapshots` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `order_id` int(10) unsigned NOT NULL,
  `reissue_id` int(10) unsigned DEFAULT NULL,
  `common_name_id` int(10) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `is_common_name` tinyint(1) NOT NULL DEFAULT 0,
  `active` tinyint(1) DEFAULT NULL,
  `domain_id` int(10) unsigned DEFAULT NULL,
  `approve_id` int(10) unsigned DEFAULT NULL,
  `status` enum('active','inactive','pending') DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_common_names_snapshots_order_id_idx` (`order_id`),
  KEY `domain_id` (`domain_id`),
  KEY `common_name_id` (`common_name_id`)
) ENGINE=InnoDB AUTO_INCREMENT=99331949 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_company_snapshots` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `order_id` int(10) unsigned NOT NULL,
  `reissue_id` int(10) unsigned DEFAULT NULL,
  `company_id` int(10) unsigned NOT NULL,
  `acct_id` int(6) unsigned DEFAULT NULL,
  `org_contact_id` int(11) DEFAULT NULL,
  `tech_contact_id` int(11) DEFAULT NULL,
  `bill_contact_id` int(11) DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `ev_status` tinyint(4) DEFAULT NULL,
  `org_name` varchar(255) DEFAULT NULL,
  `org_type` int(10) DEFAULT NULL,
  `org_assumed_name` varchar(255) DEFAULT NULL,
  `org_unit` varchar(64) DEFAULT NULL,
  `org_addr1` varchar(128) DEFAULT NULL,
  `org_addr2` varchar(128) DEFAULT NULL,
  `org_zip` varchar(40) DEFAULT NULL,
  `org_city` varchar(128) DEFAULT NULL,
  `org_state` varchar(128) DEFAULT NULL,
  `org_country` varchar(2) DEFAULT NULL,
  `org_email` varchar(128) DEFAULT NULL,
  `telephone` varchar(32) DEFAULT NULL,
  `org_reg_num` varchar(200) DEFAULT NULL,
  `jur_city` varchar(128) DEFAULT NULL,
  `jur_state` varchar(128) DEFAULT NULL,
  `jur_country` varchar(2) DEFAULT NULL,
  `incorp_agency` varchar(255) DEFAULT NULL,
  `master_agreement_sent` tinyint(1) DEFAULT NULL,
  `locked` tinyint(1) DEFAULT NULL,
  `validated_until` datetime DEFAULT NULL,
  `ov_validated_until` datetime DEFAULT NULL,
  `ev_validated_until` datetime DEFAULT NULL,
  `active` tinyint(4) DEFAULT 1,
  `public_phone` varchar(32) DEFAULT NULL,
  `public_email` varchar(128) DEFAULT NULL,
  `ascii_name` varchar(255) DEFAULT NULL,
  `address_validated_date` datetime DEFAULT NULL,
  `incorp_agency_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_company_snapshots_order_id_idx` (`order_id`),
  KEY `ix_company_id` (`company_id`),
  KEY `idx_account_id` (`acct_id`),
  KEY `incorp_agency_id` (`incorp_agency_id`)
) ENGINE=InnoDB AUTO_INCREMENT=34038823 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_duplicates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(8) unsigned zerofill NOT NULL DEFAULT 00000000,
  `sub_id` int(3) unsigned zerofill NOT NULL DEFAULT 000,
  `ca_order_id` varchar(18) NOT NULL,
  `date_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `staff_id` int(11) NOT NULL DEFAULT 0,
  `status` tinyint(4) NOT NULL DEFAULT 1,
  `collected` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `serial_number` varchar(128) NOT NULL,
  `csr` text NOT NULL,
  `serversw` smallint(5) NOT NULL DEFAULT 0,
  `sans` text NOT NULL,
  `common_name` varchar(255) NOT NULL,
  `org_unit` varchar(100) DEFAULT NULL,
  `ca_cert_id` smallint(6) NOT NULL DEFAULT 33,
  `revoked` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `hidden` tinyint(4) DEFAULT 0,
  `thumbprint` varchar(40) DEFAULT '',
  `customer_note` text DEFAULT NULL,
  `signature_hash` enum('sha1','sha256','sha384','sha512') NOT NULL DEFAULT 'sha1',
  `root_path` enum('digicert','entrust','cybertrust','comodo') NOT NULL DEFAULT 'entrust',
  `data_encipherment` tinyint(4) NOT NULL DEFAULT 0,
  `string_type` enum('PS','T61','UTF8','AUTO') NOT NULL DEFAULT 'AUTO',
  `in_progress` tinyint(1) NOT NULL DEFAULT 0,
  `certificate_tracker_id` int(10) unsigned DEFAULT NULL,
  `csr_key_type` varchar(3) NOT NULL DEFAULT '',
  `request_id` int(11) DEFAULT NULL,
  `type` set('other','encryption','signing') DEFAULT 'other',
  `user_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `addl_uc_order_id` (`order_id`),
  KEY `addl_uc_hidden` (`hidden`),
  KEY `collected_index` (`collected`),
  KEY `certificate_tracker_id` (`certificate_tracker_id`),
  KEY `request_id` (`request_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1406710 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_extras` (
  `order_id` int(8) unsigned zerofill NOT NULL,
  `asa_option` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `unit_id` int(10) unsigned NOT NULL DEFAULT 0,
  `allow_unit_access` tinyint(1) NOT NULL DEFAULT 0,
  `thumbprint` varchar(40) DEFAULT '',
  `ent_check1_staff_id` int(11) DEFAULT NULL,
  `ent_check2_staff_id` int(11) DEFAULT NULL,
  `additional_emails` text DEFAULT NULL,
  `wildcard_sans` text DEFAULT NULL,
  `dc_guid` varchar(64) NOT NULL DEFAULT '',
  `key_usage` varchar(96) NOT NULL DEFAULT '',
  `show_phone` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `show_email` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `show_address` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `cert_registration_number` varchar(128) NOT NULL,
  `is_out_of_contract` tinyint(1) NOT NULL DEFAULT 0,
  `direct_hipaa_type` enum('covered','associate','other') DEFAULT NULL,
  `wifi_option` enum('logo','friendlyname','both') DEFAULT NULL,
  `service_name` varchar(32) NOT NULL DEFAULT '',
  `ssl_profile_option` varchar(32) NOT NULL DEFAULT '',
  `subject_email` varchar(128) NOT NULL DEFAULT '',
  `custom_renewal_message` text DEFAULT NULL,
  `disable_renewal_notifications` tinyint(1) NOT NULL DEFAULT 0,
  `disable_issuance_email` tinyint(3) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`order_id`),
  KEY `ent_check1_staff_id` (`ent_check1_staff_id`),
  KEY `ent_check2_staff_id` (`ent_check2_staff_id`),
  KEY `unit_id` (`unit_id`),
  KEY `is_out_of_contract` (`is_out_of_contract`),
  KEY `idx_disable_renewal_notifications` (`disable_renewal_notifications`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_guest_access` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` int(10) unsigned NOT NULL,
  `order_id` int(10) unsigned NOT NULL,
  `fqdn` varchar(256) NOT NULL,
  `date_created` datetime NOT NULL,
  `email` varchar(256) NOT NULL,
  `hashkey` varchar(128) NOT NULL,
  `fqdn_linked_orders` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25272 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_high_risk_clues_map` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `high_risk_clues_id` int(11) DEFAULT NULL,
  `order_id` int(11) DEFAULT NULL,
  `reference_id` int(11) DEFAULT NULL,
  `reason_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `origin` enum('DigiCert','other') DEFAULT 'DigiCert',
  PRIMARY KEY (`id`),
  KEY `high_risk_clues_id` (`high_risk_clues_id`),
  KEY `order_id` (`order_id`,`reference_id`)
) ENGINE=InnoDB AUTO_INCREMENT=675 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_iceberg` (
  `order_id` int(8) unsigned zerofill NOT NULL DEFAULT 00000000,
  `json` text DEFAULT NULL,
  `incoming_email_sent` tinyint(4) NOT NULL DEFAULT 0,
  `issuance_email_sent` tinyint(4) NOT NULL DEFAULT 0,
  `insert_date` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_ids` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=125139768 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_installer_token` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `token` varchar(45) NOT NULL,
  `order_id` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `sub_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_token` (`token`),
  KEY `idx_order_id` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13382179 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_install_notes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(10) unsigned NOT NULL,
  `date_time` datetime DEFAULT NULL,
  `install_status` varchar(50) DEFAULT NULL,
  `install_data` text DEFAULT NULL,
  `staff_id` int(11) DEFAULT NULL,
  `staff_note` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7501390 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_install_status` (
  `order_id` int(10) unsigned NOT NULL,
  `install_status` varchar(40) DEFAULT 'unchecked',
  `followup_status` enum('pending','complete') NOT NULL DEFAULT 'pending',
  `date_last_checked` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `snooze_until` datetime DEFAULT NULL,
  `sent_email` tinyint(4) DEFAULT NULL,
  `extra_info` text DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  KEY `install_status` (`install_status`),
  KEY `followup_status` (`followup_status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_metadata` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `order_id` int(10) unsigned NOT NULL,
  `metadata_id` int(10) unsigned NOT NULL,
  `value` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_item_metadata_id` (`order_id`,`metadata_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3095254 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_origin_cookies` (
  `order_id` int(10) unsigned NOT NULL,
  `acct_id` int(10) unsigned DEFAULT NULL,
  `origin` varchar(255) DEFAULT NULL,
  `date_recorded` datetime DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  KEY `acct_id` (`acct_id`),
  KEY `date_recorded` (`date_recorded`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_pay_types` (
  `id` tinyint(4) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL DEFAULT '',
  `nb_abbr` varchar(8) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_price_computation` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(10) unsigned NOT NULL,
  `account_id` int(10) unsigned NOT NULL,
  `actual_price` decimal(10,2) DEFAULT 0.00,
  `computed_price` decimal(10,2) DEFAULT 0.00,
  `revenue` decimal(12,2) DEFAULT 0.00,
  PRIMARY KEY (`id`),
  KEY `ix_order_id` (`order_id`),
  KEY `ix_account_id` (`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9619012 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_price_recalculation` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` int(10) unsigned NOT NULL,
  `created` datetime NOT NULL DEFAULT current_timestamp(),
  `start_time` datetime DEFAULT NULL,
  `completed_time` datetime DEFAULT NULL,
  `orders_updated` int(10) unsigned NOT NULL DEFAULT 0,
  `status` enum('pending','running','completed','incomplete','stopped') NOT NULL DEFAULT 'pending',
  `last_updated_order` int(10) unsigned NOT NULL DEFAULT 0,
  `last_update_time` datetime DEFAULT current_timestamp(),
  `generate_report` tinyint(4) DEFAULT 0,
  `from_date` date DEFAULT curdate(),
  `to_date` date DEFAULT curdate(),
  PRIMARY KEY (`id`),
  KEY `idx_status` (`status`),
  KEY `idx_account_id` (`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=252 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_renewal_notices` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(10) unsigned NOT NULL,
  `minus_90_sent` tinyint(1) NOT NULL DEFAULT 0,
  `minus_60_sent` tinyint(1) NOT NULL DEFAULT 0,
  `minus_30_sent` tinyint(1) NOT NULL DEFAULT 0,
  `minus_7_sent` tinyint(1) NOT NULL DEFAULT 0,
  `minus_3_sent` tinyint(1) NOT NULL DEFAULT 0,
  `plus_7_sent` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_order_id` (`order_id`),
  KEY `ix_minus_90_sent` (`minus_90_sent`),
  KEY `ix_minus_60_sent` (`minus_60_sent`),
  KEY `ix_minus_30_sent` (`minus_30_sent`),
  KEY `ix_minus_7_sent` (`minus_7_sent`),
  KEY `ix_minus_3_sent` (`minus_3_sent`),
  KEY `ix_plus_7_sent` (`plus_7_sent`)
) ENGINE=InnoDB AUTO_INCREMENT=16998435 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_renewal_stats` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(10) unsigned DEFAULT NULL,
  `ctime` timestamp NOT NULL DEFAULT '2000-01-01 07:00:00',
  `mtime` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `renewal_disposition` enum('renewed_with_us','still_has_our_expired_cert','competitor_cert','doesnt_resolve','unable_to_connect','no_certificate_found','invalid_name','private_ip','self_signed_cert','untrusted_or_unknown_ca','') NOT NULL DEFAULT '',
  `product_id` int(11) DEFAULT NULL,
  `valid_till` date NOT NULL DEFAULT '0000-00-00',
  `new_order_id` int(8) unsigned zerofill NOT NULL,
  `new_acct_id` int(6) unsigned zerofill NOT NULL DEFAULT 000000,
  `new_valid_from` date NOT NULL DEFAULT '0000-00-00',
  `new_valid_till` date NOT NULL DEFAULT '0000-00-00',
  `new_issuer_name` varchar(64) NOT NULL DEFAULT '',
  `new_ca_group` varchar(64) NOT NULL DEFAULT '',
  `new_product_type` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `order_id` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17231001 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_request` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `order_tracker_id` int(10) unsigned NOT NULL,
  `order_action_queue_id` int(10) unsigned NOT NULL,
  `status` tinyint(3) unsigned NOT NULL,
  `reason` tinyint(3) unsigned NOT NULL,
  `product_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `organization_id` int(10) unsigned NOT NULL,
  `agreement_id` int(10) unsigned NOT NULL,
  `cert_profile_id` int(10) unsigned DEFAULT NULL,
  `organization_unit` varchar(255) DEFAULT NULL,
  `lifetime` int(10) unsigned NOT NULL,
  `csr` text DEFAULT NULL,
  `common_name` varchar(255) NOT NULL,
  `dns_names` text NOT NULL,
  `server_platform_id` int(11) DEFAULT NULL,
  `ip_address` varchar(15) DEFAULT NULL,
  `ca_cert_id` int(10) unsigned DEFAULT NULL,
  `signature_hash` varchar(15) NOT NULL,
  `key_size` smallint(5) unsigned DEFAULT NULL,
  `root_path` varchar(20) NOT NULL,
  `email` varchar(1024) DEFAULT NULL,
  `origin` varchar(30) DEFAULT NULL,
  `service_name` varchar(150) DEFAULT NULL,
  `custom_expiration_date` datetime DEFAULT NULL,
  `renewal_of_order_id` int(11) DEFAULT NULL,
  `extra_input` text DEFAULT NULL,
  `cs_provisioning_method` varchar(15) NOT NULL DEFAULT 'none',
  `addons` varchar(255) DEFAULT NULL,
  `auto_renew` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `additional_emails` text DEFAULT NULL,
  `user_assignments` varchar(255) DEFAULT NULL,
  `promo_code` varchar(100) DEFAULT NULL,
  `receipt_id` int(11) DEFAULT NULL,
  `is_out_of_contract` tinyint(3) NOT NULL DEFAULT 0,
  `disable_renewal_notifications` tinyint(1) NOT NULL DEFAULT 0,
  `order_validation_notes` varchar(2000) DEFAULT NULL,
  `disable_issuance_email` tinyint(3) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `ix_order_tracker_id` (`order_tracker_id`),
  KEY `order_action_queue_id` (`order_action_queue_id`),
  KEY `idx_renewal_of_order_id` (`renewal_of_order_id`),
  KEY `receipt_id` (`receipt_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10550915 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_request_extras` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `order_request_id` int(10) unsigned NOT NULL,
  `ship_name` varchar(128) DEFAULT NULL,
  `ship_addr1` varchar(128) DEFAULT NULL,
  `ship_addr2` varchar(128) DEFAULT NULL,
  `ship_city` varchar(128) DEFAULT NULL,
  `ship_state` varchar(128) DEFAULT NULL,
  `ship_zip` varchar(40) DEFAULT NULL,
  `ship_country` varchar(128) DEFAULT NULL,
  `ship_method` enum('STANDARD','EXPEDITED') DEFAULT NULL,
  `subject_name` varchar(150) DEFAULT NULL,
  `subject_job_title` varchar(150) DEFAULT NULL,
  `subject_phone` varchar(150) DEFAULT NULL,
  `subject_email` varchar(150) DEFAULT NULL,
  `custom_renewal_message` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_order_request_id` (`order_request_id`)
) ENGINE=InnoDB AUTO_INCREMENT=110675 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_status_map` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `status_id` int(10) unsigned NOT NULL,
  `reason_id` int(10) unsigned NOT NULL,
  `customer_order_status` varchar(32) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_status_reason` (`status_id`,`reason_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_tor_service_descriptors` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(10) unsigned NOT NULL,
  `uri` varchar(2048) NOT NULL,
  `public_key` text NOT NULL,
  `date_created` datetime NOT NULL,
  `staff_id_created_by` int(10) unsigned NOT NULL,
  `date_deleted` datetime NOT NULL,
  `staff_id_deleted_by` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=455 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_tracker` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `container_id` int(10) unsigned DEFAULT NULL,
  `order_id` int(10) unsigned NOT NULL,
  `type` tinyint(3) unsigned NOT NULL,
  `product_name_id` varchar(64) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `order_id` (`order_id`),
  KEY `ix_order_id` (`order_id`),
  KEY `ix_container_id` (`container_id`)
) ENGINE=InnoDB AUTO_INCREMENT=125754161 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_transaction` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `container_id` int(10) unsigned NOT NULL,
  `order_id` int(10) unsigned NOT NULL,
  `receipt_id` int(10) unsigned DEFAULT NULL,
  `acct_adjust_id` int(10) unsigned DEFAULT NULL,
  `po_id` int(10) unsigned DEFAULT NULL,
  `amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `payment_type` varchar(50) NOT NULL,
  `transaction_date` datetime NOT NULL,
  `transaction_type` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_container_id` (`container_id`),
  KEY `ix_order_id` (`order_id`),
  KEY `ix_receipt_id` (`receipt_id`),
  KEY `ix_acct_adjust_id` (`acct_adjust_id`)
) ENGINE=InnoDB AUTO_INCREMENT=119571130 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `date_added` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`,`user_id`),
  KEY `idx_user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=118441989 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_verified_contacts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(8) unsigned zerofill NOT NULL,
  `verified_contact_id` int(11) NOT NULL,
  `checklist_role_ids` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `order_verified_contact_id` (`order_id`,`verified_contact_id`),
  KEY `verified_contact_id` (`verified_contact_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19200709 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_verified_contacts_snapshots` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `order_id` int(8) unsigned NOT NULL DEFAULT 0,
  `reissue_id` int(10) unsigned NOT NULL DEFAULT 0,
  `verified_contact_id` int(10) unsigned NOT NULL,
  `status` enum('pending','active','inactive') NOT NULL DEFAULT 'pending',
  `user_id` int(10) NOT NULL,
  `company_id` int(11) NOT NULL,
  `firstname` varchar(64) NOT NULL,
  `lastname` varchar(64) NOT NULL,
  `email` varchar(255) NOT NULL,
  `job_title` varchar(64) NOT NULL,
  `telephone` varchar(32) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `order_id_idx` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=18111911 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_verified_emails` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(6) unsigned zerofill NOT NULL,
  `verified_contact_id` int(10) unsigned NOT NULL,
  `date_verified` datetime DEFAULT NULL,
  `cert_common_name` varchar(64) NOT NULL DEFAULT '',
  `email` varchar(128) NOT NULL DEFAULT '',
  `ip_address` varchar(15) NOT NULL DEFAULT '',
  `status` enum('active','inactive') DEFAULT 'active',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4131 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_wifi_friendly_names` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL,
  `friendlyname_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1367 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `order_wifi_logos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(10) unsigned NOT NULL,
  `language` char(3) NOT NULL,
  `uri` text NOT NULL,
  `doc_id` int(10) unsigned DEFAULT NULL,
  `content_type` varchar(100) DEFAULT NULL,
  `date_retrieved` timestamp NULL DEFAULT NULL,
  `date_created` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1367 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `organization_contact_snapshots` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `verified_contact_id` int(10) unsigned DEFAULT NULL,
  `checklist_id` int(10) unsigned DEFAULT NULL,
  `organization_id` int(10) unsigned DEFAULT NULL,
  `snapshot_data` blob DEFAULT NULL,
  `snapshot_date` datetime DEFAULT NULL,
  `snapshot_br_version` varchar(32) DEFAULT NULL,
  `contact_valid_from` datetime DEFAULT NULL,
  `doc_valid_from` datetime DEFAULT NULL,
  `snapshot_checklist_version` varchar(16) DEFAULT NULL,
  `max_validity_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_org_checklist` (`verified_contact_id`,`checklist_id`),
  KEY `idx_verified_contact_id` (`verified_contact_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3045554 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `organization_container_assignments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `organization_id` int(11) NOT NULL,
  `container_id` int(11) NOT NULL,
  `date_created` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_organization_id` (`organization_id`),
  KEY `idx_container_id` (`container_id`)
) ENGINE=InnoDB AUTO_INCREMENT=126947 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `organization_logo` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL DEFAULT current_timestamp(),
  `organization_id` int(10) unsigned NOT NULL,
  `logo` mediumtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_org_id` (`organization_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `organization_metadata` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `organization_id` int(11) DEFAULT NULL,
  `brand` varchar(256) DEFAULT NULL,
  `context_data` varchar(256) DEFAULT NULL,
  `locale` varchar(5) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `customer_comment_template` varchar(255) DEFAULT NULL,
  `customer_comment_lang` varchar(5) DEFAULT NULL,
  `customer_comment_date` datetime DEFAULT NULL,
  `customer_comment` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_organization` (`organization_id`)
) ENGINE=InnoDB AUTO_INCREMENT=410278 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `organization_snapshots` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `organization_id` int(10) unsigned DEFAULT NULL,
  `checklist_id` int(10) unsigned DEFAULT NULL,
  `snapshot_data` blob DEFAULT NULL,
  `snapshot_date` datetime DEFAULT NULL,
  `snapshot_br_version` varchar(32) DEFAULT NULL,
  `org_valid_from` datetime DEFAULT NULL,
  `doc_valid_from` datetime DEFAULT NULL,
  `snapshot_checklist_version` varchar(16) DEFAULT NULL,
  `max_validity_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_org_checklist` (`organization_id`,`checklist_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2917340 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `organization_validation_cache` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `organization_id` int(11) DEFAULT NULL,
  `checklist_id` int(11) DEFAULT NULL,
  `valid_from` date DEFAULT NULL,
  `valid_until` date DEFAULT NULL,
  `date_created` datetime DEFAULT current_timestamp(),
  `last_updated` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_org_checklist` (`organization_id`,`checklist_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1568283 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `org_types` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `ou_account_exemptions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` int(10) unsigned NOT NULL,
  `date_created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_account_id` (`account_id`) USING HASH
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `ou_blacklist` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` int(10) unsigned NOT NULL DEFAULT 0,
  `ou_value` varchar(128) NOT NULL,
  `staff_id` int(11) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_account_ou` (`account_id`,`ou_value`)
) ENGINE=InnoDB AUTO_INCREMENT=10195 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `ou_whitelist` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` int(10) unsigned NOT NULL,
  `ou_value` varchar(128) NOT NULL,
  `staff_id` int(11) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `staff_id2` int(10) unsigned DEFAULT NULL,
  `note` text DEFAULT NULL,
  `document_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_account_value` (`account_id`,`ou_value`),
  KEY `ix_date_created` (`date_created`)
) ENGINE=InnoDB AUTO_INCREMENT=215860 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `payment_profiles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `gty_profile_id` varchar(32) NOT NULL,
  `cc_label` varchar(128) DEFAULT NULL,
  `cc_last4` varchar(4) DEFAULT NULL,
  `cc_exp_month` varchar(2) DEFAULT NULL,
  `cc_exp_year` varchar(4) DEFAULT NULL,
  `cc_type` enum('amex','visa','mastercard','discover','other','none') NOT NULL DEFAULT 'none',
  `bill_name` varchar(128) DEFAULT NULL,
  `bill_org_name` varchar(128) DEFAULT NULL,
  `bill_addr1` varchar(128) DEFAULT NULL,
  `bill_addr2` varchar(128) DEFAULT NULL,
  `bill_city` varchar(128) DEFAULT NULL,
  `bill_state` varchar(128) DEFAULT NULL,
  `bill_zip` varchar(40) DEFAULT NULL,
  `bill_country` varchar(2) DEFAULT NULL,
  `bill_email` varchar(255) DEFAULT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 1,
  `gty_status` varchar(64) NOT NULL DEFAULT '',
  `payment_gty` varchar(32) NOT NULL DEFAULT 'cybersource',
  `date_created` datetime NOT NULL,
  `new_profile_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=91342 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `direct_group` set('view_HCO','view_users','view_requests','view_certificates','view_domains','account_settings','edit_users','edit_roles','edit_users_hco','all_HCOs','all_ISSOs','all_users','request_cert','request_address_cert','request_org_cert','request_device_cert','additional_emails','approve_requests','reject_requests','edit_requests','view_certificate','add_order_notes','delete_order_notes','view_order_notes','rekey_cert','revoke_cert','cancel_order','download_cert','view_order_duplicates','deposit_funds','view_balance') DEFAULT NULL,
  `direct_group2` set('view_documents','all_documents','upload_documents','view_balance_history','edit_self','edit_HCO','edit_ISSO','view_contacts','edit_contacts','expire_documents','download_documents','edit_contacts_hco','custom_fields','delete_hco','deactivate_hco','create_users','create_contacts','approval_rules','delete_domains','approve_domains','edit_domains','add_domains','submit_domains','resend_dcv','import','case_notes','request_fbca_address_cert') DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `permissions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=94 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `permission_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `acct_id` int(11) DEFAULT NULL,
  `permission_id` int(11) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `description` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `permission_id` (`permission_id`),
  KEY `acct_id` (`acct_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `permission_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  `type` set('grant','revoke') DEFAULT NULL,
  `level` set('group','user') DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `permission_id` (`user_id`,`permission_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=37534 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `php_sessions` (
  `s_num` varchar(32) NOT NULL,
  `s_mtime` int(11) DEFAULT NULL,
  `s_ctime` int(11) DEFAULT NULL,
  `s_data` mediumtext DEFAULT NULL,
  `s_user_type` enum('cust','staff') NOT NULL DEFAULT 'cust',
  PRIMARY KEY (`s_num`),
  KEY `php_sessions_mtime` (`s_mtime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `pki_notes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(8) unsigned zerofill DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `note` text DEFAULT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_orderid` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=57142798 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `po` (
  `id` int(4) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `acct_id` int(6) unsigned zerofill NOT NULL DEFAULT 000000,
  `flag` tinyint(4) NOT NULL DEFAULT 0,
  `status` tinyint(4) NOT NULL DEFAULT 0,
  `invoice_number` int(8) DEFAULT NULL,
  `invoice_status` tinyint(1) NOT NULL DEFAULT 1,
  `notes` text DEFAULT NULL,
  `date_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `contact_name` varchar(128) NOT NULL DEFAULT '',
  `electronic_signature` varchar(128) DEFAULT NULL,
  `email` varchar(128) NOT NULL DEFAULT '',
  `telephone` varchar(32) NOT NULL DEFAULT '',
  `telephone_ext` varchar(16) NOT NULL DEFAULT '',
  `fax` varchar(32) NOT NULL DEFAULT '',
  `org_name` varchar(128) NOT NULL DEFAULT '',
  `org_addr1` varchar(128) NOT NULL DEFAULT '',
  `org_addr2` varchar(128) NOT NULL DEFAULT '',
  `org_city` varchar(64) NOT NULL DEFAULT '',
  `org_state` varchar(64) NOT NULL DEFAULT '',
  `org_country` varchar(2) NOT NULL DEFAULT '0',
  `org_zip` varchar(10) NOT NULL DEFAULT '',
  `inv_term` int(2) DEFAULT 10,
  `inv_term_eom` tinyint(4) DEFAULT 0,
  `inv_contact_name` varchar(128) NOT NULL DEFAULT '',
  `inv_email` varchar(128) NOT NULL DEFAULT '',
  `inv_telephone` varchar(32) NOT NULL DEFAULT '',
  `inv_telephone_ext` varchar(16) NOT NULL DEFAULT '',
  `inv_fax` varchar(32) NOT NULL DEFAULT '',
  `inv_org_name` varchar(128) NOT NULL DEFAULT '',
  `inv_org_addr1` varchar(128) NOT NULL DEFAULT '',
  `inv_org_addr2` varchar(128) NOT NULL DEFAULT '',
  `inv_org_city` varchar(64) NOT NULL DEFAULT '',
  `inv_org_state` varchar(64) NOT NULL DEFAULT '',
  `inv_org_country` varchar(2) NOT NULL DEFAULT '',
  `inv_org_zip` varchar(10) NOT NULL DEFAULT '',
  `po_number` varchar(32) NOT NULL DEFAULT '',
  `amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `amount_owed` decimal(10,2) DEFAULT NULL,
  `reject_notes` varchar(255) NOT NULL DEFAULT '',
  `reject_date_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `reject_staff` int(10) unsigned NOT NULL DEFAULT 0,
  `inv_send_mail` tinyint(1) NOT NULL DEFAULT 0,
  `inv_send_fax` tinyint(1) NOT NULL DEFAULT 0,
  `invoice_sent` tinyint(1) NOT NULL DEFAULT 0,
  `hard_copy_name` varchar(128) NOT NULL DEFAULT '',
  `paid_amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `paid_date_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `send_email_reminders` tinyint(4) NOT NULL DEFAULT 1,
  `send_from` int(10) unsigned DEFAULT NULL,
  `date_last_emailed` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `unit_id` int(11) NOT NULL DEFAULT 0,
  `container_id` int(10) unsigned DEFAULT NULL,
  `is_internal` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `converted_from_quote` datetime DEFAULT NULL,
  `quote_expiration_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `status` (`status`),
  KEY `invoice_status` (`invoice_status`),
  KEY `idx_acct` (`acct_id`),
  KEY `idx_invoice_number` (`invoice_number`),
  KEY `container_id` (`container_id`)
) ENGINE=InnoDB AUTO_INCREMENT=215631 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `po_audit` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `action_id` int(10) unsigned DEFAULT NULL,
  `field_name` varchar(50) DEFAULT NULL,
  `old_value` text DEFAULT NULL,
  `new_value` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1030437 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `po_audit_action` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `po_id` int(10) unsigned DEFAULT NULL,
  `staff_id` smallint(5) unsigned NOT NULL DEFAULT 0,
  `date_dt` datetime DEFAULT NULL,
  `action_type` varchar(255) DEFAULT NULL,
  `affected_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=668575 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `po_contact` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `po_id` int(10) unsigned NOT NULL,
  `name` varchar(128) DEFAULT NULL,
  `email` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_po_id` (`po_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16408 DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `po_docs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `po_id` int(4) unsigned zerofill NOT NULL DEFAULT 0000,
  `filename` varchar(128) NOT NULL DEFAULT '',
  `ctime` datetime NOT NULL,
  `notes` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_po_id` (`po_id`)
) ENGINE=InnoDB AUTO_INCREMENT=92352 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `po_flags` (
  `id` tinyint(1) NOT NULL AUTO_INCREMENT,
  `number` tinyint(1) NOT NULL DEFAULT 0,
  `color` varchar(16) NOT NULL DEFAULT '',
  `description` varchar(128) NOT NULL DEFAULT '',
  `color_code` varchar(7) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `po_invoice_statuses` (
  `id` tinyint(4) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `po_notes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `po_id` int(8) unsigned zerofill DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `note` text DEFAULT NULL,
  `staff_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `po_notes_po_id` (`po_id`),
  KEY `date_index` (`date`)
) ENGINE=InnoDB AUTO_INCREMENT=1082493 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `po_prod` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) NOT NULL DEFAULT 0,
  `order_id` int(8) unsigned zerofill NOT NULL DEFAULT 00000000,
  `years` tinyint(1) NOT NULL DEFAULT 0,
  `servers` int(4) NOT NULL DEFAULT 0,
  `license` enum('single','unlimited') NOT NULL DEFAULT 'single',
  `po_id` int(4) unsigned zerofill NOT NULL DEFAULT 0000,
  `redeemed` tinyint(1) NOT NULL DEFAULT 0,
  `status` tinyint(4) NOT NULL DEFAULT 1,
  `amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `domain` varchar(255) NOT NULL DEFAULT '',
  `cred_amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `addl_cn_price` decimal(10,2) NOT NULL DEFAULT 0.00,
  `product_name_id` varchar(64) DEFAULT NULL,
  `purchased_wildcard_names` int(10) unsigned NOT NULL DEFAULT 0,
  `addl_wc_price` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `po_id` (`po_id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2390594 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `po_prod_addons` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `po_prod_id` int(10) unsigned NOT NULL,
  `addon_id` int(10) unsigned NOT NULL,
  `amount` decimal(10,0) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `po_prod_id` (`po_prod_id`),
  KEY `po_addon_addon_id` (`addon_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13648 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `po_prod_statuses` (
  `id` tinyint(4) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `po_statuses` (
  `id` tinyint(4) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `practical_demo_tokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `domain_id` int(11) NOT NULL,
  `name_scope` varchar(255) DEFAULT NULL,
  `date_submitted` datetime DEFAULT NULL,
  `expiration_date` datetime DEFAULT NULL,
  `confirmed_date` datetime DEFAULT NULL,
  `cert_approval_id` int(11) DEFAULT NULL,
  `token_target` varchar(255) DEFAULT NULL,
  `token` varchar(255) DEFAULT NULL,
  `method` varchar(32) DEFAULT NULL,
  `scope_id` varchar(255) DEFAULT NULL,
  `container_domain_id` varchar(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_domain_id` (`domain_id`,`name_scope`),
  KEY `idx_container_domain_id` (`container_domain_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1753677 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `pre_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `public_id` varchar(255) NOT NULL,
  `date_created` datetime NOT NULL,
  `expire_date` datetime DEFAULT NULL,
  `date_processed` datetime DEFAULT NULL,
  `type` enum('SAML') NOT NULL,
  `container_id` int(11) NOT NULL,
  `order_data` text NOT NULL,
  `order_id` int(11) DEFAULT NULL,
  `person_id` varchar(255) DEFAULT NULL,
  `idp_entity_id` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `public_id_UNIQUE` (`public_id`)
) ENGINE=InnoDB AUTO_INCREMENT=90091 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `pricing_contracts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `acct_id` int(6) unsigned NOT NULL,
  `date_time` datetime NOT NULL,
  `created_by_staff_id` int(10) unsigned NOT NULL,
  `effective_date` datetime NOT NULL,
  `term_length` tinyint(4) NOT NULL,
  `end_date` datetime NOT NULL,
  `auto_renewal` tinyint(4) NOT NULL,
  `service_fee` decimal(10,2) NOT NULL,
  `service_fee_limit_type` enum('year','term','6months','quarter','month') NOT NULL DEFAULT 'year',
  `total_cert_limit` varchar(10) NOT NULL,
  `total_ssl_cert_limit` varchar(10) NOT NULL,
  `total_client_cert_limit` varchar(10) NOT NULL,
  `limit_type` enum('year','term') NOT NULL DEFAULT 'year',
  `product_limits` text DEFAULT NULL,
  `pricing_model` enum('flatfee','percert','combined','tiered','tiered_revenue','prepay','none') DEFAULT NULL,
  `discount_type` enum('none','percent_all','percent_each','fixed') NOT NULL DEFAULT 'none',
  `total_domain_limit` varchar(5) NOT NULL,
  `price_locking` enum('30_days_notice','year','term') NOT NULL DEFAULT '30_days_notice',
  `needs_cps_change_notices` tinyint(4) NOT NULL DEFAULT 0,
  `has_custom_terms` tinyint(4) NOT NULL DEFAULT 0,
  `note` text NOT NULL,
  `custom_rates` text NOT NULL,
  `percent_discount` tinyint(4) NOT NULL DEFAULT 0,
  `allowed_lifetime` enum('any','one','two','three','four','five','six') NOT NULL DEFAULT 'any',
  `current_tier` int(10) unsigned DEFAULT NULL,
  `last_annual_check` datetime DEFAULT NULL,
  `is_lifetime_tiered` tinyint(4) NOT NULL DEFAULT 0,
  `is_tier1_base_pricing` tinyint(4) NOT NULL DEFAULT 0,
  `require_click_agreement` tinyint(4) NOT NULL DEFAULT 0,
  `agreement_id` int(10) unsigned DEFAULT NULL,
  `agreement_ip` varchar(50) DEFAULT NULL,
  `agreement_user_id` int(10) unsigned DEFAULT NULL,
  `agreement_date` timestamp NULL DEFAULT NULL,
  `ela` tinyint(4) NOT NULL DEFAULT 0,
  `enterprise_support_plan` tinyint(4) NOT NULL DEFAULT 1,
  `unit_rates` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `subaccount_unit_discounts` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `acct_id` (`acct_id`),
  KEY `effective_date` (`effective_date`),
  KEY `end_date` (`end_date`),
  KEY `auto_renewal` (`auto_renewal`),
  KEY `total_domain_limit` (`total_domain_limit`),
  KEY `price_locking` (`price_locking`),
  KEY `has_custom_terms` (`has_custom_terms`)
) ENGINE=InnoDB AUTO_INCREMENT=24131 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `pricing_contract_sales_stats` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `contract_id` int(10) unsigned DEFAULT NULL,
  `sales_stat_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `pricing_contract_sales_stats_sales_stat_id` (`sales_stat_id`),
  KEY `contract_id` (`contract_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9004 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `pricing_contract_tiers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pricing_contract_id` int(10) unsigned NOT NULL,
  `max_volume` int(8) unsigned NOT NULL,
  `is_unlimited` tinyint(4) unsigned NOT NULL DEFAULT 0,
  `discount_type` enum('none','percent_all','percent_each','fixed') DEFAULT NULL,
  `custom_rates` text DEFAULT NULL,
  `percent_discount` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14088 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `private_ca_info` (
  `id` int(11) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `common_name` varchar(255) NOT NULL DEFAULT '',
  `private_ca_org_id` int(11) unsigned NOT NULL DEFAULT 0,
  `org_unit` text DEFAULT NULL,
  `signature_hash` enum('sha1','sha256','sha384','sha512') NOT NULL DEFAULT 'sha256',
  `key_size` varchar(10) NOT NULL DEFAULT '2048',
  `key_algorithm` varchar(10) NOT NULL DEFAULT 'rsa',
  `lifetime` tinyint(4) unsigned NOT NULL DEFAULT 0,
  `custom_expiration_date` datetime DEFAULT NULL,
  `custom_validity_days` int(6) unsigned DEFAULT NULL,
  `is_root` tinyint(4) unsigned NOT NULL DEFAULT 0,
  `is_cert_revocation_list` tinyint(4) unsigned DEFAULT NULL,
  `is_ocsp` tinyint(4) unsigned DEFAULT NULL,
  `cps_default` tinyint(4) unsigned DEFAULT NULL,
  `custom_cps_url` text DEFAULT NULL,
  `custom_policy_identifier` text DEFAULT NULL,
  `order_specific_message` text DEFAULT NULL,
  `root_ca_cert_id` int(11) unsigned NOT NULL DEFAULT 0,
  `root_ca_private_pki_order_id` int(11) unsigned zerofill NOT NULL DEFAULT 00000000000,
  `date_created` datetime DEFAULT NULL,
  `user_id` int(11) unsigned DEFAULT 0,
  `account_id` int(6) unsigned zerofill NOT NULL DEFAULT 000000,
  `status` varchar(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `ix_common_name` (`common_name`),
  KEY `ix_root_ca_cert_id` (`root_ca_cert_id`),
  KEY `ix_root_ca_private_pki_order_id` (`root_ca_private_pki_order_id`),
  KEY `ix_account_id` (`account_id`),
  KEY `ix_status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `private_ca_organizations` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` int(6) unsigned zerofill NOT NULL DEFAULT 000000,
  `container_id` int(11) unsigned DEFAULT NULL,
  `org_name` varchar(255) NOT NULL DEFAULT '',
  `org_city` varchar(128) NOT NULL DEFAULT '',
  `org_state` varchar(128) NOT NULL DEFAULT '',
  `org_country` varchar(2) NOT NULL DEFAULT '',
  `date_created` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_unique_acct_org` (`account_id`,`org_name`,`org_country`),
  KEY `ix_account_id` (`account_id`),
  KEY `ix_container_id` (`container_id`),
  KEY `ix_org_name` (`org_name`),
  KEY `ix_org_country` (`org_country`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `products` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(128) DEFAULT NULL,
  `simple_name` varchar(128) NOT NULL,
  `accounting_code` varchar(10) NOT NULL DEFAULT '',
  `cmd_prod_id` varchar(64) DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `has_sans` tinyint(1) NOT NULL DEFAULT 0,
  `additional_dns_names_allowed` tinyint(1) NOT NULL DEFAULT 0,
  `valid_addons` varchar(255) NOT NULL,
  `ca_product_type` enum('ssl','codesigning','client','none','ev_ssl','ov_ssl','dv_ssl') DEFAULT NULL,
  `max_lifetime` tinyint(3) unsigned NOT NULL DEFAULT 3,
  `min_lifetime` tinyint(3) unsigned NOT NULL DEFAULT 1,
  `max_days` smallint(5) unsigned DEFAULT NULL,
  `review_url` varchar(255) DEFAULT NULL,
  `review_url_text` varchar(255) DEFAULT NULL,
  `api_name` varchar(45) DEFAULT NULL,
  `api_group_name` varchar(45) DEFAULT NULL,
  `product_type` varchar(45) DEFAULT NULL,
  `description` varchar(512) DEFAULT NULL,
  `domain_blacklist_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `cmd_prod_id` (`cmd_prod_id`),
  KEY `active` (`active`),
  KEY `simple_name` (`simple_name`)
) ENGINE=InnoDB AUTO_INCREMENT=11026 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `product_api` (
  `product_api_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id` int(10) unsigned NOT NULL,
  `product_id` int(10) unsigned NOT NULL,
  `product_name_id` varchar(64) NOT NULL,
  `product_type` varchar(64) NOT NULL,
  `group_type` varchar(64) NOT NULL,
  `product_name` varchar(128) NOT NULL,
  `profile_id` int(10) unsigned DEFAULT NULL,
  `sort_order` int(10) unsigned DEFAULT 10000,
  `short_description` varchar(255) DEFAULT NULL,
  `user_interface_description` text DEFAULT NULL,
  PRIMARY KEY (`product_api_id`),
  UNIQUE KEY `idx_product_name_id` (`product_name_id`),
  KEY `idx_product_id` (`id`),
  KEY `ix_product_id` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=337 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `product_api_old` (
  `id` int(10) unsigned NOT NULL,
  `product_name_id` varchar(64) NOT NULL,
  `product_type` varchar(64) NOT NULL,
  `group_type` varchar(64) NOT NULL,
  `product_name` varchar(128) NOT NULL,
  `profile_id` int(10) unsigned DEFAULT NULL,
  `sort_order` int(10) unsigned DEFAULT 10000,
  `short_description` varchar(255) DEFAULT NULL,
  `user_interface_description` text DEFAULT NULL,
  PRIMARY KEY (`product_name_id`),
  KEY `idx_product_id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `product_rates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `product_id` int(10) unsigned DEFAULT NULL,
  `rates` text DEFAULT NULL,
  `renewal_discount` varchar(255) DEFAULT NULL,
  `addl_cn` varchar(255) DEFAULT NULL,
  `start_date` datetime NOT NULL,
  `fqdn_rates` varchar(255) DEFAULT NULL,
  `wildcard_rates` varchar(255) DEFAULT NULL,
  `currency` char(3) CHARACTER SET ascii NOT NULL DEFAULT 'USD',
  `fqdn_package_rates` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`),
  KEY `ix_currency` (`currency`)
) ENGINE=InnoDB AUTO_INCREMENT=581 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `promotion_new_customer` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `created` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_new` tinyint(1) unsigned DEFAULT NULL,
  `test_results` text DEFAULT NULL,
  `is_eligible` tinyint(1) unsigned DEFAULT NULL,
  `eligibility_notes` text DEFAULT NULL,
  `promo_code_id` int(11) unsigned DEFAULT NULL,
  `order_id` int(11) unsigned DEFAULT NULL,
  `order_price` smallint(5) unsigned DEFAULT NULL,
  `rewarded` tinyint(1) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `promo_codes` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `expiration_date` date NOT NULL,
  `num_uses` int(11) NOT NULL DEFAULT 1,
  `num_uses_per_account` int(11) NOT NULL DEFAULT 1,
  `promo_code` varchar(100) NOT NULL,
  `product_prices` text NOT NULL,
  `percent_discount` varchar(10) NOT NULL DEFAULT '0',
  `extra_days` int(11) NOT NULL,
  `lifetime` varchar(25) NOT NULL DEFAULT '0',
  `product_id` varchar(255) NOT NULL DEFAULT '0',
  `max_names` smallint(5) unsigned NOT NULL DEFAULT 0,
  `customer_name` varchar(100) NOT NULL,
  `customer_org` varchar(100) NOT NULL,
  `customer_email` varchar(100) NOT NULL,
  `customer_phone` varchar(30) NOT NULL,
  `make_permanent_discount` tinyint(4) NOT NULL DEFAULT 0,
  `note` text NOT NULL,
  `reason_id` tinyint(3) unsigned DEFAULT 0,
  `competitor_number` tinyint(3) unsigned DEFAULT NULL,
  `staff_id` int(11) NOT NULL DEFAULT 0,
  `cust_user_id` int(11) NOT NULL DEFAULT 0,
  `acct_id` int(6) unsigned NOT NULL DEFAULT 0,
  `completed` tinyint(4) NOT NULL DEFAULT 0,
  `category` varchar(50) NOT NULL,
  `order_id` int(8) unsigned zerofill NOT NULL DEFAULT 00000000,
  `receipt_id` int(10) NOT NULL DEFAULT 0,
  `stat_row_id` int(11) NOT NULL DEFAULT 0,
  `only_new_accounts` tinyint(4) NOT NULL DEFAULT 0,
  `allowed_names` varchar(200) DEFAULT NULL,
  `cert_expiration_date` date DEFAULT NULL,
  `source_page` varchar(255) DEFAULT NULL,
  `currency` char(3) CHARACTER SET ascii NOT NULL DEFAULT 'USD',
  `custom_days` int(11) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`promo_code`),
  KEY `promo_code_order_id_idx` (`order_id`),
  KEY `order_id` (`order_id`),
  KEY `receipt_id` (`receipt_id`),
  KEY `idx_acct_id` (`acct_id`)
) ENGINE=InnoDB AUTO_INCREMENT=238122 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `promo_code_extras` (
  `promo_code_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_info` text DEFAULT NULL,
  PRIMARY KEY (`promo_code_id`)
) ENGINE=InnoDB AUTO_INCREMENT=33463 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `promo_code_orders` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `promo_code_id` int(10) unsigned NOT NULL,
  `acct_id` int(6) unsigned zerofill DEFAULT NULL,
  `order_id` int(8) unsigned zerofill DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `account_index` (`acct_id`),
  KEY `order_index` (`order_id`),
  KEY `promo_code_id` (`promo_code_id`)
) ENGINE=InnoDB AUTO_INCREMENT=96893 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `promo_code_reasons` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `reason` varchar(255) NOT NULL,
  `status` varchar(20) DEFAULT 'active',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `promo_pages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `thumbnail` varchar(255) NOT NULL DEFAULT '',
  `text` mediumtext NOT NULL,
  `description` text NOT NULL,
  `name` varchar(128) NOT NULL DEFAULT '',
  `order` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `quotes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `recipientName` varchar(150) NOT NULL,
  `recipientOrgName` varchar(150) NOT NULL,
  `recipientEmail` varchar(150) NOT NULL,
  `recipientPhone` varchar(25) NOT NULL,
  `productCount` int(11) NOT NULL,
  `productDetails` text NOT NULL,
  `grandTotal` double NOT NULL,
  `token` varchar(50) NOT NULL,
  `promo_code` varchar(20) NOT NULL,
  `staff_id` int(11) NOT NULL,
  `note` text NOT NULL,
  `date_time` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `token` (`token`)
) ENGINE=InnoDB AUTO_INCREMENT=83163 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `real_id_states` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` char(50) NOT NULL,
  `real_id_compliant` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `date_last_modified` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `modified_by` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `real_id_compliant` (`real_id_compliant`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `reasons` (
  `id` tinyint(4) NOT NULL AUTO_INCREMENT,
  `status_id` tinyint(4) NOT NULL DEFAULT 0,
  `name` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `status_id` (`status_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `receipts` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `date_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `acct_amount` decimal(10,2) DEFAULT 0.00,
  `cc_amount` decimal(10,2) DEFAULT 0.00,
  `cc_last4` varchar(4) DEFAULT NULL,
  `cc_exp_date` varchar(4) DEFAULT NULL,
  `cc_type` enum('amex','visa','mastercard','discover','other','none') NOT NULL DEFAULT 'none',
  `gty_trans_id` varchar(32) DEFAULT '0',
  `gty_settlement_id` varchar(32) DEFAULT '0',
  `gty_refund_id` varchar(32) DEFAULT '0',
  `bill_name` varchar(128) DEFAULT NULL,
  `bill_org_name` varchar(128) DEFAULT NULL,
  `bill_addr1` varchar(128) DEFAULT NULL,
  `bill_addr2` varchar(128) DEFAULT NULL,
  `bill_city` varchar(128) DEFAULT NULL,
  `bill_state` varchar(128) DEFAULT NULL,
  `bill_zip` varchar(40) DEFAULT NULL,
  `bill_country` varchar(2) DEFAULT NULL,
  `bill_email` varchar(255) DEFAULT NULL,
  `gty_status` varchar(64) NOT NULL DEFAULT '',
  `gty_capture_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `gty_auth_msg` varchar(128) NOT NULL DEFAULT '',
  `gty_request_token` varchar(128) NOT NULL DEFAULT '',
  `gty_ref_code` varchar(128) NOT NULL DEFAULT '',
  `payment_gty` enum('cybersource','netbilling') NOT NULL DEFAULT 'cybersource',
  `payment_profile_id` varchar(32) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `gty_trans_id` (`gty_trans_id`),
  KEY `gty_settlement_id` (`gty_settlement_id`)
) ENGINE=InnoDB AUTO_INCREMENT=119065236 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `receipt_tax` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `receipt_id` int(10) unsigned NOT NULL,
  `tax_amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `gross_amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  PRIMARY KEY (`id`),
  KEY `ix_receipt_id` (`receipt_id`)
) ENGINE=InnoDB AUTO_INCREMENT=76497410 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `registration_authority` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` int(10) unsigned NOT NULL,
  `registration_authority_hash` varchar(128) DEFAULT NULL,
  `registration_authority_encrypted` varchar(255) DEFAULT NULL,
  `ip_ranges` varchar(255) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_account_id` (`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `reissues` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(8) unsigned zerofill NOT NULL DEFAULT 00000000,
  `status` tinyint(1) NOT NULL DEFAULT 2,
  `ca_order_id` int(11) NOT NULL DEFAULT 0,
  `cmd_prod_id` varchar(64) NOT NULL,
  `date_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `staff_id` int(11) NOT NULL DEFAULT 0,
  `auth_1_staff` int(11) NOT NULL,
  `auth_1_date_time` datetime NOT NULL,
  `auth_2_staff` int(11) NOT NULL,
  `auth_2_date_time` datetime NOT NULL,
  `csr` text NOT NULL,
  `serversw` smallint(5) NOT NULL,
  `add_cn` tinyint(2) NOT NULL,
  `reason` text NOT NULL,
  `collected` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `revoked` tinyint(1) NOT NULL DEFAULT 0,
  `reason_code` tinyint(1) NOT NULL,
  `update_expiry` tinyint(1) NOT NULL,
  `valid_till` date NOT NULL DEFAULT '0000-00-00',
  `whois_completed` tinyint(1) NOT NULL,
  `whois_staff_id` int(10) NOT NULL,
  `whois_date_time` datetime NOT NULL,
  `org_name_completed` tinyint(1) NOT NULL,
  `org_name_staff_id` int(10) NOT NULL,
  `org_name_date_time` datetime NOT NULL,
  `old_common_name` text NOT NULL,
  `new_common_name` text NOT NULL,
  `old_sans` text NOT NULL,
  `new_sans` text NOT NULL,
  `new_sans_to_validate` text DEFAULT NULL,
  `old_org_name` varchar(255) NOT NULL,
  `new_org_name` varchar(255) NOT NULL,
  `old_org_unit` varchar(128) NOT NULL,
  `new_org_unit` varchar(128) NOT NULL,
  `old_org_addr1` varchar(128) NOT NULL,
  `new_org_addr1` varchar(128) NOT NULL,
  `old_org_addr2` varchar(128) NOT NULL,
  `new_org_addr2` varchar(128) NOT NULL,
  `old_org_city` varchar(64) NOT NULL,
  `new_org_city` varchar(64) NOT NULL,
  `old_org_state` varchar(64) NOT NULL,
  `new_org_state` varchar(64) NOT NULL,
  `old_org_country` varchar(2) NOT NULL,
  `new_org_country` varchar(2) NOT NULL,
  `old_org_zip` varchar(12) NOT NULL,
  `new_org_zip` varchar(12) NOT NULL,
  `old_email` varchar(255) NOT NULL,
  `new_email` varchar(255) NOT NULL,
  `old_telephone` varchar(32) NOT NULL,
  `new_telephone` varchar(32) NOT NULL,
  `old_telephone_ext` varchar(12) NOT NULL,
  `new_telephone_ext` varchar(12) NOT NULL,
  `reject_date_time` datetime NOT NULL,
  `reject_staff_id` int(10) NOT NULL,
  `reject_reason` text NOT NULL,
  `stat_row_id` int(11) NOT NULL,
  `string_type` enum('PS','T61','UTF8','AUTO') NOT NULL DEFAULT 'AUTO',
  `ca_cert_id` smallint(6) NOT NULL DEFAULT 33,
  `origin` enum('retail','enterprise','staff') DEFAULT 'retail',
  `delay_revoke` smallint(6) NOT NULL,
  `receipt_id` int(10) NOT NULL DEFAULT 0,
  `signature_hash` enum('sha1','sha256','sha384','sha512') DEFAULT 'sha1',
  `root_path` enum('digicert','entrust','cybertrust','comodo') NOT NULL DEFAULT 'entrust',
  `no_sans` tinyint(1) NOT NULL DEFAULT 0,
  `code_signing_cert_token` varchar(32) DEFAULT NULL,
  `risk_score` smallint(5) unsigned DEFAULT NULL,
  `key_usage` varchar(150) DEFAULT NULL,
  `in_progress` tinyint(1) NOT NULL DEFAULT 0,
  `pay_type` varchar(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `stat_row_id` (`stat_row_id`),
  KEY `reissues_status` (`status`),
  KEY `collected_index` (`collected`),
  KEY `status` (`status`),
  KEY `receipt_id` (`receipt_id`),
  KEY `in_progress` (`in_progress`)
) ENGINE=InnoDB AUTO_INCREMENT=901018 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `reissue_notes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `reissue_id` int(8) unsigned zerofill DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `note` text DEFAULT NULL,
  `staff_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `reissue_notes_reissue_id` (`reissue_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10388 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `rejections` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(8) unsigned zerofill NOT NULL DEFAULT 00000000,
  `reject_notes` text NOT NULL,
  `reject_date_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `reject_staff` int(10) unsigned NOT NULL DEFAULT 0,
  `reject_stat_row_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=512443 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `reports` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `container_id` int(10) unsigned NOT NULL,
  `template_id` int(10) unsigned NOT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'requested',
  `instance_id` varchar(255) DEFAULT NULL,
  `last_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `email_sent` varchar(10) NOT NULL DEFAULT 'no',
  `url` varchar(400) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `template_id_idx` (`template_id`),
  CONSTRAINT `template_id` FOREIGN KEY (`template_id`) REFERENCES `report_templates` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1000075 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `report_schedules` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `report_id` int(10) unsigned NOT NULL,
  `frequency` enum('MONTHLY','WEEKLY','DAILY') NOT NULL,
  `parameters` varchar(45) DEFAULT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'requested',
  `instance_id` varchar(255) DEFAULT NULL,
  `last_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `report_id_idx` (`report_id`),
  CONSTRAINT `report_id` FOREIGN KEY (`report_id`) REFERENCES `reports` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1000005 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `report_templates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fields` varchar(1000) NOT NULL,
  `filters` varchar(1000) DEFAULT NULL,
  `parameters` varchar(200) DEFAULT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `last_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `query_name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1000063 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `request_auth_log` (
  `company_id` int(10) unsigned NOT NULL,
  `date_processed` datetime NOT NULL,
  `already_completed` tinyint(3) unsigned NOT NULL,
  `found_dcv` tinyint(3) unsigned DEFAULT NULL,
  `found_ov_checks` tinyint(3) unsigned DEFAULT NULL,
  `reference_dcv_id` int(10) unsigned DEFAULT NULL,
  `reference_checkmark_id` int(10) unsigned DEFAULT NULL,
  `created_checkmark_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`company_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `request_auth_tool` (
  `org_id` int(10) unsigned NOT NULL,
  `cert_approval_id` int(10) unsigned DEFAULT NULL,
  `cis_domain_id` varchar(255) DEFAULT NULL,
  `last_checked` datetime DEFAULT NULL,
  `date_found` datetime DEFAULT NULL,
  `checkmark_note` text DEFAULT NULL,
  UNIQUE KEY `org_id` (`org_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `reseller_company_types` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `reseller_seal_info` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Use UNSIGNED MEDIUMINT limits us to 16 million seals to keep us below the hash collision threshold',
  `hash` char(8) DEFAULT NULL COMMENT 'CHAR(8) with our hashing algorithm would have a collision at around 19 million hashes',
  `reseller_id` int(10) unsigned NOT NULL,
  `domains` text DEFAULT NULL,
  `created_timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  `seen_on_url` varchar(255) DEFAULT NULL,
  `seen_timestamp` timestamp NULL DEFAULT NULL,
  `seen_with_params` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `reseller_id` (`reseller_id`),
  UNIQUE KEY `hash` (`hash`)
) ENGINE=InnoDB AUTO_INCREMENT=7241 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `revokes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(8) unsigned zerofill NOT NULL DEFAULT 00000000,
  `date_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `staff_id` int(11) NOT NULL DEFAULT 0,
  `reason` text NOT NULL,
  `reason_code` tinyint(1) NOT NULL DEFAULT 0,
  `simple_reason` enum('unknown','duplicate','info_change','installation','new_provider','no_longer_needed','nonpayment','private_key','test_order','prod_change','validation') NOT NULL DEFAULT 'unknown',
  `refunded` tinyint(1) NOT NULL DEFAULT 0,
  `server_response` text NOT NULL,
  `temp_hide` tinyint(1) NOT NULL DEFAULT 0,
  `refund_code` varchar(32) NOT NULL DEFAULT '',
  `completed` tinyint(1) NOT NULL DEFAULT 0,
  `delay_revoke` int(11) NOT NULL DEFAULT 0,
  `auth_1_staff` int(11) NOT NULL DEFAULT 0,
  `auth_1_date_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `auth_2_staff` int(11) NOT NULL DEFAULT 0,
  `auth_2_date_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `confirmed_authentic` tinyint(1) NOT NULL DEFAULT 0,
  `stat_row_id` int(11) NOT NULL,
  `serial_number` varchar(64) NOT NULL,
  `type` enum('revoke','cancel') NOT NULL DEFAULT 'revoke',
  `po_id` int(11) DEFAULT NULL,
  `cc_refund_amount` decimal(10,2) DEFAULT NULL,
  `acct_refund_amount` decimal(10,2) DEFAULT NULL,
  `wire_transfer_refund_amount` decimal(10,2) DEFAULT NULL,
  `is_suspicious` tinyint(1) DEFAULT NULL,
  `high_risk_items` varchar(255) DEFAULT NULL,
  `request_received` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `order_id` (`order_id`),
  KEY `stat_row_id` (`stat_row_id`),
  KEY `serial_number` (`serial_number`),
  KEY `date_time` (`date_time`),
  KEY `completed_idx` (`completed`)
) ENGINE=InnoDB AUTO_INCREMENT=2847897 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `risky_contacts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `certificate_request_id` varchar(128) NOT NULL,
  `contact_hash` varchar(32) DEFAULT NULL,
  `firstname` int(10) unsigned NOT NULL,
  `lastname` int(10) unsigned NOT NULL,
  `email` int(10) unsigned NOT NULL,
  `telephone` int(10) unsigned NOT NULL,
  `snooze_until` datetime DEFAULT NULL,
  `status` varchar(32) NOT NULL DEFAULT 'pending',
  `staff_id` int(11) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `date_completed` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_certificate_request_id` (`certificate_request_id`),
  KEY `ix_contact_hash` (`contact_hash`),
  KEY `ix_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `risky_domains` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `public_id` varchar(35) NOT NULL,
  `account_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `risk_score` int(10) DEFAULT NULL,
  `snooze_until` datetime DEFAULT NULL,
  `completed_date` datetime DEFAULT NULL,
  `brand` varchar(256) DEFAULT NULL,
  `locale` varchar(5) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_domain_public_id` (`public_id`(8)),
  KEY `risky_domains_account_id` (`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=125443 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `risky_ou` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `certificate_request_id` varchar(128) DEFAULT NULL,
  `account_id` int(10) unsigned NOT NULL,
  `ou_value` varchar(256) NOT NULL,
  `date_created` datetime NOT NULL,
  `account_name` varchar(255) DEFAULT NULL,
  `organization_name` varchar(255) DEFAULT NULL,
  `reserved_by_staff_id` int(10) unsigned DEFAULT NULL,
  `reserved_date_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_account_value` (`account_id`,`ou_value`(255)),
  KEY `ix_certificate_request_id` (`certificate_request_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1463634 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `risk_history` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(10) unsigned DEFAULT NULL,
  `reissue_id` int(10) unsigned DEFAULT NULL,
  `company_id` int(10) unsigned NOT NULL DEFAULT 0,
  `domain_id` int(10) unsigned NOT NULL DEFAULT 0,
  `risk_score` smallint(5) unsigned DEFAULT NULL,
  `risk_factors` text DEFAULT NULL,
  `date_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `company_id` (`company_id`),
  KEY `domain_id` (`domain_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19402029 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `salesforce_account_watchlist` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `last_touched` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `acct_id` int(6) unsigned zerofill NOT NULL,
  `total_spent_before_mpki` int(11) DEFAULT NULL,
  `total_spent_since_mpki` int(11) DEFAULT NULL,
  `month_to_date_total` int(11) DEFAULT NULL,
  `month_to_date_cert_count` smallint(6) DEFAULT NULL,
  `rejected_from_watchlist` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `sf_account_guid` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `acct_id` (`acct_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1085 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `salesforce_last_upsert_times` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `type` enum('orders','contacts') DEFAULT NULL,
  `record_id` int(11) DEFAULT NULL,
  `upsert_timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `type` (`type`,`record_id`),
  KEY `sflut_record_id` (`record_id`),
  KEY `sflut_up_ts` (`upsert_timestamp`)
) ENGINE=InnoDB AUTO_INCREMENT=907046 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `salesforce_order_leads` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `last_touched` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `order_id` int(10) unsigned NOT NULL,
  `staff_id` smallint(5) unsigned NOT NULL,
  `rejected_by_sales` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `sf_lead_guid` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `sales_acct_notes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `acct_id` int(8) unsigned zerofill DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `context` varchar(25) NOT NULL,
  `note` varchar(255) DEFAULT NULL,
  `staff_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=494 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `sales_stats` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ord_date` datetime NOT NULL,
  `col_date` datetime NOT NULL,
  `units` smallint(6) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `country` varchar(2) NOT NULL,
  `reseller_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `is_renewal` tinyint(1) NOT NULL DEFAULT 0,
  `is_first_order` tinyint(1) NOT NULL DEFAULT 0,
  `order_id` int(8) unsigned zerofill NOT NULL,
  `ent_client_cert_id` int(10) unsigned NOT NULL DEFAULT 0,
  `serversw` smallint(5) NOT NULL,
  `type` enum('revoke','rejection','order','cancel') NOT NULL DEFAULT 'order',
  `origin` enum('retail','enterprise') DEFAULT 'retail',
  `lifetime` tinyint(2) NOT NULL,
  `test_order` tinyint(1) NOT NULL DEFAULT 0,
  `finance_revamp` tinyint(1) NOT NULL DEFAULT 0,
  `col_till` date DEFAULT '0000-00-00',
  `sale_type` enum('po','acct','funny','credit','unknown','bill reseller','ela','wire','subscription','voucher') DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `country` (`country`),
  KEY `reseller_id` (`reseller_id`),
  KEY `is_renewal` (`is_renewal`),
  KEY `units` (`units`),
  KEY `amount` (`amount`),
  KEY `serversw` (`serversw`),
  KEY `type` (`type`),
  KEY `ord_date` (`ord_date`),
  KEY `col_date` (`col_date`),
  KEY `lifetime` (`lifetime`),
  KEY `order_type` (`order_id`,`type`),
  KEY `test_order` (`test_order`),
  KEY `ss_origin` (`origin`),
  KEY `is_first_order` (`is_first_order`),
  KEY `ent_client_cert_id` (`ent_client_cert_id`)
) ENGINE=InnoDB AUTO_INCREMENT=213651751 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `sales_stats_audit` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `stat_row_id` int(10) DEFAULT NULL,
  `staff_id` int(10) NOT NULL,
  `memo` tinytext DEFAULT NULL,
  `modified` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14493 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `saml_assertion_log1` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `saml_response` text NOT NULL,
  `account_id` int(10) unsigned DEFAULT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  `entity_id` varchar(1024) DEFAULT NULL,
  `attributes` text DEFAULT NULL,
  `errors` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_date_created` (`date_created`),
  KEY `ix_account_id` (`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `saml_assertion_log2` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `saml_response` text NOT NULL,
  `account_id` int(10) unsigned DEFAULT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  `entity_id` varchar(1024) DEFAULT NULL,
  `attributes` text DEFAULT NULL,
  `errors` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_date_created` (`date_created`),
  KEY `ix_account_id` (`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4157 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `saml_assertion_log3` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `saml_response` text NOT NULL,
  `account_id` int(10) unsigned DEFAULT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  `entity_id` varchar(1024) DEFAULT NULL,
  `attributes` text DEFAULT NULL,
  `errors` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_date_created` (`date_created`),
  KEY `ix_account_id` (`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4588 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `saml_entity` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` int(10) unsigned NOT NULL,
  `xml_metadata` mediumtext DEFAULT NULL,
  `source_url` varchar(1024) DEFAULT NULL,
  `idp_entity_id` varchar(1024) NOT NULL,
  `idp_signon_url` varchar(1024) NOT NULL,
  `attribute_mapping` varchar(2048) DEFAULT NULL,
  `friendly_name` varchar(64) DEFAULT NULL,
  `friendly_slug` varchar(64) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `last_signon_date` datetime DEFAULT NULL,
  `last_xml_pull_date` datetime DEFAULT NULL,
  `type` varchar(16) DEFAULT NULL,
  `discoverable` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_slug` (`friendly_slug`),
  KEY `ix_account` (`account_id`),
  KEY `ix_type` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=3298 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `saml_entity_certificate` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `saml_entity_id` int(10) unsigned NOT NULL,
  `certificate` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_saml_entity_id` (`saml_entity_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7659 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `saml_guest_request` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `person_id` varchar(64) NOT NULL,
  `account_id` int(10) unsigned NOT NULL,
  `order_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_person_id` (`person_id`),
  KEY `idx_account_id` (`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=239 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `saml_login_token` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `token` varchar(255) NOT NULL,
  `created_date` datetime DEFAULT NULL,
  `expires_date` datetime DEFAULT NULL,
  `is_processed` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `token_UNIQUE` (`token`)
) ENGINE=InnoDB AUTO_INCREMENT=2635 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `seal_info` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Use UNSIGNED MEDIUMINT limits us to 16 million seals to keep us below the hash collision threshold',
  `hash` char(8) DEFAULT NULL COMMENT 'CHAR(8) with our hashing algorithm would have a collision at around 19 million hashes',
  `order_id` int(10) unsigned NOT NULL,
  `created_timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  `seen_on_url` varchar(255) DEFAULT NULL,
  `seen_timestamp` timestamp NULL DEFAULT NULL,
  `seen_with_params` varchar(255) DEFAULT NULL,
  `stored_settings` varchar(255) DEFAULT NULL,
  `organization_logo_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `order_id` (`order_id`),
  UNIQUE KEY `hash` (`hash`),
  KEY `ix_logo_id` (`organization_logo_id`)
) ENGINE=InnoDB AUTO_INCREMENT=179374 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `seal_info_deprecated` (
  `order_id` int(10) unsigned NOT NULL,
  `seen_timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  `seen_on_url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `security_questions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `question` varchar(255) NOT NULL DEFAULT '',
  `status` enum('active','retired') DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `serversw` (
  `id` smallint(5) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) DEFAULT NULL,
  `best_format` varchar(20) DEFAULT NULL,
  `sort_order` tinyint(4) unsigned DEFAULT NULL,
  `install_url` varchar(150) DEFAULT NULL,
  `csr_url` varchar(150) DEFAULT NULL,
  `cert_type` enum('server','code') NOT NULL DEFAULT 'server',
  `requires_new_csr` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `sort_order` (`sort_order`)
) ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `sf_contacts_temp` (
  `acct_id` int(6) unsigned zerofill NOT NULL DEFAULT 000000,
  `watched_id` int(11) unsigned DEFAULT 0,
  `id` int(11) unsigned NOT NULL DEFAULT 0,
  `contact_type` enum('org','tech','bill') DEFAULT NULL,
  `job_title` varchar(64) DEFAULT NULL,
  `firstname` varchar(128) DEFAULT NULL,
  `lastname` varchar(128) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `telephone` varchar(32) DEFAULT NULL,
  `telephone_ext` varchar(16) NOT NULL DEFAULT '',
  `fax` varchar(32) DEFAULT NULL,
  `org_type` tinyint(3) DEFAULT NULL,
  `org_name` varchar(255) DEFAULT NULL,
  `org_unit` varchar(64) DEFAULT NULL,
  `org_addr1` varchar(128) DEFAULT NULL,
  `org_addr2` varchar(128) DEFAULT NULL,
  `org_zip` varchar(40) DEFAULT NULL,
  `org_city` varchar(128) DEFAULT NULL,
  `org_state` varchar(128) DEFAULT NULL,
  `org_country` varchar(2) DEFAULT NULL,
  `org_reg_num` varchar(25) DEFAULT NULL,
  `org_duns_num` varchar(32) DEFAULT NULL,
  `opt_in_news` tinyint(1) NOT NULL DEFAULT 0,
  `usable_org_name` varchar(255) NOT NULL DEFAULT '',
  `timezone` varchar(40) DEFAULT NULL,
  `i18n_language_id` tinyint(4) unsigned DEFAULT 1,
  `last_updated` timestamp NULL DEFAULT NULL,
  `sf_guid` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `acct_id` (`acct_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `sf_orders_temp` (
  `acct_id` int(6) unsigned zerofill NOT NULL DEFAULT 000000,
  `org_name` varchar(255) NOT NULL DEFAULT '',
  `id` int(8) unsigned zerofill NOT NULL,
  `date_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `common_name` varchar(255) NOT NULL DEFAULT '',
  `status` tinyint(4) NOT NULL DEFAULT 1,
  `reason` tinyint(4) NOT NULL DEFAULT 1,
  `lifetime` tinyint(4) NOT NULL DEFAULT 0,
  `product_id` int(11) DEFAULT NULL,
  `is_renewed` tinyint(1) NOT NULL DEFAULT 0,
  `renewed_order_id` int(8) unsigned zerofill NOT NULL DEFAULT 00000000,
  `is_first_order` tinyint(1) NOT NULL DEFAULT 0,
  `valid_till` date NOT NULL DEFAULT '0000-00-00',
  `ca_collect_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `value` decimal(10,2) DEFAULT NULL,
  `sf_guid` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `acct_id` (`acct_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `signing_timestamp_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(8) unsigned zerofill NOT NULL,
  `order_timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=179907 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `siteseallink` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `language` char(5) NOT NULL DEFAULT 'en_US',
  `link` varchar(64) NOT NULL DEFAULT '0',
  `percentage` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `type` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=241 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `siteseallinkproducts` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `type_id` tinyint(3) unsigned DEFAULT NULL,
  `product_id` smallint(5) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `siteseallinktype` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `siteseallinkurl` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `language` char(5) NOT NULL DEFAULT 'en_US',
  `link` varchar(192) NOT NULL DEFAULT '',
  `percentage` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `type` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=133 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `staff` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `firstname` varchar(50) DEFAULT NULL,
  `lastname` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `username` varchar(120) DEFAULT NULL,
  `dotname` varchar(60) DEFAULT NULL,
  `staff_role_id` smallint(6) NOT NULL DEFAULT 200,
  `hashpass` varchar(128) NOT NULL DEFAULT '',
  `newpass` tinyint(4) DEFAULT 1,
  `status` enum('active','inactive','deleted','locked out') DEFAULT 'active',
  `ip_access` text NOT NULL,
  `last_pw_change` date NOT NULL DEFAULT '0000-00-00',
  `failed_attempts` tinyint(1) NOT NULL DEFAULT 0,
  `phone_extension` varchar(4) DEFAULT NULL,
  `staff_direct_phone` varchar(20) DEFAULT NULL,
  `settings` set('timecard_required','prompt_for_time','track_time_daily','track_time_weekly','account_rep','account_dev','account_client_mgr') DEFAULT NULL,
  `photo_file_id` int(10) unsigned DEFAULT NULL,
  `hire_date` date DEFAULT NULL,
  `risk_approval_threshold` smallint(5) NOT NULL DEFAULT 0,
  `queue_status` int(11) DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2526 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `staff_background_info` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `staff_id` int(10) unsigned NOT NULL,
  `token` varchar(128) NOT NULL,
  `provider_name` varchar(255) NOT NULL,
  `provider_email` varchar(255) NOT NULL,
  `provider_employer` varchar(255) NOT NULL,
  `candidate_name` varchar(255) NOT NULL,
  `requested_date` datetime DEFAULT NULL,
  `completed` tinyint(1) DEFAULT 0,
  `completed_date` datetime DEFAULT NULL,
  `hidden` tinyint(1) DEFAULT 0,
  `hidden_date` datetime DEFAULT NULL,
  `datum_provider_role` varchar(255) DEFAULT '',
  `datum_how_long_known` varchar(255) DEFAULT '',
  `datum_employment_dates` varchar(255) DEFAULT '',
  `datum_compensation` varchar(255) DEFAULT '',
  `datum_responsibilities` text DEFAULT NULL,
  `datum_leadership` text DEFAULT NULL,
  `datum_promotion` varchar(255) DEFAULT '',
  `datum_rehire` tinyint(1) DEFAULT NULL,
  `datum_rehire_ex` varchar(255) DEFAULT '',
  `datum_strengths` text DEFAULT NULL,
  `datum_accomplishments` text DEFAULT NULL,
  `datum_rel_coworkers` varchar(255) DEFAULT '',
  `datum_rel_supervisor` varchar(255) DEFAULT '',
  `datum_rel_customers` varchar(255) DEFAULT '',
  `datum_rate_verbal` int(11) DEFAULT NULL,
  `datum_rate_written` int(11) DEFAULT NULL,
  `datum_schedule` varchar(255) DEFAULT '',
  `datum_attendance` varchar(255) DEFAULT '',
  `datum_overtime` varchar(255) DEFAULT '',
  `datum_pressure` varchar(255) DEFAULT '',
  `datum_character` text DEFAULT NULL,
  `datum_misc` text DEFAULT NULL,
  `datum_weaknesses` text DEFAULT NULL,
  `datum_compare_peers` text DEFAULT NULL,
  `datum_recommend` text DEFAULT NULL,
  `datum_work_again` text DEFAULT NULL,
  `datum_sales_v_service` text DEFAULT NULL,
  `datum_presentation` text DEFAULT NULL,
  `datum_deadlines` text DEFAULT NULL,
  `datum_right_v_on_time` text DEFAULT NULL,
  `datum_other` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_bginfo_token` (`token`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `staff_client_certs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `staff_id` int(11) NOT NULL DEFAULT 0,
  `create_date` date NOT NULL DEFAULT '1900-01-01',
  `expiry_date` date NOT NULL DEFAULT '1900-01-01',
  `common_name` varchar(64) NOT NULL DEFAULT '',
  `email` varchar(255) NOT NULL DEFAULT '',
  `org_unit` varchar(128) NOT NULL DEFAULT '',
  `serial_number` varchar(64) NOT NULL DEFAULT '',
  `revoked` tinyint(4) NOT NULL DEFAULT 0,
  `signature_hash` set('unknown','sha1','sha256','sha384','sha512','sha256ecdsa','sha384ecdsa') NOT NULL DEFAULT 'unknown',
  `encrypted_key` mediumtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `staff_id` (`staff_id`),
  KEY `serial_number` (`serial_number`(6))
) ENGINE=InnoDB AUTO_INCREMENT=2388 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `staff_ip_access` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` date DEFAULT '1900-01-01',
  `ip_address` varchar(15) NOT NULL DEFAULT '',
  `ip_address_end` varchar(15) NOT NULL DEFAULT '',
  `description` varchar(255) DEFAULT '',
  `allow_my_docs_polling` tinyint(3) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `staff_otp_cache` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `device_id` int(11) DEFAULT NULL,
  `staff_id` int(11) DEFAULT NULL,
  `otp` varchar(32) DEFAULT NULL,
  `date_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3545929 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `staff_otp_deleted` (
  `id` int(10) unsigned NOT NULL,
  `staff_id` int(11) DEFAULT NULL,
  `device_key` varchar(255) DEFAULT NULL,
  `shared_secret` varchar(255) DEFAULT NULL,
  `device_description` varchar(255) DEFAULT NULL,
  `ctime` datetime DEFAULT NULL,
  `algorithm` enum('motp','oath-hotp') NOT NULL DEFAULT 'motp',
  `failed_attempts` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `staff_otp_devices` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `staff_id` int(11) DEFAULT NULL,
  `device_key` varchar(255) DEFAULT NULL,
  `shared_secret` varchar(255) DEFAULT NULL,
  `device_description` varchar(255) DEFAULT NULL,
  `ctime` datetime DEFAULT NULL,
  `algorithm` enum('motp','oath-hotp') NOT NULL DEFAULT 'motp',
  `failed_attempts` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2117 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `staff_permission_failures` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `staff_id` smallint(6) NOT NULL DEFAULT 0,
  `date_time` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `permission` varchar(255) NOT NULL DEFAULT '',
  `request_uri` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16602 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `staff_permission_import` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `role_name` varchar(255) NOT NULL DEFAULT '',
  `permission` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `staff_permission_snapshots` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `staff_roles_snapshot` mediumtext DEFAULT NULL,
  `staff_permissions_snapshot` mediumtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `date_time_idx` (`date_time`)
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `staff_phone_devices` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_time` datetime DEFAULT NULL,
  `staff_id` int(10) unsigned NOT NULL DEFAULT 0,
  `device_user` varchar(64) NOT NULL DEFAULT '0',
  `device_pass` varchar(128) NOT NULL DEFAULT '0',
  `device_token` varchar(64) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `staff_id` (`staff_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1482 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `staff_pw_changes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `staff_id` int(11) NOT NULL DEFAULT 0,
  `date` date NOT NULL DEFAULT '0000-00-00',
  `hashpass` varchar(128) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6164 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `staff_roles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `role_name` varchar(64) NOT NULL DEFAULT '',
  `department` varchar(64) NOT NULL DEFAULT '',
  `summary` varchar(255) NOT NULL DEFAULT '',
  `base_role_id` smallint(6) NOT NULL DEFAULT 0,
  `is_base_role` tinyint(4) NOT NULL DEFAULT 0,
  `permissions` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=286 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `staff_role_descendant_map` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `staff_role_id` int(10) unsigned NOT NULL,
  `descendant_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=196 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `staff_shift` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `staff_id` int(10) unsigned DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `staff_date_idx` (`staff_id`,`start_date`,`end_date`)
) ENGINE=InnoDB AUTO_INCREMENT=93 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `staff_shift_day` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `shift_id` smallint(5) unsigned DEFAULT NULL,
  `day` tinyint(3) unsigned DEFAULT NULL,
  `start_hour` tinyint(3) unsigned DEFAULT NULL,
  `end_hour` tinyint(3) unsigned DEFAULT NULL,
  `start_min` tinyint(3) unsigned DEFAULT NULL,
  `end_min` tinyint(3) unsigned DEFAULT NULL,
  `extension` varchar(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `shift_id_idx` (`shift_id`)
) ENGINE=InnoDB AUTO_INCREMENT=432 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `staff_tags` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `staff_id` int(11) NOT NULL,
  `tag` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4188 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `standing_approval_invitations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `acct_id` int(11) NOT NULL,
  `email` varchar(128) NOT NULL,
  `org_name` varchar(255) DEFAULT NULL,
  `token` varchar(32) NOT NULL,
  `date_time` datetime DEFAULT NULL,
  `status` enum('active','deleted') NOT NULL DEFAULT 'active',
  `standing_cert_approval_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `standing_cert_approvals` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `acct_id` int(11) NOT NULL,
  `origin` enum('email','phone') DEFAULT NULL,
  `approver_name` varchar(255) NOT NULL DEFAULT '',
  `approver_email` varchar(255) DEFAULT NULL,
  `approver_phone` varchar(255) DEFAULT NULL,
  `approver_ip` varchar(15) NOT NULL DEFAULT '',
  `org_name` varchar(255) DEFAULT NULL,
  `staff_id` int(11) NOT NULL DEFAULT 0,
  `staff_note` text DEFAULT NULL,
  `ctime` datetime DEFAULT NULL,
  `agreement_id` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `statuses` (
  `id` tinyint(4) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `subaccount_invite` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `date_created` datetime DEFAULT NULL,
  `last_sent_date` datetime DEFAULT NULL,
  `date_used` datetime DEFAULT NULL,
  `status` varchar(16) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `parent_account_id` int(10) unsigned zerofill NOT NULL,
  `token` varchar(255) NOT NULL,
  `subaccount_id` int(10) unsigned zerofill DEFAULT NULL,
  `subaccount_type` varchar(64) NOT NULL,
  `invite_note` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_token` (`token`),
  KEY `idx_date_created` (`date_created`)
) ENGINE=InnoDB AUTO_INCREMENT=641 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `subaccount_order_transaction` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(10) unsigned NOT NULL,
  `billed_account_id` int(10) unsigned NOT NULL,
  `account_id` int(10) unsigned NOT NULL,
  `container_id` int(10) unsigned NOT NULL,
  `price` decimal(10,2) DEFAULT 0.00,
  `order_price` decimal(10,2) DEFAULT 0.00,
  `currency` char(3) NOT NULL DEFAULT 'USD',
  `receipt_id` int(10) unsigned DEFAULT 0,
  `acct_adjust_id` int(10) unsigned DEFAULT 0,
  `order_transaction_id` int(10) unsigned DEFAULT 0,
  `transaction_date` datetime DEFAULT current_timestamp(),
  `transaction_type` varchar(32) DEFAULT NULL,
  `balance` decimal(10,2) DEFAULT 0.00,
  PRIMARY KEY (`id`),
  KEY `idx_billed_account_id` (`billed_account_id`),
  KEY `idx_account_id` (`account_id`),
  KEY `idx_container_id` (`container_id`),
  KEY `ix_order_id` (`order_id`),
  KEY `idx_order_transaction_id` (`order_transaction_id`),
  KEY `idx_acct_adjust_id` (`acct_adjust_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16168628 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `subaccount_product_rates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` int(10) unsigned NOT NULL,
  `parent_account_id` int(10) unsigned NOT NULL,
  `product_rates` text NOT NULL,
  `client_cert_rates` text DEFAULT NULL,
  `currency` char(3) NOT NULL DEFAULT 'USD',
  `user_id` int(10) unsigned NOT NULL,
  `date_created` datetime NOT NULL DEFAULT current_timestamp(),
  `last_updated` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_account_id` (`account_id`),
  KEY `ix_parent_account_id` (`parent_account_id`),
  KEY `ix_currency` (`currency`)
) ENGINE=InnoDB AUTO_INCREMENT=143939 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `support_email_random_values` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `date_expired` datetime DEFAULT NULL,
  `date_completed` datetime DEFAULT NULL,
  `organization_id` int(10) unsigned DEFAULT NULL,
  `domain_id` varchar(128) DEFAULT NULL,
  `doc_id` int(10) unsigned DEFAULT NULL,
  `email_address` varchar(255) NOT NULL,
  `staff_id` int(10) unsigned NOT NULL,
  `random_value` varchar(128) NOT NULL,
  `type` varchar(32) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_random_value` (`random_value`) USING HASH
) ENGINE=InnoDB AUTO_INCREMENT=420565 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `symc_order_notes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `symc_order_id` varchar(32) DEFAULT NULL,
  `staff_id` int(10) unsigned NOT NULL DEFAULT 0,
  `date_time` datetime NOT NULL,
  `note` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `date_time` (`date_time`),
  KEY `order_id_idx` (`symc_order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=419446 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `tfa_accounts` (
  `acct_id` int(11) unsigned NOT NULL,
  `last_enabled` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`acct_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `tfa_requirements` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `acct_id` int(8) NOT NULL DEFAULT 0,
  `container_id` int(11) unsigned DEFAULT NULL,
  `auth_type` enum('google_auth','client_cert') CHARACTER SET latin1 NOT NULL DEFAULT 'google_auth',
  `scope_type` enum('account','role','user','container') NOT NULL DEFAULT 'user',
  `scope_container_id` int(11) unsigned DEFAULT NULL,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `role` varchar(20) NOT NULL,
  `date_added` datetime NOT NULL,
  `forced_by_digicert` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `acct_id` (`acct_id`),
  KEY `auth_type` (`auth_type`),
  KEY `scope_type` (`scope_type`),
  KEY `user_id` (`user_id`),
  KEY `role` (`role`),
  KEY `forced_by_digicert` (`forced_by_digicert`)
) ENGINE=InnoDB AUTO_INCREMENT=16499 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `tool_logs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `host` varchar(255) DEFAULT NULL,
  `tool` varchar(25) DEFAULT NULL,
  `time_requested` datetime DEFAULT NULL,
  `ip1` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `ip2` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `ip3` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `ip4` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `data` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `host` (`host`(12),`tool`(2))
) ENGINE=InnoDB AUTO_INCREMENT=1939427 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `ui_stored_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `date_created` timestamp NOT NULL DEFAULT current_timestamp(),
  `date_modified` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `name` varchar(64) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_user_name` (`user_id`,`name`)
) ENGINE=InnoDB AUTO_INCREMENT=109305 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `unborn_orders` (
  `sessionid` varchar(64) NOT NULL,
  `last_hit` datetime DEFAULT NULL,
  `order_data` text DEFAULT NULL,
  PRIMARY KEY (`sessionid`),
  KEY `idx_last_hit` (`last_hit`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `unit_bundles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` int(10) unsigned NOT NULL,
  `contract_id` int(10) unsigned NOT NULL,
  `deal_id` varchar(10) DEFAULT NULL,
  `staff_id` int(10) unsigned NOT NULL,
  `product_id` int(10) unsigned NOT NULL,
  `total_units` decimal(10,2) unsigned DEFAULT 0.00,
  `remaining_units` decimal(10,2) unsigned DEFAULT 0.00,
  `date_time` datetime DEFAULT current_timestamp(),
  `start_date` datetime NOT NULL,
  `end_date` datetime NOT NULL,
  `note` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `account_id` (`account_id`),
  KEY `contract_id` (`contract_id`),
  KEY `product_id` (`product_id`),
  KEY `start_date` (`start_date`),
  KEY `end_date` (`end_date`)
) ENGINE=InnoDB AUTO_INCREMENT=42121 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `unit_order` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `created_date` datetime NOT NULL DEFAULT current_timestamp(),
  `account_id` int(10) unsigned NOT NULL,
  `unit_account_id` int(10) unsigned DEFAULT NULL,
  `unit_contract_id` int(10) unsigned DEFAULT NULL,
  `status` varchar(32) NOT NULL,
  `cost` decimal(10,2) NOT NULL DEFAULT 0.00,
  `expiration_date` date NOT NULL,
  `notes` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_account_id` (`account_id`),
  KEY `idx_unit_account_id` (`unit_account_id`),
  KEY `idx_expiration_date` (`expiration_date`),
  KEY `idx_status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=2235 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `unit_order_bundle` (
  `unit_order_id` int(10) unsigned NOT NULL,
  `product_name_id` varchar(255) NOT NULL,
  `units` int(10) unsigned NOT NULL DEFAULT 0,
  `cost` decimal(10,2) NOT NULL DEFAULT 0.00,
  KEY `idx_unit_order_id` (`unit_order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `unit_order_transaction` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `unit_order_id` int(10) unsigned NOT NULL,
  `account_id` int(10) unsigned NOT NULL,
  `container_id` int(10) unsigned DEFAULT NULL,
  `acct_adjust_id` int(10) unsigned NOT NULL,
  `amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `tax_amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `currency` char(3) NOT NULL DEFAULT 'USD',
  `payment_type` enum('balance') NOT NULL DEFAULT 'balance',
  `transaction_date` datetime NOT NULL DEFAULT current_timestamp(),
  `transaction_type` enum('order','refund') NOT NULL DEFAULT 'order',
  PRIMARY KEY (`id`),
  KEY `idx_account_id` (`account_id`),
  KEY `idx_acct_adjust_id` (`acct_adjust_id`),
  KEY `idx_unit_id` (`unit_order_id`),
  KEY `ix_transaction_date` (`transaction_date`)
) ENGINE=InnoDB AUTO_INCREMENT=1236 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `upgrade_options` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `number` tinyint(4) NOT NULL DEFAULT 0,
  `name` varchar(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `acct_id` int(6) unsigned zerofill NOT NULL DEFAULT 000000,
  `firstname` varchar(128) DEFAULT NULL,
  `lastname` varchar(128) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `username` varchar(64) DEFAULT NULL,
  `job_title` varchar(64) DEFAULT NULL,
  `telephone` varchar(32) DEFAULT NULL,
  `telephone_extension` varchar(32) DEFAULT NULL,
  `hashpass` varchar(128) NOT NULL DEFAULT '',
  `newpass` tinyint(4) DEFAULT 1,
  `opt_in_news` tinyint(1) DEFAULT 0,
  `is_master` tinyint(1) DEFAULT 0,
  `super_access` tinyint(1) NOT NULL DEFAULT 0,
  `reseller_access` tinyint(1) NOT NULL DEFAULT 0,
  `basic_access` tinyint(1) NOT NULL DEFAULT 1,
  `recovery_admin` tinyint(1) NOT NULL DEFAULT 0,
  `status` enum('active','inactive','deleted') NOT NULL DEFAULT 'active',
  `secret_question` int(11) NOT NULL DEFAULT 0,
  `secret_answer` varchar(255) NOT NULL DEFAULT '',
  `first_ip` varchar(15) DEFAULT NULL,
  `ctime` datetime DEFAULT NULL,
  `role` varchar(200) NOT NULL,
  `ent_role` varchar(200) DEFAULT 'limited',
  `ent_unit_id` int(10) unsigned DEFAULT 0,
  `token` varchar(32) DEFAULT NULL,
  `token_time` datetime NOT NULL DEFAULT '1900-00-00 00:00:00',
  `last_verified` datetime DEFAULT '1900-00-00 00:00:00',
  `forgot_block` tinyint(4) NOT NULL DEFAULT 0,
  `consecutive_failed_logins` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `i18n_language_id` tinyint(4) unsigned DEFAULT 1,
  `agent_agreement_id` int(11) NOT NULL,
  `agent_agreement_date` datetime DEFAULT NULL,
  `last_password_change` datetime NOT NULL,
  `account_summary_email_frequency` enum('never','monthly','quarterly') NOT NULL DEFAULT 'never',
  `tfa_phone_number` varchar(40) NOT NULL,
  `is_limited_admin` tinyint(3) NOT NULL DEFAULT 0,
  `container_id` int(10) unsigned DEFAULT NULL,
  `default_payment_profile_id` int(11) DEFAULT 0,
  `last_login_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  KEY `acct_id` (`acct_id`),
  KEY `idx_email` (`email`(12)),
  KEY `token` (`token`(8)),
  KEY `container_id` (`container_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2027503 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `users_requiring_password_reset` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `reason` varchar(64) DEFAULT NULL,
  `date_created` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `ix_user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4103 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `user_company` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `company_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`company_id`),
  KEY `company_id` (`company_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1888631 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `user_contact_info` (
  `user_id` int(10) unsigned NOT NULL,
  `field` varchar(32) NOT NULL,
  `value` varchar(255) NOT NULL,
  KEY `user_id` (`user_id`),
  KEY `field` (`field`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `user_container_assignments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `container_id` int(11) NOT NULL,
  `date_created` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_container_id` (`container_id`)
) ENGINE=InnoDB AUTO_INCREMENT=38624 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `user_ent_units` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `unit_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id_idx` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=57139 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `user_google_auth_cache` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `device_id` int(11) NOT NULL DEFAULT 0,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `otp` varchar(50) NOT NULL,
  `date_time` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `device_id` (`device_id`),
  KEY `otp` (`otp`),
  KEY `date_time` (`date_time`)
) ENGINE=InnoDB AUTO_INCREMENT=471693 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `user_google_auth_devices` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `acct_id` int(8) unsigned NOT NULL DEFAULT 0,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `date_added` datetime NOT NULL,
  `date_last_used` datetime NOT NULL,
  `encrypted_secret_key` varchar(255) NOT NULL,
  `failed_attempts` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `acct_id` (`acct_id`)
) ENGINE=InnoDB AUTO_INCREMENT=29568 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `user_invite` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `date_accepted` datetime DEFAULT NULL,
  `date_processed` datetime DEFAULT NULL,
  `last_sent_date` datetime DEFAULT NULL,
  `status` varchar(16) NOT NULL,
  `invite_key` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `user_id` int(11) NOT NULL,
  `container_id` int(11) NOT NULL,
  `processor_user_id` int(11) DEFAULT NULL,
  `created_user_id` int(11) DEFAULT NULL,
  `requested_firstname` varchar(128) DEFAULT NULL,
  `requested_lastname` varchar(128) DEFAULT NULL,
  `requested_username` varchar(64) DEFAULT NULL,
  `requested_job_title` varchar(128) DEFAULT NULL,
  `requested_telephone` varchar(32) DEFAULT NULL,
  `requested_hashpass` varchar(128) NOT NULL DEFAULT '',
  `requested_secret_question` int(11) DEFAULT NULL,
  `requested_secret_answer` varchar(255) DEFAULT NULL,
  `invite_note` varchar(255) DEFAULT NULL,
  `processor_comment` varchar(255) DEFAULT NULL,
  `is_sso_only` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_user_invites_key` (`invite_key`) USING HASH,
  KEY `ix_container_id_user_id` (`container_id`,`user_id`),
  KEY `user_invite_username` (`requested_username`)
) ENGINE=InnoDB AUTO_INCREMENT=66141628 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `user_tfa_client_certs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `acct_id` int(8) unsigned NOT NULL DEFAULT 0,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `date_added` datetime NOT NULL,
  `date_last_used` datetime NOT NULL,
  `thumbprint` varchar(40) NOT NULL DEFAULT '',
  `expire_date` datetime NOT NULL,
  `issuer_dn` varchar(100) NOT NULL,
  `ca_order_id` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `acct_id` (`acct_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6585 DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `validation_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `sub_of` int(11) NOT NULL DEFAULT 0,
  `ia_qiis` tinyint(1) NOT NULL DEFAULT 1,
  `approved_staff` smallint(2) unsigned NOT NULL DEFAULT 0,
  `approved_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `ia_qiis` (`ia_qiis`)
) ENGINE=InnoDB AUTO_INCREMENT=2291 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `validation_contexts` (
  `item_id` int(11) NOT NULL,
  `context` varchar(40) DEFAULT NULL,
  `sort_order` tinyint(4) DEFAULT NULL,
  KEY `contexts_item_id` (`item_id`),
  KEY `contexts_context` (`context`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `validation_docs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `v_id` int(4) unsigned zerofill NOT NULL DEFAULT 0000,
  `filename` varchar(128) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `v_id` (`v_id`)
) ENGINE=InnoDB AUTO_INCREMENT=322 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `validation_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category` int(11) NOT NULL DEFAULT 0,
  `contexts` varchar(150) NOT NULL DEFAULT '',
  `scope` mediumtext NOT NULL,
  `country` varchar(150) NOT NULL,
  `state` varchar(150) NOT NULL,
  `city` varchar(150) NOT NULL,
  `sort_order` tinyint(4) DEFAULT NULL,
  `title` varchar(255) NOT NULL DEFAULT '',
  `url` varchar(1000) NOT NULL DEFAULT '',
  `email` varchar(255) NOT NULL DEFAULT '',
  `telephone` varchar(64) NOT NULL DEFAULT '',
  `fax` varchar(64) NOT NULL DEFAULT '',
  `snail_mail` text NOT NULL,
  `description` text NOT NULL,
  `ia_qiis` tinyint(1) NOT NULL DEFAULT 1,
  `username` varchar(128) NOT NULL,
  `password` varchar(128) NOT NULL,
  `submitted_staff` smallint(2) unsigned NOT NULL DEFAULT 0,
  `submitted_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `ov_approved_staff_1` smallint(2) unsigned NOT NULL DEFAULT 0,
  `ov_approved_time_1` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `ov_approved_staff_2` smallint(2) unsigned NOT NULL DEFAULT 0,
  `ov_approved_time_2` datetime NOT NULL,
  `ev_approved_staff_1` smallint(2) unsigned NOT NULL DEFAULT 0,
  `ev_approved_time_1` datetime NOT NULL,
  `ev_approved_staff_2` smallint(2) unsigned NOT NULL DEFAULT 0,
  `ev_approved_time_2` datetime NOT NULL,
  `post_params` mediumtext DEFAULT NULL,
  `disable_joi_state_province` tinyint(1) DEFAULT 0,
  `disable_joi_locality` tinyint(1) DEFAULT 0,
  `joi_reg_num_patterns` text DEFAULT NULL,
  `ov_status` varchar(16) NOT NULL DEFAULT 'new',
  `ev_status` varchar(16) NOT NULL DEFAULT 'new',
  `joi_reg_num_regex_vals` text DEFAULT '',
  `enforce_regex_check` tinyint(1) DEFAULT 1,
  `last_disclosed` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `is_disclosed` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `category` (`category`)
) ENGINE=InnoDB AUTO_INCREMENT=17622 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `validation_items_history` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `validation_item_id` int(11) NOT NULL,
  `item_json` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `is_archived` tinyint(1) NOT NULL DEFAULT 0,
  `date_updated` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_validation_item_id` (`validation_item_id`),
  KEY `idx_date_updated` (`date_updated`)
) ENGINE=InnoDB AUTO_INCREMENT=9301 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `validation_item_urls` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `validation_item_id` int(11) NOT NULL,
  `url` varchar(1000) NOT NULL DEFAULT '',
  `date_created` datetime NOT NULL DEFAULT current_timestamp(),
  `last_updated` datetime NOT NULL DEFAULT current_timestamp(),
  `staff_id` int(10) unsigned NOT NULL,
  `is_archived` tinyint(1) NOT NULL DEFAULT 0,
  `archived_reason` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `idx_validation_item_id` (`validation_item_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19283 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `validation_notes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `v_id` int(8) unsigned zerofill DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `note` text DEFAULT NULL,
  `staff_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `v_id` (`v_id`)
) ENGINE=InnoDB AUTO_INCREMENT=124 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `valid_dupe_accts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `acct_id` int(6) unsigned zerofill NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=135 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `verified_contacts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `status` enum('pending','active','inactive') NOT NULL DEFAULT 'pending',
  `user_id` int(10) NOT NULL,
  `company_id` int(11) NOT NULL,
  `acct_id` int(8) NOT NULL DEFAULT 0,
  `firstname` varchar(64) NOT NULL,
  `lastname` varchar(64) NOT NULL,
  `email` varchar(255) NOT NULL,
  `job_title` varchar(64) NOT NULL,
  `telephone` varchar(32) NOT NULL,
  `token` varchar(200) NOT NULL,
  `token_date` datetime DEFAULT NULL,
  `encrypted_data` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `status` (`status`),
  KEY `company_id` (`company_id`),
  KEY `firstname` (`firstname`),
  KEY `lastname` (`lastname`),
  KEY `token` (`token`),
  KEY `acct_id` (`acct_id`)
) ENGINE=InnoDB AUTO_INCREMENT=811131 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `verified_contact_roles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `verified_contact_id` int(11) NOT NULL DEFAULT 0,
  `checklist_role_id` int(11) NOT NULL DEFAULT 0,
  `valid_till_date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `verified_contact_id` (`verified_contact_id`),
  KEY `checklist_role_id` (`checklist_role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3450583 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `virtual_account` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `bank_number` char(4) NOT NULL,
  `branch_number` char(3) NOT NULL,
  `virtual_account_number` char(7) NOT NULL,
  `virtual_account_type` char(1) NOT NULL,
  `account_registration_date` datetime DEFAULT NULL,
  `using_start_date` datetime DEFAULT NULL,
  `account_id` int(10) unsigned DEFAULT NULL,
  `container_id` int(10) unsigned DEFAULT NULL,
  `status` varchar(2) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `staff_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_virtual_account_1` (`account_id`,`container_id`),
  KEY `idx_virtual_account_2` (`bank_number`,`branch_number`,`status`,`update_date`)
) ENGINE=InnoDB AUTO_INCREMENT=100001 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `virtual_account_bank_master` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `bank_number` char(4) NOT NULL,
  `branch_number` char(3) NOT NULL,
  `bank_name` varchar(64) NOT NULL,
  `branch_name` varchar(64) NOT NULL,
  `account_name` varchar(64) NOT NULL,
  `update_date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_virtual_account_bank_master` (`bank_number`,`branch_number`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `virtual_account_history` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `virtual_account_id` int(10) unsigned NOT NULL,
  `bank_number` char(4) NOT NULL,
  `branch_number` char(3) NOT NULL,
  `virtual_account_number` char(7) NOT NULL,
  `virtual_account_type` char(1) NOT NULL,
  `using_start_date` datetime DEFAULT NULL,
  `account_id` int(10) unsigned DEFAULT NULL,
  `container_id` int(10) unsigned DEFAULT NULL,
  `status` varchar(2) NOT NULL,
  `update_date` datetime NOT NULL,
  `staff_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31121 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `virtual_account_release` (
  `virtual_account_id` int(10) unsigned NOT NULL,
  `account_id` int(10) unsigned NOT NULL,
  `update_date` datetime NOT NULL,
  PRIMARY KEY (`virtual_account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `voucher_code` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `voucher_order_id` int(10) unsigned NOT NULL,
  `code` varchar(64) NOT NULL,
  `account_id` int(10) unsigned DEFAULT NULL,
  `product_name_id` varchar(255) NOT NULL,
  `no_of_fqdns` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `no_of_wildcards` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `shipping_method` tinyint(3) unsigned DEFAULT NULL,
  `validity_days` smallint(5) unsigned DEFAULT NULL,
  `validity_years` tinyint(3) unsigned DEFAULT NULL,
  `created_date` datetime NOT NULL DEFAULT current_timestamp(),
  `start_date` date DEFAULT NULL,
  `expiry_date` date DEFAULT NULL,
  `use_san_package` tinyint(1) DEFAULT NULL,
  `status` varchar(32) NOT NULL,
  `group_id` smallint(5) unsigned NOT NULL DEFAULT 1,
  `cost` decimal(10,2) NOT NULL DEFAULT 0.00,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_voucher_code` (`code`),
  KEY `idx_account_id` (`account_id`),
  KEY `idx_status` (`status`),
  KEY `idx_group_id` (`group_id`),
  KEY `idx_vo_id` (`voucher_order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=31617 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `voucher_code_orders` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `voucher_code_id` int(10) unsigned DEFAULT NULL,
  `order_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_order_id` (`order_id`),
  KEY `idx_voucher_code_id` (`voucher_code_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19888 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `voucher_code_reissued` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `voucher_code_id` int(10) unsigned NOT NULL,
  `reissued_code` varchar(64) NOT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  `created_date` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_reissued_code` (`reissued_code`),
  KEY `idx_voucher_code_id` (`voucher_code_id`),
  KEY `idx_user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `voucher_order` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `created_date` datetime NOT NULL DEFAULT current_timestamp(),
  `account_id` int(10) unsigned NOT NULL,
  `status` varchar(32) NOT NULL,
  `cost` decimal(10,2) NOT NULL DEFAULT 0.00,
  `cost_plus_tax` decimal(18,2) NOT NULL DEFAULT 0.00,
  `name` varchar(128) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `expiration_date` date NOT NULL,
  `codes_count` smallint(5) unsigned NOT NULL DEFAULT 0,
  `redeemed_count` smallint(5) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `idx_account_id` (`account_id`),
  KEY `idx_expiration_date` (`expiration_date`)
) ENGINE=InnoDB AUTO_INCREMENT=18162 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `voucher_order_transaction` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `voucher_order_id` int(10) unsigned DEFAULT NULL,
  `account_id` int(10) NOT NULL,
  `container_id` int(10) unsigned DEFAULT NULL,
  `receipt_id` int(10) unsigned DEFAULT NULL,
  `acct_adjust_id` int(10) unsigned DEFAULT NULL,
  `invoice_id` int(10) unsigned DEFAULT 0,
  `amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `currency` char(3) NOT NULL DEFAULT 'USD',
  `payment_type` varchar(50) NOT NULL,
  `transaction_date` datetime NOT NULL DEFAULT current_timestamp(),
  `transaction_type` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_account_id` (`account_id`),
  KEY `idx_acct_ajust_id` (`acct_adjust_id`),
  KEY `idx_receipt_id` (`receipt_id`),
  KEY `idx_vo_id` (`voucher_order_id`),
  KEY `ix_transaction_date` (`transaction_date`),
  KEY `idx_invoice_id` (`invoice_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17688 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `voucher_receipt_tax` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `receipt_id` int(10) unsigned NOT NULL DEFAULT 0,
  `voucher_order_id` int(10) unsigned NOT NULL DEFAULT 0,
  `group_id` smallint(5) unsigned NOT NULL DEFAULT 0,
  `product_id` int(11) NOT NULL DEFAULT 0,
  `quantity` smallint(5) unsigned NOT NULL DEFAULT 0,
  `tax_amount` decimal(18,2) NOT NULL DEFAULT 0.00,
  `gross_amount` decimal(18,2) NOT NULL DEFAULT 0.00,
  PRIMARY KEY (`id`),
  KEY `ix_receipt_id` (`receipt_id`),
  KEY `ix_voucher_order_id` (`voucher_order_id`),
  KEY `ix_group_id` (`group_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1942 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `vt_api_call` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` date DEFAULT NULL,
  `api_count` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=269921 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `vt_report_data` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` varchar(255) DEFAULT NULL,
  `order_status` varchar(255) DEFAULT NULL,
  `report_status` varchar(255) DEFAULT NULL,
  `scan_date` date DEFAULT NULL,
  `serial_number` varchar(255) DEFAULT NULL,
  `file_hashes` varchar(255) DEFAULT NULL,
  `data` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5531 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `vt_report_query` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `query_name` varchar(50) NOT NULL DEFAULT '',
  `query_type` varchar(10) NOT NULL DEFAULT 'POSTAUTH',
  `query_text` text DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `changed_by` varchar(45) DEFAULT NULL,
  `comments` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `weak_keys` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ip` varchar(16) DEFAULT NULL,
  `page` varchar(64) DEFAULT NULL,
  `username` varchar(64) DEFAULT NULL,
  `acct_id` int(11) DEFAULT NULL,
  `csr` text DEFAULT NULL,
  `date_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=199 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `weak_keys_all` (
  `id` int(11) NOT NULL,
  `keysize` smallint(5) unsigned NOT NULL DEFAULT 0,
  `seed` smallint(5) unsigned NOT NULL DEFAULT 0,
  `seed_type` enum('rnd','nornd','noreadrnd','') NOT NULL DEFAULT '',
  `arch` enum('ppc64','i386','x86_64','') NOT NULL DEFAULT '',
  `hash1` int(10) unsigned NOT NULL DEFAULT 0,
  `hash2` int(10) unsigned NOT NULL DEFAULT 0,
  `hash3` int(10) unsigned NOT NULL DEFAULT 0,
  `hash4` int(10) unsigned NOT NULL DEFAULT 0,
  `hash5` int(10) unsigned NOT NULL DEFAULT 0,
  KEY `weak_keys_all_hash1` (`hash1`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `whois_batch` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime DEFAULT NULL,
  `account_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `product_id` int(10) unsigned NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=83 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `whois_cache` (
  `domain` varchar(255) NOT NULL,
  `emails` text DEFAULT NULL,
  `whois_output` text DEFAULT NULL,
  `cache_time` datetime DEFAULT NULL,
  `alexa_rank` int(11) DEFAULT NULL,
  PRIMARY KEY (`domain`),
  KEY `cache_time` (`cache_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `whois_contact` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime DEFAULT NULL,
  `whois_record_id` int(10) unsigned NOT NULL,
  `contact_type` varchar(50) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `address_country` varchar(255) DEFAULT NULL,
  `phone` varchar(30) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `clean_phone` varchar(255) DEFAULT NULL,
  `phone_extension` varchar(255) DEFAULT NULL,
  `raa_type` varchar(255) DEFAULT NULL,
  `se_exists` int(1) DEFAULT NULL,
  `se_allowed_chars` int(1) DEFAULT NULL,
  `se_at_char` int(1) DEFAULT NULL,
  `se_domain` int(1) DEFAULT NULL,
  `se_local` int(1) DEFAULT NULL,
  `se_format` int(1) DEFAULT NULL,
  `se_resolvable` int(1) DEFAULT NULL,
  `se_syn_success` int(1) DEFAULT NULL,
  `se_anomaly_detected` int(1) DEFAULT NULL,
  `oe_valid` int(1) DEFAULT NULL,
  `oe_server` int(1) DEFAULT NULL,
  `st_exists` int(1) DEFAULT NULL,
  `st_cc_present` int(1) DEFAULT NULL,
  `st_cc_format` int(1) DEFAULT NULL,
  `st_not_short` int(1) DEFAULT NULL,
  `st_not_long` int(1) DEFAULT NULL,
  `st_allowed_length` int(1) DEFAULT NULL,
  `st_allowed_chars` int(1) DEFAULT NULL,
  `st_extension_present` int(1) DEFAULT NULL,
  `st_extension_char` int(1) DEFAULT NULL,
  `st_extension_format` int(1) DEFAULT NULL,
  `st_2009_success` int(1) DEFAULT NULL,
  `st_2013_success` int(1) DEFAULT NULL,
  `st_syn_success` int(1) DEFAULT NULL,
  `ot_valid` int(1) DEFAULT NULL,
  `ot_dial_early` int(1) DEFAULT NULL,
  `ot_connected` int(1) DEFAULT NULL,
  `ot_busy` int(1) DEFAULT NULL,
  `ot_disconnected` int(1) DEFAULT NULL,
  `ot_all_circuits` int(1) DEFAULT NULL,
  `ot_invalid` int(1) DEFAULT NULL,
  `ot_success` int(1) DEFAULT NULL,
  `se_2009_success` tinyint(4) DEFAULT NULL,
  `se_2013_success` tinyint(4) DEFAULT NULL,
  `st_prepended_zero` int(1) DEFAULT NULL,
  `early_phone` varchar(50) DEFAULT NULL,
  `st_op_syn_success` int(1) DEFAULT NULL,
  `ot_non_digit_char` int(1) DEFAULT NULL,
  `st_local_zero` int(1) DEFAULT NULL,
  `ot_2009_success` int(1) DEFAULT NULL,
  `ot_2013_success` int(1) DEFAULT NULL,
  `ot_retries` tinyint(4) DEFAULT 0,
  `oe_blocked` tinyint(4) DEFAULT NULL,
  `oe_2009_success` tinyint(4) DEFAULT NULL,
  `oe_2013_success` tinyint(4) DEFAULT NULL,
  `oe_success` tinyint(4) DEFAULT NULL,
  `email_domain_part` varchar(255) DEFAULT NULL,
  `email_local_part` varchar(255) DEFAULT NULL,
  `address_city` varchar(255) DEFAULT NULL,
  `address_state` varchar(255) DEFAULT NULL,
  `address_zip` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_whois_record_id` (`whois_record_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1091470 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `whois_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `doc_id` int(11) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `org_name` varchar(255) DEFAULT NULL,
  `staff_id` int(11) DEFAULT 0,
  `whois_type` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `doc_id` (`doc_id`)
) ENGINE=InnoDB AUTO_INCREMENT=555410 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `whois_record` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime DEFAULT NULL,
  `domain` varchar(255) DEFAULT NULL,
  `batch_id` int(10) unsigned NOT NULL DEFAULT 0,
  `product_id` int(10) unsigned NOT NULL,
  `date_completed` datetime DEFAULT NULL,
  `approved_staff_id` int(10) unsigned DEFAULT NULL,
  `open_date` datetime DEFAULT NULL,
  `open_by_staff_id` int(10) unsigned DEFAULT NULL,
  `original_record` text DEFAULT NULL,
  `whois_date_created` varchar(255) DEFAULT NULL,
  `whois_date_updated` varchar(255) DEFAULT NULL,
  `raa_gfather` int(1) DEFAULT NULL,
  `ot_common` int(1) DEFAULT NULL,
  `oe_duplicates` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `domain` (`domain`(8)),
  KEY `ix_batch_id` (`batch_id`),
  KEY `date_completed` (`date_completed`)
) ENGINE=InnoDB AUTO_INCREMENT=363824 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `wifi_friendlynames` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `language` char(3) NOT NULL,
  `friendlyname` text NOT NULL,
  `encoded_friendlyname` text DEFAULT NULL,
  `verified_contact_id` int(11) NOT NULL,
  `date_created` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=216 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `wip_queue` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `position` bigint(20) DEFAULT NULL,
  `entity_type` varchar(50) NOT NULL,
  `entity_id` int(11) NOT NULL,
  `reissue_id` int(11) DEFAULT NULL,
  `checklist_id` int(11) DEFAULT NULL,
  `priority` tinyint(4) DEFAULT 1,
  `created_date` datetime NOT NULL,
  `sleep_until` datetime DEFAULT NULL,
  `dibs_date` datetime DEFAULT NULL,
  `dibs_staff_id` int(11) DEFAULT NULL,
  `origin` varchar(50) DEFAULT NULL,
  `work_type` varchar(50) DEFAULT NULL,
  `work_status` varchar(50) DEFAULT NULL,
  `product_group` varchar(50) DEFAULT NULL,
  `org_country` varchar(50) DEFAULT NULL,
  `untouched` tinyint(4) DEFAULT 1,
  `parent_reservation_id` int(11) DEFAULT NULL,
  `last_checked` timestamp NULL DEFAULT NULL,
  `BRAND` varchar(25) DEFAULT NULL,
  `timezone` varchar(50) DEFAULT '',
  `premium` tinyint(4) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `idx_priority` (`priority`),
  KEY `idx_entity_id` (`entity_id`),
  KEY `idx_dibs_staff_id` (`dibs_staff_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8773472 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `wip_queue_assignment_definition` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `work_types` varchar(255) DEFAULT NULL,
  `work_statuses` varchar(255) DEFAULT NULL,
  `product_groups` varchar(255) DEFAULT NULL,
  `origins` varchar(255) DEFAULT NULL,
  `org_countries` varchar(255) DEFAULT NULL,
  `brands` varchar(255) DEFAULT NULL,
  `exclude_org_countries` varchar(255) DEFAULT NULL,
  `business_hours_only` tinyint(4) NOT NULL DEFAULT 0,
  `account_ids` varchar(255) DEFAULT NULL,
  `premium` varchar(3) NOT NULL DEFAULT '*',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=328 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `wip_queue_assignment_templates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `assignment_json` text NOT NULL,
  `date_created` datetime NOT NULL,
  `created_by_staff_id` int(10) unsigned DEFAULT NULL,
  `date_last_modified` datetime DEFAULT NULL,
  `last_modified_by_staff_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `wip_queue_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `wip_queue_id` int(11) DEFAULT NULL,
  `staff_id` int(11) DEFAULT NULL,
  `event` varchar(255) DEFAULT NULL,
  `timestamp` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `wip_queue_id` (`wip_queue_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3641487 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `wip_queue_reports` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `staff_id` int(11) DEFAULT NULL,
  `group_by` varchar(255) DEFAULT NULL,
  `sorted_group_by` varchar(255) DEFAULT NULL,
  `chart_type` varchar(255) DEFAULT NULL,
  `include_total` tinyint(4) DEFAULT NULL,
  `filters` text DEFAULT NULL,
  `last_result` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `wip_queue_report_preferences` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `wip_queue_report_id` int(11) NOT NULL,
  `staff_id` int(11) NOT NULL,
  `star` tinyint(4) DEFAULT 0,
  `hide` tinyint(4) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_report_staff` (`wip_queue_report_id`,`staff_id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `wip_queue_staff_assignments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `staff_id` int(11) NOT NULL,
  `wip_queue_assignment_definition_id` int(11) NOT NULL,
  `priority` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=54487 DEFAULT CHARSET=utf8;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
