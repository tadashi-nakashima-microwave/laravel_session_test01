
# This is a fix for InnoDB in MySQL >= 4.1.x
# It "suspends judgement" for fkey relationships until are tables are set.
SET FOREIGN_KEY_CHECKS = 0;

# addhoc fix by K.Hirai 2012/02/06
SET NAMES utf8;


#-----------------------------------------------------------------------------
#-- about
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `about`;


CREATE TABLE `about`
(
	`id` INTEGER(8)  NOT NULL AUTO_INCREMENT,
	`title` VARCHAR(30),
	`text` TEXT,
	`admission` TINYINT,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`)
);

#-----------------------------------------------------------------------------
#-- admin_user
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `admin_user`;


CREATE TABLE `admin_user`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	`status` TINYINT UNSIGNED default 1 NOT NULL,
	`login_name` VARCHAR(30) COMMENT '登録名',
	`sha1_password` VARCHAR(64)  NOT NULL,
	`salt` VARCHAR(32),
	`name` VARCHAR(30) COMMENT 'ID',
	`memo` VARCHAR(512) COMMENT 'メモ',
	`mail` VARCHAR(120) COMMENT 'mailaddress',
	`type` VARCHAR(100),
	`admin_role_id` INTEGER COMMENT 'ロール権限ID',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	`logined_at` DATETIME,
	`permitted_page_ids` VARCHAR(512),
	PRIMARY KEY (`id`),
	UNIQUE KEY `admin_user_U_1` (`login_name`)
);

#-----------------------------------------------------------------------------
#-- admin_session
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `admin_session`;


CREATE TABLE `admin_session`
(
	`id` VARCHAR(255)  NOT NULL COMMENT 'セッションID ランダム文字列',
	`data` TEXT  NOT NULL COMMENT 'symfonyのセッションデータ',
	`updated_at` DATETIME,
	PRIMARY KEY (`id`)
) COMMENT='総合管理画面用セッション情報';

#-----------------------------------------------------------------------------
#-- agreement
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `agreement`;


CREATE TABLE `agreement`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	`number_id` INTEGER,
	`title` VARCHAR(60),
	`text` TEXT,
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`)
);

#-----------------------------------------------------------------------------
#-- area
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `area`;


CREATE TABLE `area`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	`display_order` INTEGER,
	`name` VARCHAR(40),
	`memo` VARCHAR(200),
	`updated_at` DATETIME,
	PRIMARY KEY (`id`)
);

#-----------------------------------------------------------------------------
#-- auth
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `auth`;


CREATE TABLE `auth`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	`service_id` SMALLINT,
	`status` TINYINT,
	`memo` VARCHAR(200),
	`attention` VARCHAR(160),
	`auth_0` VARCHAR(20),
	`auth_1` VARCHAR(20),
	`auth_2` VARCHAR(20),
	`auth_3` VARCHAR(20),
	`auth_4` VARCHAR(20),
	`auth_5` VARCHAR(20),
	`auth_6` VARCHAR(20),
	`auth_7` VARCHAR(20),
	`auth_8` VARCHAR(20),
	`auth_9` VARCHAR(20),
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`)
);

#-----------------------------------------------------------------------------
#-- disclaimer
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `disclaimer`;


CREATE TABLE `disclaimer`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	`text` TEXT,
	`order` INTEGER,
	`admission` TINYINT,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`)
);

#-----------------------------------------------------------------------------
#-- faq_category
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `faq_category`;


CREATE TABLE `faq_category`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	`name` VARCHAR(40),
	`order` SMALLINT,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`)
);

#-----------------------------------------------------------------------------
#-- faq
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `faq`;


CREATE TABLE `faq`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	`faq_category_id` INTEGER,
	`service_id` SMALLINT,
	`title` VARCHAR(255),
	`text` TEXT,
	`order` INTEGER,
	`admission` TINYINT,
	`pickup` TINYINT,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	INDEX `faq_FI_1` (`faq_category_id`)
);

#-----------------------------------------------------------------------------
#-- category
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `category`;


CREATE TABLE `category`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	`name` VARCHAR(40),
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`)
);

#-----------------------------------------------------------------------------
#-- admin_page
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `admin_page`;


CREATE TABLE `admin_page`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	`name` VARCHAR(40),
	`url` VARCHAR(100),
	`route_names` TEXT,
	`category_id` INTEGER,
	`page_parent_id` INTEGER,
	`memo` VARCHAR(255),
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	INDEX `admin_page_FI_1` (`category_id`)
);

#-----------------------------------------------------------------------------
#-- admin_user_page
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `admin_user_page`;


CREATE TABLE `admin_user_page`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	`admin_user_id` INTEGER,
	`admin_page_id` INTEGER  NOT NULL,
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	INDEX `admin_user_page_FI_1` (`admin_user_id`),
	INDEX `admin_user_page_FI_2` (`admin_page_id`)
);

#-----------------------------------------------------------------------------
#-- prefecture
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `prefecture`;


CREATE TABLE `prefecture`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	`area_id` SMALLINT,
	`display_order` TINYINT,
	`name` VARCHAR(10),
	`memo` VARCHAR(200),
	`updated_at` DATETIME,
	PRIMARY KEY (`id`)
);

#-----------------------------------------------------------------------------
#-- service
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `service`;


CREATE TABLE `service`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	`name` VARCHAR(30),
	`auth_flag` TINYINT,
	`status` TINYINT,
	`owner_pc_url` VARCHAR(255),
	`owner_mb_url` VARCHAR(255),
	`shop_pc_url` VARCHAR(255),
	`shop_mb_url` VARCHAR(255),
	`member_pc_url` VARCHAR(255),
	`member_mb_url` VARCHAR(255),
	`updated_at` DATETIME,
	PRIMARY KEY (`id`)
);

#-----------------------------------------------------------------------------
#-- shop_information
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `shop_information`;


CREATE TABLE `shop_information`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	`service_id` SMALLINT,
	`disp_type` TINYINT,
	`xl_category_id` TINYINT,
	`big_category_id` INTEGER,
	`mid_category_id` INTEGER,
	`title` VARCHAR(60),
	`text` TEXT,
	`important` TINYINT,
	`admission` TINYINT,
	`display_date` DATETIME,
	`disp_from` DATETIME,
	`disp_to` DATETIME,
	`updated_at` DATETIME,
	`created_at` DATETIME,
	PRIMARY KEY (`id`)
);

#-----------------------------------------------------------------------------
#-- i_faspa_redirect
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `i_faspa_redirect`;


CREATE TABLE `i_faspa_redirect`
(
	`id_type` TINYINT(3) UNSIGNED  NOT NULL COMMENT 'ID種別 1:店舗 2:ブランド 3:時間割予約店舗',
	`redirect_id` INTEGER(11) UNSIGNED  NOT NULL COMMENT '店舗・ブランドなどID',
	`redirect_distinction` TINYINT(3) UNSIGNED  NOT NULL COMMENT 'リダイレクト区別 1:SP 2:PC',
	`redirect_url` VARCHAR(200)  NOT NULL COMMENT 'リダイレクト先URL',
	`created_at` DATETIME  NOT NULL COMMENT '作成年月日',
	`updated_at` DATETIME  NOT NULL COMMENT '更新年月日',
	PRIMARY KEY (`id_type`,`redirect_id`,`redirect_distinction`)
) COMMENT='I_ファスパリダイレクト情報';

#-----------------------------------------------------------------------------
#-- i_shop_tp_inf
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `i_shop_tp_inf`;


CREATE TABLE `i_shop_tp_inf`
(
	`shop_tp_inf_id` INTEGER  NOT NULL AUTO_INCREMENT COMMENT '店舗タッチパネルお知らせID',
	`xl_category_id` TINYINT,
	`big_category_id` INTEGER,
	`mid_category_id` INTEGER,
	`inf_title` VARCHAR(100),
	`inf_body` VARCHAR(512),
	`inf_url` VARCHAR(512),
	`dsp_order` INTEGER,
	`tp_inf_dsp_sts` TINYINT COMMENT '表示ステータス。0:非承認、1:承認',
	`disp_from` DATETIME,
	`disp_to` DATETIME,
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`shop_tp_inf_id`)
) COMMENT='店舗タッチパネルお知らせ';

#-----------------------------------------------------------------------------
#-- mobile_manual
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `mobile_manual`;


CREATE TABLE `mobile_manual`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT COMMENT 'モバイルマニュアルID',
	`title` VARCHAR(255)  NOT NULL COMMENT 'タイトル',
	`display_order` INTEGER COMMENT '表示順',
	`admission` TINYINT default 0 COMMENT '承認ステータス。0:非承認、1:承認',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`)
) COMMENT='モバイルマニュアル保存テーブル';

#-----------------------------------------------------------------------------
#-- shop_mail
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `shop_mail`;


CREATE TABLE `shop_mail`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	`shop_id` INTEGER(8) COMMENT '店舗ID',
	`coupon_id` BIGINT COMMENT 'クーポンID',
	`status` TINYINT,
	`is_send` TINYINT COMMENT '送信済みフラグ 0:未送信 1:送信済み',
	`send_type` TINYINT,
	`send_number` INTEGER(5) COMMENT '配信No',
	`sender` VARCHAR(64),
	`subject` VARCHAR(100),
	`header` VARCHAR(2048),
	`text` VARCHAR(8192),
	`text_html` TEXT COMMENT 'メール内容(HTML)',
	`footer` VARCHAR(2048),
	`target_type` TINYINT default 0 NOT NULL COMMENT '配信対象種別 0: 条件指定 1: ID指定',
	`src_sex` TINYINT,
	`src_age_from` INTEGER(3),
	`src_age_to` INTEGER(3),
	`src_birth_m` SMALLINT,
	`src_birth_d` SMALLINT,
	`src_pref_id` TINYINT,
	`src_visit_from` DATETIME,
	`src_visit_to` DATETIME,
	`src_entry_from` DATETIME,
	`src_entry_to` DATETIME,
	`src_member_rank` TINYINT COMMENT '会員ランク 1:ダイヤモンド 2:プラチナ 3:ゴールド 4:シルバー 5:ブロンズ',
	`src_point_grant_date_from` DATETIME COMMENT 'ポイント付与日(from)',
	`src_point_grant_date_to` DATETIME COMMENT 'ポイント付与日(to)',
	`avg_unt_cst_from` INTEGER COMMENT '開始平均単価',
	`avg_unt_cst_to` INTEGER COMMENT '終了平均単価',
	`midclass_id` INTEGER COMMENT 'メニュー中分類ID',
	`src_num` INTEGER(3) COMMENT '利用者数',
	`src_phone_number` VARCHAR(20) COMMENT '配信対象者の携帯電話番号',
	`src_chg_startyear` INTEGER UNSIGNED COMMENT '配信対象者の機種変更_開始年',
	`src_chg_startmonth` TINYINT COMMENT '配信対象者の機種変更_開始月',
	`src_chg_startday` TINYINT COMMENT '配信対象者の機種変更_開始日',
	`src_chg_endyear` INTEGER UNSIGNED COMMENT '配信対象者の機種変更_終了年',
	`src_chg_endmonth` TINYINT COMMENT '配信対象者の機種変更_終了月',
	`src_chg_endday` TINYINT COMMENT '配信対象者の機種変更_終了日',
	`src_last_startyear` INTEGER UNSIGNED COMMENT '配信対象者の最終ログイン_開始年',
	`src_last_startmonth` TINYINT COMMENT '配信対象者の最終ログイン_開始月',
	`src_last_startday` TINYINT COMMENT '配信対象者の最終ログイン_開始日',
	`src_last_endyear` INTEGER UNSIGNED COMMENT '配信対象者の最終ログイン_終了年',
	`src_last_endmonth` TINYINT COMMENT '配信対象者の最終ログイン_終了月',
	`src_last_endday` TINYINT COMMENT '配信対象者の最終ログイン_終了日',
	`src_visit_ranking_status` TINYINT default 0 COMMENT '来店回数ランキング(0:指定なし 1:集計期間月単位 2:集計期間週単位)',
	`src_visit_ranking_date_from` DATETIME COMMENT '集計期間(開始)',
	`src_visit_ranking_date_to` DATETIME COMMENT '集計期間(未満)',
	`src_visit_ranking_from` INTEGER(3) COMMENT '上位何位から',
	`src_visit_ranking_to` INTEGER(3) COMMENT '上位何位まで',
	`send_date` DATETIME,
	`send_start` DATETIME COMMENT '送信開始時間',
	`send_end` DATETIME COMMENT '送信終了時間',
	`send_num` INTEGER(8) COMMENT '配信数',
	`auth_status` TINYINT default 0 NOT NULL COMMENT '承認状態 0:承認不要, 1:承認済み, 2:承認待ち, 3:差戻し',
	`mail_template_id` INTEGER COMMENT 'メールテンプレートID',
	`send_condition_type` TINYINT default 0 COMMENT '配信条件種別タイプ 0:最終来店 1:初回来店 2:期限切れ告知',
	`send_condition_span_1` TINYINT COMMENT '配信条件1 期間',
	`send_condition_unit_1` TINYINT COMMENT '配信条件1 単位 1:ヶ月 2:日',
	`send_condition_span_2` TINYINT COMMENT '配信条件2 期間',
	`send_condition_unit_2` TINYINT COMMENT '配信条件2 単位 1:ヶ月 2:日',
	`send_condition_span_3` TINYINT COMMENT '配信条件3 期間',
	`send_condition_unit_3` TINYINT COMMENT '配信条件3 単位 1:ヶ月 2:日',
	`send_condition_span_4` TINYINT COMMENT '配信条件4 期間',
	`send_condition_unit_4` TINYINT COMMENT '配信条件4 単位 1:ヶ月 2:日',
	`send_condition_span_5` TINYINT COMMENT '配信条件5 期間',
	`send_condition_unit_5` TINYINT COMMENT '配信条件5 単位 1:ヶ月 2:日',
	`send_html_mail` TINYINT default 0 NOT NULL COMMENT 'HTMLメールかどうか 0:テキストメール, 1:HTMLメール',
	`use_coupon_status` TINYINT default 0 NOT NULL COMMENT '利用できるクーポンの数 0:どれかひとつ 1:それぞれの個別指定に従う',
	`common_coupon_limit_status` TINYINT default 0 NOT NULL COMMENT '複数クーポン配信制限共通設定 0:共通 1:個別',
	`qr_point_status` TINYINT default 0 NOT NULL COMMENT 'QRポイントメールフラグ 0: 通常メール 1: QRポイントメール',
	`qr_point_num` INTEGER COMMENT 'QR来店ポイント付与数',
	`qr_point_term_start` DATETIME COMMENT 'QR来店ポイント付与期限（開始）',
	`qr_point_term_end` DATETIME COMMENT 'QR来店ポイント付与期限（終了）',
	`shop_member_card_not_have_check` TINYINT default 0 COMMENT '会員証未発行の会員のみ 0: 指定なし 1: 指定あり',
	`point_has_not_give_yet_check` TINYINT default 0 COMMENT '未付与の会員のみ（会員証発行後まだかざしていない） 0:指定なし 1:指定あり',
	`last_visit_date_from` INTEGER COMMENT '開始最終来店日経過日数（メールの送信対象は最終来店日からの経過日数が開始～終了まで）',
	`last_visit_date_to` INTEGER COMMENT '終了最終来店日経過日数',
	`ttl_buy_num_from` INTEGER COMMENT '開始累計購買回数（メールの送信対象は累計購買回数が開始～終了まで）',
	`ttl_buy_num_to` INTEGER COMMENT '終了累計購買回数',
	`analysis_category` TINYINT UNSIGNED COMMENT '分析カテゴリ 1:優良、2:固定、3:新規・休眠、4:見込み、5:疎遠、6:不信、7:一見',
	`shop_rsv_dptm_id` INTEGER(10) default 0 COMMENT '部門ID(自動車ph6)',
	`shop_rsv_ct_opt_id_1` INTEGER(10) default 0 COMMENT '予約カテゴリID_1(自動車ph6)',
	`shop_rsv_ct_opt_id_2` INTEGER(10) default 0 COMMENT '予約カテゴリID_2(自動車ph6)',
	`shop_rsv_ct_opt_id_3` INTEGER(10) default 0 COMMENT '予約カテゴリID_3(自動車ph6)',
	`shop_rsv_ct_opt_id_4` INTEGER(10) default 0 COMMENT '予約カテゴリID_4(自動車ph6)',
	`shop_rsv_ct_opt_id_5` INTEGER(10) default 0 COMMENT '予約カテゴリID_5(自動車ph6)',
	`repeat_type` TINYINT default 0 COMMENT 'メール種別 1:初回特典メール 2:誕生日メール 3:リピートメール 4:ステップメール 5:来店がない人メール 6:有効期限切れ告知メール 7:車検リマインドメール(自動車ph6)',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	KEY `index_shop_id`(`shop_id`),
	KEY `index_shop_mail_1`(`status`, `is_send`, `src_num`, `send_date`),
	KEY `index_coupon_id`(`coupon_id`),
	KEY `index_is_send`(`is_send`)
) COMMENT='店舗のメール送信設定件送信履歴';

#-----------------------------------------------------------------------------
#-- shop_mail_config
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `shop_mail_config`;


CREATE TABLE `shop_mail_config`
(
	`shop_id` INTEGER(8) COMMENT '店舗ＩＤ',
	`sender_nml` VARCHAR(64) COMMENT '通常メール差出人名',
	`title_nml` VARCHAR(60) COMMENT '通常メール初期タイトル設定値',
	`header_nml` TEXT COMMENT '通常メールヘッダテキスト',
	`footer_nml` TEXT COMMENT '通常メールフッタテキスト',
	`sender_cpn` VARCHAR(64) COMMENT 'クーポンメール差出人',
	`title_cpn` VARCHAR(60) COMMENT 'クーポンメール初期タイトル設定値',
	`header_cpn` TEXT COMMENT 'クーポンメールヘッダテキスト',
	`footer_cpn` TEXT COMMENT 'クーポンメールフッタテキスト',
	`coupon_number_status` TINYINT default 1 NOT NULL COMMENT 'クーポンを番号表示 設定 0:非表示 1:表示',
	`coupon_mobile_exchange_button_status` TINYINT default 0 NOT NULL COMMENT 'クーポンを使用済にするボタンの表示 設定 0:非表示 1:表示',
	`test_mail_to` VARCHAR(1024) COMMENT 'テストメール送信先アドレス（複数選択の場合は改行区切り）',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	PRIMARY KEY (`id`)
);

#-----------------------------------------------------------------------------
#-- shop_mail_temp
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `shop_mail_temp`;


CREATE TABLE `shop_mail_temp`
(
	`shop_id` INTEGER(8) COMMENT '店舗ID',
	`session` VARCHAR(50),
	`email` VARCHAR(100),
	`created_at` DATETIME,
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	PRIMARY KEY (`id`)
);

#-----------------------------------------------------------------------------
#-- epark_admin
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `epark_admin`;


CREATE TABLE `epark_admin`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	`from` VARCHAR(200) COMMENT '送信元アドレス',
	`subject` VARCHAR(200) COMMENT 'タイトル',
	`msg` TEXT COMMENT '本文',
	`ins_dt` DATETIME COMMENT '作成(メール受信)日時',
	`mail_status` INTEGER(1) COMMENT '0未処理,1停止(メールの内容が だと思う),2 退会,3 問い合わせ,9 無視 (不達通知(MAILER-DAEMON)なども)メール受信時に自動的に設定されるのは、0または9',
	`upd_dt` DATETIME COMMENT '更新日時(総合管理画面でmail_statusを変更した日時)',
	`downloaded_at` DATETIME COMMENT 'データをダウンロードした日付。停止・退会・問い合わせの状態のものがダウンロード可能',
	PRIMARY KEY (`id`),
	KEY `index_epark_admin_I_1`(`mail_status`, `ins_dt`)
);

#-----------------------------------------------------------------------------
#-- mt_admin
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `mt_admin`;


CREATE TABLE `mt_admin`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	`from` VARCHAR(200),
	`subject` VARCHAR(200),
	`msg` TEXT,
	`ins_dt` DATETIME,
	PRIMARY KEY (`id`)
);

#-----------------------------------------------------------------------------
#-- t_mail_delivery
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `t_mail_delivery`;


CREATE TABLE `t_mail_delivery`
(
	`mail_delivery_id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT 'MAIL配信ID',
	`delivery_title` VARCHAR(80)  NOT NULL COMMENT 'MAIL配信タイトル',
	`delivery_status` TINYINT UNSIGNED default 0 NOT NULL COMMENT 'MAIL配信ステータス 0: 承認待ち（計算中）、1:承認待ち、2:承認、3:否認、4: 再承認待ち（計算中）、5:再承認待ち、6:CSV待機中 7:CSV作成中、8:CSV作成済、9:コピー中、10:配信済',
	`create_user_id` INTEGER  NOT NULL COMMENT '作成者ID ログインユーザーID（admin_user.id）',
	`update_user_id` INTEGER COMMENT '更新者ID ログインユーザーID（admin_user.id）',
	`approve_user_id` INTEGER COMMENT '承認者ID ログインユーザーID（admin_user.id）',
	`check_user_id` INTEGER COMMENT '確認者ID ログインユーザーID（admin_user.id）',
	`select_item` VARCHAR(400) COMMENT '配信用クエリー SELECT項目',
	`delivery_query` VARCHAR(8000) COMMENT '配信用クエリー FROM句以降',
	`target_number` INTEGER UNSIGNED default 0 NOT NULL COMMENT '配信対象者数 SELECT COUNT(*) の結果',
	`delivery_at` DATETIME COMMENT '配信日付 配信ボタン押下日付時間',
	`created_at` DATETIME  NOT NULL COMMENT '作成日付 初回承認依頼ボタン押下日付時間',
	`updated_at` DATETIME  NOT NULL COMMENT '更新日付',
	PRIMARY KEY (`mail_delivery_id`),
	KEY `ix_t_mail_delivery01`(`created_at`),
	KEY `ix_t_mail_delivery02`(`updated_at`)
) COMMENT='MAIL配信';

#-----------------------------------------------------------------------------
#-- t_mail_container
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `t_mail_container`;


CREATE TABLE `t_mail_container`
(
	`mail_delivery_id` INTEGER UNSIGNED  NOT NULL COMMENT 'MAIL配信ID',
	`container_no` TINYINT UNSIGNED  NOT NULL COMMENT 'コンテナ番号（登録順）0～連番',
	`and_or_flg` TINYINT COMMENT 'AND_ORフラグ 0：AND 1：OR（コンテナ番号が1の場合はNULL）',
	PRIMARY KEY (`mail_delivery_id`,`container_no`)
) COMMENT='MAILコンテナ';

#-----------------------------------------------------------------------------
#-- t_mail_terms
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `t_mail_terms`;


CREATE TABLE `t_mail_terms`
(
	`mail_delivery_id` INTEGER UNSIGNED  NOT NULL COMMENT 'MAIL配信ID',
	`container_no` TINYINT UNSIGNED  NOT NULL COMMENT 'コンテナ番号（登録順）0～連番',
	`terms_no` TINYINT UNSIGNED  NOT NULL COMMENT '条件番号（登録順）0～連番',
	`and_or_flg` TINYINT COMMENT 'AND_ORフラグ 0：AND 1：OR（条件番号が1の場合はNULL）',
	`exclude_flg` TINYINT default 0 NOT NULL COMMENT '除外フラグ 0：一致（IN） 1：除外（NOT IN）',
	`shop_designate_flg` TINYINT default 0 NOT NULL COMMENT '配信店舗指定フラグ 0：全店舗  1：店舗指定',
	`delivery_shop_ids` VARCHAR(8000) COMMENT '配信先店舗 店舗ID（カンマ区切り）',
	`member_designate_flg` TINYINT default 0 NOT NULL COMMENT '配信会員指定フラグ 0：全会員  1：会員指定',
	`minimum_age` TINYINT UNSIGNED COMMENT '最小年齢 NULLは条件指定なし 1～条件指定',
	`maximum_age` TINYINT UNSIGNED COMMENT '最大年齢 NULLは条件指定なし 1～条件指定',
	`gender` TINYINT COMMENT '性別 0： 男性 1： 女性 member.sex',
	`epark_pref_codes` VARCHAR(160) COMMENT '都道府県 チェックボックス（カンマ区切り）',
	`city_codes` VARCHAR(1200) COMMENT '市区町村 チェックボックス（カンマ区切り）',
	`from_birth_month` TINYINT UNSIGNED COMMENT '誕生月開始 1～12月',
	`from_birth_day` TINYINT UNSIGNED COMMENT '誕生日開始 1～31日',
	`to_birth_month` TINYINT UNSIGNED COMMENT '誕生月終了 1～12月',
	`to_birth_day` TINYINT UNSIGNED COMMENT '誕生日終了 1～31日 1/1～12/31の場合は条件指定なし',
	PRIMARY KEY (`mail_delivery_id`,`container_no`,`terms_no`)
) COMMENT='MAIL条件';

#-----------------------------------------------------------------------------
#-- member
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `member`;


CREATE TABLE `member`
(
	`id` INTEGER(8)  NOT NULL AUTO_INCREMENT COMMENT '自動生成プライマリキー',
	`entry_shop_id` INTEGER(8) COMMENT '会員登録の入り口となった店舗',
	`status` TINYINT default 0 NOT NULL COMMENT '会員の運用状況 0：運用中 1：運用停止 2：削除済み 3：仮登録',
	`user_agent` VARCHAR(200) COMMENT 'クライアントブラウザのユーザエージェント',
	`mobile_uid` VARCHAR(30) COMMENT 'クライアント携帯のUID(個体識別番号)',
	`login_status` TINYINT default 0 NOT NULL COMMENT 'ログインの状態 かんたんログインのログイン状態チェックのために使用する 0: 非ログイン1: ログイン',
	`logined_at` DATETIME COMMENT '最終ログイン日時',
	`name` VARCHAR(40) COMMENT '会員の本名(会員登録時には入力しない。任意)',
	`call_name` VARCHAR(40)  NOT NULL COMMENT '会員の呼び出し名 店員が呼び出し時に使用',
	`sha1_password` VARCHAR(40)  NOT NULL COMMENT 'ハッシュ化されたパスワード 入力されたパスワード文字列にsaltをつなげ、sha1ハッシュを計算して生成',
	`salt` VARCHAR(32)  NOT NULL COMMENT 'ランダム生成した文字列をmd5ハッシュ化したもの',
	`email` VARCHAR(255)  NOT NULL COMMENT 'メールアドレス ログイン時の識別子にも使用する',
	`tel` VARCHAR(20) COMMENT '電話番号',
	`zip_code` VARCHAR(7) COMMENT '郵便番号',
	`prefecture_id` TINYINT  NOT NULL COMMENT '都道府県ID epark_common.prefecture.idへの参照',
	`area_id` SMALLINT  NOT NULL COMMENT '地域ID',
	`address` VARCHAR(120) COMMENT '市区町村以下の住所',
	`sex` TINYINT  NOT NULL COMMENT '性別 0: 男性 1: 女性',
	`birthday` DATE COMMENT '生年月日',
	`receive_news` TINYINT default 0 NOT NULL COMMENT 'EPARKからのお知らせメールを受け取るかどうか 0: 受け取らない 1: 受け取る',
	`pc_mail_magazine` TINYINT default 0 NOT NULL COMMENT 'PCメールマガジンを受け取るかどうか 0: 受け取らない 1: 受け取る',
	`mail_status` INTEGER default 0 NOT NULL COMMENT 'メール配信状態 0: 正常 1: 存在しないメールアドレス 2: ドメイン拒否',
	`coupon_status` INTEGER default 0 NOT NULL COMMENT '地域のお得なクーポンを受け取るか受け取らないか　受け取らない:0 受け取る:1',
	`switch_status` INTEGER default 0 NOT NULL COMMENT '旧システムからの移行の状態 0: 移行後に登録 1: 移行後未確認 2: 移行後確認済み NOT_EQUAL 対策で、0 < switch_status という条件の箇所があるので、status を追加するときは要注意',
	`switched_at` DATETIME COMMENT '旧システムからの切り替え確認日時',
	`memo` TEXT COMMENT '備考',
	`api_member_flag` TINYINT default 0 NOT NULL COMMENT 'API会員フラグ 0: 通常会員 1: API会員',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	`member_type` TINYINT default 0 NOT NULL COMMENT '会員種別 0: 会員種別未判定(通常会員) 1: 限定会員（ＡＰＩ会員） 30:メディカル会員 40:くら寿司アプリ会員 50:グループ会員（API連携会員） 51:AddPlus会員（API連携会員） 52:ケータイ手帳会員（API連携会員）100:一般会員（ＥＰＡＲＫ会員） 110:とくとく会員',
	`mail_style` TINYINT default 1 NOT NULL COMMENT 'メール受信 形式 0:テキストメール 1: HTMLメール',
	`mobile_carrier` TINYINT default 9 NOT NULL COMMENT '携帯キャリア 1:docomo 2:au 3:SoftBank 4:その他 9:未判定',
	`device_type` TINYINT default 9 NOT NULL COMMENT 'デバイス種別 1:フィーチャーフォン 2:スマートフォン 9:未判定',
	PRIMARY KEY (`id`),
	KEY `index_entry_shop_id`(`entry_shop_id`),
	KEY `index_mobile_uid`(`mobile_uid`),
	KEY `index_email`(`email`),
	KEY `index_birthday`(`birthday`),
	KEY `index_created_at`(`created_at`),
	KEY `index_prefecture_id`(`prefecture_id`),
	KEY `index_api_member_flag`(`api_member_flag`),
	KEY `index_status`(`status`),
	KEY `index_switch_status`(`switch_status`)
) COMMENT='会員情報マスタ';

#-----------------------------------------------------------------------------
#-- member_session
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `member_session`;


CREATE TABLE `member_session`
(
	`id` VARCHAR(255)  NOT NULL COMMENT 'セッションID ランダム文字列',
	`data` TEXT  NOT NULL COMMENT 'symfonyのセッションデータ',
	`updated_at` DATETIME COMMENT 'セッションタイムスタンプ',
	PRIMARY KEY (`id`),
	KEY `updated_at`(`updated_at`)
) COMMENT='会員のセッション情報 symfonyのセッション管理機能が使用する';

#-----------------------------------------------------------------------------
#-- m_fb_id_info
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `m_fb_id_info`;


CREATE TABLE `m_fb_id_info`
(
	`member_id` INTEGER  NOT NULL AUTO_INCREMENT COMMENT 'EPARK会員ID',
	`mem_fb_id` VARCHAR(20)  NOT NULL COMMENT 'EPARK会員facebook ID',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`member_id`),
	KEY `ix_mem_fb_id`(`mem_fb_id`)
) COMMENT='EPARK会員のfacebook ID管理テーブル';

#-----------------------------------------------------------------------------
#-- member_temp
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `member_temp`;


CREATE TABLE `member_temp`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	`random_key` VARCHAR(20)  NOT NULL COMMENT '会員登録用URLに埋め込み、仮登録ユーザを識別するためのランダムな文字列',
	`entry_shop_id` INTEGER COMMENT 'EPARK会員登録の入口となった店舗のID',
	`email` VARCHAR(255)  NOT NULL COMMENT 'メールアドレス 空メールのFromアドレス',
	`entry_count` TINYINT default 1 NOT NULL COMMENT 'ユーザが(一時データの保存期間内に)空メールを送信した回数 この値が多い場合は返信メールがうまく届いていない可能性あり',
	`resend_count` TINYINT default 0 NOT NULL COMMENT '管理側が(手動で)ユーザに会員登録メールを再送した回数',
	`qr_key` VARCHAR(26) COMMENT 'QRコードより会員登録を行う際に使用する。',
	`timetable_flg` TINYINT default 0 NOT NULL COMMENT '時間割予約店舗の店舗 0=いいえ 0以外=はい',
	`sbm_flg` TINYINT default 0 NOT NULL COMMENT 'SBM店舗 0=いいえ 1=はい',
	`mem_fb_id` VARCHAR(100) COMMENT 'facebook idの保存',
	`resent_at` DATETIME COMMENT '管理側が最後に会員登録メールを送信した日時',
	`expires_at` DATETIME COMMENT 'このレコードの保存期限 期限の過ぎたデータは定期的に削除する',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`)
) COMMENT='空メール送信による仮登録データの一時保存用';

#-----------------------------------------------------------------------------
#-- member_change_email_temp
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `member_change_email_temp`;


CREATE TABLE `member_change_email_temp`
(
	`member_id` INTEGER  NOT NULL COMMENT '会員ID',
	`temp_hash` VARCHAR(26)  NOT NULL COMMENT 'メールアドレスを変更したユーザを識別するためのランダムキー',
	`email` VARCHAR(255) COMMENT 'ユーザの新しいメールアドレス',
	`expires_at` DATETIME COMMENT 'このレコードの保存期限 期限の過ぎたデータは定期的に削除する',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`member_id`)
) COMMENT='会員のメールアドレス変更用データ一時保存用';

#-----------------------------------------------------------------------------
#-- tmp_member
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `tmp_member`;


CREATE TABLE `tmp_member`
(
	`member_id` INTEGER  NOT NULL COMMENT 'Member ID',
	`key` VARCHAR(20)  NOT NULL COMMENT 'random key',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	PRIMARY KEY (`id`)
) COMMENT='Temporary table for resetting user password.';

#-----------------------------------------------------------------------------
#-- member_tokutoku
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `member_tokutoku`;


CREATE TABLE `member_tokutoku`
(
	`id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT '自動生成プライマリキー',
	`member_id` INTEGER  NOT NULL COMMENT '会員ID',
	`status` TINYINT default 1 NOT NULL COMMENT 'ステータス 0: 運用 1: 運用停止',
	`work_id` TINYINT  NOT NULL COMMENT '職業 0:専業主婦 1:会社員 2:公務員 3:経営者・役員 4:ﾊﾟｰﾄ・ｱﾙﾊﾞｲﾄ 5:自営業 6:学生 7:無職 8:その他',
	`children` TINYINT  NOT NULL COMMENT '子供(第一子)の生まれた年 0-',
	`taste01` TINYINT default 0 NOT NULL COMMENT '趣味嗜好：映画・観劇 0: チェックなし 1: チェックあり',
	`taste02` TINYINT default 0 NOT NULL COMMENT '趣味嗜好：音楽・コンサート 0: チェックなし 1: チェックあり',
	`taste03` TINYINT default 0 NOT NULL COMMENT '趣味嗜好：スポーツ(観戦含) 0: チェックなし 1: チェックあり',
	`taste04` TINYINT default 0 NOT NULL COMMENT '趣味嗜好：ペット 0: チェックなし 1: チェックあり',
	`taste05` TINYINT default 0 NOT NULL COMMENT '趣味嗜好：習い事 0: チェックなし 1: チェックあり',
	`taste06` TINYINT default 0 NOT NULL COMMENT '趣味嗜好：アウトドア 0: チェックなし 1: チェックあり',
	`taste07` TINYINT default 0 NOT NULL COMMENT '趣味嗜好：旅行 0: チェックなし 1: チェックあり',
	`taste08` TINYINT default 0 NOT NULL COMMENT '趣味嗜好：ゲーム・娯楽 0: チェックなし 1: チェックあり',
	`taste09` TINYINT default 0 NOT NULL COMMENT '趣味嗜好：ショッピング 0: チェックなし 1: チェックあり',
	`taste10` TINYINT default 0 NOT NULL COMMENT '趣味嗜好：ギャンブル 0: チェックなし 1: チェックあり',
	`taste11` TINYINT default 0 NOT NULL COMMENT '趣味嗜好：（未使用） 0: チェックなし 1: チェックあり',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	KEY `index_member_id`(`member_id`)
) COMMENT='EPARK とくとく会員関連テーブル 会員がEPARK とくとく会員に登録していることを表す';

#-----------------------------------------------------------------------------
#-- member_population_daily
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `member_population_daily`;


CREATE TABLE `member_population_daily`
(
	`id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT '自動生成プライマリキー',
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID',
	`period_date` DATE  NOT NULL COMMENT '集計年月日',
	`register_member` INTEGER  NOT NULL COMMENT '獲得会員数',
	`leave_member` INTEGER  NOT NULL COMMENT '退会会員数',
	`total_member` INTEGER  NOT NULL COMMENT '累計会員数',
	PRIMARY KEY (`id`),
	KEY `index_shop_id`(`shop_id`),
	KEY `index_period_date`(`period_date`)
) COMMENT='会員数遷移集計(日別)';

#-----------------------------------------------------------------------------
#-- member_population_monthly
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `member_population_monthly`;


CREATE TABLE `member_population_monthly`
(
	`id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT '自動生成プライマリキー',
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID',
	`period_date` DATE  NOT NULL COMMENT '集計年月',
	`register_member` INTEGER  NOT NULL COMMENT '獲得会員数',
	`leave_member` INTEGER  NOT NULL COMMENT '退会会員数',
	`total_member` INTEGER  NOT NULL COMMENT '累計会員数',
	PRIMARY KEY (`id`),
	KEY `index_shop_id`(`shop_id`),
	KEY `index_period_date`(`period_date`)
) COMMENT='会員数遷移集計(月別)';

#-----------------------------------------------------------------------------
#-- member_report
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `member_report`;


CREATE TABLE `member_report`
(
	`member_id` INTEGER  NOT NULL COMMENT '会員ID',
	`wait_total_epark` INTEGER default 0 NOT NULL COMMENT '累計順番待ち受付件数（EPARK）',
	`reserve_total_epark` INTEGER default 0 NOT NULL COMMENT '累計順番待ち受付件数（EPARK）',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`member_id`),
	KEY `index_wait_total_epark`(`wait_total_epark`),
	KEY `index_reserve_total_epark`(`reserve_total_epark`)
) COMMENT='EPARK 会員別集計情報テーブル （日次バッチ更新）';

#-----------------------------------------------------------------------------
#-- member_token
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `member_token`;


CREATE TABLE `member_token`
(
	`member_id` INTEGER  NOT NULL COMMENT '会員ID',
	`app_type` INTEGER  NOT NULL COMMENT 'アプリ種別',
	`refresh_token` TEXT COMMENT 'リフレッシュトークン',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`member_id`,`app_type`),
	KEY `membr_token_index_updated_at`(`updated_at`)
) COMMENT='会員のリフレッシュトークンの期限切れの時に自動で再認証させる';

#-----------------------------------------------------------------------------
#-- t_line_member
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `t_line_member`;


CREATE TABLE `t_line_member`
(
	`line_member_id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT 'LINE連携会員ID',
	`line_mid` VARCHAR(512) COMMENT 'LINE_MID',
	`member_id` INTEGER UNSIGNED  NOT NULL COMMENT 'EPARK会員ID',
	`line_channel_id` VARCHAR(16) COMMENT 'LINE連携店舗チャンネルID',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`line_member_id`),
	UNIQUE KEY `uix_t_line_member1` (`member_id`, `line_channel_id`)
) COMMENT='LINE EPARK連携テーブル';

#-----------------------------------------------------------------------------
#-- t_line_block
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `t_line_block`;


CREATE TABLE `t_line_block`
(
	`line_block_id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT 'LINEブロックID',
	`line_member_id` INTEGER UNSIGNED  NOT NULL COMMENT 'LINE連携会員ID',
	`option_type` TINYINT UNSIGNED  NOT NULL COMMENT 'オプションタイプ 4:ブロック解除, 8:ブロック',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`line_block_id`),
	KEY `idx_t_line_block1`(`created_at`),
	KEY `idx_t_line_block2`(`updated_at`),
	KEY `idx_t_line_block3`(`line_member_id`, `option_type`)
) COMMENT='LINEブロック情報';

#-----------------------------------------------------------------------------
#-- i_line_at_shop
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `i_line_at_shop`;


CREATE TABLE `i_line_at_shop`
(
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID',
	`account_id` VARCHAR(32)  NOT NULL COMMENT 'LINE＠アカウントのID',
	`account_line_id` VARCHAR(50) COMMENT 'LINEのid',
	`account_premium_line_id` VARCHAR(50) COMMENT 'LINEのpremium_id',
	`account_mid` VARCHAR(128) COMMENT 'LINEのmid',
	`account_name` VARCHAR(1024)  NOT NULL COMMENT 'LINE＠アカウントの名称',
	`account_info_json` VARCHAR(2048)  NOT NULL COMMENT 'LINE＠アカウント情報をjson形式で保存',
	`expire_date` DATETIME COMMENT 'トークン有効期限',
	`line_reserve_image_name` VARCHAR(50) COMMENT 'LINE連携_受付完了トーク画像名',
	`line_call_image_name` VARCHAR(50) COMMENT 'LINE連携_直前通知トーク画像名',
	`status` TINYINT default 1 COMMENT 'レコードステータス。0=無効、1=有効',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`shop_id`),
	KEY `ix_i_line_at_shop1`(`account_id`),
	KEY `ix_i_line_at_shop2`(`account_mid`),
	KEY `ix_i_line_at_shop3`(`account_line_id`),
	KEY `ix_i_line_at_shop4`(`account_premium_line_id`)
) COMMENT='i_LINE＠連携店舗';

#-----------------------------------------------------------------------------
#-- i_sme_line_member
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `i_sme_line_member`;


CREATE TABLE `i_sme_line_member`
(
	`line_uid` VARCHAR(128)  NOT NULL COMMENT 'LINE_UID',
	`member_id` INTEGER  NOT NULL COMMENT 'EPARK会員ID',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`line_uid`),
	UNIQUE KEY `uix_i_sme_line_member1` (`member_id`)
) COMMENT='i_SME LINE連携会員';

#-----------------------------------------------------------------------------
#-- i_line_shop_member
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `i_line_shop_member`;


CREATE TABLE `i_line_shop_member`
(
	`id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT 'ID',
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID',
	`member_id` INTEGER  NOT NULL COMMENT '会員ID',
	`regist_date` DATETIME  NOT NULL COMMENT '登録年月日',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	UNIQUE KEY `uix_i_line_shop_member1` (`shop_id`, `member_id`)
) COMMENT='i_SME LINEの会員店舗連携情報';

#-----------------------------------------------------------------------------
#-- t_line_send_message_history
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `t_line_send_message_history`;


CREATE TABLE `t_line_send_message_history`
(
	`id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT 'ID',
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID',
	`receive_id` INTEGER COMMENT '受付ID',
	`message_type` TINYINT  NOT NULL COMMENT 'メッセージタイプ',
	`send_result` TINYINT  NOT NULL COMMENT '送信結果',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	KEY `ix_t_line_send_message_history1`(`shop_id`, `created_at`)
) COMMENT='LINEメッセージ送信履歴';

#-----------------------------------------------------------------------------
#-- i_line_shop_config
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `i_line_shop_config`;


CREATE TABLE `i_line_shop_config`
(
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID',
	`line_at_id` VARCHAR(50) COMMENT 'LINE@ID',
	`wait_call_message_1` VARCHAR(255) COMMENT '順番待ち呼出しメッセージ1',
	`wait_call_message_2` VARCHAR(255) COMMENT '順番待ち呼出しメッセージ2',
	`wait_call_message_3` VARCHAR(255) COMMENT '順番待ち呼出しメッセージ3',
	`qr_call_message_1` VARCHAR(255) COMMENT 'QR呼出しメッセージ1',
	`qr_call_message_2` VARCHAR(255) COMMENT 'QR呼出しメッセージ2',
	`qr_call_message_3` VARCHAR(255) COMMENT 'QR呼出しメッセージ3',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`shop_id`)
) COMMENT='LINE連携店舗設定(ビジネスコネクト)';

#-----------------------------------------------------------------------------
#-- day_data
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `day_data`;


CREATE TABLE `day_data`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	`compile_date` DATE  NOT NULL COMMENT 'Compile date',
	`member_temp_num` INTEGER COMMENT 'The Number of peaple tried to register',
	`pref_coupon_num` INTEGER COMMENT 'The Number of Received a coupon',
	PRIMARY KEY (`id`,`compile_date`)
) COMMENT='Compile for people tried to register';

#-----------------------------------------------------------------------------
#-- invite
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `invite`;


CREATE TABLE `invite`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	`serial` VARCHAR(255)  NOT NULL COMMENT '紹介シリアル',
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID',
	`member_id` INTEGER  NOT NULL COMMENT '会員ID',
	`friend_member_id` INTEGER COMMENT '被紹介会員ID',
	`present_flag` TINYINT default 0 NOT NULL COMMENT 'プレゼント受領フラグ(0: 未 / 1: 済)',
	`present_id` INTEGER  NOT NULL COMMENT 'プレゼントID',
	`limit_date` DATE  NOT NULL COMMENT '有効期日',
	`close_mail_send` TINYINT default 0 NOT NULL COMMENT '成立メール送信フラグ(0: 未送信, 1: 送信済み)',
	`delivery_order_id` INTEGER default 0 NOT NULL COMMENT '配信オーダーID',
	`qr_image_deleted` TINYINT default 0 NOT NULL COMMENT 'QR画像削除フラグ(0: 未削除, 1: 削除済み)',
	`status` TINYINT default 1 NOT NULL COMMENT '有効紹介フラグ (0: 無効 / 1: 有効)',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	INDEX `invite_FI_1` (`present_id`)
) COMMENT='友人紹介履歴';

#-----------------------------------------------------------------------------
#-- invite_present
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `invite_present`;


CREATE TABLE `invite_present`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	`title` VARCHAR(255)  NOT NULL COMMENT 'プレゼントタイトル',
	`description` TEXT COMMENT 'プレゼントの説明',
	`contents` TEXT COMMENT 'コンテンツ',
	`shop_ids_text` TEXT COMMENT '店舗ID（入力テキストのまま保持）',
	`period_start` DATE  NOT NULL COMMENT '有効期間開始日',
	`period_end` DATE  NOT NULL COMMENT '有効期間終了日',
	`status` TINYINT default 1 NOT NULL COMMENT '有効フラグ （0: 無効 / 1: 有効）',
	`coupon_id_1` INTEGER  NOT NULL COMMENT 'クーポン１ID',
	`coupon_id_2` INTEGER COMMENT 'クーポン２ID',
	`coupon_id_3` INTEGER COMMENT 'クーポン３ID',
	`access_count` INTEGER default 0 NOT NULL COMMENT 'アクセス数',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	KEY `index_invite_present_1`(`period_start`, `period_end`)
) COMMENT='友人紹介プレゼント';

#-----------------------------------------------------------------------------
#-- invite_present_shop
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `invite_present_shop`;


CREATE TABLE `invite_present_shop`
(
	`present_id` INTEGER  NOT NULL COMMENT 'プレゼントID',
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID',
	`created_at` DATETIME,
	PRIMARY KEY (`present_id`,`shop_id`)
) COMMENT='友人紹介プレゼント-店舗連結テーブル';

#-----------------------------------------------------------------------------
#-- admin_invite
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `admin_invite`;


CREATE TABLE `admin_invite`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	`serial` VARCHAR(255)  NOT NULL COMMENT '紹介シリアル',
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID',
	`member_id` INTEGER  NOT NULL COMMENT '会員ID',
	`friend_member_id` INTEGER COMMENT '被紹介会員ID',
	`present_flag` TINYINT default 0 NOT NULL COMMENT 'プレゼント受領フラグ(0: 未 / 1: 済)',
	`present_id` INTEGER  NOT NULL COMMENT 'プレゼントID',
	`limit_date` DATE  NOT NULL COMMENT '有効期日',
	`status` TINYINT default 1 NOT NULL COMMENT '有効フラグ （0: 無効 / 1: 有効）',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	INDEX `admin_invite_FI_1` (`present_id`)
) COMMENT='運営友人紹介履歴';

#-----------------------------------------------------------------------------
#-- admin_invite_present
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `admin_invite_present`;


CREATE TABLE `admin_invite_present`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	`title` VARCHAR(255)  NOT NULL COMMENT 'プレゼントタイトル',
	`description` TEXT COMMENT 'プレゼントの説明',
	`contents` TEXT COMMENT 'コンテンツ',
	`status` TINYINT default 1 NOT NULL COMMENT '有効フラグ （0: 無効 / 1: 有効）',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`)
) COMMENT='運営友人紹介プレゼント';

#-----------------------------------------------------------------------------
#-- mobile_spec_docomo
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `mobile_spec_docomo`;


CREATE TABLE `mobile_spec_docomo`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	`name` VARCHAR(30),
	`generation` TINYINT,
	`cache` SMALLINT,
	`browser_width` SMALLINT,
	`browser_height` SMALLINT,
	`display_width` SMALLINT,
	`display_height` SMALLINT,
	`can_ssl` TINYINT,
	`can_flash` TINYINT,
	`can_gps` TINYINT,
	`can_table` TINYINT,
	`can_css` TINYINT,
	`html_version` TINYINT,
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`)
);

#-----------------------------------------------------------------------------
#-- mobile_spec_ezweb
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `mobile_spec_ezweb`;


CREATE TABLE `mobile_spec_ezweb`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	`name` VARCHAR(30),
	`terminal_name` VARCHAR(20),
	`generation` TINYINT,
	`cache` SMALLINT,
	`browser_width` SMALLINT,
	`browser_height` SMALLINT,
	`display_width` SMALLINT,
	`display_height` SMALLINT,
	`can_ssl` TINYINT,
	`can_flash` TINYINT,
	`can_gps` TINYINT,
	`can_table` TINYINT,
	`can_css` TINYINT,
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`)
);

#-----------------------------------------------------------------------------
#-- mobile_spec_softbank
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `mobile_spec_softbank`;


CREATE TABLE `mobile_spec_softbank`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	`name` VARCHAR(30),
	`terminal_name` VARCHAR(20),
	`generation` TINYINT,
	`cache` SMALLINT,
	`browser_width` SMALLINT,
	`browser_height` SMALLINT,
	`display_width` SMALLINT,
	`display_height` SMALLINT,
	`can_ssl` TINYINT,
	`can_flash` TINYINT,
	`can_gps` TINYINT,
	`can_table` TINYINT,
	`can_css` TINYINT,
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`)
);

#-----------------------------------------------------------------------------
#-- emoji
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `emoji`;


CREATE TABLE `emoji`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	`name` VARCHAR(10)  NOT NULL,
	`code_i` VARCHAR(4)  NOT NULL,
	`code_ez` VARCHAR(4)  NOT NULL,
	`code_s` SMALLINT  NOT NULL,
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`)
);

#-----------------------------------------------------------------------------
#-- emoji_ez
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `emoji_ez`;


CREATE TABLE `emoji_ez`
(
	`code` VARCHAR(4)  NOT NULL,
	`title` VARCHAR(255)  NOT NULL,
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	PRIMARY KEY (`id`)
);

#-----------------------------------------------------------------------------
#-- emoji_s
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `emoji_s`;


CREATE TABLE `emoji_s`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	`code` VARCHAR(10)  NOT NULL,
	PRIMARY KEY (`id`)
);

#-----------------------------------------------------------------------------
#-- emoji_i
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `emoji_i`;


CREATE TABLE `emoji_i`
(
	`code` VARCHAR(4)  NOT NULL,
	`title` VARCHAR(255)  NOT NULL,
	`code2` VARCHAR(255),
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	PRIMARY KEY (`id`)
);

#-----------------------------------------------------------------------------
#-- emoji_master
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `emoji_master`;


CREATE TABLE `emoji_master`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	`code` VARCHAR(20)  NOT NULL,
	`title` VARCHAR(10)  NOT NULL,
	`pc_path` VARCHAR(10),
	`code_i` VARCHAR(4),
	`order_id` INTEGER,
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`)
);

#-----------------------------------------------------------------------------
#-- emoji_master_ez
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `emoji_master_ez`;


CREATE TABLE `emoji_master_ez`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	`code` INTEGER  NOT NULL,
	`jis_code` VARCHAR(4),
	`order_id` INTEGER,
	PRIMARY KEY (`id`,`code`)
);

#-----------------------------------------------------------------------------
#-- emoji_master_softbank
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `emoji_master_softbank`;


CREATE TABLE `emoji_master_softbank`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	`number` INTEGER,
	`code` VARCHAR(10)  NOT NULL,
	`jis_code` VARCHAR(4),
	`order_id` INTEGER,
	PRIMARY KEY (`id`,`code`)
);

#-----------------------------------------------------------------------------
#-- mobile_category_master
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `mobile_category_master`;


CREATE TABLE `mobile_category_master`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	`category1_code` SMALLINT,
	`category2_cade` SMALLINT,
	`category_name` VARCHAR(60),
	`category_name_kana` VARCHAR(80),
	`category_order` SMALLINT,
	`category_emoji` VARCHAR(12),
	`category_admission` TINYINT,
	`display_order` SMALLINT,
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`)
);

#-----------------------------------------------------------------------------
#-- mobile_category_mapping
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `mobile_category_mapping`;


CREATE TABLE `mobile_category_mapping`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	`mobile_category_id` INTEGER,
	`category1_code` SMALLINT,
	`category2_code` SMALLINT,
	`pc_category_code` SMALLINT,
	`pc_category1_code` SMALLINT,
	`pc_category2_code` SMALLINT,
	`pc_category3_code` SMALLINT,
	`pc_category4_code` SMALLINT,
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	INDEX `mobile_category_mapping_FI_1` (`mobile_category_id`)
);

#-----------------------------------------------------------------------------
#-- daily
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `daily`;


CREATE TABLE `daily`
(
	`id` INTEGER(8)  NOT NULL AUTO_INCREMENT,
	`member_id` INTEGER COMMENT '会員ID',
	`carry_over` SMALLINT default 1 COMMENT 'キャリーオーバーしている回数',
	`accept_flag` TINYINT default 0 COMMENT '当選報告の有無 有り：1 無し：0',
	`lot_date` DATE COMMENT '抽選日',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	UNIQUE KEY `lot_date` (`lot_date`)
);

#-----------------------------------------------------------------------------
#-- prize_reserve
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `prize_reserve`;


CREATE TABLE `prize_reserve`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	`title` VARCHAR(255) COMMENT 'タイトル',
	`period_start` DATE COMMENT '対象期間開始日',
	`period_end` DATE COMMENT '対象期間終了日',
	`drawing_date` DATE COMMENT '抽選日',
	`publication_date` DATE COMMENT '当選発表日',
	`application_limit_day` INTEGER default 0 COMMENT '申請期限日(発表日からの日数）',
	`status` INTEGER default 0 COMMENT 'ステータス 0: 未抽選 / 1: 抽選済み',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`)
);

#-----------------------------------------------------------------------------
#-- prize_reserve_rank
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `prize_reserve_rank`;


CREATE TABLE `prize_reserve_rank`
(
	`rank_id` INTEGER  NOT NULL AUTO_INCREMENT COMMENT 'ランクID',
	`prize_id` INTEGER COMMENT '懸賞ID',
	`win_num` INTEGER COMMENT '当選人数',
	`rank_order` INTEGER COMMENT '順位',
	`rank_name` VARCHAR(255) COMMENT 'ランク（1等賞・2等賞、など）',
	`prize` VARCHAR(255) COMMENT '商品（DVDプレイヤー、30,000円、など）',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`rank_id`),
	INDEX `prize_reserve_rank_FI_1` (`prize_id`)
);

#-----------------------------------------------------------------------------
#-- winner
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `winner`;


CREATE TABLE `winner`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	`entry_id` VARCHAR(255)  NOT NULL COMMENT '応募番号',
	`prize_type` CHAR(1) default 'R' NOT NULL COMMENT '懸賞種別　R:予約',
	`member_id` INTEGER  NOT NULL COMMENT '会員ID',
	`rank_id` INTEGER COMMENT '当選ランクID',
	`prize` VARCHAR(255)  NOT NULL COMMENT '商品',
	`application_status` INTEGER default 0 NOT NULL COMMENT '申告の有無 0: 無し / 1: 申告あり',
	`family_name` VARCHAR(10) COMMENT 'お名前（姓）',
	`first_name` VARCHAR(10) COMMENT 'お名前（名）',
	`email` VARCHAR(255) COMMENT 'メール',
	`tel` VARCHAR(14) COMMENT 'ご連絡先電話（ハイフン無し）',
	`zip` VARCHAR(7) COMMENT '郵便番号（ハイフン無し7桁）',
	`pref` VARCHAR(255) COMMENT '都道府県',
	`city` VARCHAR(255) COMMENT '市区町村',
	`address` VARCHAR(255) COMMENT '住所',
	`comment` VARCHAR(255) COMMENT 'コメント(喜びの声)',
	`status` INTEGER default 1 NOT NULL COMMENT 'ステータス',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`)
);

#-----------------------------------------------------------------------------
#-- receive
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `receive`;


CREATE TABLE `receive`
(
	`id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT 'ID',
	`reserve_id` BIGINT COMMENT '使ってはいけない! 旧システムからのデータ移行のとき、店舗ごとの予約IDを保持する 新システムでは参照しない',
	`owner_shop_id` BIGINT COMMENT 'オーナーID',
	`shop_id` BIGINT COMMENT '店舗ID',
	`member_id` INTEGER default 0 COMMENT '会員ＩＤ',
	`reserve_status` TINYINT COMMENT '予約状態 0:予約 4：仮予約 9:削除 旧： 予約状態 0:予約 1:キャンセル 2:未来店 3:不明 9:削除',
	`reserve_type` TINYINT COMMENT '予約タイプ 0:順番待ち 1:予約 2:予約台帳',
	`is_send` TINYINT default 0 COMMENT 'メール送信状態 0:未送信 1:送信済み 10:呼出対象外',
	`is_send_information` TINYINT default 0 NOT NULL COMMENT '有料会員N分前送信フラグ 0:未送信 1:送信済み',
	`information_mail_time` SMALLINT UNSIGNED default 0 NOT NULL COMMENT '有料会員N分前設定時間 0:送信しない',
	`receipt_no` INTEGER default 0 COMMENT '受付番号',
	`receipt_date` DATETIME COMMENT '案内予定日時 ※席に着きたい時間 順番待ちの場合は受付日時 時間指定・将来順番待ちの時は予約時に指定した日時 「戻す」場合は割り込ませたい順番になるようにこの日時を変更',
	`agent_date` DATETIME COMMENT '予約代行の目標案内予定時間（会員の登録した予約希望時間）',
	`guide_target_time` DATETIME COMMENT '待ち時間ロジックが基準時間固定の場合の案内予定時間を保持する。',
	`late_date` DATETIME COMMENT '遅刻した場合、到着した日時(推測) 無断キャンセルから「戻す」をした時に、receipt_date がコピーされていることを確認',
	`guide_status` TINYINT COMMENT '案内状態 0:未案内 1:案内済 2:不在 3:無断キャンセル 4:案内済再案内 5:不在再案内 6:接客中 7:接客中再案内 8:キャンセル 旧：案内状態 0:未案内 1:案内済み 2:呼び出し済み（現在expired扱い。callはどうしようか？）',
	`wait_count` SMALLINT default 0 COMMENT '待ち回数 (無断キャンセルになる毎にインクリメントされている)',
	`wait_count_on_entry` SMALLINT COMMENT '順番取り時の待ち組数',
	`wait_time` SMALLINT default 0 COMMENT '待ち時間(分) (新規作成時に設定した後は更新されない) (要らない疑惑)',
	`wait_time_on_entry` SMALLINT COMMENT '順番取り時の待ち時間',
	`guide_date` DATETIME COMMENT '案内日付 (案内済になった日時、guided_at の方が適切な名前)',
	`call_date` DATETIME COMMENT '呼び出し日付 (呼び出した日時ではなく、「不在」状態になった日時、「呼出」ボタンとは無関係)',
	`call_cnt` TINYINT default 0 COMMENT '呼び出し回数 (「不在」状態になる度にインクリメントされる)',
	`call_tel_cnt` TINYINT default 0 COMMENT '電話呼出回数 (「電話呼出コール」ボタン押下し、成功する度にインクリメントされる)',
	`call_tel_date` DATETIME COMMENT '電話呼出最終日時 (「電話呼出コール」ボタン押下し、成功するになった日時)',
	`wait_ivr_chk_sts` TINYINT UNSIGNED default 0 NOT NULL COMMENT '順番待ち受付IVR確認状態 (順番待ち受付におけるIVRでの確認の状態。1:承諾 2.キャンセル 10.クリア 20.呼出対象外)',
	`wait_ivr_chk_at` DATETIME COMMENT '順番待ち受付IVR最終確認日時 (順番待ち受付におけるIVRでの確認日時。順番待ち受付IVR確認状態の全状態における最終日時)',
	`serv_call_tel_cnt` TINYINT UNSIGNED default 0 COMMENT '接客中電話呼出回数 (「電話呼出コール」ボタン押下し、成功する度にインクリメントされる)',
	`serv_call_tel_at` DATETIME COMMENT '接客中電話呼出最終日時 (「電話呼出コール」ボタン押下し、成功するになった日時)',
	`serv_ivr_chk_sts` TINYINT UNSIGNED default 0 NOT NULL COMMENT '接客中IVR確認状態 (接客中におけるIVRでの確認の状態。1:承諾 2.キャンセル 10.クリア)',
	`serv_ivr_chk_at` DATETIME COMMENT '接客中IVR最終確認日時 (接客中におけるIVRでの確認日時。接客中IVR確認状態の全状態における最終日時)',
	`regist_no` VARCHAR(100) COMMENT '部門別受付ＮＯ',
	`regist_both_no` VARCHAR(100) COMMENT 'どちらでも受付ＮＯ',
	`shop_reserve_condition_id` BIGINT COMMENT '部門選択条件ID',
	`shop_reserve_condition_value` VARCHAR(100) COMMENT '部門選択条件内容',
	`shop_reserve_department_id` BIGINT COMMENT '部門ID null:移行データ（部門なし店舗も含む）',
	`shop_reserve_department_value` VARCHAR(100) COMMENT '部門名',
	`shop_reserve_category_id_1` BIGINT COMMENT '条件１ＩＤ',
	`shop_reserve_category_value_1` VARCHAR(100) COMMENT '条件１内容',
	`shop_reserve_category_id_2` BIGINT COMMENT '条件２ＩＤ',
	`shop_reserve_category_value_2` VARCHAR(100) COMMENT '条件２内容',
	`shop_reserve_category_id_3` BIGINT COMMENT '条件３ＩＤ',
	`shop_reserve_category_value_3` VARCHAR(100) COMMENT '条件３内容',
	`shop_reserve_category_id_4` BIGINT COMMENT '条件４ＩＤ',
	`shop_reserve_category_value_4` VARCHAR(100) COMMENT '条件４内容',
	`shop_reserve_category_id_5` BIGINT COMMENT '条件５ＩＤ',
	`shop_reserve_category_value_5` VARCHAR(100) COMMENT '条件５内容',
	`check_status` TINYINT default 0 COMMENT 'default=0  「タッチパネル来店客チェック」なる機能に使用する',
	`voice_play_status` TINYINT default 0 COMMENT '音声案内済（呼出済）フラグ 0:呼出前 1:呼出済',
	`voice_play_date` DATETIME COMMENT '音声案内 呼出日時',
	`is_main_dochirademo` TINYINT default 0 COMMENT 'default=0  「どちらでも部門」受付データの正データかの判定に使用する 0:副データ 1:正データ',
	`memo` VARCHAR(100) COMMENT 'メモ',
	`spare1` BIGINT COMMENT '予備１',
	`spare2` VARCHAR(100) COMMENT '予備２',
	`entry_date` DATETIME COMMENT 'レコード作成日時',
	`entry_type` TINYINT COMMENT '予約登録元 0:PC管理画面 1:PC表側 2:携帯管理画面 3:携帯表側 4:タッチパネル管理画面 5:タッチパネル 6:API 7:スマートフォンサイト 98:ゲスト（非会員） 99：病院 100：外部API 101：くら寿司アプリ(Android) 102：くら寿司アプリ(iOS) 103：薬局外部連携 104：サイネージ 105：EPARK総合アプリ(Android) 106：EPARK総合アプリ(iOS) ※ 1:PC表側 は使用していない様子',
	`parent_id` BIGINT COMMENT '連続受付時の親receieve_id',
	`referer` VARCHAR(255) COMMENT 'リファラ',
	`service_start_time` DATETIME COMMENT '接客開始日時',
	`service_end_time` DATETIME COMMENT '接客完了日時',
	`service_end_status` VARCHAR(4) COMMENT '接客完了ステータス',
	`employee_id` BIGINT COMMENT '担当者ID',
	`employee_name` VARCHAR(20) COMMENT '担当者名',
	`member_called_at` DATETIME COMMENT '携帯呼出日時',
	`serv_mem_called_at` DATETIME COMMENT '接客中携帯呼出日時',
	`checkdata` DATETIME COMMENT '将来順番予約確認日付(予約台帳機能の際に使用)',
	`voice_counter_display_no` BIGINT COMMENT 'カウンター表示機で呼出したカウンター番号',
	`re_guidance_date` DATETIME COMMENT '再案内時の時間',
	`purchase_status` SMALLINT UNSIGNED default 0 NOT NULL COMMENT '購入ステータス(0:購入なし、1:購入済み)',
	`rsv_confirm_status` TINYINT UNSIGNED default 0 NOT NULL COMMENT '予約確認ステータス(0:未確認、1:確認済) 自動車ph7',
	`cxl_wait_condition` TINYINT UNSIGNED default 0 NOT NULL COMMENT 'CXL待ち状況（0:キャンセル待ちしていない(来店証明未完了を含む)、1:キャンセル待ち中(来店証明済み、未割り込み)、2:キャンセル待ち中(来店証明済み、割り込み済み)）',
	`created_at` DATETIME COMMENT 'レコード作成日時',
	`updated_at` DATETIME COMMENT 'レコード更新日時',
	PRIMARY KEY (`id`),
	KEY `index_shop_id`(`shop_id`),
	KEY `index_member_id`(`member_id`),
	KEY `index_receipt_date`(`receipt_date`),
	KEY `index_regist_no`(`regist_no`),
	KEY `index_regist_both_no`(`regist_both_no`),
	KEY `index_shop_reserve_department_id`(`shop_reserve_department_id`),
	KEY `index_guide_date`(`guide_date`),
	KEY `index_send_information`(`is_send_information`, `information_mail_time`),
	KEY `index_for_employee`(`guide_status`, `employee_id`),
	KEY `index_reserve_type`(`reserve_type`),
	INDEX `receive_FI_1` (`employee_id`)
) COMMENT='当日分の予約受付データの格納テーブル';

#-----------------------------------------------------------------------------
#-- t_receive_resty
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `t_receive_resty`;


CREATE TABLE `t_receive_resty`
(
	`receive_resty_id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT '自動生成プライマリキー',
	`member_id` INTEGER(11)  NOT NULL COMMENT '会員ID',
	`shop_id` INTEGER(11)  NOT NULL COMMENT '店舗ID',
	`receipt_no` VARCHAR(100)  NOT NULL COMMENT '予約番号',
	`status` INTEGER(11)  NOT NULL COMMENT '予約ステータス',
	`receipt_date` DATETIME  NOT NULL COMMENT '予約日時',
	`person_count` INTEGER UNSIGNED default 0 COMMENT '予約人数',
	`seat_category_id` VARCHAR(100) COMMENT '席カテゴリーID カンマ区切り',
	`smoke_type` TINYINT UNSIGNED COMMENT '喫煙種別 0:指定なし, 1:禁煙, 2:喫煙, 3:分煙',
	`plan_name` VARCHAR(255) COMMENT 'プラン名',
	`regist_date` VARCHAR(40)  NOT NULL COMMENT '予約作成日時 YYYY-MM-DD HH:mm:ss.SSSSSS形式',
	`created_at` DATETIME  NOT NULL COMMENT 'レコード作成日時',
	`updated_at` DATETIME  NOT NULL COMMENT 'レコード更新日時',
	`deleted_flg` TINYINT UNSIGNED default 0 NOT NULL COMMENT '削除フラグ 0:有効 1:削除',
	PRIMARY KEY (`receive_resty_id`),
	KEY `ix_receive_resty1`(`member_id`),
	KEY `ix_receive_resty2`(`shop_id`),
	KEY `ix_receive_resty3`(`status`),
	KEY `ix_receive_resty4`(`receipt_date`)
) COMMENT='RESTY予約情報管理テーブル';

#-----------------------------------------------------------------------------
#-- guest_receive
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `guest_receive`;


CREATE TABLE `guest_receive`
(
	`id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT 'ID',
	`receive_id` BIGINT  NOT NULL COMMENT '予約ID',
	`name` VARCHAR(40)  NOT NULL COMMENT 'ゲスト氏名',
	`email` VARCHAR(225)  NOT NULL COMMENT 'メールアドレス',
	`guest_auth_key` VARCHAR(64) COMMENT 'ゲスト認証キー',
	`passphrase` VARCHAR(64) COMMENT 'パスフレーズ',
	`passphrase_salt` VARCHAR(32) COMMENT 'パスフレーズソルト',
	`guest_auth_token` VARCHAR(64) COMMENT 'ゲスト認証トークン',
	`created_at` DATETIME COMMENT 'レコード作成日時',
	`updated_at` DATETIME COMMENT 'レコード更新日時',
	PRIMARY KEY (`id`)
) COMMENT='ゲスト予約者情報テーブル';

#-----------------------------------------------------------------------------
#-- receive_tel_call
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `receive_tel_call`;


CREATE TABLE `receive_tel_call`
(
	`receive_id` BIGINT  NOT NULL COMMENT 'receiveテーブルのidと紐づいている',
	`receive_tel_number` VARCHAR(100)  NOT NULL COMMENT '予約者の電話番号',
	`auto_call_status` TINYINT default 0 NOT NULL COMMENT '自動電話呼出状態 0:未コール 1:自動コール済み',
	`created_at` DATETIME COMMENT 'レコード作成日時',
	`updated_at` DATETIME COMMENT 'レコード更新日時',
	PRIMARY KEY (`receive_id`),
	KEY `index_receive_tel_number`(`receive_tel_number`)
) COMMENT='当日分の予約受付データの電話番号管理テーブル';

#-----------------------------------------------------------------------------
#-- receive_tel_call_api_log
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `receive_tel_call_api_log`;


CREATE TABLE `receive_tel_call_api_log`
(
	`id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT 'ID',
	`receive_id` BIGINT  NOT NULL COMMENT '予約ID',
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID（あえて冗長）',
	`transmission_status` TINYINT default 1 NOT NULL COMMENT '通信ステータス 1:通信中 2:完了',
	`result_status` TINYINT default 0 NOT NULL COMMENT '結果ステータス 0:未完了 1:正常 2:エラー終了 3:異常終了（タイムアウト等） 4:強制終了',
	`result_notified` TINYINT default 1 NOT NULL COMMENT '結果表示済みフラグ 1:未表示 2:表示済み',
	`call_count` TINYINT default 0 NOT NULL COMMENT '電話呼出API実行回数',
	`call_log_message` VARCHAR(100) COMMENT 'ログメッセージ（エラー発生時に）',
	`call_start_time` DATETIME COMMENT '通信開始日時',
	`call_end_time` DATETIME COMMENT '通信終了日時（強制終了時はその日時）',
	`guide_status` TINYINT UNSIGNED  NOT NULL COMMENT '案内状態 0: 未案内 1: 案内済 2: 不在 3: 無断キャンセル 4: 案内済再案内 5: 不在・無断キャンセル再案内 6: 接客中 7: 接客中再案内',
	`auto_call_flg` TINYINT UNSIGNED default 0 NOT NULL COMMENT '自動呼出フラグ 0: 手動呼出 1: 自動呼出',
	`acs2_callable_seat` TEXT COMMENT 'ACS2用 電話呼出時に紐付けられる呼出可能席(JSON)',
	`created_at` DATETIME COMMENT 'レコード作成日時',
	`updated_at` DATETIME COMMENT 'レコード更新日時',
	PRIMARY KEY (`id`),
	KEY `index_receive_id`(`receive_id`),
	KEY `index_transmission_status`(`transmission_status`),
	KEY `index_result_status`(`result_status`),
	KEY `index_result_notified`(`result_notified`)
) COMMENT='電話呼出API通信ログ管理テーブル';

#-----------------------------------------------------------------------------
#-- receive_agent_history
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `receive_agent_history`;


CREATE TABLE `receive_agent_history`
(
	`id` BIGINT  NOT NULL COMMENT 'ID',
	`agent_date` DATETIME COMMENT '予約代行の目標案内予定時間（会員の登録した予約希望時間）',
	`guide_target_time` DATETIME COMMENT '待ち時間ロジックが基準時間固定の場合の案内予定時間を保持する。',
	`call_tel_cnt` TINYINT default 0 COMMENT '電話呼出回数 (「電話呼出コール」ボタン押下し、成功する度にインクリメントされる)',
	`call_tel_date` DATETIME COMMENT '電話呼出最終日時 (「電話呼出コール」ボタン押下し、成功するになった日時)',
	`parent_id` BIGINT COMMENT '連続受付時の親receieve_id',
	`service_start_time` DATETIME COMMENT '接客開始日時',
	`service_end_time` DATETIME COMMENT '接客完了日時',
	`service_end_status` VARCHAR(4) COMMENT '接客完了ステータス',
	`employee_name` VARCHAR(20) COMMENT '担当者名',
	`created_at` DATETIME COMMENT 'レコード作成日時',
	`updated_at` DATETIME COMMENT 'レコード更新日時',
	PRIMARY KEY (`id`),
	KEY `agent_date`(`agent_date`)
) COMMENT='当日以降の代行予約データの格納テーブル';

#-----------------------------------------------------------------------------
#-- i_receive_more_hist
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `i_receive_more_hist`;


CREATE TABLE `i_receive_more_hist`
(
	`receive_id` BIGINT  NOT NULL COMMENT '予約ID',
	`wait_ivr_chk_sts` TINYINT UNSIGNED default 0 NOT NULL COMMENT '順番待ち受付IVR確認状態 (順番待ち受付におけるIVRでの確認の状態。1:承諾 2.キャンセル 10.クリア)',
	`wait_ivr_chk_at` DATETIME COMMENT '順番待ち受付IVR最終確認日時 (順番待ち受付におけるIVRでの確認日時。順番待ち受付IVR確認状態の全状態における最終日時)',
	`serv_call_tel_cnt` TINYINT UNSIGNED default 0 NOT NULL COMMENT '接客中電話呼出回数 (「電話呼出コール」ボタン押下し、成功する度にインクリメントされる)',
	`serv_call_tel_at` DATETIME COMMENT '接客中電話呼出最終日時 (「電話呼出コール」ボタン押下し、成功するになった日時)',
	`serv_ivr_chk_sts` TINYINT UNSIGNED default 0 NOT NULL COMMENT '接客中IVR確認状態 (接客中におけるIVRでの確認の状態。1:承諾 2.キャンセル 10.クリア)',
	`serv_ivr_chk_at` DATETIME COMMENT '接客中IVR最終確認日時 (接客中におけるIVRでの確認日時。接客中IVR確認状態の全状態における最終日時)',
	`serv_mem_called_at` DATETIME COMMENT '接客中携帯呼出日時',
	`created_at` DATETIME COMMENT 'レコード作成日時',
	`updated_at` DATETIME COMMENT 'レコード更新日時',
	PRIMARY KEY (`receive_id`),
	KEY `ix_i_receive_more_hist_1`(`created_at`)
) COMMENT='予約データ履歴追加情報テーブル';

#-----------------------------------------------------------------------------
#-- receive_history
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `receive_history`;


CREATE TABLE `receive_history`
(
	`id` BIGINT  NOT NULL COMMENT 'ID',
	`reserve_id` BIGINT COMMENT '使ってはいけない! 旧システムからのデータ移行のとき、店舗ごとの予約IDを保持する 新システムでは参照しない',
	`owner_shop_id` BIGINT COMMENT 'オーナーID',
	`shop_id` BIGINT COMMENT '店舗ID',
	`member_id` INTEGER default 0 COMMENT '会員ＩＤ',
	`reserve_status` TINYINT COMMENT '予約状態 0:予約 4:仮予約 9:削除 旧： 予約状態 0:予約 1:キャンセル 2:未来店 3:不明 9:削除',
	`reserve_type` TINYINT COMMENT '予約タイプ 0:順番待ち 1:予約 2:予約台帳',
	`is_send` TINYINT default 0 COMMENT 'メール送信状態 0:未送信 1:送信済み',
	`is_send_information` TINYINT default 0 NOT NULL COMMENT '有料会員N分前送信フラグ 0:未送信 1:送信済み',
	`information_mail_time` SMALLINT UNSIGNED default 0 NOT NULL COMMENT '有料会員N分前設定時間 0:送信しない',
	`receipt_no` INTEGER default 0 COMMENT '受付番号',
	`receipt_date` DATETIME COMMENT '案内予定日時 ※席に着きたい時間 順番待ちの場合は受付日時 時間指定・将来順番待ちの時は予約時に指定した日時 「戻す」場合は割り込ませたい順番になるようにこの日時を変更',
	`late_date` DATETIME COMMENT '遅刻した場合、到着した日時(推測) 無断キャンセルから「戻す」をした時に、receipt_date がコピーされていることを確認',
	`guide_status` TINYINT COMMENT '案内状態 0:未案内 1:案内済 2:不在 3:無断キャンセル 4:案内済再案内 5:不在再案内 6:接客中 7:接客中再案内  8:キャンセル 旧：案内状態 0:未案内 1:案内済み 2:呼び出し済み（現在expired扱い。callはどうしようか？）',
	`wait_count` SMALLINT default 0 COMMENT '待ち回数 (無断キャンセルになる毎にインクリメントされている)',
	`wait_count_on_entry` SMALLINT COMMENT '順番取り時の待ち組数',
	`wait_time` SMALLINT default 0 COMMENT '待ち時間(分) (新規作成時に設定した後は更新されない) (要らない疑惑)',
	`wait_time_on_entry` SMALLINT COMMENT '順番取り時の待ち時間',
	`guide_date` DATETIME COMMENT '案内日付 (案内済になった日時、guided_at の方が適切な名前)',
	`call_date` DATETIME COMMENT '呼び出し日付 (呼び出した日時ではなく、「不在」状態になった日時、「呼出」ボタンとは無関係)',
	`call_cnt` TINYINT default 0 COMMENT '呼び出し回数 (「不在」状態になる度にインクリメントされる)',
	`regist_no` VARCHAR(100) COMMENT '部門別受付ＮＯ',
	`regist_both_no` VARCHAR(100) COMMENT 'どちらでも受付ＮＯ',
	`shop_reserve_condition_id` BIGINT COMMENT '部門選択条件ID',
	`shop_reserve_condition_value` VARCHAR(100) COMMENT '部門選択条件内容',
	`shop_reserve_department_id` BIGINT COMMENT '部門ID null:移行データ（部門なし店舗も含む）',
	`shop_reserve_department_value` VARCHAR(100) COMMENT '部門名',
	`shop_reserve_category_id_1` BIGINT COMMENT '条件１ＩＤ',
	`shop_reserve_category_value_1` VARCHAR(100) COMMENT '条件１内容',
	`shop_reserve_category_id_2` BIGINT COMMENT '条件２ＩＤ',
	`shop_reserve_category_value_2` VARCHAR(100) COMMENT '条件２内容',
	`shop_reserve_category_id_3` BIGINT COMMENT '条件３ＩＤ',
	`shop_reserve_category_value_3` VARCHAR(100) COMMENT '条件３内容',
	`shop_reserve_category_id_4` BIGINT COMMENT '条件４ＩＤ',
	`shop_reserve_category_value_4` VARCHAR(100) COMMENT '条件４内容',
	`shop_reserve_category_id_5` BIGINT COMMENT '条件５ＩＤ',
	`shop_reserve_category_value_5` VARCHAR(100) COMMENT '条件５内容',
	`check_status` TINYINT default 0 COMMENT 'default=0  「タッチパネル来店客チェック」なる機能に使用する',
	`voice_play_status` TINYINT default 0 COMMENT '音声案内済（呼出済）フラグ 0:呼出前 1:呼出済',
	`voice_play_date` DATETIME COMMENT '音声案内 呼出日時',
	`is_main_dochirademo` TINYINT default 0 COMMENT 'default=0  「どちらでも部門」受付データの正データかの判定に使用する 0:副データ 1:正データ',
	`memo` VARCHAR(100) COMMENT 'メモ',
	`spare1` BIGINT COMMENT '予備１',
	`spare2` VARCHAR(100) COMMENT '予備２',
	`entry_date` DATETIME COMMENT 'レコード作成日時',
	`entry_type` TINYINT COMMENT '予約登録元 0:PC管理画面 1:PC表側 2:携帯管理画面 3:携帯表側 4:タッチパネル管理画面 5:タッチパネル 6:API 7:スマートフォンサイト 98:ゲスト（非会員） 99:病院 100:外部API',
	`status_updated_at` DATETIME COMMENT 'ステータス更新日時',
	`created_at` DATETIME COMMENT 'レコード作成日時',
	`updated_at` DATETIME COMMENT 'レコード更新日時',
	PRIMARY KEY (`id`),
	KEY `index_shop_id`(`shop_id`),
	KEY `index_member_id`(`member_id`),
	KEY `index_owner_shop_id`(`owner_shop_id`),
	KEY `index_receipt_date`(`receipt_date`),
	KEY `index_shop_reserve_department_id`(`shop_reserve_department_id`),
	KEY `index_created_at`(`created_at`),
	KEY `index_receive_history_I_1`(`shop_id`, `reserve_type`, `created_at`),
	KEY `index_receive_history_I_2`(`owner_shop_id`, `shop_id`, `reserve_type`, `receipt_date`),
	KEY `index_receive_history_I_3`(`updated_at`, `reserve_type`),
	KEY `index_receive_history_I_4`(`owner_shop_id`, `created_at`, `reserve_type`, `reserve_status`, `guide_status`)
) COMMENT='バッチ処理で当日分から移動される。';

#-----------------------------------------------------------------------------
#-- receive_research
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `receive_research`;


CREATE TABLE `receive_research`
(
	`id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT 'ID',
	`place` VARCHAR(200) COMMENT '実行された場所',
	`data` TEXT COMMENT '挿入されるデータ',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`)
) COMMENT='くら寿司調査用テーブル(2011/02以降)';

#-----------------------------------------------------------------------------
#-- receive_inflow
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `receive_inflow`;


CREATE TABLE `receive_inflow`
(
	`receive_id` BIGINT COMMENT '予約ID (receive.id)',
	`shop_id` BIGINT COMMENT '店舗ID (shop.id)　※receive_historyとjoinすると重くなるためこのテーブルでも持つ',
	`from_shop` INTEGER COMMENT '流入元店舗ID',
	`from_page` INTEGER COMMENT '流入元ページまたは流入元機能　1:近隣店舗誘導',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	PRIMARY KEY (`id`),
	KEY `index_shop_receive_page`(`shop_id`, `receive_id`, `from_page`)
) COMMENT='予約流入元情報（現状は近隣店舗誘導機能で使用）';

#-----------------------------------------------------------------------------
#-- t_rcv_pl
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `t_rcv_pl`;


CREATE TABLE `t_rcv_pl`
(
	`receive_id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT '予約受付ID',
	`owner_shop_id` INTEGER UNSIGNED  NOT NULL COMMENT 'オーナー店舗ID',
	`shop_id` INTEGER UNSIGNED  NOT NULL COMMENT '店舗ID',
	`member_id` INTEGER UNSIGNED  NOT NULL COMMENT '会員ID',
	`shop_mem_id` INTEGER UNSIGNED  NOT NULL COMMENT '店舗会員連携ID',
	`member_rsv_id` VARCHAR(20)  NOT NULL COMMENT '予約者ID',
	`rsv_no` VARCHAR(20) COMMENT '予約番号',
	`rsv_status` TINYINT UNSIGNED COMMENT '予約状態',
	`rsv_type` TINYINT UNSIGNED COMMENT '予約タイプ',
	`rsv_is_send` TINYINT UNSIGNED default 0 COMMENT '予約メール送信状態',
	`rsv_time` DATETIME COMMENT '予約日時',
	`rsv_show_name` VARCHAR(20) COMMENT '予約枠表示名称',
	`rsv_shop_dept_id` INTEGER UNSIGNED COMMENT '予約部門ID',
	`rsv_shop_dept_value` VARCHAR(100) COMMENT '予約部門名',
	`rsv_employee_id` INTEGER UNSIGNED COMMENT '予約担当者ID',
	`rsv_employee_name` VARCHAR(20) COMMENT '予約担当者氏名',
	`rsv_memo` VARCHAR(100) COMMENT '予約受付メモ',
	`rsv_entry_type` TINYINT UNSIGNED COMMENT '予約エントリータイプ',
	`rsv_referer` VARCHAR(255) COMMENT '予約受付リファラ',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`receive_id`),
	KEY `ix_t_rcv_pl1`(`shop_id`, `member_id`, `member_rsv_id`),
	KEY `ix_t_rcv_pl2`(`rsv_no`),
	KEY `ix_t_rcv_pl3`(`member_rsv_id`, `rsv_shop_dept_id`, `rsv_employee_id`)
) COMMENT='会員複数（受診者）の予約受付を管理します。';

#-----------------------------------------------------------------------------
#-- h_rcv_his_pl
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `h_rcv_his_pl`;


CREATE TABLE `h_rcv_his_pl`
(
	`receive_id` BIGINT UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT '予約受付ID',
	`owner_shop_id` INTEGER UNSIGNED  NOT NULL COMMENT 'オーナー店舗ID',
	`shop_id` INTEGER UNSIGNED  NOT NULL COMMENT '店舗ID',
	`member_id` INTEGER UNSIGNED  NOT NULL COMMENT '会員ID',
	`shop_mem_id` INTEGER UNSIGNED  NOT NULL COMMENT '店舗会員連携ID',
	`member_rsv_id` VARCHAR(20)  NOT NULL COMMENT '予約者ID',
	`rsv_no` VARCHAR(20) COMMENT '予約番号',
	`rsv_status` TINYINT UNSIGNED COMMENT '予約状態',
	`rsv_type` TINYINT UNSIGNED COMMENT '予約タイプ',
	`rsv_is_send` TINYINT UNSIGNED default 0 COMMENT '予約メール送信状態',
	`rsv_time` DATETIME COMMENT '予約日時',
	`rsv_show_name` VARCHAR(20) COMMENT '予約枠表示名称',
	`rsv_shop_dept_id` INTEGER UNSIGNED COMMENT '予約部門ID',
	`rsv_shop_dept_value` VARCHAR(100) COMMENT '予約部門名',
	`rsv_employee_id` INTEGER UNSIGNED COMMENT '予約担当者ID',
	`rsv_employee_name` VARCHAR(20) COMMENT '予約担当者氏名',
	`rsv_memo` VARCHAR(100) COMMENT '予約受付メモ',
	`rsv_entry_type` TINYINT UNSIGNED COMMENT '予約エントリータイプ',
	`rsv_referer` VARCHAR(255) COMMENT '予約受付リファラ',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`receive_id`),
	KEY `ix_h_rcv_his_pl1`(`shop_id`, `member_id`, `member_rsv_id`),
	KEY `ix_h_rcv_his_pl2`(`rsv_no`),
	KEY `ix_h_rcv_his_pl3`(`member_rsv_id`, `rsv_shop_dept_id`, `rsv_employee_id`)
) COMMENT='会員複数（受診者）の予約受付を管理します。';

#-----------------------------------------------------------------------------
#-- mmb_s
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `mmb_s`;


CREATE TABLE `mmb_s`
(
	`owner_id` BIGINT  NOT NULL,
	`shop_id` BIGINT  NOT NULL,
	`member_id` INTEGER  NOT NULL,
	`service_id` SMALLINT  NOT NULL,
	`pref_id` TINYINT,
	`name` VARCHAR(40),
	`nickname` VARCHAR(40),
	`email` VARCHAR(100),
	`sex` TINYINT,
	`age` SMALLINT,
	`birth_m` SMALLINT,
	`birth_d` SMALLINT,
	`news_status` TINYINT,
	`entry_date` DATETIME,
	`free_text` TEXT,
	PRIMARY KEY (`owner_id`,`shop_id`,`member_id`,`service_id`),
	KEY `index_shop_id`(`shop_id`),
	KEY `index_member_id`(`member_id`),
	KEY `index_entry_date`(`entry_date`)
);

#-----------------------------------------------------------------------------
#-- rsv_d
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `rsv_d`;


CREATE TABLE `rsv_d`
(
	`owner_id` BIGINT  NOT NULL,
	`shop_id` BIGINT  NOT NULL,
	`target_date` DATETIME  NOT NULL,
	`date_type` TINYINT  NOT NULL,
	`rsv_type` TINYINT  NOT NULL,
	`use_type` TINYINT  NOT NULL,
	`department_id` INTEGER default 0 NOT NULL,
	`r_grp_sum` INTEGER,
	`r_psn_sum` INTEGER,
	`r_psn1_grp_sum` INTEGER,
	`r_psn2_grp_sum` INTEGER,
	`r_psn3_grp_sum` INTEGER,
	`r_psn4_grp_sum` INTEGER,
	`r_psn5_grp_sum` INTEGER,
	`r_psn6_grp_sum` INTEGER,
	`r_psn7_grp_sum` INTEGER,
	`r_psn8_grp_sum` INTEGER,
	`r_psn9_grp_sum` INTEGER,
	`r_psn10_grp_sum` INTEGER,
	`g_grp_sum` INTEGER,
	`g_psn_sum` INTEGER,
	`g_psn1_grp_sum` INTEGER,
	`g_psn2_grp_sum` INTEGER,
	`g_psn3_grp_sum` INTEGER,
	`g_psn4_grp_sum` INTEGER,
	`g_psn5_grp_sum` INTEGER,
	`g_psn6_grp_sum` INTEGER,
	`g_psn7_grp_sum` INTEGER,
	`g_psn8_grp_sum` INTEGER,
	`g_psn9_grp_sum` INTEGER,
	`g_psn10_grp_sum` INTEGER,
	`g_time_avg` INTEGER,
	`c_grp_sum` INTEGER,
	`c_psn_sum` INTEGER,
	`c_psn1_grp_sum` INTEGER,
	`c_psn2_grp_sum` INTEGER,
	`c_psn3_grp_sum` INTEGER,
	`c_psn4_grp_sum` INTEGER,
	`c_psn5_grp_sum` INTEGER,
	`c_psn6_grp_sum` INTEGER,
	`c_psn7_grp_sum` INTEGER,
	`c_psn8_grp_sum` INTEGER,
	`c_psn9_grp_sum` INTEGER,
	`c_psn10_grp_sum` INTEGER,
	`c_time_avg` INTEGER,
	`n_grp_sum` INTEGER,
	`n_psn_sum` INTEGER,
	`n_psn1_grp_sum` INTEGER,
	`n_psn2_grp_sum` INTEGER,
	`n_psn3_grp_sum` INTEGER,
	`n_psn4_grp_sum` INTEGER,
	`n_psn5_grp_sum` INTEGER,
	`n_psn6_grp_sum` INTEGER,
	`n_psn7_grp_sum` INTEGER,
	`n_psn8_grp_sum` INTEGER,
	`n_psn9_grp_sum` INTEGER,
	`n_psn10_grp_sum` INTEGER,
	`n_time_avg` INTEGER,
	`qr_reg_sum` INTEGER,
	`action_date` DATETIME,
	`widget_imp_num` INTEGER,
	`widget_click_num` INTEGER,
	`shop_member_regist_num` INTEGER,
	`waiting_count_num` INTEGER,
	`reserve_count_num` INTEGER,
	PRIMARY KEY (`owner_id`,`shop_id`,`target_date`,`date_type`,`rsv_type`,`use_type`,`department_id`),
	KEY `index_owner_id`(`owner_id`),
	KEY `index_shop_id`(`shop_id`),
	KEY `index_department_id`(`department_id`)
);

#-----------------------------------------------------------------------------
#-- rsv_m
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `rsv_m`;


CREATE TABLE `rsv_m`
(
	`owner_id` BIGINT  NOT NULL,
	`shop_id` BIGINT  NOT NULL,
	`target_date` DATETIME  NOT NULL,
	`rsv_type` TINYINT  NOT NULL,
	`use_type` TINYINT  NOT NULL,
	`department_id` INTEGER default 0 NOT NULL,
	`r_grp_sum` INTEGER,
	`r_psn_sum` INTEGER,
	`r_psn1_grp_sum` INTEGER,
	`r_psn2_grp_sum` INTEGER,
	`r_psn3_grp_sum` INTEGER,
	`r_psn4_grp_sum` INTEGER,
	`r_psn5_grp_sum` INTEGER,
	`r_psn6_grp_sum` INTEGER,
	`r_psn7_grp_sum` INTEGER,
	`r_psn8_grp_sum` INTEGER,
	`r_psn9_grp_sum` INTEGER,
	`r_psn10_grp_sum` INTEGER,
	`g_grp_sum` INTEGER,
	`g_psn_sum` INTEGER,
	`g_psn1_grp_sum` INTEGER,
	`g_psn2_grp_sum` INTEGER,
	`g_psn3_grp_sum` INTEGER,
	`g_psn4_grp_sum` INTEGER,
	`g_psn5_grp_sum` INTEGER,
	`g_psn6_grp_sum` INTEGER,
	`g_psn7_grp_sum` INTEGER,
	`g_psn8_grp_sum` INTEGER,
	`g_psn9_grp_sum` INTEGER,
	`g_psn10_grp_sum` INTEGER,
	`g_time_avg` INTEGER,
	`c_grp_sum` INTEGER,
	`c_psn_sum` INTEGER,
	`c_psn1_grp_sum` INTEGER,
	`c_psn2_grp_sum` INTEGER,
	`c_psn3_grp_sum` INTEGER,
	`c_psn4_grp_sum` INTEGER,
	`c_psn5_grp_sum` INTEGER,
	`c_psn6_grp_sum` INTEGER,
	`c_psn7_grp_sum` INTEGER,
	`c_psn8_grp_sum` INTEGER,
	`c_psn9_grp_sum` INTEGER,
	`c_psn10_grp_sum` INTEGER,
	`c_time_avg` INTEGER,
	`n_grp_sum` INTEGER,
	`n_psn_sum` INTEGER,
	`n_psn1_grp_sum` INTEGER,
	`n_psn2_grp_sum` INTEGER,
	`n_psn3_grp_sum` INTEGER,
	`n_psn4_grp_sum` INTEGER,
	`n_psn5_grp_sum` INTEGER,
	`n_psn6_grp_sum` INTEGER,
	`n_psn7_grp_sum` INTEGER,
	`n_psn8_grp_sum` INTEGER,
	`n_psn9_grp_sum` INTEGER,
	`n_psn10_grp_sum` INTEGER,
	`n_time_avg` INTEGER,
	`qr_reg_sum` INTEGER,
	`action_date` DATETIME,
	PRIMARY KEY (`owner_id`,`shop_id`,`target_date`,`rsv_type`,`use_type`,`department_id`),
	KEY `index_owner_id`(`owner_id`),
	KEY `index_shop_id`(`shop_id`),
	KEY `index_department_id`(`department_id`),
	KEY `index_rsv_m_I_1`(`owner_id`, `shop_id`, `department_id`, `target_date`)
);

#-----------------------------------------------------------------------------
#-- rsv_m_week
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `rsv_m_week`;


CREATE TABLE `rsv_m_week`
(
	`owner_id` BIGINT  NOT NULL,
	`shop_id` BIGINT  NOT NULL,
	`target_date` DATETIME  NOT NULL,
	`date_type` TINYINT  NOT NULL,
	`rsv_type` TINYINT  NOT NULL,
	`use_type` TINYINT  NOT NULL,
	`department_id` INTEGER default 0 NOT NULL,
	`r_grp_sum` INTEGER,
	`r_psn_sum` INTEGER,
	`r_psn1_grp_sum` INTEGER,
	`r_psn2_grp_sum` INTEGER,
	`r_psn3_grp_sum` INTEGER,
	`r_psn4_grp_sum` INTEGER,
	`r_psn5_grp_sum` INTEGER,
	`r_psn6_grp_sum` INTEGER,
	`r_psn7_grp_sum` INTEGER,
	`r_psn8_grp_sum` INTEGER,
	`r_psn9_grp_sum` INTEGER,
	`r_psn10_grp_sum` INTEGER,
	`g_grp_sum` INTEGER,
	`g_psn_sum` INTEGER,
	`g_psn1_grp_sum` INTEGER,
	`g_psn2_grp_sum` INTEGER,
	`g_psn3_grp_sum` INTEGER,
	`g_psn4_grp_sum` INTEGER,
	`g_psn5_grp_sum` INTEGER,
	`g_psn6_grp_sum` INTEGER,
	`g_psn7_grp_sum` INTEGER,
	`g_psn8_grp_sum` INTEGER,
	`g_psn9_grp_sum` INTEGER,
	`g_psn10_grp_sum` INTEGER,
	`g_time_avg` INTEGER,
	`c_grp_sum` INTEGER,
	`c_psn_sum` INTEGER,
	`c_psn1_grp_sum` INTEGER,
	`c_psn2_grp_sum` INTEGER,
	`c_psn3_grp_sum` INTEGER,
	`c_psn4_grp_sum` INTEGER,
	`c_psn5_grp_sum` INTEGER,
	`c_psn6_grp_sum` INTEGER,
	`c_psn7_grp_sum` INTEGER,
	`c_psn8_grp_sum` INTEGER,
	`c_psn9_grp_sum` INTEGER,
	`c_psn10_grp_sum` INTEGER,
	`c_time_avg` INTEGER,
	`n_grp_sum` INTEGER,
	`n_psn_sum` INTEGER,
	`n_psn1_grp_sum` INTEGER,
	`n_psn2_grp_sum` INTEGER,
	`n_psn3_grp_sum` INTEGER,
	`n_psn4_grp_sum` INTEGER,
	`n_psn5_grp_sum` INTEGER,
	`n_psn6_grp_sum` INTEGER,
	`n_psn7_grp_sum` INTEGER,
	`n_psn8_grp_sum` INTEGER,
	`n_psn9_grp_sum` INTEGER,
	`n_psn10_grp_sum` INTEGER,
	`n_time_avg` INTEGER,
	`qr_reg_sum` INTEGER,
	`action_date` DATETIME,
	PRIMARY KEY (`owner_id`,`shop_id`,`target_date`,`date_type`,`rsv_type`,`use_type`,`department_id`),
	KEY `index_owner_id`(`owner_id`),
	KEY `index_shop_id`(`shop_id`),
	KEY `index_department_id`(`department_id`),
	KEY `index_rsv_m_week_I_1`(`owner_id`, `shop_id`, `department_id`, `target_date`),
	KEY `index_rsv_m_week_I_2`(`owner_id`, `shop_id`, `department_id`, `rsv_type`, `date_type`)
);

#-----------------------------------------------------------------------------
#-- time_week
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `time_week`;


CREATE TABLE `time_week`
(
	`owner_id` BIGINT  NOT NULL,
	`shop_id` BIGINT  NOT NULL,
	`date_type` TINYINT  NOT NULL,
	`use_type` TINYINT  NOT NULL,
	`department_id` INTEGER default 0 NOT NULL,
	`g_grp_sum` BIGINT,
	`c_grp_sum` INTEGER,
	`n_grp_sum` INTEGER,
	`g_time_avg` INTEGER,
	`c_time_avg` INTEGER,
	`n_time_avg` INTEGER,
	`count_date` DATETIME,
	`action_date` DATETIME,
	PRIMARY KEY (`owner_id`,`shop_id`,`date_type`,`use_type`,`department_id`),
	KEY `index_owner_id`(`owner_id`),
	KEY `index_shop_id`(`shop_id`),
	KEY `index_department_id`(`department_id`)
);

#-----------------------------------------------------------------------------
#-- wait_d
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `wait_d`;


CREATE TABLE `wait_d`
(
	`owner_id` BIGINT  NOT NULL,
	`shop_id` BIGINT  NOT NULL,
	`target_date` DATETIME  NOT NULL,
	`target_hour` INTEGER  NOT NULL,
	`date_type` TINYINT  NOT NULL,
	`use_type` TINYINT  NOT NULL,
	`department_id` INTEGER default 0 NOT NULL,
	`g_grp_sum` INTEGER,
	`g_time_avg` INTEGER,
	`g_time00_05_grp_sum` INTEGER,
	`g_time05_10_grp_sum` INTEGER,
	`g_time10_20_grp_sum` INTEGER,
	`g_time20_30_grp_sum` INTEGER,
	`g_time30_45_grp_sum` INTEGER,
	`g_time45_60_grp_sum` INTEGER,
	`g_time60_grp_sum` INTEGER,
	`c_grp_sum` INTEGER,
	`c_time_avg` INTEGER,
	`c_time00_05_grp_sum` INTEGER,
	`c_time05_10_grp_sum` INTEGER,
	`c_time10_20_grp_sum` INTEGER,
	`c_time20_30_grp_sum` INTEGER,
	`c_time30_45_grp_sum` INTEGER,
	`c_time45_60_grp_sum` INTEGER,
	`c_time60_grp_sum` INTEGER,
	`n_grp_sum` INTEGER,
	`n_time_avg` INTEGER,
	`n_time00_05_grp_sum` INTEGER,
	`n_time05_10_grp_sum` INTEGER,
	`n_time10_20_grp_sum` INTEGER,
	`n_time20_30_grp_sum` INTEGER,
	`n_time30_45_grp_sum` INTEGER,
	`n_time45_60_grp_sum` INTEGER,
	`n_time60_grp_sum` INTEGER,
	`action_date` DATETIME,
	PRIMARY KEY (`owner_id`,`shop_id`,`target_date`,`target_hour`,`date_type`,`use_type`,`department_id`),
	KEY `index_owner_id`(`owner_id`),
	KEY `index_shop_id`(`shop_id`),
	KEY `index_department_id`(`department_id`),
	KEY `index_wait_d_I_1`(`owner_id`, `shop_id`, `department_id`, `target_date`)
);

#-----------------------------------------------------------------------------
#-- wait_m
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `wait_m`;


CREATE TABLE `wait_m`
(
	`owner_id` BIGINT  NOT NULL,
	`shop_id` BIGINT  NOT NULL,
	`target_date` DATETIME  NOT NULL,
	`target_hour` INTEGER  NOT NULL,
	`use_type` TINYINT  NOT NULL,
	`department_id` INTEGER default 0 NOT NULL,
	`g_grp_sum` INTEGER,
	`g_time_avg` INTEGER,
	`g_time00_05_grp_sum` INTEGER,
	`g_time05_10_grp_sum` INTEGER,
	`g_time10_20_grp_sum` INTEGER,
	`g_time20_30_grp_sum` INTEGER,
	`g_time30_45_grp_sum` INTEGER,
	`g_time45_60_grp_sum` INTEGER,
	`g_time60_grp_sum` INTEGER,
	`c_grp_sum` INTEGER,
	`c_time_avg` INTEGER,
	`c_time00_05_grp_sum` INTEGER,
	`c_time05_10_grp_sum` INTEGER,
	`c_time10_20_grp_sum` INTEGER,
	`c_time20_30_grp_sum` INTEGER,
	`c_time30_45_grp_sum` INTEGER,
	`c_time45_60_grp_sum` INTEGER,
	`c_time60_grp_sum` INTEGER,
	`n_grp_sum` INTEGER,
	`n_time_avg` INTEGER,
	`n_time00_05_grp_sum` INTEGER,
	`n_time05_10_grp_sum` INTEGER,
	`n_time10_20_grp_sum` INTEGER,
	`n_time20_30_grp_sum` INTEGER,
	`n_time30_45_grp_sum` INTEGER,
	`n_time45_60_grp_sum` INTEGER,
	`n_time60_grp_sum` INTEGER,
	`action_date` DATETIME,
	PRIMARY KEY (`owner_id`,`shop_id`,`target_date`,`target_hour`,`use_type`,`department_id`),
	KEY `index_owner_id`(`owner_id`),
	KEY `index_shop_id`(`shop_id`),
	KEY `index_department_id`(`department_id`),
	KEY `index_wait_m_I_1`(`owner_id`, `shop_id`, `department_id`, `target_date`)
);

#-----------------------------------------------------------------------------
#-- member_daily_rpt
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `member_daily_rpt`;


CREATE TABLE `member_daily_rpt`
(
	`owner_id` BIGINT  NOT NULL,
	`shop_id` BIGINT  NOT NULL,
	`date` DATETIME  NOT NULL,
	`sex` TINYINT  NOT NULL,
	`type` TINYINT  NOT NULL,
	`age_under_10s_sum` INTEGER,
	`age_10s_sum` INTEGER,
	`age_20s_sum` INTEGER,
	`age_30s_sum` INTEGER,
	`age_40s_sum` INTEGER,
	`age_50s_sum` INTEGER,
	`age_60s_sum` INTEGER,
	`age_70s_sum` INTEGER,
	`age_80s_sum` INTEGER,
	`age_90s_sum` INTEGER,
	`age_over_100s_sum` INTEGER,
	`created_at` DATETIME,
	`updated_at` DATETIME,
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	PRIMARY KEY (`id`),
	KEY `index_owner_id`(`owner_id`),
	KEY `index_shop_id`(`shop_id`)
);

#-----------------------------------------------------------------------------
#-- shop_reserve_department_condition
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `shop_reserve_department_condition`;


CREATE TABLE `shop_reserve_department_condition`
(
	`id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT '選択条件ID',
	`shop_id` BIGINT  NOT NULL COMMENT '店舗ID',
	`name` VARCHAR(100) COMMENT '条件名',
	`status` TINYINT COMMENT '条件の可否 0：有効 1：無効',
	`is_deleted` TINYINT COMMENT '削除フラグ（0:有効データ、1：削除済）要否は検討',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	KEY `index_shop_id`(`shop_id`)
) COMMENT='部門選択条件データを格納する';

#-----------------------------------------------------------------------------
#-- shop_reserve_department_department_condition_mapping
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `shop_reserve_department_department_condition_mapping`;


CREATE TABLE `shop_reserve_department_department_condition_mapping`
(
	`id` BIGINT  NOT NULL AUTO_INCREMENT,
	`shop_id` BIGINT COMMENT '店舗ID',
	`shop_reserve_department_condition_id` BIGINT  NOT NULL COMMENT '選択条件ID',
	`shop_reserve_department_id` BIGINT COMMENT '部門ID',
	`condition_value_max` BIGINT COMMENT '設定値 最大値',
	`condition_value_min` BIGINT COMMENT '設定値　最小値',
	`is_deleted` TINYINT default 0 COMMENT '削除フラグ 0:有効データ 1：削除済',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	KEY `index_shop_id`(`shop_id`),
	KEY `index_shop_reserve_department_condition_id`(`shop_reserve_department_condition_id`),
	KEY `index_shop_reserve_department_id`(`shop_reserve_department_id`)
) COMMENT='部門選択条件に紐付く部門データを格納する。';

#-----------------------------------------------------------------------------
#-- shop_reserve_department
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `shop_reserve_department`;


CREATE TABLE `shop_reserve_department`
(
	`id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT '部門ID',
	`shop_id` BIGINT COMMENT '店舗ID',
	`name` VARCHAR(100) COMMENT '部門名',
	`max_num` BIGINT COMMENT '最大値　(受入数)',
	`min_num` BIGINT COMMENT '最小値　(受入数)',
	`seat` SMALLINT COMMENT '席数',
	`regist_no_char` VARCHAR(80) COMMENT '受付ＮＯ名称',
	`regist_no_current` INTEGER default 1 COMMENT '受付ＮＯカレント値（00000）',
	`regist_no_current_digits` SMALLINT default 3 COMMENT '受付ＮＯカレント値表示桁数：1～５　',
	`is_dochirademo` VARCHAR(255) default '1' COMMENT 'どちらでも対象区分 ０：対象外 1:対象',
	`display_on_toutchpanel` TINYINT default 0 COMMENT '受付用タッチパネル表示区分 0:非表示 1:表示',
	`display_on_mobile` TINYINT default 1 COMMENT 'モバイルサイト表示区分 0:非表示 1:表示',
	`display_order` TINYINT default 0 COMMENT '画面表示順',
	`status` SMALLINT default 1 COMMENT '反映状況 0:停止中 １:反映中',
	`is_deleted` SMALLINT default 0 COMMENT '削除フラグ 0:有効データ 1：削除済要否は検討',
	`wait_line_extra` SMALLINT default 0 NOT NULL COMMENT 'N組以上の待ち時間設定',
	`print_message` VARCHAR(1024) COMMENT '発券下部のメッセージ',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	`department_msg` VARCHAR(255) COMMENT '部門説明文',
	`regist_no_range_min` INTEGER COMMENT '受付番号範囲最小値 ※shop_reserve_department_description.banknotes = 3（発券連番方法＝「部門ごと（範囲設定）」）のときのみ有効',
	`regist_no_range_max` INTEGER COMMENT '受付番号範囲最大値 ※shop_reserve_department_description.banknotes = 3（発券連番方法＝「部門ごと（範囲設定）」）のときのみ有効',
	`waiting_time_touchpanel` TINYINT default 1 COMMENT 'タッチパネル待ち時間表示 0:非表示 1:表示',
	`waiting_time_mobile` TINYINT default 1 COMMENT 'モバイルサイト待ち時間表示 0:非表示 1:表示',
	`wait_time_display_type` TINYINT default 1 NOT NULL COMMENT '待ち時間表示タイプ 1: 最大待ち時間 2: 最小待ち時間 ～ 最大待ち時間',
	`wait_time_min` INTEGER COMMENT '最小案内時間（分）',
	`reserve_type` TINYINT default 0 COMMENT '予約タイプ 0:順番待ち 1:予約　※shop.screen_kind = 3 (D:時間指定・順番待ち併用受付仕様) の場合のみ有効',
	`department_attention` VARCHAR(255) COMMENT '部門注意書き ※shop.screen_kind = 3 (D:時間指定・順番待ち併用受付仕様) の場合のみ有効',
	`department_attention_mobile` VARCHAR(255) COMMENT '携帯表示用部門注意書き ※shop.screen_kind = 3 (D:時間指定・順番待ち併用受付仕様) の場合のみ有効',
	`receipt_date_print` TINYINT default 1 COMMENT '案内予定時刻印刷 0:しない 1:する　※shop.screen_kind = 3 (D:時間指定・順番待ち併用受付仕様) の場合のみ有効',
	`service_time` INTEGER default 0 NOT NULL COMMENT '接客時間',
	`reserve_limit` INTEGER default 0 NOT NULL COMMENT '受付組数',
	`wait_status` TINYINT default 1 NOT NULL COMMENT '順番待ち予約可否 1: 許可 2: 不許可',
	`reserve_status` TINYINT default 1 NOT NULL COMMENT '将来順番予約可否 1: 許可 2: 不許可',
	`group_id` BIGINT  NOT NULL COMMENT '席連動グループID',
	`svc_alt_min` TINYINT COMMENT '接客終了アラート分 [-]接客終了時刻の「n分前」 [+]接客終了時刻の「n分後」',
	PRIMARY KEY (`id`),
	KEY `index_shop_id`(`shop_id`),
	INDEX `shop_reserve_department_FI_1` (`group_id`)
) COMMENT='部門マスタデータを格納';

#-----------------------------------------------------------------------------
#-- shop_reserve_department_description
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `shop_reserve_department_description`;


CREATE TABLE `shop_reserve_department_description`
(
	`id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT 'ID',
	`shop_id` BIGINT  NOT NULL COMMENT '店舗ID',
	`description` TEXT COMMENT '説明文',
	`comment` TEXT COMMENT '注意書き',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	`banknotes` TINYINT default 0 NOT NULL COMMENT '発券連番方法 0:部門ごと 1:連番 2:ランダム 3:部門ごと（範囲設定）',
	`list_confirm` TINYINT default 1 NOT NULL COMMENT '一覧確認ボタン 0:有り 1:無し',
	`criteria_both_status` TINYINT default 1 NOT NULL COMMENT 'どちらでもの副表示・非表示 0:表示 1:非表示',
	`sort_type` TINYINT  NOT NULL COMMENT '受付データの並び順 0:案内予定が早い順 1:受付順',
	`number_disp_status` TINYINT default 1 NOT NULL COMMENT '受付順・案内順の番号 0:非表示 1:表示',
	`wait_time_disp_total` TINYINT default 0 NOT NULL COMMENT '待ち時間、待ち組数の累計表示 0: 無し 1: 有り',
	`department_name` VARCHAR(40) COMMENT '部門機能の名称',
	`interlocking_seat_reserve_time_pitch` INTEGER default 0 NOT NULL COMMENT '将来順番予約　予約時間ピッチ（分）',
	PRIMARY KEY (`id`),
	UNIQUE KEY `shop_id` (`shop_id`),
	KEY `index_shop_id`(`shop_id`)
) COMMENT='店舗部門管理設定の説明文・注意書き';

#-----------------------------------------------------------------------------
#-- shop_reserve_department_category_mapping
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `shop_reserve_department_category_mapping`;


CREATE TABLE `shop_reserve_department_category_mapping`
(
	`id` BIGINT  NOT NULL,
	`shop_id` BIGINT COMMENT '店舗ID',
	`shop_reserve_department_id` BIGINT COMMENT '部門ID',
	`shop_reserve_category_id` BIGINT COMMENT '予約カテゴリID',
	`display_order` TINYINT COMMENT '画面表示順',
	`status` SMALLINT default 0 COMMENT '運用ステータス 0:反映中 1:停止中',
	`is_deleted` SMALLINT default 0 COMMENT '削除フラグ 0:有効データ 1：削除済  要否は検討',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	KEY `index_shop_id`(`shop_id`),
	KEY `index_shop_reserve_department_id`(`shop_reserve_department_id`),
	KEY `index_shop_reserve_category_id`(`shop_reserve_category_id`)
) COMMENT='部門毎予約カテゴリ';

#-----------------------------------------------------------------------------
#-- shop_reserve_category
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `shop_reserve_category`;


CREATE TABLE `shop_reserve_category`
(
	`id` BIGINT  NOT NULL COMMENT '予約カテゴリID',
	`shop_id` BIGINT COMMENT '店舗ID',
	`display_order` TINYINT COMMENT '表示順',
	`name` VARCHAR(100) COMMENT '予約カテゴリ 名称',
	`description` VARCHAR(100) COMMENT '予約カテゴリ　説明文',
	`attention` VARCHAR(100) COMMENT '予約カテゴリ　注釈文',
	`type` TINYINT COMMENT '入力タイプ 0:テキスト 1:数値 2:選択肢',
	`attribute` TINYINT COMMENT '属性 0：無し 1:人数 2:名前 3:電話番号 4:診察券番号',
	`reserve` TINYINT COMMENT '順番待ち 0:使用する　１：使用しない',
	`booking` TINYINT COMMENT '時間指定予約・将来順番受付 0:使用する　１：使用しない',
	`touchpanel` TINYINT COMMENT 'タッチパネル(予約登録)で使用 0:使用する　１：使用しない',
	`touchpanel_reception` TINYINT default 1 NOT NULL COMMENT 'タッチパネル受付画面で使用 0:使用する 1:使用しない',
	`touchpanel_staff` TINYINT default 1 NOT NULL COMMENT 'タッチパネルスタッフ画面で使用 0:使用する 1:使用しない',
	`touchpanel_reserve` TINYINT default 1 NOT NULL COMMENT 'タッチパネル予約登録で使用 0:使用する 1:使用しない',
	`touchpanel_staff_category_display_status` TINYINT default 0 COMMENT 'スタッフ画面のカテゴリ設定ページでの予約カテゴリボタン表示 0:使用する 1:使用しない',
	`disp_panel` TINYINT COMMENT 'タッチパネル(店頭画面)に表示 0:使用する　１：使用しない',
	`continuous_reception` TINYINT default 1 NOT NULL COMMENT '連続受付で使用 0:使用する　１：使用しない',
	`touchpanel_staff_immediate_guide` TINYINT default 1 NOT NULL COMMENT '即時案内使用可否 使用する：0  使用しない：1',
	`text_type` TINYINT COMMENT '文字列タイプ 0:全角かな 1:半角英数 2:半角数値',
	`text_max` SMALLINT COMMENT '文字列最大文字数',
	`text_min` SMALLINT COMMENT '文字列最小文字数',
	`num_max` INTEGER COMMENT '最大数値',
	`num_min` INTEGER COMMENT '最小数値',
	`use_condition_category_id` BIGINT COMMENT '使用条件カテゴリID',
	`use_condition_category_option_ids` VARCHAR(100) COMMENT '仕様条件カテゴリオプションID（カンマ区切り）。use_condition_category_id がある場合、ここで指定したIDのオプションが選択されている場合にのみ表示される。',
	`memo` VARCHAR(255) COMMENT '備考 ０：有効　１：無効',
	`show_attention_flg` TINYINT default 0 COMMENT '注釈文ポップアップ表示フラグ',
	`status` SMALLINT default 0 COMMENT '運用ステータス 0:反映中 1:停止中',
	`admin_status` SMALLINT default 0 COMMENT '（管理画面設定）運用ステータス 0:反映中 1:停止中',
	`is_deleted` SMALLINT default 0 COMMENT '削除フラグ 0:有効データ 1：削除済  要否は検討',
	`receive_print` TINYINT default 0 COMMENT '（店舗管理）受付一覧レポート 0:表示する 1:表示しない',
	`use_hist_shw_flg` TINYINT UNSIGNED default 0 COMMENT '利用履歴表示区分',
	`ticket_print_flg` TINYINT UNSIGNED default 0 COMMENT '発券用紙印字フラグ 0:印字しない 1:印字する',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	KEY `index_shop_id`(`shop_id`)
) COMMENT='予約カテゴリマスタ';

#-----------------------------------------------------------------------------
#-- shop_reserve_category_option
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `shop_reserve_category_option`;


CREATE TABLE `shop_reserve_category_option`
(
	`id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT 'オプションＩＤ',
	`shop_id` BIGINT COMMENT '店舗ID',
	`shop_reserve_category_id` BIGINT COMMENT '予約カテゴリＩＤ',
	`display_order` TINYINT COMMENT '表示順',
	`name` VARCHAR(20) COMMENT '名称',
	`background_color` VARCHAR(6) COMMENT '背景色 表示する際の１６進数の背景色 /^[0-9a-f]{6}$/ 現在は JINS 仕様のタッチパネル以外では使用しない 例: ffffff 000000',
	`mobile` TINYINT default 0 COMMENT '順番待ち(サイト)表示権限 0:使用する 1:使用しない',
	`future_rsv_flg` TINYINT default 0 COMMENT '将来順番予約(サイト)表示権限 0:使用する 1:使用しない',
	`receipt_flg` TINYINT default 0 COMMENT 'タッチパネル受付画面表示権限 0:使用する 1:使用しない',
	`staff_rsv_flg` TINYINT default 0 COMMENT 'タッチパネルスタッフ画面の順番待ち表示権限 0:使用する 1:使用しない',
	`staff_future_rsv_flg` TINYINT default 0 COMMENT 'タッチパネルスタッフ画面の将来順番予約表示権限 0:使用する 1:使用しない',
	`status` TINYINT default 0 COMMENT '承認 ０：承認　1：非承認',
	`admin_status` TINYINT default 0 COMMENT '（管理画面設定）承認 ０：承認　1：非承認',
	`memo` VARCHAR(200) COMMENT '使用してないかも',
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	KEY `index_shop_id`(`shop_id`),
	KEY `index_shop_reserve_category_id`(`shop_reserve_category_id`)
) COMMENT='予約カテゴリ選択肢のデータを格納';

#-----------------------------------------------------------------------------
#-- member_receive
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `member_receive`;


CREATE TABLE `member_receive`
(
	`member_id` INTEGER COMMENT '会員ID',
	`reserve_id` BIGINT COMMENT '使ってはいけない! 旧システムからのデータ移行のとき、店舗ごとの予約IDを保持する 新システムでは参照しない',
	`receive_id` BIGINT COMMENT '予約ID (epark_receive.receive.id)',
	`owner_shop_id` BIGINT COMMENT 'オーナー店舗ID',
	`shop_id` BIGINT COMMENT '店舗ID',
	`reserve_status` TINYINT COMMENT '予約ステータス 予約:0 キャンセル:1 未来店:2 不明:3 削除:9',
	`reserve_type` TINYINT COMMENT '予約形態 順番待ち:0 予約:1',
	`is_send` TINYINT COMMENT 'お知らせメールの送信状況 未送信:0 送信済み:1',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	PRIMARY KEY (`id`),
	KEY `index_receive_id`(`receive_id`),
	KEY `index_created_at`(`created_at`)
) COMMENT='店舗会員別予約テーブル ※不要疑惑のテーブル 旧システムでの全期間全店舗のReceiveが入っていたテーブル 現行のシステムでは、ReceiveHistory(当日分も必要なときはReceiveも)で代用可 一部のタスクではすでにReceiveHistoryを使って集計をしています 旧システムでは店舗ごとでReceiveテーブルが分かれていて、 全店舗を通しての集計が困難だったためこのテーブルが集計に使用されていた テーブル名にMemberとついているが意味はなく、タッチパネルからの予約など、全予約データが入っている';

#-----------------------------------------------------------------------------
#-- line_holiday
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `line_holiday`;


CREATE TABLE `line_holiday`
(
	`id` BIGINT  NOT NULL AUTO_INCREMENT,
	`shop_id` BIGINT,
	`shop_reserve_department_id` BIGINT,
	`is_department_kbn` TINYINT default 0 COMMENT '部門管理導入区分 0:旧カテゴリー 1:部門管理導入',
	`service_time` INTEGER,
	`service_time_extra` INTEGER COMMENT 'N組以上の平均サービス時間',
	`wait_default` INTEGER,
	`wait_default_extra` INTEGER COMMENT 'N組以上の平均到達組数',
	`wait_lock` TINYINT,
	`wait_0` DECIMAL(4,1),
	`wait_1` DECIMAL(4,1),
	`wait_2` DECIMAL(4,1),
	`wait_3` DECIMAL(4,1),
	`wait_4` DECIMAL(4,1),
	`wait_5` DECIMAL(4,1),
	`wait_6` DECIMAL(4,1),
	`wait_7` DECIMAL(4,1),
	`wait_8` DECIMAL(4,1),
	`wait_9` DECIMAL(4,1),
	`wait_10` DECIMAL(4,1),
	`wait_11` DECIMAL(4,1),
	`wait_12` DECIMAL(4,1),
	`wait_13` DECIMAL(4,1),
	`wait_14` DECIMAL(4,1),
	`wait_15` DECIMAL(4,1),
	`wait_16` DECIMAL(4,1),
	`wait_17` DECIMAL(4,1),
	`wait_18` DECIMAL(4,1),
	`wait_19` DECIMAL(4,1),
	`wait_20` DECIMAL(4,1),
	`wait_21` DECIMAL(4,1),
	`wait_22` DECIMAL(4,1),
	`wait_23` DECIMAL(4,1),
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	UNIQUE KEY `shop_department_uniq` (`shop_id`, `shop_reserve_department_id`),
	KEY `index_shop_id`(`shop_id`),
	KEY `index_shop_reserve_department_id`(`shop_reserve_department_id`),
	KEY `index_is_department_kbn`(`is_department_kbn`)
);

#-----------------------------------------------------------------------------
#-- line_holiday_2
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `line_holiday_2`;


CREATE TABLE `line_holiday_2`
(
	`id` BIGINT  NOT NULL AUTO_INCREMENT,
	`shop_id` BIGINT,
	`shop_reserve_department_id` BIGINT,
	`is_department_kbn` TINYINT default 0 COMMENT '部門管理導入区分 0:旧カテゴリー 1:部門管理導入',
	`service_time` INTEGER,
	`service_time_extra` INTEGER COMMENT 'N組以上の平均サービス時間',
	`wait_default` INTEGER,
	`wait_default_extra` INTEGER COMMENT 'N組以上の平均到達組数',
	`wait_lock` TINYINT,
	`wait_0` DECIMAL(4,1),
	`wait_1` DECIMAL(4,1),
	`wait_2` DECIMAL(4,1),
	`wait_3` DECIMAL(4,1),
	`wait_4` DECIMAL(4,1),
	`wait_5` DECIMAL(4,1),
	`wait_6` DECIMAL(4,1),
	`wait_7` DECIMAL(4,1),
	`wait_8` DECIMAL(4,1),
	`wait_9` DECIMAL(4,1),
	`wait_10` DECIMAL(4,1),
	`wait_11` DECIMAL(4,1),
	`wait_12` DECIMAL(4,1),
	`wait_13` DECIMAL(4,1),
	`wait_14` DECIMAL(4,1),
	`wait_15` DECIMAL(4,1),
	`wait_16` DECIMAL(4,1),
	`wait_17` DECIMAL(4,1),
	`wait_18` DECIMAL(4,1),
	`wait_19` DECIMAL(4,1),
	`wait_20` DECIMAL(4,1),
	`wait_21` DECIMAL(4,1),
	`wait_22` DECIMAL(4,1),
	`wait_23` DECIMAL(4,1),
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	UNIQUE KEY `shop_department_uniq` (`shop_id`, `shop_reserve_department_id`),
	KEY `index_shop_id`(`shop_id`),
	KEY `index_shop_reserve_department_id`(`shop_reserve_department_id`),
	KEY `index_is_department_kbn`(`is_department_kbn`)
);

#-----------------------------------------------------------------------------
#-- line_weekday
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `line_weekday`;


CREATE TABLE `line_weekday`
(
	`id` BIGINT  NOT NULL AUTO_INCREMENT,
	`shop_id` BIGINT,
	`shop_reserve_department_id` BIGINT,
	`is_department_kbn` TINYINT default 0 COMMENT '部門管理導入区分 0:旧カテゴリー 1:部門管理導入',
	`service_time` INTEGER,
	`service_time_extra` INTEGER COMMENT 'N組以上の平均サービス時間',
	`wait_default` INTEGER,
	`wait_default_extra` INTEGER COMMENT 'N組以上の平均到達組数',
	`wait_lock` TINYINT,
	`wait_0` DECIMAL(4,1),
	`wait_1` DECIMAL(4,1),
	`wait_2` DECIMAL(4,1),
	`wait_3` DECIMAL(4,1),
	`wait_4` DECIMAL(4,1),
	`wait_5` DECIMAL(4,1),
	`wait_6` DECIMAL(4,1),
	`wait_7` DECIMAL(4,1),
	`wait_8` DECIMAL(4,1),
	`wait_9` DECIMAL(4,1),
	`wait_10` DECIMAL(4,1),
	`wait_11` DECIMAL(4,1),
	`wait_12` DECIMAL(4,1),
	`wait_13` DECIMAL(4,1),
	`wait_14` DECIMAL(4,1),
	`wait_15` DECIMAL(4,1),
	`wait_16` DECIMAL(4,1),
	`wait_17` DECIMAL(4,1),
	`wait_18` DECIMAL(4,1),
	`wait_19` DECIMAL(4,1),
	`wait_20` DECIMAL(4,1),
	`wait_21` DECIMAL(4,1),
	`wait_22` DECIMAL(4,1),
	`wait_23` DECIMAL(4,1),
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	UNIQUE KEY `shop_department_uniq` (`shop_id`, `shop_reserve_department_id`),
	KEY `index_shop_id`(`shop_id`),
	KEY `index_shop_reserve_department_id`(`shop_reserve_department_id`),
	KEY `index_is_department_kbn`(`is_department_kbn`)
);

#-----------------------------------------------------------------------------
#-- line_weekday_2
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `line_weekday_2`;


CREATE TABLE `line_weekday_2`
(
	`id` BIGINT  NOT NULL AUTO_INCREMENT,
	`shop_id` BIGINT,
	`shop_reserve_department_id` BIGINT,
	`is_department_kbn` TINYINT default 0 COMMENT '部門管理導入区分 0:旧カテゴリー 1:部門管理導入',
	`service_time` INTEGER,
	`service_time_extra` INTEGER COMMENT 'N組以上の平均サービス時間',
	`wait_default` INTEGER,
	`wait_default_extra` INTEGER COMMENT 'N組以上の平均到達組数',
	`wait_lock` TINYINT,
	`wait_0` DECIMAL(4,1),
	`wait_1` DECIMAL(4,1),
	`wait_2` DECIMAL(4,1),
	`wait_3` DECIMAL(4,1),
	`wait_4` DECIMAL(4,1),
	`wait_5` DECIMAL(4,1),
	`wait_6` DECIMAL(4,1),
	`wait_7` DECIMAL(4,1),
	`wait_8` DECIMAL(4,1),
	`wait_9` DECIMAL(4,1),
	`wait_10` DECIMAL(4,1),
	`wait_11` DECIMAL(4,1),
	`wait_12` DECIMAL(4,1),
	`wait_13` DECIMAL(4,1),
	`wait_14` DECIMAL(4,1),
	`wait_15` DECIMAL(4,1),
	`wait_16` DECIMAL(4,1),
	`wait_17` DECIMAL(4,1),
	`wait_18` DECIMAL(4,1),
	`wait_19` DECIMAL(4,1),
	`wait_20` DECIMAL(4,1),
	`wait_21` DECIMAL(4,1),
	`wait_22` DECIMAL(4,1),
	`wait_23` DECIMAL(4,1),
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	UNIQUE KEY `shop_department_uniq` (`shop_id`, `shop_reserve_department_id`),
	KEY `index_shop_id`(`shop_id`),
	KEY `index_shop_reserve_department_id`(`shop_reserve_department_id`),
	KEY `index_is_department_kbn`(`is_department_kbn`)
);

#-----------------------------------------------------------------------------
#-- line_auto_holiday
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `line_auto_holiday`;


CREATE TABLE `line_auto_holiday`
(
	`id` BIGINT  NOT NULL AUTO_INCREMENT,
	`shop_id` BIGINT,
	`shop_reserve_department_id` BIGINT,
	`is_department_kbn` TINYINT default 0 COMMENT '部門管理導入区分 0:旧カテゴリー 1:部門管理導入',
	`wait_0` DECIMAL(4,1),
	`wait_1` DECIMAL(4,1),
	`wait_2` DECIMAL(4,1),
	`wait_3` DECIMAL(4,1),
	`wait_4` DECIMAL(4,1),
	`wait_5` DECIMAL(4,1),
	`wait_6` DECIMAL(4,1),
	`wait_7` DECIMAL(4,1),
	`wait_8` DECIMAL(4,1),
	`wait_9` DECIMAL(4,1),
	`wait_10` DECIMAL(4,1),
	`wait_11` DECIMAL(4,1),
	`wait_12` DECIMAL(4,1),
	`wait_13` DECIMAL(4,1),
	`wait_14` DECIMAL(4,1),
	`wait_15` DECIMAL(4,1),
	`wait_16` DECIMAL(4,1),
	`wait_17` DECIMAL(4,1),
	`wait_18` DECIMAL(4,1),
	`wait_19` DECIMAL(4,1),
	`wait_20` DECIMAL(4,1),
	`wait_21` DECIMAL(4,1),
	`wait_22` DECIMAL(4,1),
	`wait_23` DECIMAL(4,1),
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	UNIQUE KEY `shop_department_uniq` (`shop_id`, `shop_reserve_department_id`),
	KEY `index_shop_id`(`shop_id`),
	KEY `index_shop_reserve_department_id`(`shop_reserve_department_id`)
);

#-----------------------------------------------------------------------------
#-- line_auto_holiday_2
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `line_auto_holiday_2`;


CREATE TABLE `line_auto_holiday_2`
(
	`id` BIGINT  NOT NULL AUTO_INCREMENT,
	`shop_id` BIGINT,
	`shop_reserve_department_id` BIGINT,
	`is_department_kbn` TINYINT default 0 COMMENT '部門管理導入区分 0:旧カテゴリー 1:部門管理導入',
	`wait_0` DECIMAL(4,1),
	`wait_1` DECIMAL(4,1),
	`wait_2` DECIMAL(4,1),
	`wait_3` DECIMAL(4,1),
	`wait_4` DECIMAL(4,1),
	`wait_5` DECIMAL(4,1),
	`wait_6` DECIMAL(4,1),
	`wait_7` DECIMAL(4,1),
	`wait_8` DECIMAL(4,1),
	`wait_9` DECIMAL(4,1),
	`wait_10` DECIMAL(4,1),
	`wait_11` DECIMAL(4,1),
	`wait_12` DECIMAL(4,1),
	`wait_13` DECIMAL(4,1),
	`wait_14` DECIMAL(4,1),
	`wait_15` DECIMAL(4,1),
	`wait_16` DECIMAL(4,1),
	`wait_17` DECIMAL(4,1),
	`wait_18` DECIMAL(4,1),
	`wait_19` DECIMAL(4,1),
	`wait_20` DECIMAL(4,1),
	`wait_21` DECIMAL(4,1),
	`wait_22` DECIMAL(4,1),
	`wait_23` DECIMAL(4,1),
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	UNIQUE KEY `shop_department_uniq` (`shop_id`, `shop_reserve_department_id`),
	KEY `index_shop_id`(`shop_id`),
	KEY `index_shop_reserve_department_id`(`shop_reserve_department_id`)
);

#-----------------------------------------------------------------------------
#-- line_auto_weekday
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `line_auto_weekday`;


CREATE TABLE `line_auto_weekday`
(
	`id` BIGINT  NOT NULL AUTO_INCREMENT,
	`shop_id` BIGINT,
	`shop_reserve_department_id` BIGINT,
	`is_department_kbn` TINYINT default 0 COMMENT '部門管理導入区分 0:旧カテゴリー 1:部門管理導入',
	`wait_0` DECIMAL(4,1),
	`wait_1` DECIMAL(4,1),
	`wait_2` DECIMAL(4,1),
	`wait_3` DECIMAL(4,1),
	`wait_4` DECIMAL(4,1),
	`wait_5` DECIMAL(4,1),
	`wait_6` DECIMAL(4,1),
	`wait_7` DECIMAL(4,1),
	`wait_8` DECIMAL(4,1),
	`wait_9` DECIMAL(4,1),
	`wait_10` DECIMAL(4,1),
	`wait_11` DECIMAL(4,1),
	`wait_12` DECIMAL(4,1),
	`wait_13` DECIMAL(4,1),
	`wait_14` DECIMAL(4,1),
	`wait_15` DECIMAL(4,1),
	`wait_16` DECIMAL(4,1),
	`wait_17` DECIMAL(4,1),
	`wait_18` DECIMAL(4,1),
	`wait_19` DECIMAL(4,1),
	`wait_20` DECIMAL(4,1),
	`wait_21` DECIMAL(4,1),
	`wait_22` DECIMAL(4,1),
	`wait_23` DECIMAL(4,1),
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	UNIQUE KEY `shop_department_uniq` (`shop_id`, `shop_reserve_department_id`),
	KEY `index_shop_id`(`shop_id`),
	KEY `index_shop_reserve_department_id`(`shop_reserve_department_id`)
);

#-----------------------------------------------------------------------------
#-- line_auto_weekday_2
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `line_auto_weekday_2`;


CREATE TABLE `line_auto_weekday_2`
(
	`id` BIGINT  NOT NULL AUTO_INCREMENT,
	`shop_id` BIGINT,
	`shop_reserve_department_id` BIGINT,
	`is_department_kbn` TINYINT default 0 COMMENT '部門管理導入区分 0:旧カテゴリー 1:部門管理導入',
	`wait_0` DECIMAL(4,1),
	`wait_1` DECIMAL(4,1),
	`wait_2` DECIMAL(4,1),
	`wait_3` DECIMAL(4,1),
	`wait_4` DECIMAL(4,1),
	`wait_5` DECIMAL(4,1),
	`wait_6` DECIMAL(4,1),
	`wait_7` DECIMAL(4,1),
	`wait_8` DECIMAL(4,1),
	`wait_9` DECIMAL(4,1),
	`wait_10` DECIMAL(4,1),
	`wait_11` DECIMAL(4,1),
	`wait_12` DECIMAL(4,1),
	`wait_13` DECIMAL(4,1),
	`wait_14` DECIMAL(4,1),
	`wait_15` DECIMAL(4,1),
	`wait_16` DECIMAL(4,1),
	`wait_17` DECIMAL(4,1),
	`wait_18` DECIMAL(4,1),
	`wait_19` DECIMAL(4,1),
	`wait_20` DECIMAL(4,1),
	`wait_21` DECIMAL(4,1),
	`wait_22` DECIMAL(4,1),
	`wait_23` DECIMAL(4,1),
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	UNIQUE KEY `shop_department_uniq` (`shop_id`, `shop_reserve_department_id`),
	KEY `index_shop_id`(`shop_id`),
	KEY `index_shop_reserve_department_id`(`shop_reserve_department_id`)
);

#-----------------------------------------------------------------------------
#-- add_reserve_time
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `add_reserve_time`;


CREATE TABLE `add_reserve_time`
(
	`id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT 'ID',
	`shop_id` BIGINT COMMENT '店舗ID',
	`shop_reserve_department_id` BIGINT COMMENT '部門ID',
	`add_data` DATETIME COMMENT '追加した臨時の時間枠の日時',
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	UNIQUE KEY `shop_department_uniq` (`shop_id`, `shop_reserve_department_id`),
	KEY `index_shop_id`(`shop_id`),
	KEY `index_shop_reserve_department_id`(`shop_reserve_department_id`)
) COMMENT='追加した予約時間枠を格納する（時間指定予約） 『EPARKマニュアル パソコン版・店舗管理画面(時間指定予約用)』の5.G(13ページ)「空き時間枠追加」にて説明されている機能のためのデータ。 以下のようなケースで使用（マニュアルより抜粋）:   『通常、時間指定予約はあらかじめ店舗側で設定した１時間あたりの時間枠でしか予約ができません。   しかし「１２時」に予約されたお客様が実際の時間で「１１ 時４５分」にご案内する事できた場合。   「１２時」という時間枠に空きができますが「１２時」という時間枠に新たに予約を入れる事はシステム上できません。   そこで「１２時１分」という空き時間枠を新たに設定する事で「１２時」で予約できるようにする事が可能になります。』';

#-----------------------------------------------------------------------------
#-- future_calender
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `future_calender`;


CREATE TABLE `future_calender`
(
	`id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT 'ID',
	`shop_id` BIGINT COMMENT '店舗ID',
	`shop_reserve_department_id` BIGINT COMMENT '部門ID',
	`pattern` INTEGER COMMENT '例外パターン 4:個別1 5:個別2 6:個別3 7:個別4 8:個別5 9~: その他',
	`date` DATETIME COMMENT '日付',
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	KEY `index_shop_id`(`shop_id`),
	KEY `index_shop_reserve_department_id`(`shop_reserve_department_id`)
) COMMENT='以下にある4つのFUTURE_*テーブル(FUTURE_HOLIDAY,FUTURE_HOLIDAY_2,FUTURE_WEEKDAY,FUTURE_WEEKDAY_2)を正規化して1テーブルにまとめ、 また、「個別」の設定を柔軟に行えるようにしたもの。FUTURE_*テーブルをリプレースする目的で新しく作られたと思われる。 平日(翌日平日)、平日(翌日土日祝)、土日祝(翌日平日)、土日祝(翌日土日祝)、個別1、個別2、個別3、個別4、個別5(、その他:未調査)という項目ごとに設定。';

#-----------------------------------------------------------------------------
#-- future_capa
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `future_capa`;


CREATE TABLE `future_capa`
(
	`id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT 'ID',
	`shop_id` BIGINT COMMENT '店舗ID',
	`is_department_kbn` TINYINT default 0 COMMENT '部門管理導入区分 0:旧カテゴリー 1:部門管理導入',
	`shop_reserve_department_id` BIGINT COMMENT '部門ID',
	`pattern` INTEGER COMMENT 'スケジュールのパターン WeekType などとも呼ばれているらしい 指定日と、指定日の翌日の状態（平日・休日）の組み合わせによって数値が決まるらしい 指定日  指定日の翌日 0:平日  →  平日 1:平日  →  休日 2:休日  →  平日 3:休日  →  休日',
	`mobile_ratio` INTEGER default 100 COMMENT 'モバイル受付率',
	`capa_default` INTEGER COMMENT '将来順番受付最大数デフォルト値',
	`section_num` INTEGER default 4 COMMENT '1時間当たりの予約枠数',
	`capa_0` INTEGER COMMENT '0時台の将来順番受付最大数',
	`capa_1` INTEGER COMMENT '1時台の将来順番受付最大数',
	`capa_2` INTEGER COMMENT '2時台の将来順番受付最大数',
	`capa_3` INTEGER COMMENT '3時台の将来順番受付最大数',
	`capa_4` INTEGER COMMENT '4時台の将来順番受付最大数',
	`capa_5` INTEGER COMMENT '5時台の将来順番受付最大数',
	`capa_6` INTEGER COMMENT '6時台の将来順番受付最大数',
	`capa_7` INTEGER COMMENT '7時台の将来順番受付最大数',
	`capa_8` INTEGER COMMENT '8時台の将来順番受付最大数',
	`capa_9` INTEGER COMMENT '9時台の将来順番受付最大数',
	`capa_10` INTEGER COMMENT '10時台の将来順番受付最大数',
	`capa_11` INTEGER COMMENT '11時台の将来順番受付最大数',
	`capa_12` INTEGER COMMENT '12時台の将来順番受付最大数',
	`capa_13` INTEGER COMMENT '13時台の将来順番受付最大数',
	`capa_14` INTEGER COMMENT '14時台の将来順番受付最大数',
	`capa_15` INTEGER COMMENT '15時台の将来順番受付最大数',
	`capa_16` INTEGER COMMENT '16時台の将来順番受付最大数',
	`capa_17` INTEGER COMMENT '17時台の将来順番受付最大数',
	`capa_18` INTEGER COMMENT '18時台の将来順番受付最大数',
	`capa_19` INTEGER COMMENT '19時台の将来順番受付最大数',
	`capa_20` INTEGER COMMENT '20時台の将来順番受付最大数',
	`capa_21` INTEGER COMMENT '21時台の将来順番受付最大数',
	`capa_22` INTEGER COMMENT '22時台の将来順番受付最大数',
	`capa_23` INTEGER COMMENT '23時台の将来順番受付最大数',
	`capa_zero_disable_flg` TINYINT default 0 NOT NULL COMMENT '0時台の将来順番受付状況 0:受付可、1:受付不可',
	`capa_1_disable_flg` TINYINT default 0 NOT NULL COMMENT '1時台の将来順番受付状況 0:受付可、1:受付不可',
	`capa_2_disable_flg` TINYINT default 0 NOT NULL COMMENT '2時台の将来順番受付状況 0:受付可、1:受付不可',
	`capa_3_disable_flg` TINYINT default 0 NOT NULL COMMENT '3時台の将来順番受付状況 0:受付可、1:受付不可',
	`capa_4_disable_flg` TINYINT default 0 NOT NULL COMMENT '4時台の将来順番受付状況 0:受付可、1:受付不可',
	`capa_5_disable_flg` TINYINT default 0 NOT NULL COMMENT '5時台の将来順番受付状況 0:受付可、1:受付不可',
	`capa_6_disable_flg` TINYINT default 0 NOT NULL COMMENT '6時台の将来順番受付状況 0:受付可、1:受付不可',
	`capa_7_disable_flg` TINYINT default 0 NOT NULL COMMENT '7時台の将来順番受付状況 0:受付可、1:受付不可',
	`capa_8_disable_flg` TINYINT default 0 NOT NULL COMMENT '8時台の将来順番受付状況 0:受付可、1:受付不可',
	`capa_9_disable_flg` TINYINT default 0 NOT NULL COMMENT '9時台の将来順番受付状況 0:受付可、1:受付不可',
	`capa_10_disable_flg` TINYINT default 0 NOT NULL COMMENT '10時台の将来順番受付状況 0:受付可、1:受付不可',
	`capa_11_disable_flg` TINYINT default 0 NOT NULL COMMENT '11時台の将来順番受付状況 0:受付可、1:受付不可',
	`capa_12_disable_flg` TINYINT default 0 NOT NULL COMMENT '12時台の将来順番受付状況 0:受付可、1:受付不可',
	`capa_13_disable_flg` TINYINT default 0 NOT NULL COMMENT '13時台の将来順番受付状況 0:受付可、1:受付不可',
	`capa_14_disable_flg` TINYINT default 0 NOT NULL COMMENT '14時台の将来順番受付状況 0:受付可、1:受付不可',
	`capa_15_disable_flg` TINYINT default 0 NOT NULL COMMENT '15時台の将来順番受付状況 0:受付可、1:受付不可',
	`capa_16_disable_flg` TINYINT default 0 NOT NULL COMMENT '16時台の将来順番受付状況 0:受付可、1:受付不可',
	`capa_17_disable_flg` TINYINT default 0 NOT NULL COMMENT '17時台の将来順番受付状況 0:受付可、1:受付不可',
	`capa_18_disable_flg` TINYINT default 0 NOT NULL COMMENT '18時台の将来順番受付状況 0:受付可、1:受付不可',
	`capa_19_disable_flg` TINYINT default 0 NOT NULL COMMENT '19時台の将来順番受付状況 0:受付可、1:受付不可',
	`capa_20_disable_flg` TINYINT default 0 NOT NULL COMMENT '20時台の将来順番受付状況 0:受付可、1:受付不可',
	`capa_21_disable_flg` TINYINT default 0 NOT NULL COMMENT '21時台の将来順番受付状況 0:受付可、1:受付不可',
	`capa_22_disable_flg` TINYINT default 0 NOT NULL COMMENT '22時台の将来順番受付状況 0:受付可、1:受付不可',
	`capa_23_disable_flg` TINYINT default 0 NOT NULL COMMENT '23時台の将来順番受付状況 0:受付可、1:受付不可',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	UNIQUE KEY `shop_department_uniq` (`shop_id`, `shop_reserve_department_id`, `pattern`),
	KEY `index_shop_reserve_department_id`(`shop_reserve_department_id`),
	KEY `index_pattern`(`shop_id`, `pattern`)
) COMMENT='将来順番受付の時間別予約キャパシティの設定。 以下にある4つのFUTURE_*テーブル(FUTURE_HOLIDAY,FUTURE_HOLIDAY_2,FUTURE_WEEKDAY,FUTURE_WEEKDAY_2)を正規化して1テーブルにまとめ、 また、「個別」の設定を柔軟に行えるようにしたもの。FUTURE_*テーブルをリプレースする目的で新しく作られたと思われる。 平日(翌日平日)、平日(翌日土日祝)、土日祝(翌日平日)、土日祝(翌日土日祝)、個別1、個別2、個別3、個別4、個別5(、その他:未調査)という項目ごとに設定。';

#-----------------------------------------------------------------------------
#-- shop_reserve_config
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `shop_reserve_config`;


CREATE TABLE `shop_reserve_config`
(
	`id` BIGINT  NOT NULL AUTO_INCREMENT,
	`shop_id` BIGINT  NOT NULL COMMENT '店舗ＩＤ',
	`shop_mobile_status` TINYINT COMMENT '順番待ち：携帯サイト受付 0:受付 1:停止 ',
	`mobile_msg` VARCHAR(255) COMMENT '順番待ち：受付停止中メッセージの手動設定内容',
	`mobile_msg_status` TINYINT default 1 COMMENT '順番待ち：受付停止中メッセージ 0:手動設定 1:定型文表示',
	`telop_msg` VARCHAR(255) COMMENT 'タッチパネル（店舗受付用）テロップメッセージ',
	`telop_msg_status` TINYINT COMMENT 'テロップ表示ステータス 0:表示 1:非表示 スプレッドシートではここだけ論理が逆になっていたけど周りと同じ',
	`issue_msg` VARCHAR(255) COMMENT '発券メッセージ',
	`issue_msg_status` TINYINT COMMENT '0:編集（発券メッセージ必須） 1:発券メッセージ空白ＯＫ',
	`wait_time_max` SMALLINT COMMENT '順番待ち：待ち時間表示上限',
	`wait_late_time` SMALLINT COMMENT '順番待ち：「呼出」猶予時間(分) 予約データが不在になった後、この時間(分)経過すると無断キャンセルになる',
	`seat` INTEGER COMMENT '席数',
	`news_setup_display` TINYINT default 0 COMMENT '携帯予約確認画面で設定を表示する制御 0:表示しない 1:表示する',
	`mail_status` TINYINT default 1 COMMENT '順番待ち：直前お知らせメール 0:配信する 1:配信しない',
	`mail_order` TINYINT default 2 COMMENT '順番待ち：直前お知らせメールを送る予約・順番待ちの範囲 この順番までの予約・順番待ちのメンバーにメールを送る',
	`mail_order2` TINYINT default 0 COMMENT '順番待ち：直前お知らせメール2を送る予約・順番待ちの範囲',
	`mail_order3` TINYINT default 0 COMMENT '順番待ち：直前お知らせメール3を送る予約・順番待ちの範囲',
	`send_mail_limit_extension_status` TINYINT default 0 NOT NULL COMMENT 'メール配信上限数拡張ステータス 0:通常 2件/日 1:拡張 5件/日',
	`qr_mail_order` TINYINT default 0 COMMENT '「QRコール：QRコールを送る予約・順番待ちの範囲」この順番までの予約・順番待ちのQR登録者にメールを送る 「順番待ち：直前お知らせメール」が有効になっていない場合は使えません 0:手動送信',
	`qr_mail_order2` TINYINT default 0 COMMENT '「QRコール：直前お知らせメール2の範囲」QRコールを送る予約・順番待ちの範囲　0:手動送信',
	`qr_mail_order3` TINYINT default 0 COMMENT '「QRコール：直前お知らせメール3の範囲」QRコールを送る予約・順番待ちの範囲　0:手動送信',
	`mail_status2` TINYINT default 1 COMMENT '順番待ち：作業完了メール 0:配信する 1:配信しない',
	`auto_tel_call_status` TINYINT default 1 NOT NULL COMMENT '自動電話呼出設定 0:自動呼出を行う 1:自動呼出をしない',
	`auto_tel_call_order` TINYINT default 0 NOT NULL COMMENT '自動電話呼出組数 この順番までの予約・順番待ちの電話呼出対象に電話呼出を行う。',
	`mobile_wait_view_status` TINYINT default 0 COMMENT '順番待ち時間・件数表示切替（携帯／スマホ／PC共通項目） 0:全表示 1:件数のみ表示 2:時間のみ表示 9:非表示',
	`mobile_wait_display` TINYINT default 1 COMMENT '停止中待ち情報表示切替 0:表示 1:非表示',
	`mobile_status` TINYINT COMMENT '将来順番受付・時間指定：携帯サイト受付 0:受付 1:停止',
	`stop_msg` TEXT COMMENT '将来順番受付・時間指定：受付停止中メッセージの手動設定内容',
	`stop_msg_status` TINYINT default 1 COMMENT '将来順番受付・時間指定：受付停止中メッセージ 0:手動設定 1:定型文表示',
	`enable_time` SMALLINT COMMENT '受付対応可能時間 携帯サイトから予約の受付を何分後から受付けるかの設定 (外部からお店までの移動時間を計算に入れてください)',
	`enable_term` SMALLINT COMMENT '受付対応可能期間 何日後の予約を受付けるかの設定です 今日から何日後までの予約を時間指定予約、将来順番待ち予約できるかを設定',
	`enable_type` TINYINT default 1 NOT NULL COMMENT '席連動予約 受付対応可能期間(開始)の種別 1:分、2:日',
	`enable_from` SMALLINT COMMENT '席連動予約 受付対応可能期間(開始) 現在時間から設定日または分後以降の時間のみ予約可能',
	`enable_to` SMALLINT COMMENT '席連動予約 受付対応可能期間(終了) 現在日付から設定日後まで予約可能',
	`late_time` SMALLINT COMMENT '予約時間後の猶予時間（分単位） 予約した時刻を過ぎた場合の呼出猶予時間を設定します。',
	`enable_wait_time` SMALLINT default 6 COMMENT '※使用しない 待ち有効時間 この時間(Hour)を経過した不在・無断キャンセルは店舗側タッチパネルの不在・無断キャンセルの一覧に表示しない が、もう、これは使用しないとのこと',
	`touch_wait_time` TINYINT default 0 COMMENT 'タッチパネル待ち時間表示 0:表示 1:非表示',
	`touch_wait_count` TINYINT default 0 COMMENT 'タッチパネル待ち組数表示 0:表示 1:非表示',
	`coupon_button` TINYINT default 0 COMMENT 'タッチパネル（店頭受付用）：クーポンボタン表示 0:表示 1:非表示',
	`tablet_coupon_btn` TINYINT default 1 COMMENT 'タッチパネル（iPad,Tablet用）：クーポンボタン表示 0:表示 1:非表示',
	`category_button` TINYINT default 1 NOT NULL COMMENT 'タッチパネル（設定用）：カテゴリボタン表示 0:表示 1:非表示',
	`touch_wait_pair` TINYINT default 0 COMMENT 'タッチパネル待ち組表示 0:表示 1:非表示',
	`contact_mail_msg` VARCHAR(255) COMMENT '連絡ボタン押下時の送信メールメッセージ',
	`admin_touch_colum1` TINYINT default 0 COMMENT '管理用タッチパネル表示項目1 0:待ち時間 1:お呼び出し 2:受付時間 3:案内予定',
	`admin_touch_colum2` TINYINT default 1 COMMENT '管理用タッチパネル表示項目2 0:待ち時間 1:お呼び出し 2:受付時間 3:案内予定',
	`touch_detail_left_area_left_cd` TINYINT default 0 COMMENT 'タッチパネル設定 左パネル 左 0:待ち時間 1:お呼び出し 2:受付時間 3:案内予定',
	`touch_detail_left_area_right_cd` TINYINT default 0 COMMENT 'タッチパネル設定 左パネル 右 0:待ち時間 1:お呼び出し 2:受付時間 3:案内予定',
	`touch_detail_right_area_left_cd` TINYINT default 0 COMMENT 'タッチパネル設定 右パネル 左 0:非表示 0!=部門IDまたは予約カテゴリID',
	`touch_detail_right_area_center_cd` TINYINT default 0 COMMENT 'タッチパネル設定 右パネル 中央 0:非表示 0!=部門IDまたは予約カテゴリID',
	`touch_detail_right_area_right_cd` TINYINT default 0 COMMENT 'タッチパネル設定 右パネル 右 0:非表示 0!=部門IDまたは予約カテゴリID',
	`touch_second_stage_cd` TINYINT default 0 COMMENT 'タッチパネル設定 全体状況 2段1項目表示 0:非表示 0!=1;「待ち時間」以外',
	`touch_second_stage2_cd` TINYINT default 0 COMMENT 'タッチパネル設定 全体状況 2段2項目表示 0:非表示 0!=1;「待ち時間」以外',
	`touch_third_stage_cd` TINYINT default 0 COMMENT 'タッチパネル設定 全体状況 3段1項目表示 0:非表示 0!=1;「待ち時間」以外',
	`touch_third_stage2_cd` TINYINT default 0 COMMENT 'タッチパネル設定 全体状況 3段2項目表示 0:非表示 0!=1;「待ち時間」以外',
	`enable_shop_timeset_edit` TINYINT default 0 COMMENT '店舗管理画面の時間枠編集表示設定 0:非表示 1:表示',
	`wait_time_display_type` TINYINT default 1 NOT NULL COMMENT '待ち時間表示タイプ 1: 最大待ち時間 2: 最小待ち時間 ～ 最大待ち時間',
	`wait_time_min` INTEGER COMMENT '最小案内時間（分）',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	`registration_no_status` TINYINT default 0 NOT NULL COMMENT '診察券番号メッセージステータス 0:なし(デフォルト)  1:あり',
	`registration_no_msg` VARCHAR(255) COMMENT '診察券番号メッセージ',
	`wait_line_extra` SMALLINT default 0 NOT NULL COMMENT 'N組以上の待ち時間設定',
	`mail_header_ad` VARCHAR(255) COMMENT 'メール文頭AD',
	`continuous_reception_status` TINYINT default 0 NOT NULL COMMENT '連続受付可否設定  0:使用しない 1:使用する',
	`continuous_reception_caption` VARCHAR(50) COMMENT '連続受付ボタン名称',
	`continuous_reception_discription` VARCHAR(50) COMMENT '連続受付説明文',
	`guid_date_print_status` TINYINT COMMENT '待ち基準時間固定の場合の案内予定時間を受付票へ印字設定 0:しない 1:する。',
	`jikansitei_rsv_btn_status` TINYINT default 0 COMMENT '時間指定予約店舗のお客様側タッチパネル 翌日以降受付ボタン表示設定  0:無し 1:有り',
	`number_of_print` TINYINT default 1 NOT NULL COMMENT '受付票印刷枚数 初期値：1枚',
	`guide_button_label_status` TINYINT default 0 NOT NULL COMMENT '案内ボタン文言変更設定 0:デフォルト 1:編集',
	`guide_button_label` VARCHAR(10) default '案内' COMMENT '案内ボタン文言',
	`service_end_status_select` TINYINT default 1 NOT NULL COMMENT '接客完了時のステータス選択 0:有り 1:無し',
	`service_end_button_label_status` TINYINT default 0 NOT NULL COMMENT '接客完了時のステータス選択ボタン設定 0:デフォルト 1:編集',
	`service_end_red_button_label` VARCHAR(4) default '成約' COMMENT '接客完了時赤ボタン文言',
	`service_end_blue_button_label` VARCHAR(4) default '検討' COMMENT '接客完了時青ボタン文言',
	`service_end_green_button_label` VARCHAR(4) default '対応完了' COMMENT '接客完了時緑ボタン文言',
	`service_end_gray_button_label` VARCHAR(4) default '取消' COMMENT '接客完了時灰ボタン文言',
	`touch_serving_stage1_cd` TINYINT default 0 COMMENT '接客中一覧カスタム表示項目1 0:非表示 0以外:表示設定コード',
	`touch_serving_stage2_cd` TINYINT default 0 COMMENT '接客中一覧カスタム表示項目2 0:非表示 0以外:表示設定コード',
	`touch_serving_stage3_cd` TINYINT default 0 COMMENT '接客中一覧カスタム表示項目3 0:非表示 0以外:表示設定コード',
	`multiple_service_status` TINYINT default 1 COMMENT '担当者複数割当のステータス 0:有効 1:無効',
	`neighboring_guidance_status` TINYINT default 0 NOT NULL COMMENT '近隣店舗誘導 0:非表示 1:表示',
	`uketsuke_hakken_status` TINYINT default 0 NOT NULL COMMENT '受付発券 0:しない 1:する。',
	`cancel_frame_use` TINYINT default 1 NOT NULL COMMENT '将来順番予約：キャンセル枠復活機能 0:非表示 1:表示',
	`advance_frame_use` TINYINT default 0 NOT NULL COMMENT '将来順番予約：前倒し案内再予約機能 0:非表示 1:表示',
	`development_view_status` TINYINT default 0 NOT NULL COMMENT '経過時間表示/非表示切り替え 0:非表示 1:表示',
	`mobile_wait_display_status` TINYINT default 0 NOT NULL COMMENT '順番待ち受付停止中表示項目設定 0:待ち組数/待ち時間 1:待ち組数のみ 2:待ち時間のみ',
	`shift_closing_time_by_waiting_time` TINYINT default 0 COMMENT '待ち時間によって携帯予約受付の終了時間を早める 0:有効 1:無効',
	`reserve_regist_status` TINYINT default 0 NOT NULL COMMENT '事前予約登録ボタン表示 0:非表示 1:表示',
	`accepted_chime_call` TINYINT default 0 NOT NULL COMMENT '受付チャイム呼出 0: 使用しない 1: 使用する',
	`voice_guide_auth` TINYINT default 0 NOT NULL COMMENT '音声案内機能利用権限 0: 使用しない 1: 使用する',
	`voice_guide_type` TINYINT default 1 NOT NULL COMMENT '音声案内タイプ選択 1: 会員登録 2: 相互送客',
	`check_button_switching_stage` TINYINT default 1 NOT NULL COMMENT '確認ボタン背景色切り替え段階（default:1） 4段階まで',
	`cancel_button_use` TINYINT UNSIGNED default 1 NOT NULL COMMENT 'タッチパネル スタッフ画面へのキャンセルボタン利用権限 0:表示 1: 非表示',
	`serving_alert_flg` TINYINT default 0 NOT NULL COMMENT '接客中アラートフラグ 0:使用不可 1:使用可',
	`serving_chime_flg` TINYINT default 0 NOT NULL COMMENT '接客中チャイムフラグ 0:使用不可 1:使用可',
	`rcv_adjst_status` TINYINT default 0 NOT NULL COMMENT '予約調整枠設定区分 0:使用しない 1:使用する',
	`pl_rcv_wait_status` TINYINT default 0 NOT NULL COMMENT '滞留予約待ち時間設定区分 0:有効 1:無効',
	`tp_add_dtl_shw_type` TINYINT default 0 COMMENT 'タッチパネル（スタッフ画面）内の追加詳細情報の表示制御を行う区分 0:なし 10:マイカー情報',
	`mem_car_rgst_shw_flg` TINYINT default 0 COMMENT 'マイカー登録ボタンの表示制御を行うフラグ 0:非表示 1:表示',
	`mem_car_slct_shw_flg` TINYINT default 0 COMMENT '順番待ち、将来順番受付時、マイカー選択の表示制御を行うフラグ 0:非表示 1:表示',
	`shop_signage_status` TINYINT default 0 COMMENT '順番待ちサイネージ受付 0:使用不可 1:使用可',
	`new_arrivals_rsv_flg` TINYINT default 1 COMMENT '新着予約利用フラグ 0:使用しない 1:使用する',
	`disp_future_only_flg` TINYINT default 1 NOT NULL COMMENT '将来順番待ちのみ存在する場合の順番待ち受付表示フラグ 0:非表示 1:表示',
	`reserve_signage_sts` TINYINT default 0 COMMENT '時間指定サイネージ受付 0:使用不可 1:使用可',
	`cxl_wait_threshold` TINYINT UNSIGNED default 3 NOT NULL COMMENT 'CXL待ちでスキップ出来る最前組数',
	`auto_call_stop_flg` TINYINT(4) default 0 COMMENT '直前お知らせメール、自動電話呼出を、タッチパネルスタッフ画面側の設定で、停止させるフラグ 0：自動呼出有効 1：自動呼出停止',
	`future_btn_position_flg` TINYINT(4) UNSIGNED default 0 NOT NULL COMMENT 'タッチパネル：将来順番ボタンの位置変更切替0:既存のまま 1: 順番待ちボタンの隣',
	`absent_notice_msg` VARCHAR(255) COMMENT '不在通知、ファスパ表示内容',
	`absent_cancel_notice_msg` VARCHAR(255) COMMENT '不在無断キャンセル通知、ファスパ表示内容',
	`future_order_is_not_reserve_flg` TINYINT default 1 COMMENT '将来順番予約は予約ではない旨を表示フラグ 0:表示しない 1:表示する',
	`future_order_is_not_reserve_msg` TEXT COMMENT '将来順番予約は予約ではない旨のファスパ表示文',
	`auto_call_acs2_flg` TINYINT(4) default 0 COMMENT 'ACS2(席ステータス連携自動呼出システム)の利用権限 0：ACS2停止中 1：ACS2利用中',
	`cxl_guided_stock_number` TINYINT COMMENT 'CXL待ち：案内済み番号の最大ストック件数',
	`specified_waiting_time_json` VARCHAR(100) COMMENT '指定待ち時間表示の設定内容(JSON)',
	PRIMARY KEY (`id`),
	UNIQUE KEY `uq_shop_reserve_config` (`shop_id`),
	KEY `index_shop_id`(`shop_id`)
);

#-----------------------------------------------------------------------------
#-- correct_wait_time
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `correct_wait_time`;


CREATE TABLE `correct_wait_time`
(
	`id` BIGINT  NOT NULL AUTO_INCREMENT,
	`shop_id` BIGINT,
	`shop_reserve_department_id` BIGINT COMMENT '部門ID',
	`is_department_kbn` TINYINT default 0 COMMENT '部門管理導入区分 0:旧カテゴリー 1:部門管理導入',
	`correct1` SMALLINT default 0 COMMENT '待ち時間変更(補正) 1組目(分)',
	`correct2` SMALLINT default 0 COMMENT '待ち時間変更(補正) 2組目以降(分)',
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	UNIQUE KEY `shop_department_uniq` (`shop_id`, `shop_reserve_department_id`),
	KEY `index_shop_id`(`shop_id`),
	KEY `index_shop_reserve_department_id`(`shop_reserve_department_id`)
) COMMENT='待ち時間補正';

#-----------------------------------------------------------------------------
#-- shop_reserve_conventional_category
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `shop_reserve_conventional_category`;


CREATE TABLE `shop_reserve_conventional_category`
(
	`id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT '予約カテゴリＩＤ',
	`shop_id` BIGINT COMMENT '店舗ＩＤ',
	`display_order` TINYINT COMMENT '表示順',
	`name` VARCHAR(100) COMMENT '名称',
	`description` VARCHAR(100) COMMENT '説明',
	`attention` VARCHAR(100) COMMENT '項目注意書き',
	`type` TINYINT default 0 COMMENT '入力タイプ 0:テキスト 1:数値 2:選択肢',
	`attribute` TINYINT default 0 COMMENT '属性 0：無し 1:人数 2:名前 3:電話番号 4:診察券番号 5:メールアドレス',
	`reserve` TINYINT default 0 COMMENT '(携帯用フラグ)順番待ち 0:使用する １：使用しない member_mobileの順番待ちのみの予約でこのカテゴリを使用するかしないか',
	`booking` TINYINT default 0 COMMENT '(携帯用フラグ)時間指定予約・将来順番受付 0:使用する １：使用しない member_mobile,shop_pcの時間指定・将来順番受付のみで使用するかしないか',
	`touchpanel` TINYINT default 0 COMMENT 'タッチパネル(予約登録)で使用 0:使用する １：使用しない shop_touchの店頭受付画面・店舗案内画面の 順番待ち予約・将来順番受付・時間指定予約で使用するかしないか、 shop_touch予約登録全般での使用の可否 reserve_status に影響されない',
	`touchpanel_reception` TINYINT default 0 NOT NULL COMMENT 'タッチパネル受付画面で使用 0:使用する 1:使用しない',
	`touchpanel_staff` TINYINT default 0 NOT NULL COMMENT 'タッチパネルスタッフ画面で使用 0:使用する 1:使用しない',
	`touchpanel_reserve` TINYINT default 0 NOT NULL COMMENT 'タッチパネル予約登録で使用 0:使用する 1:使用しない',
	`touchpanel_staff_category_display_status` TINYINT default 0 NOT NULL COMMENT 'スタッフ画面のカテゴリ設定ページでの予約カテゴリボタン表示 0:使用する 1:使用しない',
	`disp_panel` TINYINT default 0 COMMENT 'タッチパネル(店頭画面)に表示 0:使用する １：使用しない shop_touchの店頭受付画面(トップページ)にカテゴリを表示するかしないか。 カテゴリーの入力する・しないには影響しない トップページの予約一覧にこのカテゴリーを表示させるかどうかのみの設定',
	`staff_disp_panel_flg` TINYINT default 0 COMMENT 'スタッフタッチパネルフラグ',
	`continuous_reception` TINYINT default 1 NOT NULL COMMENT '連続受付で使用 0:使用する　１：使用しない',
	`touchpanel_staff_immediate_guide` TINYINT default 1 NOT NULL COMMENT '即時案内使用可否 使用する：0  使用しない：1',
	`text_type` TINYINT default 0 COMMENT 'テキスト入力タイプ 0:全角かな 1:半角英数 2:半角数値 3:半角英数記号(メールアドレス)',
	`text_max` SMALLINT COMMENT '文字列最大文字数',
	`text_min` SMALLINT COMMENT '文字列最小文字数',
	`num_max` INTEGER COMMENT '最大数値',
	`num_min` INTEGER COMMENT '最小数値',
	`parent_id` BIGINT COMMENT '上位カテゴリ番号',
	`use_condition_category_id` BIGINT COMMENT '使用条件カテゴリID',
	`use_condition_category_option_ids` VARCHAR(100) COMMENT '仕様条件カテゴリオプションID（カンマ区切り）。use_condition_category_id がある場合、ここで指定したIDのオプションが選択されている場合にのみ表示される。',
	`show_attention_flg` TINYINT default 0 COMMENT '注釈文ポップアップ表示フラグ',
	`status` TINYINT default 0 COMMENT '承認 ０：有効　１：無効',
	`admin_status` TINYINT default 0 COMMENT '（管理画面設定）承認 ０：有効　１：無効',
	`memo` VARCHAR(255) COMMENT '備考',
	`receive_print` TINYINT default 0 COMMENT '（店舗管理）受付一覧レポート 0:表示する 1:表示しない',
	`ticket_print_flg` TINYINT UNSIGNED default 0 COMMENT '発券用紙印字フラグ 0:印字しない 1:印字する',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	KEY `index_shop_id`(`shop_id`)
) COMMENT='旧EPARK のカテゴリー(上位、下位あり)';

#-----------------------------------------------------------------------------
#-- shop_reserve_conventional_category_option
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `shop_reserve_conventional_category_option`;


CREATE TABLE `shop_reserve_conventional_category_option`
(
	`id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT 'オプションＩＤ',
	`shop_id` BIGINT COMMENT 'ショップＩＤ',
	`shop_reserve_conventional_category_id` BIGINT COMMENT '予約カテゴリＩＤ',
	`display_order` TINYINT COMMENT '表示順',
	`name` VARCHAR(20) COMMENT '名称',
	`mobile` TINYINT default 0 COMMENT '携帯サイトに表示するか 0:表示　1:非表示',
	`num_max` INTEGER default 0 COMMENT '選択可能最大値',
	`num_min` INTEGER default 0 COMMENT '選択可能最小値',
	`parent_option_ids` VARCHAR(100) COMMENT '上位カテゴリーのIDを,区切りで指定 ここに記述したIDを選択している時、このオプションを選択できる',
	`input_skip_flg` TINYINT default 0 NOT NULL COMMENT '上位カテゴリの入力スキップフラグ',
	`status` TINYINT default 0 COMMENT '承認　 ０：承認　1：非承認',
	`admin_status` TINYINT default 0 COMMENT '（管理画面設定）承認　 ０：承認　1：非承認',
	`memo` VARCHAR(200) COMMENT '備考',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	KEY `index_shop_id`(`shop_id`),
	KEY `shop_reserve_conventional_category_id`(`shop_reserve_conventional_category_id`)
) COMMENT='旧EPARK のカテゴリーの選択肢のオプション(上位、下位あり)';

#-----------------------------------------------------------------------------
#-- h_shop_reserve_category_manage
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `h_shop_reserve_category_manage`;


CREATE TABLE `h_shop_reserve_category_manage`
(
	`id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT '予約カテゴリ管理ＩＤ',
	`shop_id` BIGINT  NOT NULL COMMENT '店舗ＩＤ',
	`reserve_category_id` BIGINT  NOT NULL COMMENT '予約カテゴリＩＤ',
	`ps_ui_flg` TINYINT default 0 NOT NULL COMMENT ' UI区分',
	`created_at` DATETIME  NOT NULL,
	`updated_at` DATETIME  NOT NULL,
	PRIMARY KEY (`id`),
	KEY `index_shop_id`(`shop_id`),
	KEY `index_created_at`(`created_at`),
	KEY `index_updated_at`(`updated_at`)
) COMMENT='店舗予約カテゴリ管理';

#-----------------------------------------------------------------------------
#-- owner_shop
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `owner_shop`;


CREATE TABLE `owner_shop`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	`status` TINYINT default 1 NOT NULL COMMENT 'アカウントの運用状態 0: 運用中 1: 停止中 2: 削除済み',
	`name` VARCHAR(80),
	`name_kana` VARCHAR(200) COMMENT 'オーナー店舗名ひらがな',
	`custom_specification_type` TINYINT default 0 NOT NULL COMMENT '店舗独自仕様種別 0: 通常 1: くら寿司 2: JINS 3:新メディカル 4:API 5:ポータルメディカル 1: くら寿司 は現在未使用、将来の改修時のために予約 ※このカラムは、shop.custom_specification_type の利用に置き換えられます。利用しません。(2011/06/24)',
	`email` VARCHAR(255) COMMENT 'メールアドレス',
	`tel` VARCHAR(20) COMMENT '電話番号',
	`fax` VARCHAR(20) COMMENT 'fax番号',
	`zip_code` VARCHAR(7) COMMENT '郵便番号',
	`address` VARCHAR(300) COMMENT '住所',
	`contact_name` VARCHAR(40) COMMENT '担当者名',
	`contact_name_kana` VARCHAR(100) COMMENT '担当者名ひらがな',
	`url` VARCHAR(300) COMMENT 'サイトURL',
	`memo` TEXT COMMENT '備考',
	`concier_disp_type` TINYINT default 0 COMMENT 'コンシェル表示区分 0:ON 1:OFF',
	`franchise_help_link_flg` TINYINT default 1 COMMENT '加盟店さま向けヘルプサイトへのリンク設定項目 0:ON 1:OFF',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`)
) COMMENT='オーナー店舗マスタ';

#-----------------------------------------------------------------------------
#-- owner_shop_auth
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `owner_shop_auth`;


CREATE TABLE `owner_shop_auth`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT COMMENT 'オーナ店舗権限ID',
	`owner_shop_id` INTEGER  NOT NULL COMMENT 'オーナ店舗ID',
	`service_id` SMALLINT  NOT NULL COMMENT 'commonのserviceテーブルと紐付けられるID',
	`password` VARCHAR(15) COMMENT '平文パスワード保持用カラム',
	`sha1_password` VARCHAR(40)  NOT NULL COMMENT '総合管理画面から各オーナー店舗で設定したオーナー店舗管理パスワード。sha1暗号化済み',
	`salt` VARCHAR(32)  NOT NULL COMMENT 'sha1暗号化用salt',
	`send_num` SMALLINT  NOT NULL COMMENT 'メールを送信するとカウントされる。現在登録されている全てのレコードでこの値が0',
	`login_at` DATETIME COMMENT 'オーナー店舗管理画面への最終ログイン日時',
	`send_last_mail_at` DATETIME COMMENT '最後にメール送信した日時',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	KEY `index_owner_shop_id`(`owner_shop_id`)
) COMMENT='オーナ店舗権限マスタ';

#-----------------------------------------------------------------------------
#-- shop
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `shop`;


CREATE TABLE `shop`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	`owner_shop_id` INTEGER  NOT NULL COMMENT 'オーナー店舗のID',
	`mdshop_id` INTEGER default 0 NOT NULL COMMENT 'EPARK MEDICALの店舗ID',
	`pref_id` TINYINT COMMENT '都道府県ID epark_common.prefecture.id',
	`shop_category_id` INTEGER COMMENT '所属カテゴリID shop_category.idへの外部キー',
	`status` TINYINT default 1 NOT NULL COMMENT '運用状態 0: 運用 1: 運用停止 2: 削除済み 承認 0: 承認 1: 非承認 2: 削除済み 総合管理画面では「承認」と呼ばれている これとは別に、shop_auth.status 「EPARKサービス利用状態」の利用中、停止中もあるので注意',
	`logined_at` DATETIME COMMENT '最終ログイン日時',
	`name` VARCHAR(80) COMMENT '店舗名',
	`name_kana` VARCHAR(200) COMMENT '店舗名ひらがな',
	`sha1_password` VARCHAR(40) COMMENT '符号化化済みパスワード',
	`salt` VARCHAR(32) COMMENT '認証用ランダムキー',
	`email` VARCHAR(255) COMMENT 'メールアドレス',
	`url_mobile` VARCHAR(100) COMMENT 'モバイルサイトのURL',
	`url_pc` VARCHAR(100) COMMENT 'PCサイトのURL',
	`tel` VARCHAR(20) COMMENT '電話番号',
	`fax` VARCHAR(20) COMMENT 'FAX番号',
	`cancel_tel` VARCHAR(20) COMMENT 'テイクアウトでキャンセル・内容変更時に使用する電話番号',
	`gmo_shop_id` INTEGER COMMENT 'GMO決済用加盟店ID',
	`zip_code` VARCHAR(7) COMMENT '郵便番号',
	`address1` VARCHAR(100) COMMENT '住所1',
	`address2` VARCHAR(100) COMMENT '住所2',
	`access_car` VARCHAR(300) COMMENT '車でのアクセス',
	`access_train` VARCHAR(420) COMMENT '電車でのアクセス',
	`copyright` VARCHAR(100) COMMENT '著作権表示',
	`image_name` VARCHAR(50) COMMENT '携帯サイトロゴ画像名',
	`touch_image_name` VARCHAR(50) COMMENT 'タッチパネルロゴ画像名',
	`latitude` DOUBLE COMMENT '店舗の緯度',
	`longitude` DOUBLE COMMENT '店舗の経度',
	`neighborhood_shop_list` VARCHAR(30) COMMENT '近隣店舗。店舗IDを３件まで登録可能。改行をすることで別IDとして認識します。',
	`contact_name` VARCHAR(40) COMMENT '担当者名',
	`contact_name_kana` VARCHAR(100) COMMENT '担当者名ひらがな',
	`contract_type` TINYINT default 0 NOT NULL COMMENT '契約の種類 0: ライトコース 1: 通常コース 2: EPARKライト契約(android版)',
	`printer_type` TINYINT COMMENT 'プリンタの種類 0: EPSON 1: 日本プリメックス 2: CITIZEN(新GMS端末のみ),3: SII,4: エプソン（iPad印刷可）6: Android用Bluetoothプリンタ',
	`printer_ip` VARCHAR(15) COMMENT 'プリンターIP',
	`audio_assist_server_ip` VARCHAR(15) COMMENT '音声案内サーバIP',
	`use_display` TINYINT default 0 NOT NULL COMMENT '表示機があるかどうか 0: なし 1: あり 旧）表示機管理作成前 0: なし 1: あり(JINS店舗 1台運用も含む) 2: あり(JINS店舗 2台運用) 3:あり（NEWメガネショップ用）',
	`single_terminal` TINYINT default 0 NOT NULL COMMENT '運用台数が一台かどうか 0: 2台運用 1: 1台運用',
	`mail_sendable` TINYINT default 1 NOT NULL COMMENT 'メール配信可能かどうか 0: 不可能 1: 可能',
	`customer_screen_show_type` TINYINT default 1 NOT NULL COMMENT 'お客様画面表示方法 1：1列表示、2：2列表示（将来順番と順番を別表示）、3：2列表示ダミー行有り、4:2列表示縦（通常、部門なし店舗のみ）',
	`touch_wait_check` TINYINT default 0 NOT NULL COMMENT 'タッチパネル来店客チェックの有無 0: なし 1: あり',
	`is_remail` TINYINT default 0 NOT NULL COMMENT 'リメール店舗かどうか 0:EPARK店舗 1:リメール店舗',
	`send_reserve_mail` TINYINT default 1 NOT NULL COMMENT '会員に予約確認メールを送信するかどうか',
	`sel_criteria_kbn` TINYINT default 0 NOT NULL COMMENT '部門選択条件 0: 未導入 1: 導入',
	`department_kbn` TINYINT default 0 NOT NULL COMMENT '部門 0: 未導入 1: 導入',
	`sequential_department_id` BIGINT default 0 COMMENT '部門連番用の部門ID',
	`criteria_both_kbn` TINYINT default 0 COMMENT '「どちらでも」部門 0: 未使用 1: 使用',
	`closed_sunday` TINYINT default 0 NOT NULL COMMENT '日曜休業かどうか 0:営業 1:休業',
	`closed_monday` TINYINT default 0 NOT NULL COMMENT '月曜休業かどうか 0:営業 1:休業',
	`closed_tuesday` TINYINT default 0 NOT NULL COMMENT '火曜休業かどうか 0:営業 1:休業',
	`closed_wednesday` TINYINT default 0 NOT NULL COMMENT '水曜休業かどうか 0:営業 1:休業',
	`closed_thursday` TINYINT default 0 NOT NULL COMMENT '木曜休業かどうか 0:営業 1:休業',
	`closed_friday` TINYINT default 0 NOT NULL COMMENT '金曜休業かどうか 0:営業 1:休業',
	`closed_saturday` TINYINT default 0 NOT NULL COMMENT '土曜休業かどうか 0:営業 1:休業',
	`closed_holiday` TINYINT default 0 NOT NULL COMMENT '祝日休業かどうか 0:営業 1:休業',
	`open_holiday` TINYINT default 0 NOT NULL COMMENT '祝日営業しているかどうか 0:休業 1:営業 ここだけ、0:休業 となって論理が逆なので注意 上記の、closed_holiday以外の休日設定が「祝日と重なったときに限って」特別に営業するという設定。 closed_holidayが1（休業）となっていると矛盾するので、旧システムの管理画面では closed_holiday と open_holiday を同時にチェックしようとすると警告メッセージが表示されて変更できない',
	`irregular_holiday` TINYINT default 0 NOT NULL COMMENT '不定休かどうか 0:不定休でない 1:不定休である',
	`always_open` TINYINT default 0 NOT NULL COMMENT '年中無休かどうか 0:年中無休でない 1:年中無休である',
	`decided_holiday` TINYINT default 0 NOT NULL COMMENT '「定休日なし」かどうか 0:「定休日なし」でない 1:「定休日なし」である',
	`medical_url` VARCHAR(10) COMMENT '医療機関用URL(詳しく調べる必要あり)',
	`memo` VARCHAR(200) COMMENT '備考。switchが入っていた場合を条件としていて、移管店舗かどうか判断していたりする。',
	`spare1` BIGINT COMMENT '移管するときに使っていた様子。これが空でなく、memoの値がswitchなら移管店舗と判断している。',
	`spare2` VARCHAR(100) COMMENT '使っていない',
	`inspection_machine_count` TINYINT default 1 NOT NULL COMMENT '検査機台数(jins用)',
	`session_life_time` INTEGER default 3600 NOT NULL COMMENT 'SHOP毎のセッショライフタイム（秒）',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	`printer_status` TINYINT default 0 NOT NULL COMMENT 'メディカル使用項目 プリンタ印刷(受付票) 0:しない 1:する',
	`browser_type` TINYINT default 0 NOT NULL COMMENT 'ブラウザタイプ 0:IE6 1:IE7以上',
	`information_color` TINYINT default 0 NOT NULL COMMENT '受付画面配色 0:Aグリーン 1:Bオレンジ 2:Cブルー',
	`screen_kind` TINYINT default 0 NOT NULL COMMENT '画面種別 0:A（ショップ仕様）1:B（飲食店仕様) 2:C (新JINSデザイン仕様) 3:D (時間指定・順番待ち併用受付仕様)',
	`voice_play_status` TINYINT default 0 NOT NULL COMMENT '音声呼出 0:なし1:あり',
	`custom_specification_type` TINYINT default 0 NOT NULL COMMENT '店舗独自仕様種別 0: 通常 1: くら寿司 2: JINS 3:新メディカル 4:API 5:ポータルメディカル 6:査定システム 7:阪急阪神レストラン街 8:薬局 9:カーケア 10:大病院予約連携 1: くら寿司 は現在未使用、将来の改修時のために予約 ※owner_shop.custom_specification_type は廃止予定です。',
	`use_report` TINYINT  NOT NULL COMMENT 'Eネ!レポ機能利用フラグ0:無効1:有効',
	`only_publication` TINYINT default 0 NOT NULL COMMENT '掲載のみフラグ0:通常1:掲載のみ',
	`seats` SMALLINT default 0 COMMENT '席数0:指定なし',
	`unit_price_lunch` INTEGER default 0 COMMENT '単価（昼）0:指定なし1:～1,000円 2:1,000～2,000円 3:2,000～3,000円 4:3,000～5,000円 5:5,000～10,000円 6:10,000～20,000円 7:20,000円～',
	`unit_price_dinner` TINYINT default 0 COMMENT '単価（夜）0:指定なし1:～1,000円 2:1,000～2,000円 3:2,000～3,000円 4:3,000～5,000円 5:5,000～10,000円 6:10,000～20,000円 7:20,000円～',
	`credit_card` TINYINT default 0 NOT NULL COMMENT '詳細情報：各種クレジットカード有0:指定なし1:なし2:あり',
	`shopping_mall` TINYINT default 0 NOT NULL COMMENT '詳細情報：ショッピングモール有0:指定なし1:なし2:あり',
	`smoking` TINYINT default 0 NOT NULL COMMENT '喫煙可能 0: 指定なし 1: 禁煙 2: 喫煙可 3:分煙',
	`child_seats` TINYINT default 0 NOT NULL COMMENT '詳細情報：お子様席有0:指定なし1:なし2:あり',
	`parking` TINYINT default 0 NOT NULL COMMENT '詳細情報：駐車場有0:指定なし1:なし2:あり',
	`takeout` TINYINT default 0 NOT NULL COMMENT '詳細情報：テイクアウト有0:指定なし1:なし2:あり',
	`open_text` VARCHAR(200) COMMENT '営業時間（フリーテキスト）',
	`close_text` VARCHAR(200) COMMENT '定休日（フリーテキスト）',
	`charged_reservation` TINYINT default 0 NOT NULL COMMENT '有料予約店舗かどうか 0:使用しない1:使用する',
	`proposed_shop_list` VARCHAR(800) COMMENT '同時会員登録店舗。店舗IDを99件まで登録可能。改行をすることで別IDとして認識します。',
	`sbm_proposed_shop_list` VARCHAR(800) COMMENT '同時会員登録店舗(新SBM版)。店舗IDを99件まで登録可能。改行をすることで別IDとして認識します。',
	`coupon_day_count` TINYINT default 4 COMMENT '1店舗あたりのクーポン発行可能日数 2012.06.22#5313_改修により店舗毎に管理する。',
	`aim_time_text` VARCHAR(40) COMMENT 'ねらい目時間',
	`google_shop_photo` TINYINT default 1 NOT NULL COMMENT 'Googleおみせフォト使用フラグ 0: 使用 1: 未使用',
	`free_drink` TINYINT default 0 NOT NULL COMMENT '飲み放題・ドリンクバー有 0: 指定なし 1: なし 2: あり',
	`free_food` TINYINT default 0 NOT NULL COMMENT '食べ放題有 0: 指定なし 1: なし 2: あり',
	`credit_card_text` VARCHAR(100) COMMENT 'クレジットカード フリー文言',
	`zashiki` TINYINT default 0 NOT NULL COMMENT 'お座敷有 0: 指定なし 1: なし 2: あり',
	`barrier_free` TINYINT default 0 NOT NULL COMMENT 'バリアフリー有 0: 指定なし 1: なし 2: あり',
	`lunch` TINYINT default 0 NOT NULL COMMENT 'ランチ有 0: 指定なし 1: なし 2: あり',
	`late_night` TINYINT default 0 NOT NULL COMMENT '22時以降も営業有 0: 指定なし 1: なし 2: あり',
	`neighboring_guidance_shop_list` VARCHAR(50) COMMENT '近隣店舗誘導。店舗IDを５件まで登録可能。改行をすることで別IDとして認識します。',
	`neighboring_guidance_text` VARCHAR(200) COMMENT '近隣店舗誘導メッセージ',
	`interlocking_seat_contact_name` VARCHAR(40) COMMENT '担当者機能名称',
	`interlocking_seat_booth_name` VARCHAR(40) COMMENT 'ブース機能名称',
	`display_graph` TINYINT default 1 COMMENT 'グラフ表示 0：表示、1：非表示',
	`display_icon1` TINYINT default 1 COMMENT 'おすすめアイコン１ 0：表示、1：非表示',
	`icon1_hour` INTEGER COMMENT 'アイコン表示時間１ おすすめアイコンを表示する時間帯',
	`display_icon2` TINYINT default 1 COMMENT 'おすすめアイコン２ 0：表示、1：非表示',
	`icon2_hour` INTEGER COMMENT 'アイコン表示時間２ おすすめアイコンを表示する時間帯',
	`mail_free_count` INTEGER COMMENT 'メール無料送数',
	`mail_unit_price` SMALLINT COMMENT 'メール単価。メール無料送数を超えた場合の1メールあたりの単価。',
	`pda_logout_hour` TINYINT default 2 COMMENT 'PDA強制ログアウト実行時間 0時から23時で管理を想定 99：しない、2：AM2時に実行 8:AM8時に実行 ',
	`culture_cd` VARCHAR(5) default 'ja_JP' COMMENT '使用言語コード',
	`dsgn_col_id` INTEGER UNSIGNED COMMENT 'デザインカラーID',
	`reception_wording` VARCHAR(30) COMMENT '受付ボタン文言',
	`reception_font_size` SMALLINT default 550 COMMENT '受付ボタン文言サイズ(倍率)',
	`net_reception_wording` VARCHAR(30) COMMENT 'ネット受付ボタン文言',
	`net_reception_font_size` SMALLINT default 550 COMMENT 'ネット受付ボタン文言サイズ(倍率)',
	`concier_disp_type` TINYINT default 0 COMMENT 'コンシェル表示区分 0:ON 1:OFF',
	`newly_open_date` DATE COMMENT '新規オープン日',
	`accept_start_days` SMALLINT UNSIGNED COMMENT '予約受付可能になる新規オープン日からの日数',
	`expo_id` VARCHAR(255) COMMENT 'EXPO独自の店舗識別子',
	`parking_number` INTEGER UNSIGNED COMMENT '駐車場台数',
	`em_type` TINYINT UNSIGNED default 0 NOT NULL COMMENT '電子マネー',
	`kids_menu` TINYINT default 0 NOT NULL COMMENT 'キッズメニュー',
	`keywords` VARCHAR(255) COMMENT '検索キーワード',
	`nsips_cordi_status` TINYINT UNSIGNED default 0 NOT NULL COMMENT 'NSIPS連携区分',
	`gotoeat` TINYINT(4) default 0 NOT NULL COMMENT 'GoToEat対象',
	`gourmet_shop_id` VARCHAR(20) COMMENT 'EPARKグルメ店舗ID',
	`takeout_shop_id` INTEGER(11) COMMENT 'EPARKテイクアウト店舗ID',
	PRIMARY KEY (`id`),
	KEY `index_owner_shop_id`(`owner_shop_id`),
	KEY `index_only_publication_status`(`only_publication`, `status`),
	INDEX `shop_FI_2` (`shop_category_id`)
) COMMENT='店舗マスタ';

#-----------------------------------------------------------------------------
#-- shop_auth
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `shop_auth`;


CREATE TABLE `shop_auth`
(
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID',
	`owner_shop_id` INTEGER  NOT NULL COMMENT 'オーナー店舗ID パフォーマンス向上のための冗長化',
	`status` TINYINT default 1 NOT NULL COMMENT 'EPARKサービス利用状態 0: 利用中 1: 停止中 総合管理画面で「承認」と呼ばれている shop.status もあるので注意',
	`sha1_password_touch` VARCHAR(64)  NOT NULL COMMENT '符号化済みパスワード タッチパネル用',
	`salt_touch` VARCHAR(32)  NOT NULL COMMENT '認証用salt タッチパネル用',
	`sha1_password_admin` VARCHAR(64)  NOT NULL COMMENT '符号化済みパスワード 店舗管理画面用',
	`salt_admin` VARCHAR(32)  NOT NULL COMMENT '認証用salt 店舗管理画面用',
	`send_count` SMALLINT  NOT NULL COMMENT '管理者アカウント情報送信回数',
	`registration_mailto` VARCHAR(20)  NOT NULL COMMENT '会員登録用空メールアドレスの、@の左部分',
	`coupon_id` INTEGER COMMENT '初回特典クーポン',
	`nml_mail_auth_group_id` INTEGER COMMENT 'お知らせメール配信設定承認グループID',
	`cpn_mail_auth_group_id` INTEGER COMMENT 'クーポンメール配信設定承認グループID',
	`line_channel_id` VARCHAR(16) COMMENT 'LINE連携店舗のチャンネルID',
	`line_channel_secret` VARCHAR(64) COMMENT 'LINE連携店舗のチャンネルシークレット',
	`line_shop_mid` VARCHAR(512) COMMENT 'LINE連携店舗の識別子（mid）',
	`line_bot_id` INTEGER UNSIGNED COMMENT 'LINE連携店舗の識別子（bot_id）',
	`sent_at` DATETIME COMMENT '店舗アカウント情報初回送信日時',
	`logined_at` DATETIME COMMENT '最終ログイン日時',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	`telreserve_useno` VARCHAR(20) COMMENT '電話予約サービスの利用者電話番号',
	`nsips_credential` VARCHAR(512) COMMENT 'NSIPS連携クレデンシャル',
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	PRIMARY KEY (`id`),
	UNIQUE KEY `uix_shop_auth` (`shop_id`),
	KEY `index_owner_shop_id`(`owner_shop_id`),
	KEY `index_status`(`status`),
	INDEX `shop_auth_FI_3` (`nml_mail_auth_group_id`),
	INDEX `shop_auth_FI_4` (`cpn_mail_auth_group_id`)
) COMMENT='店舗の認証情報';

#-----------------------------------------------------------------------------
#-- tmp_shop_auth
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `tmp_shop_auth`;


CREATE TABLE `tmp_shop_auth`
(
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID',
	`key` VARCHAR(20)  NOT NULL COMMENT 'ランダムキー',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	PRIMARY KEY (`id`),
	INDEX `tmp_shop_auth_FI_1` (`shop_id`)
) COMMENT='パスワード再発行時利用';

#-----------------------------------------------------------------------------
#-- shop_category
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `shop_category`;


CREATE TABLE `shop_category`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	`xl_category_id` INTEGER default 0 NOT NULL COMMENT '大々分類のカテゴリID 1: グルメ 2: 医療 3: 暮らし',
	`big_category_id` INTEGER default 0 NOT NULL COMMENT '大分類のカテゴリID',
	`mid_category_id` INTEGER default 0 NOT NULL COMMENT '中分類のカテゴリID',
	`name` VARCHAR(40)  NOT NULL COMMENT 'カテゴリ名',
	`display_order` BIGINT  NOT NULL COMMENT '表示順 12桁を4桁ずつに区切り、上から順にそれぞれ大・中・小分類の表示順を表す',
	`memo` VARCHAR(200) COMMENT '備考',
	`total_shop_count` INTEGER default 0 NOT NULL COMMENT '登録店舗数',
	`operating_shop_count` INTEGER default 0 NOT NULL COMMENT '掲載中店舗数',
	`only_publication_shop_count` INTEGER default 0 NOT NULL COMMENT '掲載のみ店舗数',
	`only_publication_button` INTEGER default 0 NOT NULL COMMENT '掲載のみ店舗ボタン',
	`epark_brought_button` INTEGER default 0 NOT NULL COMMENT '導入済み店舗ボタン',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`)
) COMMENT='店舗カテゴリ';

#-----------------------------------------------------------------------------
#-- big_category
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `big_category`;


CREATE TABLE `big_category`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	`name` VARCHAR(40)  NOT NULL COMMENT '大分類カテゴリ名',
	PRIMARY KEY (`id`)
) COMMENT='大分類のカテゴリ';

#-----------------------------------------------------------------------------
#-- mid_category
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `mid_category`;


CREATE TABLE `mid_category`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	`name` VARCHAR(40)  NOT NULL COMMENT '中分類カテゴリ名',
	PRIMARY KEY (`id`)
) COMMENT='中分類のカテゴリ';

#-----------------------------------------------------------------------------
#-- small_category
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `small_category`;


CREATE TABLE `small_category`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	`name` VARCHAR(40)  NOT NULL COMMENT '小分類カテゴリ名',
	PRIMARY KEY (`id`)
) COMMENT='小分類のカテゴリ';

#-----------------------------------------------------------------------------
#-- shop_auth_config
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `shop_auth_config`;


CREATE TABLE `shop_auth_config`
(
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID',
	`auth_type` TINYINT  NOT NULL COMMENT '権限 1: 順番待ち機能の利用権限 2: 将来順番受付機能の利用権限 3: メール配信の利用権限 8: テストな権限 9:QRコード利用権限 10:初回特典有無 11:店舗管理画面の削除ボタン表示可否 12:タッチパネルからのメール配信設定 13:テンプレートメール機能の利用権限 14:EPARK API widget 利用権限 15:電話呼出利用権限 16:接客機能の利用権限 17:担当者機能の利用権限 18:接客中QRコール利用権限 19: 携帯呼出利用権限 20:予約台帳機能利用権限 21: 来店ポイント機能利用権限 22: 即時案内機能利用権限 23:メールにクーポンをセットできる数 24:券売機利用権限 25:手書きパッド利用権限 26:席連動機能利用権限 27:ブース機能利用権限 28:来店スタンプ機能利用権限 29:電話受付機能利用権限 30:接客中電話呼出利用権限 31:メッセージ配信機能利用権限 32:デザインカラー利用権限 33:接客中アラート権限 34:接客中チャイム権限 36:選択コンテンツ機能利用権限 38:ダイニングレジ機能利用権限 39:整理券発券機能利用権限 40:緊急Push配信利用権限 41:緊急メール配信機能利用権限 42:薬局お薬手帳連携 43:Resty連携予約ポイント付与 44:Y2クラウド連携設定 45:QR・バーコードリーダー連携権限 48:順番待ちサイネージ受付権限 49:呼出しQRコードWeb表示権限 52:予約タイプ選択権限',
	`auth_status` TINYINT  NOT NULL COMMENT '権限ステータス 0: 使用可 1: 使用不可 ただしauth_id=8の場合は 0: 通常 1: テスト店舗、auth_id=23の場合は 0:複数 1:1つ、auth_id=44の場合は 0:連携しない 1:連携する auth_id=49の場合は 0:空メール(デフォルト) 1:Webページ表示',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`shop_id`,`auth_type`),
	KEY `index_shop_id`(`shop_id`),
	KEY `index_type`(`auth_type`)
) COMMENT='店舗の各種権限設定 ※本来不要なテーブル Shopテーブルへ4つカラムを追加すればよく、このテーブルが存在することが大げさ(by iceさん？) 課金にからむものはこのテーブルにまとまっている気がします(k-nakamura)テスト店舗はさておき。';

#-----------------------------------------------------------------------------
#-- shop_member
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `shop_member`;


CREATE TABLE `shop_member`
(
	`id` BIGINT  NOT NULL AUTO_INCREMENT,
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID',
	`member_id` INTEGER  NOT NULL COMMENT '会員ID',
	`service_id` SMALLINT  NOT NULL COMMENT 'サービスID',
	`pv_count` INTEGER default 0 NOT NULL COMMENT 'ページ閲覧回数',
	`news_status` TINYINT default 1 NOT NULL COMMENT 'メール配信ステータス 0: 拒否 1: 希望',
	`status` TINYINT default 1 NOT NULL COMMENT 'ステータス 0: 運用 1: 運用停止',
	`edited_by` TINYINT default 0 NOT NULL COMMENT '編集または削除したユーザのタイプ 0: 会員 1: 店舗 2: オーナー店舗(不使用) 2: 運営側',
	`visit_date` DATETIME COMMENT '会員が直近で来店した日付',
	`first_visit_date` DATE default '9999-12-31' COMMENT '会員が初めて来店した日付',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	KEY `shop_member_I_1`(`visit_date`),
	KEY `index_member_id`(`member_id`),
	KEY `index_shop_member_I_2`(`shop_id`, `created_at`, `status`),
	KEY `index_shop_member_I_3`(`shop_id`, `news_status`),
	KEY `index_updated_at`(`updated_at`),
	KEY `index_created_at`(`created_at`),
	KEY `ix_shop_member4`(`shop_id`, `member_id`)
) COMMENT='店舗・会員の関連テーブル 会員が店舗に登録していることを表す';

#-----------------------------------------------------------------------------
#-- shop_menu
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `shop_menu`;


CREATE TABLE `shop_menu`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID',
	`status` TINYINT default 1 NOT NULL COMMENT '公開ステータス 0: 公開中 1: 非公開 2: 削除',
	`display_order` TINYINT  NOT NULL COMMENT '表示順',
	`name` VARCHAR(50)  NOT NULL COMMENT 'メニュー名',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	KEY `index_shop_id`(`shop_id`)
) COMMENT='店舗メニュー';

#-----------------------------------------------------------------------------
#-- shop_menu_detail
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `shop_menu_detail`;


CREATE TABLE `shop_menu_detail`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	`shop_menu_id` INTEGER  NOT NULL COMMENT 'メニューID',
	`title` VARCHAR(50)  NOT NULL COMMENT '小見出し',
	`text` TEXT  NOT NULL COMMENT '説明',
	`fix` VARCHAR(10) COMMENT '定型文設定 システム側で用意された定型文を表示する 1: 税込 2: 税抜き 3: 要予約',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	INDEX `shop_menu_detail_FI_1` (`shop_menu_id`)
) COMMENT='メニューの詳細';

#-----------------------------------------------------------------------------
#-- shop_photo
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `shop_photo`;


CREATE TABLE `shop_photo`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID',
	`status` TINYINT default 1 NOT NULL COMMENT '公開ステータス 0: 公開 1: 非公開 2: 削除',
	`display_order` TINYINT  NOT NULL COMMENT '表示順',
	`title` VARCHAR(50)  NOT NULL COMMENT '写真名',
	`filename` VARCHAR(100)  NOT NULL COMMENT '画像ファイル名',
	`text` TEXT  NOT NULL COMMENT '説明文',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	KEY `index_shop_id`(`shop_id`)
) COMMENT='店舗の写真情報';

#-----------------------------------------------------------------------------
#-- shop_session_pc
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `shop_session_pc`;


CREATE TABLE `shop_session_pc`
(
	`id` VARCHAR(255)  NOT NULL COMMENT 'セッションID ランダム文字列',
	`data` TEXT  NOT NULL COMMENT 'symfonyのセッションデータ',
	`shop_id` INTEGER COMMENT '店舗ID これをキーにしてセッション数を数えられるように',
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	INDEX `shop_session_pc_FI_1` (`shop_id`)
) COMMENT='PC版総合管理画面用セッション情報';

#-----------------------------------------------------------------------------
#-- shop_session_touch
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `shop_session_touch`;


CREATE TABLE `shop_session_touch`
(
	`id` VARCHAR(255)  NOT NULL COMMENT 'セッションID ランダム文字列',
	`data` TEXT  NOT NULL COMMENT 'symfonyのセッションデータ',
	`shop_id` INTEGER COMMENT '店舗ID これをキーにしてセッション数を数えられるように',
	`updated_at` DATETIME,
	PRIMARY KEY (`id`)
) COMMENT='店舗タッチパネル用セッション情報';

#-----------------------------------------------------------------------------
#-- shop_session_mobile
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `shop_session_mobile`;


CREATE TABLE `shop_session_mobile`
(
	`id` VARCHAR(255)  NOT NULL COMMENT 'セッションID ランダム文字列',
	`data` TEXT  NOT NULL COMMENT 'symfonyのセッションデータ',
	`shop_id` INTEGER COMMENT '店舗ID これをキーにしてセッション数を数えられるように',
	`mobile_uid` VARCHAR(50) COMMENT '携帯電話のUID',
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	INDEX `shop_session_mobile_FI_1` (`shop_id`)
) COMMENT='店舗mobile用セッション情報';

#-----------------------------------------------------------------------------
#-- shop_site_api_access_log
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `shop_site_api_access_log`;


CREATE TABLE `shop_site_api_access_log`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	`service_code` VARCHAR(8)  NOT NULL COMMENT '店舗種別',
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID',
	`access_date` DATE  NOT NULL COMMENT '集計日付',
	`access_total` INTEGER default 0 NOT NULL COMMENT 'アクセス数',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	UNIQUE KEY `shop_site_api_access_log_uniq` (`service_code`, `shop_id`, `access_date`)
) COMMENT='店舗・日別のアクセス数';

#-----------------------------------------------------------------------------
#-- shop_site_tag_design
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `shop_site_tag_design`;


CREATE TABLE `shop_site_tag_design`
(
	`service_code` VARCHAR(8)  NOT NULL COMMENT '店舗種別',
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID',
	`width1` SMALLINT default 480 NOT NULL COMMENT 'デザイン1の横幅',
	`width2` SMALLINT default 250 COMMENT 'デザイン2の横幅',
	`background_color` VARCHAR(6) default 'ecfedc' NOT NULL COMMENT '背景色',
	`border_color` VARCHAR(6) default 'bbbbbb' NOT NULL COMMENT '外枠線色',
	`button_color` TINYINT default 1 NOT NULL COMMENT 'ボタン 1:なし 2:RED 3:ORANGE 4:BLUE 5:GREEN 6:GRAY 7:BLACK',
	`save_tag1` TEXT  NOT NULL COMMENT '保存タグ1',
	`save_tag2` TEXT COMMENT '保存タグ2',
	PRIMARY KEY (`service_code`,`shop_id`)
) COMMENT='店舗のタグのデザイン';

#-----------------------------------------------------------------------------
#-- shop_extra_closure
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `shop_extra_closure`;


CREATE TABLE `shop_extra_closure`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID',
	`close_date` DATE  NOT NULL,
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	UNIQUE KEY `shop_id_and_close_date_unique` (`shop_id`, `close_date`),
	KEY `index_shop_id`(`shop_id`)
) COMMENT='店舗の臨時休業日設定';

#-----------------------------------------------------------------------------
#-- shop_timeset
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `shop_timeset`;


CREATE TABLE `shop_timeset`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID',
	`set_number` TINYINT  NOT NULL COMMENT '設定パターン(日の分類) 0:平日 1:土曜日 2:日曜日 3:祝日 4:金曜日 5:祝前日 6:月曜 7:火曜 8:水曜 9:木曜',
	`wait_time` SMALLINT  NOT NULL COMMENT '待ち時間(分) ※利用せず',
	`wait_time_max` SMALLINT  NOT NULL COMMENT 'ディスプレイに表示する最大待ち時間(分) ※利用せず',
	`open1_start` TIME  NOT NULL COMMENT '営業時間1の開始時間',
	`open1_close` TIME  NOT NULL COMMENT '営業時間1の終了時間',
	`open2_start` TIME COMMENT '営業時間2の開始時間',
	`open2_close` TIME COMMENT '営業時間2の終了時間',
	`open3_start` TIME COMMENT '営業時間3の開始時間',
	`open3_close` TIME COMMENT '営業時間3の終了時間',
	`order_stop` INTEGER COMMENT '受付終了時間',
	`open24` TINYINT COMMENT '24時間営業 1:24時間営業 0:24時間営業ではない',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	KEY `index_shop_id`(`shop_id`),
	KEY `index_set_number_shop_id`(`set_number`, `shop_id`)
) COMMENT='店舗の営業時間情報';

#-----------------------------------------------------------------------------
#-- shop_point_timeset_margin
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `shop_point_timeset_margin`;


CREATE TABLE `shop_point_timeset_margin`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID',
	`shop_timeset_id` INTEGER  NOT NULL COMMENT '店舗営業時間設定ID',
	`margin1` SMALLINT COMMENT '閉店時間設定1からの来店ポイント付与可能時間(分) 0～180分 ※NULLの場合未設定',
	`margin2` SMALLINT COMMENT '閉店時間設定2からの来店ポイント付与可能時間(分) 0～180分 ※NULLの場合未設定',
	`margin3` SMALLINT COMMENT '閉店時間設定3からの来店ポイント付与可能時間(分) 0～180分 ※NULLの場合未設定',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	KEY `index_shop_id`(`shop_id`),
	KEY `index_shop_timeset_id`(`shop_timeset_id`, `shop_id`)
) COMMENT='閉店時間から、何分後まで来店ポイントの付与が可能か設定';

#-----------------------------------------------------------------------------
#-- shop_timeset_exeption
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `shop_timeset_exeption`;


CREATE TABLE `shop_timeset_exeption`
(
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID',
	`date` DATETIME COMMENT '設定日',
	`created_at` DATETIME,
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	PRIMARY KEY (`id`),
	KEY `index_shop_id`(`shop_id`)
) COMMENT='店舗の営業時間設定（例外）';

#-----------------------------------------------------------------------------
#-- shop_timeset_mobile
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `shop_timeset_mobile`;


CREATE TABLE `shop_timeset_mobile`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID',
	`set_number` TINYINT  NOT NULL COMMENT '設定パターン(日の分類)',
	`open1_start` TIME  NOT NULL COMMENT '営業時間1の開始時間',
	`open1_close` TIME  NOT NULL COMMENT '営業時間1の終了時間',
	`open2_start` TIME COMMENT '営業時間2の開始時間',
	`open2_close` TIME COMMENT '営業時間2の終了時間',
	`open3_start` TIME COMMENT '営業時間3の開始時間',
	`open3_close` TIME COMMENT '営業時間3の終了時間',
	`open24` TINYINT COMMENT '24時間営業 1:24時間営業 0:24時間営業ではない',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	KEY `index_shop_id`(`shop_id`)
) COMMENT='店舗の携帯予約受付時間情報';

#-----------------------------------------------------------------------------
#-- shop_access
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `shop_access`;


CREATE TABLE `shop_access`
(
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID',
	`date` DATETIME  NOT NULL COMMENT '日付',
	`member_pv` INTEGER COMMENT '会員ページビュー',
	`nonmember_pv` INTEGER COMMENT '非会員ページビュー',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	PRIMARY KEY (`id`),
	KEY `index_shop_id`(`shop_id`)
) COMMENT='店舗のユーザーアクセス集計情報';

#-----------------------------------------------------------------------------
#-- shop_pv_detail
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `shop_pv_detail`;


CREATE TABLE `shop_pv_detail`
(
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID',
	`date` DATETIME  NOT NULL COMMENT '日付',
	`time` SMALLINT  NOT NULL COMMENT '時間(0-24)',
	`member_pv` INTEGER COMMENT '会員ページビュー',
	`nomember_pv` INTEGER COMMENT '非会員ページビュー',
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	PRIMARY KEY (`id`),
	KEY `index_shop_id`(`shop_id`)
);

#-----------------------------------------------------------------------------
#-- shop_pv_menu
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `shop_pv_menu`;


CREATE TABLE `shop_pv_menu`
(
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID',
	`date` DATETIME  NOT NULL COMMENT '日付',
	`time` SMALLINT  NOT NULL COMMENT '時間(0-24)',
	`member_pv` INTEGER COMMENT '会員ページビュー',
	`nomember_pv` INTEGER COMMENT '非会員ページビュー',
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	PRIMARY KEY (`id`),
	KEY `index_shop_id`(`shop_id`)
);

#-----------------------------------------------------------------------------
#-- shop_pv_photo
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `shop_pv_photo`;


CREATE TABLE `shop_pv_photo`
(
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID',
	`date` DATETIME  NOT NULL COMMENT '日付',
	`time` SMALLINT  NOT NULL COMMENT '時間(0-24)',
	`member_pv` INTEGER COMMENT '会員ページビュー',
	`nomember_pv` INTEGER COMMENT '非会員ページビュー',
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	PRIMARY KEY (`id`),
	KEY `index_shop_id`(`shop_id`)
);

#-----------------------------------------------------------------------------
#-- shop_pv_reserve
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `shop_pv_reserve`;


CREATE TABLE `shop_pv_reserve`
(
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID',
	`date` DATETIME  NOT NULL COMMENT '日付',
	`time` SMALLINT  NOT NULL COMMENT '時間(0-24)',
	`member_pv` INTEGER COMMENT '会員ページビュー',
	`nomember_pv` INTEGER COMMENT '非会員ページビュー',
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	PRIMARY KEY (`id`),
	KEY `index_shop_id`(`shop_id`)
);

#-----------------------------------------------------------------------------
#-- shop_pv_toppage
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `shop_pv_toppage`;


CREATE TABLE `shop_pv_toppage`
(
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID',
	`date` DATETIME  NOT NULL COMMENT '日付',
	`time` SMALLINT  NOT NULL COMMENT '時間(0-24)',
	`member_pv` INTEGER COMMENT '会員ページビュー',
	`nomember_pv` INTEGER COMMENT '非会員ページビュー',
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	PRIMARY KEY (`id`),
	KEY `index_shop_id_date_time`(`shop_id`, `date`, `time`)
);

#-----------------------------------------------------------------------------
#-- shop_pv_toppage_inflow
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `shop_pv_toppage_inflow`;


CREATE TABLE `shop_pv_toppage_inflow`
(
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID',
	`date` DATETIME  NOT NULL COMMENT '日付',
	`member_pv` INTEGER COMMENT '会員ページビュー',
	`nomember_pv` INTEGER COMMENT '非会員ページビュー',
	`from_shop` INTEGER COMMENT '流入元店舗ID',
	`from_page` INTEGER COMMENT '流入元ページまたは流入元機能　1:近隣店舗誘導',
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	PRIMARY KEY (`id`),
	KEY `index_shop_date_frompage`(`shop_id`, `date`, `from_page`),
	KEY `index_shop_date_fromshop_frompage`(`shop_id`, `date`, `from_shop`, `from_page`)
) COMMENT='流入元あり施設トップPV　shop_pv_toppageに流入元店舗を追加するとレコード数が増えるのでこちらにカウントする。現状は時間の要求はなし';

#-----------------------------------------------------------------------------
#-- shop_coupon
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `shop_coupon`;


CREATE TABLE `shop_coupon`
(
	`coupon_id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT 'クーポンID',
	`mail_id` INTEGER  NOT NULL COMMENT 'メールID （shop_mail.id OR group_mail.id）',
	`shop_id` INTEGER COMMENT '店舗ID',
	`group_id` INTEGER COMMENT 'グループ店舗ID',
	`shop_coupon_mst_id` INTEGER COMMENT '店舗クーポンマスタID',
	`name` VARCHAR(100) COMMENT 'クーポン名称',
	`text` VARCHAR(3500) COMMENT 'クーポン内容',
	`print_content` TEXT COMMENT '印字用クーポン説明',
	`send_limit_status` TINYINT default 0 NOT NULL COMMENT 'クーポン配信利用枚数指定(0:指定なし 1:指定する)',
	`send_limit` INTEGER COMMENT '配信枚数',
	`use_max_status` TINYINT default 1 NOT NULL COMMENT '利用回数指定(0:指定なし 1:期間中 2:一日)',
	`use_max_num` INTEGER COMMENT '利用可能回数最大値',
	`term_start` DATETIME COMMENT '利用期限開始日',
	`term_end` DATETIME COMMENT '利用期限終了日',
	`time_start_h` VARCHAR(2) COMMENT '有効時間開始(時)',
	`time_start_m` VARCHAR(2) COMMENT '有効時間開始(分)',
	`time_end_h` VARCHAR(2) COMMENT '有効時間終了(時)',
	`time_end_m` VARCHAR(2) COMMENT '有効時間終了(分)',
	`use_date_status` TINYINT default 0 NOT NULL COMMENT '有効日付指定(0:指定なし 1:指定する)',
	`use_week` VARCHAR(20) COMMENT '曜日指定　カンマ区切り 0：日1：月2：火3：水4：木5：金6：土7：祝',
	`use_days` VARCHAR(150) COMMENT '日付指定　カンマ区切り',
	`coupon_img` VARCHAR(50) COMMENT 'クーポン画像',
	`update_date` DATETIME COMMENT '更新日時 本来はupdated_atにすべき',
	PRIMARY KEY (`coupon_id`),
	KEY `index_shop_id`(`shop_id`),
	KEY `shop_coupon_FI_2`(`group_id`),
	KEY `index_term_end`(`term_end`),
	KEY `index_term_start`(`term_start`),
	KEY `idx_shop_mail_id`(`mail_id`, `shop_id`),
	KEY `idx_group_mail_id`(`mail_id`, `group_id`)
) COMMENT='クーポン管理データ格納';

#-----------------------------------------------------------------------------
#-- coupon_use
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `coupon_use`;


CREATE TABLE `coupon_use`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT COMMENT 'データコンバート時の主キー重複防止措置',
	`coupon_id` BIGINT COMMENT 'クーポンID',
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID',
	`member_id` INTEGER  NOT NULL COMMENT '会員ID',
	`print_no` BIGINT COMMENT 'クーポン番号',
	`use_date` DATETIME COMMENT '使用日時',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	UNIQUE KEY `coupon_use_uniq` (`coupon_id`, `shop_id`, `member_id`, `use_date`),
	KEY `index_coupon_id`(`coupon_id`),
	KEY `index_shop_id`(`shop_id`),
	KEY `member_id_created_at`(`member_id`, `created_at`)
) COMMENT='クーポン使用履歴';

#-----------------------------------------------------------------------------
#-- coupon_piece
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `coupon_piece`;


CREATE TABLE `coupon_piece`
(
	`mail_id` BIGINT  NOT NULL COMMENT 'メールID',
	`coupon_id` BIGINT  NOT NULL COMMENT 'クーポンID',
	`coupon_box_id` INTEGER COMMENT 'クーポンBOXID',
	`shop_id` INTEGER COMMENT '店舗ID',
	`group_id` INTEGER COMMENT 'グループ店舗ID',
	`member_id` INTEGER  NOT NULL COMMENT '会員ID',
	`print_number` BIGINT COMMENT 'クーポン発行番号',
	`key_number` INTEGER COMMENT '連番クーポン毎に１から生成',
	`key_random` INTEGER COMMENT 'ランダム生成番号',
	`use_count` INTEGER COMMENT 'クーポンが使用された回数',
	`sent_at` DATETIME COMMENT '送信日時',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	PRIMARY KEY (`id`),
	KEY `index_mail_id`(`mail_id`),
	KEY `index_coupon_id`(`coupon_id`),
	KEY `index_shop_id`(`shop_id`),
	KEY `index_member_id`(`member_id`),
	KEY `index_print_number`(`print_number`),
	KEY `coupon_piece_FI_1`(`coupon_box_id`),
	KEY `key_number`(`key_number`),
	KEY `coupon_piece_FI_2`(`group_id`),
	KEY `index_use_count`(`use_count`),
	KEY `index_group_coupon`(`group_id`, `coupon_id`),
	KEY `index_shop_coupon`(`coupon_id`, `shop_id`)
) COMMENT='クーポン（旧MISEMADO_RESERVE.COUPON_SEND）';

#-----------------------------------------------------------------------------
#-- shop_info
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `shop_info`;


CREATE TABLE `shop_info`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID',
	`group_info_id` INTEGER COMMENT 'グループ店舗お知らせID',
	`status` TINYINT default 1 NOT NULL COMMENT 'お知らせの承認状態 0:承認, 1:非承認, 2:削除済',
	`entry_type` TINYINT default 0 NOT NULL COMMENT '登録者種別。0:オーナー店舗、1:店舗',
	`title` VARCHAR(100)  NOT NULL COMMENT 'お知らせタイトル',
	`content` TEXT  NOT NULL COMMENT 'お知らせ内容',
	`push_notification` TINYINT default 0 NOT NULL COMMENT 'プッシュ配信 0:オフ 1:オン',
	`emergency` TINYINT default 0 NOT NULL COMMENT '緊急フラグ 0:通常 1:緊急',
	`start_reservation_at` DATETIME default '9999-12-31 00:00:00' COMMENT '予約対象開始日時',
	`end_reservation_at` DATETIME default '9999-12-31 00:00:00' COMMENT '予約対象終了日時',
	`start_display_at` DATETIME  NOT NULL COMMENT '表示開始日時',
	`end_display_at` DATETIME  NOT NULL COMMENT '表示終了日時',
	`news_photo` VARCHAR(100) COMMENT 'お知らせ画像',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	KEY `index_shop_id`(`shop_id`),
	KEY `shop_info_FI_2`(`group_info_id`)
) COMMENT='店舗お知らせ（旧MISEMADO_RESERVE）';

#-----------------------------------------------------------------------------
#-- qr_call
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `qr_call`;


CREATE TABLE `qr_call`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	`receive_id` INTEGER  NOT NULL COMMENT '予約ID',
	`auth_status` TINYINT default 0 NOT NULL COMMENT '認証状態 0:未承認, 1:承認済み',
	`call_method_type` TINYINT default 0 NOT NULL COMMENT '通知方法 0:メール通知 1:LINE通知',
	`mail` VARCHAR(255) COMMENT 'メールアドレス',
	`line_mid` VARCHAR(512) COMMENT 'LINE上の内部的な識別子',
	`qr_key` VARCHAR(26)  NOT NULL COMMENT 'QRコードのランダム値',
	`qr_image_file` VARCHAR(255)  NOT NULL COMMENT 'QRコード画像ファイル名',
	`call1_at` DATETIME COMMENT '1回目呼出日時',
	`call2_at` DATETIME COMMENT '2回目呼出日時',
	`call3_at` DATETIME COMMENT '3回目呼出日時',
	`mobile_access_at` DATETIME COMMENT '携帯アクセス日時',
	`auth_at` DATETIME COMMENT '認証日時',
	`created_at` DATETIME  NOT NULL COMMENT '作成日時',
	`updated_at` DATETIME  NOT NULL COMMENT '更新日時',
	PRIMARY KEY (`id`),
	KEY `index_receive_id`(`receive_id`),
	KEY `index_qr_key`(`qr_key`),
	KEY `idx_qr_call_auth_status`(`auth_status`)
) COMMENT='QRコール';

#-----------------------------------------------------------------------------
#-- qr_call_history
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `qr_call_history`;


CREATE TABLE `qr_call_history`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	`receive_id` INTEGER  NOT NULL COMMENT '予約ID',
	`auth_status` TINYINT default 0 NOT NULL COMMENT '認証状態 0:未承認, 1:承認済み',
	`call_method_type` TINYINT default 0 NOT NULL COMMENT '通知方法 0:メール通知 1:LINE通知',
	`mail` VARCHAR(255) COMMENT 'メールアドレス',
	`line_mid` VARCHAR(512) COMMENT 'LINE上の内部的な識別子',
	`qr_key` VARCHAR(64)  NOT NULL COMMENT 'QRコードのランダム値',
	`qr_image_file` VARCHAR(255)  NOT NULL COMMENT 'QRコード画像ファイル名',
	`call1_at` DATETIME COMMENT '1回目呼出日時',
	`call2_at` DATETIME COMMENT '2回目呼出日時',
	`call3_at` DATETIME COMMENT '3回目呼出日時',
	`mobile_access_at` DATETIME COMMENT '携帯アクセス日時',
	`auth_at` DATETIME COMMENT '認証日時',
	`original_created_at` DATETIME  NOT NULL COMMENT '移動前の作成日時',
	`original_updated_at` DATETIME  NOT NULL COMMENT '移動前の更新日時',
	`created_at` DATETIME  NOT NULL COMMENT '作成日時',
	`updated_at` DATETIME  NOT NULL COMMENT '更新日時',
	PRIMARY KEY (`id`),
	KEY `index_receive_id`(`receive_id`),
	KEY `idx_create_at`(`original_created_at`),
	KEY `index_auth_status`(`auth_status`)
) COMMENT='QRコール履歴';

#-----------------------------------------------------------------------------
#-- qr_call_mail_templete
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `qr_call_mail_templete`;


CREATE TABLE `qr_call_mail_templete`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID',
	`call_delivery_type` TINYINT UNSIGNED default 0 NOT NULL COMMENT 'コール配信種別',
	`call_number` TINYINT default 1 NOT NULL COMMENT 'N回目の呼び出しに使用',
	`sender` VARCHAR(64)  NOT NULL COMMENT '送信者',
	`subject` VARCHAR(64)  NOT NULL COMMENT '件名',
	`text` TEXT  NOT NULL COMMENT '本文',
	`created_at` DATETIME  NOT NULL COMMENT '作成日時',
	`updated_at` DATETIME  NOT NULL COMMENT '更新日時',
	PRIMARY KEY (`id`),
	UNIQUE KEY `call_mail_templete_uniq` (`shop_id`, `call_delivery_type`, `call_number`),
	KEY `index_shop_id`(`shop_id`),
	KEY `index_call_number`(`call_number`)
) COMMENT='呼出メール内容';

#-----------------------------------------------------------------------------
#-- qr_call_mail_templete2
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `qr_call_mail_templete2`;


CREATE TABLE `qr_call_mail_templete2`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID',
	`call_number` TINYINT default 1 NOT NULL COMMENT 'N回目の呼び出しに使用',
	`sender` VARCHAR(64)  NOT NULL COMMENT '送信者',
	`subject` VARCHAR(64)  NOT NULL,
	`text` TEXT  NOT NULL,
	`created_at` DATETIME  NOT NULL COMMENT '作成日時',
	`updated_at` DATETIME  NOT NULL COMMENT '更新日時',
	PRIMARY KEY (`id`),
	UNIQUE KEY `call_mail_templete2_uniq` (`shop_id`, `call_number`),
	KEY `index_shop_id`(`shop_id`),
	KEY `index_call_number`(`call_number`)
) COMMENT='作業完了メール文言設定';

#-----------------------------------------------------------------------------
#-- qr_call_assess
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `qr_call_assess`;


CREATE TABLE `qr_call_assess`
(
	`receive_id` BIGINT  NOT NULL COMMENT '予約受付データID',
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ＩＤ',
	`calls1_at` DATETIME COMMENT '査定完了時呼出日時',
	`calls2_at` DATETIME COMMENT '査定完了後QR呼出日時',
	`calls3_at` DATETIME COMMENT '不在無断キャンセルQR呼出日時',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`receive_id`),
	KEY `index_shop_id`(`shop_id`)
) COMMENT='査定店舗用 QR履歴';

#-----------------------------------------------------------------------------
#-- qr_call_member_regist
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `qr_call_member_regist`;


CREATE TABLE `qr_call_member_regist`
(
	`qr_call_id` INTEGER  NOT NULL COMMENT 'qr_call_id',
	`mobile_uid` VARCHAR(30) COMMENT '携帯電話のUID',
	`mail` VARCHAR(255) COMMENT 'メールアドレス',
	`receive_mail_magazine` TINYINT default 0 NOT NULL COMMENT 'メールマガジンを受け取る 0:受け取らない, 1:受け取る',
	`member_regist_selected` TINYINT default 0 NOT NULL COMMENT '会員登録選択状態 0:会員登録しない, 1:会員登録する',
	`created_at` DATETIME  NOT NULL COMMENT '作成日時',
	`updated_at` DATETIME  NOT NULL COMMENT '更新日時',
	PRIMARY KEY (`qr_call_id`),
	KEY `index_mobile_uid`(`mobile_uid`),
	KEY `index_receive_mail_magazine_id`(`receive_mail_magazine`)
) COMMENT='QR呼出会員登録';

#-----------------------------------------------------------------------------
#-- mobile_information
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `mobile_information`;


CREATE TABLE `mobile_information`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	`entry_name` VARCHAR(30) default 'EPARK運営事務局' NOT NULL COMMENT '設定者名',
	`information_type` VARCHAR(20)  NOT NULL COMMENT 'お知らせ種別(強調表示) 例）お知らせ、障害情報 等',
	`title` VARCHAR(100)  NOT NULL COMMENT 'タイトル',
	`body` TEXT  NOT NULL COMMENT '本文',
	`display_start` DATE  NOT NULL COMMENT '表示開始日',
	`display_end` DATE  NOT NULL COMMENT '表示終了日',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	KEY `index_display_start`(`display_start`),
	KEY `index_display_end`(`display_end`)
) COMMENT='お知らせ';

#-----------------------------------------------------------------------------
#-- pc_information
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `pc_information`;


CREATE TABLE `pc_information`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	`title` VARCHAR(100)  NOT NULL COMMENT 'タイトル',
	`body` TEXT  NOT NULL COMMENT '本文',
	`display_start` DATE  NOT NULL COMMENT '表示開始日',
	`display_end` DATE  NOT NULL COMMENT '表示終了日',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	KEY `index_display_start`(`display_start`),
	KEY `index_display_end`(`display_end`)
) COMMENT='PC お知らせ';

#-----------------------------------------------------------------------------
#-- questionnaire
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `questionnaire`;


CREATE TABLE `questionnaire`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	`member_id` INTEGER  NOT NULL COMMENT '会員ID',
	`questionnaire_type_id` TINYINT  NOT NULL COMMENT 'タイプ',
	`question_1` VARCHAR(100) COMMENT '質問1',
	`answer_1` VARCHAR(300) COMMENT '回答1',
	`question_2` VARCHAR(100) COMMENT '質問2',
	`answer_2` VARCHAR(300) COMMENT '回答2',
	`question_3` VARCHAR(100) COMMENT '質問3',
	`answer_3` VARCHAR(300) COMMENT '回答3',
	`question_4` VARCHAR(100) COMMENT '質問4',
	`answer_4` VARCHAR(300) COMMENT '回答4',
	`question_5` VARCHAR(100) COMMENT '質問5',
	`answer_5` VARCHAR(300) COMMENT '回答5',
	`user_agent` VARCHAR(200) COMMENT '携帯エージェント',
	`receipt_data` DATETIME COMMENT '受付時間',
	`is_deleted` TINYINT default 0 COMMENT '削除フラグ 0:有効データ 1：削除済 ',
	`created_at` DATETIME COMMENT '作成日時',
	`updated_at` DATETIME COMMENT '更新日時',
	PRIMARY KEY (`id`),
	KEY `index_receipt_data`(`receipt_data`),
	KEY `index_questionnaire_type_id`(`questionnaire_type_id`),
	KEY `index_is_deleted`(`is_deleted`)
) COMMENT='アンケート(質問・回答)';

#-----------------------------------------------------------------------------
#-- questionnaire_type
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `questionnaire_type`;


CREATE TABLE `questionnaire_type`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	`name` VARCHAR(40)  NOT NULL,
	`created_at` DATETIME COMMENT '作成日時',
	`updated_at` DATETIME COMMENT '更新日時',
	PRIMARY KEY (`id`)
) COMMENT='アンケート(質問・回答)';

#-----------------------------------------------------------------------------
#-- shop_member_medical
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `shop_member_medical`;


CREATE TABLE `shop_member_medical`
(
	`id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT '自動生成プライマリキー',
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID',
	`member_id` INTEGER  NOT NULL COMMENT '会員ID',
	`sufferer_name` VARCHAR(255)  NOT NULL COMMENT '患者名',
	`registration_no` VARCHAR(255)  NOT NULL COMMENT '診察券番号',
	`status` TINYINT default 1 NOT NULL COMMENT 'ステータス 0: 運用 1: 運用停止',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	KEY `index_member_id`(`member_id`),
	INDEX `shop_member_medical_FI_1` (`shop_id`)
) COMMENT='EPARK MEDICAL店舗の会員関連テーブル 会員がEPARK MEDICAL店舗に登録していることを表す';

#-----------------------------------------------------------------------------
#-- receive_api_metadata
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `receive_api_metadata`;


CREATE TABLE `receive_api_metadata`
(
	`receive_id` INTEGER  NOT NULL COMMENT '予約ID',
	`track_no` INTEGER  NOT NULL COMMENT 'トラックNo（API利用側予約外部キー）',
	`track_no_date` DATE COMMENT 'トラックNo発行日（予約日）',
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID',
	`department_id` INTEGER default 0 NOT NULL COMMENT '部門ID',
	`wait_order` INTEGER default 0 NOT NULL COMMENT '並び順',
	`wait_minutes` INTEGER default 0 NOT NULL COMMENT '予想待ち時間',
	`calling_flag` TINYINT default 0 NOT NULL COMMENT '呼出中 0:通常 1:呼出中 ※このフラグがついている「不在」情報は、APIで特殊処理を行う。→ 同一部門で「呼出中」の情報があれば、それは新規の「呼出」ですべて「案内済み」となる。また、携帯サイトでの予約表記も修正',
	`is_sent` TINYINT default 0 NOT NULL COMMENT 'データ送信フラグ 0:未送信 1:送信済み',
	`cancel_retry_flag` TINYINT default 0 NOT NULL COMMENT 'キャンセルリトライフラグ 0:正常 1:キャンセルリトライ中',
	`cancel_retry_count` INTEGER default 0 NOT NULL COMMENT 'キャンセルリトライ回数',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`receive_id`),
	KEY `index_track_no`(`track_no`),
	KEY `index_shop_id`(`shop_id`),
	KEY `index_is_sent`(`is_sent`),
	KEY `index_cancel_retry_flag`(`cancel_retry_flag`)
) COMMENT='API機能予約付加情報';

#-----------------------------------------------------------------------------
#-- shop_api_info
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `shop_api_info`;


CREATE TABLE `shop_api_info`
(
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID',
	`secret_key` VARCHAR(40)  NOT NULL COMMENT 'パスワード API用（secret_key）',
	`api_type` TINYINT default 1 NOT NULL COMMENT 'API利用形態 1: EPARK APIのみ 2: 発券機主体（Vessel） 3: 発券機主体（Billcon）',
	`wait_time_type` TINYINT default 1 NOT NULL COMMENT '待ち時間計算主体 1: EPARK 2: 発券機',
	`foreign_api_url_base` VARCHAR(255) default '' NOT NULL COMMENT '外部API 基礎URL',
	`mobile_display_flag_member_registration` TINYINT default 0 NOT NULL COMMENT '会員登録表示設定 0:表示する 1:表示しない',
	`mobile_display_flag_reserve` TINYINT default 0 NOT NULL COMMENT '予約表示設定 0:表示する 1:表示しない',
	`mobile_expression_flag_shop` TINYINT default 0 NOT NULL COMMENT '「店舗」表現設定 0:デフォルト（「店舗」） 1:手動設定',
	`mobile_expression_text_shop` VARCHAR(255) default '' NOT NULL COMMENT '「店舗」表現テキスト',
	`mobile_expression_flag_business_hours` TINYINT default 0 NOT NULL COMMENT '「営業時間」表現設定 0:デフォルト（「営業時間」） 1:手動設定',
	`mobile_expression_text_business_hours` VARCHAR(255) default '' NOT NULL COMMENT '「営業時間」表現テキスト',
	`mobile_expression_flag_wait_order_unit` TINYINT default 0 NOT NULL COMMENT '待ち組数単位（組）表現設定  0:デフォルト（「組」） 1:手動設定',
	`mobile_expression_text_wait_order_unit` VARCHAR(255) default '' NOT NULL COMMENT '待ち組数単位（組）表現テキスト',
	`last_regularly_update_date` DATETIME COMMENT '定期更新最終日時',
	`failure_flag` TINYINT default 0 NOT NULL COMMENT '障害フラグ 0:正常 1:障害発生',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`shop_id`)
) COMMENT='API利用店舗の追加情報';

#-----------------------------------------------------------------------------
#-- shop_reserve_department_api_info
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `shop_reserve_department_api_info`;


CREATE TABLE `shop_reserve_department_api_info`
(
	`shop_reserve_department_id` BIGINT  NOT NULL COMMENT '部門ID',
	`job_id` VARCHAR(255) default '' NOT NULL COMMENT '業務ID',
	`reserve_type` TINYINT default 0 NOT NULL COMMENT '予約形態設定 0:順番待ち 1:時間指定',
	`stop_flag` TINYINT default 0 NOT NULL COMMENT '受付停止設定（臨時停止） 0:受付中 1:停止中',
	`open_flag_info` TINYINT default 1 NOT NULL COMMENT '携帯サイト「開示」設定 0:開示しない 1:開示する',
	`open_flag_reserve` TINYINT default 1 NOT NULL COMMENT '「予約受付」設定 0:表示しない 1:表示する',
	`required_flag_name` TINYINT default 0 NOT NULL COMMENT '追加必須項目設定 「お名前」 0:不要（デフォルト） 1:必須',
	`required_flag_tel` TINYINT default 0 NOT NULL COMMENT '追加必須項目設定 「お電話番号」 0:不要（デフォルト） 1:必須',
	`closed_sunday` TINYINT default 0 NOT NULL COMMENT '日曜休止かどうか 0:受付 1:休業',
	`closed_monday` TINYINT default 0 NOT NULL COMMENT '月曜休止かどうか 0:受付 1:休業',
	`closed_tuesday` TINYINT default 0 NOT NULL COMMENT '火曜休止かどうか 0:受付 1:休業',
	`closed_wednesday` TINYINT default 0 NOT NULL COMMENT '水曜休止かどうか 0:受付 1:休業',
	`closed_thursday` TINYINT default 0 NOT NULL COMMENT '木曜休止かどうか 0:受付 1:休業',
	`closed_friday` TINYINT default 0 NOT NULL COMMENT '金曜休止かどうか 0:受付 1:休業',
	`closed_saturday` TINYINT default 0 NOT NULL COMMENT '土曜休止かどうか 0:受付 1:休業',
	`closed_holiday` TINYINT default 0 NOT NULL COMMENT '祝日休止かどうか 0:受付 1:休業',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`shop_reserve_department_id`)
) COMMENT='API利用店舗の部門別設定情報  ※ 外部向きにつき、フラグの0/1を一般的（と思われる）値で統一 （※ → EPARKの標準とは肯定／否定のニュアンスが逆になっているので要注意）';

#-----------------------------------------------------------------------------
#-- shop_reserve_department_timeset
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `shop_reserve_department_timeset`;


CREATE TABLE `shop_reserve_department_timeset`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID',
	`shop_reserve_department_id` INTEGER  NOT NULL COMMENT '部門ID',
	`set_number` TINYINT default 0 NOT NULL COMMENT '設定パターン(日の分類) 0:デフォルト（固定）',
	`open1_start` TIME  NOT NULL COMMENT '受付時間1の開始時間',
	`open1_close` TIME  NOT NULL COMMENT '受付時間1の終了時間',
	`open2_start` TIME COMMENT '受付時間2の開始時間',
	`open2_close` TIME COMMENT '受付時間2の終了時間',
	`open3_start` TIME COMMENT '受付時間3の開始時間',
	`open3_close` TIME COMMENT '受付時間3の終了時間',
	`order_stop` INTEGER default 0 NOT NULL COMMENT '受付終了時間',
	`open24` TINYINT default 0 NOT NULL COMMENT '24時間受付 1:24時間受付 0:24時間受付ではない',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`)
) COMMENT='部門別の受付時間情報';

#-----------------------------------------------------------------------------
#-- shop_cooperation_info
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `shop_cooperation_info`;


CREATE TABLE `shop_cooperation_info`
(
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID',
	`login_token_name` VARCHAR(255) default '' NOT NULL COMMENT 'ログイントークン名',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`shop_id`)
) COMMENT='外部連携店舗の追加情報（ログイントークン名等）';

#-----------------------------------------------------------------------------
#-- shop_introduction
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `shop_introduction`;


CREATE TABLE `shop_introduction`
(
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID',
	`header` VARCHAR(255) default '' NOT NULL COMMENT '見出し',
	`introduction` TEXT COMMENT '紹介文',
	`image` VARCHAR(255) default '' NOT NULL COMMENT 'TOP画像',
	`zip_code` VARCHAR(8) default '' NOT NULL COMMENT '郵便番号（ハイフン許容）',
	`tel` VARCHAR(20) default '' NOT NULL COMMENT '電話番号（ハイフン許容）',
	`courses` VARCHAR(255) default '' NOT NULL COMMENT 'コース(診療科目)',
	`business_hours` VARCHAR(255) default '' NOT NULL COMMENT '営業時間(診療時間)',
	`holidays` VARCHAR(255) default '' NOT NULL COMMENT '休業日(休診日)',
	`comment` TEXT COMMENT '備考',
	`tab2_display_flag` TINYINT default 0 NOT NULL COMMENT 'タブ2表示フラグ 0:表示 1:非表示',
	`tab3_display_flag` TINYINT default 0 NOT NULL COMMENT 'タブ3表示フラグ 0:表示 1:非表示',
	`tab3_header` VARCHAR(255) default '' NOT NULL COMMENT 'タブ3ヘッダテキスト',
	PRIMARY KEY (`shop_id`)
) COMMENT='施設紹介情報。EPARK MEDICAL店舗（全医療系施設）で利用';

#-----------------------------------------------------------------------------
#-- shop_introduction_descriptions
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `shop_introduction_descriptions`;


CREATE TABLE `shop_introduction_descriptions`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT COMMENT '自動生成プライマリキー',
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID',
	`type` VARCHAR(2) default 'A' NOT NULL COMMENT '詳細タイプ (A: スタッフ紹介, B: スタッフ紹介追加情報, C: 任意項目)',
	`display_order` INTEGER default 1 NOT NULL COMMENT '表示順',
	`header` VARCHAR(255) default '' NOT NULL COMMENT '見出し',
	`text` TEXT COMMENT 'テキスト',
	`image` VARCHAR(255) default '' NOT NULL COMMENT '画像',
	PRIMARY KEY (`id`),
	INDEX `shop_introduction_descriptions_FI_1` (`shop_id`)
) COMMENT='施設紹介 詳細情報。EPARK MEDICAL店舗（全医療系施設）で利用';

#-----------------------------------------------------------------------------
#-- delivery_order
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `delivery_order`;


CREATE TABLE `delivery_order`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT COMMENT '自動生成プライマリキー',
	`delivery_order_name` VARCHAR(40)  NOT NULL COMMENT '配信オーダー名（4-40文字）',
	`client_name` VARCHAR(20) COMMENT 'クライアント名（20文字以内）',
	`delivery_status` TINYINT  NOT NULL COMMENT '配信ステータス 0:待機中 1:配信中 2:一時停止 3:完了 9:削除',
	`post_datetime_start` DATETIME  NOT NULL COMMENT '掲載開始日',
	`post_datetime_end` DATETIME  NOT NULL COMMENT '掲載終了日',
	`button_type` TINYINT  NOT NULL COMMENT 'ボタン項目 0:応募する（先着順） 1:応募する（抽選） 2:自由入力（6文字以内） 3:購入する',
	`button_display` VARCHAR(6) COMMENT '自由入力の場合のボタン項目名',
	`announcement_date` DATETIME COMMENT '応募する（抽選）の場合の発表日',
	`is_lotted` TINYINT default 0 NOT NULL COMMENT '応募する（抽選）の場合の抽選済みフラグ 0:未抽選 1:抽選済',
	`application_datetime_start` DATETIME  NOT NULL COMMENT '応募開始日',
	`application_datetime_end_type` TINYINT  NOT NULL COMMENT '応募終了日 0:掲載終了日と同じ 1:発行枚数完了と同時に終了する',
	`tie_up_id_1` INTEGER  NOT NULL COMMENT 'タイアップ1（なしの場合は0）',
	`tie_up_1_sentence` TINYINT  NOT NULL COMMENT '文言のON/OFF 0:OFF 1:ON',
	`tie_up_1_button` TINYINT  NOT NULL COMMENT '次へボタンのON/OFF 0:OFF 1:ON',
	`tie_up_id_2` INTEGER  NOT NULL COMMENT 'タイアップ2（なしの場合は0）',
	`publication_num` INTEGER  NOT NULL COMMENT '発行枚数',
	`publication_num_display` TINYINT  NOT NULL COMMENT '発行枚数の残存数 0:表示しない 1:表示する',
	`publication_all_num_display` TINYINT default 1 NOT NULL COMMENT '発行枚数総数 0:表示しない 1:表示する',
	`remainder_num` INTEGER  NOT NULL COMMENT '残存数',
	`post_item` VARCHAR(200)  NOT NULL COMMENT '掲載品目',
	`introduction` TEXT  NOT NULL COMMENT '導入部分',
	`detail` TEXT  NOT NULL COMMENT '詳細',
	`how_to_use` VARCHAR(1024) COMMENT '利用方法',
	`mypage_post_flg` TINYINT  NOT NULL COMMENT 'マイページ掲載フラグ 0:OFF 1:ON',
	`touch_panel_ticket` TINYINT  NOT NULL COMMENT '店頭端末発券 0:利用しない 1:利用する',
	`utilizable_shop` TINYINT  NOT NULL COMMENT '利用可能施設 0:全店舗 1:一部',
	`utilizable_shop_ids` TEXT COMMENT '利用可能施設ID',
	`utilizable_shop_id_not` TINYINT COMMENT '利用可能施設IDの値に含まれない店舗を対象とする',
	`member_type` TINYINT  NOT NULL COMMENT '利用可能会員 0:クーポン会員のみ 1:全員 2:友達紹介 3:初回特典',
	`available_period_start` DATE  NOT NULL COMMENT '有効期間開始日',
	`available_period_end` DATE  NOT NULL COMMENT '有効期間終了日',
	`ticket_possible_time_start` TIME COMMENT '発券可能時間帯開始',
	`ticket_possible_time_end` TIME COMMENT '発券可能時間帯終了',
	`use_max_num` INTEGER  NOT NULL COMMENT '利用回数上限',
	`use_max_num_display` TINYINT default 1 NOT NULL COMMENT '利用回数の表示 0:表示しない 1:表示する',
	`coupon_text` VARCHAR(1024)  NOT NULL COMMENT 'クーポン内容',
	`precaution` VARCHAR(1024)  NOT NULL COMMENT '注意事項',
	`memo` VARCHAR(255) COMMENT '管理者用メモ',
	`random_key` VARCHAR(32)  NOT NULL COMMENT 'リンクURL用ランダムキー(配信オーダー名＋現在日時のハッシュ)',
	`target_sex` TINYINT  NOT NULL COMMENT '対象会員性別 0: 男性 1: 女性 -1:指定しない',
	`target_age_from` TINYINT  NOT NULL COMMENT '対象会員年齢（から） -1:指定しない',
	`target_age_to` TINYINT  NOT NULL COMMENT '対象会員年齢（まで） -1:指定しない',
	`target_birth_m` SMALLINT  NOT NULL COMMENT '対象会員誕生日（月） -1:指定しない',
	`target_pref_id` VARCHAR(255)  NOT NULL COMMENT '対象会員都道府県ID -1:指定しない',
	`target_docomo` TINYINT  NOT NULL COMMENT 'DoCoMoユーザーが対象か否か',
	`target_au` TINYINT  NOT NULL COMMENT 'auユーザーが対象か否か',
	`target_softbank` TINYINT  NOT NULL COMMENT 'SoftBankユーザーが対象か否か',
	`target_willcom` TINYINT  NOT NULL COMMENT 'WILLCOMユーザーが対象か否か',
	`coupon_number_status` TINYINT default 1 NOT NULL COMMENT 'クーポンを番号表示 設定 0:非表示 1:表示',
	`coupon_mobile_exchange_button_status` TINYINT default 0 NOT NULL COMMENT 'クーポンを使用済にするボタンの表示 設定 0:非表示 1:表示',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	KEY `index_delivery_status`(`delivery_status`),
	KEY `index_post_datetime_start`(`post_datetime_start`),
	KEY `index_post_datetime_end`(`post_datetime_end`),
	KEY `index_button_type`(`button_type`),
	KEY `index_application_datetime_start`(`application_datetime_start`),
	KEY `index_mypage_post_flg`(`mypage_post_flg`),
	KEY `index_touch_panel_ticket`(`touch_panel_ticket`),
	KEY `index_target_sex`(`target_sex`),
	KEY `index_target_age_from`(`target_age_from`),
	KEY `index_target_age_to`(`target_age_to`),
	KEY `index_target_birth_m`(`target_birth_m`),
	KEY `index_target_pref_id`(`target_pref_id`),
	KEY `index_target_docomo`(`target_docomo`),
	KEY `index_target_au`(`target_au`),
	KEY `index_target_softbank`(`target_softbank`),
	KEY `index_target_willcom`(`target_willcom`),
	KEY `index_created_at`(`created_at`),
	KEY `index_random_key`(`random_key`)
) COMMENT='配信オーダーデータ格納テーブル';

#-----------------------------------------------------------------------------
#-- tie_up
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `tie_up`;


CREATE TABLE `tie_up`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT COMMENT '自動生成プライマリキー',
	`creative_name` VARCHAR(40)  NOT NULL COMMENT 'クリエイティブ名',
	`client_name` VARCHAR(20)  NOT NULL COMMENT 'クライアント名',
	`ad_type` TINYINT  NOT NULL COMMENT '広告タイプ',
	`status` TINYINT  NOT NULL COMMENT '状態',
	`post_type` TINYINT  NOT NULL COMMENT '掲載タイプ',
	`post_limit` TINYINT default 0 NOT NULL COMMENT '投稿回数 0:1回のみ投稿 1:複数回投稿',
	`use_photo` TINYINT default 0 NOT NULL COMMENT '写真投稿',
	`photo_disp_text_status` TINYINT default 0 NOT NULL COMMENT '写真投稿表示文言ステータス',
	`photo_disp_text` TEXT COMMENT '写真投稿表示文言',
	`pv` BIGINT(20) default 0 NOT NULL COMMENT 'ページビュー',
	`questionnaire_name` VARCHAR(255) default '' COMMENT 'アンケート名称',
	`questionnaire_notes` VARCHAR(1000) default '' COMMENT '注釈',
	`button_label` VARCHAR(255) default '割引券をもらう' COMMENT '応募リンクボタン',
	`disp_text_status` TINYINT default 0 NOT NULL COMMENT '表示文言ステータス',
	`disp_text` TEXT default '' COMMENT '表示文言',
	`entry_link_status` TINYINT default 0 NOT NULL COMMENT '応募リンクURLステータス',
	`entry_link_url` VARCHAR(300) default 'http://e.mbtn.jp/member/couponList' COMMENT '応募リンクURL',
	`use_send_mail` TINYINT default 0 NOT NULL COMMENT '投稿完了メール送信可否',
	`use_send_mail_template_id` INTEGER default 0 COMMENT '投稿完了メールテンプレートID',
	`photo_essential_status` TINYINT default 0 COMMENT '写真投稿必須フラグ 0:未必須 1:必須',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	KEY `index_ad_type`(`ad_type`),
	KEY `index_post_type`(`post_type`)
);

#-----------------------------------------------------------------------------
#-- creative_parts
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `creative_parts`;


CREATE TABLE `creative_parts`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT COMMENT '自動生成プライマリキー',
	`tie_up_id` INTEGER  NOT NULL COMMENT 'タイアップID',
	`field_id` TINYINT  NOT NULL COMMENT 'フィールドID',
	`input_value` TEXT COMMENT '入力値',
	`url` VARCHAR(1000) COMMENT 'リンクを使用する場合',
	`display_order` TINYINT COMMENT '表示順',
	PRIMARY KEY (`id`),
	KEY `index_tie_up_id`(`tie_up_id`),
	KEY `index_field_id`(`field_id`),
	KEY `index_display_order`(`display_order`)
) COMMENT='クリエイティブ詳細（ノーマルタイプ）データ格納テーブル';

#-----------------------------------------------------------------------------
#-- creative_parts_questionnaire_category
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `creative_parts_questionnaire_category`;


CREATE TABLE `creative_parts_questionnaire_category`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT COMMENT '自動生成プライマリキー',
	`tie_up_id` INTEGER  NOT NULL COMMENT 'タイアップID',
	`name` VARCHAR(255) default '' NOT NULL COMMENT 'カテゴリ名称',
	`description` VARCHAR(1000) default '' NOT NULL COMMENT 'カテゴリ補足テキスト',
	`display_order` TINYINT default 0 NOT NULL COMMENT '表示順',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	UNIQUE KEY `creative_parts_questionnaire_category_uniq` (`tie_up_id`, `display_order`),
	KEY `index_tie_up_id`(`tie_up_id`),
	KEY `index_display_order`(`display_order`)
) COMMENT='クリエイティブ詳細（アンケートタイプ） アンケートカテゴリ';

#-----------------------------------------------------------------------------
#-- creative_parts_questionnaire_question
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `creative_parts_questionnaire_question`;


CREATE TABLE `creative_parts_questionnaire_question`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT COMMENT '自動生成プライマリキー',
	`tie_up_id` INTEGER default 0 NOT NULL COMMENT 'タイアップID',
	`category_id` INTEGER default 0 NOT NULL COMMENT 'アンケートカテゴリID',
	`question` VARCHAR(500) default '' NOT NULL COMMENT '設問内容',
	`answer_type` TINYINT default 0 NOT NULL COMMENT '回答形式',
	`required_flag` TINYINT default 0 NOT NULL COMMENT '必須項目フラグ',
	`display_order` TINYINT default 0 NOT NULL COMMENT '表示順',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	UNIQUE KEY `creative_parts_questionnaire_question_uniq` (`category_id`, `display_order`),
	KEY `index_tie_up_id`(`tie_up_id`),
	KEY `index_category_id`(`category_id`),
	KEY `index_display_order`(`display_order`)
) COMMENT='クリエイティブ詳細（アンケートタイプ） アンケート設問';

#-----------------------------------------------------------------------------
#-- creative_parts_questionnaire_question_choice
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `creative_parts_questionnaire_question_choice`;


CREATE TABLE `creative_parts_questionnaire_question_choice`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT COMMENT '自動生成プライマリキー',
	`question_id` INTEGER default 0 NOT NULL COMMENT 'アンケート設問ID',
	`choice` VARCHAR(255) default '' NOT NULL COMMENT '設問内容',
	`display_order` TINYINT default 0 NOT NULL COMMENT '表示順',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	UNIQUE KEY `creative_parts_questionnaire_question_choice_uniq` (`question_id`, `display_order`),
	KEY `index_question_id`(`question_id`),
	KEY `index_display_order`(`display_order`)
) COMMENT='クリエイティブ詳細（アンケートタイプ） アンケート選択肢';

#-----------------------------------------------------------------------------
#-- creative_parts_questionnaire_answer
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `creative_parts_questionnaire_answer`;


CREATE TABLE `creative_parts_questionnaire_answer`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT COMMENT '自動生成プライマリキー',
	`delivery_order_id` INTEGER default 0 NOT NULL COMMENT '配信オーダーID',
	`tie_up_id` INTEGER default 0 NOT NULL COMMENT 'タイアップID',
	`member_id` INTEGER default 0 NOT NULL COMMENT '会員ID',
	`receipt_date` DATETIME  NOT NULL COMMENT '回答日時',
	`question_1` VARCHAR(500) default '' NOT NULL COMMENT '設問内容1',
	`answer_1` TEXT COMMENT '回答テキスト1',
	`question_2` VARCHAR(500) default '' NOT NULL COMMENT '設問内容2',
	`answer_2` TEXT COMMENT '回答テキスト2',
	`question_3` VARCHAR(500) default '' NOT NULL COMMENT '設問内容3',
	`answer_3` TEXT COMMENT '回答テキスト3',
	`question_4` VARCHAR(500) default '' NOT NULL COMMENT '設問内容4',
	`answer_4` TEXT COMMENT '回答テキスト4',
	`question_5` VARCHAR(500) default '' NOT NULL COMMENT '設問内容5',
	`answer_5` TEXT COMMENT '回答テキスト5',
	`question_6` VARCHAR(500) default '' NOT NULL COMMENT '設問内容6',
	`answer_6` TEXT COMMENT '回答テキスト6',
	`question_7` VARCHAR(500) default '' NOT NULL COMMENT '設問内容7',
	`answer_7` TEXT COMMENT '回答テキスト7',
	`question_8` VARCHAR(500) default '' NOT NULL COMMENT '設問内容8',
	`answer_8` TEXT COMMENT '回答テキスト8',
	`question_9` VARCHAR(500) default '' NOT NULL COMMENT '設問内容9',
	`answer_9` TEXT COMMENT '回答テキスト9',
	`question_10` VARCHAR(500) default '' NOT NULL COMMENT '設問内容10',
	`answer_10` TEXT COMMENT '回答テキスト10',
	`question_11` VARCHAR(500) default '' NOT NULL COMMENT '設問内容11',
	`answer_11` VARCHAR(128) default '' COMMENT '回答テキスト11',
	`question_12` VARCHAR(500) default '' NOT NULL COMMENT '設問内容12',
	`answer_12` VARCHAR(128) default '' COMMENT '回答テキスト12',
	`question_13` VARCHAR(500) default '' NOT NULL COMMENT '設問内容13',
	`answer_13` TEXT COMMENT '回答テキスト13',
	`question_14` VARCHAR(500) default '' NOT NULL COMMENT '設問内容14',
	`answer_14` VARCHAR(128) default '' COMMENT '回答テキスト14',
	`question_15` VARCHAR(500) default '' NOT NULL COMMENT '設問内容15',
	`answer_15` TEXT default '' COMMENT '回答テキスト15',
	`question_16` VARCHAR(500) default '' NOT NULL COMMENT '設問内容16',
	`answer_16` VARCHAR(128) default '' COMMENT '回答テキスト16',
	`question_17` VARCHAR(500) default '' NOT NULL COMMENT '設問内容17',
	`answer_17` TEXT default '' COMMENT '回答テキスト17',
	`question_18` VARCHAR(500) default '' NOT NULL COMMENT '設問内容18',
	`answer_18` VARCHAR(128) default '' COMMENT '回答テキスト18',
	`question_19` VARCHAR(500) default '' NOT NULL COMMENT '設問内容19',
	`answer_19` VARCHAR(128) default '' COMMENT '回答テキスト19',
	`question_20` VARCHAR(500) default '' NOT NULL COMMENT '設問内容20',
	`answer_20` TEXT default '' COMMENT '回答テキスト20',
	`question_21` VARCHAR(500) default '' NOT NULL COMMENT '設問内容21',
	`answer_21` VARCHAR(128) default '' COMMENT '回答テキスト21',
	`question_22` VARCHAR(500) default '' NOT NULL COMMENT '設問内容22',
	`answer_22` TEXT default '' COMMENT '回答テキスト22',
	`question_23` VARCHAR(500) default '' NOT NULL COMMENT '設問内容23',
	`answer_23` VARCHAR(128) default '' COMMENT '回答テキスト23',
	`question_24` VARCHAR(500) default '' NOT NULL COMMENT '設問内容24',
	`answer_24` VARCHAR(128) default '' COMMENT '回答テキスト24',
	`question_25` VARCHAR(500) default '' NOT NULL COMMENT '設問内容25',
	`answer_25` TEXT default '' COMMENT '回答テキスト25',
	`question_26` VARCHAR(500) default '' NOT NULL COMMENT '設問内容26',
	`answer_26` VARCHAR(128) default '' COMMENT '回答テキスト26',
	`question_27` VARCHAR(500) default '' NOT NULL COMMENT '設問内容27',
	`answer_27` VARCHAR(128) default '' COMMENT '回答テキスト27',
	`question_28` VARCHAR(500) default '' NOT NULL COMMENT '設問内容28',
	`answer_28` VARCHAR(128) default '' COMMENT '回答テキスト28',
	`question_29` VARCHAR(500) default '' NOT NULL COMMENT '設問内容29',
	`answer_29` VARCHAR(128) default '' COMMENT '回答テキスト29',
	`question_30` VARCHAR(500) default '' NOT NULL COMMENT '設問内容30',
	`answer_30` VARCHAR(128) default '' COMMENT '回答テキスト30',
	`question_31` VARCHAR(128) default '' NOT NULL COMMENT '設問内容31',
	`answer_31` VARCHAR(128) default '' COMMENT '回答テキスト31',
	`question_32` VARCHAR(128) default '' NOT NULL COMMENT '設問内容32',
	`answer_32` VARCHAR(128) default '' COMMENT '回答テキスト32',
	`question_33` VARCHAR(128) default '' NOT NULL COMMENT '設問内容33',
	`answer_33` VARCHAR(128) default '' COMMENT '回答テキスト33',
	`question_34` VARCHAR(128) default '' NOT NULL COMMENT '設問内容34',
	`answer_34` VARCHAR(128) default '' COMMENT '回答テキスト34',
	`question_35` VARCHAR(128) default '' NOT NULL COMMENT '設問内容35',
	`answer_35` VARCHAR(128) default '' COMMENT '回答テキスト35',
	`question_36` VARCHAR(128) default '' NOT NULL COMMENT '設問内容36',
	`answer_36` VARCHAR(128) default '' COMMENT '回答テキスト36',
	`question_37` VARCHAR(128) default '' NOT NULL COMMENT '設問内容37',
	`answer_37` VARCHAR(128) default '' COMMENT '回答テキスト37',
	`question_38` VARCHAR(128) default '' NOT NULL COMMENT '設問内容38',
	`answer_38` VARCHAR(128) default '' COMMENT '回答テキスト38',
	`question_39` VARCHAR(128) default '' NOT NULL COMMENT '設問内容39',
	`answer_39` VARCHAR(128) default '' COMMENT '回答テキスト39',
	`question_40` VARCHAR(128) default '' NOT NULL COMMENT '設問内容40',
	`answer_40` VARCHAR(128) default '' COMMENT '回答テキスト40',
	`epark_status` TINYINT(1) default 0 COMMENT 'EPARK導入0:未1:導入2:済',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	KEY `index_tie_up_id`(`tie_up_id`),
	KEY `index_member_id`(`member_id`)
) COMMENT='クリエイティブ詳細（アンケートタイプ） アンケート回答';

#-----------------------------------------------------------------------------
#-- coupon_lot
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `coupon_lot`;


CREATE TABLE `coupon_lot`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT COMMENT '抽選ID',
	`coupon_id` BIGINT(20)  NOT NULL COMMENT 'クーポンID',
	`member_id` INTEGER  NOT NULL COMMENT '会員ID',
	`lot` TINYINT(1) default 0 NOT NULL COMMENT '当選（1当選)',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	UNIQUE KEY `coupon_member_id` (`coupon_id`, `member_id`)
) COMMENT='クーポン抽選登録';

#-----------------------------------------------------------------------------
#-- unique_access
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `unique_access`;


CREATE TABLE `unique_access`
(
	`id` BIGINT(20)  NOT NULL AUTO_INCREMENT COMMENT 'アクセスID',
	`tie_up_id` INTEGER(11)  NOT NULL COMMENT 'タイアップID',
	`member_id` INTEGER(8)  NOT NULL COMMENT '会員ID',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	UNIQUE KEY `tie_up_member` (`tie_up_id`, `member_id`)
) COMMENT='タイアップページのURLのクリック数（ユニーク）';

#-----------------------------------------------------------------------------
#-- tie_up_mail_template
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `tie_up_mail_template`;


CREATE TABLE `tie_up_mail_template`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT COMMENT '自動生成プライマリキー',
	`sender` VARCHAR(64)  NOT NULL COMMENT '差出人',
	`subject` VARCHAR(60)  NOT NULL COMMENT 'メールタイトル',
	`text` TEXT  NOT NULL COMMENT 'メール本文',
	`memo` TEXT COMMENT '説明',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`)
);

#-----------------------------------------------------------------------------
#-- tie_up_mail_send_count
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `tie_up_mail_send_count`;


CREATE TABLE `tie_up_mail_send_count`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT COMMENT '自動生成プライマリキー',
	`delivery_order_id` INTEGER  NOT NULL COMMENT '配信オーダーID',
	`tie_up_id` INTEGER  NOT NULL COMMENT 'タイアップID',
	`send_count` INTEGER default 0 NOT NULL COMMENT 'メール送信回数',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	UNIQUE KEY `tie_up_mail_send_count_uniq` (`delivery_order_id`, `tie_up_id`)
);

#-----------------------------------------------------------------------------
#-- admin_edit_category
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `admin_edit_category`;


CREATE TABLE `admin_edit_category`
(
	`id` SMALLINT  NOT NULL AUTO_INCREMENT COMMENT '自動生成プライマリキー',
	`cd` VARCHAR(50)  NOT NULL COMMENT '大項目コード',
	`name` VARCHAR(100) COMMENT '名称',
	`display_order` SMALLINT COMMENT '表示順',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	UNIQUE KEY `admin_edit_category_U_1` (`cd`)
) COMMENT='変更箇所(大項目)';

#-----------------------------------------------------------------------------
#-- admin_edit_history
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `admin_edit_history`;


CREATE TABLE `admin_edit_history`
(
	`id` INTEGER(8)  NOT NULL AUTO_INCREMENT COMMENT '自動生成プライマリキー',
	`edit_type` INTEGER COMMENT '更新種別 1:追加 2:変更 3:削除',
	`history_date` DATETIME COMMENT '変更日時',
	`admin_user_id` INTEGER COMMENT '更新者ID(削除されている場合はnull)',
	`admin_user_name` VARCHAR(30) COMMENT '更新者',
	`shop_id` INTEGER COMMENT '店舗ID',
	`shop_name` VARCHAR(80) COMMENT '店舗名',
	`edit_category_id` SMALLINT  NOT NULL COMMENT '更新箇所(大項目)',
	`edit_items` TEXT COMMENT '更新箇所(小項目)CSVで保存',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	KEY `index_01`(`history_date`, `edit_category_id`),
	INDEX `admin_edit_history_FI_1` (`admin_user_id`),
	INDEX `admin_edit_history_FI_2` (`edit_category_id`)
) COMMENT='変更履歴';

#-----------------------------------------------------------------------------
#-- pay_member
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `pay_member`;


CREATE TABLE `pay_member`
(
	`id` BIGINT(20)  NOT NULL AUTO_INCREMENT COMMENT '自動生成プライマリキー',
	`member_id` INTEGER(8)  NOT NULL COMMENT '会員ID',
	`carrier_id` TINYINT  NOT NULL COMMENT '携帯キャリアID 1:DoCoMo 2:AU 3:Softbank 4:DoCoMo(spモード) 99:その他',
	`mobile_uid` VARCHAR(30)  NOT NULL COMMENT '携帯電話のUID',
	`option_type` INTEGER(8)  NOT NULL COMMENT '有料オプション種別 0:クーポンボックス1:EPARKコンシェル',
	`payment_method` TINYINT default 1 NOT NULL COMMENT '決済種別 1:キャリア決済 2:クレジット決済 3:auかんたん決済 4:ソフトバンクまとめて支払い',
	`status` TINYINT  NOT NULL COMMENT 'ステータス 0:新規 1:登録中 2:認証エラー 9:解約済み',
	`mail_status` TINYINT default 0 NOT NULL COMMENT '登録完了メール送信状況 0:未送信 1:送信済み',
	`registered_at` DATETIME COMMENT '登録時刻',
	`cancelled_at` DATETIME COMMENT '退会時刻',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	UNIQUE KEY `member_id_option_type` (`member_id`, `option_type`),
	UNIQUE KEY `carrier_id_member_id_mobile_uid_option_type` (`carrier_id`, `member_id`, `mobile_uid`, `option_type`),
	KEY `index_pay_member_1`(`option_type`, `status`)
) COMMENT='有料サービス認証状態';

#-----------------------------------------------------------------------------
#-- pay_member_credit
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `pay_member_credit`;


CREATE TABLE `pay_member_credit`
(
	`id` BIGINT(20)  NOT NULL AUTO_INCREMENT COMMENT '自動生成プライマリキー',
	`pay_member_id` BIGINT(20)  NOT NULL COMMENT '有料サービス認証状態ID',
	`member_id` INTEGER(8)  NOT NULL COMMENT '会員ID ※JOINを避けるための冗長',
	`option_type` INTEGER(8)  NOT NULL COMMENT '有料オプション種別 0:クーポンボックス1:EPARKコンシェル ※JOINを避けるための冗長',
	`gmo_member_id` VARCHAR(60)  NOT NULL COMMENT 'GMO会員ID',
	`gmo_order_id` VARCHAR(27)  NOT NULL COMMENT 'GMO取引ID',
	`transaction_id` INTEGER  NOT NULL COMMENT '登録時クレジット決済トランザクションID',
	`status` TINYINT  NOT NULL COMMENT 'ステータス 1:有効 9:無効',
	`registered_at` DATETIME  NOT NULL COMMENT '登録日時',
	`araigae_at` DATETIME COMMENT '洗替日時',
	`araigae_status` TINYINT default 0 NOT NULL COMMENT '洗替結果 0:未洗替 1:成功 2:失敗',
	`cancelled_at` DATETIME COMMENT '解除日時',
	`cancelled_comment` TEXT COMMENT '解除事由',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	UNIQUE KEY `gmo_order_id_uniq` (`gmo_order_id`),
	KEY `index_pay_member_id`(`pay_member_id`),
	KEY `index_member_id`(`member_id`),
	KEY `index_gmo_member_id`(`gmo_member_id`),
	KEY `index_status`(`status`)
) COMMENT='有料サービスクレジット決済情報（GMOペイメント登録情報）';

#-----------------------------------------------------------------------------
#-- coupon_box
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `coupon_box`;


CREATE TABLE `coupon_box`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT COMMENT '自動生成プライマリキー',
	`delivery_date` DATETIME  NOT NULL COMMENT '配信日',
	`shop_id` INTEGER COMMENT '店舗ID',
	`shop_name` VARCHAR(80)  NOT NULL COMMENT '店舗名',
	`title` VARCHAR(40)  NOT NULL COMMENT 'タイトル',
	`text` VARCHAR(2048)  NOT NULL COMMENT '本文',
	`coupon_text` VARCHAR(512) COMMENT '発券メッセージ内容',
	`coupon_box_member_status` TINYINT default 0 NOT NULL COMMENT '配信先IDテキスト指定状態 (0: 指定しない / 1: 指定する)',
	`status` TINYINT default 1 NOT NULL COMMENT '有効フラグ (0: 無効 / 1: 有効)',
	`display` TINYINT default 1 NOT NULL COMMENT '表示（表示/非表示）',
	`usable_persons_num` INTEGER default 0 NOT NULL COMMENT '利用可能回数（人数）',
	`usable_paymember_type` TINYINT default 1 NOT NULL COMMENT '使用可能な会員種別',
	`image_file_name` VARCHAR(30) COMMENT '画像ファイル名',
	`memo` VARCHAR(200) COMMENT 'メモ',
	`coupon_attribute` TINYINT default 0 NOT NULL COMMENT 'クーポン属性 0:従来クーポン 1:お知らせ 2:クーポン 3:プレミアムクーポン 4:共通クーポン',
	`display_mail_icon` TINYINT default 0 COMMENT 'メールアイコン表示(0:非表示 1:表示)',
	`display_coupon_icon` TINYINT default 0 COMMENT 'クーポンアイコン表示(0:非表示 1:表示)',
	`display_premium_coupon_icon` TINYINT default 0 COMMENT 'プレミアムクーポンアイコン表示(0:非表示 1:表示)',
	`coupon_category_id` INTEGER  NOT NULL COMMENT 'クーポンカテゴリID',
	`coupon_category_id_type` TINYINT COMMENT 'クーポンカテゴリID種別 0:店舗大カテゴリ 1:クーポンカテゴリ',
	`pref_id` INTEGER COMMENT '都道府県ID',
	`city_id` INTEGER COMMENT '市区町村ID',
	`address` VARCHAR(100) COMMENT '所在地：丁目番地以下',
	`address_fulltext` VARCHAR(200) COMMENT '所在地：都道府県以降すべて',
	`display_normal_flg` TINYINT default 0 COMMENT '表示箇所（通常）',
	`display_coupon_flg` TINYINT default 0 COMMENT '表示箇所（クーポン）',
	`publication_coupon` TINYINT  NOT NULL COMMENT '発券の有無（0:発券なし 1:発券あり）',
	`display_male` TINYINT default 0 COMMENT '対象性別（男性）',
	`display_female` TINYINT default 0 COMMENT '対象性別（女性）',
	`display_age_from` TINYINT COMMENT '対象年齢（下限）',
	`display_age_to` TINYINT COMMENT '対象年齢（上限）',
	`coupon_start` DATETIME COMMENT 'クーポン期間（開始）',
	`coupon_end` DATETIME COMMENT 'クーポン期間（終了）',
	`coupon_time_start` TIME COMMENT 'クーポン発券可能時間（開始）',
	`coupon_time_end` TIME COMMENT 'クーポン発券可能時間（終了）',
	`use_max_num` INTEGER COMMENT '利用可能回数',
	`coupon_number_status` TINYINT default 1 NOT NULL COMMENT 'クーポンを番号表示 設定 0:非表示 1:表示',
	`coupon_mobile_exchange_button_status` TINYINT default 0 NOT NULL COMMENT 'クーポンを使用済にするボタンの表示 設定 0:非表示 1:表示',
	`edit_status` TINYINT default 2 COMMENT '登録中ステータス（0:スリープ中 1:登録中 2:登録完了）',
	`target_num` INTEGER default 0 NOT NULL COMMENT '登録時対象件数（総数）',
	`target_pay_member_num` INTEGER default 0 NOT NULL COMMENT '登録時対象件数（クーポンBOX）',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	INDEX `coupon_box_FI_1` (`shop_id`)
) COMMENT='クーポンBOX';

#-----------------------------------------------------------------------------
#-- coupon_box_member
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `coupon_box_member`;


CREATE TABLE `coupon_box_member`
(
	`coupon_box_id` INTEGER  NOT NULL COMMENT 'クーポンBOX ID',
	`member_id` INTEGER  NOT NULL COMMENT '会員ID',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`coupon_box_id`,`member_id`),
	KEY `index_member_id`(`member_id`),
	KEY `coupon_box_member_coupon_box_id`(`coupon_box_id`)
) COMMENT='クーポンBOX-メンバー';

#-----------------------------------------------------------------------------
#-- coupon_box_favorite
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `coupon_box_favorite`;


CREATE TABLE `coupon_box_favorite`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT COMMENT '自動生成プライマリキー',
	`member_id` INTEGER  NOT NULL COMMENT '会員ID',
	`type` VARCHAR(20) COMMENT 'クーポン種別',
	`mail_id` BIGINT COMMENT 'クーポンID or メールID',
	`coupon_box_flg` TINYINT COMMENT '1:クーポンBOX 0:メール送信 2:グループ配信メール',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`,`member_id`),
	KEY `index_member_id`(`member_id`)
) COMMENT='クーポンBOX-お気に入り';

#-----------------------------------------------------------------------------
#-- coupon_box_member_temp
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `coupon_box_member_temp`;


CREATE TABLE `coupon_box_member_temp`
(
	`member_id` INTEGER  NOT NULL COMMENT '会員ID',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`member_id`)
) COMMENT='クーポンBOX-メンバー・テンポラリテーブル';

#-----------------------------------------------------------------------------
#-- coupon_box_count_cache
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `coupon_box_count_cache`;


CREATE TABLE `coupon_box_count_cache`
(
	`member_id` INTEGER(8)  NOT NULL COMMENT '会員ID',
	`normal_count` INTEGER COMMENT '「通常」件数',
	`normal_has_new` TINYINT COMMENT '「通常」新着有無',
	`coupon_count` INTEGER COMMENT '「クーポン」件数',
	`coupon_has_new` TINYINT COMMENT '「クーポン」新着有無',
	`favorite_count` INTEGER COMMENT '「お気に入り」件数',
	`expires_at` DATETIME COMMENT '有効期限',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`member_id`),
	KEY `index_expires_at`(`expires_at`)
) COMMENT='クーポンBOX 表示件数キャッシュテーブル';

#-----------------------------------------------------------------------------
#-- pay_option_type
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `pay_option_type`;


CREATE TABLE `pay_option_type`
(
	`id` INTEGER  NOT NULL COMMENT 'オプションID -1:有料会員 0:クーポンBOX 1:EPARKコンシェル',
	`name` VARCHAR(50)  NOT NULL COMMENT 'オプション名',
	`amount` INTEGER COMMENT 'オプション利用料',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`)
) COMMENT='有料オプションマスタテーブル';

#-----------------------------------------------------------------------------
#-- pay_member_process
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `pay_member_process`;


CREATE TABLE `pay_member_process`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT COMMENT '自動生成プライマリキー',
	`option_type_id` INTEGER COMMENT '有料オプションID',
	`count` INTEGER  NOT NULL COMMENT '件数',
	`counted_date` DATE  NOT NULL COMMENT '集計日付',
	PRIMARY KEY (`id`),
	KEY `index_option_type_id_couted_date`(`option_type_id`, `counted_date`),
	KEY `index_counted_date`(`counted_date`)
) COMMENT='有料会員数推移集計テーブル';

#-----------------------------------------------------------------------------
#-- privacy_policy
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `privacy_policy`;


CREATE TABLE `privacy_policy`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT COMMENT '自動生成プライマリキー',
	`number_id` INTEGER COMMENT '第～条',
	`title` VARCHAR(60) COMMENT '表示タイトル',
	`text` TEXT COMMENT '本文',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	KEY `index_number_id`(`number_id`)
) COMMENT='プライバシーポリシーテーブル';

#-----------------------------------------------------------------------------
#-- pay_member_agreement
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `pay_member_agreement`;


CREATE TABLE `pay_member_agreement`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT COMMENT '自動生成プライマリキー',
	`carrier_id` TINYINT  NOT NULL COMMENT '携帯キャリアID 1:DoCoMo 2:AU 3:Softbank 99:その他',
	`number_id` INTEGER COMMENT '第～条',
	`title` VARCHAR(60) COMMENT '表示タイトル',
	`text` TEXT COMMENT '本文',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	KEY `index_carrier_id`(`carrier_id`),
	KEY `index_number_id`(`number_id`)
) COMMENT='有料会員利用規約テーブル';

#-----------------------------------------------------------------------------
#-- pay_member_not_supported_devices_docomo
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `pay_member_not_supported_devices_docomo`;


CREATE TABLE `pay_member_not_supported_devices_docomo`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT COMMENT '自動生成プライマリキー',
	`device_name` VARCHAR(30)  NOT NULL COMMENT '機種名',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	UNIQUE KEY `index_docomo_device_name` (`device_name`)
) COMMENT='有料会員対応しない端末ーdocomo';

#-----------------------------------------------------------------------------
#-- pay_member_not_supported_devices_softbank
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `pay_member_not_supported_devices_softbank`;


CREATE TABLE `pay_member_not_supported_devices_softbank`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT COMMENT '自動生成プライマリキー',
	`device_name` VARCHAR(30)  NOT NULL COMMENT '機種名',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	UNIQUE KEY `index_softbank_device_name` (`device_name`)
) COMMENT='有料会員対応しない端末ーソフトバンク';

#-----------------------------------------------------------------------------
#-- pay_member_not_supported_devices_au
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `pay_member_not_supported_devices_au`;


CREATE TABLE `pay_member_not_supported_devices_au`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT COMMENT '自動生成プライマリキー',
	`device_id` VARCHAR(30)  NOT NULL COMMENT '機種ID',
	`device_name` VARCHAR(30) COMMENT '機種名',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	UNIQUE KEY `index_au_device_id` (`device_id`)
) COMMENT='有料会員対応しない端末ーAU';

#-----------------------------------------------------------------------------
#-- pay_member_register_transaction_hist_docomo
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `pay_member_register_transaction_hist_docomo`;


CREATE TABLE `pay_member_register_transaction_hist_docomo`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT COMMENT '自動生成プライマリキー',
	`member_id` INTEGER(8)  NOT NULL COMMENT '会員ID',
	`mobile_uid` VARCHAR(50)  NOT NULL COMMENT '携帯電話のUID',
	`option_type` INTEGER(8)  NOT NULL COMMENT '有料オプション種別 0:クーポンボックス1:EPARKコンシェル',
	`sales_unique_code` VARCHAR(30)  NOT NULL COMMENT '加盟店指定パラメータ',
	`req_date` DATETIME  NOT NULL COMMENT '決済要求日時',
	`price` INTEGER(8)  NOT NULL COMMENT '決済金額',
	`payment_id` VARCHAR(30) COMMENT 'ケータイ払い決済番号',
	`payment_date` DATETIME COMMENT '継続発生ユーザー認証日時',
	`settlement_code` VARCHAR(4) COMMENT '課金確定要求結果コード「00」受付完了、「99」未受付、「01」インタフェース項目異常エラーなど',
	`settlement_date` DATETIME COMMENT '課金確定要求日時',
	`adjust_code` VARCHAR(4) COMMENT '課金補正要求結果コード「00」受付完了、「99」未受付、「01」インタフェース項目異常エラーなど',
	`adjust_date` DATETIME COMMENT '課金補正要求日時',
	`last_settlement_target_date` DATETIME COMMENT '最終課金確定対象日時',
	`completion_code` VARCHAR(4) COMMENT '確定完了応答結果コード「OK」正常完了、「AN」与信ＮＧ、「CN」抹消',
	`completion_date` DATETIME COMMENT '課金確定完了応答日時',
	`adjust_completion_code` VARCHAR(4) COMMENT '確定補正応答結果コード「OK」正常完了、「AN」与信ＮＧ、「CN」抹消',
	`adjust_completion_date` DATETIME COMMENT '課金補正完了応答日時',
	`termination_requested` TINYINT default 0 NOT NULL COMMENT '継続終了要求済ステータス。0:ユーザの終了要求なし 1:ユーザの終了要求済',
	`termination_requested_date` DATETIME COMMENT 'ユーザが継続終了要求済した日時',
	`termination_code` VARCHAR(4) COMMENT '継続終了応答結果コード「OK」正常処理（継続終了要求）、「MB」継続終了、「CN」継続課金枠抹消',
	`termination_date` DATETIME COMMENT '継続終了応答日時',
	`question_id` INTEGER default 0 NOT NULL COMMENT '終了アンケート設問ID',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	UNIQUE KEY `unique_sales_unique_code` (`sales_unique_code`),
	KEY `index_member_id`(`member_id`),
	KEY `index_mobile_uid`(`mobile_uid`),
	KEY `index_payment_id`(`payment_id`),
	KEY `index_settlement_code`(`settlement_code`),
	KEY `index_completion_code`(`completion_code`),
	KEY `index_termination_requested`(`termination_requested`),
	KEY `index_termination_code`(`termination_code`),
	KEY `index_question_id`(`question_id`),
	KEY `index_last_settlement_target_date`(`last_settlement_target_date`),
	KEY `index_adjust_code`(`adjust_code`),
	KEY `index_index_adjust_completion_code`(`adjust_completion_code`)
) COMMENT='有料会員取引履歴ーDocomo（旧：iモード専用）';

#-----------------------------------------------------------------------------
#-- pay_member_monthly_settlement_hist_docomo
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `pay_member_monthly_settlement_hist_docomo`;


CREATE TABLE `pay_member_monthly_settlement_hist_docomo`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT COMMENT '自動生成プライマリキー',
	`register_transaction_hist_docomo_id` INTEGER  NOT NULL COMMENT '取引履歴ID',
	`settlement_code` VARCHAR(4) COMMENT '課金確定要求結果コード「00」受付完了、「99」未受付、「01」インタフェース項目異常エラーなど',
	`settlement_date` DATETIME COMMENT '課金確定要求日時',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	KEY `index_register_transaction_hist_docomo_id`(`register_transaction_hist_docomo_id`),
	KEY `index_settlement_code`(`settlement_code`)
) COMMENT='有料会員月次確定処理履歴ーDocomo（旧：imode専用）';

#-----------------------------------------------------------------------------
#-- pay_member_register_transaction_hist_docomo_sp
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `pay_member_register_transaction_hist_docomo_sp`;


CREATE TABLE `pay_member_register_transaction_hist_docomo_sp`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT COMMENT '自動生成プライマリキー',
	`member_id` INTEGER(8)  NOT NULL COMMENT '会員ID',
	`pay_member_id` BIGINT default 0 NOT NULL COMMENT '有料サービス認証状態ID',
	`device_type` TINYINT default 99 NOT NULL COMMENT '端末種別 1:iモード 2:spモード 99:その他（Wi-fi, テザリング）',
	`mobile_uid` VARCHAR(50) default '' NOT NULL COMMENT '携帯電話のUID',
	`option_type` TINYINT  NOT NULL COMMENT '有料オプション種別 0:クーポンボックス1:EPARKコンシェル',
	`operation_status` TINYINT default 0 NOT NULL COMMENT '現在の処理状況（Docomoへの遷移復帰時の処理分岐等に利用） 0:なし 1:継続発生処理中 2:継続変更処理中 3:継続終了処理中 99:その他処理中',
	`shop_token` VARCHAR(40)  NOT NULL COMMENT '加盟店トークン（最大200文字だが、40文字で十分）',
	`docomo_token` VARCHAR(100) COMMENT 'ドコモ指定トークン（ユーザ認証結果取得インターフェイスで受信）',
	`docomo_token_date` DATETIME COMMENT 'ドコモ指定トークン受信日時（ドコモチェック仕様：有効期限5分）',
	`docomo_openid` VARCHAR(200) COMMENT 'ユーザチェック用 docomoOpenID',
	`docomo_openid_realm` VARCHAR(200) COMMENT 'ユーザチェック用 docomoOpenID realm',
	`docomo_suid` VARCHAR(200) COMMENT 'ユーザチェック用 docomo SUID',
	`req_date` DATETIME  NOT NULL COMMENT '決済要求日時',
	`price` INTEGER(8)  NOT NULL COMMENT '決済金額',
	`payment_id` VARCHAR(30) COMMENT 'ケータイ払い決済番号',
	`payment_date` DATETIME COMMENT '継続発生ユーザー認証日時',
	`settlement_code` VARCHAR(4) COMMENT '課金確定要求結果コード「00」受付完了、「99」未受付、「01」インタフェース項目異常エラーなど',
	`settlement_date` DATETIME COMMENT '課金確定要求日時',
	`adjust_code` VARCHAR(4) COMMENT '課金補正要求結果コード「00」受付完了、「99」未受付、「01」インタフェース項目異常エラーなど',
	`adjust_date` DATETIME COMMENT '課金補正要求日時',
	`last_settlement_target_date` DATETIME COMMENT '最終課金確定対象日時',
	`completion_code` VARCHAR(4) COMMENT '確定完了応答結果コード「OK」正常完了、「AN」与信ＮＧ、「CN」抹消',
	`completion_date` DATETIME COMMENT '課金確定完了応答日時',
	`adjust_completion_code` VARCHAR(4) COMMENT '確定補正応答結果コード「OK」正常完了、「AN」与信ＮＧ、「CN」抹消',
	`adjust_completion_date` DATETIME COMMENT '課金補正完了応答日時',
	`cancel_code` VARCHAR(4) COMMENT '取消完了応答結果コード「OK」正常完了、「M1」翌月確定取消、「NG」処理失敗',
	`cancel_date` DATETIME COMMENT '取消完了応答日時',
	`undo_code` VARCHAR(4) COMMENT 'IF取消要求結果コード 00:受付完了 01:パラメータ異常エラー 99:未受付',
	`undo_date` DATETIME COMMENT 'IF取消要求日時',
	`termination_requested` TINYINT default 0 NOT NULL COMMENT '継続終了ステータス。0:終了要求なし 1:ユーザの終了要求済 2:確定失敗終了 3:管理画面終了 9:その他終了',
	`termination_requested_date` DATETIME COMMENT '継続終了ステータス変更日時',
	`end_code` VARCHAR(4) COMMENT 'IF終了要求結果コード「00」受付完了、「99」未受付、「01」インタフェース項目異常エラーなど',
	`end_date` DATETIME COMMENT 'IF終了要求日時',
	`termination_code` VARCHAR(4) COMMENT '継続終了応答結果コード、「MB」継続終了、「CN」docomo抹消、「CB」docomo前月抹消',
	`termination_date` DATETIME COMMENT '継続終了応答日時',
	`question_id` INTEGER default 0 NOT NULL COMMENT '終了アンケート設問ID',
	`register_line_flg` TINYINT default 1 NOT NULL COMMENT '新規会員有料オプション登録導線中フラグ 0: 導線中 1: 導線中でない',
	`coupon_box_id` VARCHAR(20) COMMENT '登録導線中クーポンBOX詳細遷移パラメータ ※DoCoMoのみキャリア課金画面から戻ってくる際にセッションが切れるため一時保存用にカラムを追加しています。',
	`premium_shop_id` INTEGER COMMENT '登録導線中おまかせ順番受付遷移パラメータ ※DoCoMoのみキャリア課金画面から戻ってくる際にセッションが切れるため一時保存用にカラムを追加しています。',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	UNIQUE KEY `unique_shop_token` (`shop_token`),
	KEY `index_member_id`(`member_id`),
	KEY `index_mobile_uid`(`mobile_uid`),
	KEY `index_payment_id`(`payment_id`),
	KEY `index_settlement_code`(`settlement_code`),
	KEY `index_completion_code`(`completion_code`),
	KEY `index_termination_requested`(`termination_requested`),
	KEY `index_termination_code`(`termination_code`),
	KEY `index_question_id`(`question_id`),
	KEY `index_last_settlement_target_date`(`last_settlement_target_date`),
	KEY `index_adjust_code`(`adjust_code`),
	KEY `index_index_adjust_completion_code`(`adjust_completion_code`)
) COMMENT='有料会員取引履歴ーDocomo（spモード/iモード対応）';

#-----------------------------------------------------------------------------
#-- pay_member_monthly_settlement_hist_docomo_sp
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `pay_member_monthly_settlement_hist_docomo_sp`;


CREATE TABLE `pay_member_monthly_settlement_hist_docomo_sp`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT COMMENT '自動生成プライマリキー',
	`register_transaction_hist_docomo_sp_id` INTEGER  NOT NULL COMMENT '取引履歴ID',
	`settlement_code` VARCHAR(4) COMMENT '課金確定要求結果コード「00」受付完了、「99」未受付、「01」インタフェース項目異常エラーなど',
	`settlement_date` DATETIME COMMENT '課金確定要求日時',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	KEY `index_register_transaction_hist_docomo_sp_id`(`register_transaction_hist_docomo_sp_id`),
	KEY `index_settlement_code`(`settlement_code`)
) COMMENT='有料会員月次確定処理履歴ーDocomo（spモード/iモード対応）';

#-----------------------------------------------------------------------------
#-- pay_member_transaction_hist_au
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `pay_member_transaction_hist_au`;


CREATE TABLE `pay_member_transaction_hist_au`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT COMMENT '自動生成プライマリキー',
	`member_id` INTEGER(8)  NOT NULL COMMENT '会員ID',
	`mobile_uid` VARCHAR(50)  NOT NULL COMMENT '携帯電話のUID',
	`option_type` INTEGER(8)  NOT NULL COMMENT '有料オプション種別 0:クーポンボックス1:EPARKコンシェル',
	`interface_name` VARCHAR(30)  NOT NULL COMMENT 'インターフェース名',
	`rslt_cd` VARCHAR(30)  NOT NULL COMMENT '結果コード',
	`rsn_cd` VARCHAR(30) COMMENT '結果事由コード',
	`tran_id` VARCHAR(255) COMMENT 'トランザクションID',
	`odr_id` VARCHAR(255) COMMENT 'オーダーID',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	KEY `index_member_id`(`member_id`)
) COMMENT='有料会員取引履歴ーAU';

#-----------------------------------------------------------------------------
#-- pay_member_transaction_hist_au_kantan
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `pay_member_transaction_hist_au_kantan`;


CREATE TABLE `pay_member_transaction_hist_au_kantan`
(
	`id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT '自動生成プライマリキー',
	`member_id` INTEGER(8)  NOT NULL COMMENT '会員ID',
	`pay_member_id` BIGINT default 0 NOT NULL COMMENT '有料サービス認証状態ID',
	`option_type` TINYINT  NOT NULL COMMENT '有料オプション種別 0:クーポンボックス1:EPARKコンシェル',
	`payment_status` TINYINT default 0 NOT NULL COMMENT '決済状態 0:未登録 1:登録済み 2:解約・無効 ※課金の有効/無効はこの値のみを判定する。(念のため、in_transaction=処理内を加えるのも可)',
	`transaction_code` TINYINT default 0 NOT NULL COMMENT 'トランザクション種別: 0:未実行 1:OpenID認証要求 2:決済認可要求 3:ユーザ認証要求 4:継続課金情報登録 5:継続課金解約 6:決済ステータス取得 7:処理取消 8:OpenID解除',
	`in_transaction` TINYINT default 0 NOT NULL COMMENT '処理中フラグ 0:処理なし 1:処理中',
	`open_id_auth_result` TINYINT default 0 NOT NULL COMMENT 'OpenID認証要求結果 0:未実行 1:成功 2:失敗',
	`approval_result` TINYINT default 0 NOT NULL COMMENT '決済認可要求結果 0:未実行 1:成功 2:失敗',
	`user_auth_result` TINYINT default 0 NOT NULL COMMENT 'ユーザ認証要求結果 0:未実行 1:成功 2:失敗',
	`register_result` TINYINT default 0 NOT NULL COMMENT '継続課金情報登録結果 0:未実行 1:成功 2:失敗 3:失敗（要取消）',
	`terminate_result` TINYINT default 0 NOT NULL COMMENT '継続課金解約結果 0:未実行 1:成功 2:失敗 3:強制解約 4:引継ぎ解約',
	`stat_result` TINYINT default 0 NOT NULL COMMENT '決済ステータス取得結果 0:未実行 1:成功 2:失敗',
	`cancel_result` TINYINT default 0 NOT NULL COMMENT '処理取消結果 0:未実行 1:成功 2:失敗',
	`openid_rel_result` TINYINT default 0 NOT NULL COMMENT 'OpenID解除結果 0:未実行 1:成功 2:失敗',
	`x_result_cd` VARCHAR(8) default '' NOT NULL COMMENT '処理結果コード 各要求処理応答結果にて取得 ※最新のもので上書き',
	`open_id` VARCHAR(256) default '' NOT NULL COMMENT 'OpenID OpenID認証応答にて取得',
	`transaction_id` VARCHAR(32) default '' NOT NULL COMMENT 'トランザクションID 決済認可応答にて取得',
	`user_auth_paymtd` VARCHAR(2) default '' NOT NULL COMMENT '支払方法 ユーザ認証応答にて取得 02:クレジットカード 03:WebMoney ※合算であった場合には応答されない',
	`approval_datetime` DATETIME COMMENT '決済認可要求日時',
	`approval_result_cd` VARCHAR(8) default '' NOT NULL COMMENT '決済認可要求結果コード',
	`approval_cert_type` VARCHAR(2) default '' NOT NULL COMMENT '認証区分 決済に使われるユーザ識別情報のパターン 01固定',
	`approval_account_interval_kbn` VARCHAR(2) default '' NOT NULL COMMENT '課金間隔区分 課金が発生する間隔の単位 02固定',
	`approval_account_interval` INTEGER default 0 NOT NULL COMMENT '課金区分 課金が発生する間隔 1固定',
	`approval_account_timing_kbn` VARCHAR(2) default '' NOT NULL COMMENT '課金タイミング区分 課金日の指定方法 01:日指定, 02:月末日',
	`approval_account_timing` TINYINT default 0 NOT NULL COMMENT '課金タイミング 初回課金年月日翌月以降の毎月課金日の指定(1～28) 課金タイミング区分が 01:日指定 の場合に有効',
	`approval_first_account_day` VARCHAR(8) default '' NOT NULL COMMENT '初回の課金日（YYYYMMDD）',
	`approval_first_amount` INTEGER default 0 NOT NULL COMMENT '初回の課金金額（1円～）',
	`approval_next_amount` INTEGER default 0 NOT NULL COMMENT '次回からの課金金額（1円～）',
	`approval_commodity` VARCHAR(256) default '' NOT NULL COMMENT '摘要 ※継続課金の場合、課金タイミングの記入必須（例: 毎月○○日に課金）',
	`approval_member_manage_no` BIGINT default 0 NOT NULL COMMENT '加盟店管理番号 加盟店で管理している注文番号 (pay_member_transaction_hist_au_kantan.id)',
	`approval_contents_id` VARCHAR(15) default '' NOT NULL COMMENT 'コンテンツID',
	`register_datetime` DATETIME COMMENT '継続課金登録要求日時',
	`register_result_cd` VARCHAR(8) default '' NOT NULL COMMENT '継続課金登録要求結果コード',
	`register_continue_account_id` VARCHAR(11) default '' NOT NULL COMMENT '継続課金ID',
	`register_member_manage_no` BIGINT default 0 NOT NULL COMMENT '加盟店管理番号 加盟店で管理している注文番号 (pay_member_transaction_hist_au_kantan.id)',
	`register_process_day` VARCHAR(8) default '' NOT NULL COMMENT '登録処理日 YYYYMMDD',
	`register_process_time` VARCHAR(6) default '' NOT NULL COMMENT '登録処理時刻 hhmmss',
	`terminate_datetime` DATETIME COMMENT '継続課金解約要求日時（NULLの場合はバッチ処理による解約）',
	`terminate_result_cd` VARCHAR(8) default '' NOT NULL COMMENT '継続課金解約要求結果コード',
	`terminate_process_day` VARCHAR(8) default '' NOT NULL COMMENT '解約処理日 YYYYMMDD',
	`terminate_process_time` VARCHAR(6) default '' NOT NULL COMMENT '解約処理時刻 hhmmss',
	`stat_datetime` DATETIME COMMENT '決済ステータス取得 要求日時',
	`stat_result_cd` VARCHAR(8) default '' NOT NULL COMMENT '決済ステータス取得 要求結果コード',
	`stat_transaction_status` VARCHAR(2) default '' NOT NULL COMMENT '決済ステータス取得 トランザクションステータス 10:決済認可済み 20:規約同意済み 30:暗証番号認証済み 40:決済完了済 90:無効',
	`stat_pay_info_no` VARCHAR(16) default '' NOT NULL COMMENT '決済ステータス決済 情報番号',
	`stat_pay_status` VARCHAR(2) default '' NOT NULL COMMENT '決済ステータス取得 決済ステータス 10:オーソリ※継続課金の場合は設定されない 15:オーソリ取消※継続課金の場合は設定されない 20:売上 25:売上取消 30:請求 40:返金 90:該当無し※従量課金の場合は設定されない 95:処理不定※継続課金の場合は設定されない',
	`cancel_datetime` DATETIME COMMENT '処理取消要求日時',
	`cancel_result_cd` VARCHAR(8) default '' NOT NULL COMMENT '処理取消要求結果コード',
	`cancel_process_kbn` VARCHAR(2) default '' NOT NULL COMMENT '処理取消処理区分 正常終了時の詳細 06:継続課金の解約を行いました。 35:継続課金が登録されていません。 63:売上取消が行われています。 66:継続課金の解約が行われています。',
	`cancel_pay_info_no` VARCHAR(16) default '' NOT NULL COMMENT '処理取消決済情報番号',
	`cancel_process_day` VARCHAR(8) default '' NOT NULL COMMENT '取消処理日 YYYYMMDD',
	`cancel_process_time` VARCHAR(6) default '' NOT NULL COMMENT '取消処理時刻 hhmmss',
	`openid_rel_datetime` DATETIME COMMENT 'OpenID解除要求日時',
	`openid_rel_result_cd` VARCHAR(8) default '' NOT NULL COMMENT 'OpenID解除要求結果コード',
	`bill_sync_status` TINYINT  NOT NULL COMMENT '課金登録同期状態 0:未実行 1:同期中 2:登録完了 3:登録失敗 9:同期失敗',
	`bill_sync_start_datetime` DATETIME COMMENT '課金登録同期処理開始日時',
	`bill_sync_end_datetime` DATETIME COMMENT '課金登録同期処理終了日時',
	`bill_sync_message` TINYINT  NOT NULL COMMENT '課金登録同期メッセージ表示フラグ 0:非表示 1:表示',
	`bill_result_cd` VARCHAR(8) default '' NOT NULL COMMENT '継続課金処理結果コード',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	`bill_result_day` VARCHAR(8) default '' NOT NULL COMMENT '継続課金処理日 YYYYMMDD',
	PRIMARY KEY (`id`),
	KEY `index_member_id_option_type`(`member_id`, `option_type`, `payment_status`),
	KEY `index_pay_member_id`(`pay_member_id`),
	KEY `index_transaction_id`(`transaction_id`),
	KEY `index_transaction_code`(`transaction_code`)
) COMMENT='有料会員取引履歴ーAU（auかんたん決済）';

#-----------------------------------------------------------------------------
#-- pay_member_au_kantan_daily_batch_log
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `pay_member_au_kantan_daily_batch_log`;


CREATE TABLE `pay_member_au_kantan_daily_batch_log`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT COMMENT 'ID',
	`process_code` VARCHAR(10)  NOT NULL COMMENT '処理コード TERMINATE:登録解除処理',
	`start_datetime` DATETIME  NOT NULL COMMENT '処理開始日時',
	`end_datetime` DATETIME COMMENT '処理終了日時',
	`target_datetime` DATETIME  NOT NULL COMMENT '処理対象日時',
	`result_code` TINYINT  NOT NULL COMMENT '結果コード 1:成功 2:失敗',
	`result` TEXT COMMENT '結果内容',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`)
) COMMENT='auかんたん決済 日次バッチ処理ログテーブル';

#-----------------------------------------------------------------------------
#-- pay_member_taking_over_hist_au_kantan
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `pay_member_taking_over_hist_au_kantan`;


CREATE TABLE `pay_member_taking_over_hist_au_kantan`
(
	`id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT '自動生成プライマリキー',
	`member_id` INTEGER(8)  NOT NULL COMMENT '会員ID',
	`option_type` TINYINT  NOT NULL COMMENT '有料オプション種別 0:クーポンボックス1:EPARKコンシェル',
	`taking_over_status` TINYINT default 0 NOT NULL COMMENT '引継ぎ状態 0:未処理 1:完了（退会完了）',
	`transaction_code` TINYINT default 0 NOT NULL COMMENT 'トランザクション種別: 0:未実行 1:OpenID認証要求 2:EZ番号通知要求 3:会員認証要求 4:トークン払い出し要求 5:退会要求',
	`in_transaction` TINYINT default 0 NOT NULL COMMENT '処理中フラグ 0:処理なし 1:処理中',
	`open_id_auth_result` TINYINT default 0 NOT NULL COMMENT 'OpenID認証要求結果 0:未実行 1:成功 2:失敗',
	`ez_number_result` TINYINT default 0 NOT NULL COMMENT 'EZ番号通知要求結果 0:未実行 1:成功 2:失敗',
	`user_auth_result` TINYINT default 0 NOT NULL COMMENT '会員認証要求結果 0:未実行 1:成功 2:失敗 3:退会済',
	`token_result` TINYINT default 0 NOT NULL COMMENT 'トークン払い出し要求結果 0:未実行 1:成功 2:失敗',
	`cancel_result` TINYINT default 0 NOT NULL COMMENT '退会要求結果 0:未実行 1:成功 2:失敗 3:退会済',
	`result_cd` VARCHAR(8) default '' NOT NULL COMMENT '処理結果コード 各要求処理応答結果にて取得 ※最新のもので上書き',
	`open_id` VARCHAR(256) default '' NOT NULL COMMENT 'OpenID',
	`nonce` VARCHAR(256) default '' NOT NULL COMMENT 'openid.response_nonce',
	`ez_number_datetime` DATETIME COMMENT 'EZ番号通知要求日時',
	`ver` VARCHAR(3) default '' NOT NULL COMMENT 'バージョン 1.0固定',
	`ez_number_result_cd` VARCHAR(8) default '' NOT NULL COMMENT 'EZ番号通知要求結果コード',
	`subid` VARCHAR(40) default '' NOT NULL COMMENT 'EZ番号',
	`user_auth_datetime` DATETIME COMMENT '会員認証要求日時',
	`sys_no` VARCHAR(1) default '' NOT NULL COMMENT 'システム識別 プレミアムEZ 回収代行システム：1固定',
	`user_auth_rslt_cd` VARCHAR(2) default '' NOT NULL COMMENT '結果コード',
	`user_auth_rsn_cd` VARCHAR(6) default '' NOT NULL COMMENT '結果事由コード',
	`cont_sts` VARCHAR(2) default '' NOT NULL COMMENT '契約状態',
	`token_datetime` DATETIME COMMENT 'トークン払い出し要求日時',
	`item_flag` VARCHAR(1) default '' NOT NULL COMMENT '物販orデジコンフラグ 物販：0 デジタルコンテンツ：1',
	`use_fin_page` VARCHAR(1) default '' NOT NULL COMMENT '完了画面表示フラグ 非表示：0 表示：1',
	`token_err` VARCHAR(4) default '' NOT NULL COMMENT 'エラーコード 処理結果',
	`token` TEXT COMMENT 'トークン',
	`cancel_rslt_cd` VARCHAR(2) default '' NOT NULL COMMENT '退会要求 結果コード',
	`cancel_rsn_cd` VARCHAR(6) default '' NOT NULL COMMENT '退会要求 結果事由コード',
	`cancel_suc_datetime` DATETIME COMMENT '退会成功日時',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	KEY `index_member_id_option_type`(`member_id`, `option_type`, `taking_over_status`),
	KEY `index_transaction_code`(`transaction_code`)
) COMMENT='auかんたん決済への引継ぎ履歴ーAU（まとめてau支払い→auかんたん決済）';

#-----------------------------------------------------------------------------
#-- pay_member_transaction_hist_softbank
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `pay_member_transaction_hist_softbank`;


CREATE TABLE `pay_member_transaction_hist_softbank`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT COMMENT '自動生成プライマリキー',
	`member_id` INTEGER(8)  NOT NULL COMMENT '会員ID',
	`mobile_uid` VARCHAR(50)  NOT NULL COMMENT '携帯電話のUID',
	`option_type` INTEGER(8)  NOT NULL COMMENT '有料オプション種別 0:クーポンボックス1:EPARKコンシェル',
	`request_type` VARCHAR(15)  NOT NULL COMMENT 'リクエストURIタイプ',
	`reg` VARCHAR(10)  NOT NULL COMMENT '結果コード',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	KEY `index_member_id`(`member_id`)
) COMMENT='有料会員取引履歴ーSoftbank';

#-----------------------------------------------------------------------------
#-- pay_member_transaction_hist_softbank_matomete
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `pay_member_transaction_hist_softbank_matomete`;


CREATE TABLE `pay_member_transaction_hist_softbank_matomete`
(
	`id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT '自動生成プライマリキー',
	`member_id` INTEGER(8)  NOT NULL COMMENT '会員ID',
	`pay_member_id` BIGINT default 0 NOT NULL COMMENT '有料サービス認証状態ID',
	`option_type` TINYINT  NOT NULL COMMENT '有料オプション種別 0:クーポンボックス1:EPARKコンシェル',
	`bill_status` TINYINT default 0 NOT NULL COMMENT '課金状態 0:未登録 1:登録済み 2:解除・無効 ※課金の有効/無効はこの値のみを判定する。(念のため、in_transaction=処理内を加えるのも可)',
	`transaction_code` TINYINT default 0 NOT NULL COMMENT 'トランザクション種別: 0:未実行 1:OpenID認証要求 2:課金開始要求 3:課金同意確認 4:課金要求 5:OpenID認証要求(解除時) 6:月額課金解除要求 7:月額課金継続確認要求',
	`in_transaction` TINYINT default 0 NOT NULL COMMENT '処理中フラグ 0:処理なし 1:処理中',
	`open_id_auth_result` TINYINT default 0 NOT NULL COMMENT 'OpenID認証要求結果 0:未実行 1:成功 2:失敗 3:キャンセル',
	`bill_beginning_result` TINYINT default 0 NOT NULL COMMENT '課金開始要求結果 0:未実行 1:成功 2:失敗',
	`bill_agree_result` TINYINT default 0 NOT NULL COMMENT '課金同意確認結果 0:未実行 1:成功 2:失敗 3:キャンセル',
	`bill_execute_result` TINYINT default 0 NOT NULL COMMENT '課金要求結果 0:未実行 1:成功 2:失敗',
	`can_open_id_auth_result` TINYINT default 0 NOT NULL COMMENT 'OpenID認証要求結果(解除時) 0:未実行 1:成功 2:失敗 3:キャンセル',
	`monthly_cancel_result` TINYINT default 0 NOT NULL COMMENT '月額課金解除要求結果 0:未実行 1:成功 2:失敗 3:キャンセル 4:解除済',
	`monthly_reference_result` TINYINT default 0 NOT NULL COMMENT '月額課金継続確認要求結果 0:未実行 1:成功 2:失敗',
	`service_user_id` VARCHAR(64) default '' NOT NULL COMMENT '中間ID OpenID認証応答にて取得 プロバイダ別ユーザー識別子',
	`can_service_user_id` VARCHAR(64) default '' NOT NULL COMMENT '解除処理時の中間ID OpenID認証応答にて取得 プロバイダ別ユーザー識別子',
	`transaction_id` VARCHAR(20) default '' NOT NULL COMMENT 'トランザクションID 課金開始要求レスポンスにて取得',
	`bill_beginning_datetime` DATETIME COMMENT '課金開始要求日時',
	`service_code` VARCHAR(18) default '' NOT NULL COMMENT 'サービス識別子',
	`servicer_manage_no` VARCHAR(20) default '' NOT NULL COMMENT 'CP 情報管理番号',
	`amount` INTEGER default 0 NOT NULL COMMENT '購入金額',
	`cp_note` VARCHAR(144) default '' NOT NULL COMMENT '購入内容',
	`bill_beginning_status_code` VARCHAR(5) default '' NOT NULL COMMENT '課金開始要求処理結果コード',
	`bill_execute_datetime` DATETIME COMMENT '課金要求日時',
	`order_no` VARCHAR(14) default '' NOT NULL COMMENT '注文番号',
	`purchase_day` VARCHAR(14) default '' NOT NULL COMMENT '購入日時（YYYYMMDDhhmmss）キャリア側レスポンス',
	`bill_execute_status_code` VARCHAR(5) default '' NOT NULL COMMENT '課金要求処理結果コード',
	`monthly_cancel_datetime` DATETIME COMMENT '月額課金解除処理日時',
	`monthly_cancel_error_code` VARCHAR(4) default '' NOT NULL COMMENT '月額課金解除要求エラーコード',
	`monthly_reference_datetime` DATETIME COMMENT '月額課金継続確認要求日時',
	`monthly_regist_status` VARCHAR(2) default '' NOT NULL COMMENT '月額課金登録状態',
	`monthly_reference_result_code` VARCHAR(5) default '' NOT NULL COMMENT '月額課金継続確認要求処理結果コード',
	`monthly_detail_code` VARCHAR(4) default '' NOT NULL COMMENT '月額課金継続確認エラー詳細コード',
	`bill_sync_status` TINYINT  NOT NULL COMMENT '課金登録同期状態 0:未実行 1:同期中 2:登録完了 3:登録失敗 9:同期失敗',
	`bill_sync_start_datetime` DATETIME COMMENT '課金登録同期処理開始日時',
	`bill_sync_end_datetime` DATETIME COMMENT '課金登録同期処理終了日時',
	`bill_sync_message` TINYINT  NOT NULL COMMENT '課金登録同期メッセージ表示フラグ 0:非表示 1:表示',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	KEY `index_member_id_option_type`(`member_id`, `option_type`, `bill_status`),
	KEY `index_pay_member_id`(`pay_member_id`),
	KEY `index_transaction_id`(`transaction_id`),
	KEY `index_transaction_code`(`transaction_code`)
) COMMENT='有料会員取引履歴‐SB（ソフトバンクまとめて支払い）';

#-----------------------------------------------------------------------------
#-- pay_member_transaction_hist_credit
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `pay_member_transaction_hist_credit`;


CREATE TABLE `pay_member_transaction_hist_credit`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT COMMENT '自動生成プライマリキー',
	`member_id` INTEGER(8)  NOT NULL COMMENT '会員ID',
	`option_type` INTEGER  NOT NULL COMMENT '有料オプション種別 0:クーポンボックス1:EPARKコンシェル',
	`status` TINYINT  NOT NULL COMMENT '決済ステータス 0:取引未完了 1:会員未登録 2:成功 3:失敗',
	`gmo_member_id` VARCHAR(60)  NOT NULL COMMENT 'GMO会員ID 最大60文字',
	`gmo_order_id` VARCHAR(27)  NOT NULL COMMENT 'GMO取引ID 最大27文字',
	`shop_id` VARCHAR(13) COMMENT 'GMO店舗ID',
	`job_cd` VARCHAR(32) COMMENT 'GMO処理区分',
	`amount` INTEGER COMMENT 'GMO利用金額',
	`tax` INTEGER COMMENT 'GMO税送料',
	`currency` VARCHAR(3) COMMENT 'GMO通貨コード',
	`access_id` VARCHAR(32) COMMENT 'GMO取引ID',
	`access_pass` VARCHAR(32) COMMENT 'GMO取引パスワード',
	`order_id` VARCHAR(27) COMMENT 'GMOオーダーID',
	`forwarded` VARCHAR(32) COMMENT 'GMO結果仕向け先コード',
	`method` VARCHAR(1) COMMENT 'GMO支払方法',
	`pay_times` INTEGER COMMENT 'GMO支払回数',
	`approve` VARCHAR(7) COMMENT 'GMOカード会社承認番号',
	`tran_id` VARCHAR(28) COMMENT 'GMOトランザクションID',
	`tran_date` VARCHAR(14) COMMENT 'GMO処理日時',
	`check_string` VARCHAR(32) COMMENT 'GMO処理結果チェック文字列',
	`err_code` VARCHAR(32) COMMENT 'GMOエラーコード',
	`err_info` VARCHAR(32) COMMENT 'GMOエラー詳細',
	`client_field1` VARCHAR(32) COMMENT '自由項目１：有料オプション名',
	`client_field2` VARCHAR(32) COMMENT '自由項目２：料金（月額）',
	`client_field3` VARCHAR(32) COMMENT '自由項目３：会員ID',
	`new_card_flag` VARCHAR(1) COMMENT 'GMO未登録カード利用フラグ',
	`pay_type` VARCHAR(1) COMMENT 'GMO決済方法',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	UNIQUE KEY `gmo_order_id_uniq` (`gmo_order_id`),
	KEY `index_member_id`(`option_type`),
	KEY `index_gmo_order_id`(`gmo_order_id`)
) COMMENT='有料会員取引履歴ークレジット決済(GMOペイメント)';

#-----------------------------------------------------------------------------
#-- carrier_test_uid
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `carrier_test_uid`;


CREATE TABLE `carrier_test_uid`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT COMMENT '自動生成プライマリキー',
	`carrier_id` TINYINT  NOT NULL COMMENT '携帯キャリアID 1:DoCoMo 2:AU 3:Softbank 99:その他',
	`uid` VARCHAR(100)  NOT NULL COMMENT 'テスト携帯UID (携帯以外はIPアドレス-実機テストはWiFiで)',
	`status` TINYINT default 0 NOT NULL COMMENT '利用状態 0:利用可能 1:利用不可能',
	`docomo_verification_return_NG` TINYINT default 0 NOT NULL COMMENT 'docomoユーザ認証NGリターンフラグ0:通常1:常にNGを返す',
	`comment` VARCHAR(100)  NOT NULL COMMENT '携帯の持ち主等',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	KEY `index_carrier_id_status_uid`(`carrier_id`, `status`, `uid`)
) COMMENT='キャリアテスト用端末登録テーブル';

#-----------------------------------------------------------------------------
#-- pda_login
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `pda_login`;


CREATE TABLE `pda_login`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT COMMENT '自動生成プライマリキー',
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID',
	`sequential_number` INTEGER  NOT NULL COMMENT '連番',
	`pda_id` VARCHAR(11)  NOT NULL COMMENT 'PDA用ログインID (shop_id + sequential_number の10桁 or shop_id + sequential_number の11桁)',
	`carrier` VARCHAR(50) COMMENT '最終ログイン機種',
	`session_id` VARCHAR(100) COMMENT 'セッションID',
	`status` TINYINT  NOT NULL COMMENT '運用ステータス 0:運用中 1:停止中 2:予備 3:運用中(Xorder) 4:運用中(e-menu) 9:削除済',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	KEY `index_status`(`status`),
	KEY `index_sequential_number`(`sequential_number`),
	INDEX `pda_login_FI_1` (`shop_id`)
) COMMENT='PDAログイン用ID登録テーブル';

#-----------------------------------------------------------------------------
#-- repeat_mail
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `repeat_mail`;


CREATE TABLE `repeat_mail`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	`shop_id` INTEGER(8)  NOT NULL COMMENT '店舗ID',
	`repeat_type` TINYINT  NOT NULL COMMENT 'メール種別 1:初回特典メール 2:誕生日メール 3:リピートメール 4:ステップメール 5:来店がない人メール 6:有効期限切れ告知メール 7:車検リマインドメール',
	`mail_type` TINYINT  NOT NULL COMMENT '配信種別 1:通常メール 2:クーポンメール',
	`status` TINYINT default 0 NOT NULL COMMENT '状態 0:有効 1:無効 2:不明(削除)',
	`send_status` TINYINT default 0 NOT NULL COMMENT '送信ステータス 0:実行中 1:一時停止 2:配信終了',
	`send_type` TINYINT COMMENT '設定者 0:オーナー店舗 1:店舗',
	`send_number` INTEGER(5) COMMENT '配信No',
	`sender` VARCHAR(64) COMMENT '差出人',
	`subject` VARCHAR(60) COMMENT '配信タイトル',
	`header` TEXT COMMENT 'メールヘッダ',
	`text` TEXT COMMENT 'メール内容',
	`text_html` TEXT COMMENT 'メール内容(HTML)',
	`footer` TEXT COMMENT 'メールフッタ',
	`src_sex` TINYINT COMMENT '配信対象:性別 0:男性 1:女性',
	`src_age_from` INTEGER(3) COMMENT '配信対象:年齢(開始)',
	`src_age_to` INTEGER(3) COMMENT '配信対象:年齢(終了)',
	`src_birth_m` SMALLINT COMMENT '配信対象:誕生月',
	`src_pref_id` TINYINT COMMENT '配信対象:都道府県',
	`src_member_rank` TINYINT COMMENT '会員ランク 1:ダイヤモンド 2:プラチナ 3:ゴールド 4:シルバー 5:ブロンズ',
	`src_visit_ranking_status` TINYINT default 1 COMMENT '来店回数ランキングによる絞り込み(0:指定あり 1:指定なし)',
	`src_visit_ranking_span_type` TINYINT default 1 COMMENT '集計期間タイプ(1:月単位 2:週単位)',
	`src_visit_ranking_span_monthly` TINYINT COMMENT '集計期間(何ヶ月分)',
	`src_visit_ranking_span_weekly` TINYINT COMMENT '集計期間(何週間分)',
	`src_visit_ranking_from` INTEGER(3) COMMENT '上位何位から',
	`src_visit_ranking_to` INTEGER(3) COMMENT '上位何位まで',
	`send_date_type` TINYINT COMMENT '配信日時タイプ 1:初回登録のN日後のN時台に配信(誕生日のN日前のN時台に配信) 2:初回登録からN時間後に配信(誕生日当日のN時台に配信) 3:月初(1日)のN時台に配信',
	`send_day` TINYINT COMMENT '配信日時:日設定(登録日からN日後／毎月N日／毎週N曜日／誕生日のN日前)',
	`send_hour` TINYINT COMMENT '配信日時:時間設定(N時台に配信、N時間後に配信)',
	`send_repeat` TINYINT COMMENT '配信周期 1:毎月 2:毎週 (リピートメールのみ)',
	`send_condition_type` TINYINT default 0 NOT NULL COMMENT '配信条件種別タイプ 0:最終来店 1:初回来店 2:期限切れ告知',
	`send_condition_span_1` TINYINT COMMENT '配信条件1 期間',
	`send_condition_unit_1` TINYINT COMMENT '配信条件1 単位 1:ヶ月 2:日',
	`send_condition_span_2` TINYINT COMMENT '配信条件2 期間',
	`send_condition_unit_2` TINYINT COMMENT '配信条件2 単位 1:ヶ月 2:日',
	`send_condition_span_3` TINYINT COMMENT '配信条件3 期間',
	`send_condition_unit_3` TINYINT COMMENT '配信条件3 単位 1:ヶ月 2:日',
	`send_condition_span_4` TINYINT COMMENT '配信条件4 期間',
	`send_condition_unit_4` TINYINT COMMENT '配信条件4 単位 1:ヶ月 2:日',
	`send_condition_span_5` TINYINT COMMENT '配信条件5 期間',
	`send_condition_unit_5` TINYINT COMMENT '配信条件5 単位 1:ヶ月 2:日',
	`repeat_start` DATETIME COMMENT 'リピート開始日時',
	`repeat_end` DATETIME COMMENT 'リピート終了時間(無期限の場合はNULL)',
	`coupon_start` TINYINT COMMENT 'クーポン利用開始日',
	`coupon_end` SMALLINT COMMENT 'クーポン利用終了日(開始月の末日まではNULL)',
	`coupon_start_h` TINYINT COMMENT 'クーポン有効時刻開始(時)',
	`coupon_start_m` TINYINT COMMENT 'クーポン有効時刻開始(分)',
	`coupon_end_time_type` TINYINT COMMENT 'クーポン有効時刻終了種別 0:当日 1:翌日',
	`coupon_end_h` TINYINT COMMENT 'クーポン有効時刻終了(時)',
	`coupon_end_m` TINYINT COMMENT 'クーポン有効時刻終了(分)',
	`coupon_use_max_num` INTEGER COMMENT 'クーポン利用可能回数',
	`coupon_text` TEXT COMMENT 'クーポン内容',
	`send_html_mail` TINYINT default 0 NOT NULL COMMENT 'HTMLメールかどうか 0:テキストメール, 1:HTMLメール',
	`use_coupon_status` TINYINT default 0 NOT NULL COMMENT '利用できるクーポンの数 0:どれかひとつ 1:それぞれの個別指定に従う',
	`common_coupon_limit_status` TINYINT default 0 NOT NULL COMMENT '複数クーポン配信制限共通設定 0:共通 1:個別',
	`shop_rsv_dptm_id` INTEGER(10) default 0 COMMENT '部門ID(自動車ph6)',
	`shop_rsv_ct_opt_id_1` INTEGER(10) default 0 COMMENT '予約カテゴリID_1(自動車ph6)',
	`shop_rsv_ct_opt_id_2` INTEGER(10) default 0 COMMENT '予約カテゴリID_2(自動車ph6)',
	`shop_rsv_ct_opt_id_3` INTEGER(10) default 0 COMMENT '予約カテゴリID_3(自動車ph6)',
	`shop_rsv_ct_opt_id_4` INTEGER(10) default 0 COMMENT '予約カテゴリID_4(自動車ph6)',
	`shop_rsv_ct_opt_id_5` INTEGER(10) default 0 COMMENT '予約カテゴリID_5(自動車ph6)',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	KEY `index_01`(`shop_id`, `status`)
) COMMENT='店舗のリピートメール送信設定';

#-----------------------------------------------------------------------------
#-- repeat_shop_mail
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `repeat_shop_mail`;


CREATE TABLE `repeat_shop_mail`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	`repeat_mail_id` INTEGER COMMENT 'リピートメールID',
	`shop_mail_id` INTEGER COMMENT '店舗メールID',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	KEY `index_01`(`repeat_mail_id`, `shop_mail_id`),
	INDEX `repeat_shop_mail_FI_2` (`shop_mail_id`)
) COMMENT='送信されたリピートメール';

#-----------------------------------------------------------------------------
#-- shop_member_first
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `shop_member_first`;


CREATE TABLE `shop_member_first`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID',
	`member_id` INTEGER  NOT NULL COMMENT '会員ID',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	UNIQUE KEY `shop_member_first_uniq` (`shop_id`, `member_id`),
	KEY `index_01`(`shop_id`, `member_id`, `created_at`)
) COMMENT='マイショップ初回登録(過去60日分のみ保持)';

#-----------------------------------------------------------------------------
#-- receipt_no_seq
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `receipt_no_seq`;


CREATE TABLE `receipt_no_seq`
(
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID',
	`department_id` BIGINT default -1 NOT NULL COMMENT '部門ID(部門なしの場合は-1)',
	`receipt_no_date` DATETIME  NOT NULL COMMENT '受付番号発番日',
	`cur_receipt_no` INTEGER default 1 NOT NULL COMMENT '受付番号現在値',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`shop_id`,`department_id`,`receipt_no_date`)
) COMMENT='受付番号発番テーブル';

#-----------------------------------------------------------------------------
#-- regist_no_log
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `regist_no_log`;


CREATE TABLE `regist_no_log`
(
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID',
	`department_id` BIGINT default -1 NOT NULL COMMENT '部門ID(部門なしの場合は-1)',
	`regist_no_date` DATETIME  NOT NULL COMMENT '受付番号発番日',
	`regist_no` INTEGER default 1 NOT NULL COMMENT '受付番号',
	`status` TINYINT default 0 NOT NULL COMMENT 'ステータス　0:使用中, 1:キャンセル, 2:前倒し案内, 3:空き',
	`created_at` DATETIME,
	PRIMARY KEY (`shop_id`,`department_id`,`regist_no_date`,`regist_no`)
) COMMENT='受付番号発番管理テーブル';

#-----------------------------------------------------------------------------
#-- game_corner
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `game_corner`;


CREATE TABLE `game_corner`
(
	`id` TINYINT  NOT NULL COMMENT '掲載順（表示順）',
	`status` TINYINT default 1 COMMENT '状態（0:非表示 1:表示）',
	`title` VARCHAR(255) COMMENT 'タイトル',
	`url` VARCHAR(255) COMMENT 'ＵＲＬ',
	`image` VARCHAR(255) COMMENT '画像',
	`description` VARCHAR(255) COMMENT '説明',
	`start_date` DATE COMMENT '開始日付',
	`end_date` DATE COMMENT '終了日付',
	`created_at` DATETIME COMMENT 'レコード作成日時',
	`updated_at` DATETIME COMMENT 'レコード更新日時',
	PRIMARY KEY (`id`),
	KEY `index_status`(`status`),
	KEY `index_start_date`(`start_date`),
	KEY `index_end_date`(`end_date`)
) COMMENT='ゲームコーナー用テーブル';

#-----------------------------------------------------------------------------
#-- coupon_box_display_pref
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `coupon_box_display_pref`;


CREATE TABLE `coupon_box_display_pref`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	`coupon_box_id` INTEGER  NOT NULL COMMENT 'クーポンBOXID',
	`pref_id` INTEGER  NOT NULL COMMENT '都道府県ID',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	UNIQUE KEY `coupon_box_id_pref_id_uniq` (`coupon_box_id`, `pref_id`),
	INDEX `coupon_box_display_pref_FI_2` (`pref_id`)
) COMMENT='クーポンBOX表示対象都道府県';

#-----------------------------------------------------------------------------
#-- assess_config
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `assess_config`;


CREATE TABLE `assess_config`
(
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ＩＤ',
	`assess_button_label` VARCHAR(4) default '査定完了' COMMENT 'ボタン表示名',
	`display_type1_title` VARCHAR(20) default '現在の査定状況' COMMENT '表示機タイトル(項目名)',
	`display_type1_message1` VARCHAR(20) default '左記の番号まで査定が完了しております。' COMMENT '完了表示版右メッセージ',
	`display_type1_message2` VARCHAR(20) default '下記の番号の査定は完了しております。' COMMENT '完了表示版下メッセージ',
	`display_type2_title` VARCHAR(20) default '現在の査定状況' COMMENT '表示機タイトル(項目名)',
	`display_type2_message1` VARCHAR(20) default '左記の番号まで査定が完了しております。' COMMENT '完了表示版右メッセージ',
	`display_type2_message2` VARCHAR(20) default '下記の番号は査定中です。' COMMENT '完了表示版下メッセージ',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`shop_id`)
) COMMENT='査定店舗用 設定ファイル';

#-----------------------------------------------------------------------------
#-- holidays
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `holidays`;


CREATE TABLE `holidays`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	`date` DATE  NOT NULL COMMENT '日付',
	`name` VARCHAR(255) default '' NOT NULL COMMENT '名前',
	`wday_name` CHAR(1) default '' NOT NULL COMMENT '曜日名',
	`culture_cd` VARCHAR(5) COMMENT '言語コード',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	KEY `index_date`(`date`)
) COMMENT='祝日マスタ';

#-----------------------------------------------------------------------------
#-- shop_display_order
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `shop_display_order`;


CREATE TABLE `shop_display_order`
(
	`service_code` VARCHAR(8)  NOT NULL COMMENT 'サービスコード',
	`SHOP_CODE` VARCHAR(32)  NOT NULL COMMENT '施設コード',
	`mobile_reservable` INTEGER default 0 NOT NULL COMMENT '携帯受付中 （1:受付中 ＞ 0:停止中）',
	`shop_open_today` INTEGER default 0 NOT NULL COMMENT '営業日 （1:営業日 ＞ 0:休業日）',
	`shop_open_now` INTEGER default 0 NOT NULL COMMENT '営業時間 （1:営業中 ＞ 0:時間外）',
	`wait_time` INTEGER default 0 NOT NULL COMMENT '待ち時間 （x:長い ＞ 0:短い)',
	`photo_count` INTEGER default 0 NOT NULL COMMENT '写真 （x:多い ＞ 少ない）',
	`wait_time_display` INTEGER default 0 NOT NULL COMMENT '停止中待ち時間表示 （1:表示 ＞ 0:非表示）',
	`department` INTEGER default 0 NOT NULL COMMENT '部門管理 （1:導入 ＞ 0:未導入）',
	`first_time_amenity` INTEGER default 0 NOT NULL COMMENT '初回特典権限 （1:あり ＞ 0:なし）',
	`invite` INTEGER default 0 NOT NULL COMMENT '友達紹介 （1:あり ＞ 0:なし）',
	`contract_type` INTEGER default 0 NOT NULL COMMENT '契約タイプ （1:通常コース ＞ 0: ライトコース）',
	`shop_mail` INTEGER default 0 NOT NULL COMMENT 'メール配信権限 （1:あり ＞ 0:なし）',
	`shop_name_kana` VARCHAR(255) default '0' NOT NULL COMMENT '店舗名かな',
	`max_wait_time_last_month` SMALLINT default 0 NOT NULL COMMENT '待ち時間最大値（前月）',
	`max_wait_count_last_month` SMALLINT default 0 NOT NULL COMMENT '待ち組数最大値（前月）待ち組数最大値（前月）',
	`report_count` INTEGER default 0 NOT NULL COMMENT 'Eネ!レポの件数',
	`display_point` DECIMAL(10,2) default 0 NOT NULL COMMENT '並び順点数',
	`wanted_count` INTEGER default 0 NOT NULL COMMENT '携帯受付したい数',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`service_code`,`SHOP_CODE`),
	KEY `shop_display_order_I_1`(`mobile_reservable`),
	KEY `shop_display_order_I_2`(`shop_open_today`),
	KEY `shop_display_order_I_3`(`shop_open_now`),
	KEY `shop_display_order_I_4`(`wait_time`),
	KEY `shop_display_order_I_5`(`photo_count`),
	KEY `shop_display_order_I_6`(`wait_time_display`),
	KEY `shop_display_order_I_7`(`department`),
	KEY `shop_display_order_I_8`(`first_time_amenity`),
	KEY `shop_display_order_I_9`(`invite`),
	KEY `shop_display_order_I_10`(`contract_type`),
	KEY `shop_display_order_I_11`(`shop_mail`),
	KEY `shop_display_order_I_12`(`shop_name_kana`),
	KEY `shop_display_order_I_13`(`max_wait_time_last_month`),
	KEY `shop_display_order_I_14`(`max_wait_count_last_month`),
	KEY `shop_display_order_I_15`(`report_count`)
) COMMENT='施設並べ替え用 インデックステーブル(cronによるメンテ)';

#-----------------------------------------------------------------------------
#-- assess_finish
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `assess_finish`;


CREATE TABLE `assess_finish`
(
	`receive_id` BIGINT  NOT NULL COMMENT '予約受付データID',
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ＩＤ',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`receive_id`),
	KEY `index_shop_id`(`shop_id`)
) COMMENT='「査定完了」管理テーブル';

#-----------------------------------------------------------------------------
#-- member_summary_history
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `member_summary_history`;


CREATE TABLE `member_summary_history`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	`target_date` DATE  NOT NULL COMMENT '集計対象日',
	`member_total` INTEGER default 0 NOT NULL COMMENT '総会員数-累計',
	`member_change` INTEGER default 0 NOT NULL COMMENT '総会員数-増減',
	`member_increase` INTEGER default 0 NOT NULL COMMENT '総会員数-増加',
	`member_decrease` INTEGER default 0 NOT NULL COMMENT '総会員数-減少',
	`member_android_total` INTEGER default 0 NOT NULL COMMENT '総会員数-Android',
	`member_android_increase` INTEGER default 0 NOT NULL COMMENT '総会員数-Android増加',
	`member_android_decrease` INTEGER default 0 NOT NULL COMMENT '総会員数-Android減少',
	`member_iphone_total` INTEGER default 0 NOT NULL COMMENT '総会員数-iPhone',
	`member_iphone_increase` INTEGER default 0 NOT NULL COMMENT '総会員数-iPhone増加',
	`member_iphone_decrease` INTEGER default 0 NOT NULL COMMENT '総会員数-iPhone減少',
	`multiple_shop_member_total` INTEGER default 0 NOT NULL COMMENT '複数店舗登録会員数',
	`pay_member_total` INTEGER default 0 NOT NULL COMMENT '有料会員-累計',
	`pay_member_increase` INTEGER default 0 NOT NULL COMMENT '有料会員-増加',
	`pay_member_decrease` INTEGER default 0 NOT NULL COMMENT '有料会員-減少',
	`gold_member_total` INTEGER default 0 NOT NULL COMMENT 'ゴールド会員-累計',
	`gold_member_increase` INTEGER default 0 NOT NULL COMMENT 'ゴールド会員-増加',
	`gold_member_decrease` INTEGER default 0 NOT NULL COMMENT 'ゴールド会員-減少',
	`prize_mail_available_total` INTEGER default 0 NOT NULL COMMENT '懸賞メール-配信可能会員数',
	`prize_mail_available_increase` INTEGER default 0 NOT NULL COMMENT '懸賞メール-増加',
	`prize_mail_available_decrease` INTEGER default 0 NOT NULL COMMENT '懸賞メール-減少',
	`kura_member_total` INTEGER default 0 NOT NULL COMMENT 'くら寿司会員-累計',
	`kura_member_increase` INTEGER default 0 NOT NULL COMMENT 'くら寿司会員-増加',
	`kura_member_decrease` INTEGER default 0 NOT NULL COMMENT 'くら寿司会員-減少',
	`kura_mail_total` INTEGER default 0 NOT NULL COMMENT 'くらメール-配信可能会員数',
	`kura_mail_increase` INTEGER default 0 NOT NULL COMMENT 'くらメール-増加',
	`kura_mail_decrease` INTEGER default 0 NOT NULL COMMENT 'くらメール-減少',
	`muzinzou_mail_available_total` INTEGER default 0 NOT NULL COMMENT '無尽蔵メール-配信可能会員数',
	`muzinzou_mail_available_increase` INTEGER default 0 NOT NULL COMMENT '無尽蔵メール-増加',
	`muzinzou_mail_available_decrease` INTEGER default 0 NOT NULL COMMENT '無尽蔵メール-減少',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	UNIQUE KEY `index_target_date` (`target_date`)
) COMMENT='会員数集計テーブル';

#-----------------------------------------------------------------------------
#-- tmp_receive
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `tmp_receive`;


CREATE TABLE `tmp_receive`
(
	`id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT 'ID',
	`reserve_id` BIGINT COMMENT '使ってはいけない! 旧システムからのデータ移行のとき、店舗ごとの予約IDを保持する 新システムでは参照しない',
	`owner_shop_id` BIGINT COMMENT 'オーナーID',
	`shop_id` BIGINT COMMENT '店舗ID',
	`member_id` INTEGER default 0 COMMENT '会員ＩＤ',
	`reserve_status` TINYINT COMMENT '予約状態 0:予約 9:削除 旧： 予約状態 0:予約 1:キャンセル 2:未来店 3:不明 9:削除',
	`reserve_type` TINYINT COMMENT '予約タイプ 0:順番待ち 1:予約',
	`is_send` TINYINT default 0 COMMENT 'メール送信状態 0:未送信 1:送信済み',
	`is_send_information` TINYINT default 0 COMMENT '有料会員N分前送信フラグ 0:未送信 1:送信済み',
	`information_mail_time` SMALLINT default 0 COMMENT '有料会員N分前設定時間 0:送信しない',
	`receipt_no` INTEGER default 0 COMMENT '受付番号',
	`receipt_date` DATETIME COMMENT '案内予定日時 ※席に着きたい時間 順番待ちの場合は受付日時 時間指定・将来順番待ちの時は予約時に指定した日時 「戻す」場合は割り込ませたい順番になるようにこの日時を変更',
	`agent_date` DATETIME COMMENT '予約代行の目標案内予定時間（会員の登録した予約希望時間）',
	`late_date` DATETIME COMMENT '遅刻した場合、到着した日時(推測) 無断キャンセルから「戻す」をした時に、receipt_date がコピーされていることを確認',
	`guide_status` TINYINT COMMENT '案内状態 0:未案内 1:案内済 2:不在 3:無断キャンセル 4:案内済再案内 5:不在再案内 6:接客中 7:接客中再案内 8:キャンセル 旧：案内状態 0:未案内 1:案内済み 2:呼び出し済み（現在expired扱い。callはどうしようか？）',
	`wait_count` SMALLINT default 0 COMMENT '待ち回数 (無断キャンセルになる毎にインクリメントされている)',
	`wait_count_on_entry` SMALLINT COMMENT '順番取り時の待ち組数',
	`wait_time` SMALLINT default 0 COMMENT '待ち時間(分) (新規作成時に設定した後は更新されない) (要らない疑惑)',
	`wait_time_on_entry` SMALLINT COMMENT '順番取り時の待ち時間',
	`guide_date` DATETIME COMMENT '案内日付 (案内済になった日時、guided_at の方が適切な名前)',
	`call_date` DATETIME COMMENT '呼び出し日付 (呼び出した日時ではなく、「不在」状態になった日時、「呼出」ボタンとは無関係)',
	`call_cnt` TINYINT default 0 COMMENT '呼び出し回数 (「不在」状態になる度にインクリメントされる)',
	`regist_no` VARCHAR(100) COMMENT '部門別受付ＮＯ',
	`regist_both_no` VARCHAR(100) COMMENT 'どちらでも受付ＮＯ',
	`shop_reserve_condition_id` BIGINT COMMENT '部門選択条件ID',
	`shop_reserve_condition_value` VARCHAR(100) COMMENT '部門選択条件内容',
	`shop_reserve_department_id` BIGINT COMMENT '部門ID null:移行データ（部門なし店舗も含む）',
	`shop_reserve_department_value` VARCHAR(100) COMMENT '部門名',
	`shop_reserve_category_id_1` BIGINT COMMENT '条件１ＩＤ',
	`shop_reserve_category_value_1` VARCHAR(100) COMMENT '条件１内容',
	`shop_reserve_category_id_2` BIGINT COMMENT '条件２ＩＤ',
	`shop_reserve_category_value_2` VARCHAR(100) COMMENT '条件２内容',
	`shop_reserve_category_id_3` BIGINT COMMENT '条件３ＩＤ',
	`shop_reserve_category_value_3` VARCHAR(100) COMMENT '条件３内容',
	`shop_reserve_category_id_4` BIGINT COMMENT '条件４ＩＤ',
	`shop_reserve_category_value_4` VARCHAR(100) COMMENT '条件４内容',
	`shop_reserve_category_id_5` BIGINT COMMENT '条件５ＩＤ',
	`shop_reserve_category_value_5` VARCHAR(100) COMMENT '条件５内容',
	`check_status` TINYINT default 0 COMMENT 'default=0  「タッチパネル来店客チェック」なる機能に使用する',
	`voice_play_status` TINYINT default 0 COMMENT '音声案内済（呼出済）フラグ 0:呼出前 1:呼出済',
	`voice_play_date` DATETIME COMMENT '音声案内 呼出日時',
	`is_main_dochirademo` TINYINT default 0 COMMENT 'default=0  「どちらでも部門」受付データの正データかの判定に使用する 0:副データ 1:正データ',
	`memo` VARCHAR(100) COMMENT 'メモ',
	`spare1` BIGINT COMMENT '予備１',
	`spare2` VARCHAR(100) COMMENT '予備２ 連続受付用にSESSID を入れます。',
	`entry_date` DATETIME COMMENT 'レコード作成日時',
	`entry_type` TINYINT COMMENT '予約登録元 0:PC管理画面 1:PC表側 2:携帯管理画面 3:携帯表側 4:タッチパネル管理画面 5:タッチパネル 6:API 7:スマートフォンサイト ※ 1:PC表側 は使用していない様子',
	`created_at` DATETIME COMMENT 'レコード作成日時',
	`updated_at` DATETIME COMMENT 'レコード更新日時',
	PRIMARY KEY (`id`),
	KEY `index_shop_id`(`shop_id`),
	KEY `index_member_id`(`member_id`),
	KEY `index_receipt_date`(`receipt_date`),
	KEY `index_regist_no`(`regist_no`),
	KEY `index_regist_both_no`(`regist_both_no`),
	KEY `index_shop_reserve_department_id`(`shop_reserve_department_id`),
	KEY `index_guide_date`(`guide_date`),
	KEY `index_send_information`(`is_send_information`, `information_mail_time`),
	KEY `index_spare2`(`spare2`)
) COMMENT='当日分の予約受付データの格納テーブル';

#-----------------------------------------------------------------------------
#-- report
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `report`;


CREATE TABLE `report`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT COMMENT 'Eネ!レポID',
	`shop_id` INTEGER COMMENT '店舗ＩＤ',
	`request_id` INTEGER COMMENT '店舗リクエストＩＤ',
	`member_id` INTEGER  NOT NULL COMMENT '会員ID',
	`title` VARCHAR(255) COMMENT 'タイトル',
	`text` TEXT COMMENT '本文',
	`status` TINYINT COMMENT 'ステータス０：無効１：有効',
	`sex` TINYINT  NOT NULL COMMENT '性別０：男性１：女性',
	`wait_time` VARCHAR(255) COMMENT '待ち時間',
	`report_year` SMALLINT  NOT NULL COMMENT '利用日時（年）',
	`report_month` TINYINT  NOT NULL COMMENT '利用日時（月）',
	`report_day` TINYINT  NOT NULL COMMENT '利用日時（曜日）',
	`report_is_holiday` TINYINT  NOT NULL COMMENT '利用日時（祝日フラグ）',
	`is_lunch` TINYINT  NOT NULL COMMENT 'ディナー/ランチの別1:昼 0:夜',
	`evaluation_taste` DECIMAL(2,1)  NOT NULL COMMENT '評価：美味しさ',
	`evaluation_service` DECIMAL(2,1)  NOT NULL COMMENT '評価：サービス',
	`evaluation_price` DECIMAL(2,1)  NOT NULL COMMENT '評価：値段に対しての味',
	`evaluation_again` DECIMAL(2,1)  NOT NULL COMMENT '評価：また行きたい',
	`child_evaluation_menu` DECIMAL(2,1) COMMENT '子供評価：お子様メニュー',
	`child_evaluation_fun` DECIMAL(2,1) COMMENT '子供評価：お楽しみ要素',
	`child_evaluation_stay` DECIMAL(2,1) COMMENT '子供評価：滞在のし易さ',
	`child_evaluation_other_child` DECIMAL(2,1) COMMENT '子供評価：他のお子様連れ人数',
	`scene_one_person` TINYINT  NOT NULL COMMENT '利用シーン：おひとり',
	`scene_family` TINYINT  NOT NULL COMMENT '利用シーン：ファミリー',
	`scene_friends` TINYINT  NOT NULL COMMENT '利用シーン：フレンド',
	`scene_drinking_party` TINYINT  NOT NULL COMMENT '利用シーン：飲み会',
	`scene_date` TINYINT  NOT NULL COMMENT '利用シーン：デート',
	`scene_business` TINYINT  NOT NULL COMMENT '利用シーン：ビジネス',
	`category_calm` TINYINT  NOT NULL COMMENT 'カテゴリー詳細：静かで落ち着いている',
	`category_bustling` TINYINT  NOT NULL COMMENT 'カテゴリー詳細：ワイワイ賑やか',
	`category_nostalgia` TINYINT  NOT NULL COMMENT 'カテゴリー詳細：懐かしい雰囲気',
	`category_zashiki` TINYINT  NOT NULL COMMENT 'カテゴリー詳細：座敷がある',
	`category_private_room_zashiki` TINYINT  NOT NULL COMMENT 'カテゴリー詳細：個室（座敷）',
	`category_private_room_table` TINYINT  NOT NULL COMMENT 'カテゴリー詳細：個室（テーブル）',
	`category_near_station` TINYINT  NOT NULL COMMENT 'カテゴリー詳細：駅から5分',
	`category_theme` TINYINT  NOT NULL COMMENT 'カテゴリー詳細：テーマレストラン',
	`category_sweets` TINYINT  NOT NULL COMMENT 'カテゴリー詳細：スイーツが充実',
	`category_filling` TINYINT  NOT NULL COMMENT 'カテゴリー詳細：ボリューム自慢',
	`category_bottomless_cup` TINYINT  NOT NULL COMMENT 'カテゴリー詳細：飲み放題有り',
	`category_all_you_can_eat` TINYINT  NOT NULL COMMENT 'カテゴリー詳細：食べ放題有り',
	`category_karaoke` TINYINT  NOT NULL COMMENT 'カテゴリー詳細：カラオケ有り',
	`category_student_discount` TINYINT  NOT NULL COMMENT 'カテゴリー詳細：学割有り',
	`category_girls_gathering` TINYINT  NOT NULL COMMENT 'カテゴリー詳細：女子会向け',
	`category_pets` TINYINT  NOT NULL COMMENT 'カテゴリー詳細：ペット可',
	`category_reviewed` TINYINT  NOT NULL COMMENT 'カテゴリー詳細：TV/雑誌で紹介された',
	`category_cinema` TINYINT  NOT NULL COMMENT 'カテゴリー詳細：映画館の近く',
	`category_childrens_playground` TINYINT  NOT NULL COMMENT 'カテゴリー詳細：キッズスペース有り',
	`category_diaper` TINYINT  NOT NULL COMMENT 'カテゴリー詳細：おむつ交換スペース有り',
	`category_multipurpose_toilet` TINYINT  NOT NULL COMMENT 'カテゴリー詳細：多目的トイレ有り',
	`category_wheelchair` TINYINT  NOT NULL COMMENT 'カテゴリー詳細：バリアフリー',
	`category_magazine` TINYINT  NOT NULL COMMENT 'カテゴリー詳細：雑誌が置いてある',
	`category_ceremonial_occasions` TINYINT  NOT NULL COMMENT 'カテゴリー詳細：冠婚葬祭で使える',
	`category_night_view` TINYINT  NOT NULL COMMENT 'カテゴリー詳細：夜景がキレイ',
	`category_ocean_view` TINYINT  NOT NULL COMMENT 'カテゴリー詳細：海が見える',
	`category_green` TINYINT  NOT NULL COMMENT 'カテゴリー詳細：緑に囲まれている',
	`category_birthday` TINYINT  NOT NULL COMMENT 'カテゴリー詳細：誕生日特典有り',
	`category_late_night` TINYINT  NOT NULL COMMENT 'カテゴリー詳細：深夜でも営業している',
	`category_calories` TINYINT  NOT NULL COMMENT 'カテゴリー詳細：カロリー表示有り',
	`category_alergy` TINYINT  NOT NULL COMMENT 'カテゴリー詳細：アレルギー表示有り',
	`category_kids_menu` TINYINT  NOT NULL COMMENT 'カテゴリー詳細：お子様メニュー有り',
	`comment_count` INTEGER  NOT NULL COMMENT 'コメント数',
	`like_count` INTEGER  NOT NULL COMMENT 'Eね数',
	`is_mobile` TINYINT  NOT NULL COMMENT 'PC/モバイルの別',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	INDEX `report_FI_1` (`shop_id`),
	INDEX `report_FI_2` (`request_id`)
) COMMENT='Eネ!レポ';

#-----------------------------------------------------------------------------
#-- member_profile
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `member_profile`;


CREATE TABLE `member_profile`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT COMMENT '会員プロフィールID',
	`member_id` INTEGER  NOT NULL COMMENT '会員ID',
	`profile_name` VARCHAR(255) COMMENT 'Eネ!レポ投稿者名',
	`ranking_points` INTEGER default 0 COMMENT 'ランキングポイント',
	`report_privilege` TINYINT default 1 NOT NULL COMMENT 'Eネ!レポ使用権限',
	`frequent_places` VARCHAR(255)  NOT NULL COMMENT 'よく利用する地域',
	`work_id` TINYINT COMMENT '職業',
	`self_introduction` TEXT  NOT NULL COMMENT '自己紹介',
	`hobby` VARCHAR(255)  NOT NULL COMMENT '趣味（, separated values）',
	`is_public_prefecture` TINYINT  NOT NULL COMMENT '公開設定：都道府県',
	`is_public_gender` TINYINT  NOT NULL COMMENT '公開設定：性別',
	`is_public_birthday` TINYINT  NOT NULL COMMENT '公開設定：生年月日',
	`is_public_work` TINYINT  NOT NULL COMMENT '公開設定：職業',
	`is_public_hobby` TINYINT  NOT NULL COMMENT '公開設定：趣味',
	`is_public_frequent_places` TINYINT  NOT NULL COMMENT '公開設定：よく利用する地域',
	`is_public_visited_shops` TINYINT  NOT NULL COMMENT '公開設定：最近利用した施設',
	`is_public_self_introduction` TINYINT  NOT NULL COMMENT '公開設定：自己紹介',
	`mail_on_report` TINYINT  NOT NULL COMMENT 'メール設定：Eネ!レポ投稿完了',
	`mail_on_edit_report` TINYINT  NOT NULL COMMENT 'メール設定：Eネ!レポ編集完了',
	`mail_on_remove_report` TINYINT  NOT NULL COMMENT 'メール設定：Eネ!レポ削除完了',
	`mail_on_post_pictures` TINYINT  NOT NULL COMMENT 'メール設定：写真投稿完了',
	`mail_on_remove_pictures` TINYINT  NOT NULL COMMENT 'メール設定：写真削除完了',
	`mail_on_comment` TINYINT  NOT NULL COMMENT 'メール設定：他人のEネ!レポにコメントした',
	`mail_on_like` TINYINT  NOT NULL COMMENT 'メール設定：他人のEネ!レポにいいねを押した',
	`mail_on_commented` TINYINT  NOT NULL COMMENT 'メール設定：コメントされた',
	`mail_on_liked` TINYINT  NOT NULL COMMENT 'メール設定：いいねを押された',
	`mail_on_request_shop` TINYINT  NOT NULL COMMENT 'メール設定：店舗リクエスト',
	`mail_on_inform` TINYINT  NOT NULL COMMENT 'メール設定：通報した',
	`photo_s` VARCHAR(255) COMMENT '写真（小）ファイル名',
	`photo_l` VARCHAR(255) COMMENT '写真（大）ファイル名',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	`mail_on_delete_comment` TINYINT  NOT NULL COMMENT 'メール設定：他人のEネ!レポのコメントを削除した',
	`mail_on_deleted_comment` TINYINT  NOT NULL COMMENT 'メール設定：コメントが削除された',
	PRIMARY KEY (`id`),
	UNIQUE KEY `member_profile_U_1` (`member_id`),
	KEY `member_profile_K_1`(`report_privilege`, `ranking_points`)
) COMMENT='会員プロフィール';

#-----------------------------------------------------------------------------
#-- shop_report_summary
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `shop_report_summary`;


CREATE TABLE `shop_report_summary`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT COMMENT 'Eネ!レポ集計情報ID',
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ＩＤ',
	`max_wait_time_last_month` SMALLINT default 0 COMMENT '待ち時間最大値（前月）',
	`max_wait_count_last_month` SMALLINT default 0 COMMENT '待ち組数最大値（前月）',
	`wait_time_last_month_modified_at` DATETIME COMMENT '待ち時間最大値（前月）を更新した時刻',
	`max_wait_time_this_month` SMALLINT default 0 COMMENT '待ち時間最大値（今月）',
	`max_wait_count_this_month` SMALLINT default 0 COMMENT '待ち組数最大値（今月）',
	`report_count` INTEGER default 0 COMMENT 'Eネ!レポの件数',
	`general_evaluation` DECIMAL(4,3) default 0 COMMENT '総合評価',
	`evaluation_taste` DECIMAL(4,3) default 0 COMMENT '総合評価：美味しさ',
	`evaluation_service` DECIMAL(4,3) default 0 COMMENT '総合評価：サービス',
	`evaluation_price` DECIMAL(4,3) default 0 COMMENT '総合評価：値段に対しての味',
	`evaluation_again` DECIMAL(4,3) default 0 COMMENT '総合評価：また行きたい',
	`evaluation_women_taste` DECIMAL(4,3) default 0 COMMENT '女性評価：美味しさ',
	`evaluation_women_service` DECIMAL(4,3) default 0 COMMENT '女性評価：サービス',
	`evaluation_women_price` DECIMAL(4,3) default 0 COMMENT '女性評価：値段に対しての味',
	`evaluation_women_again` DECIMAL(4,3) default 0 COMMENT '女性評価：また行きたい',
	`evaluation_men_taste` DECIMAL(4,3) default 0 COMMENT '男性評価：美味しさ',
	`evaluation_men_service` DECIMAL(4,3) default 0 COMMENT '男性評価：サービス',
	`evaluation_men_price` DECIMAL(4,3) default 0 COMMENT '男性評価：値段に対しての味',
	`evaluation_men_again` DECIMAL(4,3) default 0 COMMENT '男性評価：また行きたい',
	`evaluation_child_menu` DECIMAL(4,3) default 0 COMMENT '子ども評価：お子様メニュー',
	`evaluation_child_fun` DECIMAL(4,3) default 0 COMMENT '子ども評価：お楽しみ要素',
	`evaluation_child_stay` DECIMAL(4,3) default 0 COMMENT '子ども評価：滞在のし易さ',
	`evaluation_child_other_child` DECIMAL(4,3) default 0 COMMENT '子ども評価：他のお子様連れ人数',
	`scene_one_person` TINYINT  NOT NULL COMMENT 'おひとりフラグ',
	`scene_family` TINYINT  NOT NULL COMMENT 'ファミリーフラグ',
	`scene_friends` TINYINT  NOT NULL COMMENT 'フレンドフラグ',
	`scene_drinking_party` TINYINT  NOT NULL COMMENT '飲み会フラグ',
	`scene_date` TINYINT  NOT NULL COMMENT 'デートフラグ',
	`scene_business` TINYINT  NOT NULL COMMENT 'ビジネスフラグ',
	`category_calm` TINYINT  NOT NULL COMMENT 'カテゴリー詳細：静かで落ち着いている',
	`category_bustling` TINYINT  NOT NULL COMMENT 'カテゴリー詳細：ワイワイ賑やか',
	`category_nostalgia` TINYINT  NOT NULL COMMENT 'カテゴリー詳細：懐かしい雰囲気',
	`category_zashiki` TINYINT  NOT NULL COMMENT 'カテゴリー詳細：座敷がある',
	`category_private_room_zashiki` TINYINT  NOT NULL COMMENT 'カテゴリー詳細：個室（座敷）',
	`category_private_room_table` TINYINT  NOT NULL COMMENT 'カテゴリー詳細：個室（テーブル）',
	`category_near_station` TINYINT  NOT NULL COMMENT 'カテゴリー詳細：駅から5分',
	`category_theme` TINYINT  NOT NULL COMMENT 'カテゴリー詳細：テーマレストラン',
	`category_sweets` TINYINT  NOT NULL COMMENT 'カテゴリー詳細：スイーツが充実',
	`category_filling` TINYINT  NOT NULL COMMENT 'カテゴリー詳細：ボリューム自慢',
	`category_bottomless_cup` TINYINT  NOT NULL COMMENT 'カテゴリー詳細：飲み放題有り',
	`category_all_you_can_eat` TINYINT  NOT NULL COMMENT 'カテゴリー詳細：食べ放題有り',
	`category_karaoke` TINYINT  NOT NULL COMMENT 'カテゴリー詳細：カラオケ有り',
	`category_student_discount` TINYINT  NOT NULL COMMENT 'カテゴリー詳細：学割有り',
	`category_girls_gathering` TINYINT  NOT NULL COMMENT 'カテゴリー詳細：女子会向け',
	`category_pets` TINYINT  NOT NULL COMMENT 'カテゴリー詳細：ペット可',
	`category_reviewed` TINYINT  NOT NULL COMMENT 'カテゴリー詳細：TV/雑誌で紹介された',
	`category_cinema` TINYINT  NOT NULL COMMENT 'カテゴリー詳細：映画館の近く',
	`category_childrens_playground` TINYINT  NOT NULL COMMENT 'カテゴリー詳細：キッズスペース有り',
	`category_diaper` TINYINT  NOT NULL COMMENT 'カテゴリー詳細：おむつ交換スペース有り',
	`category_multipurpose_toilet` TINYINT  NOT NULL COMMENT 'カテゴリー詳細：多目的トイレ有り',
	`category_wheelchair` TINYINT  NOT NULL COMMENT 'カテゴリー詳細：車椅子でも使い易い',
	`category_magazine` TINYINT  NOT NULL COMMENT 'カテゴリー詳細：雑誌が置いてある',
	`category_ceremonial_occasions` TINYINT  NOT NULL COMMENT 'カテゴリー詳細：冠婚葬祭で使える',
	`category_night_view` TINYINT  NOT NULL COMMENT 'カテゴリー詳細：夜景がキレイ',
	`category_ocean_view` TINYINT  NOT NULL COMMENT 'カテゴリー詳細：海が見える',
	`category_green` TINYINT  NOT NULL COMMENT 'カテゴリー詳細：緑に囲まれている',
	`category_birthday` TINYINT  NOT NULL COMMENT 'カテゴリー詳細：誕生日特典有り',
	`category_late_night` TINYINT  NOT NULL COMMENT 'カテゴリー詳細：深夜でも営業している',
	`category_calories` TINYINT  NOT NULL COMMENT 'カテゴリー詳細：カロリー表示有り',
	`category_alergy` TINYINT  NOT NULL COMMENT 'カテゴリー詳細：アレルギー表示有り',
	`category_kids_menu` TINYINT  NOT NULL COMMENT 'カテゴリー詳細：お子様メニュー有り',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	UNIQUE KEY `shop_report_summary_U_1` (`shop_id`),
	KEY `index_max_wait_time_last_month`(`max_wait_time_last_month`),
	KEY `index_max_wait_count_last_month`(`max_wait_count_last_month`),
	KEY `index_max_wait_time_this_month`(`max_wait_time_this_month`),
	KEY `index_max_wait_count_this_month`(`max_wait_count_this_month`),
	KEY `index_report_count`(`report_count`),
	KEY `index_general_evaluation`(`general_evaluation`)
) COMMENT='Eネ!レポ集計情報';

#-----------------------------------------------------------------------------
#-- report_like_history
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `report_like_history`;


CREATE TABLE `report_like_history`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT COMMENT 'EねID',
	`report_id` INTEGER  NOT NULL COMMENT 'Eネ!レポID',
	`member_id` INTEGER  NOT NULL COMMENT '会員ID',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	UNIQUE KEY `report_like_history_uniq` (`report_id`, `member_id`)
) COMMENT='Eネ!レポ：Eね';

#-----------------------------------------------------------------------------
#-- report_comment
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `report_comment`;


CREATE TABLE `report_comment`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT COMMENT 'コメントID',
	`report_id` INTEGER  NOT NULL COMMENT 'Eネ!レポID',
	`member_id` INTEGER  NOT NULL COMMENT '会員ID',
	`comment` TEXT  NOT NULL COMMENT 'コメント',
	`status` TINYINT  NOT NULL COMMENT 'ステータス０：無効１：有効',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	INDEX `report_comment_FI_1` (`report_id`)
) COMMENT='Eネ!レポ：コメント';

#-----------------------------------------------------------------------------
#-- shop_user_photo
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `shop_user_photo`;


CREATE TABLE `shop_user_photo`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT COMMENT '写真ID',
	`report_id` INTEGER COMMENT 'Eネ!レポID',
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID',
	`member_id` INTEGER  NOT NULL COMMENT '会員ID',
	`original_filename` VARCHAR(255) default '' NOT NULL COMMENT '元ファイル名',
	`filename_xs` VARCHAR(255)  NOT NULL COMMENT 'ファイル名（最小）',
	`filename_s` VARCHAR(255)  NOT NULL COMMENT 'ファイル名（小）',
	`filename_l` VARCHAR(255)  NOT NULL COMMENT 'ファイル名（大）',
	`category_type` TINYINT  NOT NULL COMMENT '写真カテゴリタイプ0:店舗内写真1:料理写真2:メニュー写真3:店舗外観',
	`status` TINYINT  NOT NULL COMMENT 'ステータス０：無効１：有効２：仮登録',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	INDEX `shop_user_photo_FI_1` (`report_id`),
	INDEX `shop_user_photo_FI_2` (`shop_id`)
) COMMENT='ショップ：ユーザの写真';

#-----------------------------------------------------------------------------
#-- report_inform_history
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `report_inform_history`;


CREATE TABLE `report_inform_history`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT COMMENT '通報ID',
	`report_id` INTEGER COMMENT 'Eネ!レポID',
	`shop_user_photo_id` INTEGER COMMENT '写真ID',
	`member_id` INTEGER  NOT NULL COMMENT '通報者会員ID',
	`comment` TEXT  NOT NULL COMMENT '通報コメント',
	`dealt` TINYINT  NOT NULL COMMENT '対応済フラグ',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	INDEX `report_inform_history_FI_1` (`report_id`),
	INDEX `report_inform_history_FI_2` (`shop_user_photo_id`)
) COMMENT='Eネ!レポ：通報';

#-----------------------------------------------------------------------------
#-- member_visited_shops
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `member_visited_shops`;


CREATE TABLE `member_visited_shops`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT COMMENT '施設利用履歴ID',
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID',
	`member_id` INTEGER  NOT NULL COMMENT '会員ID',
	`visited_at` DATETIME  NOT NULL COMMENT '利用した時刻(guide_dateが入る)',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	UNIQUE KEY `shop_id_member_id` (`shop_id`, `member_id`),
	KEY `index_member_id_visited_at`(`member_id`, `visited_at`)
) COMMENT='最近利用した施設';

#-----------------------------------------------------------------------------
#-- shop_request_config
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `shop_request_config`;


CREATE TABLE `shop_request_config`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT COMMENT '店舗リクエスト設定ID',
	`pc_image` VARCHAR(255) COMMENT 'PC_画像',
	`pc_wording` TEXT COMMENT 'PC_文言',
	`mb_image` VARCHAR(255) COMMENT 'MB_画像',
	`mb_wording` TEXT COMMENT 'MB_文言',
	`mb_wording_2` TEXT COMMENT 'MB_文言2',
	`display_genre` TEXT COMMENT '表示ジャンル',
	`tie_up_id` TEXT COMMENT 'タイアップID',
	`wallpaper_s` VARCHAR(255) COMMENT '壁紙登録（小)',
	`wallpaper_m` VARCHAR(255) COMMENT '壁紙登録（中)',
	`wallpaper_l` VARCHAR(255) COMMENT '壁紙登録（大)',
	`deco_regist_1` VARCHAR(255) COMMENT 'デコメ登録1',
	`deco_regist_2` VARCHAR(255) COMMENT 'デコメ登録2',
	`deco_regist_3` VARCHAR(255) COMMENT 'デコメ登録3',
	`deco_regist_4` VARCHAR(255) COMMENT 'デコメ登録4',
	`deco_regist_5` VARCHAR(255) COMMENT 'デコメ登録5',
	`deco_regist_6` VARCHAR(255) COMMENT 'デコメ登録6',
	`deco_regist_7` VARCHAR(255) COMMENT 'デコメ登録7',
	`deco_regist_8` VARCHAR(255) COMMENT 'デコメ登録8',
	`deco_regist_9` VARCHAR(255) COMMENT 'デコメ登録9',
	`deco_regist_10` VARCHAR(255) COMMENT 'デコメ登録10',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`)
) COMMENT='店舗リクエスト設定';

#-----------------------------------------------------------------------------
#-- shop_temp
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `shop_temp`;


CREATE TABLE `shop_temp`
(
	`category` VARCHAR(40)  NOT NULL COMMENT 'カテゴリ',
	`name` VARCHAR(80)  NOT NULL COMMENT '店舗名',
	`name_kana` VARCHAR(200) COMMENT '店舗名ひらがな',
	`tel` VARCHAR(20) COMMENT '電話番号',
	`zip_code` VARCHAR(7) COMMENT '郵便番号',
	`prefecture` VARCHAR(10) COMMENT '都道府県',
	`address1` VARCHAR(150) COMMENT '住所1',
	`address2` VARCHAR(150) COMMENT '住所2',
	`station_id` INTEGER COMMENT '駅ID',
	`open_text` TEXT COMMENT '営業時間（フリーテキスト）',
	`close_text` TEXT COMMENT '定休日（フリーテキスト）',
	`access_train` TEXT COMMENT '電車でのアクセス',
	`unit_price_lunch` INTEGER default 0 COMMENT '単価（昼）',
	`unit_price_dinner` INTEGER default 0 COMMENT '単価（夜）',
	`seats` SMALLINT default 0 COMMENT '席数 0:指定なし',
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	PRIMARY KEY (`id`)
) COMMENT='店舗テンポラリ';

#-----------------------------------------------------------------------------
#-- member_announcement
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `member_announcement`;


CREATE TABLE `member_announcement`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT COMMENT '会員お知らせID',
	`type` TINYINT default 0 NOT NULL COMMENT 'コメント、Ｅネの区分 0：コメント 1：Eネ',
	`member_id` INTEGER  NOT NULL COMMENT '会員ID',
	`post_member_id` INTEGER  NOT NULL COMMENT 'コメント、Ｅネした会員ID',
	`report_id` INTEGER  NOT NULL COMMENT 'コメント、Ｅネされた レポートID',
	`message` TEXT  NOT NULL COMMENT 'お知らせ内容',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	KEY `index_member_id_created_at`(`member_id`, `created_at`)
) COMMENT='会員お知らせ';

#-----------------------------------------------------------------------------
#-- web_function_setting
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `web_function_setting`;


CREATE TABLE `web_function_setting`
(
	`id` INTEGER  NOT NULL COMMENT 'WEB機能管理ID 1:口コミ投稿機能',
	`name` VARCHAR(50)  NOT NULL COMMENT '機能名',
	`status` TINYINT default 0 COMMENT '承認 0：承認　1：非承認',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`)
) COMMENT='WEB機能管理';

#-----------------------------------------------------------------------------
#-- pay_member_shop
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `pay_member_shop`;


CREATE TABLE `pay_member_shop`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT COMMENT '自動生成プライマリキー',
	`pay_member_id` BIGINT  NOT NULL COMMENT '有料サービス認証状態ID',
	`member_id` INTEGER  NOT NULL COMMENT '会員ID',
	`shop_id` INTEGER COMMENT '店舗ID',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	INDEX `pay_member_shop_FI_1` (`pay_member_id`),
	INDEX `pay_member_shop_FI_2` (`shop_id`)
) COMMENT='コンシェル登録時の経由店舗';

#-----------------------------------------------------------------------------
#-- app_lock
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `app_lock`;


CREATE TABLE `app_lock`
(
	`lock_name` VARCHAR(255)  NOT NULL COMMENT 'ロック名（キー）',
	`unique_key` VARCHAR(40)  NOT NULL COMMENT 'デッドロック判定用ユニークキー',
	`expires_at` DATETIME COMMENT '有効期限',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`lock_name`)
) COMMENT='汎用ロックテーブル（排他制御に利用）';

#-----------------------------------------------------------------------------
#-- app_log
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `app_log`;


CREATE TABLE `app_log`
(
	`id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT '自動生成プライマリキー',
	`classification` VARCHAR(255) default '' NOT NULL COMMENT '分類',
	`level` VARCHAR(16) default '' NOT NULL COMMENT 'ログレベル',
	`tag` VARCHAR(255) default '' NOT NULL COMMENT 'タグ',
	`name` VARCHAR(255) default '' NOT NULL COMMENT 'ログ名',
	`log` TEXT COMMENT 'ログ内容',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	KEY `index_classification`(`classification`),
	KEY `index_tag`(`tag`),
	KEY `index_name`(`name`)
) COMMENT='汎用ログテーブル（不具合対応などに適宜利用）';

#-----------------------------------------------------------------------------
#-- shareee_campaign
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `shareee_campaign`;


CREATE TABLE `shareee_campaign`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT COMMENT 'シェアリーキャンペーン管理ID',
	`name` VARCHAR(50)  NOT NULL COMMENT 'キャンペーン名',
	`operation_from` DATETIME  NOT NULL COMMENT '実施期間(自)',
	`operation_to` DATETIME  NOT NULL COMMENT '実施期間(至)',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`)
) COMMENT='シェアリーキャンペーン管理';

#-----------------------------------------------------------------------------
#-- shareee_point
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `shareee_point`;


CREATE TABLE `shareee_point`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT COMMENT 'シェアリーポイント管理ID',
	`campaign_id` INTEGER  NOT NULL COMMENT 'シェアリーキャンペーン管理ID',
	`point_no` VARCHAR(10)  NOT NULL COMMENT 'シェアリーポイントNo',
	`member_id` INTEGER COMMENT '会員ID',
	`mail_status` TINYINT default 0 NOT NULL COMMENT 'メール配信状況 0:未送信 1:送信済',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	INDEX `shareee_point_FI_1` (`campaign_id`)
) COMMENT='シェアリーポイント管理';

#-----------------------------------------------------------------------------
#-- portal_sp_session
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `portal_sp_session`;


CREATE TABLE `portal_sp_session`
(
	`id` VARCHAR(255)  NOT NULL COMMENT 'セッションID ランダム文字列',
	`data` TEXT  NOT NULL COMMENT 'symfonyのセッションデータ',
	`updated_at` DATETIME COMMENT 'セッションタイムスタンプ',
	PRIMARY KEY (`id`),
	KEY `updated_at`(`updated_at`)
) COMMENT='EPARKポータル スマートフォンサイト用セッション情報';

#-----------------------------------------------------------------------------
#-- shop_only_publication_wanted
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `shop_only_publication_wanted`;


CREATE TABLE `shop_only_publication_wanted`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT COMMENT '自動生成プライマリキー',
	`member_id` INTEGER  NOT NULL COMMENT '会員ID',
	`shop_id` INTEGER COMMENT '店舗ID',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	UNIQUE KEY `member_id_and_shop_id_unique` (`member_id`, `shop_id`),
	INDEX `shop_only_publication_wanted_FI_1` (`shop_id`)
);

#-----------------------------------------------------------------------------
#-- shop_search
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `shop_search`;


CREATE TABLE `shop_search`
(
	`service_code` VARCHAR(8)  NOT NULL COMMENT 'サービスコード',
	`shop_code` INTEGER  NOT NULL COMMENT '施設コード',
	`name` VARCHAR(80) COMMENT '店舗名',
	`name_kana` VARCHAR(200) COMMENT '店舗名ひらがな',
	`shop_category_id` INTEGER  NOT NULL COMMENT '所属カテゴリID shop_category.idへの外部キー',
	`category_name` VARCHAR(40) COMMENT 'カテゴリ名',
	`xl_category_id` INTEGER  NOT NULL COMMENT '大々分類のカテゴリID 1: グルメ 2: 医療 3: 暮らし',
	`big_category_id` INTEGER COMMENT '大分類のカテゴリID',
	`mid_category_id` INTEGER COMMENT '中分類のカテゴリID',
	`zip_code` VARCHAR(7) COMMENT '郵便番号',
	`pref_id` TINYINT COMMENT '都道府県ID epark_common.prefecture.id',
	`pref_name` VARCHAR(10) COMMENT '都道府県名',
	`city_id` INTEGER COMMENT '市区町村ID epark_common.city.id',
	`pref_address` VARCHAR(160) COMMENT '都道府県+住所1',
	`address1` VARCHAR(150) COMMENT '住所1',
	`address2` VARCHAR(150) COMMENT '住所2',
	`tel` VARCHAR(20) COMMENT '電話番号',
	`fax` VARCHAR(20) COMMENT 'FAX番号',
	`latitude` DOUBLE COMMENT '店舗の緯度',
	`longitude` DOUBLE COMMENT '店舗の経度',
	`keywords` VARCHAR(1024) COMMENT 'キーワード',
	`owner_shop_id` INTEGER COMMENT 'オーナー店舗ID(EPARK店舗用)',
	`custom_specification_type` TINYINT default 0 COMMENT '店舗独自仕様種別 0: 通常 1: くら寿司 2: JINS 3:新メディカル 4:API 5:ポータルメディカル 6:査定システム',
	`department_kbn` TINYINT default 0 COMMENT '部門 0: 未導入 1: 導入',
	`future_reservation_only` TINYINT default 0 COMMENT '時間指定予約店舗 0: FALSE 1: TRUE',
	`mobile_wait_view_status` TINYINT default 0 COMMENT '携帯サイト待ち時間表示 1:表示 2:非表示',
	`mobile_wait_display` TINYINT COMMENT '停止中待ち情報表示切替 1:表示 2:非表示',
	`unit_price_lunch` TINYINT default 0 NOT NULL COMMENT '単価（昼） 0: 指定なし 1: ～1000円 2: 1000円 ～ 2000円 3: 2000円 ～ 3000円 4: 3000円 ～ 5000円 5: 5000円 ～ 10000円 6: 10000円 ～ 20000円 7: 20000円 ～',
	`unit_price_dinner` TINYINT default 0 NOT NULL COMMENT '単価（夜） 0: 指定なし 1: ～1000円 2: 1000円 ～ 2000円 3: 2000円 ～ 3000円 4: 3000円 ～ 5000円 5: 5000円 ～ 10000円 6: 10000円 ～ 20000円 7: 20000円 ～',
	`takeout` TINYINT default 0 NOT NULL COMMENT 'テイクアウト有 0: 指定なし 1: なし 2: あり',
	`free_drink` TINYINT default 0 NOT NULL COMMENT '飲み放題・ドリンクバー有 0: 指定なし 1: なし 2: あり',
	`free_food` TINYINT default 0 NOT NULL COMMENT '食べ放題有 0: 指定なし 1: なし 2: あり',
	`credit_card` TINYINT default 0 NOT NULL COMMENT 'クレジットカード有  0: 指定なし 1: なし 2: あり',
	`parking` TINYINT default 0 NOT NULL COMMENT '駐車場有 0: 指定なし 1: なし 2: あり',
	`child_seats` TINYINT default 0 NOT NULL COMMENT 'お子様席有 0: 指定なし 1: なし 2: あり',
	`zashiki` TINYINT default 0 NOT NULL COMMENT 'お座敷有 0: 指定なし 1: なし 2: あり',
	`smoking` TINYINT default 0 NOT NULL COMMENT '喫煙可能 0: 指定なし 1: 禁煙 2: 喫煙可 3: 分煙',
	`barrier_free` TINYINT default 0 NOT NULL COMMENT 'バリアフリー有 0: 指定なし 1: なし 2: あり',
	`lunch` TINYINT default 0 NOT NULL COMMENT 'ランチ有 0: 指定なし 1: なし 2: あり',
	`late_night` TINYINT default 0 NOT NULL COMMENT '22時以降の営業有 0: 指定なし 1: なし 2: あり',
	`receivable` TINYINT default 0 NOT NULL COMMENT '順番待ちが可能な設定か 0: 順番待ち不可 1: 順番待ち可',
	`parking_number` INTEGER UNSIGNED COMMENT '駐車場台数',
	`em_type` TINYINT UNSIGNED default 0 NOT NULL COMMENT '電子マネー',
	`kids_menu` TINYINT default 0 NOT NULL COMMENT 'キッズメニュー',
	`only_publication` TINYINT default 0 NOT NULL COMMENT '掲載区分 0:通常 1:掲載のみ',
	`timesaving_flg` TINYINT(1) default 0 NOT NULL COMMENT '時短フラグ',
	`display_point` DECIMAL(10,2) default 0 NOT NULL COMMENT '並び順点数',
	`max_cnt_last_month` SMALLINT default 0 NOT NULL COMMENT '待ち組数最大値（前月）待ち組数最大値（前月）',
	`new_arrival_date` DATETIME COMMENT '新着ソート用の日付',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`service_code`,`shop_code`,`shop_category_id`),
	KEY `shop_search_I_1`(`max_cnt_last_month`),
	KEY `shop_search_I_2`(`new_arrival_date`),
	KEY `shop_search_idx01`(`pref_id`, `big_category_id`, `mid_category_id`),
	KEY `ix_shop_search_id3`(`only_publication`, `mid_category_id`),
	KEY `ix_shop_search_id4`(`only_publication`, `pref_id`, `big_category_id`, `mid_category_id`),
	INDEX `shop_search_FI_1` (`shop_category_id`)
) COMMENT='施設検索(shop、sbm_shopのトリガでメンテ)';

#-----------------------------------------------------------------------------
#-- group_config
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `group_config`;


CREATE TABLE `group_config`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	`owner_shop_id` INTEGER  NOT NULL COMMENT 'オーナー店舗のID',
	`name` VARCHAR(80) COMMENT 'グループ店舗名',
	`name_kana` VARCHAR(200) COMMENT 'グループ店舗名ひらがな',
	`login_id` VARCHAR(15) COMMENT 'ログインID',
	`sha1_password` VARCHAR(64)  NOT NULL COMMENT '符号化済みパスワード',
	`salt` VARCHAR(32)  NOT NULL COMMENT '認証用salt',
	`status` TINYINT default 2 NOT NULL COMMENT '運用状態 1:利用中、2:停止中、3:削除済み',
	`auth_status` TINYINT default 2 NOT NULL COMMENT '承認状態 1:承認、2:未承認',
	`test_status` TINYINT default 2 NOT NULL COMMENT 'テスト状態 1:通常、2:テスト',
	`mail_status` TINYINT default 2 NOT NULL COMMENT 'メール配信権限 1:使用可、2:使用不可',
	`urgent_mail_status` TINYINT default 2 NOT NULL COMMENT '緊急メール配信機能利用権限 1:使用可、2:使用不可',
	`mail_template_status` TINYINT default 2 NOT NULL COMMENT 'メールテンプレート作成権限 1:使用可、2:使用不可',
	`repeat_mail_status` TINYINT default 2 NOT NULL COMMENT 'リピートメール利用権限 1:使用可、2:使用不可',
	`shop_point_status` TINYINT default 2 NOT NULL COMMENT '来店ポイント機能利用権限 1:使用可、2:使用不可',
	`member_ledger_status` TINYINT default 2 NOT NULL COMMENT '顧客台帳利用権限 1:使用可、2使用不可 ※来店ポイント フェイズ１では未使用',
	`multiple_mail_coupon_status` TINYINT default 2 NOT NULL COMMENT 'メールにクーポンをセットできる数 1:複数 2:1つ',
	`nml_mail_template_author_group` INTEGER COMMENT 'お知らせメールテンプレート承認グループID',
	`cpn_mail_template_author_group` INTEGER COMMENT 'クーポンメールテンプレート承認グループID',
	`mail_auth_addr` VARCHAR(255) COMMENT 'メール承認依頼メール送信先アドレス',
	`msg_sts` TINYINT default 2 NOT NULL COMMENT 'メッセージ配信権限 1:使用可、2:使用不可',
	`pc_logout_hour` TINYINT UNSIGNED default 99 NOT NULL COMMENT 'PC強制ログアウト実行時間 0時から23時で管理を想定 99：しない、2：AM2時に実行 8:AM8時に実行',
	`brand_keyword_id` INTEGER UNSIGNED COMMENT 'ブランドID',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	KEY `index_group_statuses`(`status`, `auth_status`, `test_status`),
	KEY `group_config_FI_1`(`owner_shop_id`),
	INDEX `group_config_FI_2` (`nml_mail_template_author_group`),
	INDEX `group_config_FI_3` (`cpn_mail_template_author_group`)
) COMMENT='グループ店舗設定';

#-----------------------------------------------------------------------------
#-- group_reference
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `group_reference`;


CREATE TABLE `group_reference`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	`group_id` INTEGER  NOT NULL COMMENT 'グループID',
	`reference_group_id` INTEGER  NOT NULL COMMENT '参照グループID',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	KEY `index_group_reference`(`group_id`),
	INDEX `group_reference_FI_2` (`reference_group_id`)
) COMMENT='グループ参照設定';

#-----------------------------------------------------------------------------
#-- group_shop
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `group_shop`;


CREATE TABLE `group_shop`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	`group_id` INTEGER  NOT NULL COMMENT 'グループ店舗ID',
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID',
	`status` TINYINT default 1 NOT NULL COMMENT '運用状態 1:反映、2:停止',
	`display_order` INTEGER COMMENT '表示順',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	KEY `index_group_shop`(`group_id`, `shop_id`, `status`),
	KEY `group_shop_FI_2`(`shop_id`),
	KEY `group_shop_FI_3`(`group_id`),
	KEY `group_shop_FI_4`(`group_id`, `shop_id`)
) COMMENT='グループ所属店舗';

#-----------------------------------------------------------------------------
#-- group_mail_config
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `group_mail_config`;


CREATE TABLE `group_mail_config`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	`group_id` INTEGER  NOT NULL COMMENT 'グループ店舗ID',
	`sender_nml` VARCHAR(64) COMMENT '通常メール差出人名',
	`title_nml` VARCHAR(60) COMMENT '通常メール初期タイトル設定値',
	`header_nml` TEXT COMMENT '通常メールヘッダテキスト',
	`footer_nml` TEXT COMMENT '通常メールフッタテキスト',
	`sender_cpn` VARCHAR(64) COMMENT 'クーポンメール差出人',
	`title_cpn` VARCHAR(60) COMMENT 'クーポンメール初期タイトル設定値',
	`header_cpn` TEXT COMMENT 'クーポンメールヘッダテキスト',
	`footer_cpn` TEXT COMMENT 'クーポンメールフッタテキスト',
	`coupon_number_status` TINYINT default 1 NOT NULL COMMENT 'クーポンを番号表示 設定 0:非表示 1:表示',
	`coupon_mobile_exchange_button_status` TINYINT default 0 NOT NULL COMMENT 'クーポンを使用済にするボタンの表示 設定 0:非表示 1:表示',
	`test_mail_to` VARCHAR(1024) COMMENT 'テストメール送信先アドレス（複数選択の場合は改行区切り）',
	`area_setting_enabled` TINYINT default 0 NOT NULL COMMENT '地域別店舗選択項目使用',
	`segment_setting_enabled` TINYINT default 0 NOT NULL COMMENT 'セグメント別店舗選択項目使用',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	KEY `group_mail_config_FI_1`(`group_id`)
) COMMENT='グループメール設定';

#-----------------------------------------------------------------------------
#-- group_mail
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `group_mail`;


CREATE TABLE `group_mail`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	`group_id` INTEGER  NOT NULL COMMENT 'グループ店舗ID',
	`coupon_id` BIGINT COMMENT 'クーポンID',
	`status` TINYINT COMMENT '状態 0:有効 1:無効 2:不明(削除)',
	`is_send` TINYINT COMMENT '送信ステータス 0:実行中 1:一時停止 2:配信終了',
	`send_type` TINYINT COMMENT '設定者 0:オーナー店舗 1:店舗',
	`send_number` INTEGER(5) COMMENT '配信No',
	`sender` VARCHAR(64) COMMENT '差出人',
	`subject` VARCHAR(100) COMMENT '配信タイトル',
	`header` VARCHAR(2048) COMMENT 'メールヘッダ',
	`text` VARCHAR(8192) COMMENT 'メール内容',
	`text_html` TEXT COMMENT 'メール内容(HTML)',
	`footer` VARCHAR(2048) COMMENT 'メールフッタ',
	`target_type` TINYINT default 0 NOT NULL COMMENT '配信対象種別 0: 条件指定 1: ID指定',
	`src_sex` TINYINT COMMENT '配信対象:性別 0:男性 1:女性',
	`src_age_from` INTEGER(3) COMMENT '配信対象:年齢(開始)',
	`src_age_to` INTEGER(3) COMMENT '配信対象:年齢(終了)',
	`src_birth_m` SMALLINT COMMENT '配信対象:誕生月',
	`src_birth_d` SMALLINT COMMENT '配信対象:誕生日',
	`src_pref_id` TINYINT COMMENT '配信対象:都道府県',
	`src_visit_from` DATETIME COMMENT '配信対象:来店日(開始)',
	`src_visit_to` DATETIME COMMENT '配信対象:来店日(終了)',
	`src_entry_from` DATETIME COMMENT '配信対象:登録日(開始)',
	`src_entry_to` DATETIME COMMENT '配信対象:登録日(終了)',
	`src_num` INTEGER(3) COMMENT '利用者数',
	`src_member_rank` TINYINT COMMENT '会員ランク 1:ダイヤモンド 2:プラチナ 3:ゴールド 4:シルバー 5:ブロンズ',
	`src_point_grant_date_from` DATETIME COMMENT 'ポイント付与日(from)',
	`src_point_grant_date_to` DATETIME COMMENT 'ポイント付与日(to)',
	`shop_rsv_dptm_id` INTEGER(10) default 0 COMMENT '部門ID(自動車ph6)',
	`shop_rsv_ct_opt_id_1` INTEGER(10) default 0 COMMENT '予約カテゴリID_1(自動車ph6)',
	`shop_rsv_ct_opt_id_2` INTEGER(10) default 0 COMMENT '予約カテゴリID_2(自動車ph6)',
	`shop_rsv_ct_opt_id_3` INTEGER(10) default 0 COMMENT '予約カテゴリID_3(自動車ph6)',
	`shop_rsv_ct_opt_id_4` INTEGER(10) default 0 COMMENT '予約カテゴリID_4(自動車ph6)',
	`shop_rsv_ct_opt_id_5` INTEGER(10) default 0 COMMENT '予約カテゴリID_5(自動車ph6)',
	`repeat_type` TINYINT default 0 COMMENT 'メール種別 1:初回特典メール 2:誕生日メール 3:リピートメール 4:ステップメール 5:来店がない人メール 6:有効期限切れ告知メール 7:車検リマインドメール(自動車ph6)',
	`src_phone_number` VARCHAR(20) COMMENT '配信対象者の携帯電話番号',
	`src_chg_startyear` INTEGER UNSIGNED COMMENT '配信対象者の機種変更_開始年',
	`src_chg_startmonth` TINYINT COMMENT '配信対象者の機種変更_開始月',
	`src_chg_startday` TINYINT COMMENT '配信対象者の機種変更_開始日',
	`src_chg_endyear` INTEGER UNSIGNED COMMENT '配信対象者の機種変更_終了年',
	`src_chg_endmonth` TINYINT COMMENT '配信対象者の機種変更_終了月',
	`src_chg_endday` TINYINT COMMENT '配信対象者の機種変更_終了日',
	`src_last_startyear` INTEGER UNSIGNED COMMENT '配信対象者の最終ログイン_開始年',
	`src_last_startmonth` TINYINT COMMENT '配信対象者の最終ログイン_開始月',
	`src_last_startday` TINYINT COMMENT '配信対象者の最終ログイン_開始日',
	`src_last_endyear` INTEGER UNSIGNED COMMENT '配信対象者の最終ログイン_終了年',
	`src_last_endmonth` TINYINT COMMENT '配信対象者の最終ログイン_終了月',
	`src_last_endday` TINYINT COMMENT '配信対象者の最終ログイン_終了日',
	`avg_unt_cst_from` INTEGER COMMENT '開始平均単価',
	`avg_unt_cst_to` INTEGER COMMENT '終了平均単価',
	`midclass_id` INTEGER COMMENT 'メニュー中分類ID',
	`src_visit_ranking_status` TINYINT default 0 COMMENT '来店回数ランキング(0:指定なし 1:集計期間月単位 2:集計期間週単位)',
	`src_visit_ranking_date_from` DATETIME COMMENT '集計期間(開始)',
	`src_visit_ranking_date_to` DATETIME COMMENT '集計期間(未満)',
	`src_visit_ranking_from` INTEGER(3) COMMENT '上位何位から',
	`src_visit_ranking_to` INTEGER(3) COMMENT '上位何位まで',
	`send_date` DATETIME COMMENT '配信日時',
	`send_start` DATETIME COMMENT '送信開始時間',
	`send_end` DATETIME COMMENT '送信終了時間',
	`send_num` INTEGER(8) COMMENT '配信数',
	`send_condition_type` TINYINT default 0 COMMENT '配信条件種別タイプ 0:最終来店 1:初回来店 2:期限切れ告知',
	`send_condition_span_1` TINYINT COMMENT '配信条件1 期間',
	`send_condition_unit_1` TINYINT COMMENT '配信条件1 単位 1:ヶ月 2:日',
	`send_condition_span_2` TINYINT COMMENT '配信条件2 期間',
	`send_condition_unit_2` TINYINT COMMENT '配信条件2 単位 1:ヶ月 2:日',
	`send_condition_span_3` TINYINT COMMENT '配信条件3 期間',
	`send_condition_unit_3` TINYINT COMMENT '配信条件3 単位 1:ヶ月 2:日',
	`send_condition_span_4` TINYINT COMMENT '配信条件4 期間',
	`send_condition_unit_4` TINYINT COMMENT '配信条件4 単位 1:ヶ月 2:日',
	`send_condition_span_5` TINYINT COMMENT '配信条件5 期間',
	`send_condition_unit_5` TINYINT COMMENT '配信条件5 単位 1:ヶ月 2:日',
	`send_html_mail` TINYINT default 0 NOT NULL COMMENT 'HTMLメールかどうか 0:テキストメール, 1:HTMLメール',
	`use_coupon_status` TINYINT default 0 NOT NULL COMMENT '利用できるクーポンの数 0:どれかひとつ 1:それぞれの個別指定に従う',
	`common_coupon_limit_status` TINYINT default 0 NOT NULL COMMENT '複数クーポン配信制限共通設定 0:共通 1:個別',
	`qr_point_status` TINYINT default 0 NOT NULL COMMENT 'QRポイントメールフラグ 0: 通常メール 1: QRポイントメール',
	`qr_point_num` INTEGER COMMENT 'QR来店ポイント付与数',
	`qr_point_term_start` DATETIME COMMENT 'QR来店ポイント付与期限（開始）',
	`qr_point_term_end` DATETIME COMMENT 'QR来店ポイント付与期限（終了）',
	`shop_member_card_not_have_check` TINYINT default 0 COMMENT '会員証未発行の会員のみ 0: 指定なし 1: 指定あり',
	`point_has_not_give_yet_check` TINYINT default 0 COMMENT '未付与の会員のみ（会員証発行後まだかざしていない） 0:指定なし 1:指定あり',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	KEY `index_group_mail`(`group_id`, `status`),
	KEY `index_key_1`(`status`, `is_send`, `coupon_id`, `group_id`)
) COMMENT='グループ店舗のメール送信履歴';

#-----------------------------------------------------------------------------
#-- group_repeat_mail
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `group_repeat_mail`;


CREATE TABLE `group_repeat_mail`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	`group_id` INTEGER  NOT NULL COMMENT 'グループ店舗ID',
	`repeat_type` TINYINT  NOT NULL COMMENT 'メール種別 1:初回特典メール 2:誕生日メール 3:リピートメール 4:ステップメール 5:来店がない人メール 6:有効期限切れ告知メール',
	`mail_type` TINYINT  NOT NULL COMMENT '配信種別 1:通常メール 2:クーポンメール',
	`status` TINYINT default 0 NOT NULL COMMENT '状態 0:有効 1:無効 2:不明(削除)',
	`send_status` TINYINT default 0 NOT NULL COMMENT '送信ステータス 0:実行中 1:一時停止 2:配信終了',
	`send_type` TINYINT COMMENT '設定者 0:オーナー店舗 1:店舗',
	`send_number` INTEGER(5) COMMENT '配信No',
	`sender` VARCHAR(64) COMMENT '差出人',
	`subject` VARCHAR(60) COMMENT '配信タイトル',
	`header` TEXT COMMENT 'メールヘッダ',
	`text` TEXT COMMENT 'メール内容',
	`text_html` TEXT COMMENT 'メール内容(HTML)',
	`footer` TEXT COMMENT 'メールフッタ',
	`src_sex` TINYINT COMMENT '配信対象:性別 0:男性 1:女性',
	`src_age_from` INTEGER(3) COMMENT '配信対象:年齢(開始)',
	`src_age_to` INTEGER(3) COMMENT '配信対象:年齢(終了)',
	`src_birth_m` SMALLINT COMMENT '配信対象:誕生月',
	`src_pref_id` TINYINT COMMENT '配信対象:都道府県',
	`src_member_rank` TINYINT COMMENT '会員ランク 1:ダイヤモンド 2:プラチナ 3:ゴールド 4:シルバー 5:ブロンズ',
	`src_visit_ranking_status` TINYINT default 1 COMMENT '来店回数ランキングによる絞り込み(0:指定あり 1:指定なし)',
	`src_visit_ranking_span_type` TINYINT default 1 COMMENT '集計期間タイプ(1:月単位 2:週単位)',
	`src_visit_ranking_span_monthly` TINYINT COMMENT '集計期間(何ヶ月分)',
	`src_visit_ranking_span_weekly` TINYINT COMMENT '集計期間(何週間分)',
	`src_visit_ranking_from` INTEGER(3) COMMENT '上位何位から',
	`src_visit_ranking_to` INTEGER(3) COMMENT '上位何位まで',
	`send_date_type` TINYINT COMMENT '配信日時タイプ 1:初回登録のN日後のN時台に配信(誕生日のN日前のN時台に配信) 2:初回登録からN時間後に配信(誕生日当日のN時台に配信) 3:月初(1日)のN時台に配信',
	`send_day` TINYINT COMMENT '配信日時:日設定(登録日からN日後／毎月N日／毎週N曜日／誕生日のN日前)',
	`send_hour` TINYINT COMMENT '配信日時:時間設定(N時台に配信、N時間後に配信)',
	`send_repeat` TINYINT COMMENT '配信周期 1:毎月 2:毎週 (リピートメールのみ)',
	`send_condition_type` TINYINT default 0 NOT NULL COMMENT '配信条件種別タイプ 0:最終来店 1:初回来店 2:期限切れ告知',
	`send_condition_span_1` TINYINT COMMENT '配信条件1 期間',
	`send_condition_unit_1` TINYINT COMMENT '配信条件1 単位 1:ヶ月 2:日',
	`send_condition_span_2` TINYINT COMMENT '配信条件2 期間',
	`send_condition_unit_2` TINYINT COMMENT '配信条件2 単位 1:ヶ月 2:日',
	`send_condition_span_3` TINYINT COMMENT '配信条件3 期間',
	`send_condition_unit_3` TINYINT COMMENT '配信条件3 単位 1:ヶ月 2:日',
	`send_condition_span_4` TINYINT COMMENT '配信条件4 期間',
	`send_condition_unit_4` TINYINT COMMENT '配信条件4 単位 1:ヶ月 2:日',
	`send_condition_span_5` TINYINT COMMENT '配信条件5 期間',
	`send_condition_unit_5` TINYINT COMMENT '配信条件5 単位 1:ヶ月 2:日',
	`repeat_start` DATETIME COMMENT 'リピート開始日時',
	`repeat_end` DATETIME COMMENT 'リピート終了時間(無期限の場合はNULL)',
	`coupon_start` TINYINT COMMENT 'クーポン利用開始日',
	`coupon_end` SMALLINT COMMENT 'クーポン利用終了日(開始月の末日まではNULL)',
	`coupon_start_h` TINYINT COMMENT 'クーポン有効時刻開始(時)',
	`coupon_start_m` TINYINT COMMENT 'クーポン有効時刻開始(分)',
	`coupon_end_time_type` TINYINT COMMENT 'クーポン有効時刻終了種別 0:当日 1:翌日',
	`coupon_end_h` TINYINT COMMENT 'クーポン有効時刻終了(時)',
	`coupon_end_m` TINYINT COMMENT 'クーポン有効時刻終了(分)',
	`coupon_use_max_num` INTEGER COMMENT 'クーポン利用可能回数',
	`coupon_text` TEXT COMMENT 'クーポン内容',
	`send_html_mail` TINYINT default 0 NOT NULL COMMENT 'HTMLメールかどうか 0:テキストメール, 1:HTMLメール',
	`use_coupon_status` TINYINT default 0 NOT NULL COMMENT '利用できるクーポンの数 0:どれかひとつ 1:それぞれの個別指定に従う',
	`common_coupon_limit_status` TINYINT default 0 NOT NULL COMMENT '複数クーポン配信制限共通設定 0:共通 1:個別',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	KEY `index_01`(`group_id`, `status`)
) COMMENT='グループ店舗のリピートメール送信設定';

#-----------------------------------------------------------------------------
#-- group_mail_shop
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `group_mail_shop`;


CREATE TABLE `group_mail_shop`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	`group_mail_id` INTEGER  NOT NULL COMMENT 'グループ店舗メールID',
	`shop_id` INTEGER(8)  NOT NULL COMMENT '店舗ID',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	KEY `group_mail_shop_FI_1`(`group_mail_id`),
	KEY `group_mail_shop_FI_2`(`shop_id`)
) COMMENT='グループ店舗メール配信先店舗';

#-----------------------------------------------------------------------------
#-- group_repeat_mail_shop
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `group_repeat_mail_shop`;


CREATE TABLE `group_repeat_mail_shop`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	`group_repeat_mail_id` INTEGER  NOT NULL COMMENT 'グループ店舗リピートメールID',
	`shop_id` INTEGER(8)  NOT NULL COMMENT '店舗ID',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	KEY `group_mail_shop_FI_1`(`group_repeat_mail_id`),
	KEY `group_mail_shop_FI_2`(`shop_id`)
) COMMENT='グループ店舗リピートメール配信先店舗';

#-----------------------------------------------------------------------------
#-- group_repeat_group_mail
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `group_repeat_group_mail`;


CREATE TABLE `group_repeat_group_mail`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	`group_repeat_mail_id` INTEGER COMMENT 'リピートメールID',
	`group_mail_id` INTEGER COMMENT '店舗メールID',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	KEY `index_01`(`group_repeat_mail_id`, `group_mail_id`),
	INDEX `group_repeat_group_mail_FI_2` (`group_mail_id`)
) COMMENT='送信されたリピートメール';

#-----------------------------------------------------------------------------
#-- group_info
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `group_info`;


CREATE TABLE `group_info`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	`group_id` INTEGER  NOT NULL COMMENT 'グループ店舗ID',
	`status` TINYINT default 1 NOT NULL COMMENT 'お知らせの承認状態 0:承認, 1:非承認, 2:削除済',
	`entry_type` TINYINT default 0 NOT NULL COMMENT '登録者種別。0:オーナー店舗、1:店舗、 2:グループ店舗',
	`title` VARCHAR(100)  NOT NULL COMMENT 'お知らせタイトル',
	`content` TEXT  NOT NULL COMMENT 'お知らせ内容',
	`target_type` TINYINT UNSIGNED  NOT NULL COMMENT '対象タイプ 1:個別店舗 2:個別ブランド 3:グループ全体(全店舗・全ブランド)',
	`use_campaign_flg` TINYINT(1) default 0 NOT NULL COMMENT 'キャンペーン利用フラグ',
	`campaign_button_word` VARCHAR(100)  NOT NULL COMMENT 'キャンペーンボタン文言',
	`start_display_at` DATETIME  NOT NULL COMMENT '表示開始日時',
	`end_display_at` DATETIME  NOT NULL COMMENT '表示終了日時',
	`news_photo` VARCHAR(100) COMMENT 'お知らせ画像',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	KEY `index_group_id`(`group_id`)
) COMMENT='グループ店舗お知らせ';

#-----------------------------------------------------------------------------
#-- group_shop_login_token
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `group_shop_login_token`;


CREATE TABLE `group_shop_login_token`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	`group_id` INTEGER default 0 NOT NULL COMMENT 'グループ店舗ID',
	`shop_id` INTEGER default 0 NOT NULL COMMENT 'ログイン店舗ID',
	`login_token` VARCHAR(40) default '' NOT NULL COMMENT 'ログイン用一時トークン',
	`expired_at` DATETIME COMMENT '有効期限',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`)
) COMMENT='グループ管理画面から店舗管理画面へのログイン用トークン';

#-----------------------------------------------------------------------------
#-- mail_template
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `mail_template`;


CREATE TABLE `mail_template`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	`group_id` INTEGER COMMENT 'テンプレート作成者',
	`mail_type` TINYINT  NOT NULL COMMENT '配信種別 1:通常メール 2:クーポンメール',
	`template_start` DATETIME COMMENT 'テンプレート使用可能開始日時(無期限の場合はNULL)',
	`template_end` DATETIME COMMENT 'テンプレート使用可能終了時間(無期限の場合はNULL)',
	`coupon_day_count` INTEGER(8) COMMENT '1店舗あたりのクーポン発行可能日数 2012.06.22#5313_改修により店舗毎に管理する。',
	`subject` VARCHAR(60) COMMENT '配信タイトル',
	`text` TEXT COMMENT 'メール内容',
	`coupon_text` TEXT  NOT NULL COMMENT 'クーポン内容',
	`auth_status` TINYINT default 0 NOT NULL COMMENT 'テンプレート承認有無 0:承認不要 1:承認済み 2:承認待ち 3:差戻し',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	INDEX `mail_template_FI_1` (`group_id`)
) COMMENT='定形メール機能のメールテンプレート';

#-----------------------------------------------------------------------------
#-- touch_shop_login_token
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `touch_shop_login_token`;


CREATE TABLE `touch_shop_login_token`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	`shop_id` INTEGER default 0 NOT NULL COMMENT 'ログイン店舗ID',
	`login_token` VARCHAR(40) default '' NOT NULL COMMENT 'ログイン用一時トークン',
	`referer` VARCHAR(255) default '' NOT NULL COMMENT 'タッチパネル側の参照元',
	`expired_at` DATETIME COMMENT '有効期限',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`)
) COMMENT='タッチパネル画面から店舗管理画面へのログイン用トークン';

#-----------------------------------------------------------------------------
#-- epark_light_shops
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `epark_light_shops`;


CREATE TABLE `epark_light_shops`
(
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	PRIMARY KEY (`id`)
) COMMENT='EPARK light API連携店舗設定';

#-----------------------------------------------------------------------------
#-- epark_light_api_data
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `epark_light_api_data`;


CREATE TABLE `epark_light_api_data`
(
	`id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT '自動連番ID',
	`member_id` INTEGER  NOT NULL COMMENT '会員ID',
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID',
	`record_date` DATETIME  NOT NULL COMMENT '更新日時',
	`status` TINYINT default 1 NOT NULL COMMENT '更新フラグ 1:新規 2:更新 3:退会',
	`call_name` VARCHAR(40)  NOT NULL COMMENT '呼出し名（ニックネーム）',
	`sex` TINYINT  NOT NULL COMMENT '性別 0:男性 1:女性  ※EPARK側値',
	`birthday` DATE  NOT NULL COMMENT '生年月日',
	`prefecture_id` TINYINT  NOT NULL COMMENT '都道府県ID ※EPARK側値',
	`email` VARCHAR(255)  NOT NULL COMMENT 'メールアドレス',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	KEY `shop_id`(`shop_id`),
	KEY `record_date`(`record_date`),
	KEY `status`(`status`)
) COMMENT='EPARK light API提供データ';

#-----------------------------------------------------------------------------
#-- epark_light_api_receive_member_data
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `epark_light_api_receive_member_data`;


CREATE TABLE `epark_light_api_receive_member_data`
(
	`id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT '自動連番ID',
	`cc_member_id` INTEGER  NOT NULL COMMENT 'CC会員ID',
	`member_id` INTEGER COMMENT 'EPARK会員ID',
	`call_name` VARCHAR(40)  NOT NULL COMMENT '呼出し名（ニックネーム）',
	`sex` TINYINT  NOT NULL COMMENT '性別 1:男性 2:女性  ※EPARK LIGHT側値',
	`birthday` DATE  NOT NULL COMMENT '生年月日',
	`prefecture_id` TINYINT  NOT NULL COMMENT '都道府県ID ※EPARK LIGHT側値',
	`email` VARCHAR(255)  NOT NULL COMMENT 'メールアドレス',
	`epark_status_id` TINYINT default 1 NOT NULL COMMENT 'EPARKステータスID 1:cc初回登録がcc側EPARK店であったユーザ  2:cc初回登録がcc側EPARK light店であったユーザ',
	`record_date` DATETIME  NOT NULL COMMENT '更新日時',
	`status` TINYINT default 1 NOT NULL COMMENT '更新フラグ 1:新規 2:更新',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`)
) COMMENT='EPARK light API受信会員テーブル';

#-----------------------------------------------------------------------------
#-- epark_light_api_receive_shop_member_data
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `epark_light_api_receive_shop_member_data`;


CREATE TABLE `epark_light_api_receive_shop_member_data`
(
	`id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT '自動連番ID',
	`member_id` INTEGER COMMENT 'EPARK会員ID',
	`email` VARCHAR(255)  NOT NULL COMMENT 'メールアドレス',
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID',
	`news_status` TINYINT  NOT NULL COMMENT 'メール受信ステータス 0: 拒否 1: 受取る',
	`record_date` DATETIME  NOT NULL COMMENT '更新日時',
	`status` TINYINT default 1 NOT NULL COMMENT '更新フラグ 1:新規 2:更新 （現状「2:更新」データのみの予定）',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`)
) COMMENT='EPARK light API受信店舗会員テーブル';

#-----------------------------------------------------------------------------
#-- epark_shop_pv
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `epark_shop_pv`;


CREATE TABLE `epark_shop_pv`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT COMMENT 'id',
	`view_count` INTEGER default 0 NOT NULL COMMENT 'ページPV',
	`view_date` DATE  NOT NULL COMMENT '閲覧日',
	`custom_specification_type` TINYINT default 0 NOT NULL COMMENT '店舗独自仕様種別 0: 通常 1: くら寿司 2: JINS 3:新メディカル 4:API 5:ポータルメディカル 6:査定システム 1: くら寿司 は現在未使用、将来の改修時のために予約 ※owner_shop.custom_specification_type は廃止予定です。',
	`entry_type` TINYINT default 99 NOT NULL COMMENT '予約登録元 0:PC管理画面 1:PC表側 2:携帯管理画面 3:携帯表側 4:タッチパネル管理画面 5:タッチパネル 6:API 7:スマートフォンサイト 99:既定 ※ 1:PC表側 は使用していない様子',
	`referer` VARCHAR(255) COMMENT 'リファラ',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	UNIQUE KEY `unique_free_pv` (`view_date`, `custom_specification_type`, `entry_type`, `referer`),
	KEY `index_date_ref`(`custom_specification_type`, `view_date`, `referer`)
) COMMENT='施設TOP_ページビュー情報';

#-----------------------------------------------------------------------------
#-- receive_report
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `receive_report`;


CREATE TABLE `receive_report`
(
	`id` BIGINT  NOT NULL COMMENT 'ID',
	`shop_id` BIGINT COMMENT '店舗ID',
	`name` VARCHAR(80) COMMENT '店舗名',
	`entry_date` DATETIME COMMENT 'レコード作成日時',
	`receipt_date` DATETIME COMMENT '案内予定日時 ※席に着きたい時間 順番待ちの場合は受付日時 時間指定・将来順番待ちの時は予約時に指定した日時 「戻す」場合は割り込ませたい順番になるようにこの日時を変更',
	`guide_status` TINYINT COMMENT '案内状態 0:未案内 1:案内済 2:不在 3:無断キャンセル 4:案内済再案内 5:不在再案内 6:接客中 7:接客中再案内 8:キャンセル 旧：案内状態 0:未案内 1:案内済み 2:呼び出し済み（現在expired扱い。callはどうしようか？）',
	`referer` VARCHAR(255) COMMENT 'リファラ',
	`member_id` INTEGER default 0 NOT NULL COMMENT '会員ＩＤ',
	`sex` TINYINT  NOT NULL COMMENT '性別 0:男性 1:女性',
	`age` SMALLINT COMMENT '予約時年齢',
	`prefecture_name` VARCHAR(10) COMMENT '予約時都道府県',
	`shop_reserve_department_value` VARCHAR(100) COMMENT '部門名',
	`shop_reserve_category_value_1` VARCHAR(100) COMMENT '条件１内容',
	`shop_reserve_category_value_2` VARCHAR(100) COMMENT '条件２内容',
	`shop_reserve_category_value_3` VARCHAR(100) COMMENT '条件３内容',
	`shop_reserve_category_value_4` VARCHAR(100) COMMENT '条件４内容',
	`shop_reserve_category_value_5` VARCHAR(100) COMMENT '条件５内容',
	`reserve_type` TINYINT  NOT NULL COMMENT '予約タイプ 0:順番待ち 1:予約',
	`custom_specification_type` TINYINT default 0 NOT NULL COMMENT '店舗独自仕様種別 0: 通常 1: くら寿司 2: JINS 3:新メディカル 4:API 5:ポータルメディカル 6:査定システム 1: くら寿司 は現在未使用、将来の改修時のために予約 ※owner_shop.custom_specification_type は廃止予定です。',
	`entry_type` TINYINT COMMENT '予約登録元 0:PC管理画面 1:PC表側 2:携帯管理画面 3:携帯表側 4:タッチパネル管理画面 5:タッチパネル 6:API 7:スマートフォンサイト 99:既定 ※ 1:PC表側 は使用していない様子',
	`created_at` DATETIME COMMENT 'レコード作成日時',
	`updated_at` DATETIME COMMENT 'レコード更新日時',
	PRIMARY KEY (`id`),
	KEY `index_receipt_date`(`receipt_date`),
	KEY `index_referer`(`referer`),
	KEY `index_entry_type`(`entry_type`),
	KEY `index_guide_status`(`guide_status`)
) COMMENT='予約レポート用データ';

#-----------------------------------------------------------------------------
#-- member_temp_registration
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `member_temp_registration`;


CREATE TABLE `member_temp_registration`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	`member_temp_type` TINYINT default 1 NOT NULL COMMENT '登録種別 (1:MB新規, 2:MBメール変更, 3:PC新規(MB), 4:PC新規(PC), 5:PCサイトMBメール追加, 6:PCサイトPCメール追加, 7:PCサイトパスワード変更 8:MBサイトパスワード変更 9:MBサイト未ログイン, 10:メールアドレス本人認証)',
	`member_temp_id` BIGINT default 0 NOT NULL COMMENT '登録一時テーブルID (member_temp, portal_member_temp, member_change_email_temp)',
	`member_temp_receive_type` TINYINT default 1 NOT NULL COMMENT ' 予約タイプ（1:EPARK, 2:SBM, 3:時間割任意, 4:時間割固定）',
	`member_temp_receive_id` BIGINT default 0 NOT NULL COMMENT '予約一時保存ID (EPARK=>member_temp_receive_epark, SBM=>member_temp_receive_sbm, 時間割任意=>member_temp_receive_timetable_free, 時間割固定=>member_temp_receive_timetable_fixed)',
	`api_system_code` VARCHAR(5) COMMENT 'API連携システム識別コード API連携による登録の場合に使用',
	`entry_shop_id` INTEGER default 0 NOT NULL COMMENT '会員登録の入口となった店舗のID',
	`member_id` INTEGER default 0 NOT NULL COMMENT '会員ID（携帯メールアドレス追加時等）',
	`random_key` VARCHAR(20)  NOT NULL COMMENT '各一時テーブルの値と同値',
	`unique_number` INTEGER  NOT NULL COMMENT 'PCサイト入力用特定番号',
	`email_mobile` VARCHAR(255) default '' NOT NULL COMMENT '携帯メールアドレス',
	`email_pc` VARCHAR(255) default '' NOT NULL COMMENT 'PCメールアドレス',
	`phone_number` VARCHAR(15) COMMENT '電話番号',
	`entry_count` TINYINT default 1 NOT NULL COMMENT 'ユーザが(一時データの保存期間内に)空メールを送信した回数 この値が多い場合は返信メールがうまく届いていない可能性あり',
	`expires_at` DATETIME  NOT NULL COMMENT 'このレコードの保存期限 期限の過ぎたデータは定期的に削除する',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	UNIQUE KEY `member_temp_registration_U_1` (`random_key`),
	UNIQUE KEY `member_temp_registration_U_2` (`unique_number`),
	UNIQUE KEY `uix_member_temp_registration1` (`phone_number`),
	KEY `index_member_temp_type`(`member_temp_type`),
	KEY `index_member_temp_id`(`member_temp_id`),
	KEY `index_member_temp_receive_type`(`member_temp_receive_type`),
	KEY `index_member_temp_receive_id`(`member_temp_receive_id`),
	INDEX `member_temp_registration_FI_1` (`api_system_code`)
) COMMENT='空メール送信による仮登録データの一時保存用。予約からの会員登録（など）用';

#-----------------------------------------------------------------------------
#-- member_temp_receive_epark
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `member_temp_receive_epark`;


CREATE TABLE `member_temp_receive_epark`
(
	`id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT 'ID',
	`shop_id` BIGINT COMMENT '店舗ID',
	`member_id` INTEGER default 0 COMMENT '会員ＩＤ',
	`reserve_type` TINYINT COMMENT '予約タイプ 0:順番待ち 1:予約',
	`receive_data` TEXT COMMENT '予約データ',
	`created_at` DATETIME COMMENT 'レコード作成日時',
	`updated_at` DATETIME COMMENT 'レコード更新日時',
	PRIMARY KEY (`id`)
) COMMENT='予約登録からの会員登録時の予約情報一時保管テーブル（EPARK店舗予約） 予約中のフォームデータ（配列）などをserializeで一括保存。(最大64KB) member_temp_registration の紐付きがなくなればバッチで削除';

#-----------------------------------------------------------------------------
#-- member_temp_receive_sbm
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `member_temp_receive_sbm`;


CREATE TABLE `member_temp_receive_sbm`
(
	`id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT 'ID',
	`shop_id` BIGINT COMMENT '店舗ID',
	`member_id` INTEGER default 0 COMMENT '会員ＩＤ',
	`reserve_type` TINYINT COMMENT '予約種別 1:順番待ち, 2:将来順番予約',
	`receive_data` TEXT COMMENT '予約データ',
	`created_at` DATETIME COMMENT 'レコード作成日時',
	`updated_at` DATETIME COMMENT 'レコード更新日時',
	PRIMARY KEY (`id`)
) COMMENT='予約登録からの会員登録時の予約情報一時保管テーブル（SBM店舗予約） 予約中のフォームデータ（配列）などをserializeで一括保存。(最大64KB) member_temp_registration の紐付きがなくなればバッチで削除';

#-----------------------------------------------------------------------------
#-- member_temp_receive_timetable_free
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `member_temp_receive_timetable_free`;


CREATE TABLE `member_temp_receive_timetable_free`
(
	`id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT 'ID',
	`shop_id` BIGINT COMMENT '店舗ID',
	`member_id` INTEGER default 0 COMMENT '会員ＩＤ',
	`receive_data` TEXT COMMENT '予約データ',
	`created_at` DATETIME COMMENT 'レコード作成日時',
	`updated_at` DATETIME COMMENT 'レコード更新日時',
	PRIMARY KEY (`id`)
) COMMENT='予約登録からの会員登録時の予約情報一時保管テーブル（時間割任意制店舗予約） 予約中のフォームデータ（配列）などをserializeで一括保存。(最大64KB) member_temp_registration の紐付きがなくなればバッチで削除';

#-----------------------------------------------------------------------------
#-- member_temp_receive_timetable_fixed
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `member_temp_receive_timetable_fixed`;


CREATE TABLE `member_temp_receive_timetable_fixed`
(
	`id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT 'ID',
	`shop_id` BIGINT COMMENT '店舗ID',
	`member_id` INTEGER default 0 COMMENT '会員ＩＤ',
	`receive_data` TEXT COMMENT '予約データ',
	`created_at` DATETIME COMMENT 'レコード作成日時',
	`updated_at` DATETIME COMMENT 'レコード更新日時',
	PRIMARY KEY (`id`)
) COMMENT='予約登録からの会員登録時の予約情報一時保管テーブル（時間割固定制店舗予約） 予約中のフォームデータ（配列）などをserializeで一括保存。(最大64KB) member_temp_registration の紐付きがなくなればバッチで削除';

#-----------------------------------------------------------------------------
#-- town_restaurant_group
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `town_restaurant_group`;


CREATE TABLE `town_restaurant_group`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT COMMENT '自動生成プライマリキー',
	`name` VARCHAR(100)  NOT NULL COMMENT 'グループ名',
	`password` VARCHAR(20)  NOT NULL COMMENT 'パスワード',
	`status` TINYINT default 0 NOT NULL COMMENT '承認状態 0:承認 1:非承認',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`)
) COMMENT='レストラン街店舗グループテーブル';

#-----------------------------------------------------------------------------
#-- town_restaurant_group_shop
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `town_restaurant_group_shop`;


CREATE TABLE `town_restaurant_group_shop`
(
	`town_restaurant_group_id` INTEGER  NOT NULL COMMENT 'レストラン街店舗グループID',
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`town_restaurant_group_id`,`shop_id`),
	INDEX `town_restaurant_group_shop_FI_2` (`shop_id`)
) COMMENT='レストラン街店舗グループ紐付けテーブル';

#-----------------------------------------------------------------------------
#-- town_restaurant_group_login
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `town_restaurant_group_login`;


CREATE TABLE `town_restaurant_group_login`
(
	`id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT '自動生成プライマリキー',
	`town_restaurant_group_id` INTEGER  NOT NULL COMMENT 'レストラン街店舗グループID',
	`created_at` DATETIME,
	PRIMARY KEY (`id`),
	KEY `index_town_restaurant_group_id`(`town_restaurant_group_id`)
) COMMENT='レストラン街店舗グループログイン数判定テーブル';

#-----------------------------------------------------------------------------
#-- town_restaurant_session
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `town_restaurant_session`;


CREATE TABLE `town_restaurant_session`
(
	`id` VARCHAR(255)  NOT NULL COMMENT 'セッションID ランダム文字列',
	`data` TEXT  NOT NULL COMMENT 'symfonyのセッションデータ',
	`updated_at` DATETIME,
	PRIMARY KEY (`id`)
) COMMENT='レストラン街全体表示用セッション情報';

#-----------------------------------------------------------------------------
#-- serving_qr_call_mail_template
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `serving_qr_call_mail_template`;


CREATE TABLE `serving_qr_call_mail_template`
(
	`id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT 'プライマリキー',
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID',
	`call_number` TINYINT default 1 NOT NULL COMMENT 'N回目の呼び出しに使用',
	`sender` VARCHAR(64)  NOT NULL COMMENT '送信者',
	`subject` VARCHAR(64)  NOT NULL COMMENT '件名',
	`text` TEXT  NOT NULL COMMENT '本文',
	`created_at` DATETIME  NOT NULL COMMENT '作成日時',
	`updated_at` DATETIME  NOT NULL COMMENT '更新日時',
	PRIMARY KEY (`id`),
	UNIQUE KEY `serving_qr_call_mail_template_uniq` (`shop_id`, `call_number`),
	KEY `index_shop_id`(`shop_id`),
	KEY `index_call_number`(`call_number`)
) COMMENT='接客中QRコールメールテンプレート';

#-----------------------------------------------------------------------------
#-- shop_reserve_employee
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `shop_reserve_employee`;


CREATE TABLE `shop_reserve_employee`
(
	`id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT 'プライマリキー',
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID',
	`name` VARCHAR(20)  NOT NULL COMMENT '担当者名',
	`kana` VARCHAR(20)  NOT NULL COMMENT '担当者名（ひらがな）',
	`code` VARCHAR(20) COMMENT '担当者コード',
	`start_with` TINYINT  NOT NULL COMMENT '検索用カラム 0:あ行 1:か行 2:さ行 3:た行 4:な行 5:は行 6:ま行 7:や行 8:ら行 9:わ行',
	`status` TINYINT default 0 NOT NULL COMMENT 'ステータス 0:有効 1:無効 2:休止 9:削除済み',
	`department_id` BIGINT COMMENT '対応中部門ID',
	`service_start_time` DATETIME COMMENT '接客開始日時',
	`wait_time` SMALLINT default 0 NOT NULL COMMENT '担当者待ち時間',
	`delayed` TINYINT default 1 NOT NULL COMMENT '遅延フラグ 1:遅延なし 2:遅延中',
	`pda_login_id` INTEGER COMMENT 'PDAログインID',
	`created_at` DATETIME  NOT NULL COMMENT '作成日時',
	`updated_at` DATETIME  NOT NULL COMMENT '更新日時',
	PRIMARY KEY (`id`),
	INDEX `shop_reserve_employee_FI_1` (`shop_id`),
	INDEX `shop_reserve_employee_FI_2` (`department_id`)
) COMMENT='店舗担当者';

#-----------------------------------------------------------------------------
#-- serving_qr_call
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `serving_qr_call`;


CREATE TABLE `serving_qr_call`
(
	`id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT 'プライマリキー',
	`receive_id` BIGINT  NOT NULL COMMENT '予約ID',
	`qr_call_id` INTEGER  NOT NULL COMMENT 'QRコールID',
	`call1_at` DATETIME COMMENT '1回目呼出日時',
	`call2_at` DATETIME COMMENT '2回目呼出日時',
	`call3_at` DATETIME COMMENT '3回目呼出日時',
	`created_at` DATETIME  NOT NULL COMMENT '作成日時',
	`updated_at` DATETIME  NOT NULL COMMENT '更新日時',
	PRIMARY KEY (`id`),
	INDEX `serving_qr_call_FI_1` (`receive_id`),
	INDEX `serving_qr_call_FI_2` (`qr_call_id`)
) COMMENT='接客中QRコール';

#-----------------------------------------------------------------------------
#-- serving_qr_call_history
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `serving_qr_call_history`;


CREATE TABLE `serving_qr_call_history`
(
	`id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT 'プライマリキー',
	`receive_id` BIGINT  NOT NULL COMMENT '予約ID',
	`qr_call_id` INTEGER  NOT NULL COMMENT 'QRコールID',
	`call1_at` DATETIME COMMENT '1回目呼出日時',
	`call2_at` DATETIME COMMENT '2回目呼出日時',
	`call3_at` DATETIME COMMENT '3回目呼出日時',
	`original_created_at` DATETIME  NOT NULL COMMENT '移動前の作成日時',
	`original_updated_at` DATETIME  NOT NULL COMMENT '移動前の更新日時',
	`created_at` DATETIME  NOT NULL COMMENT '作成日時',
	`updated_at` DATETIME  NOT NULL COMMENT '更新日時',
	PRIMARY KEY (`id`)
) COMMENT='接客中QRコール履歴';

#-----------------------------------------------------------------------------
#-- member_call_mail_template
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `member_call_mail_template`;


CREATE TABLE `member_call_mail_template`
(
	`id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT 'プライマリキー',
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID',
	`call_delivery_type` TINYINT UNSIGNED default 0 NOT NULL COMMENT 'コール配信種別',
	`call_number` TINYINT default 1 NOT NULL COMMENT 'N回目の呼び出しに使用',
	`sender` VARCHAR(64)  NOT NULL COMMENT '送信者',
	`subject` VARCHAR(64)  NOT NULL COMMENT '件名',
	`text` TEXT  NOT NULL COMMENT 'メール本文',
	`created_at` DATETIME  NOT NULL COMMENT '作成日時',
	`updated_at` DATETIME  NOT NULL COMMENT '更新日時',
	PRIMARY KEY (`id`),
	UNIQUE KEY `uix_member_call_mail_template1` (`shop_id`, `call_delivery_type`, `call_number`),
	KEY `index_call_number`(`call_number`)
) COMMENT='携帯呼出メール内容';

#-----------------------------------------------------------------------------
#-- i_serv_memcall_tmpl
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `i_serv_memcall_tmpl`;


CREATE TABLE `i_serv_memcall_tmpl`
(
	`m_template_id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT 'メールテンプレートID（プライマリキー）',
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID',
	`call_number` TINYINT UNSIGNED default 1 NOT NULL COMMENT 'N回目の呼び出しに使用',
	`m_sender` VARCHAR(64)  NOT NULL COMMENT 'メール送信者',
	`m_subject` VARCHAR(64)  NOT NULL COMMENT 'メール件名',
	`m_text` VARCHAR(512)  NOT NULL COMMENT 'メール本文',
	`created_at` DATETIME  NOT NULL COMMENT '作成日時',
	`updated_at` DATETIME  NOT NULL COMMENT '更新日時',
	PRIMARY KEY (`m_template_id`),
	UNIQUE KEY `uix_i_serv_memcall_tmpl_1` (`shop_id`, `call_number`)
) COMMENT='接客中携帯呼出メール内容';

#-----------------------------------------------------------------------------
#-- search_keyword_log
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `search_keyword_log`;


CREATE TABLE `search_keyword_log`
(
	`id` BIGINT UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT 'プライマリキー',
	`carrier_type` TINYINT  NOT NULL COMMENT 'キャリア種別 1: 携帯 2: PC 3: スマートフォン',
	`service_code` VARCHAR(8) default '' NOT NULL COMMENT 'サービスコード',
	`member_id` INTEGER COMMENT '会員ID',
	`keyword` TEXT  NOT NULL COMMENT '検索文字列',
	`search_time` DATETIME  NOT NULL COMMENT '検索日時',
	PRIMARY KEY (`id`),
	KEY `index_carrier_type`(`carrier_type`)
) COMMENT='検索文字列ログ';

#-----------------------------------------------------------------------------
#-- portal_pr_shop
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `portal_pr_shop`;


CREATE TABLE `portal_pr_shop`
(
	`id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT 'id',
	`pref_code` INTEGER(8)  NOT NULL COMMENT '都道府県コード',
	`shop_id` INTEGER(8)  NOT NULL COMMENT '店舗ID',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	UNIQUE KEY `pr_shop_uniq` (`pref_code`, `shop_id`),
	KEY `index_pref_code`(`pref_code`)
) COMMENT='PR店舗リスト';

#-----------------------------------------------------------------------------
#-- portal_congestion_shop
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `portal_congestion_shop`;


CREATE TABLE `portal_congestion_shop`
(
	`id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT 'id',
	`congestion_id` INTEGER(8)  NOT NULL COMMENT '激コミID',
	`shop_id` INTEGER(8)  NOT NULL COMMENT '店舗ID',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	UNIQUE KEY `congestion_shop_uniq` (`congestion_id`, `shop_id`),
	KEY `index_congestion_id`(`congestion_id`)
) COMMENT='激コミ店舗リストテーブル';

#-----------------------------------------------------------------------------
#-- mobile_landing_page
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `mobile_landing_page`;


CREATE TABLE `mobile_landing_page`
(
	`id` INTEGER  NOT NULL COMMENT 'ID',
	`name` VARCHAR(100)  NOT NULL COMMENT 'LP名（システム固定）',
	`url` VARCHAR(1000)  NOT NULL COMMENT 'URL （省略時は自動生成・指定時は単純に入力値保持）',
	`content` TEXT COMMENT '本文（HTML可・携帯用）',
	`content_sp` TEXT COMMENT '本文（HTML可・SP用）',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`)
) COMMENT='携帯ランディングページ管理';

#-----------------------------------------------------------------------------
#-- mobile_landing_page_image
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `mobile_landing_page_image`;


CREATE TABLE `mobile_landing_page_image`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT COMMENT 'ID',
	`mobile_landing_page_id` INTEGER  NOT NULL COMMENT 'LP ID',
	`type` TINYINT  NOT NULL COMMENT '画像種別 1: 携帯用, 2:スマートフォン用',
	`display_order` INTEGER  NOT NULL COMMENT '画像並び順',
	`file_name` VARCHAR(100)  NOT NULL COMMENT '画像ファイル名',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	UNIQUE KEY `unique_mobile_landing_page_image` (`mobile_landing_page_id`, `type`, `display_order`)
) COMMENT='携帯ランディングページ画像ファイル';

#-----------------------------------------------------------------------------
#-- shop_point_mst
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `shop_point_mst`;


CREATE TABLE `shop_point_mst`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT COMMENT '自動生成プライマリキー',
	`shop_id` INTEGER COMMENT '店舗ID ※店舗IDあるいはグループIDのどちらかのみを持つ',
	`group_id` INTEGER COMMENT 'グループ店舗ID ※店舗IDあるいはグループIDのどちらかのみを持つ',
	`status` TINYINT default 1 NOT NULL COMMENT '来店ポイント運用状態 0:運用中 1:停止中',
	`mode` TINYINT default 0 NOT NULL COMMENT '来店ポイント モード 0:来店ポイント 1:来店スタンプ',
	`point_limit_status` TINYINT default 0 NOT NULL COMMENT 'ポイント有効期限 状態 0:無期限 1:付与したポイントごとに 2:ポイントを最後に付与した日から 3:スタンプ初回付与日から',
	`point_limit_span` TINYINT COMMENT '有効月数：１～36',
	`point_limit_end` TINYINT default 0 NOT NULL COMMENT '有効期間の期限 0：付与した日まで 1：月末まで有効',
	`point_limit_news_status` TINYINT default 1 NOT NULL COMMENT '期限切れ告知メール送信 状態：0：する 1：しない',
	`point_limit_news_sender` VARCHAR(80) COMMENT '配信者名',
	`point_limit_news_title` VARCHAR(100) default '' NOT NULL COMMENT '配信タイトル',
	`point_limit_news_body` VARCHAR(1500) COMMENT 'メール本文（1000文字以内）',
	`send_before_days` TINYINT COMMENT '期限切れメール配信日 ： 期限切れの何日前',
	`send_hours` TINYINT COMMENT '期限切れメール配信日 ： 時間',
	`take_coupon` TINYINT default 0 NOT NULL COMMENT 'クーポンの取得 0:発券機で印刷する 1:クーポン番号を携帯に送る',
	`group_common_name_status` TINYINT default 1 NOT NULL COMMENT 'グループ店舗共通の名称 利用設定 0:利用する 1:利用しない',
	`group_common_name` VARCHAR(100) default '' NOT NULL COMMENT 'グループ店舗共通の名称設定',
	`mobile_lp_text` TEXT COMMENT 'モバイル会員証ＬＰページの表示(1000文字以内)',
	`touch_point_button` TINYINT default 1 NOT NULL COMMENT 'タッチパネル(店頭受付用）：ポイント発行ボタン表示：0:表示 1:非表示 ',
	`touch_change_rank` TINYINT default 1 NOT NULL COMMENT 'タッチパネル(スタッフ用）：来店ポイント ランク手動変更ボタン表示設定（0:表示 1:非表示） ',
	`touch_coupon_button` TINYINT default 0 NOT NULL COMMENT 'タッチパネル(店頭/スタッフ）：「現在使えるクーポンを表示」ボタン表示：0:表示 1:非表示 ',
	`touch_coupon_button_payment` TINYINT default 1 NOT NULL COMMENT 'タッチパネル(スタッフ会計時）：「現在使えるクーポンを表示」ボタン表示：0:表示 1:非表示 ',
	`touch_point_manual_ui` TINYINT default 1 NOT NULL COMMENT 'タッチパネル(店頭受付用）：ポイント付与数入力画面　表示：0:使用可 1:使用不可 ',
	`touch_point_min_value` INTEGER COMMENT 'タッチパネル(店頭受付用）：ポイント付与最小 1-99999 ',
	`touch_point_max_value` INTEGER COMMENT 'タッチパネル(店頭受付用）：ポイント付与最大 1-99999 ',
	`touch_next_add_point_type` TINYINT default 0 NOT NULL COMMENT '次回のポイント付与ができるまでの間隔種別 0:1日 1:時間',
	`touch_next_add_point_hours` INTEGER default 0 NOT NULL COMMENT '次回のポイント付与ができるまでの間隔（「1:時間」の時の時間数）',
	`touch_coupon_multi_button` TINYINT default 1 NOT NULL COMMENT 'タッチパネル（店頭受付用）： クーポン複数発券ボタン 表示 0：表示 1：非表示 ',
	`touch_point_guide_text` VARCHAR(100) COMMENT '非会員向け案内コメント(2013/09/02 #8669対応にて、未使用の為、管理画面より項目を非表示化) ',
	`touch_point_only` TINYINT default 1 NOT NULL COMMENT 'タッチパネル ： 来店ポイントのみ付与： 0:使用可 1:使用不可',
	`fst_vst_bns_point` INTEGER default 0 NOT NULL COMMENT '初回来店ボーナスポイント',
	`sp_show_schedule` TINYINT default 1 NOT NULL COMMENT '店舗イベント機能表示区分： 0:表示 1:非表示',
	`xorder_extend_link` TINYINT default 1 NOT NULL COMMENT 'XORDER連携拡張区分： 0:使用可 1:使用不可',
	`emenu_extend_link` TINYINT default 1 NOT NULL COMMENT 'e-menu連携拡張区分： 0:使用可 1:使用不可',
	`point_target_type` TINYINT UNSIGNED default 2 NOT NULL COMMENT 'ダイニングレジ連携ポイント付与対象区分 1:税込価格 2:税抜価格',
	`cb_logo_image` VARCHAR(100) default '' NOT NULL COMMENT 'CardBook用ロゴ画像',
	`cb_image` VARCHAR(100) default '' NOT NULL COMMENT 'CardBook用メイン画像',
	`cb_stamp_image` VARCHAR(100) default '' NOT NULL COMMENT 'CardBook用スタンプ画像',
	`cb_color` VARCHAR(6) default '' NOT NULL COMMENT 'CardBook用背景色',
	`mail_coupon_point` INTEGER default 0 NOT NULL COMMENT 'メール配信クーポン使用時付与スタンプ数',
	`point_coupon_point` INTEGER default 0 NOT NULL COMMENT '来店ポイントクーポン使用時付与スタンプ数',
	`order_coupon_point` INTEGER default 0 NOT NULL COMMENT '配信オーダークーポン使用時付与スタンプ数',
	`use_cardbook_flg` TINYINT UNSIGNED default 0 NOT NULL COMMENT 'Cardbook利用フラグ 0:使用不可 1:使用可',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	UNIQUE KEY `unique_shop_id` (`shop_id`),
	UNIQUE KEY `unique_group_id` (`group_id`),
	KEY `index_status`(`status`)
) COMMENT='来店ポイント マスタ';

#-----------------------------------------------------------------------------
#-- shop_point_relation
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `shop_point_relation`;


CREATE TABLE `shop_point_relation`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT COMMENT '自動生成プライマリキー',
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID',
	`shop_point_mst_id` INTEGER  NOT NULL COMMENT '来店ポイントマスタID',
	PRIMARY KEY (`id`),
	UNIQUE KEY `unique_shop_id` (`shop_id`),
	INDEX `shop_point_relation_FI_2` (`shop_point_mst_id`)
) COMMENT='店舗-来店ポイントマスタ連結テーブル';

#-----------------------------------------------------------------------------
#-- shop_point_line
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `shop_point_line`;


CREATE TABLE `shop_point_line`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT COMMENT '自動生成プライマリキー',
	`shop_point_mst_id` INTEGER  NOT NULL COMMENT '来店ポイントマスタID',
	`shop_point_rank_id` INTEGER  NOT NULL COMMENT '会員ランクID',
	`setting_id` INTEGER default 0 NOT NULL COMMENT '来店ポイント個別設定ID',
	`week_day_id` TINYINT  NOT NULL COMMENT '曜日 0：日1：月2：火3：水4：木5：金6：土7：祝',
	`time_default` INTEGER COMMENT '時間帯共通値',
	`time_0` INTEGER COMMENT '0時台',
	`time_1` INTEGER COMMENT '1時台',
	`time_2` INTEGER COMMENT '2時台',
	`time_3` INTEGER COMMENT '3時台',
	`time_4` INTEGER COMMENT '4時台',
	`time_5` INTEGER COMMENT '5時台',
	`time_6` INTEGER COMMENT '6時台',
	`time_7` INTEGER COMMENT '7時台',
	`time_8` INTEGER COMMENT '8時台',
	`time_9` INTEGER COMMENT '9時台',
	`time_10` INTEGER COMMENT '10時台',
	`time_11` INTEGER COMMENT '11時台',
	`time_12` INTEGER COMMENT '12時台',
	`time_13` INTEGER COMMENT '13時台',
	`time_14` INTEGER COMMENT '14時台',
	`time_15` INTEGER COMMENT '15時台',
	`time_16` INTEGER COMMENT '16時台',
	`time_17` INTEGER COMMENT '17時台',
	`time_18` INTEGER COMMENT '18時台',
	`time_19` INTEGER COMMENT '19時台',
	`time_20` INTEGER COMMENT '20時台',
	`time_21` INTEGER COMMENT '21時台',
	`time_22` INTEGER COMMENT '22時台',
	`time_23` INTEGER COMMENT '23時台',
	`time_24` INTEGER COMMENT '24時台',
	`time_25` INTEGER COMMENT '25時台',
	`time_26` INTEGER COMMENT '26時台',
	`time_27` INTEGER COMMENT '27時台',
	`time_28` INTEGER COMMENT '28時台',
	`time_29` INTEGER COMMENT '29時台',
	`time_30` INTEGER COMMENT '30時台',
	`time_31` INTEGER COMMENT '31時台',
	`time_32` INTEGER COMMENT '32時台',
	`time_33` INTEGER COMMENT '33時台',
	`time_34` INTEGER COMMENT '34時台',
	`time_35` INTEGER COMMENT '35時台',
	`time_36` INTEGER COMMENT '36時台',
	`time_37` INTEGER COMMENT '37時台',
	`time_38` INTEGER COMMENT '38時台',
	`time_39` INTEGER COMMENT '39時台',
	`time_40` INTEGER COMMENT '40時台',
	`time_41` INTEGER COMMENT '41時台',
	`time_42` INTEGER COMMENT '42時台',
	`time_43` INTEGER COMMENT '43時台',
	`time_44` INTEGER COMMENT '44時台',
	`time_45` INTEGER COMMENT '45時台',
	`time_46` INTEGER COMMENT '46時台',
	`time_47` INTEGER COMMENT '47時台',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	UNIQUE KEY `unique_shop_point_line` (`shop_point_rank_id`, `setting_id`, `week_day_id`),
	KEY `index_shop_point_mst_id`(`shop_point_mst_id`)
) COMMENT='曜日・時間帯別 来店ポイント付与設定';

#-----------------------------------------------------------------------------
#-- shop_point_repeat_point_config
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `shop_point_repeat_point_config`;


CREATE TABLE `shop_point_repeat_point_config`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT COMMENT '自動生成プライマリキー',
	`shop_point_mst_id` INTEGER  NOT NULL COMMENT '来店ポイントマスタID',
	`shop_point_rank_id` INTEGER  NOT NULL COMMENT '会員ランクID',
	`setting_id` INTEGER default 0 NOT NULL COMMENT '来店ポイント個別設定ID',
	`rpt_point_status` TINYINT default 1 NOT NULL COMMENT 'リピートポイント 0：使用する 1：使用しない',
	`rpt_point_times` TINYINT default 0 NOT NULL COMMENT 'リピートポイント最終来店からの期間値 １～6',
	`rpt_point_times_span` TINYINT default 0 NOT NULL COMMENT 'リピートポイント最終来店期間単位 0：月 1：年',
	`rpt_point_case_1_from` INTEGER COMMENT 'リピートポイント条件1 開始回数',
	`rpt_point_case_1_to` INTEGER COMMENT 'リピートポイント条件1 終了回数',
	`rpt_point_case_1_point` INTEGER COMMENT 'リピートポイント条件1 付与数',
	`rpt_point_case_2_from` INTEGER COMMENT 'リピートポイント条件2 開始回数',
	`rpt_point_case_2_to` INTEGER COMMENT 'リピートポイント条件2 終了回数',
	`rpt_point_case_2_point` INTEGER COMMENT 'リピートポイント条件2 付与数',
	`rpt_point_case_3_from` INTEGER COMMENT 'リピートポイント条件3 開始回数',
	`rpt_point_case_3_to` INTEGER COMMENT 'リピートポイント条件3 終了回数',
	`rpt_point_case_3_point` INTEGER COMMENT 'リピートポイント条件3 付与数',
	`rpt_point_case_4_from` INTEGER COMMENT 'リピートポイント条件4 開始回数',
	`rpt_point_case_4_to` INTEGER COMMENT 'リピートポイント条件4 終了回数',
	`rpt_point_case_4_point` INTEGER COMMENT 'リピートポイント条件4 付与数',
	`rpt_point_case_5_from` INTEGER COMMENT 'リピートポイント条件5 開始回数',
	`rpt_point_case_5_to` INTEGER COMMENT 'リピートポイント条件5 終了回数',
	`rpt_point_case_5_point` INTEGER COMMENT 'リピートポイント条件5 付与数',
	`rpt_point_case_6_from` INTEGER COMMENT 'リピートポイント条件6 開始回数',
	`rpt_point_case_6_to` INTEGER COMMENT 'リピートポイント条件6 終了回数',
	`rpt_point_case_6_point` INTEGER COMMENT 'リピートポイント条件6 付与数',
	`rpt_point_case_7_from` INTEGER COMMENT 'リピートポイント条件7 開始回数',
	`rpt_point_case_7_to` INTEGER COMMENT 'リピートポイント条件7 終了回数',
	`rpt_point_case_7_point` INTEGER COMMENT 'リピートポイント条件7 付与数',
	`rpt_point_case_8_from` INTEGER COMMENT 'リピートポイント条件8 開始回数',
	`rpt_point_case_8_to` INTEGER COMMENT 'リピートポイント条件8 終了回数',
	`rpt_point_case_8_point` INTEGER COMMENT 'リピートポイント条件8 付与数',
	`rpt_point_case_9_from` INTEGER COMMENT 'リピートポイント条件9 開始回数',
	`rpt_point_case_9_to` INTEGER COMMENT 'リピートポイント条件9 終了回数',
	`rpt_point_case_9_point` INTEGER COMMENT 'リピートポイント条件9 付与数',
	`rpt_point_case_10_from` INTEGER COMMENT 'リピートポイント条件10 開始回数',
	`rpt_point_case_10_to` INTEGER COMMENT 'リピートポイント条件10 終了回数',
	`rpt_point_case_10_point` INTEGER COMMENT 'リピートポイント条件10 付与数',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	UNIQUE KEY `unique_shop_point_rank_id` (`shop_point_rank_id`, `setting_id`),
	KEY `index_shop_point_mst_id`(`shop_point_mst_id`)
) COMMENT='リピートポイント設定';

#-----------------------------------------------------------------------------
#-- shop_point_event_schedule
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `shop_point_event_schedule`;


CREATE TABLE `shop_point_event_schedule`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT COMMENT '自動生成プライマリキー',
	`shop_point_mst_id` INTEGER  NOT NULL COMMENT '来店ポイントマスタID',
	`shop_point_rank_id` INTEGER  NOT NULL COMMENT '会員ランクID',
	`event_number` TINYINT  NOT NULL COMMENT '条件番号',
	`event_name` VARCHAR(100)  NOT NULL COMMENT 'イベント名',
	`event_type` TINYINT default 1 NOT NULL COMMENT '種別 1:イベント 2:誕生日',
	`overlap_type` TINYINT default 1 NOT NULL COMMENT '重複時挙動 1:優先順位 2:複数適用',
	`priority` TINYINT COMMENT '使用優先順位',
	`event_status` TINYINT default 0 NOT NULL COMMENT 'ステータス 0:使用しない 1～ 種別によって変更。   種別 「1:イベント」の場合 1:使用する 2:使用する（年齢制限あり）   種別 「2:誕生日」の場合 1:誕生日当日 2:誕生日月 3:誕生日当日から前○日 4:誕生日当日から後○日 5:誕生日当日から前後○日',
	`apply_point_status` TINYINT default 1 NOT NULL COMMENT '「ポイント付与」で利用するか 1:利用する 2:利用しない',
	`apply_payment_status` TINYINT default 1 NOT NULL COMMENT '「会計額で付与」で利用するか 1:利用する 2:利用しない',
	`calc_status` TINYINT default 0 NOT NULL COMMENT 'ポイント付与方法 0：加算 1：倍率',
	`add_point` INTEGER COMMENT '付与加算値',
	`point_rate` DECIMAL(4,2) COMMENT '付与倍率',
	`term_status` TINYINT default 1 NOT NULL COMMENT '有効期間設定 1:指定する 2:指定しない',
	`term_start` DATETIME COMMENT '有効期間開始年月日',
	`term_end` DATETIME COMMENT '有効期間終了年月日',
	`age_min` INTEGER COMMENT '年齢下限',
	`age_max` INTEGER COMMENT '年齢上限',
	`sex_status` TINYINT default 3 NOT NULL COMMENT '性別条件 1:男性 2:女性 3:両方',
	`birthday_span` INTEGER COMMENT '「誕生日」期間設定数値',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	UNIQUE KEY `unique_shop_point_event_schedule` (`shop_point_rank_id`, `event_number`),
	INDEX `shop_point_event_schedule_FI_1` (`shop_point_mst_id`)
) COMMENT='来店ポイント イベント付与設定';

#-----------------------------------------------------------------------------
#-- shop_point_event_schedule_time
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `shop_point_event_schedule_time`;


CREATE TABLE `shop_point_event_schedule_time`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT COMMENT '自動生成プライマリキー',
	`shop_point_mst_id` INTEGER  NOT NULL COMMENT '来店ポイントマスタID',
	`shop_point_rank_id` INTEGER  NOT NULL COMMENT '会員ランクID',
	`shop_point_event_schedule_id` INTEGER  NOT NULL COMMENT 'イベントID',
	`display_order` INTEGER  NOT NULL COMMENT '表示順',
	`type` TINYINT default 1 NOT NULL COMMENT '種別 1:毎月○日 2:毎週○曜日 3:毎日（時刻のみ）',
	`day_number` TINYINT COMMENT '日付数値',
	`week_day_id` TINYINT COMMENT '曜日数値',
	`start_time` TIME COMMENT '開始時刻',
	`end_time` TIME COMMENT '終了時刻',
	`status` TINYINT default 2 NOT NULL COMMENT '状態 1:有効 2:無効',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	UNIQUE KEY `unique_shop_point_event_schedule_time` (`shop_point_event_schedule_id`, `display_order`),
	INDEX `shop_point_event_schedule_time_FI_1` (`shop_point_mst_id`),
	INDEX `shop_point_event_schedule_time_FI_2` (`shop_point_rank_id`)
) COMMENT='来店ポイント イベント付与 時間設定';

#-----------------------------------------------------------------------------
#-- shop_point_rank
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `shop_point_rank`;


CREATE TABLE `shop_point_rank`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT COMMENT '自動生成プライマリキー',
	`shop_point_mst_id` INTEGER  NOT NULL COMMENT '来店ポイントマスタID',
	`rank` TINYINT  NOT NULL COMMENT '会員ランク 1:ダイヤモンド 2:プラチナ 3:ゴールド 4:シルバー 5:ブロンズ',
	`status` TINYINT default 0 NOT NULL COMMENT 'ステータス0:運用中1:停止中',
	`rank_order` TINYINT  NOT NULL COMMENT 'ランク高低順(1:最高) 当初はrankと同じ値',
	`rank_name` VARCHAR(10) COMMENT 'ランク設定名',
	`default_point` INTEGER default 0 NOT NULL COMMENT 'デフォルトポイント付与数',
	`rank_up_status` INTEGER default 0 NOT NULL COMMENT 'ランクアップ条件 0:来店回数でランクアップ 1:ポイント数でランクアップ 2:累計ポイント数でランクアップ',
	`rank_up_times` TINYINT COMMENT 'ランクアップ条件 直近からの期間値 １～12',
	`rank_up_count` INTEGER COMMENT 'ランクアップ条件　来店回数　10～99数',
	`rank_up_point` INTEGER COMMENT 'ランクアップ条件　ポイント数',
	`rank_up_total_point` INTEGER COMMENT 'ランクアップ条件　累計ポイント数',
	`card_type` TINYINT default 0 NOT NULL COMMENT 'カード画像タイプ 0～10',
	`card_logo_img` VARCHAR(200) COMMENT 'カード画像パス',
	`rank_down_status` TINYINT default 1 COMMENT 'ランクダウン設定 状態 0：有効にする 1：有効にしない。',
	`rank_down_times` TINYINT COMMENT 'ランクダウン 期間　1～12　（単位：月）',
	`rank_down_visit_count` TINYINT COMMENT 'ランクダウン 回数　1～30　（単位：回）',
	`memo` VARCHAR(200),
	`payment_point_status` TINYINT default 1 NOT NULL COMMENT '会計額でポイント付与 0:する 1:しない',
	`payment_point_type` TINYINT default 0 NOT NULL COMMENT '会計額でポイント付与：計算式設定 0:A:○円ごとに○ポイント 1:B:割合（％）',
	`payment_point_type_a_base_amount` INTEGER default 0 NOT NULL COMMENT '会計額でポイント付与：計算式A 基準金額',
	`payment_point_type_a_point` INTEGER default 0 NOT NULL COMMENT '会計額でポイント付与：計算式A 付与ポイント',
	`payment_point_type_b_rate` INTEGER default 0 NOT NULL COMMENT '会計額でポイント付与：計算式B ％数値',
	`payment_point_round_type` TINYINT default 0 NOT NULL COMMENT '会計額でポイント付与：計算式 小数点設定 0:切り捨て 1:四捨五入 2:切り上げ',
	`payment_point_cut_off_amount` INTEGER default 0 NOT NULL COMMENT '会計額でポイント付与：最低会計額',
	`calc_status` TINYINT default 0 NOT NULL COMMENT 'ポイント付与スケジュール ポイント付与方法 0：加算 1：倍率',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	UNIQUE KEY `unique_shop_point_rank` (`shop_point_mst_id`, `rank`),
	UNIQUE KEY `unique_shop_point_rank_order` (`shop_point_mst_id`, `rank_order`)
) COMMENT='ポイントランクマスタ';

#-----------------------------------------------------------------------------
#-- shop_point_rule_folder
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `shop_point_rule_folder`;


CREATE TABLE `shop_point_rule_folder`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT COMMENT '自動生成プライマリキー',
	`shop_point_mst_id` INTEGER  NOT NULL COMMENT '来店ポイントマスタID',
	`name` VARCHAR(100)  NOT NULL COMMENT '保存先フォルダ名',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	KEY `index_shop_point_mst_id`(`shop_point_mst_id`)
) COMMENT='ポイント管理クーポン引換ルール保存フォルダ';

#-----------------------------------------------------------------------------
#-- shop_point_exchange_rules
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `shop_point_exchange_rules`;


CREATE TABLE `shop_point_exchange_rules`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT COMMENT '自動生成プライマリキー',
	`shop_point_mst_id` INTEGER  NOT NULL COMMENT '来店ポイントマスタID',
	`rule_name` VARCHAR(100) default '' NOT NULL COMMENT '引換ルール名称',
	`rank_list` VARCHAR(100)  NOT NULL COMMENT '会員ランク 1:ダイヤモンド 2:プラチナ 3:ゴールド 4:シルバー 5:ブロンズ カンマ区切りで格納される',
	`change_type` TINYINT default 0 NOT NULL COMMENT '引換種別 0：常時, 1：ポイントと引換, 2：ランクアップ特典, 3 : 規定スタンプ数到達(最上位ランク), 4 : ボーナス (チェックイン)',
	`rankup_mail_status` TINYINT default 0 NOT NULL COMMENT '0：しない, 1：する',
	`sex` TINYINT COMMENT '性別 0: 男性 1: 女性 NULL：指定なし',
	`age_min` TINYINT COMMENT '年齢下限',
	`age_max` TINYINT COMMENT '年齢上限',
	`coupon_point` INTEGER COMMENT 'クーポン引換必要ポイント数',
	`coupon_name` VARCHAR(100)  NOT NULL COMMENT 'クーポン名称',
	`coupon_contents` TEXT  NOT NULL COMMENT 'クーポン内容',
	`coupon_print_comment` TEXT  NOT NULL COMMENT '印字用クーポン説明',
	`coupon_send_status` TINYINT default 0 NOT NULL COMMENT '引換条件指定の利用状態 0：配信期間のみ 1:配信数のみ 2：両方 （２つのチェックボックスの組み合わせ状態）',
	`coupon_send_start` DATETIME COMMENT 'クーポン配信開始 日時',
	`coupon_send_end` DATETIME COMMENT 'クーポン配信終了 日時',
	`coupon_time_start` TIME COMMENT 'クーポン有効時間帯 開始時分',
	`coupon_time_end` TIME COMMENT 'クーポン有効時間帯 終了時分',
	`coupon_use_week` VARCHAR(20) COMMENT 'クーポン有効日付指定 曜日カンマ区切り 0：日1：月2：火3：水4：木5：金6：土7：祝',
	`coupon_use_days` VARCHAR(150) COMMENT 'クーポン有効日時指定 日付 カンマ区切り',
	`coupon_use_status` TINYINT default 0 NOT NULL COMMENT 'クーポン有効日付指定 状態 0:指定なし 1:指定する',
	`coupon_send_limit_status` TINYINT default 0 NOT NULL COMMENT 'クーポン配信数 状態 0:指定なし 1:指定する。',
	`coupon_send_limit` INTEGER COMMENT 'クーポン配信数',
	`coupon_use_limit_status` TINYINT default 0 NOT NULL COMMENT '利用可能回数 状態 0:指定なし 1:指定する 2: 1日当り',
	`coupon_use_limit` INTEGER COMMENT 'クーポン利用可能回数',
	`coupon_use_limit_per_day` INTEGER COMMENT 'クーポン利用可能回数（1日当り）',
	`coupon_end_ui_status` TINYINT default 0 NOT NULL COMMENT 'クーポン終了時処理 状態 0:非表示にする 1:表示する ',
	`coupon_end_ui_term` INTEGER COMMENT 'クーポン終了後の表示期間 1～7',
	`coupon_number_status` TINYINT default 1 NOT NULL COMMENT 'クーポンを番号表示 設定 0:非表示 1:表示',
	`coupon_mobile_exchange_button_status` TINYINT default 0 NOT NULL COMMENT 'クーポンを使用済にするボタンの表示 設定 0:非表示 1:表示',
	`coupon_rev_sts` TINYINT UNSIGNED default 0 COMMENT '規定スタンプ数到達クーポン利用期限 状態',
	`coupon_rev_unit` TINYINT UNSIGNED default 1 COMMENT '規定スタンプ数到達クーポン利用期限 単位',
	`coupon_rev_day` TINYINT UNSIGNED COMMENT '規定スタンプ数到達クーポン利用期限 日数',
	`folder_id` INTEGER COMMENT 'ルール保存先フォルダID shop_point_rule_folder.id',
	`status` TINYINT default 0 NOT NULL COMMENT '運用状態 0:停止中 1:運用中',
	`rankup_limit_type` TINYINT COMMENT 'ランクアップ有効期限の指定あり・なし',
	`rankup_limit_unit_type` TINYINT COMMENT 'ランクアップ有効期限の単位',
	`rankup_limit_cnt` INTEGER COMMENT 'ランクアップ有効期限の期間',
	`coupon_img` VARCHAR(50) COMMENT 'クーポン画像',
	`add_coupon_point` INTEGER  NOT NULL COMMENT 'クーポン使用時付与スタンプ数',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	KEY `index_shop_point_mst_id`(`shop_point_mst_id`)
) COMMENT='会員証管理';

#-----------------------------------------------------------------------------
#-- shop_point_exchange_rules_shop
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `shop_point_exchange_rules_shop`;


CREATE TABLE `shop_point_exchange_rules_shop`
(
	`shop_point_exchange_rules_id` INTEGER  NOT NULL COMMENT 'クーポン引換ルールID',
	`shop_id` INTEGER  NOT NULL COMMENT '有効店舗ID',
	`use_shop_coupon_display_setting` TINYINT default 0 NOT NULL COMMENT 'クーポン番号・クーポンボタン設定の店舗個別設定利用指定 0:店舗の設定を使用しない 1:店舗の設定を使用する',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`shop_point_exchange_rules_id`,`shop_id`),
	INDEX `shop_point_exchange_rules_shop_FI_2` (`shop_id`)
) COMMENT='クーポン引換ルール 有効店舗連結テーブル';

#-----------------------------------------------------------------------------
#-- shop_point_coupon_piece
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `shop_point_coupon_piece`;


CREATE TABLE `shop_point_coupon_piece`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT COMMENT '自動生成プライマリキー',
	`shop_member_card_id` INTEGER  NOT NULL COMMENT '来店ポイント会員証ID',
	`coupon_id` INTEGER  NOT NULL COMMENT 'クーポンID （現状、shop_point_exchange_rules.id）',
	`print_number` BIGINT  NOT NULL COMMENT 'クーポン番号 （coupon_piece ともあわせてユニークを維持する）',
	`numbered_at` DATETIME  NOT NULL COMMENT '発番日時',
	`use_count` INTEGER default 0 NOT NULL COMMENT '累計利用回数 member_point_paymentの集計と一致するはずの値。※利用回数制限のチェックにはこちらを利用した方がよい？（カウントリセット等の要件が出た場合）',
	`shop_point_mst_id` INTEGER  NOT NULL COMMENT '来店ポイントマスタID （冗長）',
	`coupon_shop_id` INTEGER COMMENT '店舗ID （冗長）※店舗IDあるいはグループIDのどちらかのみを持つ',
	`coupon_group_id` INTEGER COMMENT 'グループ店舗ID （冗長）※店舗IDあるいはグループIDのどちらかのみを持つ',
	`member_id` INTEGER  NOT NULL COMMENT '会員ID（冗長）',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	UNIQUE KEY `unique_print_number` (`print_number`),
	KEY `index_shop_member_card_id`(`shop_member_card_id`),
	KEY `index_coupon_id`(`coupon_id`),
	KEY `index_print_number`(`print_number`),
	INDEX `shop_point_coupon_piece_FI_2` (`shop_point_mst_id`)
) COMMENT='来店ポイントクーポン クーポン番号テーブル';

#-----------------------------------------------------------------------------
#-- t_shop_point_cpn_rev
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `t_shop_point_cpn_rev`;


CREATE TABLE `t_shop_point_cpn_rev`
(
	`cpn_id` INTEGER(11)  NOT NULL COMMENT '来店ポイント引換クーポンID',
	`shop_member_card_id` INTEGER(11)  NOT NULL COMMENT '来店ポイント会員証ID',
	`round_cnt` TINYINT  NOT NULL COMMENT '会員証_周回回数',
	`cpn_issue_day` DATETIME  NOT NULL COMMENT 'クーポン発行日',
	`cpn_rapse_day` DATETIME  NOT NULL COMMENT 'クーポン失効日',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`cpn_id`,`shop_member_card_id`,`round_cnt`),
	KEY `index_cpn_id`(`cpn_id`),
	KEY `index_shop_member_card_id`(`shop_member_card_id`),
	KEY `index_cpn_rapse_day`(`cpn_rapse_day`),
	INDEX `t_shop_point_cpn_rev_FI_3` (`round_cnt`)
) COMMENT='T_来店ポイント_クーポン有効期限';

#-----------------------------------------------------------------------------
#-- point_piece
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `point_piece`;


CREATE TABLE `point_piece`
(
	`id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT '自動生成プライマリキー',
	`mail_id` INTEGER  NOT NULL COMMENT 'メールID （shop_mail.id OR group_mail.id）',
	`shop_id` INTEGER COMMENT '店舗ID',
	`group_id` INTEGER COMMENT 'グループ店舗ID',
	`shop_point_mst_id` INTEGER  NOT NULL COMMENT '来店ポイントマスタID',
	`member_id` INTEGER  NOT NULL COMMENT '会員ID',
	`qr_key` VARCHAR(26)  NOT NULL COMMENT 'QRコード文字列',
	`status` TINYINT default 0 NOT NULL COMMENT '取得状況 0:未取得 1:取得済み',
	`acquired_at` DATETIME COMMENT 'ポイント取得日時',
	`acquired_point` INTEGER COMMENT '取得ポイント',
	`acquired_shop_id` INTEGER default 0 COMMENT '取得店舗ID',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	UNIQUE KEY `unique_qr_key` (`qr_key`),
	INDEX `point_piece_FI_1` (`shop_id`),
	INDEX `point_piece_FI_2` (`group_id`)
) COMMENT='ポイントメールキー保持テーブル (ポイント取得有効期限終了から一ヶ月たったものはバッチで消されます。)';

#-----------------------------------------------------------------------------
#-- member_card
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `member_card`;


CREATE TABLE `member_card`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT COMMENT '自動生成プライマリキー',
	`member_id` INTEGER  NOT NULL COMMENT '会員ID',
	`card_id` VARCHAR(20)  NOT NULL COMMENT '会員証ID',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	UNIQUE KEY `unique_member_id` (`member_id`),
	UNIQUE KEY `unique_card_id` (`card_id`)
) COMMENT='会員証ID管理テーブル';

#-----------------------------------------------------------------------------
#-- shop_member_card
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `shop_member_card`;


CREATE TABLE `shop_member_card`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT COMMENT '自動生成プライマリキー',
	`shop_point_mst_id` INTEGER  NOT NULL COMMENT '来店ポイントマスタID',
	`member_id` INTEGER  NOT NULL COMMENT '会員ID',
	`rank` TINYINT  NOT NULL COMMENT '会員ランク 1:ダイヤモンド 2:プラチナ 3:ゴールド 4:シルバー 5:ブロンズ',
	`status` TINYINT default 0 NOT NULL COMMENT '会員証の有効性 ０：有効 １：無効',
	`registered_shop_id` INTEGER default 0 NOT NULL COMMENT '登録した店舗ID',
	`shop_id` INTEGER COMMENT '店舗ID ※記録用。店舗IDあるいはグループIDのどちらかのみを持つ',
	`group_id` INTEGER COMMENT 'グループ店舗ID ※記録用。店舗IDあるいはグループIDのどちらかのみを持つ',
	`round` TINYINT default 0 NOT NULL COMMENT '来店スタンプ用 最上位クーポン用 周回回数記録カラム',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	KEY `index_shop_point_mst_id`(`shop_point_mst_id`),
	KEY `index_shop_member_card`(`registered_shop_id`, `member_id`),
	INDEX `I_referenced_t_shop_point_cpn_rev_FK_3_1` (`round`)
) COMMENT='来店ポイント会員証';

#-----------------------------------------------------------------------------
#-- shop_member_point_record
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `shop_member_point_record`;


CREATE TABLE `shop_member_point_record`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT COMMENT '自動生成プライマリキー',
	`shop_member_card_id` INTEGER  NOT NULL COMMENT '来店ポイント会員証ID',
	`member_id` INTEGER  NOT NULL COMMENT '会員ID',
	`type` TINYINT default 0 NOT NULL COMMENT '種別 0:加算ポイント 1: 交換ポイント',
	`status` TINYINT default 0 NOT NULL COMMENT '状態 0: 有効 1無効',
	`point` INTEGER default 0 NOT NULL COMMENT 'ポイント',
	`use_point` INTEGER default 0 NOT NULL COMMENT '利用ポイント',
	`revocation_date` DATETIME COMMENT 'ポイント失効日',
	`registered_shop_id` INTEGER default 0 NOT NULL COMMENT 'ポイント取得・使用店舗ID',
	`visit_date` DATETIME COMMENT '来店ポイント加算日時',
	`entry_type` TINYINT default 0 NOT NULL COMMENT 'データ登録元区分 1:タッチパネル(ユーザ) 2:タッチパネル(スタッフ) 3:店舗管理画面 4:グループ管理画面 5:QRポイント 6:API 7:日次バッチ 8:エア会員引継 9:POS連携 10:カードブックチェックイン 11:カードブックQRチェックイン',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	KEY `index_shop_member_card_id`(`shop_member_card_id`),
	KEY `index_member_id`(`member_id`),
	KEY `index_type`(`type`),
	KEY `index_status`(`status`),
	KEY `index_point`(`point`),
	KEY `index_registered_shop_id`(`registered_shop_id`),
	KEY `ix_shop_member_point_record1`(`updated_at`)
) COMMENT='来店ポイント記録';

#-----------------------------------------------------------------------------
#-- l_shop_mem_point_rec
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `l_shop_mem_point_rec`;


CREATE TABLE `l_shop_mem_point_rec`
(
	`id` INTEGER  NOT NULL COMMENT '来店ポイント記録ID',
	`shop_member_card_id` INTEGER  NOT NULL COMMENT '来店ポイント会員証ID',
	`member_id` INTEGER  NOT NULL COMMENT 'EPARK会員ID',
	`type` TINYINT default 0 NOT NULL COMMENT 'ポイント種別 0:加算ポイント 1: 交換ポイント',
	`status` TINYINT default 0 NOT NULL COMMENT 'ポイント状態 0: 有効 1無効',
	`point` INTEGER default 0 NOT NULL COMMENT 'ポイント',
	`use_point` INTEGER default 0 NOT NULL COMMENT '利用ポイント',
	`revocation_date` DATETIME COMMENT 'ポイント失効日',
	`registered_shop_id` INTEGER default 0 NOT NULL COMMENT 'ポイント取得使用店舗ID',
	`visit_date` DATETIME COMMENT '来店ポイント加算日時',
	`entry_type` TINYINT default 0 NOT NULL COMMENT 'データ登録元区分 1:タッチパネル(ユーザ) 2:タッチパネル(スタッフ) 3:店舗管理画面 4:グループ管理画面 5:QRポイント 6:API 7:日次バッチ 8:エア会員引継',
	`created_at` DATETIME  NOT NULL COMMENT '作成年月日',
	`updated_at` DATETIME  NOT NULL COMMENT '更新年月日',
	PRIMARY KEY (`id`,`created_at`),
	KEY `ix_l_shop_mem_point_rec1`(`updated_at`),
	INDEX `l_shop_mem_point_rec_FI_1` (`shop_member_card_id`)
) COMMENT='L_来店ポイント記録ログ';

#-----------------------------------------------------------------------------
#-- shop_member_point_record_modification_log
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `shop_member_point_record_modification_log`;


CREATE TABLE `shop_member_point_record_modification_log`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT COMMENT '自動生成プライマリキー',
	`shop_member_point_record_id` INTEGER  NOT NULL,
	`point` INTEGER default 0 NOT NULL COMMENT '修正ポイント（正負値）',
	`member_id` INTEGER  NOT NULL COMMENT '会員ID',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	KEY `index_shop_member_point_record_id`(`shop_member_point_record_id`),
	KEY `index_member_id`(`member_id`)
) COMMENT='来店ポイント記録修正履歴＆通知メール配信管理';

#-----------------------------------------------------------------------------
#-- member_point_payment
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `member_point_payment`;


CREATE TABLE `member_point_payment`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT COMMENT '自動生成プライマリキー',
	`shop_member_card_id` INTEGER  NOT NULL COMMENT '来店ポイント会員証ID',
	`member_id` INTEGER  NOT NULL COMMENT '会員ID',
	`point` INTEGER default 0 NOT NULL COMMENT '支払ポイント',
	`coupon_id` INTEGER default 0 NOT NULL COMMENT '購入クーポン番号',
	`change_date` DATETIME  NOT NULL COMMENT 'クーポン購入日',
	`change_shop_id` INTEGER default 0 NOT NULL COMMENT 'クーポン購入店舗ID',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	KEY `index_shop_member_card_id`(`shop_member_card_id`),
	KEY `index_member_id`(`member_id`),
	KEY `index_coupon_id`(`coupon_id`)
) COMMENT='ポイント支払管理';

#-----------------------------------------------------------------------------
#-- shop_member_rank_history
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `shop_member_rank_history`;


CREATE TABLE `shop_member_rank_history`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT COMMENT '自動生成プライマリキー',
	`shop_member_card_id` INTEGER  NOT NULL COMMENT '来店ポイント会員証ID',
	`member_id` INTEGER  NOT NULL COMMENT '会員ID',
	`rank` TINYINT  NOT NULL COMMENT '新会員ランク 1:ダイヤモンド 2:プラチナ 3:ゴールド 4:シルバー 5:ブロンズ',
	`rank_old` TINYINT COMMENT '旧会員ランク 1:ダイヤモンド 2:プラチナ 3:ゴールド 4:シルバー 5:ブロンズ',
	`type` TINYINT default 0 NOT NULL COMMENT 'データ種別 0:ランクアップ 1:ランクダウン',
	`rank_change_reason` TINYINT default 0 NOT NULL COMMENT 'ランク変更理由区分 0:正常 1:店舗管理画面よりランク停止削除 2:手動変更 3:エア会員引継',
	`rank_change_date` DATETIME  NOT NULL COMMENT 'ランク変更日時',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	KEY `index_shop_member_card_id`(`shop_member_card_id`),
	KEY `index_member_id`(`member_id`)
) COMMENT='会員ランク変動履歴';

#-----------------------------------------------------------------------------
#-- shop_point_separate_setting
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `shop_point_separate_setting`;


CREATE TABLE `shop_point_separate_setting`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT COMMENT '設定ID',
	`shop_point_mst_id` INTEGER  NOT NULL COMMENT '来店ポイントマスタID',
	`name` VARCHAR(20) default '' NOT NULL COMMENT '個別設定名',
	`status` TINYINT default 2 NOT NULL COMMENT '有効ステータス 1:有効 2:無効',
	`display_order` TINYINT default 0 NOT NULL COMMENT '表示順',
	`setting_flag_point` TINYINT default 2 NOT NULL COMMENT '個別設定有無フラグ（ポイント設定） 1:あり 2:なし',
	`setting_flag_rank` TINYINT default 2 NOT NULL COMMENT '個別設定有無フラグ（会員ランク設定） 1:あり 2:なし',
	`setting_flag_other` TINYINT default 2 NOT NULL COMMENT '個別設定有無フラグ（その他設定） 1:あり 2:なし',
	`mobile_lp_text` TEXT COMMENT 'モバイル会員証ＬＰページの表示(1000文字以内)',
	`take_coupon` TINYINT default 0 NOT NULL COMMENT 'クーポンの取得 0:発券機で印刷する 1:クーポン番号を携帯に送る',
	`touch_point_button` TINYINT default 1 NOT NULL COMMENT 'タッチパネル(店頭受付用）：ポイント発行ボタン表示：0:表示 1:非表示 ',
	`touch_change_rank` TINYINT default 1 NOT NULL COMMENT 'タッチパネル(スタッフ用）：来店ポイント ランク手動変更ボタン表示設定（0:表示 1:非表示） ',
	`touch_coupon_button` TINYINT default 0 NOT NULL COMMENT 'タッチパネル(店頭/スタッフ）：「現在使えるクーポンを表示」ボタン表示：0:表示 1:非表示 ',
	`touch_coupon_button_payment` TINYINT default 1 NOT NULL COMMENT 'タッチパネル(スタッフ会計時）：「現在使えるクーポンを表示」ボタン表示：0:表示 1:非表示 ',
	`touch_point_manual_ui` TINYINT default 1 NOT NULL COMMENT 'タッチパネル(店頭受付用）：ポイント付与数入力画面　表示：0:使用可 1:使用不可 ',
	`touch_point_min_value` INTEGER COMMENT 'タッチパネル(店頭受付用）：ポイント付与最小 1-99999 ',
	`touch_point_max_value` INTEGER COMMENT 'タッチパネル(店頭受付用）：ポイント付与最大 1-99999 ',
	`touch_next_add_point_type` TINYINT default 0 NOT NULL COMMENT '次回のポイント付与ができるまでの間隔種別 0:1日 1:時間',
	`touch_next_add_point_hours` INTEGER default 0 NOT NULL COMMENT '次回のポイント付与ができるまでの間隔（「1:時間」の時の時間数）',
	`touch_coupon_multi_button` TINYINT default 1 NOT NULL COMMENT 'タッチパネル（店頭受付用）： クーポン複数発券ボタン 表示 0：表示 1：非表示 ',
	`touch_point_only` TINYINT default 1 NOT NULL COMMENT 'タッチパネル ： 来店ポイントのみ付与： 0:使用可 1:使用不可',
	`sp_show_schedule` TINYINT default 1 NOT NULL COMMENT '店舗イベント機能表示区分： 0:表示 1:非表示',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	KEY `index_status`(`status`),
	KEY `index_setting_flag_point`(`setting_flag_point`),
	KEY `index_setting_flag_rank`(`setting_flag_rank`),
	KEY `index_setting_flag_other`(`setting_flag_other`),
	INDEX `shop_point_separate_setting_FI_1` (`shop_point_mst_id`)
) COMMENT='来店ポイント個別設定';

#-----------------------------------------------------------------------------
#-- shop_point_separate_rank_setting
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `shop_point_separate_rank_setting`;


CREATE TABLE `shop_point_separate_rank_setting`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT COMMENT '自動生成プライマリキー',
	`shop_point_mst_id` INTEGER  NOT NULL COMMENT '来店ポイントマスタID',
	`shop_point_rank_id` INTEGER  NOT NULL COMMENT '来店ポイントランクID',
	`setting_id` INTEGER default 0 NOT NULL COMMENT '来店ポイント個別設定ID',
	`default_point` INTEGER default 0 NOT NULL COMMENT 'デフォルトポイント付与数',
	`payment_point_status` TINYINT default 1 NOT NULL COMMENT '会計額でポイント付与 0:する 1:しない',
	`payment_point_type` TINYINT default 0 NOT NULL COMMENT '会計額でポイント付与：計算式設定 0:A:○円ごとに○ポイント 1:B:割合（％）',
	`payment_point_type_a_base_amount` INTEGER default 0 NOT NULL COMMENT '会計額でポイント付与：計算式A 基準金額',
	`payment_point_type_a_point` INTEGER default 0 NOT NULL COMMENT '会計額でポイント付与：計算式A 付与ポイント',
	`payment_point_type_b_rate` INTEGER default 0 NOT NULL COMMENT '会計額でポイント付与：計算式B ％数値',
	`payment_point_round_type` TINYINT default 0 NOT NULL COMMENT '会計額でポイント付与：計算式 小数点設定 0:切り捨て 1:四捨五入 2:切り上げ',
	`payment_point_cut_off_amount` INTEGER default 0 NOT NULL COMMENT '会計額でポイント付与：最低会計額',
	`calc_status` TINYINT default 0 NOT NULL COMMENT 'ポイント付与スケジュール ポイント付与方法 0：加算 1：倍率',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	UNIQUE KEY `unique_rank_setting` (`shop_point_rank_id`, `setting_id`),
	INDEX `shop_point_separate_rank_setting_FI_1` (`shop_point_mst_id`),
	INDEX `shop_point_separate_rank_setting_FI_3` (`setting_id`)
) COMMENT='ポイントランク個別設定';

#-----------------------------------------------------------------------------
#-- shop_point_separate_setting_shop
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `shop_point_separate_setting_shop`;


CREATE TABLE `shop_point_separate_setting_shop`
(
	`setting_id` INTEGER  NOT NULL COMMENT '来店ポイント個別設定ID',
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`setting_id`,`shop_id`),
	INDEX `shop_point_separate_setting_shop_FI_2` (`shop_id`)
) COMMENT='来店ポイント個別設定紐付店舗';

#-----------------------------------------------------------------------------
#-- member_visit_date
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `member_visit_date`;


CREATE TABLE `member_visit_date`
(
	`id` INTEGER(8)  NOT NULL AUTO_INCREMENT COMMENT '自動生成プライマリキー',
	`shop_member_card_id` INTEGER  NOT NULL COMMENT '来店ポイント会員証ID',
	`member_id` INTEGER  NOT NULL COMMENT '会員ID',
	`visited_shop_id` INTEGER  NOT NULL COMMENT '来店店舗ID',
	`visit_date` DATETIME  NOT NULL COMMENT '来店日',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	KEY `index_shop_member_card_id`(`shop_member_card_id`),
	KEY `index_member_id`(`member_id`),
	KEY `index_visited_shop_id`(`visited_shop_id`)
) COMMENT='来店ポイント履歴用 会員来店日';

#-----------------------------------------------------------------------------
#-- member_visit_weekly
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `member_visit_weekly`;


CREATE TABLE `member_visit_weekly`
(
	`id` INTEGER(8)  NOT NULL AUTO_INCREMENT COMMENT '自動生成プライマリキー',
	`shop_point_mst_id` INTEGER  NOT NULL COMMENT '来店ポイントマスタID',
	`shop_member_card_id` INTEGER  NOT NULL COMMENT '来店ポイント会員証ID',
	`member_id` INTEGER  NOT NULL COMMENT '会員ID',
	`rank` TINYINT COMMENT '会員ランク',
	`member_order` TINYINT COMMENT '順位',
	`visit_count` INTEGER COMMENT '来店回数累計',
	`visit_date_from` DATETIME COMMENT '集計期間(始まり)',
	`visit_date_to` DATETIME COMMENT '集計期間(終わり)',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	KEY `index_shop_point_mst_id`(`shop_point_mst_id`),
	KEY `index_shop_member_card_id`(`shop_member_card_id`),
	KEY `index_member_id`(`member_id`)
) COMMENT='来店回数 集計データ(週ごと)';

#-----------------------------------------------------------------------------
#-- member_visit_weekly_tmp
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `member_visit_weekly_tmp`;


CREATE TABLE `member_visit_weekly_tmp`
(
	`id` INTEGER(8)  NOT NULL AUTO_INCREMENT COMMENT '自動生成プライマリキー',
	`shop_point_mst_id` INTEGER  NOT NULL COMMENT '来店ポイントマスタID',
	`shop_member_card_id` INTEGER  NOT NULL COMMENT '来店ポイント会員証ID',
	`member_id` INTEGER  NOT NULL COMMENT '会員ID',
	`rank` TINYINT COMMENT '会員ランク',
	`member_order` TINYINT COMMENT '順位',
	`visit_count` INTEGER COMMENT '来店回数累計',
	`visit_date_from` DATETIME COMMENT '集計期間(始まり)',
	`visit_date_to` DATETIME COMMENT '集計期間(終わり)',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	KEY `index_shop_point_mst_id`(`shop_point_mst_id`),
	KEY `index_shop_member_card_id`(`shop_member_card_id`),
	KEY `index_member_id`(`member_id`)
) COMMENT='来店回数 集計データ(週ごと) 計算用テーブル';

#-----------------------------------------------------------------------------
#-- member_visit_monthly
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `member_visit_monthly`;


CREATE TABLE `member_visit_monthly`
(
	`id` INTEGER(8)  NOT NULL AUTO_INCREMENT COMMENT '自動生成プライマリキー',
	`shop_point_mst_id` INTEGER  NOT NULL COMMENT '来店ポイントマスタID',
	`shop_member_card_id` INTEGER  NOT NULL COMMENT '来店ポイント会員証ID',
	`member_id` INTEGER  NOT NULL COMMENT '会員ID',
	`rank` TINYINT COMMENT '会員ランク',
	`member_order` TINYINT COMMENT '順位',
	`visit_count` INTEGER COMMENT '来店回数累計',
	`visit_date_from` DATETIME COMMENT '集計期間(始まり)',
	`visit_date_to` DATETIME COMMENT '集計期間(終わり)',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	KEY `index_shop_point_mst_id`(`shop_point_mst_id`),
	KEY `index_shop_member_card_id`(`shop_member_card_id`),
	KEY `index_member_id`(`member_id`)
) COMMENT='来店回数 集計データ(月ごと)';

#-----------------------------------------------------------------------------
#-- member_visit_monthly_tmp
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `member_visit_monthly_tmp`;


CREATE TABLE `member_visit_monthly_tmp`
(
	`id` INTEGER(8)  NOT NULL AUTO_INCREMENT COMMENT '自動生成プライマリキー',
	`shop_point_mst_id` INTEGER  NOT NULL COMMENT '来店ポイントマスタID',
	`shop_member_card_id` INTEGER  NOT NULL COMMENT '来店ポイント会員証ID',
	`member_id` INTEGER  NOT NULL COMMENT '会員ID',
	`rank` TINYINT COMMENT '会員ランク',
	`member_order` TINYINT COMMENT '順位',
	`visit_count` INTEGER COMMENT '来店回数累計',
	`visit_date_from` DATETIME COMMENT '集計期間(始まり)',
	`visit_date_to` DATETIME COMMENT '集計期間(終わり)',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	KEY `index_shop_point_mst_id`(`shop_point_mst_id`),
	KEY `index_shop_member_card_id`(`shop_member_card_id`),
	KEY `index_member_id`(`member_id`)
) COMMENT='来店回数 集計(月ごと) 計算用テーブル';

#-----------------------------------------------------------------------------
#-- coupon_mail_auth
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `coupon_mail_auth`;


CREATE TABLE `coupon_mail_auth`
(
	`id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT '自動生成プライマリキー',
	`auth_key` VARCHAR(20)  NOT NULL COMMENT '認証用ユニークキー',
	`coupon_piece_id` INTEGER(11) COMMENT 'クーポンピースID',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	UNIQUE KEY `unique_auth_key` (`auth_key`)
) COMMENT='クーポンメールを認証するテーブル';

#-----------------------------------------------------------------------------
#-- search_pr_frame_group
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `search_pr_frame_group`;


CREATE TABLE `search_pr_frame_group`
(
	`id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT 'ID',
	`name` VARCHAR(100)  NOT NULL COMMENT 'グループ名',
	`status` TINYINT default 0 NOT NULL COMMENT 'ステータス ※有効：0、無効：1',
	`deleted` TINYINT default 0 NOT NULL COMMENT '削除フラグ ※未削除：0、削除済み：1',
	`created_at` DATETIME COMMENT '作成日時',
	`updated_at` DATETIME COMMENT '編集日時',
	PRIMARY KEY (`id`)
) COMMENT='広告PR枠グループ';

#-----------------------------------------------------------------------------
#-- search_pr_frame_detail
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `search_pr_frame_detail`;


CREATE TABLE `search_pr_frame_detail`
(
	`id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT 'ID',
	`search_pr_group_id` INTEGER  NOT NULL COMMENT 'グループID',
	`status` TINYINT default 0 NOT NULL COMMENT 'ステータス ※有効：0、無効：1',
	`search_keyword` VARCHAR(200) COMMENT '検索キーワード',
	`pref_id` INTEGER COMMENT '都道府県ID',
	`city_id` INTEGER COMMENT '市区町村',
	`pref_name` VARCHAR(10) COMMENT '都道府県名',
	`city_name` VARCHAR(40) COMMENT '市区町村名',
	`pref_city_text` VARCHAR(100) COMMENT '都道府県市区町村テキスト（ほぼ使わない）',
	`xl_category_id` INTEGER  NOT NULL COMMENT '大々カテゴリ',
	`big_category_id` INTEGER COMMENT '大カテゴリ',
	`mid_category_id` INTEGER COMMENT '中カテゴリ',
	`display_shop` INTEGER  NOT NULL COMMENT '表示店舗ID',
	`start_datetime` DATETIME COMMENT '設定開始日',
	`end_datetime` DATETIME COMMENT '設定終了日',
	`deleted` TINYINT default 0 NOT NULL COMMENT '削除フラグ ※未削除：0、削除済み：1',
	`created_at` DATETIME COMMENT '作成日時',
	`updated_at` DATETIME COMMENT '編集日時',
	PRIMARY KEY (`id`),
	KEY `index_search_keyword`(`search_keyword`)
) COMMENT='広告PR枠詳細';

#-----------------------------------------------------------------------------
#-- search_pr_frame_detail_tmp
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `search_pr_frame_detail_tmp`;


CREATE TABLE `search_pr_frame_detail_tmp`
(
	`sequential_id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT '自動連番ID',
	`id` INTEGER UNSIGNED COMMENT 'ID (search_pr_frame_detail.id)',
	`search_pr_group_id` INTEGER  NOT NULL COMMENT 'グループID',
	`status` TINYINT  NOT NULL COMMENT 'ステータス ※有効：0、無効：1',
	`search_keyword` VARCHAR(200) COMMENT '検索キーワード',
	`pref_id` INTEGER COMMENT '都道府県ID',
	`city_id` INTEGER COMMENT '市区町村',
	`pref_name` VARCHAR(10) COMMENT '都道府県名',
	`city_name` VARCHAR(40) COMMENT '市区町村名',
	`pref_city_text` VARCHAR(100) COMMENT '都道府県市区町村テキスト',
	`xl_category_id` INTEGER  NOT NULL COMMENT '大々カテゴリ',
	`big_category_id` INTEGER COMMENT '大カテゴリ',
	`mid_category_id` INTEGER COMMENT '中カテゴリ',
	`display_shop` VARCHAR(200)  NOT NULL COMMENT '表示店舗',
	`start_datetime` DATETIME COMMENT '設定開始日',
	`end_datetime` DATETIME COMMENT '設定終了日',
	`expires_at` DATETIME COMMENT '一時データ有効期限（通常30分）',
	`manipulation_code` TINYINT default 1 NOT NULL COMMENT '処理コード 1:挿入 2:更新 3:削除',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`sequential_id`)
) COMMENT='広告PR枠詳細アップロード一時データ';

#-----------------------------------------------------------------------------
#-- search_pr_frame_impression
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `search_pr_frame_impression`;


CREATE TABLE `search_pr_frame_impression`
(
	`id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT '自動生成プライマリキー',
	`frame_id` INTEGER  NOT NULL COMMENT '広告枠ID',
	`type` INTEGER  NOT NULL COMMENT 'インプレッション・クリック区分 ※impression:1  click2',
	`target_date` DATE  NOT NULL COMMENT '対象日時',
	`created_at` DATETIME COMMENT 'レコード作成日時',
	PRIMARY KEY (`id`),
	KEY `index_frame_id_target_date_type`(`frame_id`, `target_date`, `type`)
) COMMENT='検索結果連動広告枠別インプレッションテーブル';

#-----------------------------------------------------------------------------
#-- search_pr_frame_impression_log_history
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `search_pr_frame_impression_log_history`;


CREATE TABLE `search_pr_frame_impression_log_history`
(
	`frame_id` INTEGER  NOT NULL COMMENT '広告枠ID',
	`target_date` DATE  NOT NULL COMMENT '対象日時',
	`impression_count` INTEGER default 0 NOT NULL COMMENT 'インプレッション数',
	`click_count` INTEGER default 0 NOT NULL COMMENT 'クリック数',
	`created_at` DATETIME COMMENT 'レコード作成日時',
	`updated_at` DATETIME COMMENT 'レコード更新日時',
	PRIMARY KEY (`frame_id`,`target_date`)
) COMMENT='検索結果連動広告枠別インプレッション数及びクリック数集計履歴テーブル';

#-----------------------------------------------------------------------------
#-- shop_shop_category_rel
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `shop_shop_category_rel`;


CREATE TABLE `shop_shop_category_rel`
(
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID',
	`shop_category_id` INTEGER  NOT NULL COMMENT '店舗カテゴリID',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`shop_id`,`shop_category_id`)
) COMMENT='店舗・店舗カテゴリ関連';

#-----------------------------------------------------------------------------
#-- city
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `city`;


CREATE TABLE `city`
(
	`id` INTEGER  NOT NULL COMMENT '市区町村ID',
	`pref_id` INTEGER  NOT NULL COMMENT '都道府県ID epark_common.prefecture.id',
	`pref_name` VARCHAR(10)  NOT NULL COMMENT '都道府県名',
	`name` VARCHAR(40)  NOT NULL COMMENT '市区町村名',
	`display_order` INTEGER  NOT NULL COMMENT '表示順',
	PRIMARY KEY (`id`)
) COMMENT='市区町村マスタ';

#-----------------------------------------------------------------------------
#-- shop_category_convert
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `shop_category_convert`;


CREATE TABLE `shop_category_convert`
(
	`old_shop_category_id` INTEGER  NOT NULL COMMENT '現行の shop_category.id の値',
	`shop_category_id` INTEGER  NOT NULL COMMENT '変換後のデータに設定する id',
	`xl_category_id` INTEGER  NOT NULL COMMENT '変換後のデータに設定する xl_category_id',
	`big_category_id` INTEGER  NOT NULL COMMENT '変換後のデータに設定する big_category_id',
	`mid_category_id` INTEGER  NOT NULL COMMENT '変換後のデータに設定する mid_category_id',
	`name` VARCHAR(40)  NOT NULL COMMENT '変換後のデータに設定する name',
	`display_order` INTEGER  NOT NULL COMMENT '変換後のデータに設定する display_order',
	PRIMARY KEY (`old_shop_category_id`)
) COMMENT='店舗カテゴリ変換テーブル';

#-----------------------------------------------------------------------------
#-- member_app_push
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `member_app_push`;


CREATE TABLE `member_app_push`
(
	`id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT '自動生成プライマリキー',
	`member_id` INTEGER COMMENT '会員ID',
	`device_id` VARCHAR(255)  NOT NULL COMMENT '端末ID',
	`os_cd` TINYINT  NOT NULL COMMENT '端末種別',
	`token` VARCHAR(255)  NOT NULL COMMENT 'デバイストークン',
	`push_on` TINYINT default 1 NOT NULL COMMENT 'プッシュ通知',
	`is_deleted` TINYINT default 0 NOT NULL COMMENT '削除フラグ 0:有効データ 1：削除済 ',
	`created_at` DATETIME COMMENT '作成日時',
	`updated_at` DATETIME COMMENT '更新日時',
	PRIMARY KEY (`id`)
) COMMENT='会員アプリ通知設定';

#-----------------------------------------------------------------------------
#-- member_shop_search_condition
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `member_shop_search_condition`;


CREATE TABLE `member_shop_search_condition`
(
	`id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT '自動生成プライマリキー',
	`member_id` INTEGER  NOT NULL COMMENT '会員ID',
	`xl_category_id` INTEGER  NOT NULL COMMENT '大々カテゴリID 1: グルメ 2: 医療 3: 暮らし',
	`gps_range` INTEGER COMMENT 'GPS範囲 1: 1km 5: 5km 10: 10km',
	`address` VARCHAR(100) COMMENT '地名',
	`shop_name` VARCHAR(100) COMMENT '店名',
	`budget_time` TINYINT COMMENT '予算時間帯 1: 昼 2: 夜',
	`budget_min` INTEGER COMMENT '予算下限',
	`budget_max` INTEGER COMMENT '予算上限',
	`enabled_only` TINYINT default 0 NOT NULL COMMENT '順番待ちできるお店のみフラグ 0: チェック無し 1: チェック有り',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	UNIQUE KEY `member_id_xl_category_id_uniq` (`member_id`, `xl_category_id`)
) COMMENT='会員前回検索条件保存テーブル';

#-----------------------------------------------------------------------------
#-- member_shop_search_condition_big_category
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `member_shop_search_condition_big_category`;


CREATE TABLE `member_shop_search_condition_big_category`
(
	`member_shop_search_condition_id` BIGINT  NOT NULL COMMENT '会員前回検索条件保存テーブルID',
	`big_category_id` INTEGER  NOT NULL COMMENT '大カテゴリID',
	`created_at` DATETIME,
	PRIMARY KEY (`member_shop_search_condition_id`,`big_category_id`)
) COMMENT='会員前回検索条件大カテゴリ保存テーブル';

#-----------------------------------------------------------------------------
#-- member_shop_search_condition_mid_category
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `member_shop_search_condition_mid_category`;


CREATE TABLE `member_shop_search_condition_mid_category`
(
	`member_shop_search_condition_id` BIGINT  NOT NULL COMMENT '会員前回検索条件保存テーブルID',
	`mid_category_id` INTEGER  NOT NULL COMMENT '中カテゴリID',
	`created_at` DATETIME,
	PRIMARY KEY (`member_shop_search_condition_id`,`mid_category_id`)
) COMMENT='会員前回検索条件中カテゴリ保存テーブル';

#-----------------------------------------------------------------------------
#-- member_shop_search_condition_persistence
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `member_shop_search_condition_persistence`;


CREATE TABLE `member_shop_search_condition_persistence`
(
	`member_shop_search_condition_id` BIGINT  NOT NULL COMMENT '会員前回検索条件保存テーブルID',
	`persistence` INTEGER  NOT NULL COMMENT 'こだわり条件',
	`created_at` DATETIME,
	PRIMARY KEY (`member_shop_search_condition_id`,`persistence`)
) COMMENT='会員前回検索条件こだわり条件保存テーブル';

#-----------------------------------------------------------------------------
#-- widget_impression
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `widget_impression`;


CREATE TABLE `widget_impression`
(
	`id` BIGINT  NOT NULL COMMENT '予約ID',
	`shop_id` BIGINT COMMENT '店舗ID',
	`widget_imp_num` INTEGER default 0 COMMENT 'ウィジェット表示回数',
	`widget_click_num` INTEGER default 0 COMMENT 'ウィジェットクリック回数',
	`top_referer` VARCHAR(255) COMMENT '施設TOPリファラ',
	`shop_member_regist_num` INTEGER default 0 COMMENT '会員登録数',
	`receive_num` INTEGER default 0 COMMENT '予約数',
	`created_at` DATETIME COMMENT 'レコード作成日時',
	`updated_at` DATETIME COMMENT 'レコード更新日時',
	PRIMARY KEY (`id`)
) COMMENT='ウィジェットインプレッション';

#-----------------------------------------------------------------------------
#-- shop_reserve_config_all
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `shop_reserve_config_all`;


CREATE TABLE `shop_reserve_config_all`
(
	`shop_id` BIGINT  NOT NULL COMMENT '店舗ＩＤ',
	`disp_termi_type` TINYINT  NOT NULL COMMENT '項目表示対象端末タイプ 0:iPad 1:タッチパネル',
	`setting_layout_kbn` INTEGER  NOT NULL COMMENT '1:順番待ち表示内容選択 2:接客中表示内容選択',
	`reserve_config_id` INTEGER  NOT NULL COMMENT '順番待ち：受付停止中メッセージの手動設定内容 接客中:一覧表示項目',
	`disp_order` TINYINT default 0 COMMENT '表示順（タッチパネル向け）',
	`created_at` DATETIME  NOT NULL COMMENT 'レコード作成日時',
	`updated_at` DATETIME  NOT NULL COMMENT 'レコード更新日時',
	PRIMARY KEY (`shop_id`,`disp_termi_type`,`setting_layout_kbn`,`reserve_config_id`),
	KEY `index_shop_id`(`shop_id`),
	KEY `index_setting_layout_kbn`(`setting_layout_kbn`),
	KEY `index_reserve_config_id`(`reserve_config_id`)
);

#-----------------------------------------------------------------------------
#-- portal_lpcms_html
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `portal_lpcms_html`;


CREATE TABLE `portal_lpcms_html`
(
	`id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT,
	`device_type` TINYINT UNSIGNED default 1 NOT NULL COMMENT 'デバイスタイプ (1: PC, 2: SP, 3: MB)',
	`title` VARCHAR(255)  NOT NULL COMMENT 'タイトル',
	`url` TEXT  NOT NULL COMMENT 'URL',
	`body` TEXT COMMENT '本文 (HTML形式)',
	`memo` VARCHAR(255) COMMENT 'メモ',
	`show_flg` TINYINT UNSIGNED default 0 NOT NULL COMMENT '公開フラグ (0: 非公開, 1: 公開)',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`)
) COMMENT='HTMLテーブル';

#-----------------------------------------------------------------------------
#-- portal_lpcms_files
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `portal_lpcms_files`;


CREATE TABLE `portal_lpcms_files`
(
	`id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT,
	`html_id` INTEGER UNSIGNED COMMENT 'LP記事ID (HTML登録画面でアップロードした場合に設定)',
	`img_dir_id` INTEGER UNSIGNED COMMENT '画像ディレクトリID (HTML登録画面でアップロードした場合に設定)',
	`device_type` TINYINT UNSIGNED default 1 NOT NULL COMMENT 'デバイスタイプ (1: PC, 2: SP, 3: MB)',
	`file_type` TINYINT UNSIGNED default 1 NOT NULL COMMENT 'ファイル種別 (1: css, 2: js, 3: img)',
	`file_path` TEXT  NOT NULL COMMENT 'ファイルパス',
	`memo` VARCHAR(255) COMMENT 'メモ',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	INDEX `portal_lpcms_files_FI_1` (`html_id`),
	INDEX `portal_lpcms_files_FI_2` (`img_dir_id`)
) COMMENT='css／js／imgテーブル';

#-----------------------------------------------------------------------------
#-- portal_lpcms_img_dir
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `portal_lpcms_img_dir`;


CREATE TABLE `portal_lpcms_img_dir`
(
	`id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT,
	`html_id` INTEGER UNSIGNED COMMENT 'LP記事ID (HTML登録画面でアップロードした場合に設定)',
	`device_type` TINYINT UNSIGNED default 1 NOT NULL COMMENT 'デバイスタイプ (1: PC, 2: SP, 3: MB)',
	`dir_name` TEXT  NOT NULL COMMENT 'ディレクトリ名',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	INDEX `portal_lpcms_img_dir_FI_1` (`html_id`)
) COMMENT='画像ディレクトリテーブル';

#-----------------------------------------------------------------------------
#-- shop_mail_target_member_id
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `shop_mail_target_member_id`;


CREATE TABLE `shop_mail_target_member_id`
(
	`shop_mail_id` BIGINT  NOT NULL,
	`member_id` INTEGER  NOT NULL,
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`shop_mail_id`,`member_id`)
) COMMENT='店舗メール会員ID指定用ID保存テーブル';

#-----------------------------------------------------------------------------
#-- group_mail_target_member_id
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `group_mail_target_member_id`;


CREATE TABLE `group_mail_target_member_id`
(
	`group_mail_id` BIGINT  NOT NULL,
	`member_id` INTEGER  NOT NULL,
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`group_mail_id`,`member_id`)
) COMMENT='グループメール会員ID指定用ID保存テーブル';

#-----------------------------------------------------------------------------
#-- coupon_type
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `coupon_type`;


CREATE TABLE `coupon_type`
(
	`id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT 'クーポン種別ID',
	`name` VARCHAR(50)  NOT NULL COMMENT 'クーポン種別名',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`)
) COMMENT='クーポン種別テーブル';

#-----------------------------------------------------------------------------
#-- shop_point_coupon_target_segment
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `shop_point_coupon_target_segment`;


CREATE TABLE `shop_point_coupon_target_segment`
(
	`id` BIGINT UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT '自動生成プライマリキー',
	`sex` TINYINT UNSIGNED  NOT NULL COMMENT '性別',
	`age` TINYINT UNSIGNED  NOT NULL COMMENT '年齢',
	`rank` TINYINT UNSIGNED  NOT NULL COMMENT '会員ランク',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`)
) COMMENT='来店ポイントクーポン対象者セグメント';

#-----------------------------------------------------------------------------
#-- shop_point_coupon_target_daily_log
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `shop_point_coupon_target_daily_log`;


CREATE TABLE `shop_point_coupon_target_daily_log`
(
	`shop_point_mst_id` INTEGER UNSIGNED  NOT NULL COMMENT '来店ポイントマスタID',
	`shop_point_exchange_rules_id` INTEGER UNSIGNED  NOT NULL COMMENT 'クーポン引換ルールID',
	`shop_point_coupon_target_segment_id` BIGINT UNSIGNED  NOT NULL COMMENT '来店ポイントクーポン対象者セグメントID',
	`shop_id` INTEGER UNSIGNED  NOT NULL COMMENT '店舗ID',
	`target_num` INTEGER UNSIGNED  NOT NULL COMMENT '対象会員数',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`shop_point_mst_id`,`shop_point_exchange_rules_id`,`shop_point_coupon_target_segment_id`,`shop_id`)
) COMMENT='来店ポイントクーポン対象者数日別データ';

#-----------------------------------------------------------------------------
#-- shop_display_mst
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `shop_display_mst`;


CREATE TABLE `shop_display_mst`
(
	`shop_id` BIGINT  NOT NULL COMMENT '店舗ＩＤ',
	`type` TINYINT default 0 NOT NULL COMMENT '\'共通 店舗種別 0:部門管理共通 １：メガネショップ用\'',
	`title` VARCHAR(50) COMMENT '部門なし タイトル',
	`display_type` TINYINT default 0 COMMENT '\'部門なし 表示機タイプ 0:N1、１：N2、2:N3、3：NM\'',
	`unit_type` TINYINT default 0 COMMENT '\'表記タイプ 0:人数表記 1:組数表記\'',
	`button_name` VARCHAR(20) COMMENT '部門なし ボタン名表示',
	`type_1_title` VARCHAR(20) COMMENT '部門なし 表示機タイプ1タイトル',
	`type_1_right_msg` VARCHAR(100) COMMENT '部門なし 表示機タイプ1完了表示版右MSG',
	`type_1_footer_msg` VARCHAR(100) COMMENT '部門なし 表示機タイプ1完了表示版下MSG',
	`type_2_title` VARCHAR(20) COMMENT '部門なし 表示機タイプ2タイトル',
	`type_2_right_msg` VARCHAR(100) COMMENT '部門なし 表示機タイプ2完了表示版右MSG',
	`type_2_footer_msg` VARCHAR(100) COMMENT '部門なし 表示機タイプ2完了表示版下MSG',
	`b1_type_status` TINYINT default 0 COMMENT '\'利用する表示機タイプ B1 0:利用しない 1:利用する\'',
	`b2_type_status` TINYINT default 0 COMMENT '\'利用する表示機タイプ B2 0:利用しない 1:利用する\'',
	`b3_type_status` TINYINT default 0 COMMENT '\'利用する表示機タイプ B3 0:利用しない 1:利用する\'',
	`b1_telop_status` TINYINT default 1 COMMENT '\'部門あり B1 テロップ状態 0:なし、1:あり\'',
	`b1_telop` VARCHAR(200) COMMENT '部門あり B1 テロップ内容',
	`b2_telop_status` TINYINT default 1 COMMENT '\'部門あり B2 テロップ状態 0:なし、1:あり\'',
	`b2_telop` VARCHAR(200) COMMENT '部門あり B2テロップ内容',
	`b3_telop_status` TINYINT default 1 COMMENT '\'部門あり B3 テロップ状態 0:なし、1:あり\'',
	`b3_telop` VARCHAR(200) COMMENT '部門あり B3 テロップ内容',
	`b1_item_guide_status` TINYINT default 0 COMMENT '\'表示する項目状態 案内中 0:非表示 1:表示\'',
	`b1_item_receive_no_status` TINYINT default 0 COMMENT '\'表示する項目状態 受付番号 0:非表示 1:表示\'',
	`b1_item_receive_type` TINYINT default 0 COMMENT '\'表示する項目状態 受付番号タイプ 0:1列 1:3列\'',
	`b1_item_unit_status` TINYINT default 0 COMMENT '\'表示する項目状態 待ち組数 0:非表示 1:表示\'',
	`b1_item_wait_time_status` TINYINT default 0 COMMENT '\'表示する項目状態 待ち時間 0:非表示 1:表示\'',
	`b2_item_receive_limit` TINYINT default 0 COMMENT '\'表示する項目状態 X人目までの受付番号 \'',
	`b1_block_status` TINYINT default 0 COMMENT '\'項目順番・文言設定状態 B1 0：デフォルト 1:編集\'',
	`b1_receive_title` VARCHAR(20) COMMENT '文言設定B1 受付項目',
	`b1_guide_title` VARCHAR(20) COMMENT '文言設定B1 案内中',
	`b1_receive_no_title` VARCHAR(20) COMMENT '文言設定B1 受付番号',
	`b1_wait_unit_title` VARCHAR(20) COMMENT '文言設定B1 待ち組数',
	`b1_wait_time_title` VARCHAR(20) COMMENT '文言設定B1 待ち時間',
	`b1_guide_sort_no` TINYINT COMMENT '\'文言設定B1 案内中 順序\'',
	`b1_receive_sort_no` TINYINT COMMENT '\'文言設定B1 受付番号 順序\'',
	`b1_wait_unit_sort_no` TINYINT COMMENT '\'文言設定B1 待ち組数 順序\'',
	`b1_wait_time_sort_no` TINYINT COMMENT '\'文言設定B1 待ち時間 順序\'',
	`b3_block_status` TINYINT default 0 COMMENT '\'項目順番・文言設定状態 B3\'',
	`b3_call_no_title` VARCHAR(20) COMMENT '項目順番・文言設定 B3',
	`b1_called_status` TINYINT default 0 COMMENT '\'呼出済み表示文言状態 B1 0：デフォルト、1：編集\'',
	`b1_called_msg` VARCHAR(20) COMMENT '呼出済み表示文言',
	`b2_called_status` TINYINT default 0 COMMENT '\'呼出済み表示文言状態 B1 0：デフォルト、1：編集\'',
	`b2_called_msg` VARCHAR(20) COMMENT '呼出済み表示文言',
	`calling_display_status` TINYINT default 1 COMMENT '\'共通 呼出中の画面利用 0:あり 1:なし\'',
	`return_type` TINYINT default 0 COMMENT '\'呼出中画面からの戻り先 0: B1(待ち状況 ,1: B2 受付番号, 2:B3 呼出済み\'',
	`calling_title_status` TINYINT default 0 COMMENT '\'呼出中画面の文言状態 0: デフォルト ,1: 呼び出した番号の部門なを表示, 2:フリーワード\'',
	`calling_title` VARCHAR(50) COMMENT '呼出中画面の文言設定（デフォルト：カウンターまでおこしください）',
	`calling_upper_text` VARCHAR(30) COMMENT '呼出中画面の上段文言設定',
	`calling_lower_text` VARCHAR(30) COMMENT '呼出中画面の下段文言設定',
	`shop_glass_type` TINYINT default 1 COMMENT '\'1: あり(JINS店舗 1台運用), 2: あり(JINS店舗 2台運用),3:あり（NEWメガネショップ用）\'',
	`voice_link_status` TINYINT default 0 COMMENT '\'呼出ボタンの利用可否 0：なし 1：あり\'',
	`counter_display_status` TINYINT default 0 COMMENT '\'カウンター選択画面の利用可否 0：なし 1：カウンター表示機を利用(旧：あり) 2：既存の音声サーバーを利用\'',
	`counter_display_broadcast_status` TINYINT default 0 COMMENT '\'カウンター表示機の一斉送信機能利用可否 0：off 1：on\'',
	`counter_no_broadcast_status` TINYINT default 0 COMMENT '\'カウンター表示機呼出カウンター番号呼出機能 0：off 1：on\'',
	`external_voice_call` TINYINT default 0 NOT NULL COMMENT '外部音声呼出 0:使用しない 1:使用する',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`shop_id`),
	UNIQUE KEY `uq_shop_display_mst` (`shop_id`),
	KEY `index_shop_id`(`shop_id`)
) COMMENT='店舗表示機管理マスタ';

#-----------------------------------------------------------------------------
#-- coupon_category
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `coupon_category`;


CREATE TABLE `coupon_category`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT COMMENT 'クーポンカテゴリID',
	`name` VARCHAR(40)  NOT NULL COMMENT 'クーポンカテゴリ名',
	`display_order` INTEGER  NOT NULL COMMENT '表示順',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`)
) COMMENT='クーポンカテゴリ';

#-----------------------------------------------------------------------------
#-- coupon_pr_frame_detail
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `coupon_pr_frame_detail`;


CREATE TABLE `coupon_pr_frame_detail`
(
	`id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT 'ID',
	`search_pr_group_id` INTEGER  NOT NULL COMMENT 'グループID【削除予定】',
	`status` TINYINT default 0 NOT NULL COMMENT 'ステータス 0:有効 1:無効',
	`search_keyword` VARCHAR(200) COMMENT '検索キーワード【削除予定】',
	`pref_id` INTEGER COMMENT '都道府県ID',
	`city_id` INTEGER COMMENT '市区町村ID',
	`pref_name` VARCHAR(10) COMMENT '都道府県名',
	`city_name` VARCHAR(40) COMMENT '市区町村名',
	`pref_city_text` VARCHAR(100) COMMENT '都道府県市区町村テキスト【削除予定】',
	`xl_category_id` INTEGER COMMENT '大々カテゴリ【削除予定】',
	`big_category_id` INTEGER COMMENT '大カテゴリ【削除予定】',
	`mid_category_id` INTEGER COMMENT '中カテゴリ【削除予定】',
	`coupon_category_id` INTEGER COMMENT 'クーポンカテゴリID',
	`coupon_category_id_type` TINYINT COMMENT 'クーポンカテゴリID種別 0:店舗大カテゴリ 1:クーポンカテゴリ',
	`display_shop` INTEGER COMMENT '表示店舗ID',
	`display_coupon` INTEGER  NOT NULL COMMENT '表示クーポンID',
	`start_datetime` DATETIME COMMENT '設定開始日',
	`end_datetime` DATETIME COMMENT '設定終了日',
	`deleted` TINYINT default 0 NOT NULL COMMENT '削除フラグ 0:未削除 1:削除済み',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`)
) COMMENT='クーポンPR枠';

#-----------------------------------------------------------------------------
#-- coupon_pr_frame_detail_tmp
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `coupon_pr_frame_detail_tmp`;


CREATE TABLE `coupon_pr_frame_detail_tmp`
(
	`sequential_id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT '自動連番ID',
	`id` INTEGER UNSIGNED COMMENT 'クーポンPR枠ID',
	`search_pr_group_id` INTEGER  NOT NULL COMMENT 'グループID【削除予定】',
	`status` TINYINT  NOT NULL COMMENT 'ステータス 0:有効 1:無効',
	`search_keyword` VARCHAR(200) COMMENT '検索キーワード【削除予定】',
	`pref_id` INTEGER  NOT NULL COMMENT '都道府県ID',
	`city_id` INTEGER COMMENT '市区町村ID',
	`pref_name` VARCHAR(10) COMMENT '都道府県名',
	`city_name` VARCHAR(40) COMMENT '市区町村名',
	`pref_city_text` VARCHAR(100) COMMENT '都道府県市区町村テキスト【削除予定】',
	`xl_category_id` INTEGER  NOT NULL COMMENT '大々カテゴリ【削除予定】',
	`big_category_id` INTEGER COMMENT '大カテゴリ【削除予定】',
	`mid_category_id` INTEGER COMMENT '中カテゴリ【削除予定】',
	`coupon_category_id` INTEGER  NOT NULL COMMENT 'クーポンカテゴリID',
	`coupon_category_id_type` TINYINT  NOT NULL COMMENT 'クーポンカテゴリID種別 0:店舗大カテゴリ 1:クーポンカテゴリ',
	`display_shop` VARCHAR(200)  NOT NULL COMMENT '表示店舗【削除予定】',
	`display_coupon` VARCHAR(200) COMMENT '表示クーポン(必須にする)',
	`start_datetime` DATETIME COMMENT '設定開始日',
	`end_datetime` DATETIME COMMENT '設定終了日',
	`expires_at` DATETIME COMMENT '一時データ有効期限（通常30分）',
	`manipulation_code` TINYINT default 1 NOT NULL COMMENT '処理コード 1:挿入 2:更新 3:削除',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`sequential_id`)
) COMMENT='クーポンPR枠アップロード一時データ';

#-----------------------------------------------------------------------------
#-- coupon_pr_frame_impression
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `coupon_pr_frame_impression`;


CREATE TABLE `coupon_pr_frame_impression`
(
	`id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT '自動連番ID',
	`frame_id` INTEGER  NOT NULL COMMENT 'クーポンPR枠ID',
	`type` INTEGER  NOT NULL COMMENT 'イベント区分(1:インプレッション 2:クリック)',
	`target_date` DATE  NOT NULL COMMENT '対象日時',
	`created_at` DATETIME,
	PRIMARY KEY (`id`),
	KEY `index_frame_id_target_date_type`(`frame_id`, `target_date`, `type`)
) COMMENT='クーポンPR枠インプレッション・クリック数';

#-----------------------------------------------------------------------------
#-- coupon_pr_frame_impression_log_history
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `coupon_pr_frame_impression_log_history`;


CREATE TABLE `coupon_pr_frame_impression_log_history`
(
	`frame_id` INTEGER  NOT NULL COMMENT 'クーポンPR枠ID',
	`target_date` DATE  NOT NULL COMMENT '対象日時',
	`impression_count` INTEGER default 0 NOT NULL COMMENT 'インプレッション数',
	`click_count` INTEGER default 0 NOT NULL COMMENT 'クリック数',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`frame_id`,`target_date`)
) COMMENT='クーポンPR枠インプレッション・クリック数履歴';

#-----------------------------------------------------------------------------
#-- coupon_pr_frame_group
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `coupon_pr_frame_group`;


CREATE TABLE `coupon_pr_frame_group`
(
	`id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT 'ID',
	`name` VARCHAR(100)  NOT NULL COMMENT 'グループ名',
	`status` TINYINT default 0 NOT NULL COMMENT 'ステータス ※有効：0、無効：1',
	`deleted` TINYINT default 0 NOT NULL COMMENT '削除フラグ ※未削除：0、削除済み：1',
	`created_at` DATETIME COMMENT '作成日時',
	`updated_at` DATETIME COMMENT '編集日時',
	PRIMARY KEY (`id`)
) COMMENT='広告PR枠グループ';

#-----------------------------------------------------------------------------
#-- coupon_box_sort_condition
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `coupon_box_sort_condition`;


CREATE TABLE `coupon_box_sort_condition`
(
	`id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT '自動連番ID',
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID',
	`member_id` INTEGER  NOT NULL COMMENT '会員ID',
	`reserve_count` INTEGER default 0 NOT NULL COMMENT '会員が店舗を予約した累積数',
	`coupon_use_count` INTEGER default 0 NOT NULL COMMENT '会員が店舗のクーポンを利用した累積回数',
	`total_count` INTEGER default 0 NOT NULL COMMENT '合計',
	`status` TINYINT  NOT NULL COMMENT 'ステータス 0:有効 1:無効',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	UNIQUE KEY `uniq_index` (`shop_id`, `member_id`)
) COMMENT='店舗別会員別予約数＆クーポン利用回数集計';

#-----------------------------------------------------------------------------
#-- shop_coupon_mst
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `shop_coupon_mst`;


CREATE TABLE `shop_coupon_mst`
(
	`id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT '自動連番ID',
	`name` VARCHAR(100)  NOT NULL COMMENT 'クーポン名称',
	`content` TEXT  NOT NULL COMMENT 'クーポンの内容',
	`print_content` TEXT  NOT NULL COMMENT '印字用クーポン説明',
	`shop_id` INTEGER COMMENT '店舗ID',
	`group_id` INTEGER COMMENT 'グループID',
	`coupon_img` VARCHAR(50) COMMENT 'クーポン画像',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`)
) COMMENT='店舗・グループクーポンマスタ';

#-----------------------------------------------------------------------------
#-- repeat_mail_coupon
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `repeat_mail_coupon`;


CREATE TABLE `repeat_mail_coupon`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT COMMENT '自動生成プライマリキー',
	`repeat_mail_id` INTEGER  NOT NULL COMMENT 'リピートメールID （shop_mail.id OR group_mail.id）',
	`shop_id` INTEGER COMMENT '店舗ID',
	`group_id` INTEGER COMMENT 'グループ店舗ID',
	`shop_coupon_mst_id` INTEGER COMMENT '店舗クーポンマスタID',
	`name` VARCHAR(100) COMMENT 'クーポン名称',
	`text` VARCHAR(3500) COMMENT 'クーポン内容',
	`print_content` TEXT COMMENT '印字用クーポン説明',
	`send_limit_status` TINYINT default 0 NOT NULL COMMENT 'クーポン配信利用枚数指定(0:指定なし 1:指定する)',
	`send_limit` INTEGER COMMENT '配信枚数',
	`use_max_status` TINYINT default 1 NOT NULL COMMENT '利用回数指定(0:指定なし 1:期間中 2:一日)',
	`use_max_num` INTEGER COMMENT '利用可能回数最大値',
	`term_start_day` SMALLINT COMMENT 'クーポン利用開始日（配信日から○日後）',
	`term_end_day` SMALLINT COMMENT 'クーポン利用終了日(利用開始日から○日間 / 月の末日まではNULL)',
	`time_start_h` VARCHAR(2) COMMENT 'クーポン有効時刻開始(時)',
	`time_start_m` VARCHAR(2) COMMENT '有効時間開始(分)',
	`time_end_type` TINYINT default 0 NOT NULL COMMENT 'クーポン有効時刻種類 0:当日 1:翌日',
	`time_end_h` VARCHAR(2) COMMENT '有効時間終了(時)',
	`time_end_m` VARCHAR(2) COMMENT '有効時間終了(分)',
	`use_date_status` TINYINT default 0 NOT NULL COMMENT '有効日付指定(0:指定なし 1:指定する)',
	`use_week` VARCHAR(20) COMMENT '曜日指定　カンマ区切り 0：日1：月2：火3：水4：木5：金6：土7：祝',
	`use_days` VARCHAR(150) COMMENT '日付指定　カンマ区切り',
	`coupon_img` VARCHAR(50) COMMENT 'クーポン画像',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	INDEX `repeat_mail_coupon_FI_1` (`shop_id`),
	INDEX `repeat_mail_coupon_FI_2` (`group_id`)
) COMMENT='リピートメールクーポン（shop_couponのひな形）';

#-----------------------------------------------------------------------------
#-- receive_immediate_guide_employee
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `receive_immediate_guide_employee`;


CREATE TABLE `receive_immediate_guide_employee`
(
	`receive_id` BIGINT  NOT NULL COMMENT '予約ID',
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID',
	`employee_id` BIGINT  NOT NULL COMMENT '担当者ID',
	`employee_name` VARCHAR(20)  NOT NULL COMMENT '担当者名',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`receive_id`,`shop_id`,`employee_id`),
	UNIQUE KEY `uniq_index` (`receive_id`, `shop_id`, `employee_id`)
) COMMENT='即時対応複数担当者テーブル';

#-----------------------------------------------------------------------------
#-- receive_immediate_guide_employee_history
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `receive_immediate_guide_employee_history`;


CREATE TABLE `receive_immediate_guide_employee_history`
(
	`receive_id` BIGINT  NOT NULL COMMENT '予約ID',
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID',
	`employee_id` BIGINT  NOT NULL COMMENT '担当者ID',
	`employee_name` VARCHAR(20)  NOT NULL COMMENT '担当者名',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`receive_id`,`shop_id`,`employee_id`),
	UNIQUE KEY `uniq_index` (`receive_id`, `shop_id`, `employee_id`)
) COMMENT='即時対応複数担当者テーブル（履歴）';

#-----------------------------------------------------------------------------
#-- shop_drugstore
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `shop_drugstore`;


CREATE TABLE `shop_drugstore`
(
	`shop_id` BIGINT  NOT NULL COMMENT '店舗ID',
	`notice` TINYINT default 0 COMMENT '処方箋新着通知',
	`notice_repeat` TINYINT default 0 COMMENT 'アラーム音の繰り返し',
	`mail_address` VARCHAR(100) COMMENT '処方箋新着通知をするメールアドレス',
	`mail_copy_mail_address` VARCHAR(100) COMMENT 'メールコピーを送信するメールアドレス（Bcc）',
	`print_device` TINYINT default 0 COMMENT '処方箋印刷機器',
	`fax_number` VARCHAR(20) COMMENT '処方箋印刷用ファクス番号',
	`accept_drugstore` VARCHAR(400) COMMENT '処方せん送信完了メール',
	`accept_prescription` VARCHAR(400) COMMENT '処方せん受付メール',
	`complete_dispense` VARCHAR(400) COMMENT '調剤完了メール',
	`resend_prescription` VARCHAR(400) COMMENT '処方せん再送信依頼メール',
	`accept_holiday` TINYINT default 0 COMMENT '閉店後・休日でも予約受付をする',
	`post` TINYINT default 0 COMMENT '処方せんポスト',
	`notice_of_accept` TINYINT default 0 COMMENT '受付ファクス通知　0：使用しない　1：使用する（テキストのみ）　2：使用する（テキストと画像を1枚で出力）',
	`notice_to_fax` VARCHAR(20) COMMENT '受付ファクス通知番号',
	`order_confirm_mail` VARCHAR(100) COMMENT '注文確認メール送信先アドレス',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`shop_id`),
	KEY `index_shop_id`(`shop_id`)
) COMMENT='調剤薬局店舗の設定';

#-----------------------------------------------------------------------------
#-- receive_drugstore_prescription
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `receive_drugstore_prescription`;


CREATE TABLE `receive_drugstore_prescription`
(
	`id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT 'ID',
	`receive_id` BIGINT  NOT NULL COMMENT '予約ID',
	`accept_date` DATETIME COMMENT '処方箋受付日時',
	`fax_complete_date` DATETIME COMMENT 'ファクス送信完了日時',
	`dispensing_flag` TINYINT default 0 COMMENT '＊未使用 調剤完了フラグ（accessor_name:dispensing_flag yes/no）',
	`dispensing_date` DATETIME COMMENT '調剤完了日時',
	`prescription_status` TINYINT default 0 COMMENT '処方箋受付状況（accessor_name:prescription_status noview/accept/wait）',
	`canceled` TINYINT default 0 COMMENT 'お客様キャンセル（accessor_name:canceld none/confirm）',
	`cancel_at` DATETIME COMMENT 'お客様キャンセル日時',
	`reserve_date` DATETIME COMMENT '来店予定日',
	`reserve_name` VARCHAR(40) COMMENT '予約者名前',
	`reserve_remarks` VARCHAR(40) COMMENT 'ID/メモなど',
	`reserve_status` TINYINT default 1 COMMENT '来局予定状況 予定=1 削除=0 default=1',
	`shop_to_member_id` INTEGER(8) COMMENT '店頭登録会員ID（NULL可）',
	`request_at` DATETIME COMMENT '再送信依頼日時',
	`owner_shop_id` BIGINT UNSIGNED COMMENT 'オーナーID',
	`shop_id` BIGINT UNSIGNED COMMENT '店舗ID',
	`member_id` INTEGER UNSIGNED default 0 COMMENT '会員ID',
	`receipt_at` DATETIME COMMENT '案内予定日',
	`entry_date` DATETIME COMMENT '予約年月日',
	`entry_type` TINYINT UNSIGNED COMMENT '予約エントリータイプ',
	`entry_sub_code` INTEGER UNSIGNED COMMENT '予約エントリーサブコード',
	`test_shop_flag` TINYINT UNSIGNED default 0 COMMENT 'テスト店舗区分   0=実店舗、1=テスト店舗',
	`rx_num_of_sheet` TINYINT UNSIGNED default 0 COMMENT '処方せん枚数',
	`shop_cxl_reason` TINYINT UNSIGNED COMMENT '処方便店舗側キャンセル理由 キャンセル理由に紐づく番号を指定する',
	`shop_cxl_at` DATETIME COMMENT '処方便店舗側キャンセル日時',
	`thx_mail_send_flag` TINYINT UNSIGNED default 0 COMMENT '処方便サンキューメール送信フラグ 0=未送信、1=送信済み',
	`thx_mail_send_at` DATETIME COMMENT '処方便サンキューメール送信日時',
	`web_to_fax_flag` TINYINT UNSIGNED COMMENT 'FAXフラグ 0=通常店舗、1=webToFax店舗',
	`receive_msg_checked` TINYINT UNSIGNED default 0 COMMENT '調剤予約メッセージ確認済フラグ 0：未確認、1：確認済み',
	`receive_msg_body` VARCHAR(200) COMMENT '調剤予約メッセージ内容',
	`ds_coop_member_id` VARCHAR(80) COMMENT '外部連携会員ID',
	`med_rpt_user_id` INTEGER(11) COMMENT 'お薬手帳利用者ID',
	`ps_reserve_id` INTEGER(10) COMMENT 'PS予約ID',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	KEY `index_receive_id`(`receive_id`),
	KEY `index_accept_date`(`accept_date`),
	KEY `index_fax_complete_date`(`fax_complete_date`),
	KEY `index_dispensing_flag`(`dispensing_flag`),
	KEY `index_dispensing_date`(`dispensing_date`),
	KEY `index_prescription_status`(`prescription_status`),
	KEY `index_receive_drugstore_prescription_shop_to_member_id`(`shop_to_member_id`),
	KEY `ix_receive_drugstore_prescription_1`(`shop_id`),
	KEY `ix_receive_drugstore_prescription_2`(`member_id`),
	KEY `ix_receive_drugstore_prescription_3`(`entry_date`),
	KEY `ix_receive_drugstore_prescription_4`(`entry_type`),
	KEY `ix_receive_drugstore_prescription_5`(`entry_sub_code`),
	KEY `ix_receive_drugstore_prescription_6`(`created_at`),
	KEY `ix_receive_drugstore_prescription_7`(`entry_type`, `entry_sub_code`)
) COMMENT='予約受付データに対応する処方箋データ';

#-----------------------------------------------------------------------------
#-- l_ds_receive
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `l_ds_receive`;


CREATE TABLE `l_ds_receive`
(
	`id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT 'ID',
	`receive_id` BIGINT UNSIGNED  NOT NULL COMMENT '予約ID',
	`accept_date` DATETIME COMMENT '処方せん受付日時',
	`fax_complete_date` DATETIME COMMENT 'ファクス送信完了日時',
	`dispensing_flag` TINYINT UNSIGNED default 0 COMMENT '調剤完了フラグ（accessor_name:l_dps_flag yes/no）',
	`dispensing_date` DATETIME COMMENT '調剤完了日時',
	`prescription_status` TINYINT UNSIGNED default 0 COMMENT '処方箋受付状況（accessor_name:l_rx_st noview/accept/wait）',
	`canceled` TINYINT UNSIGNED default 0 COMMENT 'お客様キャンセル（accessor_name:l_u_cxl none/confirm）',
	`cancel_at` DATETIME COMMENT 'お客様キャンセル日時',
	`reserve_date` DATETIME COMMENT '来店予定日',
	`reserve_name` VARCHAR(40) COMMENT '予約者名前',
	`reserve_remarks` VARCHAR(40) COMMENT 'ID/メモなど',
	`reserve_status` TINYINT UNSIGNED default 1 COMMENT '来局予定状況 予定=1 削除=0',
	`shop_to_member_id` INTEGER UNSIGNED COMMENT '店頭登録会員ID（NULL可）',
	`request_at` DATETIME COMMENT '再送信依頼日時',
	`owner_shop_id` BIGINT UNSIGNED COMMENT 'オーナーID',
	`shop_id` BIGINT UNSIGNED COMMENT '店舗ID',
	`member_id` INTEGER UNSIGNED COMMENT '会員ID',
	`receipt_at` DATETIME COMMENT '案内予定日',
	`entry_date` DATETIME COMMENT '予約年月日',
	`entry_type` TINYINT UNSIGNED COMMENT '予約エントリータイプ',
	`entry_sub_code` INTEGER UNSIGNED COMMENT '予約エントリーサブコード',
	`test_shop_flag` TINYINT UNSIGNED default 0 COMMENT 'テスト店舗区分 0=実店舗、1=テスト店舗',
	`rx_num_of_sheet` TINYINT UNSIGNED default 0 COMMENT '処方せん枚数',
	`shop_cxl_reason` TINYINT UNSIGNED COMMENT '店舗側キャンセル理由 キャンセル理由に紐づく番号を指定する',
	`shop_cxl_at` DATETIME COMMENT '店舗側キャンセル日時',
	`thx_mail_send_flag` INTEGER UNSIGNED default 0 COMMENT 'サンキューメール送信フラグ 0=未送信、1=送信済み',
	`thx_mail_send_at` DATETIME COMMENT 'サンキューメール送信日時',
	`web_to_fax_flag` TINYINT UNSIGNED COMMENT 'FAXフラグ 0=通常店舗、1=webToFax店舗',
	`receive_msg_checked` TINYINT UNSIGNED default 0 COMMENT '調剤予約メッセージ確認済フラグ 0：未確認、1：確認済み',
	`receive_msg_body` VARCHAR(200) COMMENT '調剤予約メッセージ内容',
	`ds_coop_member_id` VARCHAR(80) COMMENT '外部連携会員ID',
	`med_rpt_user_id` INTEGER(11) COMMENT 'お薬手帳利用者ID',
	`ps_reserve_id` INTEGER(10) COMMENT 'PS予約ID',
	`rx_created_at` DATETIME  NOT NULL COMMENT '処方せんレコード作成日時',
	`rx_updated_at` DATETIME  NOT NULL COMMENT '処方せんレコード更新日時',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	KEY `ix_l_ds_receive_1`(`receive_id`),
	KEY `ix_l_ds_receive_2`(`accept_date`),
	KEY `ix_l_ds_receive_3`(`fax_complete_date`),
	KEY `ix_l_ds_receive_4`(`dispensing_date`),
	KEY `ix_l_ds_receive_5`(`shop_id`),
	KEY `ix_l_ds_receive_6`(`member_id`),
	KEY `ix_l_ds_receive_7`(`entry_date`),
	KEY `ix_l_ds_receive_8`(`entry_type`),
	KEY `ix_l_ds_receive_9`(`entry_sub_code`),
	KEY `ix_l_ds_receive_10`(`rx_created_at`),
	KEY `ix_l_ds_receive_11`(`created_at`),
	KEY `ix_l_ds_receive_12`(`entry_type`, `entry_sub_code`),
	KEY `ix_l_ds_receive_13`(`ds_coop_member_id`)
) COMMENT='l_調剤予約履歴テーブル';

#-----------------------------------------------------------------------------
#-- receive_drugstore_prescription_image
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `receive_drugstore_prescription_image`;


CREATE TABLE `receive_drugstore_prescription_image`
(
	`id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT 'ID',
	`receive_id` BIGINT  NOT NULL COMMENT '予約ID',
	`file_path` VARCHAR(100)  NOT NULL COMMENT '画像ファイルのパス',
	`ps_image_id` INTEGER(10) UNSIGNED COMMENT 'PS画像ID',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	KEY `index_receive_id`(`receive_id`)
) COMMENT='送信された処方箋画像の情報';

#-----------------------------------------------------------------------------
#-- receive_drugstore_faxtransmit_log
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `receive_drugstore_faxtransmit_log`;


CREATE TABLE `receive_drugstore_faxtransmit_log`
(
	`id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT 'ID',
	`receive_id` BIGINT  NOT NULL COMMENT '予約ID',
	`fax_transmit_date` DATETIME COMMENT 'ファクス送信実行日時',
	`fax_retry` TINYINT default 0 COMMENT 'ファクス再送信回数',
	`reply_to` VARCHAR(50) COMMENT 'ファクス再送信時のメール送信先アドレス',
	`fax_number` VARCHAR(20) COMMENT 'ファクス番号',
	`fax_status` BIGINT default 0 COMMENT 'ファクス送信状況（accessor_name:fax_status ng/ok/send_request/resend_request/accept/reject）',
	`error_txt` TEXT COMMENT 'エラーコード等',
	`total_page` BIGINT COMMENT '送信枚数',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	KEY `index_receive_id`(`receive_id`),
	KEY `index_fax_transmit_date`(`fax_transmit_date`),
	KEY `index_fax_status`(`fax_status`)
) COMMENT='ファクス送信ログ';

#-----------------------------------------------------------------------------
#-- ds_cooperation
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `ds_cooperation`;


CREATE TABLE `ds_cooperation`
(
	`cooperation_id` TINYINT UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT '外部連携ID',
	`m_class_auth_id` TINYINT UNSIGNED  NOT NULL COMMENT '区分属性権限ID(薬局)',
	`company_name` VARCHAR(50)  NOT NULL COMMENT '会社名',
	`client_id` VARCHAR(40)  NOT NULL COMMENT 'クライアントID',
	`client_secret` VARCHAR(40)  NOT NULL COMMENT 'クライアントシークレット',
	`representative_1` VARCHAR(40) COMMENT '担当者名1',
	`representative_2` VARCHAR(40) COMMENT '担当者名2',
	`tel` VARCHAR(40) COMMENT '電話番号',
	`mail_address` VARCHAR(255) COMMENT 'メールアドレス',
	`delete_flg` TINYINT UNSIGNED default 0 COMMENT '削除フラグ',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`cooperation_id`),
	KEY `ix_ds_cooperation1`(`client_id`, `client_secret`),
	KEY `ix_ds_cooperation2`(`delete_flg`)
) COMMENT='薬局外部連携テーブル';

#-----------------------------------------------------------------------------
#-- ds_img_token
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `ds_img_token`;


CREATE TABLE `ds_img_token`
(
	`ds_img_token_id` INTEGER(10) UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT '画像トークンID',
	`img_token` VARCHAR(40)  NOT NULL COMMENT '画像トークン',
	`shop_id` INTEGER(10) UNSIGNED  NOT NULL COMMENT '店舗ID',
	`prescription_img_id` INTEGER(10) UNSIGNED  NOT NULL COMMENT '処方箋画像ID',
	`created_at` DATETIME  NOT NULL COMMENT 'トークン発行日時',
	PRIMARY KEY (`ds_img_token_id`),
	UNIQUE KEY `uix_ds_img_token1` (`img_token`),
	KEY `ix_ds_img_token2`(`created_at`)
) COMMENT='処方箋画像トークン管理';

#-----------------------------------------------------------------------------
#-- shop_drugstore_mail_format
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `shop_drugstore_mail_format`;


CREATE TABLE `shop_drugstore_mail_format`
(
	`shop_id` INTEGER(8)  NOT NULL COMMENT '店舗ID',
	`form_name1` VARCHAR(20)  NOT NULL COMMENT '定型文名前1',
	`subject1` VARCHAR(512)  NOT NULL COMMENT '件名1',
	`text1` VARCHAR(2048)  NOT NULL COMMENT '本文1',
	`form_name2` VARCHAR(20)  NOT NULL COMMENT '定型文名前2',
	`subject2` VARCHAR(512)  NOT NULL COMMENT '件名2',
	`text2` VARCHAR(2048)  NOT NULL COMMENT '本文2',
	`form_name3` VARCHAR(20)  NOT NULL COMMENT '定型文名前3',
	`subject3` VARCHAR(512)  NOT NULL COMMENT '件名3',
	`text3` VARCHAR(2048)  NOT NULL COMMENT '本文3',
	`form_name4` VARCHAR(20)  NOT NULL COMMENT '定型文名前4',
	`subject4` VARCHAR(512)  NOT NULL COMMENT '件名',
	`text4` VARCHAR(2048)  NOT NULL COMMENT '本文4',
	`form_name5` VARCHAR(20)  NOT NULL COMMENT '定型文名前5',
	`subject5` VARCHAR(512)  NOT NULL COMMENT '件名5',
	`text5` VARCHAR(2048)  NOT NULL COMMENT '本文5',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`shop_id`),
	KEY `index_shop_drugstore_mail_format_shop_id`(`shop_id`)
) COMMENT='調剤薬局定型文メールフォーマット';

#-----------------------------------------------------------------------------
#-- receive_prescription_interview
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `receive_prescription_interview`;


CREATE TABLE `receive_prescription_interview`
(
	`id` BIGINT(20)  NOT NULL AUTO_INCREMENT COMMENT '自動生成プライマリーキー',
	`receive_id` BIGINT(20)  NOT NULL COMMENT '予約ID',
	`generic` TINYINT(4) default 1 NOT NULL COMMENT 'ジェネリック希望',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	KEY `index_receive_prescription_interview_receive_id`(`receive_id`)
) COMMENT='調剤薬局 調剤前確認項目テーブル';

#-----------------------------------------------------------------------------
#-- shop_to_member_sendmail_history
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `shop_to_member_sendmail_history`;


CREATE TABLE `shop_to_member_sendmail_history`
(
	`id` INTEGER(11)  NOT NULL AUTO_INCREMENT COMMENT 'ID 自動生成プライマリーキー',
	`shop_id` INTEGER(8)  NOT NULL COMMENT '店舗ID',
	`status` TINYINT(4)  NOT NULL COMMENT '送信結果',
	`receive_id` BIGINT(20)  NOT NULL COMMENT '予約ID',
	`mail_address` VARCHAR(255)  NOT NULL COMMENT '送信先メールアドレス',
	`form_no` TINYINT(4) COMMENT '定型文番号',
	`form_name` VARCHAR(20)  NOT NULL COMMENT '定型文名前',
	`subject` VARCHAR(512)  NOT NULL COMMENT '件名',
	`text` VARCHAR(2048)  NOT NULL COMMENT '本文',
	`send_datetime` DATETIME COMMENT '送信日時',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`,`shop_id`),
	KEY `index_shop_to_member_sendmail_history_shop_id`(`shop_id`),
	KEY `index_shop_to_member_sendmail_history_receive_id`(`receive_id`)
) COMMENT='調剤薬局定型文メール送信履歴テーブル';

#-----------------------------------------------------------------------------
#-- gift_code
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `gift_code`;


CREATE TABLE `gift_code`
(
	`service_id` INTEGER  NOT NULL COMMENT '提携サービスコード',
	`gift_code` VARCHAR(32)  NOT NULL COMMENT 'ギフトコード',
	`status` TINYINT default 0 COMMENT '使用フラグ (0:未使用 / 1:使用済)',
	`gift_start` DATETIME COMMENT 'ギフト期間（開始）',
	`gift_end` DATETIME COMMENT 'ギフト期間（終了）',
	`coupon_box_id` INTEGER COMMENT 'クーポンBOXのＩＤ',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`service_id`,`gift_code`),
	KEY `index_service_id`(`service_id`, `gift_code`, `gift_start`, `gift_end`),
	KEY `index_coupon_box_id`(`coupon_box_id`)
) COMMENT='ギフト管理';

#-----------------------------------------------------------------------------
#-- gift_member
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `gift_member`;


CREATE TABLE `gift_member`
(
	`coupon_box_id` INTEGER  NOT NULL COMMENT 'クーポンBOXのＩＤ',
	`member_id` INTEGER  NOT NULL COMMENT '会員ID',
	`service_id` INTEGER  NOT NULL COMMENT '提携サービスコード',
	`gift_code` VARCHAR(32)  NOT NULL COMMENT 'ギフトコード',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`coupon_box_id`,`member_id`),
	KEY `index_coupon_box_id`(`coupon_box_id`, `member_id`),
	KEY `index_member_id`(`member_id`),
	KEY `index_service_id`(`service_id`)
) COMMENT='ギフトとユーザの紐付け';

#-----------------------------------------------------------------------------
#-- railroad_company_master
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `railroad_company_master`;


CREATE TABLE `railroad_company_master`
(
	`railroad_company_id` SMALLINT  NOT NULL COMMENT '鉄道会社ID',
	`railroad_company_name` VARCHAR(128) COMMENT '鉄道会社名称',
	`status` TINYINT default 0 COMMENT 'ステータス',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`railroad_company_id`)
) COMMENT='鉄道会社マスタ';

#-----------------------------------------------------------------------------
#-- route_master
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `route_master`;


CREATE TABLE `route_master`
(
	`route_id` INTEGER  NOT NULL COMMENT '路線ID',
	`route_name` VARCHAR(128) COMMENT '路線名称',
	`railroad_company_id` SMALLINT default 0 COMMENT '鉄道会社ID',
	`display_order` INTEGER default 0 COMMENT '表示順序',
	`status` TINYINT default 0 COMMENT 'ステータス',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`route_id`),
	KEY `index_railroad_company_id`(`railroad_company_id`)
) COMMENT='路線マスタ';

#-----------------------------------------------------------------------------
#-- station_master
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `station_master`;


CREATE TABLE `station_master`
(
	`station_id` INTEGER  NOT NULL COMMENT '駅ID',
	`station_name` VARCHAR(128) COMMENT '駅名称',
	`station_name_kana` VARCHAR(128) COMMENT '駅名称カタカナ',
	`route_id` INTEGER default 0 COMMENT '路線ID',
	`display_order` INTEGER default 0 COMMENT '表示順序',
	`station_g_id` INTEGER default 0 COMMENT 'ターミナル駅ID',
	`pref_id` INTEGER default 0 COMMENT '都道府県ID',
	`longitude` DOUBLE default 0 COMMENT '経度',
	`latitude` DOUBLE default 0 COMMENT '緯度',
	`status` TINYINT default 0 COMMENT 'ステータス',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`station_id`),
	KEY `index_route_id`(`route_id`),
	INDEX `station_master_FI_2` (`station_g_id`)
) COMMENT='駅マスタ';

#-----------------------------------------------------------------------------
#-- station_group_master
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `station_group_master`;


CREATE TABLE `station_group_master`
(
	`station_g_id` INTEGER  NOT NULL COMMENT 'ターミナル駅ID',
	`station_g_name` VARCHAR(128) COMMENT 'ターミナル駅名称',
	`pref_id` INTEGER default 0 COMMENT '都道府県ID',
	`status` TINYINT default 0 COMMENT 'ステータス',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`station_g_id`),
	KEY `index_pref_id`(`pref_id`)
) COMMENT='ターミナル駅マスタ';

#-----------------------------------------------------------------------------
#-- pref_route_data
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `pref_route_data`;


CREATE TABLE `pref_route_data`
(
	`pref_id` INTEGER default 0 NOT NULL COMMENT '都道府県ID',
	`route_id` INTEGER default 0 NOT NULL COMMENT '路線ID',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`pref_id`,`route_id`),
	INDEX `pref_route_data_FI_1` (`route_id`)
) COMMENT='都道府県と路線を紐付ける中間データテーブル';

#-----------------------------------------------------------------------------
#-- shop_station_data
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `shop_station_data`;


CREATE TABLE `shop_station_data`
(
	`shop_id` INTEGER default 0 NOT NULL COMMENT '店舗ID',
	`station_id` INTEGER default 0 NOT NULL COMMENT '駅ID',
	`display_order` INTEGER default 0 COMMENT '表示順序',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`shop_id`,`station_id`),
	INDEX `shop_station_data_FI_2` (`station_id`)
) COMMENT='店舗と駅の紐付けテーブル';

#-----------------------------------------------------------------------------
#-- shop_counter_display
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `shop_counter_display`;


CREATE TABLE `shop_counter_display`
(
	`shop_id` BIGINT  NOT NULL COMMENT '店舗ＩＤ',
	`regist_no` BIGINT default 0 NOT NULL COMMENT '登録順',
	`counter_display_no` BIGINT default 0 NOT NULL COMMENT 'カウンター表示機番号',
	`counter_server_ip` VARCHAR(15)  NOT NULL COMMENT 'カウンター表示機サーバIP',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`shop_id`,`regist_no`),
	KEY `index_shop_id`(`shop_id`),
	KEY `index_counter_display_no`(`counter_display_no`)
) COMMENT='カウンター表示機設定テーブル';

#-----------------------------------------------------------------------------
#-- counter_display_voice_mst
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `counter_display_voice_mst`;


CREATE TABLE `counter_display_voice_mst`
(
	`id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT,
	`numerical_position` INTEGER  NOT NULL COMMENT '桁数 1:1の位 2:10の位 3:100の位 4:数値以外',
	`numerical_value` INTEGER default 0 COMMENT '数値',
	`no_status` TINYINT default 0 COMMENT '番付与ステータス なし:0 あり:1',
	`voice_code` VARCHAR(10)  NOT NULL COMMENT '音声コード',
	`voice_memo` VARCHAR(256)  NOT NULL COMMENT '音声メモ',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	KEY `index_numerical_position`(`numerical_position`),
	KEY `index_numerical_value`(`numerical_value`)
) COMMENT='カウンター表示機音声マスタテーブル';

#-----------------------------------------------------------------------------
#-- lite_report
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `lite_report`;


CREATE TABLE `lite_report`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	`lite_report_id` INTEGER  NOT NULL COMMENT '簡単レポートID',
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID',
	`member_id` INTEGER COMMENT '会員ID',
	`status` TINYINT  NOT NULL COMMENT 'ステータス（0:未承認 1:承認）',
	`report_flag` TINYINT  NOT NULL COMMENT '投稿区分(0:CSV投稿 1:会員投稿（PC） 2:会員投稿（SP）)',
	`text` VARCHAR(150)  NOT NULL COMMENT '本文',
	`initial` VARCHAR(32)  NOT NULL COMMENT 'イニシャル',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	KEY `index_shop_id`(`lite_report_id`, `shop_id`),
	INDEX `lite_report_FI_1` (`shop_id`)
) COMMENT='簡単レポート';

#-----------------------------------------------------------------------------
#-- lite_report_temp
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `lite_report_temp`;


CREATE TABLE `lite_report_temp`
(
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID',
	`text` VARCHAR(150)  NOT NULL COMMENT '本文',
	`initial` VARCHAR(32)  NOT NULL COMMENT 'イニシャル',
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	PRIMARY KEY (`id`),
	INDEX `lite_report_temp_FI_1` (`shop_id`)
) COMMENT='簡単レポートテンポラリ';

#-----------------------------------------------------------------------------
#-- mid_category_genre
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `mid_category_genre`;


CREATE TABLE `mid_category_genre`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	`mid_id` INTEGER  NOT NULL COMMENT '関連中分類キー',
	`name` VARCHAR(40)  NOT NULL COMMENT '名称',
	`seotext_1` TEXT COMMENT 'SEO用テキスト1',
	`seotext_2` TEXT COMMENT 'SEO用テキスト2',
	`seotext_3` TEXT COMMENT 'SEO用テキスト3',
	`my_order` INTEGER default 0 NOT NULL COMMENT '表示順',
	`view_status` TINYINT default 1 NOT NULL COMMENT '運用（表示）状態（0:非表示 1:運用中）',
	PRIMARY KEY (`id`),
	KEY `index_mid_id`(`mid_id`),
	KEY `index_my_order`(`my_order`),
	KEY `index_view_status`(`view_status`)
) COMMENT='ジャンルマスタ';

#-----------------------------------------------------------------------------
#-- mid_category_keyword
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `mid_category_keyword`;


CREATE TABLE `mid_category_keyword`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	`mid_id` INTEGER  NOT NULL COMMENT '関連中分類キー',
	`name` VARCHAR(40)  NOT NULL COMMENT '名称',
	`seotext_1` TEXT COMMENT 'SEO用テキスト1',
	`seotext_2` TEXT COMMENT 'SEO用テキスト2',
	`seotext_3` TEXT COMMENT 'SEO用テキスト3',
	`my_order` INTEGER default 0 NOT NULL COMMENT '表示順',
	`view_status` TINYINT default 1 NOT NULL COMMENT '運用（表示）状態（0:非表示 1:運用中）',
	PRIMARY KEY (`id`),
	KEY `index_mid_id`(`mid_id`),
	KEY `index_my_order`(`my_order`),
	KEY `index_view_status`(`view_status`)
) COMMENT='キーワードマスタ';

#-----------------------------------------------------------------------------
#-- shop_genre
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `shop_genre`;


CREATE TABLE `shop_genre`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID',
	`genre_id` INTEGER  NOT NULL COMMENT '関連ジャンルID',
	PRIMARY KEY (`id`),
	KEY `index_shop_genre`(`shop_id`, `genre_id`),
	INDEX `shop_genre_FI_2` (`genre_id`)
) COMMENT='店舗ジャンル紐づけ';

#-----------------------------------------------------------------------------
#-- shop_keyword
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `shop_keyword`;


CREATE TABLE `shop_keyword`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID',
	`keyword_id` INTEGER  NOT NULL COMMENT '関連キーワードID',
	`order_number` INTEGER UNSIGNED COMMENT '表示の順番',
	PRIMARY KEY (`id`),
	KEY `index_shop_keyword`(`shop_id`, `keyword_id`),
	INDEX `shop_keyword_FI_2` (`keyword_id`)
) COMMENT='店舗キーワード紐づけ';

#-----------------------------------------------------------------------------
#-- api_system
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `api_system`;


CREATE TABLE `api_system`
(
	`api_system_code` VARCHAR(5)  NOT NULL COMMENT 'API連携システム識別コード',
	`api_system_name` VARCHAR(40)  NOT NULL COMMENT 'API連携システム名',
	`additional_info_cd` VARCHAR(30) COMMENT '追加情報コード APIシステム毎に特別な振る舞いを持たせたい場合に使用する。カンマ区切りで複数指定可',
	`allowed_api` VARCHAR(100)  NOT NULL COMMENT '使用許可APIコード API(モジュール)毎に3桁の値を定義(ハードコード)し使用する。カンマ区切りで複数指定可',
	`secret_key` VARCHAR(40)  NOT NULL COMMENT 'シークレットキー',
	`status` TINYINT default 0 NOT NULL COMMENT 'ステータス (0:有効 1:無効 9:削除)',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`api_system_code`),
	KEY `index_status`(`status`)
) COMMENT='外部連携システム';

#-----------------------------------------------------------------------------
#-- api_system_ip
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `api_system_ip`;


CREATE TABLE `api_system_ip`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	`api_system_code` VARCHAR(5)  NOT NULL COMMENT 'API連携システム識別コード',
	`ip` VARCHAR(39)  NOT NULL COMMENT 'IP',
	`status` TINYINT default 0 NOT NULL COMMENT 'ステータス (0:有効 1:無効 9:削除)',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	KEY `index_status`(`status`),
	INDEX `api_system_ip_FI_1` (`api_system_code`)
) COMMENT='外部連携システムIP';

#-----------------------------------------------------------------------------
#-- member_editable_column
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `member_editable_column`;


CREATE TABLE `member_editable_column`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	`member_id` INTEGER  NOT NULL COMMENT '会員ID',
	`column_name` VARCHAR(20)  NOT NULL COMMENT '編集可能項目名',
	`status` TINYINT default 0 NOT NULL COMMENT 'ステータス (0:有効 9:削除)',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	KEY `index_status`(`status`)
) COMMENT='会員情報編集可能項目 通常は編集不可の項目を限定的に編集可とさせる場合に登録する';

#-----------------------------------------------------------------------------
#-- affiliate_redirect_log
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `affiliate_redirect_log`;


CREATE TABLE `affiliate_redirect_log`
(
	`id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT 'ID',
	`media_rep_id` INTEGER  NOT NULL COMMENT 'アフィリエイト業者区分',
	`request_method` VARCHAR(255) COMMENT 'リクエストメソッド',
	`request_protocol` VARCHAR(255) COMMENT 'リクエスプロトコル',
	`request_host` VARCHAR(255) COMMENT 'リクエスホスト',
	`request_uri` VARCHAR(255) COMMENT 'リクエストURI',
	`request_query_string` VARCHAR(1000) COMMENT 'タリクエストクエリーストリング',
	`redirect_param_1` VARCHAR(255) COMMENT '受信パラメータ1',
	`redirect_param_2` VARCHAR(255) COMMENT '受信パラメータ2',
	`redirect_param_3` VARCHAR(255) COMMENT '受信パラメータ3',
	`redirect_param_4` VARCHAR(255) COMMENT '受信パラメータ4',
	`redirect_param_5` VARCHAR(255) COMMENT '受信パラメータ5',
	`redirect_param_6` VARCHAR(255) COMMENT '受信パラメータ6',
	`redirect_param_7` VARCHAR(255) COMMENT '受信パラメータ7',
	`redirect_param_8` VARCHAR(255) COMMENT '受信パラメータ8',
	`redirect_param_9` VARCHAR(255) COMMENT '受信パラメータ9',
	`redirect_param_10` VARCHAR(255) COMMENT '受信パラメータ10',
	`redirect_param_11` VARCHAR(255) COMMENT '受信パラメータ11',
	`redirect_param_12` VARCHAR(255) COMMENT '受信パラメータ12',
	`redirect_param_13` VARCHAR(255) COMMENT '受信パラメータ13',
	`redirect_param_14` VARCHAR(255) COMMENT '受信パラメータ14',
	`redirect_param_15` VARCHAR(255) COMMENT '受信パラメータ15',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	KEY `index_media_rep_id`(`media_rep_id`)
) COMMENT='アフィリエイトリダイレクトログ';

#-----------------------------------------------------------------------------
#-- affiliate_result_send_log
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `affiliate_result_send_log`;


CREATE TABLE `affiliate_result_send_log`
(
	`id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT 'ID',
	`member_id` INTEGER  NOT NULL COMMENT '会員ID',
	`pay_member_id` BIGINT  NOT NULL COMMENT '有料サービス認証状態ID',
	`option_type` INTEGER(8)  NOT NULL COMMENT '有料オプション種別 0:クーポンボックス1:EPARKコンシェル',
	`media_rep_id` INTEGER  NOT NULL COMMENT 'アフィリエイト業者区分',
	`result_id` VARCHAR(255)  NOT NULL COMMENT '成果区分',
	`send_param_text` VARCHAR(1000) COMMENT '送信パラメータテキスト',
	`send_param_1` VARCHAR(255) COMMENT '送信パラメータ1',
	`send_param_2` VARCHAR(255) COMMENT '送信パラメータ2',
	`send_param_3` VARCHAR(255) COMMENT '送信パラメータ3',
	`send_param_4` VARCHAR(255) COMMENT '送信パラメータ4',
	`send_param_5` VARCHAR(255) COMMENT '送信パラメータ5',
	`send_param_6` VARCHAR(255) COMMENT '送信パラメータ6',
	`send_param_7` VARCHAR(255) COMMENT '送信パラメータ7',
	`send_param_8` VARCHAR(255) COMMENT '送信パラメータ8',
	`send_param_9` VARCHAR(255) COMMENT '送信パラメータ9',
	`send_param_10` VARCHAR(255) COMMENT '送信パラメータ10',
	`send_param_11` VARCHAR(255) COMMENT '送信パラメータ11',
	`send_param_12` VARCHAR(255) COMMENT '送信パラメータ12',
	`send_param_13` VARCHAR(255) COMMENT '送信パラメータ13',
	`send_param_14` VARCHAR(255) COMMENT '送信パラメータ14',
	`send_param_15` VARCHAR(255) COMMENT '送信パラメータ15',
	`return_code` VARCHAR(255) COMMENT 'リターンコード',
	`return_message` VARCHAR(1000) COMMENT 'リターンメッセージ',
	`sub_field_1` VARCHAR(255) COMMENT '補助項目1',
	`sub_field_2` VARCHAR(255) COMMENT '補助項目2',
	`sub_field_3` VARCHAR(255) COMMENT '補助項目3',
	`sub_field_4` VARCHAR(255) COMMENT '補助項目4',
	`sub_field_5` VARCHAR(255) COMMENT '補助項目5',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	KEY `index_member_id`(`member_id`),
	KEY `index_pay_member_id`(`pay_member_id`),
	KEY `index_media_rep_id`(`media_rep_id`)
) COMMENT='アフィリエイト成果送信ログ';

#-----------------------------------------------------------------------------
#-- cash_register_master
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `cash_register_master`;


CREATE TABLE `cash_register_master`
(
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID',
	`buttons` INTEGER default 9 NOT NULL COMMENT '画面ボタン数',
	`oneshot` TINYINT  NOT NULL COMMENT '精算ボタンスキップ 0精算 1スキップ',
	`d_message` TEXT COMMENT '券売メニュー画面デフォルトメッセージ',
	`waitback` SMALLINT default 30 COMMENT '予約画面自動戻り秒',
	`waitprint` SMALLINT UNSIGNED default 10 COMMENT '印刷画面表示秒',
	`waitexit` SMALLINT default 0 COMMENT '終了画面表示秒',
	`reserv_url` TEXT COMMENT '予約画面URL',
	`sod_password` VARCHAR(255) COMMENT '起動時パスワード',
	`err_password` VARCHAR(255) COMMENT '障害画面パスワード',
	`eod_password` VARCHAR(255) COMMENT 'レジ閉めパスワード',
	`rsv_cutmethod` TINYINT default 2 COMMENT '引換券カット方法',
	`rsv_message` TEXT COMMENT '引換券メッセージ',
	`rsv_align` VARCHAR(2) COMMENT '引換券揃え',
	`rsv_QR` TEXT COMMENT '引換券QR-URL(使用しない）',
	`rsv_model` TINYINT default 2 COMMENT '引換券QRモデル',
	`rsv_cels` TINYINT COMMENT '引換券QRセル数',
	`rsv_level` CHAR default 'H' COMMENT '引換券QRレベル',
	`rsv_QR_message` TEXT COMMENT '引換券QRメッセージ',
	`rct_cutmethod` TINYINT default 2 COMMENT '領収書カット方法',
	`rct_message` TEXT COMMENT '領収書メッセージ',
	`rct_align` VARCHAR(2) COMMENT '領収書揃え',
	`rct_QR` TEXT COMMENT '領収書QR-URL(使用しない）',
	`rct_model` TINYINT default 2 COMMENT '領収書QRモデル',
	`rct_cels` TINYINT COMMENT '領収書QRセル数',
	`rct_level` CHAR default 'H' COMMENT '領収書QRレベル',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`shop_id`)
) COMMENT='券売機店舗マスター';

#-----------------------------------------------------------------------------
#-- cash_register_terminals
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `cash_register_terminals`;


CREATE TABLE `cash_register_terminals`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT COMMENT '自動連番ID',
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID',
	`serial_name` VARCHAR(16) COMMENT '端末シリアル名',
	`sftp_host` VARCHAR(255),
	`sftp_port` SMALLINT,
	`sftp_user` VARCHAR(255),
	`sftp_pwd` VARCHAR(255),
	`sftp_root` VARCHAR(255),
	`public_key` TEXT,
	`private_key` TEXT,
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	INDEX `cash_register_terminals_FI_1` (`shop_id`)
) COMMENT='券売機端末設定';

#-----------------------------------------------------------------------------
#-- cash_register_st_rawlog
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `cash_register_st_rawlog`;


CREATE TABLE `cash_register_st_rawlog`
(
	`id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT '自動連番ID',
	`terminal_id` INTEGER  NOT NULL COMMENT '券売機端末ID',
	`sdtime` DATETIME COMMENT '記録日時',
	`rectype` TINYINT COMMENT 'レコードタイプ',
	`code` INTEGER UNSIGNED,
	`amount` SMALLINT,
	`created_at` DATETIME,
	PRIMARY KEY (`id`),
	INDEX `cash_register_st_rawlog_FI_1` (`terminal_id`)
) COMMENT='券売機日別売り上げログ';

#-----------------------------------------------------------------------------
#-- cash_register_rt_rawlog
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `cash_register_rt_rawlog`;


CREATE TABLE `cash_register_rt_rawlog`
(
	`id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT '自動連番ID',
	`terminal_id` INTEGER  NOT NULL COMMENT '券売機端末ID',
	`ldtime` DATETIME COMMENT '記録日時',
	`rectype` TINYINT COMMENT 'レコードタイプ',
	`tr_num` INTEGER UNSIGNED,
	`tr_offset` SMALLINT UNSIGNED,
	`col1` VARCHAR(10),
	`col2` VARCHAR(32),
	`col3` VARCHAR(10),
	`col4` VARCHAR(10),
	`col5` VARCHAR(10),
	`created_at` DATETIME,
	PRIMARY KEY (`id`),
	INDEX `cash_register_rt_rawlog_FI_1` (`terminal_id`)
) COMMENT='券売機リアルタイム売り上げログ';

#-----------------------------------------------------------------------------
#-- cash_register_items
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `cash_register_items`;


CREATE TABLE `cash_register_items`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT COMMENT '自動連番ID',
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID',
	`name` VARCHAR(255) COMMENT '商品名',
	`price` SMALLINT COMMENT '価格',
	`taxtype` VARCHAR(1) COMMENT '税区分',
	`sort` SMALLINT COMMENT '並び順',
	`itemphoto` VARCHAR(255) COMMENT '商品写真',
	`before_backcolor` VARCHAR(7) default '#0033ff' COMMENT '選択前背景色',
	`before_forecolor` VARCHAR(7) default '#ffffff' COMMENT '選択前文字色',
	`after_backcolor` VARCHAR(7) default '#0033ff' COMMENT '選択後背景色',
	`after_forecolor` VARCHAR(7) default '#ffffff' COMMENT '選択後文字色',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	INDEX `cash_register_items_FI_1` (`shop_id`)
) COMMENT='券売機商品マスター';

#-----------------------------------------------------------------------------
#-- receive_aggregation
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `receive_aggregation`;


CREATE TABLE `receive_aggregation`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT COMMENT 'ID',
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID',
	`receive_month` CHAR(7)  NOT NULL COMMENT '予約月 予約があった月',
	`week_day` TINYINT  NOT NULL COMMENT '曜日 0:月曜日～6:日曜日',
	`hour` TINYINT  NOT NULL COMMENT '時間 予約があった時間帯',
	`receive_count` INTEGER  NOT NULL COMMENT '件数 店舗別、時間帯別の件数',
	`new_flag` TINYINT default 1 COMMENT '最新フラグ 0:過去,1:最新',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	UNIQUE KEY `unique_receive_aggregation` (`id`),
	KEY `index_receive_aggregation_shop_id`(`shop_id`)
) COMMENT='予約情報集計 店舗別、時間帯別に予約件数を集計した結果を格納するテーブル。';

#-----------------------------------------------------------------------------
#-- interlocking_seat_group
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `interlocking_seat_group`;


CREATE TABLE `interlocking_seat_group`
(
	`id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT 'ID',
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID',
	`group_no` TINYINT default 0 NOT NULL COMMENT 'グループNO',
	`group_name` VARCHAR(20) COMMENT 'グループ名称',
	`status` TINYINT default 1 NOT NULL COMMENT 'ステータス 1: 運用中, 2: 停止中, 3: 削除済',
	`wait_count` SMALLINT default 0 NOT NULL COMMENT '待ち人数',
	`wait_time` SMALLINT default 0 NOT NULL COMMENT '待ち時間',
	`earliest_service_employee_id` BIGINT COMMENT '最短接客担当者ID',
	`earliest_service_booth_id` BIGINT COMMENT '最短接客ブースID',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	KEY `index_shop_id`(`shop_id`),
	INDEX `interlocking_seat_group_FI_2` (`earliest_service_employee_id`),
	INDEX `interlocking_seat_group_FI_3` (`earliest_service_booth_id`)
) COMMENT='席連動グループ';

#-----------------------------------------------------------------------------
#-- interlocking_seat_employee_group
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `interlocking_seat_employee_group`;


CREATE TABLE `interlocking_seat_employee_group`
(
	`id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT 'ID',
	`group_id` BIGINT  NOT NULL COMMENT '席連動グループID',
	`employee_id` BIGINT  NOT NULL COMMENT '席連動担当者ID',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	UNIQUE KEY `uq_interlocking_seat_employee_group` (`group_id`, `employee_id`),
	INDEX `interlocking_seat_employee_group_FI_2` (`employee_id`)
) COMMENT='席連動担当者グループ関連';

#-----------------------------------------------------------------------------
#-- interlocking_seat_booth
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `interlocking_seat_booth`;


CREATE TABLE `interlocking_seat_booth`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	`shop_id` BIGINT  NOT NULL COMMENT '店舗ID',
	`name` VARCHAR(40)  NOT NULL COMMENT 'ブース名',
	`name_kana` VARCHAR(80)  NOT NULL COMMENT 'ブース名(かな)',
	`counter_no` BIGINT  NOT NULL COMMENT 'カウンターNO',
	`start_with` TINYINT  NOT NULL COMMENT '検索用カラム 0:あ行 1:か行 2:さ行 3:た行 4:な行 5:は行 6:ま行 7:や行 8:ら行 9:わ行',
	`status` TINYINT default 1 NOT NULL COMMENT 'ステータス 1: 有効 2: 無効',
	`department_id` BIGINT COMMENT '対応中業務ID',
	`service_start_time` DATETIME COMMENT '接客開始日時',
	`wait_time` SMALLINT default 0 NOT NULL COMMENT '担当者待ち時間',
	`delayed` TINYINT default 1 NOT NULL COMMENT '遅延フラグ 1:遅延なし 2:遅延中',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	KEY `index_shop_id`(`shop_id`),
	INDEX `interlocking_seat_booth_FI_2` (`department_id`)
) COMMENT='席連動ブース';

#-----------------------------------------------------------------------------
#-- interlocking_seat_booth_group
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `interlocking_seat_booth_group`;


CREATE TABLE `interlocking_seat_booth_group`
(
	`id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT 'ID',
	`booth_id` BIGINT  NOT NULL COMMENT 'ブースID',
	`group_id` BIGINT  NOT NULL COMMENT 'グループID',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	UNIQUE KEY `uq_interlocking_seat_booth_group` (`group_id`, `booth_id`),
	INDEX `interlocking_seat_booth_group_FI_1` (`booth_id`)
) COMMENT='席連動ブース部門関連';

#-----------------------------------------------------------------------------
#-- interlocking_seat_receive
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `interlocking_seat_receive`;


CREATE TABLE `interlocking_seat_receive`
(
	`id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT 'ID',
	`receive_id` BIGINT COMMENT '予約ID',
	`watch_over_no` TINYINT default 0 NOT NULL COMMENT 'みまもり番号',
	`all_wait_count` SMALLINT default 0 NOT NULL COMMENT '全体の順待ち順',
	`reserve_time` DATETIME COMMENT '予約日時',
	`calling_flg` TINYINT COMMENT '呼び出し中フラグ 1:呼出中 2:通常状態',
	`lock_session` VARCHAR(255) COMMENT 'ロック中セッションID',
	`lockstart_time` DATETIME COMMENT 'ロック開始日時',
	`wait_order` INTEGER default 0 NOT NULL COMMENT '待ち順番 予約時に1000単位でインクリメント。「保留」「キャンセル」を解除する場合はこの値を調節して戻す。',
	`waiting_employee_id` BIGINT COMMENT '順番待ち担当者ID',
	`waiting_booth_id` BIGINT COMMENT '順番待ちブースID',
	`service_end_agenda_time` DATETIME COMMENT '接客完了予定日時',
	`cancel_time` DATETIME COMMENT 'キャンセル日時',
	`cancel_awake_time` DATETIME COMMENT 'キャンセル復活日時',
	`suspend_time` DATETIME COMMENT '保留日時',
	`suspend_awake_time` DATETIME COMMENT '保留解除日時',
	`call_date1` DATETIME COMMENT '呼び出し日時1',
	`call_date2` DATETIME COMMENT '呼び出し日時2',
	`revision` INTEGER default 1 NOT NULL COMMENT '改訂版号',
	`alert_at_service` TINYINT default 2 NOT NULL COMMENT '接客開始時アラート表示フラグ 1:表示，2:非表示',
	`member_call_time` DATETIME COMMENT '会員呼び出し日時',
	`booth_id` BIGINT COMMENT 'ブースID',
	`svc_chm_stop_flg` TINYINT default 0 COMMENT '接客中チャイム停止フラグ 1:停止',
	`created_at` DATETIME COMMENT 'レコード作成日時',
	`updated_at` DATETIME COMMENT 'レコード更新日時',
	PRIMARY KEY (`id`),
	KEY `index_receive_id`(`receive_id`),
	INDEX `interlocking_seat_receive_FI_2` (`waiting_employee_id`),
	INDEX `interlocking_seat_receive_FI_3` (`waiting_booth_id`)
) COMMENT='当日分の予約受付データの格納テーブル';

#-----------------------------------------------------------------------------
#-- interlocking_seat_receive_history
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `interlocking_seat_receive_history`;


CREATE TABLE `interlocking_seat_receive_history`
(
	`id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT 'ID',
	`receive_id` BIGINT COMMENT '予約ID',
	`watch_over_no` TINYINT default 0 NOT NULL COMMENT 'みまもり番号',
	`all_wait_count` SMALLINT default 0 NOT NULL COMMENT '全体の順待ち順',
	`reserve_time` DATETIME COMMENT '予約日時',
	`calling_flg` TINYINT COMMENT '呼び出し中フラグ 1:呼出中 2:通常状態',
	`lock_session` VARCHAR(255) COMMENT 'ロック中セッションID',
	`lockstart_time` DATETIME COMMENT 'ロック開始日時',
	`wait_order` INTEGER default 0 NOT NULL COMMENT '待ち順番 予約時に1000単位でインクリメント。「保留」「キャンセル」を解除する場合はこの値を調節して戻す。',
	`waiting_employee_id` BIGINT COMMENT '順番待ち担当者ID',
	`waiting_booth_id` BIGINT COMMENT '順番待ちブースID',
	`service_end_agenda_time` DATETIME COMMENT '接客完了予定日時',
	`cancel_time` DATETIME COMMENT 'キャンセル日時',
	`cancel_awake_time` DATETIME COMMENT 'キャンセル復活日時',
	`suspend_time` DATETIME COMMENT '保留日時',
	`suspend_awake_time` DATETIME COMMENT '保留解除日時',
	`call_date1` DATETIME COMMENT '呼び出し日時1',
	`call_date2` DATETIME COMMENT '呼び出し日時2',
	`revision` INTEGER default 1 NOT NULL COMMENT '改訂版号',
	`alert_at_service` TINYINT default 2 NOT NULL COMMENT '接客開始時アラート表示フラグ 1:表示，2:非表示',
	`member_call_time` DATETIME COMMENT '会員呼び出し日時',
	`booth_id` BIGINT COMMENT 'ブースID',
	`created_at` DATETIME COMMENT 'レコード作成日時',
	`updated_at` DATETIME COMMENT 'レコード更新日時',
	PRIMARY KEY (`id`),
	KEY `index_receive_id`(`receive_id`),
	INDEX `interlocking_seat_receive_history_FI_1` (`waiting_employee_id`),
	INDEX `interlocking_seat_receive_history_FI_2` (`waiting_booth_id`)
) COMMENT='当日分の予約受付データの格納テーブル(バッチ処理で当日分から移動される。)';

#-----------------------------------------------------------------------------
#-- interlocking_seat_receive_schedule
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `interlocking_seat_receive_schedule`;


CREATE TABLE `interlocking_seat_receive_schedule`
(
	`id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT '自動生成プライマリキー',
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID',
	`department_id` BIGINT  NOT NULL COMMENT '部門ID',
	`target_datetime` DATETIME COMMENT '対象日時',
	`target_date` DATE COMMENT '対象日',
	`target_hour` TINYINT  NOT NULL COMMENT '対象時',
	`target_minute` TINYINT  NOT NULL COMMENT '対象分',
	`receive_start_count` INTEGER default 0 NOT NULL COMMENT '開始受付数',
	`receive_continue_count` INTEGER default 0 NOT NULL COMMENT '継続受付数',
	`reserve_start_count` INTEGER default 0 NOT NULL COMMENT '開始将来順番予約数',
	`reserve_continue_count` INTEGER default 0 NOT NULL COMMENT '継続将来順番予約数',
	`color` VARCHAR(10) default 'white' NOT NULL COMMENT '予約日時選択画面色分け用 white: 0件, blue: 1件以上、枠数未満, red: 枠数上限',
	`cancel_reserve_including` TINYINT default 2 NOT NULL COMMENT 'キャンセル猶予時間内の将来順番予約を含んでいるかどうか 1: 含んでいる 2: 含んでいない',
	`reserve_status` TINYINT default 1 NOT NULL COMMENT '将来順番予約可否 1: 許可 2: 不許可',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	UNIQUE KEY `uq_interlocking_seat_receive_schedule` (`shop_id`, `department_id`, `target_date`, `target_hour`, `target_minute`),
	INDEX `interlocking_seat_receive_schedule_FI_2` (`department_id`)
) COMMENT='席連動店舗予約スケジュール';

#-----------------------------------------------------------------------------
#-- interlocking_seat_receive_schedule_daily
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `interlocking_seat_receive_schedule_daily`;


CREATE TABLE `interlocking_seat_receive_schedule_daily`
(
	`id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT '自動生成プライマリキー',
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID',
	`department_id` BIGINT  NOT NULL COMMENT '部門ID',
	`target_date` DATE COMMENT '対象日',
	`reserve_count` INTEGER default 0 NOT NULL COMMENT '将来順番予約数',
	`color` VARCHAR(10) default 'white' NOT NULL COMMENT '予約日時選択画面色分け用 white: 0件, blue: 1件以上、枠数未満, red: 枠数上限',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	UNIQUE KEY `uq_interlocking_seat_receive_schedule_daily` (`shop_id`, `department_id`, `target_date`),
	INDEX `interlocking_seat_receive_schedule_daily_FI_2` (`department_id`)
) COMMENT='席連動店舗日別予約スケジュール';

#-----------------------------------------------------------------------------
#-- interlocking_seat_reserve_time
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `interlocking_seat_reserve_time`;


CREATE TABLE `interlocking_seat_reserve_time`
(
	`id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT '自動生成プライマリキー',
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID',
	`reserve_time` TIME  NOT NULL COMMENT '受付時間',
	`reserve_status` TINYINT default 1 NOT NULL COMMENT '将来順番予約可否 1: 許可 2: 不許可',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	UNIQUE KEY `uq_interlocking_reserve_time` (`shop_id`, `reserve_time`),
	KEY `index_shop_id`(`shop_id`)
) COMMENT='席連動将来順番予約可能時間';

#-----------------------------------------------------------------------------
#-- interlocking_seat_reserve_schedule
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `interlocking_seat_reserve_schedule`;


CREATE TABLE `interlocking_seat_reserve_schedule`
(
	`id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT '自動生成プライマリキー',
	`receive_id` BIGINT  NOT NULL COMMENT '予約ID',
	`employee_id` BIGINT  NOT NULL COMMENT '担当者ID',
	`booth_id` BIGINT  NOT NULL COMMENT 'ブースID',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	KEY `index_receive_id`(`receive_id`)
) COMMENT='席連動予約将来順番事前と担当者登録';

#-----------------------------------------------------------------------------
#-- interlocking_seat_reserve_immediate_schedule
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `interlocking_seat_reserve_immediate_schedule`;


CREATE TABLE `interlocking_seat_reserve_immediate_schedule`
(
	`receive_id` BIGINT  NOT NULL COMMENT '予約ID',
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID',
	`employee_id` BIGINT  NOT NULL COMMENT '担当者ID',
	`employee_name` VARCHAR(20)  NOT NULL COMMENT '担当者名',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`receive_id`,`shop_id`,`employee_id`),
	UNIQUE KEY `uniq_index` (`receive_id`, `shop_id`, `employee_id`)
) COMMENT='将来順番事前担当者複数登録';

#-----------------------------------------------------------------------------
#-- email_error_count
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `email_error_count`;


CREATE TABLE `email_error_count`
(
	`email` VARCHAR(255)  NOT NULL,
	`count` INTEGER  NOT NULL COMMENT 'エラー回数',
	`status` TINYINT  NOT NULL COMMENT '0:有効／1:無効',
	`error_type` TINYINT  NOT NULL COMMENT '1.userunknown/2.filtered',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	PRIMARY KEY (`id`)
) COMMENT='メールのエラー回数管理';

#-----------------------------------------------------------------------------
#-- shop_counts_midway_summary
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `shop_counts_midway_summary`;


CREATE TABLE `shop_counts_midway_summary`
(
	`xl_category_id` INTEGER  NOT NULL COMMENT '大々分類カテゴリ',
	`pref_id` INTEGER  NOT NULL COMMENT '都道府県ID',
	`category_id` INTEGER default 0 NOT NULL COMMENT 'カテゴリID',
	`city_id` INTEGER default 0 NOT NULL COMMENT '市区町村ID',
	`station_id` INTEGER default 0 NOT NULL COMMENT '駅ID',
	`genre_id` INTEGER default 0 NOT NULL COMMENT 'ジャンルID',
	`keyword_id` INTEGER default 0 NOT NULL COMMENT 'キーワードID',
	`count` INTEGER  NOT NULL COMMENT '店舗件数',
	`updated_at` DATE  NOT NULL COMMENT '更新日',
	PRIMARY KEY (`xl_category_id`,`pref_id`,`category_id`,`city_id`,`station_id`,`genre_id`,`keyword_id`),
	KEY `index_xl_category_id`(`xl_category_id`),
	KEY `index_pref_id`(`pref_id`),
	KEY `index_category_id`(`category_id`),
	KEY `index_city_id`(`city_id`),
	KEY `index_station_id`(`station_id`),
	KEY `index_genre_id`(`genre_id`),
	KEY `index_keyword_id`(`keyword_id`)
) COMMENT='店舗件数中間集計テーブル';

#-----------------------------------------------------------------------------
#-- creative_parts_questionnaire_full_answer
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `creative_parts_questionnaire_full_answer`;


CREATE TABLE `creative_parts_questionnaire_full_answer`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT COMMENT 'ID',
	`answer_id` INTEGER  NOT NULL COMMENT '投稿ID',
	`question_no` SMALLINT  NOT NULL COMMENT '設問NO',
	`question` VARCHAR(255) COMMENT '設問内容',
	`answer` TEXT COMMENT '回答',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	KEY `index_answer_id`(`answer_id`),
	KEY `index_question_no`(`question_no`)
) COMMENT='アンケート投稿テーブル';

#-----------------------------------------------------------------------------
#-- coupon_slot
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `coupon_slot`;


CREATE TABLE `coupon_slot`
(
	`coupon_slot_id` INTEGER  NOT NULL AUTO_INCREMENT,
	`coupon_slot_memo` VARCHAR(255)  NOT NULL COMMENT 'キャンペーン名（管理画面のみ使用）',
	`status` TINYINT  NOT NULL COMMENT '0:有効 1:無効',
	`coupon_slot_kind` TINYINT  NOT NULL COMMENT 'クーポンスロットの種類',
	`coupon_slot_start` DATETIME  NOT NULL COMMENT 'クーポンBOXクーポン期間（開始）の最大値',
	`coupon_slot_end` DATETIME  NOT NULL COMMENT 'クーポンBOXクーポン期間（終了）の最小値',
	`coupon_slot_limit_type` TINYINT  NOT NULL COMMENT 'daily, weekly, monthlyの期間',
	`coupon_slot_limit_count` INTEGER  NOT NULL COMMENT '指定期間中のクーポンスロット制限回数',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`coupon_slot_id`),
	KEY `index_coupon_slot_kind`(`coupon_slot_kind`, `status`),
	KEY `index_status`(`status`)
) COMMENT='クーポンスロットキャンペーンデータ';

#-----------------------------------------------------------------------------
#-- coupon_slot_box_data
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `coupon_slot_box_data`;


CREATE TABLE `coupon_slot_box_data`
(
	`coupon_box_id` INTEGER  NOT NULL,
	`coupon_slot_win_count` INTEGER  NOT NULL,
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`coupon_box_id`)
) COMMENT='該当クーポンBOXIDの当たり外れの数';

#-----------------------------------------------------------------------------
#-- coupon_slot_box_id_list
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `coupon_slot_box_id_list`;


CREATE TABLE `coupon_slot_box_id_list`
(
	`coupon_slot_id` INTEGER  NOT NULL,
	`coupon_box_id` INTEGER  NOT NULL,
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`coupon_slot_id`,`coupon_box_id`),
	KEY `index_coupon_box_id`(`coupon_box_id`)
) COMMENT='クーポンスロットに紐づくクーポンBOXID';

#-----------------------------------------------------------------------------
#-- coupon_slot_box_id_count
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `coupon_slot_box_id_count`;


CREATE TABLE `coupon_slot_box_id_count`
(
	`coupon_box_id` INTEGER  NOT NULL,
	`slot_count` INTEGER  NOT NULL,
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`coupon_box_id`)
) COMMENT='そのクーポンBOXIDでスロットが回った回数';

#-----------------------------------------------------------------------------
#-- coupon_slot_coupon
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `coupon_slot_coupon`;


CREATE TABLE `coupon_slot_coupon`
(
	`coupon_slot_coupon_id` INTEGER  NOT NULL AUTO_INCREMENT,
	`coupon_slot_id` INTEGER  NOT NULL,
	`coupon_box_id` INTEGER  NOT NULL COMMENT '当たるクーポンBOXID',
	`coupon_slot_odds` INTEGER  NOT NULL COMMENT '選択されやすさ',
	`coupon_slot_odds_type` TINYINT  NOT NULL COMMENT 'あたり、はずれ、特別などの種類',
	`coupon_slot_command` TINYINT  NOT NULL COMMENT 'スロットの図柄',
	`selected_count` INTEGER  NOT NULL COMMENT '選択された回数',
	`status` TINYINT  NOT NULL COMMENT '0:有効 1:無効',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`coupon_slot_coupon_id`),
	KEY `index_coupon_slot_id`(`coupon_slot_id`, `status`),
	KEY `index_coupon_box_id`(`coupon_box_id`, `status`)
) COMMENT='クーポンスロット確率設定';

#-----------------------------------------------------------------------------
#-- coupon_slot_history
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `coupon_slot_history`;


CREATE TABLE `coupon_slot_history`
(
	`member_id` INTEGER  NOT NULL,
	`coupon_slot_id` INTEGER  NOT NULL,
	`coupon_slot_time` INTEGER  NOT NULL COMMENT 'スロットを回した日 unixtimestamp',
	`coupon_slot_count` INTEGER  NOT NULL COMMENT 'その日に回した回数',
	`coupon_slot_win_count` INTEGER  NOT NULL COMMENT 'その日に当たった回数',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`member_id`,`coupon_slot_id`,`coupon_slot_time`),
	KEY `index_coupon_slot_time`(`coupon_slot_time`),
	KEY `index_member_id`(`member_id`, `coupon_slot_time`),
	KEY `index_coupon_slot_id`(`coupon_slot_id`, `coupon_slot_time`)
) COMMENT='クーポンスロット履歴';

#-----------------------------------------------------------------------------
#-- coupon_slot_history_month
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `coupon_slot_history_month`;


CREATE TABLE `coupon_slot_history_month`
(
	`coupon_slot_id` INTEGER  NOT NULL,
	`coupon_slot_time` INTEGER  NOT NULL COMMENT 'スロットを回した月 unixtimestamp',
	`coupon_slot_count` INTEGER  NOT NULL COMMENT 'その月に回した回数',
	`coupon_slot_win_count` INTEGER  NOT NULL COMMENT 'その月に当たった回数',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`coupon_slot_id`,`coupon_slot_time`),
	KEY `index_coupon_slot_time`(`coupon_slot_time`)
) COMMENT='レポート用 月別クーポンスロット履歴';

#-----------------------------------------------------------------------------
#-- coupon_slot_non_member_history
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `coupon_slot_non_member_history`;


CREATE TABLE `coupon_slot_non_member_history`
(
	`non_member_id` VARCHAR(255)  NOT NULL,
	`coupon_slot_id` INTEGER  NOT NULL,
	`coupon_slot_time` INTEGER  NOT NULL COMMENT 'スロットを回した日 unixtimestamp',
	`coupon_slot_count` INTEGER  NOT NULL COMMENT 'その日に回した回数',
	`coupon_slot_win_count` INTEGER  NOT NULL COMMENT 'その日に当たった回数',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`non_member_id`,`coupon_slot_id`,`coupon_slot_time`),
	KEY `index_coupon_slot_time`(`coupon_slot_time`),
	KEY `index_coupon_slot_id`(`coupon_slot_id`, `coupon_slot_time`)
) COMMENT='非会員クーポンスロット履歴';

#-----------------------------------------------------------------------------
#-- coupon_slot_non_member_history_month
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `coupon_slot_non_member_history_month`;


CREATE TABLE `coupon_slot_non_member_history_month`
(
	`coupon_slot_id` INTEGER  NOT NULL,
	`coupon_slot_time` INTEGER  NOT NULL COMMENT 'スロットを回した月 unixtimestamp',
	`coupon_slot_count` INTEGER  NOT NULL COMMENT 'その月に回した回数',
	`coupon_slot_win_count` INTEGER  NOT NULL COMMENT 'その月に当たった回数',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`coupon_slot_id`,`coupon_slot_time`),
	KEY `index_coupon_slot_time`(`coupon_slot_time`)
) COMMENT='レポート用 月別非会員クーポンスロット履歴';

#-----------------------------------------------------------------------------
#-- coupon_slot_member
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `coupon_slot_member`;


CREATE TABLE `coupon_slot_member`
(
	`coupon_slot_member_id` INTEGER  NOT NULL AUTO_INCREMENT,
	`member_id` INTEGER  NOT NULL,
	`use_status` TINYINT  NOT NULL COMMENT 'クーポンを使ったか',
	`coupon_slot_coupon_id` INTEGER  NOT NULL,
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`coupon_slot_member_id`),
	KEY `index_member_id`(`member_id`, `use_status`, `coupon_slot_coupon_id`),
	KEY `index_coupon_slot_coupon_id`(`coupon_slot_coupon_id`),
	KEY `index_use_status`(`use_status`)
) COMMENT='会員が持っているクーポンスロット用クーポン';

#-----------------------------------------------------------------------------
#-- coupon_slot_member_cache
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `coupon_slot_member_cache`;


CREATE TABLE `coupon_slot_member_cache`
(
	`member_id` INTEGER  NOT NULL,
	`coupon_count` INTEGER  NOT NULL,
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`member_id`)
) COMMENT='クーポンスロット用クーポン所持数キャッシュ';

#-----------------------------------------------------------------------------
#-- coupon_slot_non_member
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `coupon_slot_non_member`;


CREATE TABLE `coupon_slot_non_member`
(
	`coupon_slot_non_member_id` INTEGER  NOT NULL AUTO_INCREMENT,
	`non_member_id` VARCHAR(255)  NOT NULL,
	`added` TINYINT  NOT NULL COMMENT 'クーポン付与したか',
	`coupon_slot_coupon_id` INTEGER  NOT NULL,
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`coupon_slot_non_member_id`),
	KEY `index_member_id`(`non_member_id`, `added`),
	KEY `index_coupon_slot_coupon_id`(`coupon_slot_coupon_id`),
	KEY `index_added`(`added`)
) COMMENT='非会員スロット当選情報保持用テーブル';

#-----------------------------------------------------------------------------
#-- app_user_admins
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `app_user_admins`;


CREATE TABLE `app_user_admins`
(
	`id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT '自動生成プライマリキー',
	`username` VARCHAR(255) COMMENT 'ユーザー名',
	`password` VARCHAR(255) COMMENT 'パスワード',
	`is_deleted` TINYINT default 0 NOT NULL COMMENT '削除フラグ 0:有効データ 1：削除済 ',
	`deleted` DATETIME COMMENT '削除日時',
	`created` DATETIME COMMENT '作成日時',
	`modified` DATETIME,
	PRIMARY KEY (`id`)
) COMMENT='管理画面ユーザー設定';

#-----------------------------------------------------------------------------
#-- app_push_notifications
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `app_push_notifications`;


CREATE TABLE `app_push_notifications`
(
	`id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT '自動生成プライマリキー',
	`subject` VARCHAR(255) COMMENT 'タイトル',
	`message` VARCHAR(255) COMMENT 'メッセージ',
	`url` VARCHAR(255) COMMENT 'メッセージ',
	`send_start_date` DATETIME COMMENT '送信開始日時',
	`send_status` INTEGER default 0 COMMENT '送信状況 0:未送信, 1:送信中, 2:停止中, 8:送信完了',
	`last_sended_id` INTEGER COMMENT '送信済member_id',
	`is_delete` TINYINT default 0 NOT NULL COMMENT '削除フラグ',
	`deleted` DATETIME COMMENT '削除日時',
	`created` DATETIME COMMENT '作成日時',
	`modified` DATETIME,
	PRIMARY KEY (`id`)
) COMMENT='PUSH通知送信内容設定';

#-----------------------------------------------------------------------------
#-- interlocking_seat_reserve_service_schedule
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `interlocking_seat_reserve_service_schedule`;


CREATE TABLE `interlocking_seat_reserve_service_schedule`
(
	`id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT 'ID(自動生成)',
	`receive_id` BIGINT  NOT NULL COMMENT '予約ID',
	`employee_id` BIGINT  NOT NULL COMMENT '担当者ID',
	`booth_id` BIGINT  NOT NULL COMMENT 'ブースID',
	`service_time` INTEGER COMMENT '接客時間',
	`scheduled_service_start_time` DATETIME COMMENT '接客開始予定日時',
	`scheduled_service_end_time` DATETIME COMMENT '接客終了予定日時',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	KEY `index_receive_id`(`receive_id`)
) COMMENT='担当者ブース予約割当スケジュール';

#-----------------------------------------------------------------------------
#-- culture
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `culture`;


CREATE TABLE `culture`
(
	`culture_cd` VARCHAR(5)  NOT NULL COMMENT '言語コード',
	`name` VARCHAR(30)  NOT NULL COMMENT '言語名称',
	`display_order` TINYINT UNSIGNED  NOT NULL COMMENT '表示順序',
	PRIMARY KEY (`culture_cd`),
	KEY `index_display_order`(`display_order`)
) COMMENT='言語マスタ';

#-----------------------------------------------------------------------------
#-- taberepo_notify_mail_address
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `taberepo_notify_mail_address`;


CREATE TABLE `taberepo_notify_mail_address`
(
	`id` INTEGER(8)  NOT NULL AUTO_INCREMENT COMMENT '自動生成プライマリキー',
	`notify_mail_address` VARCHAR(255)  NOT NULL COMMENT '対EPARK通知先メールアドレス',
	PRIMARY KEY (`id`)
) COMMENT='Eネ！レポート通知機能 通知先メールアドレス';

#-----------------------------------------------------------------------------
#-- admin_role
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `admin_role`;


CREATE TABLE `admin_role`
(
	`id` INTEGER(8)  NOT NULL AUTO_INCREMENT COMMENT '自動生成プライマリキー',
	`name` VARCHAR(30) COMMENT 'ロール名',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`)
) COMMENT='総合管理 ロール権限';

#-----------------------------------------------------------------------------
#-- admin_role_page
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `admin_role_page`;


CREATE TABLE `admin_role_page`
(
	`id` INTEGER(8)  NOT NULL AUTO_INCREMENT COMMENT '自動生成プライマリキー',
	`admin_role_id` INTEGER,
	`admin_page_id` INTEGER  NOT NULL,
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	INDEX `admin_role_page_FI_1` (`admin_role_id`),
	INDEX `admin_role_page_FI_2` (`admin_page_id`)
) COMMENT='総合管理 ロール権限ページ';

#-----------------------------------------------------------------------------
#-- shop_to_member
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `shop_to_member`;


CREATE TABLE `shop_to_member`
(
	`id` INTEGER(8)  NOT NULL AUTO_INCREMENT COMMENT '店頭登録会員ID',
	`member_id` INTEGER(8) COMMENT 'EPARK_ID',
	`entry_shop_id` INTEGER(8)  NOT NULL COMMENT '登録店舗ID',
	`member_type` VARCHAR(2) COMMENT '会員種別',
	`name` VARCHAR(40) COMMENT '氏名',
	`tel` VARCHAR(20)  NOT NULL COMMENT '電話番号',
	`member_act_flg` TINYINT default 0 NOT NULL COMMENT '会員運用状況 0：運用中 1：運用停止',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	KEY `index_shop_to_member_id`(`id`),
	KEY `index_shop_to_member_tel`(`tel`),
	INDEX `shop_to_member_FI_1` (`entry_shop_id`)
) COMMENT='調剤薬局店舗登録会員テーブル';

#-----------------------------------------------------------------------------
#-- receive_telreserve
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `receive_telreserve`;


CREATE TABLE `receive_telreserve`
(
	`receive_id` BIGINT  NOT NULL COMMENT 'receiveテーブルのidと紐づいている',
	`receive_tel_number` VARCHAR(100)  NOT NULL COMMENT '予約者の電話番号',
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID（あえて冗長）',
	`status` TINYINT default 0 NOT NULL COMMENT '運用状況 0：運用中 1：運用停止 2：削除済み',
	`tel_type` TINYINT default 0 COMMENT '電話番号タイプ 0:通知可 1:固定電話により通知不可',
	`callbtn_count` TINYINT default 0 COMMENT '順番待ちCallボタン通知回数',
	`servingbtn_count` TINYINT default 0 COMMENT '接客中Callボタン通知回数',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`receive_id`),
	KEY `index_receive_tel_number`(`receive_tel_number`),
	KEY `index_created_at`(`created_at`)
) COMMENT='電話予約サービスの電話番号';

#-----------------------------------------------------------------------------
#-- shop_telreserve
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `shop_telreserve`;


CREATE TABLE `shop_telreserve`
(
	`id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT 'プライマリキー',
	`status` TINYINT default 0 NOT NULL COMMENT '運用状況 0：運用中 1：運用停止 2：削除済み',
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID',
	`receive_tel_number` VARCHAR(100)  NOT NULL COMMENT '予約者の電話番号',
	`tel_type` TINYINT default 0 COMMENT '電話番号タイプ 0:通知可 1:固定電話により通知不可',
	`consent_dm` TINYINT default 0 COMMENT '0:未決定　1:送信同意　2:送信非同意 ※許諾取得の機能拡張しない限りは初期値が入るのみとなる',
	`created_at` DATETIME COMMENT 'レコード作成日時',
	`updated_at` DATETIME COMMENT 'レコード更新日時',
	PRIMARY KEY (`id`),
	UNIQUE KEY `shop_id_receive_tel_number_uniq` (`shop_id`, `receive_tel_number`),
	KEY `index_created_at`(`created_at`)
) COMMENT='電話予約サービスの店舗別電話番号管理';

#-----------------------------------------------------------------------------
#-- receive_telreserve_history
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `receive_telreserve_history`;


CREATE TABLE `receive_telreserve_history`
(
	`receive_id` BIGINT  NOT NULL COMMENT 'receiveテーブルのidと紐づいている',
	`receive_tel_number` VARCHAR(100)  NOT NULL COMMENT '予約者の電話番号',
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID（あえて冗長）',
	`status` TINYINT default 0 NOT NULL COMMENT '運用状況 0：運用中 1：運用停止 2：削除済み',
	`tel_type` TINYINT default 0 COMMENT '電話番号タイプ 0:通知可 1:固定電話により通知不可',
	`callbtn_count` TINYINT default 0 COMMENT '順番待ちCallボタン通知回数',
	`servingbtn_count` TINYINT default 0 COMMENT '接客中Callボタン通知回数',
	`original_created_at` DATETIME COMMENT '移動前の作成日時',
	`original_updated_at` DATETIME COMMENT '移動前の更新日時',
	`created_at` DATETIME COMMENT 'レコード作成日時',
	`updated_at` DATETIME COMMENT 'レコード更新日時',
	PRIMARY KEY (`receive_id`),
	KEY `index_receive_tel_number`(`receive_tel_number`),
	KEY `index_created_at`(`original_created_at`)
) COMMENT='電話予約サービスの電話番号管理履歴';

#-----------------------------------------------------------------------------
#-- receive_telreserve_sms_log
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `receive_telreserve_sms_log`;


CREATE TABLE `receive_telreserve_sms_log`
(
	`id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT 'ID',
	`status` TINYINT default 0 NOT NULL COMMENT '運用状況 0：運用中 1：運用停止 2：削除済み',
	`receive_id` BIGINT  NOT NULL COMMENT '予約ID',
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID（あえて冗長）',
	`call_type` TINYINT default 0 COMMENT '通知タイプ 0:N組前通知 1:順番待ちコールボタン 2:接客中コールボタン',
	`call_template_id` BIGINT COMMENT '呼び出しテンプレートID N組前通知の場合はテンプレートがない為値が入らない。コールボタンの場合は選択したテンプレートのIDが入る。',
	`transmission_status` TINYINT default 1 NOT NULL COMMENT '通信ステータス 1:通信中 2:完了',
	`result_status` TINYINT default 0 NOT NULL COMMENT '結果ステータス 0:未完了 1:正常 2:エラー終了 3:異常終了（タイムアウト等） 4:強制終了',
	`call_carrier` VARCHAR(50) COMMENT 'SMS送信API指定キャリア APIで必須項目ではないが、指定する仕様を施した折にその値を保存しておく',
	`api_message_id` VARCHAR(34) COMMENT 'メッセージID SMS送信APIから発行される状況問い合わせ用のユニークID',
	`request_api_status` SMALLINT COMMENT 'SMS送信APIステータス',
	`request_start_time` DATETIME COMMENT '送信要求開始日時',
	`request_end_time` DATETIME COMMENT '送信要求終了日時',
	`is_result_get` TINYINT default 1 NOT NULL COMMENT '結果取得継続フラグ 1:継続して必要 2:不要',
	`call_count` TINYINT default 0 NOT NULL COMMENT 'SMS結果取得API実行回数',
	`result_api_status` SMALLINT COMMENT 'SMS結果取得APIステータス',
	`result_start_time` DATETIME COMMENT '送信要求開始日時',
	`result_end_time` DATETIME COMMENT '送信要求終了日時',
	`sms_state_code` SMALLINT COMMENT 'SMS送信状態コード',
	`sms_send_date` DATETIME COMMENT 'SMS送信日付',
	`result_notified` TINYINT default 1 NOT NULL COMMENT '結果表示済みフラグ 1:未表示 2:表示済み',
	`created_at` DATETIME COMMENT 'レコード作成日時',
	`updated_at` DATETIME COMMENT 'レコード更新日時',
	PRIMARY KEY (`id`),
	KEY `index_receive_id`(`receive_id`),
	KEY `index_transmission_status`(`transmission_status`),
	KEY `index_result_status`(`result_status`),
	KEY `index_created_at`(`created_at`)
) COMMENT='電話予約サービスのSMS通知用API通信ログ管理';

#-----------------------------------------------------------------------------
#-- receive_telreserve_sms_log_history
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `receive_telreserve_sms_log_history`;


CREATE TABLE `receive_telreserve_sms_log_history`
(
	`id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT 'ID',
	`status` TINYINT default 0 NOT NULL COMMENT '運用状況 0：運用中 1：運用停止 2：削除済み',
	`receive_id` BIGINT  NOT NULL COMMENT '予約ID',
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID（あえて冗長）',
	`call_type` TINYINT default 0 COMMENT '通知タイプ 0:N組前通知 1:順番待ちコールボタン 2:接客中コールボタン',
	`call_template_id` BIGINT COMMENT '呼び出しテンプレートID N組前通知の場合はテンプレートがない為値が入らない。コールボタンの場合は選択したテンプレートのIDが入る。',
	`transmission_status` TINYINT default 1 NOT NULL COMMENT '通信ステータス 1:通信中 2:完了',
	`result_status` TINYINT default 0 NOT NULL COMMENT '結果ステータス 0:未完了 1:正常 2:エラー終了 3:異常終了（タイムアウト等） 4:強制終了',
	`call_carrier` VARCHAR(50) COMMENT 'SMS送信API指定キャリア APIで必須項目ではないが、指定する仕様を施した折にその値を保存しておく',
	`api_message_id` VARCHAR(34) COMMENT 'メッセージID SMS送信APIから発行される状況問い合わせ用のユニークID',
	`request_api_status` SMALLINT COMMENT 'SMS送信APIステータス',
	`request_start_time` DATETIME COMMENT '送信要求開始日時',
	`request_end_time` DATETIME COMMENT '送信要求終了日時',
	`is_result_get` TINYINT default 1 NOT NULL COMMENT '結果取得継続フラグ 1:継続して必要 2:不要',
	`call_count` TINYINT default 0 NOT NULL COMMENT 'SMS結果取得API実行回数',
	`result_api_status` SMALLINT COMMENT 'SMS結果取得APIステータス',
	`result_start_time` DATETIME COMMENT '送信要求開始日時',
	`result_end_time` DATETIME COMMENT '送信要求終了日時',
	`sms_state_code` SMALLINT COMMENT 'SMS送信状態コード',
	`sms_send_date` DATETIME COMMENT 'SMS送信日付',
	`result_notified` TINYINT default 1 NOT NULL COMMENT '結果表示済みフラグ 1:未表示 2:表示済み',
	`original_created_at` DATETIME COMMENT '移動前の作成日時',
	`original_updated_at` DATETIME COMMENT '移動前の更新日時',
	`created_at` DATETIME COMMENT 'レコード作成日時',
	`updated_at` DATETIME COMMENT 'レコード更新日時',
	PRIMARY KEY (`id`),
	KEY `index_receive_id`(`receive_id`),
	KEY `index_created_at`(`original_created_at`)
) COMMENT='電話予約サービスのSMS通知用API通信ログ管理履歴';

#-----------------------------------------------------------------------------
#-- call_mail_template
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `call_mail_template`;


CREATE TABLE `call_mail_template`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	`shop_id` BIGINT  NOT NULL COMMENT '店舗ID',
	`template_type` TINYINT default 1 NOT NULL COMMENT 'テンプレート種別 1:コールメール 2:QRコールメール 3:SMSメール',
	`template_name` VARCHAR(30)  NOT NULL COMMENT 'テンプレート名',
	`sender_name` VARCHAR(100) COMMENT '送信者名',
	`mail_subject` VARCHAR(200) COMMENT 'メールタイトル',
	`mail_contents` TEXT COMMENT 'メール内容',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	KEY `index_shop_id_template_type`(`shop_id`, `template_type`),
	KEY `index_shop_id`(`shop_id`)
) COMMENT='コールメール機能のメールテンプレート';

#-----------------------------------------------------------------------------
#-- i_bis_ctg_myshop
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `i_bis_ctg_myshop`;


CREATE TABLE `i_bis_ctg_myshop`
(
	`memship_app_id` INTEGER UNSIGNED  NOT NULL COMMENT '業種別会員ID',
	`myshop_no` INTEGER UNSIGNED  NOT NULL COMMENT 'マイショップ番号',
	`service_code` VARCHAR(8) COMMENT 'サービスコード',
	`shop_code` VARCHAR(32)  NOT NULL COMMENT '施設コード',
	`selected_shop` TINYINT default 1 NOT NULL COMMENT '選択店舗区分',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`memship_app_id`,`myshop_no`)
) COMMENT='業種別会員マイショップ情報';

#-----------------------------------------------------------------------------
#-- i_cb_checkin_time
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `i_cb_checkin_time`;


CREATE TABLE `i_cb_checkin_time`
(
	`cb_checkin_time_id` INTEGER(11) UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT 'チェックイン時間情報ID',
	`shop_id` INTEGER(11) UNSIGNED default 0 NOT NULL COMMENT '店舗ID',
	`group_id` INTEGER(11) UNSIGNED default 0 NOT NULL COMMENT 'グループID',
	`set_number_sts` TINYINT(3) UNSIGNED  NOT NULL COMMENT '設定パターン',
	`start_time1` TIME COMMENT '開始時間1',
	`end_time1` TIME COMMENT '終了時間1',
	`max_count1` TINYINT(3) UNSIGNED default 0 NOT NULL COMMENT 'チェックイン可能回数1',
	`start_time2` TIME COMMENT '開始時間2',
	`end_time2` TIME COMMENT '終了時間2',
	`max_count2` TINYINT(3) UNSIGNED default 0 NOT NULL COMMENT 'チェックイン可能回数2',
	`start_time3` TIME COMMENT '開始時間3',
	`end_time3` TIME COMMENT '終了時間3',
	`max_count3` TINYINT(3) UNSIGNED default 0 NOT NULL COMMENT 'チェックイン可能回数3',
	`all_time_flg` TINYINT(3) UNSIGNED default 0 NOT NULL COMMENT '24時間フラグ',
	`all_time_max_count` TINYINT(3) UNSIGNED default 0 NOT NULL COMMENT '24時間設定時チェックイン可能回数',
	`delete_flg` TINYINT(3) UNSIGNED default 0 NOT NULL COMMENT '削除フラグ',
	`create_user_id` INTEGER(11) UNSIGNED  NOT NULL COMMENT 'レコード作成者',
	`update_user_id` INTEGER(11) UNSIGNED  NOT NULL COMMENT 'レコード更新者',
	`created_at` DATETIME COMMENT 'レコード作成年月日',
	`updated_at` DATETIME COMMENT 'レコード更新年月日',
	PRIMARY KEY (`cb_checkin_time_id`),
	UNIQUE KEY `i_cb_checkin_time_uniq` (`shop_id`, `group_id`, `set_number_sts`)
) COMMENT='チェックイン時間情報';

#-----------------------------------------------------------------------------
#-- i_ivr_user_setting
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `i_ivr_user_setting`;


CREATE TABLE `i_ivr_user_setting`
(
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID',
	`ivr_user_id` VARCHAR(10)  NOT NULL COMMENT 'IVRユーザーID',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`shop_id`)
) COMMENT='IVRユーザ設定';

#-----------------------------------------------------------------------------
#-- m_ivr_play_pttn_mst
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `m_ivr_play_pttn_mst`;


CREATE TABLE `m_ivr_play_pttn_mst`
(
	`ivr_play_pttn_id` INTEGER  NOT NULL AUTO_INCREMENT COMMENT 'IVR再生パターンID',
	`ivr_line_type` TINYINT  NOT NULL COMMENT 'IVRラインタイプ 0: 発信 1: 着信',
	`guide_status` TINYINT  NOT NULL COMMENT '案内状態 0: 順番待ち 1: 案内済 2: 不在 3: 無断キャンセル 4: 案内済再案内 5: 不在・無断キャンセル再案内 6: 接客中 7: 接客中再案内',
	`play_pttn_cd` VARCHAR(5)  NOT NULL COMMENT '再生パターンCD',
	`play_pttn_name` VARCHAR(20)  NOT NULL COMMENT '再生パターン名',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`ivr_play_pttn_id`),
	KEY `ix_m_ivr_play_pttn_mst_1`(`ivr_line_type`, `guide_status`)
) COMMENT='IVR再生パターンマスタ';

#-----------------------------------------------------------------------------
#-- i_ivr_play_setting
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `i_ivr_play_setting`;


CREATE TABLE `i_ivr_play_setting`
(
	`ivr_play_setting_id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT 'IVR再生設定ID',
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID',
	`ivr_line_type` TINYINT UNSIGNED  NOT NULL COMMENT 'IVRラインタイプ 0: 発信 1: 着信',
	`guide_status` TINYINT UNSIGNED  NOT NULL COMMENT '案内状態 0: 順番待ち 1: 案内済 2: 不在 3: 無断キャンセル 4: 案内済再案内 5: 不在・無断キャンセル再案内 6: 接客中 7: 接客中再案内',
	`play_pttn_cd` VARCHAR(5)  NOT NULL COMMENT '再生パターンCD',
	`play_cnt` TINYINT  NOT NULL COMMENT '再生回数',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`ivr_play_setting_id`),
	UNIQUE KEY `uix_i_ivr_play_setting_1` (`shop_id`, `ivr_line_type`, `guide_status`)
) COMMENT='IVR再生設定';

#-----------------------------------------------------------------------------
#-- m_dsgn_col
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `m_dsgn_col`;


CREATE TABLE `m_dsgn_col`
(
	`dsgn_col_id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT 'デザインカラーID',
	`dsgn_col_name` VARCHAR(32)  NOT NULL COMMENT 'デザインカラー名',
	`dsgn_ope_sts` TINYINT default 0 NOT NULL COMMENT 'デザインカラー運用状況区分',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`dsgn_col_id`)
) COMMENT='デザインカラーマスタ';

#-----------------------------------------------------------------------------
#-- h_grpmsg_hist
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `h_grpmsg_hist`;


CREATE TABLE `h_grpmsg_hist`
(
	`group_msg_id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT 'グループメッセージID',
	`group_id` INTEGER(11)  NOT NULL COMMENT 'グループID',
	`msg_ope_sts` TINYINT default 0 NOT NULL COMMENT 'メッセージ運用区分',
	`msg_send_sts` TINYINT default 0 NOT NULL COMMENT 'メッセージ送信区分',
	`msg_title` VARCHAR(58)  NOT NULL COMMENT 'メッセージタイトル',
	`msg_body` VARCHAR(256)  NOT NULL COMMENT 'メッセージ本文',
	`msg_send_sch_at` DATETIME  NOT NULL COMMENT 'メッセージ配信予定日時',
	`send_start_at` DATETIME COMMENT 'メッセージ送信開始時間',
	`send_end_at` DATETIME COMMENT 'メッセージ送信終了時間',
	`msg_send_num` INTEGER UNSIGNED COMMENT 'メッセージ配信数',
	`trgt_mem_type` TINYINT COMMENT '配信対象者の会員種別 0：すべて、1：EPARK会員のみ、2：業種別会員のみ',
	`trgt_sex_type` TINYINT COMMENT '配信対象者の性別 0：指定なし、1：男性、2：女性',
	`trgt_from_age` INTEGER(3) COMMENT '配信対象者の下限年齢',
	`trgt_to_age` INTEGER(3) COMMENT '配信対象者の上限年齢',
	`trgt_birth_month` SMALLINT COMMENT '配信対象者の誕生月',
	`trgt_birth_day` SMALLINT COMMENT '配信対象者の誕生日',
	`trgt_pref_id` INTEGER(11) COMMENT '配信対象者の都道府県ID',
	`trgt_phone_number` VARCHAR(20) COMMENT '配信対象者の携帯電話番号',
	`trgt_chg_startyear` INTEGER UNSIGNED COMMENT '配信対象者の機種変更_開始年',
	`trgt_chg_startmonth` TINYINT COMMENT '配信対象者の機種変更_開始月',
	`trgt_chg_startday` TINYINT COMMENT '配信対象者の機種変更_開始日',
	`trgt_chg_endyear` INTEGER UNSIGNED COMMENT '配信対象者の機種変更_終了年',
	`trgt_chg_endmonth` TINYINT COMMENT '配信対象者の機種変更_終了月',
	`trgt_chg_endday` TINYINT COMMENT '配信対象者の機種変更_終了日',
	`trgt_last_startyear` INTEGER UNSIGNED COMMENT '配信対象者の最終ログイン_開始年',
	`trgt_last_startmonth` TINYINT COMMENT '配信対象者の最終ログイン_開始月',
	`trgt_last_startday` TINYINT COMMENT '配信対象者の最終ログイン_開始日',
	`trgt_last_endyear` INTEGER UNSIGNED COMMENT '配信対象者の最終ログイン_終了年',
	`trgt_last_endmonth` TINYINT COMMENT '配信対象者の最終ログイン_終了月',
	`trgt_last_endday` TINYINT COMMENT '配信対象者の最終ログイン_終了日',
	`img_path` VARCHAR(255) COMMENT '画像ファイルのパス',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`group_msg_id`)
) COMMENT='グループメッセージ履歴';

#-----------------------------------------------------------------------------
#-- t_rcv_ds_reserv
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `t_rcv_ds_reserv`;


CREATE TABLE `t_rcv_ds_reserv`
(
	`reserv_id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT '来局予定ID',
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID',
	`reserv_name` VARCHAR(40) COMMENT '予約者氏名',
	`reserv_memo` VARCHAR(40) COMMENT '店舗予約メモ',
	`reserv_date` DATE  NOT NULL COMMENT '来局予定日',
	`reserv_sts` INTEGER default 1 COMMENT '来局予定状況',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`reserv_id`),
	INDEX `t_rcv_ds_reserv_FI_1` (`shop_id`)
) COMMENT='T_来局予定';

#-----------------------------------------------------------------------------
#-- i_shop_dsp_cnf
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `i_shop_dsp_cnf`;


CREATE TABLE `i_shop_dsp_cnf`
(
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID',
	`shop_dsp_type` TINYINT  NOT NULL COMMENT '1:「ブースを選択しない」項目の表示制御',
	`shop_dsp_status` TINYINT default 1 COMMENT '権限ステータス 0: 使用不可 1: 使用可',
	`created_at` DATETIME  NOT NULL COMMENT 'レコード作成日時',
	`updated_at` DATETIME  NOT NULL COMMENT 'レコード更新日時',
	PRIMARY KEY (`shop_id`,`shop_dsp_type`)
) COMMENT='I_店舗画面表示設定';

#-----------------------------------------------------------------------------
#-- mobile_push
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `mobile_push`;


CREATE TABLE `mobile_push`
(
	`id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT '自動生成プライマリキー',
	`member_id` INTEGER  NOT NULL COMMENT '会員ID',
	`device_token` VARCHAR(255)  NOT NULL COMMENT '端末トークン',
	`os_cd` TINYINT  NOT NULL COMMENT '端末種別 0:Android 1:iOS',
	`is_deleted` TINYINT default 0 NOT NULL COMMENT '削除フラグ 0:有効 1:削除',
	`endpoint_arn` VARCHAR(255)  NOT NULL COMMENT 'エンドポイントARN',
	`subscription_arn` VARCHAR(255)  NOT NULL COMMENT 'サブスクリプションARN',
	`created_at` DATETIME  NOT NULL COMMENT 'レコード作成日時',
	`updated_at` DATETIME  NOT NULL COMMENT 'レコード更新日時',
	PRIMARY KEY (`id`)
) COMMENT='モバイルPush通知テーブル';

#-----------------------------------------------------------------------------
#-- i_cb_mobile_push
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `i_cb_mobile_push`;


CREATE TABLE `i_cb_mobile_push`
(
	`cb_mobile_push_id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT '自動生成プライマリキー',
	`member_id` INTEGER  NOT NULL COMMENT '会員ID',
	`device_token` VARCHAR(255)  NOT NULL COMMENT '端末トークン',
	`os_cd` TINYINT  NOT NULL COMMENT '端末種別 0:Android 1:iOS',
	`is_deleted` TINYINT default 0 NOT NULL COMMENT '削除フラグ 0:有効 1:削除',
	`endpoint_arn` VARCHAR(255)  NOT NULL COMMENT 'エンドポイントARN',
	`subscription_arn` VARCHAR(255)  NOT NULL COMMENT 'サブスクリプションARN',
	`created_at` DATETIME  NOT NULL COMMENT 'レコード作成日時',
	`updated_at` DATETIME  NOT NULL COMMENT 'レコード更新日時',
	PRIMARY KEY (`cb_mobile_push_id`)
) COMMENT='モバイルPush通知テーブル';

#-----------------------------------------------------------------------------
#-- i_memship_app_conf
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `i_memship_app_conf`;


CREATE TABLE `i_memship_app_conf`
(
	`shop_id` INTEGER(11)  NOT NULL COMMENT '店舗ID',
	`group_msg_id` INTEGER UNSIGNED  NOT NULL COMMENT 'グループメッセージID',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`shop_id`,`group_msg_id`),
	INDEX `i_memship_app_conf_FI_2` (`group_msg_id`)
) COMMENT='グループメッセージ配信先店舗情報';

#-----------------------------------------------------------------------------
#-- h_shop_msg_hist
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `h_shop_msg_hist`;


CREATE TABLE `h_shop_msg_hist`
(
	`shop_msg_id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT 'ショップメッセージID',
	`shop_id` INTEGER(11)  NOT NULL COMMENT '店舗ID',
	`msg_ope_sts` TINYINT default 0 NOT NULL COMMENT 'メッセージ運用区分',
	`msg_send_sts` TINYINT default 0 NOT NULL COMMENT 'メッセージ送信区分',
	`msg_title` VARCHAR(58)  NOT NULL COMMENT 'メッセージタイトル',
	`msg_body` VARCHAR(256)  NOT NULL COMMENT 'メッセージ本文',
	`msg_send_sch_at` DATETIME  NOT NULL COMMENT 'メッセージ配信予定日時',
	`send_start_at` DATETIME COMMENT 'メッセージ送信開始時間',
	`send_end_at` DATETIME COMMENT 'メッセージ送信終了時間',
	`msg_send_num` INTEGER UNSIGNED COMMENT 'メッセージ配信数',
	`auth_sts` TINYINT default 0 NOT NULL COMMENT '承認状態',
	`trgt_mem_type` TINYINT COMMENT '配信対象者の会員種別 0：すべて、1：EPARK会員のみ、2：業種別会員のみ',
	`trgt_sex_type` TINYINT COMMENT '配信対象者の性別 0：指定なし、1：男性、2：女性',
	`trgt_from_age` INTEGER(3) COMMENT '配信対象者の下限年齢',
	`trgt_to_age` INTEGER(3) COMMENT '配信対象者の上限年齢',
	`trgt_birth_month` SMALLINT COMMENT '配信対象者の誕生月',
	`trgt_birth_day` SMALLINT COMMENT '配信対象者の誕生日',
	`trgt_pref_id` INTEGER(11) COMMENT '配信対象者の都道府県ID',
	`trgt_phone_number` VARCHAR(20) COMMENT '配信対象者の携帯電話番号',
	`trgt_chg_startyear` INTEGER UNSIGNED COMMENT '配信対象者の機種変更_開始年',
	`trgt_chg_startmonth` TINYINT COMMENT '配信対象者の機種変更_開始月',
	`trgt_chg_startday` TINYINT COMMENT '配信対象者の機種変更_開始日',
	`trgt_chg_endyear` INTEGER UNSIGNED COMMENT '配信対象者の機種変更_終了年',
	`trgt_chg_endmonth` TINYINT COMMENT '配信対象者の機種変更_終了月',
	`trgt_chg_endday` TINYINT COMMENT '配信対象者の機種変更_終了日',
	`trgt_last_startyear` INTEGER UNSIGNED COMMENT '配信対象者の最終ログイン_開始年',
	`trgt_last_startmonth` TINYINT COMMENT '配信対象者の最終ログイン_開始月',
	`trgt_last_startday` TINYINT COMMENT '配信対象者の最終ログイン_開始日',
	`trgt_last_endyear` INTEGER UNSIGNED COMMENT '配信対象者の最終ログイン_終了年',
	`trgt_last_endmonth` TINYINT COMMENT '配信対象者の最終ログイン_終了月',
	`trgt_last_endday` TINYINT COMMENT '配信対象者の最終ログイン_終了日',
	`img_path` VARCHAR(255) COMMENT '画像ファイルのパス',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`shop_msg_id`)
) COMMENT='店舗メッセージ履歴';

#-----------------------------------------------------------------------------
#-- business_cat_sys
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `business_cat_sys`;


CREATE TABLE `business_cat_sys`
(
	`business_cat_sys_id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT '業種別システム識別ID',
	`business_cat_name` VARCHAR(40) COMMENT '業種別システム名称',
	`business_cat_account` VARCHAR(20)  NOT NULL COMMENT '認証アカウント',
	`secret_key` VARCHAR(40)  NOT NULL COMMENT 'シークレットキー',
	`add_info` VARCHAR(30)  NOT NULL COMMENT '追加情報フィールド',
	`biz_cate_sts` TINYINT COMMENT '連携先運用状況区分',
	`ip_filter_flg` TINYINT default 0 COMMENT 'IPアドレス制御フラグ項目',
	`created_at` DATETIME  NOT NULL COMMENT '作成年月日 レコード作成年月日',
	`updated_at` DATETIME  NOT NULL COMMENT '更新年月日 レコード更新年月日',
	PRIMARY KEY (`business_cat_sys_id`)
) COMMENT='業種別システムマスタ';

#-----------------------------------------------------------------------------
#-- business_cat_member
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `business_cat_member`;


CREATE TABLE `business_cat_member`
(
	`business_cat_mem_id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT '業種別会員ID',
	`business_cat_sys_id` INTEGER UNSIGNED  NOT NULL COMMENT '業種別システム識別ID',
	`business_cat_mem_cd` VARCHAR(255)  NOT NULL COMMENT '業種別会員コード',
	`member_sts` TINYINT default 0 NOT NULL COMMENT '会員運用状況区分',
	`sha1_password` VARCHAR(40)  NOT NULL COMMENT 'ハッシュパスワード',
	`salt` VARCHAR(32)  NOT NULL COMMENT 'ハッシュ種',
	`sei_kanji` VARCHAR(40) COMMENT '会員漢字姓',
	`mei_kanji` VARCHAR(40) COMMENT '会員漢字名',
	`sei_kana` VARCHAR(40) COMMENT '会員かな姓',
	`mei_kana` VARCHAR(40) COMMENT '会員かな名',
	`email` VARCHAR(255) COMMENT '会員メールアドレス',
	`tel` VARCHAR(20) COMMENT '会員電話番号',
	`country_code` VARCHAR(5) COMMENT '会員国コード',
	`zip_no` VARCHAR(7) COMMENT '会員郵便番号',
	`pref_code` CHAR(2) COMMENT '都道府県コード',
	`address1` VARCHAR(120) COMMENT '会員住所1',
	`address2` VARCHAR(120) COMMENT '会員住所2',
	`sex` TINYINT COMMENT '会員性別区分',
	`birthyear` CHAR(4) COMMENT '会員生年',
	`birthmonth` CHAR(2) COMMENT '会員生月',
	`birthday` CHAR(2) COMMENT '会員生日',
	`memo` VARCHAR(255) COMMENT '備考フィールド',
	`created_at` DATETIME  NOT NULL COMMENT '作成年月日 レコード作成年月日',
	`updated_at` DATETIME  NOT NULL COMMENT '更新年月日 レコード更新年月日',
	PRIMARY KEY (`business_cat_mem_id`),
	UNIQUE KEY `business_cat_member_uniq` (`business_cat_sys_id`, `business_cat_mem_cd`),
	KEY `index_business_cat_member_api_system_code`(`business_cat_sys_id`)
) COMMENT='業種別会員テーブル';

#-----------------------------------------------------------------------------
#-- m_slct_cntnt
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `m_slct_cntnt`;


CREATE TABLE `m_slct_cntnt`
(
	`slct_cntnt_id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT '選択コンテンツID',
	`shop_category_id` INTEGER COMMENT '所属カテゴリID shop_category.idへの外部キー',
	`cntnt_name` VARCHAR(32)  NOT NULL COMMENT 'コンテンツ名称',
	`cntnt_fnc_name` VARCHAR(32)  NOT NULL COMMENT 'コンテンツ機能名称',
	`cntnt_ope_sts` TINYINT default 0 NOT NULL COMMENT 'コンテンツ運用状況区分',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`slct_cntnt_id`),
	INDEX `m_slct_cntnt_FI_1` (`shop_category_id`)
) COMMENT='M_コンテンツ選択マスタ';

#-----------------------------------------------------------------------------
#-- i_shop_slct_cntnt_conf
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `i_shop_slct_cntnt_conf`;


CREATE TABLE `i_shop_slct_cntnt_conf`
(
	`shop_id` INTEGER(11)  NOT NULL COMMENT '店舗ID',
	`slct_cntnt_id` INTEGER UNSIGNED  NOT NULL COMMENT '提供コンテンツID',
	`cntnt_order` INTEGER UNSIGNED COMMENT '提供コンテンツの表示順序',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`shop_id`,`slct_cntnt_id`),
	INDEX `i_shop_slct_cntnt_conf_FI_2` (`slct_cntnt_id`)
) COMMENT='I_店舗提供コンテンツ情報';

#-----------------------------------------------------------------------------
#-- business_cat_timemem
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `business_cat_timemem`;


CREATE TABLE `business_cat_timemem`
(
	`business_cat_mem_id` INTEGER UNSIGNED  NOT NULL COMMENT '業種別会員ID',
	`timemember_id` INTEGER  NOT NULL COMMENT '時間割会員ID',
	`created_at` DATETIME  NOT NULL COMMENT '作成年月日 レコード作成年月日',
	`updated_at` DATETIME  NOT NULL COMMENT '更新年月日 レコード更新年月日',
	PRIMARY KEY (`business_cat_mem_id`,`timemember_id`)
) COMMENT='業種別会員_時間割会員連携';

#-----------------------------------------------------------------------------
#-- business_cat_receive
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `business_cat_receive`;


CREATE TABLE `business_cat_receive`
(
	`business_cat_mem_id` INTEGER UNSIGNED  NOT NULL COMMENT '業種別会員ID',
	`receive_id` BIGINT  NOT NULL COMMENT '予約受付ID',
	`receipt_date` DATETIME  NOT NULL COMMENT '案内予定日時',
	`created_at` DATETIME  NOT NULL COMMENT '作成年月日 レコード作成年月日',
	`updated_at` DATETIME  NOT NULL COMMENT '更新年月日 レコード更新年月日',
	PRIMARY KEY (`business_cat_mem_id`,`receive_id`)
) COMMENT='業種別会員_受付データ連携';

#-----------------------------------------------------------------------------
#-- item_title
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `item_title`;


CREATE TABLE `item_title`
(
	`item_title_id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT '項目タイトルID',
	`title_name` VARCHAR(32)  NOT NULL COMMENT '項目タイトル名',
	`created_at` DATETIME  NOT NULL COMMENT '作成年月日 レコード作成年月日',
	`updated_at` DATETIME  NOT NULL COMMENT '更新年月日 レコード更新年月日',
	PRIMARY KEY (`item_title_id`)
) COMMENT='項目タイトルマスタ';

#-----------------------------------------------------------------------------
#-- item_title_set_info
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `item_title_set_info`;


CREATE TABLE `item_title_set_info`
(
	`business_cat_sys_id` INTEGER UNSIGNED  NOT NULL COMMENT '業種別システム識別ID',
	`item_sts` TINYINT  NOT NULL COMMENT '汎用項目区分',
	`item_no` INTEGER  NOT NULL COMMENT '項目番号',
	`item_title_id` INTEGER UNSIGNED  NOT NULL COMMENT '項目タイトルID',
	`created_at` DATETIME  NOT NULL COMMENT '作成年月日 レコード作成年月日',
	`updated_at` DATETIME  NOT NULL COMMENT '更新年月日 レコード更新年月日',
	PRIMARY KEY (`business_cat_sys_id`,`item_sts`,`item_no`)
) COMMENT='項目タイトル設定情報';

#-----------------------------------------------------------------------------
#-- business_cat_str
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `business_cat_str`;


CREATE TABLE `business_cat_str`
(
	`business_cat_mem_id` INTEGER UNSIGNED  NOT NULL COMMENT '業種別会員ID',
	`item_no` INTEGER  NOT NULL COMMENT '項目番号',
	`item_title_id` INTEGER UNSIGNED  NOT NULL COMMENT '項目タイトルID',
	`str_item` VARCHAR(255)  NOT NULL COMMENT '文字列項目',
	`created_at` DATETIME  NOT NULL COMMENT '作成年月日 レコード作成年月日',
	`updated_at` DATETIME  NOT NULL COMMENT '更新年月日 レコード更新年月日',
	PRIMARY KEY (`business_cat_mem_id`,`item_no`)
) COMMENT='業種別会員文字列項目';

#-----------------------------------------------------------------------------
#-- business_cat_flg
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `business_cat_flg`;


CREATE TABLE `business_cat_flg`
(
	`business_cat_mem_id` INTEGER UNSIGNED  NOT NULL COMMENT '業種別会員ID',
	`item_no` INTEGER  NOT NULL COMMENT '項目番号',
	`item_title_id` INTEGER UNSIGNED  NOT NULL COMMENT '項目タイトルID',
	`flg_item` TINYINT  NOT NULL COMMENT 'フラグ項目',
	`created_at` DATETIME  NOT NULL COMMENT '作成年月日 レコード作成年月日',
	`updated_at` DATETIME  NOT NULL COMMENT '更新年月日 レコード更新年月日',
	PRIMARY KEY (`business_cat_mem_id`,`item_no`)
) COMMENT='業種別会員フラグ項目';

#-----------------------------------------------------------------------------
#-- business_cat_num
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `business_cat_num`;


CREATE TABLE `business_cat_num`
(
	`business_cat_mem_id` INTEGER UNSIGNED  NOT NULL COMMENT '業種別会員ID',
	`item_no` INTEGER  NOT NULL COMMENT '項目番号',
	`item_title_id` INTEGER UNSIGNED  NOT NULL COMMENT '項目タイトルID',
	`num_item` INTEGER  NOT NULL COMMENT '数字項目',
	`created_at` DATETIME  NOT NULL COMMENT '作成年月日 レコード作成年月日',
	`updated_at` DATETIME  NOT NULL COMMENT '更新年月日 レコード更新年月日',
	PRIMARY KEY (`business_cat_mem_id`,`item_no`)
) COMMENT='業種別会員数字項目';

#-----------------------------------------------------------------------------
#-- business_cat_date
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `business_cat_date`;


CREATE TABLE `business_cat_date`
(
	`business_cat_mem_id` INTEGER UNSIGNED  NOT NULL COMMENT '業種別会員ID',
	`item_no` INTEGER  NOT NULL COMMENT '項目番号',
	`item_title_id` INTEGER UNSIGNED  NOT NULL COMMENT '項目タイトルID',
	`date_item` DATE  NOT NULL COMMENT '日付項目',
	`created_at` DATETIME  NOT NULL COMMENT '作成年月日 レコード作成年月日',
	`updated_at` DATETIME  NOT NULL COMMENT '更新年月日 レコード更新年月日',
	PRIMARY KEY (`business_cat_mem_id`,`item_no`)
) COMMENT='業種別会員日付項目';

#-----------------------------------------------------------------------------
#-- business_cat_enable_shop
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `business_cat_enable_shop`;


CREATE TABLE `business_cat_enable_shop`
(
	`business_cat_sys_id` INTEGER UNSIGNED  NOT NULL COMMENT '業種別システム識別ID',
	`service_code` VARCHAR(8)  NOT NULL COMMENT 'サービスコード区分',
	`shop_id` BIGINT  NOT NULL COMMENT '店舗ID',
	`enable_shop_sts` TINYINT default 1 COMMENT '業種別使用可能店舗運用状況区分',
	`created_at` DATETIME  NOT NULL COMMENT '作成年月日 レコード作成年月日',
	`updated_at` DATETIME  NOT NULL COMMENT '更新年月日 レコード更新年月日',
	PRIMARY KEY (`business_cat_sys_id`,`service_code`,`shop_id`)
) COMMENT='業種別使用可能店舗';

#-----------------------------------------------------------------------------
#-- allowed_ip_address
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `allowed_ip_address`;


CREATE TABLE `allowed_ip_address`
(
	`allowed_ip_id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT '許可IPアドレスID',
	`business_cat_sys_id` INTEGER UNSIGNED  NOT NULL COMMENT '業種別システム識別ID',
	`allowed_ip_address` VARCHAR(64)  NOT NULL COMMENT '許可IPアドレス',
	`subnet_mask` INTEGER default 0,
	`business_cat_ip_sts` TINYINT default 1 COMMENT 'IPアドレス運用状況区分',
	`created_at` DATETIME  NOT NULL COMMENT '作成年月日 レコード作成年月日',
	`updated_at` DATETIME  NOT NULL COMMENT '更新年月日 レコード更新年月日',
	PRIMARY KEY (`allowed_ip_id`)
) COMMENT='業種別許可IPアドレス';

#-----------------------------------------------------------------------------
#-- m_pref
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `m_pref`;


CREATE TABLE `m_pref`
(
	`pref_code` CHAR(2)  NOT NULL COMMENT '都道府県コード JIS X 0401に準拠',
	`pref_kanji_name` VARCHAR(10)  NOT NULL COMMENT '都道府県漢字名称',
	`pref_kana_name` VARCHAR(20)  NOT NULL COMMENT '都道府県カナ名称(全角カタカナ)',
	`epark_pref` INTEGER  NOT NULL COMMENT 'EPARK互換用 prefectureテーブルのコード値',
	`yg_pref` CHAR(7)  NOT NULL COMMENT 'Y!グルメ都道府県マスタ互換用　portal_yg_prefのコード値',
	`created_at` DATETIME  NOT NULL COMMENT '作成年月日 レコード作成年月日',
	`updated_at` DATETIME  NOT NULL COMMENT '更新年月日 レコード更新年月日',
	PRIMARY KEY (`pref_code`),
	KEY `index_pref_kanji_name`(`pref_kanji_name`),
	KEY `index_epark_pref`(`epark_pref`),
	KEY `index_yg_pref`(`yg_pref`)
) COMMENT='M_都道府県マスタ';

#-----------------------------------------------------------------------------
#-- m_memship_mem
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `m_memship_mem`;


CREATE TABLE `m_memship_mem`
(
	`memship_id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT '会員証AP会員ID',
	`member_id` INTEGER COMMENT '会員ID',
	`dev_os_type` TINYINT  NOT NULL COMMENT '端末OS種別',
	`dev_model_name` VARCHAR(255) COMMENT '端末モデル名',
	`dev_os_ver` VARCHAR(255) COMMENT '端末OSバージョン',
	`dev_tokn` VARCHAR(255)  NOT NULL COMMENT 'デバイストークン',
	`dev_chg_date` DATE  NOT NULL COMMENT '機種変更年月日',
	`created_at` DATETIME  NOT NULL COMMENT '作成年月日',
	`updated_at` DATETIME  NOT NULL COMMENT '更新年月日',
	PRIMARY KEY (`memship_id`)
) COMMENT='M_会員証AP会員マスタ';

#-----------------------------------------------------------------------------
#-- i_mem_info_ml_rep
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `i_mem_info_ml_rep`;


CREATE TABLE `i_mem_info_ml_rep`
(
	`mem_info_ml_rep_id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT '会員情報配信担当者',
	`shop_id` INTEGER COMMENT '店舗ID',
	`group_id` INTEGER COMMENT 'グループID',
	`rep_fst_nm` VARCHAR(40)  NOT NULL COMMENT '担当者名字',
	`rep_lst_nm` VARCHAR(40)  NOT NULL COMMENT '担当者名前',
	`rep_pos` VARCHAR(40) COMMENT '担当者役職',
	`rep_email` VARCHAR(40)  NOT NULL COMMENT '担当者メールアドレス',
	`rep_ope_sts` TINYINT  NOT NULL COMMENT '0：運用中 1：運用停止 2：削除済み',
	`created_at` DATETIME  NOT NULL COMMENT 'レコード作成年月日',
	`updated_at` DATETIME  NOT NULL COMMENT 'レコード更新年月日',
	PRIMARY KEY (`mem_info_ml_rep_id`)
) COMMENT='null';

#-----------------------------------------------------------------------------
#-- l_coupon_mail_dlv
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `l_coupon_mail_dlv`;


CREATE TABLE `l_coupon_mail_dlv`
(
	`coupon_mail_dlv_id` INTEGER  NOT NULL AUTO_INCREMENT COMMENT '自動生成',
	`shop_point_mst_id` INTEGER  NOT NULL COMMENT '来店ポイントマスタID',
	`member_id` INTEGER  NOT NULL COMMENT '会員マスタID',
	`after_rank` TINYINT  NOT NULL COMMENT 'ランクアップ後の会員ランク  1:ダイヤモンド 2:プラチナ 3:ゴールド 4:シルバー 5:ブロンズ',
	`created_at` DATETIME  NOT NULL COMMENT '作成年月日',
	`updated_at` DATETIME  NOT NULL COMMENT '更新年月日',
	PRIMARY KEY (`coupon_mail_dlv_id`)
) COMMENT='null';

#-----------------------------------------------------------------------------
#-- t_imp_fmid_relation
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `t_imp_fmid_relation`;


CREATE TABLE `t_imp_fmid_relation`
(
	`fmid` VARCHAR(11)  NOT NULL COMMENT 'FileMaker自動採番一意情報',
	`run_kind` TINYINT UNSIGNED  NOT NULL COMMENT '種別 1: オーナー店舗入稿 2: 店舗入稿',
	`owner_shop_id` INTEGER UNSIGNED COMMENT 'オーナー店舗ID関連キー情報格納',
	`temp_owner_shop_id` INTEGER UNSIGNED COMMENT 'テンポラリオーナー店舗ID関連キー情報格納',
	`shop_id` INTEGER UNSIGNED COMMENT '店舗ID関連キー情報格納',
	`temp_shop_id` INTEGER UNSIGNED COMMENT 'テンポラテンポラリ店舗ID関連キー情報格納',
	`run_admin_user_id` INTEGER UNSIGNED COMMENT '実行ユーザーID',
	`created_at` DATETIME  NOT NULL COMMENT '登録時間',
	`updated_at` DATETIME  NOT NULL COMMENT '更新時間',
	PRIMARY KEY (`fmid`)
) COMMENT='T_インポート用FMID リレーション管理';

#-----------------------------------------------------------------------------
#-- w_imp_fmid_relation
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `w_imp_fmid_relation`;


CREATE TABLE `w_imp_fmid_relation`
(
	`fmid` VARCHAR(11)  NOT NULL COMMENT 'FileMaker自動採番一意情報',
	`run_kind` TINYINT UNSIGNED  NOT NULL COMMENT '種別 1: オーナー店舗入稿 2: 店舗入稿',
	`owner_shop_id` INTEGER UNSIGNED COMMENT 'オーナー店舗ID関連キー情報格納',
	`temp_owner_shop_id` INTEGER UNSIGNED COMMENT 'テンポラリオーナー店舗ID関連キー情報格納',
	`shop_id` INTEGER UNSIGNED COMMENT '店舗ID関連キー情報格納',
	`temp_shop_id` INTEGER UNSIGNED COMMENT 'テンポラテンポラリ店舗ID関連キー情報格納',
	`run_admin_user_id` INTEGER UNSIGNED COMMENT '実行ユーザーID',
	`created_at` DATETIME  NOT NULL COMMENT '登録時間',
	`updated_at` DATETIME  NOT NULL COMMENT '更新時間',
	PRIMARY KEY (`fmid`),
	INDEX `w_imp_fmid_relation_FI_1` (`temp_owner_shop_id`),
	INDEX `w_imp_fmid_relation_FI_2` (`temp_shop_id`)
) COMMENT='W_インポート用テンポラリFMID リレーション管理';

#-----------------------------------------------------------------------------
#-- c_imp_run_manager
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `c_imp_run_manager`;


CREATE TABLE `c_imp_run_manager`
(
	`run_kind` TINYINT UNSIGNED  NOT NULL COMMENT '処理種類 1: オーナー店舗入稿実行 2: 店舗入稿実行 3: 店舗解約・停止',
	`result_status` TINYINT UNSIGNED  NOT NULL COMMENT 'インポート実行状態 0: 未処理 1: CSVチェック完了 2: テンポラリー処理登録完了 3: 実テーブル登録中',
	`run_admin_user_id` INTEGER UNSIGNED  NOT NULL COMMENT '実行ユーザーID',
	`created_at` DATETIME  NOT NULL COMMENT '登録時間',
	`updated_at` DATETIME  NOT NULL COMMENT '更新時間',
	PRIMARY KEY (`run_kind`)
) COMMENT='C_インポート用実行処理管理';

#-----------------------------------------------------------------------------
#-- w_imp_owner_shop
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `w_imp_owner_shop`;


CREATE TABLE `w_imp_owner_shop`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	`forced_insert_flg` TINYINT COMMENT '強制登録フラグ',
	`owner_shop_id` INTEGER COMMENT '更新用オーナー店舗ID',
	`status` TINYINT default 1 NOT NULL COMMENT 'アカウントの運用状態 0: 運用中 1: 停止中 2: 削除済み',
	`name` VARCHAR(80) COMMENT 'オーナー店舗名',
	`name_kana` VARCHAR(200) COMMENT 'オーナー店舗名ひらがな',
	`custom_specification_type` TINYINT default 0 NOT NULL COMMENT '店舗独自仕様種別 0: 通常 1: くら寿司 2: JINS 3:新メディカル 4:API 5:ポータルメディカル 1: くら寿司 は現在未使用、将来の改修時のために予約 ※このカラムは、shop.custom_specification_type の利用に置き換えられます。利用しません。(2011/06/24)',
	`email` VARCHAR(255) COMMENT 'メールアドレス',
	`tel` VARCHAR(20) COMMENT '電話番号',
	`fax` VARCHAR(20) COMMENT 'fax番号',
	`zip_code` VARCHAR(7) COMMENT '郵便番号',
	`address` VARCHAR(300) COMMENT '住所',
	`contact_name` VARCHAR(40) COMMENT '担当者名',
	`contact_name_kana` VARCHAR(100) COMMENT '担当者名ひらがな',
	`url` VARCHAR(300) COMMENT 'サイトURL',
	`memo` TEXT COMMENT '備考',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`)
) COMMENT='W_インポート用テンポラリオーナー店舗マスタ';

#-----------------------------------------------------------------------------
#-- w_imp_shop
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `w_imp_shop`;


CREATE TABLE `w_imp_shop`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	`forced_insert_flg` TINYINT COMMENT '強制登録フラグ',
	`forced_update_flg` TINYINT COMMENT '強制更新フラグ',
	`shop_id` INTEGER COMMENT '更新用店舗ID',
	`owner_shop_id` INTEGER  NOT NULL COMMENT 'オーナー店舗のID',
	`mdshop_id` INTEGER default 0 NOT NULL COMMENT 'EPARK MEDICALの店舗ID',
	`pref_id` TINYINT COMMENT '都道府県ID epark_common.prefecture.id',
	`shop_category_id` INTEGER COMMENT '所属カテゴリID shop_category.idへの外部キー',
	`status` TINYINT default 1 NOT NULL COMMENT '運用状態 0: 運用 1: 運用停止 2: 削除済み 承認 0: 承認 1: 非承認 2: 削除済み 総合管理画面では「承認」と呼ばれている これとは別に、shop_auth.status 「EPARKサービス利用状態」の利用中、停止中もあるので注意',
	`logined_at` DATETIME COMMENT '最終ログイン日時',
	`name` VARCHAR(80) COMMENT '店舗名',
	`name_kana` VARCHAR(200) COMMENT '店舗名ひらがな',
	`sha1_password` VARCHAR(40) COMMENT '符号化化済みパスワード',
	`salt` VARCHAR(32) COMMENT '認証用ランダムキー',
	`email` VARCHAR(255) COMMENT 'メールアドレス',
	`url_mobile` VARCHAR(100) COMMENT 'モバイルサイトのURL',
	`url_pc` VARCHAR(100) COMMENT 'PCサイトのURL',
	`tel` VARCHAR(20) COMMENT '電話番号',
	`fax` VARCHAR(20) COMMENT 'FAX番号',
	`zip_code` VARCHAR(7) COMMENT '郵便番号',
	`address1` VARCHAR(100) COMMENT '住所1',
	`address2` VARCHAR(100) COMMENT '住所2',
	`access_car` VARCHAR(300) COMMENT '車でのアクセス',
	`access_train` VARCHAR(420) COMMENT '電車でのアクセス',
	`copyright` VARCHAR(100) COMMENT '著作権表示',
	`image_name` VARCHAR(50) COMMENT '携帯サイトロゴ画像名',
	`touch_image_name` VARCHAR(50) COMMENT 'タッチパネルロゴ画像名',
	`latitude` DOUBLE COMMENT '店舗の緯度',
	`longitude` DOUBLE COMMENT '店舗の経度',
	`neighborhood_shop_list` VARCHAR(30) COMMENT '近隣店舗。店舗IDを３件まで登録可能。改行をすることで別IDとして認識します。',
	`contact_name` VARCHAR(40) COMMENT '担当者名',
	`contact_name_kana` VARCHAR(100) COMMENT '担当者名ひらがな',
	`contract_type` TINYINT default 0 NOT NULL COMMENT '契約の種類 0: ライトコース 1: 通常コース',
	`printer_type` TINYINT COMMENT 'プリンタの種類 0: EPSON 1: 日本プリメックス 2: CITIZEN(新GMS端末のみ),3: SII,4: エプソン（iPad印刷可）',
	`printer_ip` VARCHAR(15) COMMENT 'プリンターIP',
	`audio_assist_server_ip` VARCHAR(15) COMMENT '音声案内サーバIP',
	`use_display` TINYINT default 0 NOT NULL COMMENT '表示機があるかどうか 0: なし 1: あり 旧）表示機管理作成前 0: なし 1: あり(JINS店舗 1台運用も含む) 2: あり(JINS店舗 2台運用) 3:あり（NEWメガネショップ用）',
	`single_terminal` TINYINT default 0 NOT NULL COMMENT '運用台数が一台かどうか 0: 2台運用 1: 1台運用',
	`mail_sendable` TINYINT default 1 NOT NULL COMMENT 'メール配信可能かどうか 0: 不可能 1: 可能',
	`customer_screen_show_type` TINYINT default 1 NOT NULL COMMENT 'お客様画面表示方法 1：1列表示、2：2列表示（将来順番と順番を別表示）、3：2列表示ダミー行有り',
	`touch_wait_check` TINYINT default 0 NOT NULL COMMENT 'タッチパネル来店客チェックの有無 0: なし 1: あり',
	`is_remail` TINYINT default 0 NOT NULL COMMENT 'リメール店舗かどうか 0:EPARK店舗 1:リメール店舗',
	`send_reserve_mail` TINYINT default 1 NOT NULL COMMENT '会員に予約確認メールを送信するかどうか',
	`sel_criteria_kbn` TINYINT default 0 NOT NULL COMMENT '部門選択条件 0: 未導入 1: 導入',
	`department_kbn` TINYINT default 0 NOT NULL COMMENT '部門 0: 未導入 1: 導入',
	`sequential_department_id` BIGINT default 0 COMMENT '部門連番用の部門ID',
	`criteria_both_kbn` TINYINT default 0 COMMENT '「どちらでも」部門 0: 未使用 1: 使用',
	`closed_sunday` TINYINT default 0 NOT NULL COMMENT '日曜休業かどうか 0:営業 1:休業',
	`closed_monday` TINYINT default 0 NOT NULL COMMENT '月曜休業かどうか 0:営業 1:休業',
	`closed_tuesday` TINYINT default 0 NOT NULL COMMENT '火曜休業かどうか 0:営業 1:休業',
	`closed_wednesday` TINYINT default 0 NOT NULL COMMENT '水曜休業かどうか 0:営業 1:休業',
	`closed_thursday` TINYINT default 0 NOT NULL COMMENT '木曜休業かどうか 0:営業 1:休業',
	`closed_friday` TINYINT default 0 NOT NULL COMMENT '金曜休業かどうか 0:営業 1:休業',
	`closed_saturday` TINYINT default 0 NOT NULL COMMENT '土曜休業かどうか 0:営業 1:休業',
	`closed_holiday` TINYINT default 0 NOT NULL COMMENT '祝日休業かどうか 0:営業 1:休業',
	`open_holiday` TINYINT default 0 NOT NULL COMMENT '祝日営業しているかどうか 0:休業 1:営業 ここだけ、0:休業 となって論理が逆なので注意 上記の、closed_holiday以外の休日設定が「祝日と重なったときに限って」特別に営業するという設定。 closed_holidayが1（休業）となっていると矛盾するので、旧システムの管理画面では closed_holiday と open_holiday を同時にチェックしようとすると警告メッセージが表示されて変更できない',
	`irregular_holiday` TINYINT default 0 NOT NULL COMMENT '不定休かどうか 0:不定休でない 1:不定休である',
	`always_open` TINYINT default 0 NOT NULL COMMENT '年中無休かどうか 0:年中無休でない 1:年中無休である',
	`decided_holiday` TINYINT default 0 NOT NULL COMMENT '「定休日なし」かどうか 0:「定休日なし」でない 1:「定休日なし」である',
	`medical_url` VARCHAR(10) COMMENT '医療機関用URL(詳しく調べる必要あり)',
	`memo` VARCHAR(200) COMMENT '備考。switchが入っていた場合を条件としていて、移管店舗かどうか判断していたりする。',
	`spare1` BIGINT COMMENT '移管するときに使っていた様子。これが空でなく、memoの値がswitchなら移管店舗と判断している。',
	`spare2` VARCHAR(100) COMMENT '使っていない',
	`inspection_machine_count` TINYINT default 1 NOT NULL COMMENT '検査機台数(jins用)',
	`session_life_time` INTEGER default 3600 NOT NULL COMMENT 'SHOP毎のセッショライフタイム（秒）',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	`printer_status` TINYINT default 0 NOT NULL COMMENT 'メディカル使用項目 プリンタ印刷(受付票) 0:しない 1:する',
	`browser_type` TINYINT default 0 NOT NULL COMMENT 'ブラウザタイプ 0:IE6 1:IE7以上',
	`information_color` TINYINT default 0 NOT NULL COMMENT '受付画面配色 0:Aグリーン 1:Bオレンジ 2:Cブルー',
	`screen_kind` TINYINT default 0 NOT NULL COMMENT '画面種別 0:A（ショップ仕様）1:B（飲食店仕様) 2:C (新JINSデザイン仕様) 3:D (時間指定・順番待ち併用受付仕様)',
	`voice_play_status` TINYINT default 0 NOT NULL COMMENT '音声呼出 0:なし1:あり',
	`custom_specification_type` TINYINT default 0 NOT NULL COMMENT '店舗独自仕様種別 0: 通常 1: くら寿司 2: JINS 3:新メディカル 4:API 5:ポータルメディカル 6:査定システム 7:阪急阪神レストラン街 8:薬局 9:カーケア 10:大病院予約連携 1: くら寿司 は現在未使用、将来の改修時のために予約 ※owner_shop.custom_specification_type は廃止予定です。',
	`use_report` TINYINT  NOT NULL COMMENT 'Eネ!レポ機能利用フラグ0:無効1:有効',
	`only_publication` TINYINT default 0 NOT NULL COMMENT '掲載のみフラグ0:通常1:掲載のみ',
	`seats` SMALLINT default 0 COMMENT '席数0:指定なし',
	`unit_price_lunch` INTEGER default 0 COMMENT '単価（昼）0:指定なし1:～1,000円 2:1,000～2,000円 3:2,000～3,000円 4:3,000～5,000円 5:5,000～10,000円 6:10,000～20,000円 7:20,000円～',
	`unit_price_dinner` TINYINT default 0 COMMENT '単価（夜）0:指定なし1:～1,000円 2:1,000～2,000円 3:2,000～3,000円 4:3,000～5,000円 5:5,000～10,000円 6:10,000～20,000円 7:20,000円～',
	`credit_card` TINYINT default 0 NOT NULL COMMENT '詳細情報：各種クレジットカード有0:指定なし1:なし2:あり',
	`shopping_mall` TINYINT default 0 NOT NULL COMMENT '詳細情報：ショッピングモール有0:指定なし1:なし2:あり',
	`smoking` TINYINT default 0 NOT NULL COMMENT '喫煙可能 0: 指定なし 1: 禁煙 2: 喫煙可 3: 分煙',
	`child_seats` TINYINT default 0 NOT NULL COMMENT '詳細情報：お子様席有0:指定なし1:なし2:あり',
	`parking` TINYINT default 0 NOT NULL COMMENT '詳細情報：駐車場有0:指定なし1:なし2:あり',
	`takeout` TINYINT default 0 NOT NULL COMMENT '詳細情報：テイクアウト有0:指定なし1:なし2:あり',
	`open_text` VARCHAR(200) COMMENT '営業時間（フリーテキスト）',
	`close_text` VARCHAR(200) COMMENT '定休日（フリーテキスト）',
	`charged_reservation` TINYINT default 0 NOT NULL COMMENT '有料予約店舗かどうか 0:使用しない1:使用する',
	`proposed_shop_list` VARCHAR(800) COMMENT '同時会員登録店舗。店舗IDを99件まで登録可能。改行をすることで別IDとして認識します。',
	`sbm_proposed_shop_list` VARCHAR(800) COMMENT '同時会員登録店舗(新SBM版)。店舗IDを99件まで登録可能。改行をすることで別IDとして認識します。',
	`coupon_day_count` TINYINT default 4 COMMENT '1店舗あたりのクーポン発行可能日数 2012.06.22#5313_改修により店舗毎に管理する。',
	`aim_time_text` VARCHAR(40) COMMENT 'ねらい目時間',
	`google_shop_photo` TINYINT default 1 NOT NULL COMMENT 'Googleおみせフォト使用フラグ 0: 使用 1: 未使用',
	`free_drink` TINYINT default 0 NOT NULL COMMENT '飲み放題・ドリンクバー有 0: 指定なし 1: なし 2: あり',
	`free_food` TINYINT default 0 NOT NULL COMMENT '食べ放題有 0: 指定なし 1: なし 2: あり',
	`credit_card_text` VARCHAR(100) COMMENT 'クレジットカード フリー文言',
	`zashiki` TINYINT default 0 NOT NULL COMMENT 'お座敷有 0: 指定なし 1: なし 2: あり',
	`barrier_free` TINYINT default 0 NOT NULL COMMENT 'バリアフリー有 0: 指定なし 1: なし 2: あり',
	`lunch` TINYINT default 0 NOT NULL COMMENT 'ランチ有 0: 指定なし 1: なし 2: あり',
	`late_night` TINYINT default 0 NOT NULL COMMENT '22時以降も営業有 0: 指定なし 1: なし 2: あり',
	`neighboring_guidance_shop_list` VARCHAR(50) COMMENT '近隣店舗誘導。店舗IDを５件まで登録可能。改行をすることで別IDとして認識します。',
	`neighboring_guidance_text` VARCHAR(200) COMMENT '近隣店舗誘導メッセージ',
	`interlocking_seat_contact_name` VARCHAR(40) COMMENT '担当者機能名称',
	`interlocking_seat_booth_name` VARCHAR(40) COMMENT 'ブース機能名称',
	`display_graph` TINYINT default 1 COMMENT 'グラフ表示 0：表示、1：非表示',
	`display_icon1` TINYINT default 1 COMMENT 'おすすめアイコン１ 0：表示、1：非表示',
	`icon1_hour` INTEGER COMMENT 'アイコン表示時間１ おすすめアイコンを表示する時間帯',
	`display_icon2` TINYINT default 1 COMMENT 'おすすめアイコン２ 0：表示、1：非表示',
	`icon2_hour` INTEGER COMMENT 'アイコン表示時間２ おすすめアイコンを表示する時間帯',
	`mail_free_count` INTEGER COMMENT 'メール無料送数',
	`mail_unit_price` SMALLINT COMMENT 'メール単価。メール無料送数を超えた場合の1メールあたりの単価。',
	`pda_logout_hour` TINYINT default 2 COMMENT 'PDA強制ログアウト実行時間 0時から23時で管理を想定 99：しない、2：AM2時に実行 8:AM8時に実行 ',
	`culture_cd` VARCHAR(5) default 'ja_JP' COMMENT '使用言語コード',
	PRIMARY KEY (`id`),
	INDEX `w_imp_shop_FI_1` (`owner_shop_id`)
) COMMENT='W_インポート用テンポラリ店舗マスタ';

#-----------------------------------------------------------------------------
#-- w_imp_shop_auth
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `w_imp_shop_auth`;


CREATE TABLE `w_imp_shop_auth`
(
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID',
	`owner_shop_id` INTEGER  NOT NULL COMMENT 'オーナー店舗ID パフォーマンス向上のための冗長化',
	`status` TINYINT default 1 NOT NULL COMMENT 'EPARKサービス利用状態 0: 利用中 1: 停止中 総合管理画面で「承認」と呼ばれている shop.status もあるので注意',
	`password_touch` VARCHAR(15)  NOT NULL COMMENT 'パスワード タッチパネル用',
	`password_admin` VARCHAR(15)  NOT NULL COMMENT 'パスワード 店舗管理画面用',
	`sha1_password_touch` VARCHAR(64)  NOT NULL COMMENT '符号化済みパスワード タッチパネル用',
	`salt_touch` VARCHAR(32)  NOT NULL COMMENT '認証用salt タッチパネル用',
	`sha1_password_admin` VARCHAR(64)  NOT NULL COMMENT '符号化済みパスワード 店舗管理画面用',
	`salt_admin` VARCHAR(32)  NOT NULL COMMENT '認証用salt 店舗管理画面用',
	`send_count` SMALLINT  NOT NULL COMMENT '管理者アカウント情報送信回数',
	`registration_mailto` VARCHAR(20)  NOT NULL COMMENT '会員登録用空メールアドレスの、@の左部分',
	`coupon_id` INTEGER COMMENT '初回特典クーポン',
	`nml_mail_auth_group_id` INTEGER COMMENT 'お知らせメール配信設定承認グループID',
	`cpn_mail_auth_group_id` INTEGER COMMENT 'クーポンメール配信設定承認グループID',
	`sent_at` DATETIME COMMENT '店舗アカウント情報初回送信日時',
	`logined_at` DATETIME COMMENT '最終ログイン日時',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	PRIMARY KEY (`id`),
	INDEX `w_imp_shop_auth_FI_1` (`shop_id`),
	INDEX `w_imp_shop_auth_FI_2` (`owner_shop_id`)
) COMMENT='W_インポート用テンポラリ店舗の認証情報';

#-----------------------------------------------------------------------------
#-- w_imp_shop_auth_config
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `w_imp_shop_auth_config`;


CREATE TABLE `w_imp_shop_auth_config`
(
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID',
	`auth_type` TINYINT  NOT NULL COMMENT '権限 1: 順番待ち機能の利用権限 2: 将来順番受付機能の利用権限 3: メール配信の利用権限 8: テストな権限 9:QRコード利用権限 10:初回特典有無 11:店舗管理画面の削除ボタン表示可否 12:タッチパネルからのメール配信設定 13:テンプレートメール機能の利用権限 14:EPARK API widget 利用権限 15:電話呼出利用権限 16:接客機能の利用権限 17:担当者機能の利用権限 18:接客中QRコール利用権限 19: 携帯呼出利用権限 20:予約台帳機能利用権限 21: 来店ポイント機能利用権限 22: 即時案内機能利用権限 23:メールにクーポンをセットできる数 24:券売機利用権限 25:手書きパッド利用権限 26:席連動機能利用権限 27:ブース機能利用権限 28:来店スタンプ機能利用権限 29:電話受付機能利用権限 30:接客中電話呼出利用権限 31:メッセージ配信機能利用権限 32:デザインカラー利用権限 33:接客中アラート権限 34:接客中チャイム権限 36:選択コンテンツ機能利用権限 38:ダイニングレジ機能利用権限 39:整理券発券機能利用権限 40:緊急Push配信利用権限 41:緊急メール配信機能利用権限 42:薬局お薬手帳連携 43:Resty連携予約ポイント付与 44:Y2クラウド連携設定 45:QR・バーコードリーダー連携権限 48:順番待ちサイネージ受付権限 49:呼出しQRコードWeb表示権限 52:予約タイプ選択権限',
	`auth_status` TINYINT  NOT NULL COMMENT '権限ステータス 0: 使用可 1: 使用不可 ただしauth_id=8の場合は 0: 通常 1: テスト店舗、auth_id=23の場合は 0:複数 1:1つ',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`shop_id`,`auth_type`)
) COMMENT='W_インポート用テンポラリ店舗の各種権限設定';

#-----------------------------------------------------------------------------
#-- w_imp_pda_login
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `w_imp_pda_login`;


CREATE TABLE `w_imp_pda_login`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT COMMENT '自動生成プライマリキー',
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID',
	`sequential_number` INTEGER  NOT NULL COMMENT '連番',
	`pda_id` VARCHAR(11)  NOT NULL COMMENT 'PDA用ログインID (shop_id + sequential_number の10桁 or shop_id + sequential_number の11桁)',
	`carrier` VARCHAR(50) COMMENT '最終ログイン機種',
	`session_id` VARCHAR(100) COMMENT 'セッションID',
	`status` TINYINT  NOT NULL COMMENT '運用ステータス 0:運用中 1:停止中 2:予備 9:削除済',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	INDEX `w_imp_pda_login_FI_1` (`shop_id`)
) COMMENT='W_インポート用テンポラリPDAログイン用ID登録テーブル';

#-----------------------------------------------------------------------------
#-- w_imp_shop_timeset
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `w_imp_shop_timeset`;


CREATE TABLE `w_imp_shop_timeset`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID',
	`set_number` TINYINT  NOT NULL COMMENT '設定パターン(日の分類) 0:平日 1:土曜日 2:日曜日 3:祝日 4:金曜日 5:祝前日 6:月曜 7:火曜 8:水曜 9:木曜 10:その他',
	`wait_time` SMALLINT  NOT NULL COMMENT '待ち時間(分) ※利用せず',
	`wait_time_max` SMALLINT  NOT NULL COMMENT 'ディスプレイに表示する最大待ち時間(分) ※利用せず',
	`open1_start` TIME  NOT NULL COMMENT '営業時間1の開始時間',
	`open1_close` TIME  NOT NULL COMMENT '営業時間1の終了時間',
	`open2_start` TIME COMMENT '営業時間2の開始時間',
	`open2_close` TIME COMMENT '営業時間2の終了時間',
	`open3_start` TIME COMMENT '営業時間3の開始時間',
	`open3_close` TIME COMMENT '営業時間3の終了時間',
	`order_stop` INTEGER COMMENT '受付終了時間',
	`open24` TINYINT COMMENT '24時間営業 1:24時間営業 0:24時間営業ではない',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	INDEX `w_imp_shop_timeset_FI_1` (`shop_id`)
) COMMENT='W_インポート用テンポラリ店舗の営業時間情報';

#-----------------------------------------------------------------------------
#-- w_imp_shop_timeset_mobile
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `w_imp_shop_timeset_mobile`;


CREATE TABLE `w_imp_shop_timeset_mobile`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID',
	`set_number` TINYINT  NOT NULL COMMENT '設定パターン(日の分類)',
	`open1_start` TIME  NOT NULL COMMENT '営業時間1の開始時間',
	`open1_close` TIME  NOT NULL COMMENT '営業時間1の終了時間',
	`open2_start` TIME COMMENT '営業時間2の開始時間',
	`open2_close` TIME COMMENT '営業時間2の終了時間',
	`open3_start` TIME COMMENT '営業時間3の開始時間',
	`open3_close` TIME COMMENT '営業時間3の終了時間',
	`open24` TINYINT COMMENT '24時間営業 1:24時間営業 0:24時間営業ではない',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	INDEX `w_imp_shop_timeset_mobile_FI_1` (`shop_id`)
) COMMENT='W_インポート用テンポラリ店舗の携帯予約受付時間情報店舗の携帯予約受付時間情報';

#-----------------------------------------------------------------------------
#-- w_imp_shop_shop_category_rel
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `w_imp_shop_shop_category_rel`;


CREATE TABLE `w_imp_shop_shop_category_rel`
(
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID',
	`shop_category_id` INTEGER  NOT NULL COMMENT '店舗カテゴリID',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`shop_id`,`shop_category_id`)
) COMMENT='W_インポート用テンポラリ店舗・店舗カテゴリ関連';

#-----------------------------------------------------------------------------
#-- w_imp_shop_report_summary
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `w_imp_shop_report_summary`;


CREATE TABLE `w_imp_shop_report_summary`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT COMMENT 'Eネ!レポ集計情報ID',
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ＩＤ',
	`max_wait_time_last_month` SMALLINT default 0 COMMENT '待ち時間最大値（前月）',
	`max_wait_count_last_month` SMALLINT default 0 COMMENT '待ち組数最大値（前月）',
	`wait_time_last_month_modified_at` DATETIME COMMENT '待ち時間最大値（前月）を更新した時刻',
	`max_wait_time_this_month` SMALLINT default 0 COMMENT '待ち時間最大値（今月）',
	`max_wait_count_this_month` SMALLINT default 0 COMMENT '待ち組数最大値（今月）',
	`report_count` INTEGER default 0 COMMENT 'Eネ!レポの件数',
	`general_evaluation` DECIMAL(4,3) default 0 COMMENT '総合評価',
	`evaluation_taste` DECIMAL(4,3) default 0 COMMENT '総合評価：美味しさ',
	`evaluation_service` DECIMAL(4,3) default 0 COMMENT '総合評価：サービス',
	`evaluation_price` DECIMAL(4,3) default 0 COMMENT '総合評価：値段に対しての味',
	`evaluation_again` DECIMAL(4,3) default 0 COMMENT '総合評価：また行きたい',
	`evaluation_women_taste` DECIMAL(4,3) default 0 COMMENT '女性評価：美味しさ',
	`evaluation_women_service` DECIMAL(4,3) default 0 COMMENT '女性評価：サービス',
	`evaluation_women_price` DECIMAL(4,3) default 0 COMMENT '女性評価：値段に対しての味',
	`evaluation_women_again` DECIMAL(4,3) default 0 COMMENT '女性評価：また行きたい',
	`evaluation_men_taste` DECIMAL(4,3) default 0 COMMENT '男性評価：美味しさ',
	`evaluation_men_service` DECIMAL(4,3) default 0 COMMENT '男性評価：サービス',
	`evaluation_men_price` DECIMAL(4,3) default 0 COMMENT '男性評価：値段に対しての味',
	`evaluation_men_again` DECIMAL(4,3) default 0 COMMENT '男性評価：また行きたい',
	`evaluation_child_menu` DECIMAL(4,3) default 0 COMMENT '子ども評価：お子様メニュー',
	`evaluation_child_fun` DECIMAL(4,3) default 0 COMMENT '子ども評価：お楽しみ要素',
	`evaluation_child_stay` DECIMAL(4,3) default 0 COMMENT '子ども評価：滞在のし易さ',
	`evaluation_child_other_child` DECIMAL(4,3) default 0 COMMENT '子ども評価：他のお子様連れ人数',
	`scene_one_person` TINYINT  NOT NULL COMMENT 'おひとりフラグ',
	`scene_family` TINYINT  NOT NULL COMMENT 'ファミリーフラグ',
	`scene_friends` TINYINT  NOT NULL COMMENT 'フレンドフラグ',
	`scene_drinking_party` TINYINT  NOT NULL COMMENT '飲み会フラグ',
	`scene_date` TINYINT  NOT NULL COMMENT 'デートフラグ',
	`scene_business` TINYINT  NOT NULL COMMENT 'ビジネスフラグ',
	`category_calm` TINYINT  NOT NULL COMMENT 'カテゴリー詳細：静かで落ち着いている',
	`category_bustling` TINYINT  NOT NULL COMMENT 'カテゴリー詳細：ワイワイ賑やか',
	`category_nostalgia` TINYINT  NOT NULL COMMENT 'カテゴリー詳細：懐かしい雰囲気',
	`category_zashiki` TINYINT  NOT NULL COMMENT 'カテゴリー詳細：座敷がある',
	`category_private_room_zashiki` TINYINT  NOT NULL COMMENT 'カテゴリー詳細：個室（座敷）',
	`category_private_room_table` TINYINT  NOT NULL COMMENT 'カテゴリー詳細：個室（テーブル）',
	`category_near_station` TINYINT  NOT NULL COMMENT 'カテゴリー詳細：駅から5分',
	`category_theme` TINYINT  NOT NULL COMMENT 'カテゴリー詳細：テーマレストラン',
	`category_sweets` TINYINT  NOT NULL COMMENT 'カテゴリー詳細：スイーツが充実',
	`category_filling` TINYINT  NOT NULL COMMENT 'カテゴリー詳細：ボリューム自慢',
	`category_bottomless_cup` TINYINT  NOT NULL COMMENT 'カテゴリー詳細：飲み放題有り',
	`category_all_you_can_eat` TINYINT  NOT NULL COMMENT 'カテゴリー詳細：食べ放題有り',
	`category_karaoke` TINYINT  NOT NULL COMMENT 'カテゴリー詳細：カラオケ有り',
	`category_student_discount` TINYINT  NOT NULL COMMENT 'カテゴリー詳細：学割有り',
	`category_girls_gathering` TINYINT  NOT NULL COMMENT 'カテゴリー詳細：女子会向け',
	`category_pets` TINYINT  NOT NULL COMMENT 'カテゴリー詳細：ペット可',
	`category_reviewed` TINYINT  NOT NULL COMMENT 'カテゴリー詳細：TV/雑誌で紹介された',
	`category_cinema` TINYINT  NOT NULL COMMENT 'カテゴリー詳細：映画館の近く',
	`category_childrens_playground` TINYINT  NOT NULL COMMENT 'カテゴリー詳細：キッズスペース有り',
	`category_diaper` TINYINT  NOT NULL COMMENT 'カテゴリー詳細：おむつ交換スペース有り',
	`category_multipurpose_toilet` TINYINT  NOT NULL COMMENT 'カテゴリー詳細：多目的トイレ有り',
	`category_wheelchair` TINYINT  NOT NULL COMMENT 'カテゴリー詳細：車椅子でも使い易い',
	`category_magazine` TINYINT  NOT NULL COMMENT 'カテゴリー詳細：雑誌が置いてある',
	`category_ceremonial_occasions` TINYINT  NOT NULL COMMENT 'カテゴリー詳細：冠婚葬祭で使える',
	`category_night_view` TINYINT  NOT NULL COMMENT 'カテゴリー詳細：夜景がキレイ',
	`category_ocean_view` TINYINT  NOT NULL COMMENT 'カテゴリー詳細：海が見える',
	`category_green` TINYINT  NOT NULL COMMENT 'カテゴリー詳細：緑に囲まれている',
	`category_birthday` TINYINT  NOT NULL COMMENT 'カテゴリー詳細：誕生日特典有り',
	`category_late_night` TINYINT  NOT NULL COMMENT 'カテゴリー詳細：深夜でも営業している',
	`category_calories` TINYINT  NOT NULL COMMENT 'カテゴリー詳細：カロリー表示有り',
	`category_alergy` TINYINT  NOT NULL COMMENT 'カテゴリー詳細：アレルギー表示有り',
	`category_kids_menu` TINYINT  NOT NULL COMMENT 'カテゴリー詳細：お子様メニュー有り',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	UNIQUE KEY `w_imp_shop_report_summary_U_1` (`shop_id`)
) COMMENT='W_インポート用テンポラリEネ!レポ集計情報';

#-----------------------------------------------------------------------------
#-- w_imp_shop_reserve_config
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `w_imp_shop_reserve_config`;


CREATE TABLE `w_imp_shop_reserve_config`
(
	`id` BIGINT  NOT NULL AUTO_INCREMENT,
	`shop_id` BIGINT  NOT NULL COMMENT '店舗ＩＤ',
	`shop_mobile_status` TINYINT COMMENT '順番待ち：携帯サイト受付 0:受付 1:停止 ',
	`mobile_msg` VARCHAR(255) COMMENT '順番待ち：受付停止中メッセージの手動設定内容',
	`mobile_msg_status` TINYINT default 1 COMMENT '順番待ち：受付停止中メッセージ 0:手動設定 1:定型文表示',
	`telop_msg` VARCHAR(255) COMMENT 'タッチパネル（店舗受付用）テロップメッセージ',
	`telop_msg_status` TINYINT COMMENT 'テロップ表示ステータス 0:表示 1:非表示 スプレッドシートではここだけ論理が逆になっていたけど周りと同じ',
	`issue_msg` VARCHAR(255) COMMENT '発券メッセージ',
	`issue_msg_status` TINYINT COMMENT '0:編集（発券メッセージ必須） 1:発券メッセージ空白ＯＫ',
	`wait_time_max` SMALLINT COMMENT '順番待ち：待ち時間表示上限',
	`wait_late_time` SMALLINT COMMENT '順番待ち：「呼出」猶予時間(分) 予約データが不在になった後、この時間(分)経過すると無断キャンセルになる',
	`seat` INTEGER COMMENT '席数',
	`news_setup_display` TINYINT default 0 COMMENT '携帯予約確認画面で設定を表示する制御 0:表示しない 1:表示する',
	`mail_status` TINYINT default 1 COMMENT '順番待ち：直前お知らせメール 0:配信する 1:配信しない',
	`mail_order` TINYINT default 2 COMMENT '順番待ち：直前お知らせメールを送る予約・順番待ちの範囲 この順番までの予約・順番待ちのメンバーにメールを送る',
	`send_mail_limit_extension_status` TINYINT default 0 NOT NULL COMMENT 'メール配信上限数拡張ステータス 0:通常 2件/日 1:拡張 5件/日',
	`qr_mail_order` TINYINT default 0 COMMENT '「QRコール：QRコールを送る予約・順番待ちの範囲」この順番までの予約・順番待ちのQR登録者にメールを送る 「順番待ち：直前お知らせメール」が有効になっていない場合は使えません 0:手動送信',
	`mail_status2` TINYINT default 1 COMMENT '順番待ち：作業完了メール 0:配信する 1:配信しない',
	`auto_tel_call_status` TINYINT default 1 NOT NULL COMMENT '自動電話呼出設定 0:自動呼出を行う 1:自動呼出をしない',
	`auto_tel_call_order` TINYINT default 0 NOT NULL COMMENT '自動電話呼出組数 この順番までの予約・順番待ちの電話呼出対象に電話呼出を行う。',
	`mobile_wait_view_status` TINYINT default 0 COMMENT '順番待ち時間・件数表示切替（携帯／スマホ／PC共通項目） 0:全表示 1:件数のみ表示 2:時間のみ表示 9:非表示',
	`mobile_wait_display` TINYINT default 1 COMMENT '停止中待ち情報表示切替 0:表示 1:非表示',
	`mobile_status` TINYINT COMMENT '将来順番受付・時間指定：携帯サイト受付 0:受付 1:停止',
	`stop_msg` TEXT COMMENT '将来順番受付・時間指定：受付停止中メッセージの手動設定内容',
	`stop_msg_status` TINYINT default 1 COMMENT '将来順番受付・時間指定：受付停止中メッセージ 0:手動設定 1:定型文表示',
	`enable_time` SMALLINT COMMENT '受付対応可能時間 携帯サイトから予約の受付を何分後から受付けるかの設定 (外部からお店までの移動時間を計算に入れてください)',
	`enable_term` SMALLINT COMMENT '受付対応可能期間 何日後の予約を受付けるかの設定です 今日から何日後までの予約を時間指定予約、将来順番待ち予約できるかを設定',
	`enable_type` TINYINT default 1 NOT NULL COMMENT '席連動予約 受付対応可能期間(開始)の種別 1:分、2:日',
	`enable_from` SMALLINT COMMENT '席連動予約 受付対応可能期間(開始) 現在時間から設定日または分後以降の時間のみ予約可能',
	`enable_to` SMALLINT COMMENT '席連動予約 受付対応可能期間(終了) 現在日付から設定日後まで予約可能',
	`late_time` SMALLINT COMMENT '予約時間後の猶予時間（分単位） 予約した時刻を過ぎた場合の呼出猶予時間を設定します。',
	`enable_wait_time` SMALLINT default 6 COMMENT '※使用しない 待ち有効時間 この時間(Hour)を経過した不在・無断キャンセルは店舗側タッチパネルの不在・無断キャンセルの一覧に表示しない が、もう、これは使用しないとのこと',
	`touch_wait_time` TINYINT default 0 COMMENT 'タッチパネル待ち時間表示 0:表示 1:非表示',
	`coupon_button` TINYINT default 0 COMMENT 'タッチパネル（店頭受付用）：クーポンボタン表示 0:表示 1:非表示',
	`tablet_coupon_btn` TINYINT default 1 COMMENT 'タッチパネル（iPad,Tablet用）：クーポンボタン表示 0:表示 1:非表示',
	`category_button` TINYINT default 1 NOT NULL COMMENT 'タッチパネル（設定用）：カテゴリボタン表示 0:表示 1:非表示',
	`touch_wait_pair` TINYINT default 0 COMMENT 'タッチパネル待ち組表示 0:表示 1:非表示',
	`contact_mail_msg` VARCHAR(255) COMMENT '連絡ボタン押下時の送信メールメッセージ',
	`admin_touch_colum1` TINYINT default 0 COMMENT '管理用タッチパネル表示項目1 0:待ち時間 1:お呼び出し 2:受付時間 3:案内予定',
	`admin_touch_colum2` TINYINT default 1 COMMENT '管理用タッチパネル表示項目2 0:待ち時間 1:お呼び出し 2:受付時間 3:案内予定',
	`touch_detail_left_area_left_cd` TINYINT default 0 COMMENT 'タッチパネル設定 左パネル 左 0:待ち時間 1:お呼び出し 2:受付時間 3:案内予定',
	`touch_detail_left_area_right_cd` TINYINT default 0 COMMENT 'タッチパネル設定 左パネル 右 0:待ち時間 1:お呼び出し 2:受付時間 3:案内予定',
	`touch_detail_right_area_left_cd` TINYINT default 0 COMMENT 'タッチパネル設定 右パネル 左 0:非表示 0!=部門IDまたは予約カテゴリID',
	`touch_detail_right_area_center_cd` TINYINT default 0 COMMENT 'タッチパネル設定 右パネル 中央 0:非表示 0!=部門IDまたは予約カテゴリID',
	`touch_detail_right_area_right_cd` TINYINT default 0 COMMENT 'タッチパネル設定 右パネル 右 0:非表示 0!=部門IDまたは予約カテゴリID',
	`touch_second_stage_cd` TINYINT default 0 COMMENT 'タッチパネル設定 全体状況 2段1項目表示 0:非表示 0!=1;「待ち時間」以外',
	`touch_second_stage2_cd` TINYINT default 0 COMMENT 'タッチパネル設定 全体状況 2段2項目表示 0:非表示 0!=1;「待ち時間」以外',
	`touch_third_stage_cd` TINYINT default 0 COMMENT 'タッチパネル設定 全体状況 3段1項目表示 0:非表示 0!=1;「待ち時間」以外',
	`touch_third_stage2_cd` TINYINT default 0 COMMENT 'タッチパネル設定 全体状況 3段2項目表示 0:非表示 0!=1;「待ち時間」以外',
	`enable_shop_timeset_edit` TINYINT default 0 COMMENT '店舗管理画面の時間枠編集表示設定 0:非表示 1:表示',
	`wait_time_display_type` TINYINT default 1 NOT NULL COMMENT '待ち時間表示タイプ 1: 最大待ち時間 2: 最小待ち時間 ～ 最大待ち時間',
	`wait_time_min` INTEGER COMMENT '最小案内時間（分）',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	`registration_no_status` TINYINT default 0 NOT NULL COMMENT '診察券番号メッセージステータス 0:なし(デフォルト)  1:あり',
	`registration_no_msg` VARCHAR(255) COMMENT '診察券番号メッセージ',
	`wait_line_extra` SMALLINT default 0 NOT NULL COMMENT 'N組以上の待ち時間設定',
	`mail_header_ad` VARCHAR(255) COMMENT 'メール文頭AD',
	`continuous_reception_status` TINYINT default 0 NOT NULL COMMENT '連続受付可否設定  0:使用しない 1:使用する',
	`continuous_reception_caption` VARCHAR(50) COMMENT '連続受付ボタン名称',
	`continuous_reception_discription` VARCHAR(50) COMMENT '連続受付説明文',
	`guid_date_print_status` TINYINT COMMENT '待ち基準時間固定の場合の案内予定時間を受付票へ印字設定 0:しない 1:する。',
	`jikansitei_rsv_btn_status` TINYINT default 0 COMMENT '時間指定予約店舗のお客様側タッチパネル 翌日以降受付ボタン表示設定  0:無し 1:有り',
	`number_of_print` TINYINT default 1 NOT NULL COMMENT '受付票印刷枚数 初期値：1枚',
	`guide_button_label_status` TINYINT default 0 NOT NULL COMMENT '案内ボタン文言変更設定 0:デフォルト 1:編集',
	`guide_button_label` VARCHAR(10) default '案内' COMMENT '案内ボタン文言',
	`service_end_status_select` TINYINT default 1 NOT NULL COMMENT '接客完了時のステータス選択 0:有り 1:無し',
	`service_end_button_label_status` TINYINT default 0 NOT NULL COMMENT '接客完了時のステータス選択ボタン設定 0:デフォルト 1:編集',
	`service_end_red_button_label` VARCHAR(4) default '成約' COMMENT '接客完了時赤ボタン文言',
	`service_end_blue_button_label` VARCHAR(4) default '検討' COMMENT '接客完了時青ボタン文言',
	`service_end_green_button_label` VARCHAR(4) default '対応完了' COMMENT '接客完了時緑ボタン文言',
	`service_end_gray_button_label` VARCHAR(4) default '取消' COMMENT '接客完了時灰ボタン文言',
	`touch_serving_stage1_cd` TINYINT default 0 COMMENT '接客中一覧カスタム表示項目1 0:非表示 0以外:表示設定コード',
	`touch_serving_stage2_cd` TINYINT default 0 COMMENT '接客中一覧カスタム表示項目2 0:非表示 0以外:表示設定コード',
	`touch_serving_stage3_cd` TINYINT default 0 COMMENT '接客中一覧カスタム表示項目3 0:非表示 0以外:表示設定コード',
	`multiple_service_status` TINYINT default 1 COMMENT '担当者複数割当のステータス 0:有効 1:無効',
	`neighboring_guidance_status` TINYINT default 0 NOT NULL COMMENT '近隣店舗誘導 0:非表示 1:表示',
	`uketsuke_hakken_status` TINYINT default 0 NOT NULL COMMENT '受付発券 0:しない 1:する。',
	`cancel_frame_use` TINYINT default 1 NOT NULL COMMENT '将来順番予約：キャンセル枠復活機能 0:非表示 1:表示',
	`advance_frame_use` TINYINT default 0 NOT NULL COMMENT '将来順番予約：前倒し案内再予約機能 0:非表示 1:表示',
	`development_view_status` TINYINT default 0 NOT NULL COMMENT '経過時間表示/非表示切り替え 0:非表示 1:表示',
	`mobile_wait_display_status` TINYINT default 0 NOT NULL COMMENT '順番待ち受付停止中表示項目設定 0:待ち組数/待ち時間 1:待ち組数のみ 2:待ち時間のみ',
	`shift_closing_time_by_waiting_time` TINYINT default 0 COMMENT '待ち時間によって携帯予約受付の終了時間を早める 0:有効 1:無効',
	`reserve_regist_status` TINYINT default 0 NOT NULL COMMENT '事前予約登録ボタン表示 0:非表示 1:表示',
	`accepted_chime_call` TINYINT default 0 NOT NULL COMMENT '受付チャイム呼出 0: 使用しない 1: 使用する',
	`voice_guide_auth` TINYINT default 0 NOT NULL COMMENT '音声案内機能利用権限 0: 使用しない 1: 使用する',
	`voice_guide_type` TINYINT default 1 NOT NULL COMMENT '音声案内タイプ選択 1: 会員登録 2: 相互送客',
	`check_button_switching_stage` TINYINT default 1 NOT NULL COMMENT '確認ボタン背景色切り替え段階（default:1） 4段階まで',
	`cancel_button_use` TINYINT UNSIGNED default 1 NOT NULL COMMENT 'タッチパネル スタッフ画面へのキャンセルボタン利用権限 0:表示 1: 非表示',
	`serving_alert_flg` TINYINT default 0 NOT NULL COMMENT '接客中アラートフラグ 0:使用不可 1:使用可',
	`serving_chime_flg` TINYINT default 0 NOT NULL COMMENT '接客中チャイムフラグ 0:使用不可 1:使用可',
	PRIMARY KEY (`id`),
	UNIQUE KEY `uq_shop_reserve_config` (`shop_id`)
) COMMENT='W_インポート用テンポラリ予約共通店舗管理設定';

#-----------------------------------------------------------------------------
#-- w_imp_correct_wait_time
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `w_imp_correct_wait_time`;


CREATE TABLE `w_imp_correct_wait_time`
(
	`id` BIGINT  NOT NULL AUTO_INCREMENT,
	`shop_id` BIGINT,
	`shop_reserve_department_id` BIGINT COMMENT '部門ID',
	`is_department_kbn` TINYINT default 0 COMMENT '部門管理導入区分 0:旧カテゴリー 1:部門管理導入',
	`correct1` SMALLINT default 0 COMMENT '待ち時間変更(補正) 1組目(分)',
	`correct2` SMALLINT default 0 COMMENT '待ち時間変更(補正) 2組目以降(分)',
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	UNIQUE KEY `shop_department_uniq` (`shop_id`, `shop_reserve_department_id`)
) COMMENT='W_インポート用テンポラリ待ち時間補正';

#-----------------------------------------------------------------------------
#-- w_imp_shop_station_data
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `w_imp_shop_station_data`;


CREATE TABLE `w_imp_shop_station_data`
(
	`shop_id` INTEGER default 0 NOT NULL COMMENT '店舗ID',
	`station_id` INTEGER default 0 NOT NULL COMMENT '駅ID',
	`display_order` INTEGER default 0 COMMENT '表示順序',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`shop_id`,`station_id`)
) COMMENT='W_インポート用テンポラリ店舗と駅の紐付けテーブル';

#-----------------------------------------------------------------------------
#-- t_rcv_adjst
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `t_rcv_adjst`;


CREATE TABLE `t_rcv_adjst`
(
	`receive_id` BIGINT  NOT NULL COMMENT '予約受付ID (FK)',
	`parent_rcv_id` BIGINT  NOT NULL COMMENT '親予約受付ID (FK)',
	`created_at` DATETIME  NOT NULL COMMENT '作成年月日',
	`updated_at` DATETIME  NOT NULL COMMENT '更新年月日',
	PRIMARY KEY (`receive_id`),
	KEY `ix_t_rcv_adjst1`(`parent_rcv_id`)
) COMMENT='T_予約調整枠情報';

#-----------------------------------------------------------------------------
#-- h_rcv_adjst_hist
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `h_rcv_adjst_hist`;


CREATE TABLE `h_rcv_adjst_hist`
(
	`receive_id` BIGINT  NOT NULL COMMENT '予約受付ID',
	`parent_rcv_id` BIGINT  NOT NULL COMMENT '親予約受付ID',
	`created_at` DATETIME  NOT NULL COMMENT '作成年月日',
	`updated_at` DATETIME  NOT NULL COMMENT '更新年月日',
	PRIMARY KEY (`receive_id`),
	KEY `ix_h_rcv_adjst_hist1`(`parent_rcv_id`)
) COMMENT='H_予約調整枠情報履歴';

#-----------------------------------------------------------------------------
#-- m_menu_midclass
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `m_menu_midclass`;


CREATE TABLE `m_menu_midclass`
(
	`midclass_id` INTEGER UNSIGNED  NOT NULL COMMENT 'メニュー中分類ID',
	`shop_category_id` INTEGER UNSIGNED  NOT NULL COMMENT '店舗カテゴリID table: shop_category',
	`midclass_name` VARCHAR(40)  NOT NULL COMMENT '「まぐろ」、「サーモン」などの中分類名称 ',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`midclass_id`),
	KEY `uix_M_メニュー中分類マスタ1`(`shop_category_id`, `midclass_name`),
	KEY `ix_M_メニュー中分類マスタ2`(`created_at`),
	KEY `ix_M_メニュー中分類マスタ3`(`updated_at`)
) COMMENT='M_メニュー中分類マスタ定義テーブル';

#-----------------------------------------------------------------------------
#-- h_ord_hist
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `h_ord_hist`;


CREATE TABLE `h_ord_hist`
(
	`ord_hst_id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT '注文履歴、通し番号',
	`member_id` INTEGER  NOT NULL COMMENT 'EPARK会員ID',
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID table: shop',
	`midclass_id` INTEGER UNSIGNED  NOT NULL COMMENT 'メニュー中分類ID table: m_menu_midclass',
	`avg_unt_cst` INTEGER default 0 NOT NULL COMMENT '当日の平均単価',
	`total_payment` INTEGER default 0 NOT NULL COMMENT '当日の支払総額',
	`paid_at` DATETIME COMMENT '会計した日時',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`ord_hst_id`),
	KEY `uix_H_注文履歴1`(`member_id`, `shop_id`, `paid_at`),
	KEY `ix_H_注文履歴2`(`midclass_id`),
	KEY `ix_H_注文履歴3`(`avg_unt_cst`),
	KEY `ix_H_注文履歴4`(`created_at`),
	KEY `ix_H_注文履歴5`(`updated_at`),
	INDEX `h_ord_hist_FI_1` (`shop_id`)
) COMMENT='注文履歴テーブル';

#-----------------------------------------------------------------------------
#-- s_mem_shop_paid
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `s_mem_shop_paid`;


CREATE TABLE `s_mem_shop_paid`
(
	`member_id` INTEGER UNSIGNED  NOT NULL,
	`shop_id` INTEGER UNSIGNED  NOT NULL COMMENT '店舗ID table: shop',
	`midclass_id` INTEGER UNSIGNED  NOT NULL COMMENT 'メニュー中分類ID table: m_menu_midclass',
	`avg_unt_cst` DECIMAL(11,2) UNSIGNED default 0 COMMENT '平均単価(これまでに支払った平均単価)',
	`ttl_paid_cnt` INTEGER UNSIGNED default 0 NOT NULL COMMENT 'これまでの総支払回数',
	`last_paid_at` DATETIME  NOT NULL COMMENT '最後に会計された日時',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`member_id`,`shop_id`),
	KEY `ix_S_会員店舗支払サマリ1`(`avg_unt_cst`),
	KEY `ix_S_会員店舗支払サマリ2`(`midclass_id`),
	KEY `ix_S_会員店舗支払サマリ3`(`ttl_paid_cnt`),
	KEY `ix_S_会員店舗支払サマリ4`(`last_paid_at`),
	KEY `ix_S_会員店舗支払サマリ5`(`created_at`),
	KEY `ix_S_会員店舗支払サマリ6`(`updated_at`),
	INDEX `s_mem_shop_paid_FI_1` (`shop_id`)
) COMMENT='S_会員店舗支払サマリ';

#-----------------------------------------------------------------------------
#-- m_menu_keyword
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `m_menu_keyword`;


CREATE TABLE `m_menu_keyword`
(
	`keyword_id` INTEGER UNSIGNED  NOT NULL COMMENT 'メニューキーワードID',
	`midclass_id` INTEGER UNSIGNED  NOT NULL COMMENT 'メニュー中分類ID',
	`keyword_name` VARCHAR(20)  NOT NULL COMMENT 'キーワード',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`keyword_id`),
	KEY `uix_M_メニュー中分類キーワードマスタ1`(`midclass_id`, `keyword_name`),
	KEY `ix_M_メニュー中分類キーワードマスタ2`(`created_at`),
	KEY `ix_M_メニュー中分類キーワードマスタ3`(`updated_at`)
) COMMENT='M_メニュー中分類キーワードマスタ';

#-----------------------------------------------------------------------------
#-- t_rsv_entry_sub_code
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `t_rsv_entry_sub_code`;


CREATE TABLE `t_rsv_entry_sub_code`
(
	`receive_id` INTEGER  NOT NULL COMMENT '予約受付ID',
	`entry_type` TINYINT COMMENT '予約登録元 0:PC管理画面 1:PC表側 2:携帯管理画面 3:携帯表側 4:タッチパネル管理画面 5:タッチパネル 6:API 7:スマートフォンサイト 98 ：ゲスト（非会員） 99：病院 100：外部API 103：薬局外部連携 ※ 1:PC表側 は使用していない様子',
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID',
	`entry_sub_code` TINYINT COMMENT '予約登録元 1:ポスト受付 100：くすりの窓口 101：薬局マップ 102：Alike(アライク) 103：マピオン 104：ライフパレット　ダイアベティス 105：がんサポート 106：Qlife 107：ビットストリート 108：pathee 109：医療MAP 110： バスいまどこ？(Android) 111： バスいまどこ？(iOS) 112： バスあと何分？(Android) 113： バスあと何分？(iOS) 114: ここドラッグ(Android) 115: 病院チェッカー(Android) 116: 病院チェッカー(iOS) 117: あぐらいふ(Android) 118: あぐらいふ(iOS) 119: FortuneKK 120：病院の通信簿　121：お母さんのための病院の通信簿 122：歯医者さんの通信簿　123：ナースカフェ　124：メディカルモール　125：不動産屋の通信簿　126：癒しの通信簿　 127：日本医学検定協会HP　128：食物アレルギー情報検索サイト『ALLE-MO(アレモ)』　129：子育て応援クラブ『むくむく』　 130：子育て応援クラブ『むくむく』(団体ページ)　131：旭川介護施設Navi　132：一般社団法人　任意後見支援協会　 133：横浜老人ホーム相談センター　134：育児を応援する行政サービスガイド ママフレ　135：ベビペディア　 136：ヘルシーネットワーク　137：EPARK(Yahooロコ用)　138：ココミル　139：メンタルヘルス.jp　140：古岡整形外科　 141：EPARK病院　142：清澤眼科医院　143：お薬手帳アプリ　144：ローカルプレイス　145：ファスパ(Web to Fax)　 146：病院検索スクエル　147：くすりの窓口(テスト用1)　148：くすりの窓口(テスト用2)　149：お薬手帳アプリAndroid　 150：幼稚園協会誌　151：薬局ナビ　152：お医者さんガイド　153：くすりの窓口アプリ(iOS)　154：くすりの窓口アプリ(Android)　 155：大手アプリ 新生堂薬局(iOS)　156：大手アプリ 新生堂薬局(Android)　157：Catchboard　158：株式会社興和サービスアシスト　 159：株式会社セルメスタ　160:エクスペリエンス・コネクト株式会社　161：完成堂藤井薬局　162:健やか　163:EPARKキュア　 164:デジタル診察券アプリ(ios)　165:デジタル診察券アプリ(android)　166:TONEライフログ　167:goo地図　 168：くすりの窓口(テスト用3)　169：くすりの窓口(テスト用4)　170：くすりの窓口(テスト用5)　171：くすりの窓口(テスト用6)　 172：くすりの窓口(テスト用7) 300：EPARKアプリ Android 301：EPARKアプリ iOS 500:順番待ちLINE連携(CWA)(未使用)　501:順番待ちLINE連携(WEBログイン)(未使用)　502:順番待ちLINE連携(SME)(未使用) 504:Cardbook　505:順番待ちLINE連携(BNC)　506:CardBookからの順番待ちLINE連携 1000：ゆうてんじ内科 1001：南堺病院 1002：三井記念病院 1003：勝楽堂病院 1004：三芳野病院 1005：さくら通りクリニック 1006：阪南中央病院 1007：　豊田地域医療センター 1008：埼玉西協同病院　1009：世田谷下田総合病院　1010：総合母子保健センター愛育病院　1011：興和会 右田病院　 1012：恩賜財団東京都同胞援護会 昭島病院　1013：人形町こどもクリニック　1014:卓秀会 平塚胃腸病院　 1015:自治医科大学附属病院　1016：東鷲宮病院　1017：北里大学北里研究所病院　1018：洛西ニュータウン病院　 1019：大阪掖済会病院　1020：医療法人庸愛会 富田町病院　1021：医療法人健和会 うえだ下田部病院 1022：西横浜国際総合病院　 1023：独立行政法人 国立病院機構 災害医療センター　1024：聖霊病院　1025：医療法人社団 昌医会 葛西昌医会病院　 1026：医療法人財団慈生会野村病院　1027：公益財団法人東京都医療保健協会 練馬総合病院　 1028：愛育クリニック　1029：社会福祉法人賛育会 賛育会病院　1030：一般財団法人 仁和会総合病院　 1031：医療法人社団永生会 南多摩病院　1032：順天堂大学医学部附属練馬病院　1033:EPARKヘルスケア デバック＆テスト用コード01　 1034:かもりクリニック　1035:EPARKヘルスケア デバック＆テスト用コード03　1036:関東労災病院　 1037:医療法人徳洲会 東京西徳洲会病院　1038:独立行政法人 新小山市民病院　1039:関東中央病院　1040:佐野厚生総合病院　 1041:使用先未定病院FAX用コード1　1042:使用先未定病院FAX用コード2　1043:使用先未定病院FAX用コード3　1044:使用先未定病院FAX用コード4 1045:使用先未定病院FAX用コード5　1046:使用先未定病院FAX用コード6　1047:使用先未定病院FAX用コード7　1048:使用先未定病院FAX用コード8 1049:使用先未定病院FAX用コード9　1050:使用先未定病院FAX用コード10　',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`receive_id`),
	INDEX `t_rsv_entry_sub_code_FI_1` (`shop_id`)
) COMMENT='T_エントリータイプサブコード';

#-----------------------------------------------------------------------------
#-- shop_extra_open
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `shop_extra_open`;


CREATE TABLE `shop_extra_open`
(
	`shop_extra_open_id` INTEGER  NOT NULL AUTO_INCREMENT,
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID',
	`open_date` DATETIME COMMENT 'オープン日',
	`open1_start` TIME  NOT NULL COMMENT '営業時間1の開始時間',
	`open1_close` TIME  NOT NULL COMMENT '営業時間1の終了時間',
	`open2_start` TIME COMMENT '営業時間2の開始時間',
	`open2_close` TIME COMMENT '営業時間2の終了時間',
	`open3_start` TIME COMMENT '営業時間3の開始時間',
	`open3_close` TIME COMMENT '営業時間3の終了時間',
	`order_stop` INTEGER COMMENT '受付終了時間',
	`open24` TINYINT COMMENT '24時間営業 1:24時間営業 0:24時間営業ではない',
	`mobile1_start` TIME  NOT NULL COMMENT '携帯受付時間1の開始時間',
	`mobile1_close` TIME  NOT NULL COMMENT '携帯受付時間1の終了時間',
	`mobile2_start` TIME COMMENT '携帯受付時間2の開始時間',
	`mobile2_close` TIME COMMENT '携帯受付時間2の終了時間',
	`mobile3_start` TIME COMMENT '携帯受付時間3の開始時間',
	`mobile3_close` TIME COMMENT '携帯受付時間3の終了時間',
	`mobile24` TINYINT COMMENT '24時間受付 1:24時間受付 0:24時間受付ではない',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`shop_extra_open_id`),
	KEY `ix_shop_extra_open1`(`shop_id`),
	KEY `uix_shop_extra_open1`(`open_date`, `shop_id`)
) COMMENT='臨時営業日設定';

#-----------------------------------------------------------------------------
#-- i_extra_open_reason
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `i_extra_open_reason`;


CREATE TABLE `i_extra_open_reason`
(
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID',
	`message` VARCHAR(200)  NOT NULL COMMENT 'メッセージ',
	`publish_start_at` DATETIME  NOT NULL COMMENT '掲載開始日時',
	`publish_end_at` DATETIME  NOT NULL COMMENT '掲載終了日時',
	`created_at` DATETIME  NOT NULL COMMENT '登録日時',
	`updated_at` DATETIME  NOT NULL COMMENT '更新日時',
	PRIMARY KEY (`shop_id`)
) COMMENT='I_臨時営業理由';

#-----------------------------------------------------------------------------
#-- w_imp_shop_rsv_department
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `w_imp_shop_rsv_department`;


CREATE TABLE `w_imp_shop_rsv_department`
(
	`id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT '部門ID',
	`shop_id` BIGINT COMMENT '店舗ID',
	`name` VARCHAR(100) COMMENT '部門名',
	`max_num` BIGINT COMMENT '最大値　(受入数)',
	`min_num` BIGINT COMMENT '最小値　(受入数)',
	`seat` SMALLINT COMMENT '席数',
	`regist_no_char` VARCHAR(80) COMMENT '受付ＮＯ名称',
	`regist_no_current` INTEGER default 1 COMMENT '受付ＮＯカレント値（00000）',
	`regist_no_current_digits` SMALLINT default 3 COMMENT '受付ＮＯカレント値表示桁数：1～５',
	`is_dochirademo` VARCHAR(255) default '1' COMMENT 'どちらでも対象区分 ０：対象外 1:対象',
	`display_on_toutchpanel` TINYINT default 0 COMMENT '受付用タッチパネル表示区分 0:非表示 1:表示',
	`display_on_mobile` TINYINT default 1 COMMENT 'モバイルサイト表示区分 0:非表示 1:表示',
	`display_order` TINYINT default 0 COMMENT '画面表示順',
	`status` SMALLINT default 1 COMMENT '反映状況 0:停止中 １:反映中',
	`is_deleted` SMALLINT default 0 COMMENT '削除フラグ 0:有効データ 1：削除済要否は検討',
	`wait_line_extra` SMALLINT default 0 NOT NULL COMMENT 'N組以上の待ち時間設定',
	`print_message` VARCHAR(100) COMMENT '発券下部のメッセージ',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	`department_msg` VARCHAR(255) COMMENT '部門説明文',
	`regist_no_range_min` INTEGER COMMENT '受付番号範囲最小値 ※shop_reserve_department_description.banknotes = 3（発券連番方法＝「部門ごと（範囲設定）」）のときのみ有効',
	`regist_no_range_max` INTEGER COMMENT '受付番号範囲最大値 ※shop_reserve_department_description.banknotes = 3（発券連番方法＝「部門ごと（範囲設定）」）のときのみ有効',
	`waiting_time_touchpanel` TINYINT default 1 COMMENT 'タッチパネル待ち時間表示 0:非表示 1:表示',
	`waiting_time_mobile` TINYINT default 1 COMMENT 'モバイルサイト待ち時間表示 0:非表示 1:表示',
	`wait_time_display_type` TINYINT default 1 NOT NULL COMMENT '待ち時間表示タイプ 1: 最大待ち時間 2: 最小待ち時間 ～ 最大待ち時間',
	`wait_time_min` INTEGER COMMENT '最小案内時間（分）',
	`reserve_type` TINYINT default 0 COMMENT '予約タイプ 0:順番待ち 1:予約　※shop.screen_kind = 3 (D:時間指定・順番待ち併用受付仕様) の場合のみ有効',
	`department_attention` VARCHAR(255) COMMENT '部門注意書き ※shop.screen_kind = 3 (D:時間指定・順番待ち併用受付仕様) の場合のみ有効',
	`department_attention_mobile` VARCHAR(255) COMMENT '携帯表示用部門注意書き ※shop.screen_kind = 3 (D:時間指定・順番待ち併用受付仕様) の場合のみ有効',
	`receipt_date_print` TINYINT default 1 COMMENT '案内予定時刻印刷 0:しない 1:する　※shop.screen_kind = 3 (D:時間指定・順番待ち併用受付仕様) の場合のみ有効',
	`service_time` INTEGER default 0 NOT NULL COMMENT '接客時間',
	`reserve_limit` INTEGER default 0 NOT NULL COMMENT '受付組数',
	`wait_status` TINYINT default 1 NOT NULL COMMENT '順番待ち予約可否 1: 許可 2: 不許可',
	`reserve_status` TINYINT default 1 NOT NULL COMMENT '将来順番予約可否 1: 許可 2: 不許可',
	`group_id` BIGINT  NOT NULL COMMENT '席連動グループID',
	`svc_alt_min` TINYINT COMMENT '接客終了アラート分 [-]接客終了時刻の「n分前」 [+]接客終了時刻の「n分後」',
	PRIMARY KEY (`id`)
) COMMENT='W_インポート用テンポラリ部門マスタデータを格納';

#-----------------------------------------------------------------------------
#-- w_imp_shop_rsv_dept_cond
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `w_imp_shop_rsv_dept_cond`;


CREATE TABLE `w_imp_shop_rsv_dept_cond`
(
	`id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT '選択条件ID',
	`shop_id` BIGINT  NOT NULL COMMENT '店舗ID',
	`name` VARCHAR(100) COMMENT '条件名',
	`status` TINYINT COMMENT '条件の可否 0：有効 1：無効',
	`is_deleted` TINYINT COMMENT '削除フラグ（0:有効データ、1：削除済）要否は検討',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`)
) COMMENT='W_インポート用テンポラリ部門選択条件データを格納する';

#-----------------------------------------------------------------------------
#-- w_imp_shop_rsv_dept_desc
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `w_imp_shop_rsv_dept_desc`;


CREATE TABLE `w_imp_shop_rsv_dept_desc`
(
	`id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT 'ID',
	`shop_id` BIGINT  NOT NULL COMMENT '店舗ID',
	`description` TEXT COMMENT '説明文',
	`comment` TEXT COMMENT '注意書き',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	`banknotes` TINYINT default 0 NOT NULL COMMENT '発券連番方法 0:部門ごと 1:連番 2:ランダム 3:部門ごと（範囲設定）',
	`list_confirm` TINYINT default 1 NOT NULL COMMENT '一覧確認ボタン 0:有り 1:無し',
	`criteria_both_status` TINYINT default 1 NOT NULL COMMENT 'どちらでもの副表示・非表示 0:表示 1:非表示',
	`sort_type` TINYINT  NOT NULL COMMENT '受付データの並び順 0:案内予定が早い順 1:受付順',
	`number_disp_status` TINYINT default 1 NOT NULL COMMENT '受付順・案内順の番号 0:非表示 1:表示',
	`wait_time_disp_total` TINYINT default 0 NOT NULL COMMENT '待ち時間、待ち組数の累計表示 0: 無し 1: 有り',
	`department_name` VARCHAR(40) COMMENT '部門機能の名称',
	`interlocking_seat_reserve_time_pitch` INTEGER default 0 NOT NULL COMMENT '将来順番予約　予約時間ピッチ（分）',
	PRIMARY KEY (`id`),
	UNIQUE KEY `shop_id` (`shop_id`)
) COMMENT='W_インポート用テンポラリ店舗部門管理設定の説明文・注意書き';

#-----------------------------------------------------------------------------
#-- w_imp_shop_rsv_dept_cond_map
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `w_imp_shop_rsv_dept_cond_map`;


CREATE TABLE `w_imp_shop_rsv_dept_cond_map`
(
	`id` BIGINT  NOT NULL AUTO_INCREMENT,
	`shop_id` BIGINT COMMENT '店舗ID',
	`shop_reserve_department_condition_id` BIGINT  NOT NULL COMMENT '選択条件ID',
	`shop_reserve_department_id` BIGINT COMMENT '部門ID',
	`condition_value_max` BIGINT COMMENT '設定値 最大値',
	`condition_value_min` BIGINT COMMENT '設定値　最小値',
	`is_deleted` TINYINT default 0 COMMENT '削除フラグ 0:有効データ 1：削除済',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`)
) COMMENT='W_インポート用テンポラリ部門選択条件に紐付く部門データを格納する。';

#-----------------------------------------------------------------------------
#-- w_imp_shop_rsv_dept_cat_map
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `w_imp_shop_rsv_dept_cat_map`;


CREATE TABLE `w_imp_shop_rsv_dept_cat_map`
(
	`id` BIGINT  NOT NULL,
	`shop_id` BIGINT COMMENT '店舗ID',
	`shop_reserve_department_id` BIGINT COMMENT '部門ID',
	`shop_reserve_category_id` BIGINT COMMENT '予約カテゴリID',
	`display_order` TINYINT COMMENT '画面表示順',
	`status` SMALLINT default 0 COMMENT '運用ステータス 0:反映中 1:停止中',
	`is_deleted` SMALLINT default 0 COMMENT '削除フラグ 0:有効データ 1：削除済  要否は検討',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	KEY `index_shop_id`(`shop_id`),
	KEY `index_shop_reserve_department_id`(`shop_reserve_department_id`),
	KEY `index_shop_reserve_category_id`(`shop_reserve_category_id`)
) COMMENT='W_インポート用テンポラリ部門毎予約カテゴリ';

#-----------------------------------------------------------------------------
#-- w_imp_shop_rsv_conv_cat_opt
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `w_imp_shop_rsv_conv_cat_opt`;


CREATE TABLE `w_imp_shop_rsv_conv_cat_opt`
(
	`id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT 'オプションＩＤ',
	`shop_id` BIGINT COMMENT 'ショップＩＤ',
	`shop_reserve_conventional_category_id` BIGINT COMMENT '予約カテゴリＩＤ',
	`display_order` TINYINT COMMENT '表示順',
	`name` VARCHAR(20) COMMENT '名称',
	`mobile` TINYINT default 0 COMMENT '携帯サイトに表示するか 0:表示　1:非表示',
	`num_max` INTEGER default 0 COMMENT '選択可能最大値',
	`num_min` INTEGER default 0 COMMENT '選択可能最小値',
	`parent_option_ids` VARCHAR(100) COMMENT '上位カテゴリーのIDを,区切りで指定 ここに記述したIDを選択している時、このオプションを選択できる',
	`input_skip_flg` TINYINT default 0 NOT NULL COMMENT '上位カテゴリの入力スキップフラグ',
	`status` TINYINT default 0 COMMENT '承認　 ０：承認　1：非承認',
	`admin_status` TINYINT default 0 COMMENT '（管理画面設定）承認　 ０：承認　1：非承認',
	`memo` VARCHAR(200) COMMENT '備考',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`)
) COMMENT='W_インポート用テンポラリ旧EPARK のカテゴリーの選択肢のオプション(上位、下位あり)';

#-----------------------------------------------------------------------------
#-- w_imp_shop_rsv_conv_cat
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `w_imp_shop_rsv_conv_cat`;


CREATE TABLE `w_imp_shop_rsv_conv_cat`
(
	`id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT '予約カテゴリＩＤ',
	`shop_id` BIGINT COMMENT '店舗ＩＤ',
	`display_order` TINYINT COMMENT '表示順',
	`name` VARCHAR(100) COMMENT '名称',
	`description` VARCHAR(100) COMMENT '説明',
	`attention` VARCHAR(100) COMMENT '項目注意書き',
	`type` TINYINT default 0 COMMENT '入力タイプ 0:テキスト 1:数値 2:選択肢',
	`attribute` TINYINT default 0 COMMENT '属性 0：無し 1:人数 2:名前 3:電話番号 4:診察券番号',
	`reserve` TINYINT default 0 COMMENT '(携帯用フラグ)順番待ち 0:使用する １：使用しない member_mobileの順番待ちのみの予約でこのカテゴリを使用するかしないか',
	`booking` TINYINT default 0 COMMENT '(携帯用フラグ)時間指定予約・将来順番受付 0:使用する １：使用しない member_mobile,shop_pcの時間指定・将来順番受付のみで使用するかしないか',
	`touchpanel` TINYINT default 0 COMMENT 'タッチパネル(予約登録)で使用 0:使用する １：使用しない shop_touchの店頭受付画面・店舗案内画面の 順番待ち予約・将来順番受付・時間指定予約で使用するかしないか、 shop_touch予約登録全般での使用の可否 reserve_status に影響されない',
	`touchpanel_reception` TINYINT default 0 NOT NULL COMMENT 'タッチパネル受付画面で使用 0:使用する 1:使用しない',
	`touchpanel_staff` TINYINT default 0 NOT NULL COMMENT 'タッチパネルスタッフ画面で使用 0:使用する 1:使用しない',
	`touchpanel_reserve` TINYINT default 0 NOT NULL COMMENT 'タッチパネル予約登録で使用 0:使用する 1:使用しない',
	`touchpanel_staff_category_display_status` TINYINT default 0 NOT NULL COMMENT 'スタッフ画面のカテゴリ設定ページでの予約カテゴリボタン表示 0:使用する 1:使用しない',
	`disp_panel` TINYINT default 0 COMMENT 'タッチパネル(店頭画面)に表示 0:使用する １：使用しない shop_touchの店頭受付画面(トップページ)にカテゴリを表示するかしないか。 カテゴリーの入力する・しないには影響しない トップページの予約一覧にこのカテゴリーを表示させるかどうかのみの設定',
	`continuous_reception` TINYINT default 1 NOT NULL COMMENT '連続受付で使用 0:使用する　１：使用しない',
	`touchpanel_staff_immediate_guide` TINYINT default 1 NOT NULL COMMENT '即時案内使用可否 使用する：0  使用しない：1',
	`text_type` TINYINT default 0 COMMENT 'テキスト入力タイプ 0:全角かな 1:半角英数 2:半角数値',
	`text_max` SMALLINT COMMENT '文字列最大文字数',
	`text_min` SMALLINT COMMENT '文字列最小文字数',
	`num_max` INTEGER COMMENT '最大数値',
	`num_min` INTEGER COMMENT '最小数値',
	`parent_id` BIGINT COMMENT '上位カテゴリ番号',
	`use_condition_category_id` BIGINT COMMENT '使用条件カテゴリID',
	`use_condition_category_option_ids` VARCHAR(100) COMMENT '仕様条件カテゴリオプションID（カンマ区切り）。use_condition_category_id がある場合、ここで指定したIDのオプションが選択されている場合にのみ表示される。',
	`status` TINYINT default 0 COMMENT '承認 ０：有効　１：無効',
	`admin_status` TINYINT default 0 COMMENT '（管理画面設定）承認 ０：有効　１：無効',
	`memo` VARCHAR(255) COMMENT '備考',
	`receive_print` TINYINT default 0 COMMENT '（店舗管理）受付一覧レポート 0:表示する 1:表示しない',
	`ticket_print_flg` TINYINT UNSIGNED default 0 COMMENT '発券用紙印字フラグ 0:印字しない 1:印字する',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	KEY `index_shop_id`(`shop_id`)
) COMMENT='W_インポート用テンポラリ旧EPARK のカテゴリー(上位、下位あり)';

#-----------------------------------------------------------------------------
#-- w_imp_shop_rsv_cat
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `w_imp_shop_rsv_cat`;


CREATE TABLE `w_imp_shop_rsv_cat`
(
	`id` BIGINT  NOT NULL COMMENT '予約カテゴリID',
	`shop_id` BIGINT COMMENT '店舗ID',
	`display_order` TINYINT COMMENT '表示順',
	`name` VARCHAR(100) COMMENT '予約カテゴリ 名称',
	`description` VARCHAR(100) COMMENT '予約カテゴリ　説明文',
	`attention` VARCHAR(100) COMMENT '予約カテゴリ　注釈文',
	`type` TINYINT COMMENT '入力タイプ 0:テキスト 1:数値 2:選択肢',
	`attribute` TINYINT COMMENT '属性 0：無し 1:人数 2:名前 3:電話番号 4:診察券番号',
	`reserve` TINYINT COMMENT '順番待ち 0:使用する　１：使用しない',
	`booking` TINYINT COMMENT '時間指定予約・将来順番受付 0:使用する　１：使用しない',
	`touchpanel` TINYINT COMMENT 'タッチパネル(予約登録)で使用 0:使用する　１：使用しない',
	`touchpanel_reception` TINYINT default 1 NOT NULL COMMENT 'タッチパネル受付画面で使用 0:使用する 1:使用しない',
	`touchpanel_staff` TINYINT default 1 NOT NULL COMMENT 'タッチパネルスタッフ画面で使用 0:使用する 1:使用しない',
	`touchpanel_reserve` TINYINT default 1 NOT NULL COMMENT 'タッチパネル予約登録で使用 0:使用する 1:使用しない',
	`touchpanel_staff_category_display_status` TINYINT default 0 COMMENT 'スタッフ画面のカテゴリ設定ページでの予約カテゴリボタン表示 0:使用する 1:使用しない',
	`disp_panel` TINYINT COMMENT 'タッチパネル(店頭画面)に表示 0:使用する　１：使用しない',
	`continuous_reception` TINYINT default 1 NOT NULL COMMENT '連続受付で使用 0:使用する　１：使用しない',
	`touchpanel_staff_immediate_guide` TINYINT default 1 NOT NULL COMMENT '即時案内使用可否 使用する：0  使用しない：1',
	`text_type` TINYINT COMMENT '文字列タイプ 0:全角かな 1:半角英数 2:半角数値',
	`text_max` SMALLINT COMMENT '文字列最大文字数',
	`text_min` SMALLINT COMMENT '文字列最小文字数',
	`num_max` INTEGER COMMENT '最大数値',
	`num_min` INTEGER COMMENT '最小数値',
	`use_condition_category_id` BIGINT COMMENT '使用条件カテゴリID',
	`use_condition_category_option_ids` VARCHAR(100) COMMENT '仕様条件カテゴリオプションID（カンマ区切り）。use_condition_category_id がある場合、ここで指定したIDのオプションが選択されている場合にのみ表示される。',
	`memo` VARCHAR(255) COMMENT '備考 ０：有効　１：無効',
	`status` SMALLINT default 0 COMMENT '運用ステータス 0:反映中 1:停止中',
	`admin_status` SMALLINT default 0 COMMENT '（管理画面設定）運用ステータス 0:反映中 1:停止中',
	`is_deleted` SMALLINT default 0 COMMENT '削除フラグ 0:有効データ 1：削除済  要否は検討',
	`receive_print` TINYINT default 0 COMMENT '（店舗管理）受付一覧レポート 0:表示する 1:表示しない',
	`ticket_print_flg` TINYINT UNSIGNED default 0 COMMENT '発券用紙印字フラグ 0:印字しない 1:印字する',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`)
) COMMENT='W_インポート用テンポラリ予約カテゴリマスタ';

#-----------------------------------------------------------------------------
#-- w_imp_shop_display_mst
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `w_imp_shop_display_mst`;


CREATE TABLE `w_imp_shop_display_mst`
(
	`shop_id` BIGINT  NOT NULL COMMENT '店舗ＩＤ',
	`type` TINYINT default 0 NOT NULL COMMENT '\'共通 店舗種別 0:部門管理共通 １：メガネショップ用\'',
	`title` VARCHAR(50) COMMENT '部門なし タイトル',
	`display_type` TINYINT default 0 COMMENT '\'部門なし 表示機タイプ 0:N1、１：N2、2:N3、3：NM\'',
	`unit_type` TINYINT default 0 COMMENT '\'表記タイプ 0:人数表記 1:組数表記\'',
	`button_name` VARCHAR(20) COMMENT '部門なし ボタン名表示',
	`type_1_title` VARCHAR(20) COMMENT '部門なし 表示機タイプ1タイトル',
	`type_1_right_msg` VARCHAR(100) COMMENT '部門なし 表示機タイプ1完了表示版右MSG',
	`type_1_footer_msg` VARCHAR(100) COMMENT '部門なし 表示機タイプ1完了表示版下MSG',
	`type_2_title` VARCHAR(20) COMMENT '部門なし 表示機タイプ2タイトル',
	`type_2_right_msg` VARCHAR(100) COMMENT '部門なし 表示機タイプ2完了表示版右MSG',
	`type_2_footer_msg` VARCHAR(100) COMMENT '部門なし 表示機タイプ2完了表示版下MSG',
	`b1_type_status` TINYINT default 0 COMMENT '\'利用する表示機タイプ B1 0:利用しない 1:利用する\'',
	`b2_type_status` TINYINT default 0 COMMENT '\'利用する表示機タイプ B2 0:利用しない 1:利用する\'',
	`b3_type_status` TINYINT default 0 COMMENT '\'利用する表示機タイプ B3 0:利用しない 1:利用する\'',
	`b1_telop_status` TINYINT default 1 COMMENT '\'部門あり B1 テロップ状態 0:なし、1:あり\'',
	`b1_telop` VARCHAR(200) COMMENT '部門あり B1 テロップ内容',
	`b2_telop_status` TINYINT default 1 COMMENT '\'部門あり B2 テロップ状態 0:なし、1:あり\'',
	`b2_telop` VARCHAR(200) COMMENT '部門あり B2テロップ内容',
	`b3_telop_status` TINYINT default 1 COMMENT '\'部門あり B3 テロップ状態 0:なし、1:あり\'',
	`b3_telop` VARCHAR(200) COMMENT '部門あり B3 テロップ内容',
	`b1_item_guide_status` TINYINT default 0 COMMENT '\'表示する項目状態 案内中 0:非表示 1:表示\'',
	`b1_item_receive_no_status` TINYINT default 0 COMMENT '\'表示する項目状態 受付番号 0:非表示 1:表示\'',
	`b1_item_receive_type` TINYINT default 0 COMMENT '\'表示する項目状態 受付番号タイプ 0:1列 1:3列\'',
	`b1_item_unit_status` TINYINT default 0 COMMENT '\'表示する項目状態 待ち組数 0:非表示 1:表示\'',
	`b1_item_wait_time_status` TINYINT default 0 COMMENT '\'表示する項目状態 待ち時間 0:非表示 1:表示\'',
	`b2_item_receive_limit` TINYINT default 0 COMMENT '\'表示する項目状態 X人目までの受付番号 \'',
	`b1_block_status` TINYINT default 0 COMMENT '\'項目順番・文言設定状態 B1 0：デフォルト 1:編集\'',
	`b1_receive_title` VARCHAR(20) COMMENT '文言設定B1 受付項目',
	`b1_guide_title` VARCHAR(20) COMMENT '文言設定B1 案内中',
	`b1_receive_no_title` VARCHAR(20) COMMENT '文言設定B1 受付番号',
	`b1_wait_unit_title` VARCHAR(20) COMMENT '文言設定B1 待ち組数',
	`b1_wait_time_title` VARCHAR(20) COMMENT '文言設定B1 待ち時間',
	`b1_guide_sort_no` TINYINT COMMENT '\'文言設定B1 案内中 順序\'',
	`b1_receive_sort_no` TINYINT COMMENT '\'文言設定B1 受付番号 順序\'',
	`b1_wait_unit_sort_no` TINYINT COMMENT '\'文言設定B1 待ち組数 順序\'',
	`b1_wait_time_sort_no` TINYINT COMMENT '\'文言設定B1 待ち時間 順序\'',
	`b3_block_status` TINYINT default 0 COMMENT '\'項目順番・文言設定状態 B3\'',
	`b3_call_no_title` VARCHAR(20) COMMENT '項目順番・文言設定 B3',
	`b1_called_status` TINYINT default 0 COMMENT '\'呼出済み表示文言状態 B1 0：デフォルト、1：編集\'',
	`b1_called_msg` VARCHAR(20) COMMENT '呼出済み表示文言',
	`b2_called_status` TINYINT default 0 COMMENT '\'呼出済み表示文言状態 B1 0：デフォルト、1：編集\'',
	`b2_called_msg` VARCHAR(20) COMMENT '呼出済み表示文言',
	`calling_display_status` TINYINT default 1 COMMENT '\'共通 呼出中の画面利用 0:あり 1:なし\'',
	`return_type` TINYINT default 0 COMMENT '\'呼出中画面からの戻り先 0: B1(待ち状況 ,1: B2 受付番号, 2:B3 呼出済み\'',
	`calling_title_status` TINYINT default 0 COMMENT '\'呼出中画面の文言状態 0: デフォルト ,1: 呼び出した番号の部門なを表示, 2:フリーワード\'',
	`calling_title` VARCHAR(50) COMMENT '呼出中画面の文言設定（デフォルト：カウンターまでおこしください）',
	`calling_upper_text` VARCHAR(30) COMMENT '呼出中画面の上段文言設定',
	`calling_lower_text` VARCHAR(30) COMMENT '呼出中画面の下段文言設定',
	`shop_glass_type` TINYINT default 1 COMMENT '\'1: あり(JINS店舗 1台運用), 2: あり(JINS店舗 2台運用),3:あり（NEWメガネショップ用）\'',
	`voice_link_status` TINYINT default 0 COMMENT '\'呼出ボタンの利用可否 0：なし 1：あり\'',
	`counter_display_status` TINYINT default 0 COMMENT '\'カウンター選択画面の利用可否 0：なし 1：カウンター表示機を利用(旧：あり) 2：既存の音声サーバーを利用\'',
	`counter_display_broadcast_status` TINYINT default 0 COMMENT '\'カウンター表示機の一斉送信機能利用可否 0：off 1：on\'',
	`counter_no_broadcast_status` TINYINT default 0 COMMENT '\'カウンター表示機呼出カウンター番号呼出機能 0：off 1：on\'',
	`external_voice_call` TINYINT default 0 NOT NULL COMMENT '外部音声呼出 0:使用しない 1:使用する',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`shop_id`),
	UNIQUE KEY `uq_shop_display_mst` (`shop_id`)
) COMMENT='W_インポート用テンポラリ店舗表示機管理マスタ';

#-----------------------------------------------------------------------------
#-- w_imp_line_weekday
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `w_imp_line_weekday`;


CREATE TABLE `w_imp_line_weekday`
(
	`id` BIGINT  NOT NULL AUTO_INCREMENT,
	`shop_id` BIGINT,
	`shop_reserve_department_id` BIGINT,
	`is_department_kbn` TINYINT default 0 COMMENT '部門管理導入区分 0:旧カテゴリー 1:部門管理導入',
	`service_time` INTEGER,
	`service_time_extra` INTEGER COMMENT 'N組以上の平均サービス時間',
	`wait_default` INTEGER,
	`wait_default_extra` INTEGER COMMENT 'N組以上の平均到達組数',
	`wait_lock` TINYINT,
	`wait_0` DECIMAL(4,1),
	`wait_1` DECIMAL(4,1),
	`wait_2` DECIMAL(4,1),
	`wait_3` DECIMAL(4,1),
	`wait_4` DECIMAL(4,1),
	`wait_5` DECIMAL(4,1),
	`wait_6` DECIMAL(4,1),
	`wait_7` DECIMAL(4,1),
	`wait_8` DECIMAL(4,1),
	`wait_9` DECIMAL(4,1),
	`wait_10` DECIMAL(4,1),
	`wait_11` DECIMAL(4,1),
	`wait_12` DECIMAL(4,1),
	`wait_13` DECIMAL(4,1),
	`wait_14` DECIMAL(4,1),
	`wait_15` DECIMAL(4,1),
	`wait_16` DECIMAL(4,1),
	`wait_17` DECIMAL(4,1),
	`wait_18` DECIMAL(4,1),
	`wait_19` DECIMAL(4,1),
	`wait_20` DECIMAL(4,1),
	`wait_21` DECIMAL(4,1),
	`wait_22` DECIMAL(4,1),
	`wait_23` DECIMAL(4,1),
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	UNIQUE KEY `shop_department_uniq` (`shop_id`, `shop_reserve_department_id`)
);

#-----------------------------------------------------------------------------
#-- w_imp_line_weekday_2
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `w_imp_line_weekday_2`;


CREATE TABLE `w_imp_line_weekday_2`
(
	`id` BIGINT  NOT NULL AUTO_INCREMENT,
	`shop_id` BIGINT,
	`shop_reserve_department_id` BIGINT,
	`is_department_kbn` TINYINT default 0 COMMENT '部門管理導入区分 0:旧カテゴリー 1:部門管理導入',
	`service_time` INTEGER,
	`service_time_extra` INTEGER COMMENT 'N組以上の平均サービス時間',
	`wait_default` INTEGER,
	`wait_default_extra` INTEGER COMMENT 'N組以上の平均到達組数',
	`wait_lock` TINYINT,
	`wait_0` DECIMAL(4,1),
	`wait_1` DECIMAL(4,1),
	`wait_2` DECIMAL(4,1),
	`wait_3` DECIMAL(4,1),
	`wait_4` DECIMAL(4,1),
	`wait_5` DECIMAL(4,1),
	`wait_6` DECIMAL(4,1),
	`wait_7` DECIMAL(4,1),
	`wait_8` DECIMAL(4,1),
	`wait_9` DECIMAL(4,1),
	`wait_10` DECIMAL(4,1),
	`wait_11` DECIMAL(4,1),
	`wait_12` DECIMAL(4,1),
	`wait_13` DECIMAL(4,1),
	`wait_14` DECIMAL(4,1),
	`wait_15` DECIMAL(4,1),
	`wait_16` DECIMAL(4,1),
	`wait_17` DECIMAL(4,1),
	`wait_18` DECIMAL(4,1),
	`wait_19` DECIMAL(4,1),
	`wait_20` DECIMAL(4,1),
	`wait_21` DECIMAL(4,1),
	`wait_22` DECIMAL(4,1),
	`wait_23` DECIMAL(4,1),
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	UNIQUE KEY `shop_department_uniq` (`shop_id`, `shop_reserve_department_id`)
);

#-----------------------------------------------------------------------------
#-- w_imp_line_holiday
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `w_imp_line_holiday`;


CREATE TABLE `w_imp_line_holiday`
(
	`id` BIGINT  NOT NULL AUTO_INCREMENT,
	`shop_id` BIGINT,
	`shop_reserve_department_id` BIGINT,
	`is_department_kbn` TINYINT default 0 COMMENT '部門管理導入区分 0:旧カテゴリー 1:部門管理導入',
	`service_time` INTEGER,
	`service_time_extra` INTEGER COMMENT 'N組以上の平均サービス時間',
	`wait_default` INTEGER,
	`wait_default_extra` INTEGER COMMENT 'N組以上の平均到達組数',
	`wait_lock` TINYINT,
	`wait_0` DECIMAL(4,1),
	`wait_1` DECIMAL(4,1),
	`wait_2` DECIMAL(4,1),
	`wait_3` DECIMAL(4,1),
	`wait_4` DECIMAL(4,1),
	`wait_5` DECIMAL(4,1),
	`wait_6` DECIMAL(4,1),
	`wait_7` DECIMAL(4,1),
	`wait_8` DECIMAL(4,1),
	`wait_9` DECIMAL(4,1),
	`wait_10` DECIMAL(4,1),
	`wait_11` DECIMAL(4,1),
	`wait_12` DECIMAL(4,1),
	`wait_13` DECIMAL(4,1),
	`wait_14` DECIMAL(4,1),
	`wait_15` DECIMAL(4,1),
	`wait_16` DECIMAL(4,1),
	`wait_17` DECIMAL(4,1),
	`wait_18` DECIMAL(4,1),
	`wait_19` DECIMAL(4,1),
	`wait_20` DECIMAL(4,1),
	`wait_21` DECIMAL(4,1),
	`wait_22` DECIMAL(4,1),
	`wait_23` DECIMAL(4,1),
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	UNIQUE KEY `shop_department_uniq` (`shop_id`, `shop_reserve_department_id`)
);

#-----------------------------------------------------------------------------
#-- w_imp_line_holiday_2
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `w_imp_line_holiday_2`;


CREATE TABLE `w_imp_line_holiday_2`
(
	`id` BIGINT  NOT NULL AUTO_INCREMENT,
	`shop_id` BIGINT,
	`shop_reserve_department_id` BIGINT,
	`is_department_kbn` TINYINT default 0 COMMENT '部門管理導入区分 0:旧カテゴリー 1:部門管理導入',
	`service_time` INTEGER,
	`service_time_extra` INTEGER COMMENT 'N組以上の平均サービス時間',
	`wait_default` INTEGER,
	`wait_default_extra` INTEGER COMMENT 'N組以上の平均到達組数',
	`wait_lock` TINYINT,
	`wait_0` DECIMAL(4,1),
	`wait_1` DECIMAL(4,1),
	`wait_2` DECIMAL(4,1),
	`wait_3` DECIMAL(4,1),
	`wait_4` DECIMAL(4,1),
	`wait_5` DECIMAL(4,1),
	`wait_6` DECIMAL(4,1),
	`wait_7` DECIMAL(4,1),
	`wait_8` DECIMAL(4,1),
	`wait_9` DECIMAL(4,1),
	`wait_10` DECIMAL(4,1),
	`wait_11` DECIMAL(4,1),
	`wait_12` DECIMAL(4,1),
	`wait_13` DECIMAL(4,1),
	`wait_14` DECIMAL(4,1),
	`wait_15` DECIMAL(4,1),
	`wait_16` DECIMAL(4,1),
	`wait_17` DECIMAL(4,1),
	`wait_18` DECIMAL(4,1),
	`wait_19` DECIMAL(4,1),
	`wait_20` DECIMAL(4,1),
	`wait_21` DECIMAL(4,1),
	`wait_22` DECIMAL(4,1),
	`wait_23` DECIMAL(4,1),
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	UNIQUE KEY `shop_department_uniq` (`shop_id`, `shop_reserve_department_id`)
);

#-----------------------------------------------------------------------------
#-- w_imp_future_capa
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `w_imp_future_capa`;


CREATE TABLE `w_imp_future_capa`
(
	`id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT 'ID',
	`shop_id` BIGINT COMMENT '店舗ID',
	`is_department_kbn` TINYINT default 0 COMMENT '部門管理導入区分 0:旧カテゴリー 1:部門管理導入',
	`shop_reserve_department_id` BIGINT COMMENT '部門ID',
	`pattern` INTEGER COMMENT 'スケジュールのパターン WeekType などとも呼ばれているらしい 指定日と、指定日の翌日の状態（平日・休日）の組み合わせによって数値が決まるらしい 指定日  指定日の翌日 0:平日  →  平日 1:平日  →  休日 2:休日  →  平日 3:休日  →  休日',
	`mobile_ratio` INTEGER default 100 COMMENT 'モバイル受付率',
	`capa_default` INTEGER COMMENT '将来順番受付最大数デフォルト値',
	`section_num` INTEGER default 4 COMMENT '1時間当たりの予約枠数',
	`capa_0` INTEGER COMMENT '0時台の将来順番受付最大数',
	`capa_1` INTEGER COMMENT '1時台の将来順番受付最大数',
	`capa_2` INTEGER COMMENT '2時台の将来順番受付最大数',
	`capa_3` INTEGER COMMENT '3時台の将来順番受付最大数',
	`capa_4` INTEGER COMMENT '4時台の将来順番受付最大数',
	`capa_5` INTEGER COMMENT '5時台の将来順番受付最大数',
	`capa_6` INTEGER COMMENT '6時台の将来順番受付最大数',
	`capa_7` INTEGER COMMENT '7時台の将来順番受付最大数',
	`capa_8` INTEGER COMMENT '8時台の将来順番受付最大数',
	`capa_9` INTEGER COMMENT '9時台の将来順番受付最大数',
	`capa_10` INTEGER COMMENT '10時台の将来順番受付最大数',
	`capa_11` INTEGER COMMENT '11時台の将来順番受付最大数',
	`capa_12` INTEGER COMMENT '12時台の将来順番受付最大数',
	`capa_13` INTEGER COMMENT '13時台の将来順番受付最大数',
	`capa_14` INTEGER COMMENT '14時台の将来順番受付最大数',
	`capa_15` INTEGER COMMENT '15時台の将来順番受付最大数',
	`capa_16` INTEGER COMMENT '16時台の将来順番受付最大数',
	`capa_17` INTEGER COMMENT '17時台の将来順番受付最大数',
	`capa_18` INTEGER COMMENT '18時台の将来順番受付最大数',
	`capa_19` INTEGER COMMENT '19時台の将来順番受付最大数',
	`capa_20` INTEGER COMMENT '20時台の将来順番受付最大数',
	`capa_21` INTEGER COMMENT '21時台の将来順番受付最大数',
	`capa_22` INTEGER COMMENT '22時台の将来順番受付最大数',
	`capa_23` INTEGER COMMENT '23時台の将来順番受付最大数',
	`capa_zero_disable_flg` TINYINT default 0 NOT NULL COMMENT '0時台の将来順番受付状況 0:受付可、1:受付不可',
	`capa_1_disable_flg` TINYINT default 0 NOT NULL COMMENT '1時台の将来順番受付状況 0:受付可、1:受付不可',
	`capa_2_disable_flg` TINYINT default 0 NOT NULL COMMENT '2時台の将来順番受付状況 0:受付可、1:受付不可',
	`capa_3_disable_flg` TINYINT default 0 NOT NULL COMMENT '3時台の将来順番受付状況 0:受付可、1:受付不可',
	`capa_4_disable_flg` TINYINT default 0 NOT NULL COMMENT '4時台の将来順番受付状況 0:受付可、1:受付不可',
	`capa_5_disable_flg` TINYINT default 0 NOT NULL COMMENT '5時台の将来順番受付状況 0:受付可、1:受付不可',
	`capa_6_disable_flg` TINYINT default 0 NOT NULL COMMENT '6時台の将来順番受付状況 0:受付可、1:受付不可',
	`capa_7_disable_flg` TINYINT default 0 NOT NULL COMMENT '7時台の将来順番受付状況 0:受付可、1:受付不可',
	`capa_8_disable_flg` TINYINT default 0 NOT NULL COMMENT '8時台の将来順番受付状況 0:受付可、1:受付不可',
	`capa_9_disable_flg` TINYINT default 0 NOT NULL COMMENT '9時台の将来順番受付状況 0:受付可、1:受付不可',
	`capa_10_disable_flg` TINYINT default 0 NOT NULL COMMENT '10時台の将来順番受付状況 0:受付可、1:受付不可',
	`capa_11_disable_flg` TINYINT default 0 NOT NULL COMMENT '11時台の将来順番受付状況 0:受付可、1:受付不可',
	`capa_12_disable_flg` TINYINT default 0 NOT NULL COMMENT '12時台の将来順番受付状況 0:受付可、1:受付不可',
	`capa_13_disable_flg` TINYINT default 0 NOT NULL COMMENT '13時台の将来順番受付状況 0:受付可、1:受付不可',
	`capa_14_disable_flg` TINYINT default 0 NOT NULL COMMENT '14時台の将来順番受付状況 0:受付可、1:受付不可',
	`capa_15_disable_flg` TINYINT default 0 NOT NULL COMMENT '15時台の将来順番受付状況 0:受付可、1:受付不可',
	`capa_16_disable_flg` TINYINT default 0 NOT NULL COMMENT '16時台の将来順番受付状況 0:受付可、1:受付不可',
	`capa_17_disable_flg` TINYINT default 0 NOT NULL COMMENT '17時台の将来順番受付状況 0:受付可、1:受付不可',
	`capa_18_disable_flg` TINYINT default 0 NOT NULL COMMENT '18時台の将来順番受付状況 0:受付可、1:受付不可',
	`capa_19_disable_flg` TINYINT default 0 NOT NULL COMMENT '19時台の将来順番受付状況 0:受付可、1:受付不可',
	`capa_20_disable_flg` TINYINT default 0 NOT NULL COMMENT '20時台の将来順番受付状況 0:受付可、1:受付不可',
	`capa_21_disable_flg` TINYINT default 0 NOT NULL COMMENT '21時台の将来順番受付状況 0:受付可、1:受付不可',
	`capa_22_disable_flg` TINYINT default 0 NOT NULL COMMENT '22時台の将来順番受付状況 0:受付可、1:受付不可',
	`capa_23_disable_flg` TINYINT default 0 NOT NULL COMMENT '23時台の将来順番受付状況 0:受付可、1:受付不可',
	PRIMARY KEY (`id`),
	UNIQUE KEY `shop_department_uniq` (`shop_id`, `shop_reserve_department_id`, `pattern`)
) COMMENT='W_インポート用テンポラリ将来順番予約の時間別予約キャパシティの設定。 以下にある4つのFUTURE_*テーブル(FUTURE_HOLIDAY,FUTURE_HOLIDAY_2,FUTURE_WEEKDAY,FUTURE_WEEKDAY_2)を正規化して1テーブルにまとめ、 また、「個別」の設定を柔軟に行えるようにしたもの。FUTURE_*テーブルをリプレースする目的で新しく作られたと思われる。 平日(翌日平日)、平日(翌日土日祝)、土日祝(翌日平日)、土日祝(翌日土日祝)、個別1、個別2、個別3、個別4、個別5(、その他:未調査)という項目ごとに設定。';

#-----------------------------------------------------------------------------
#-- w_imp_qr_call_mail_templete
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `w_imp_qr_call_mail_templete`;


CREATE TABLE `w_imp_qr_call_mail_templete`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID',
	`call_number` TINYINT default 1 NOT NULL COMMENT 'N回目の呼び出しに使用',
	`sender` VARCHAR(64)  NOT NULL COMMENT '送信者',
	`subject` VARCHAR(64)  NOT NULL,
	`text` TEXT  NOT NULL,
	`created_at` DATETIME  NOT NULL COMMENT '作成日時',
	`updated_at` DATETIME  NOT NULL COMMENT '更新日時',
	PRIMARY KEY (`id`),
	UNIQUE KEY `call_mail_templete_uniq` (`shop_id`, `call_number`)
) COMMENT='W_インポート用テンポラリ呼出メール内容';

#-----------------------------------------------------------------------------
#-- w_imp_shop_rsv_cat_opt
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `w_imp_shop_rsv_cat_opt`;


CREATE TABLE `w_imp_shop_rsv_cat_opt`
(
	`id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT 'オプションＩＤ',
	`shop_id` BIGINT  NOT NULL COMMENT '店舗ID',
	`shop_reserve_category_id` BIGINT  NOT NULL COMMENT '予約カテゴリＩＤ',
	`display_order` TINYINT COMMENT '表示順',
	`name` VARCHAR(20) COMMENT '名称',
	`background_color` VARCHAR(6) COMMENT '背景色 表示する際の１６進数の背景色 /^[0-9a-f]{6}$/ 現在は JINS 仕様のタッチパネル以外では使用しない 例: ffffff 000000',
	`mobile` TINYINT default 0 COMMENT '携帯サイトに表示するか 0:表示　1:非表示',
	`status` TINYINT default 0 COMMENT '承認 ０：承認　1：非承認',
	`admin_status` TINYINT default 0 COMMENT '（管理画面設定）承認 ０：承認　1：非承認',
	`memo` VARCHAR(200) COMMENT '使用してないかも',
	`updated_at` DATETIME,
	PRIMARY KEY (`id`)
) COMMENT='W_インポート用予約カテゴリ選択肢のデータを格納';

#-----------------------------------------------------------------------------
#-- t_imp_run_log_file
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `t_imp_run_log_file`;


CREATE TABLE `t_imp_run_log_file`
(
	`run_kind` TINYINT UNSIGNED  NOT NULL COMMENT '処理種類 1: オーナー店舗入稿実行 2: 店舗入稿実行 3: 店舗解約・停止',
	`result_status` TINYINT UNSIGNED  NOT NULL COMMENT '処理結果状態 0: 未処理  1: CSVチェック完了 2: テンポラリー処理登録完了 3: 実テーブル登録中  4: 正常終了 9: エラー終了',
	`run_admin_user_id` INTEGER UNSIGNED  NOT NULL COMMENT '実行ユーザーID',
	`log_file_name` VARCHAR(40)  NOT NULL COMMENT 'ログファイル名称 正常：YYYYMMDD-HHMMSS_OK_****.log 異常：YYYYMMDD-HHMMSS_NG_****.log',
	`line_cnt` INTEGER UNSIGNED default 0 COMMENT '対象（処理）件数',
	`run_file_name` VARCHAR(100)  NOT NULL COMMENT '実行ファイル名',
	`created_at` DATETIME  NOT NULL COMMENT '登録時間',
	`updated_at` DATETIME  NOT NULL COMMENT '更新時間',
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	PRIMARY KEY (`id`),
	KEY `ix_t_imp_run_log_file`(`created_at`)
) COMMENT='T_実行結果ログ情報';

#-----------------------------------------------------------------------------
#-- t_memberinflow_token
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `t_memberinflow_token`;


CREATE TABLE `t_memberinflow_token`
(
	`registration_token` VARCHAR(32)  NOT NULL COMMENT '登録トークン',
	`member_id` INTEGER(8)  NOT NULL COMMENT 'EPARK会員ID',
	`token_status` TINYINT default 0 NOT NULL COMMENT 'トークンステータス',
	`expired_at` DATETIME  NOT NULL COMMENT 'トークンの有効期限',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`registration_token`)
) COMMENT='memberinflow自動登録のためのTOKEN管理';

#-----------------------------------------------------------------------------
#-- w_car_import
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `w_car_import`;


CREATE TABLE `w_car_import`
(
	`cartype_id` INTEGER UNSIGNED  NOT NULL COMMENT '車種ID',
	`maker_id` VARCHAR(100) COMMENT 'メーカーID',
	`car_name` VARCHAR(100) COMMENT '車名',
	`type_name` VARCHAR(100) COMMENT '型式',
	`engine_cc` VARCHAR(100) COMMENT '排気量',
	`engine_cc_spec` VARCHAR(100) COMMENT 'カタログ排気量',
	`fuel_id` VARCHAR(100) COMMENT '燃料種別ID',
	`turbo_id` VARCHAR(100) COMMENT 'ターボID',
	`tm_id` VARCHAR(100) COMMENT 'トランスミッションID',
	`drive_id` VARCHAR(100) COMMENT '駆動方式ID',
	`eco_id` VARCHAR(100) COMMENT 'エコシステムID',
	`mode_value_max` VARCHAR(100) COMMENT 'カタログ燃費_最高',
	`mode_value_min` VARCHAR(100) COMMENT 'カタログ燃費_最低',
	`weight_max` VARCHAR(100) COMMENT '車重_最高',
	`weight_min` VARCHAR(100) COMMENT '車重_最低',
	`sale_year_month` VARCHAR(100) COMMENT '発売年月',
	`frm_if_entry_time` VARCHAR(100) COMMENT '連携元登録日',
	`frm_if_update_time` VARCHAR(100) COMMENT '連携元更新日',
	`created_at` DATETIME  NOT NULL COMMENT '作成日時',
	`updated_at` DATETIME  NOT NULL COMMENT '更新日時',
	PRIMARY KEY (`cartype_id`)
) COMMENT='W_車両情報取込テンポラリテーブル';

#-----------------------------------------------------------------------------
#-- w_m_car
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `w_m_car`;


CREATE TABLE `w_m_car`
(
	`cartype_id` INTEGER  NOT NULL COMMENT '車種ID',
	`car_name` VARCHAR(100)  NOT NULL COMMENT '車名',
	`engine_cc` INTEGER  NOT NULL COMMENT '排気量',
	`sale_year_month` INTEGER  NOT NULL COMMENT '発売年月',
	`created_at` DATETIME  NOT NULL COMMENT '作成日時',
	`updated_at` DATETIME  NOT NULL COMMENT '更新日時',
	PRIMARY KEY (`cartype_id`),
	KEY `ix_w_m_car_2`(`car_name`),
	KEY `ix_w_m_car_3`(`engine_cc`, `sale_year_month`)
) COMMENT='W_車両マスタテンポラリ';

#-----------------------------------------------------------------------------
#-- m_car
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `m_car`;


CREATE TABLE `m_car`
(
	`cartype_id` INTEGER  NOT NULL COMMENT '車種ID',
	`car_name` VARCHAR(100)  NOT NULL COMMENT '車名',
	`engine_cc` INTEGER  NOT NULL COMMENT '排気量',
	`sale_year_month` INTEGER  NOT NULL COMMENT '発売年月',
	`created_at` DATETIME  NOT NULL COMMENT '作成日時',
	`updated_at` DATETIME  NOT NULL COMMENT '更新日時',
	PRIMARY KEY (`cartype_id`),
	KEY `ix_m_car_2`(`car_name`),
	KEY `ix_m_car_3`(`engine_cc`, `sale_year_month`),
	INDEX `I_referenced_i_mem_car_FK_3_1` (`sale_year_month`)
) COMMENT='M_車両マスタ';

#-----------------------------------------------------------------------------
#-- i_mem_car
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `i_mem_car`;


CREATE TABLE `i_mem_car`
(
	`mem_car_id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT '会員マイカーID',
	`mem_id` INTEGER UNSIGNED  NOT NULL COMMENT '会員ID',
	`mem_car_no` TINYINT UNSIGNED  NOT NULL COMMENT '会員マイカー連番',
	`car_name` VARCHAR(100)  NOT NULL COMMENT '車名',
	`engine_cc` INTEGER COMMENT '排気量',
	`sale_year_month` INTEGER COMMENT '発売年月',
	`car_inspect_exp_date` DATE COMMENT '車検証有効期限日',
	`car_memo` VARCHAR(24) COMMENT '車のメモ書き',
	`created_at` DATETIME  NOT NULL COMMENT '作成日時',
	`updated_at` DATETIME  NOT NULL COMMENT '更新日時',
	PRIMARY KEY (`mem_car_id`),
	UNIQUE KEY `uix_i_mem_car_1` (`mem_id`, `mem_car_no`),
	INDEX `i_mem_car_FI_1` (`car_name`),
	INDEX `i_mem_car_FI_2` (`engine_cc`),
	INDEX `i_mem_car_FI_3` (`sale_year_month`)
) COMMENT='I_会員マイカー情報';

#-----------------------------------------------------------------------------
#-- t_rcv_mem_car
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `t_rcv_mem_car`;


CREATE TABLE `t_rcv_mem_car`
(
	`receive_id` INTEGER UNSIGNED  NOT NULL COMMENT '受付ID',
	`mem_car_id` INTEGER UNSIGNED  NOT NULL COMMENT '会員マイカーID',
	`car_name` VARCHAR(100)  NOT NULL COMMENT '車名',
	`engine_cc` INTEGER COMMENT '排気量',
	`sale_year_month` INTEGER COMMENT '発売年月',
	`car_inspect_exp_date` DATE COMMENT '車検証有効期限日',
	`car_memo` VARCHAR(24) COMMENT '車のメモ書き',
	`created_at` DATETIME  NOT NULL COMMENT '作成日時',
	`updated_at` DATETIME  NOT NULL COMMENT '更新日時',
	PRIMARY KEY (`receive_id`,`mem_car_id`),
	INDEX `I_referenced_h_rcv_mem_car_FK_2_1` (`mem_car_id`),
	INDEX `t_rcv_mem_car_FI_2` (`mem_car_id`)
) COMMENT='T_受付会員マイカー';

#-----------------------------------------------------------------------------
#-- h_rcv_mem_car
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `h_rcv_mem_car`;


CREATE TABLE `h_rcv_mem_car`
(
	`receive_id` INTEGER UNSIGNED  NOT NULL COMMENT '受付ID',
	`mem_car_id` INTEGER UNSIGNED  NOT NULL COMMENT '会員マイカーID',
	`car_name` VARCHAR(100)  NOT NULL COMMENT '車名',
	`engine_cc` INTEGER COMMENT '排気量',
	`sale_year_month` INTEGER COMMENT '発売年月',
	`car_inspect_exp_date` DATE COMMENT '車検証有効期限日',
	`car_memo` VARCHAR(24) COMMENT '車のメモ書き',
	`created_at` DATETIME  NOT NULL COMMENT '作成日時',
	`updated_at` DATETIME  NOT NULL COMMENT '更新日時',
	PRIMARY KEY (`receive_id`,`mem_car_id`),
	INDEX `h_rcv_mem_car_FI_2` (`mem_car_id`)
) COMMENT='H_受付会員マイカー履歴';

#-----------------------------------------------------------------------------
#-- h_car_import_rs
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `h_car_import_rs`;


CREATE TABLE `h_car_import_rs`
(
	`car_imp_rslt_hst_id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT '車両情報インポート結果履歴ID',
	`car_imp_rslt_type` VARCHAR(1)  NOT NULL COMMENT '車両情報インポート結果区分 s:成功、e：エラー',
	`car_imp_cnt` INTEGER UNSIGNED COMMENT '車両情報インポート件数',
	`created_at` DATETIME  NOT NULL COMMENT '作成日時',
	`updated_at` DATETIME  NOT NULL COMMENT '更新日時',
	PRIMARY KEY (`car_imp_rslt_hst_id`),
	KEY `ix_h_car_import_rs_1`(`created_at`)
) COMMENT='H_車両情報インポート結果履歴';

#-----------------------------------------------------------------------------
#-- t_device_token
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `t_device_token`;


CREATE TABLE `t_device_token`
(
	`device_token_id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT 'デバイストークンID',
	`device_token` VARCHAR(255)  NOT NULL COMMENT 'デバイストークン',
	`deleted_flg` TINYINT UNSIGNED  NOT NULL COMMENT '削除フラグ 0:有効 1:削除',
	`created_at` DATETIME  NOT NULL COMMENT '作成日時',
	`updated_at` DATETIME  NOT NULL COMMENT '更新日時',
	PRIMARY KEY (`device_token_id`),
	UNIQUE KEY `uix_t_device_token1` (`device_token`)
) COMMENT='T_デバイストークン';

#-----------------------------------------------------------------------------
#-- t_device_info
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `t_device_info`;


CREATE TABLE `t_device_info`
(
	`device_info_id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT '端末情報ID',
	`app_type` TINYINT UNSIGNED  NOT NULL COMMENT 'アプリケーション種別 利用アプリケーション 1:mini_touch',
	`id_for_vendor` VARCHAR(32)  NOT NULL COMMENT '端末識別子',
	`device_token_id` INTEGER UNSIGNED COMMENT 'デバイストークンID',
	`pda_login_id` INTEGER COMMENT 'PDAログインID',
	`shop_id` INTEGER UNSIGNED COMMENT '店舗ID',
	`created_at` DATETIME  NOT NULL COMMENT '作成日時',
	`updated_at` DATETIME  NOT NULL COMMENT '更新日時',
	PRIMARY KEY (`device_info_id`),
	UNIQUE KEY `uix_t_device_info1` (`app_type`, `id_for_vendor`),
	KEY `ix_t_device_info1`(`shop_id`),
	INDEX `t_device_info_FI_1` (`device_token_id`),
	INDEX `t_device_info_FI_2` (`pda_login_id`)
) COMMENT='T_端末情報';

#-----------------------------------------------------------------------------
#-- m_class_auth
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `m_class_auth`;


CREATE TABLE `m_class_auth`
(
	`auth_id` TINYINT UNSIGNED  NOT NULL COMMENT '権限ID',
	`auth_name` VARCHAR(40)  NOT NULL COMMENT '権限名 1: ジェネリック発注 2: ポスト(BLE) 3: ポスト(BLE)通知メール 4: Web to Fax',
	`class_attr` TINYINT UNSIGNED  NOT NULL COMMENT '区分属性 1: 薬局 2: テイクアウト',
	`sort_id` TINYINT UNSIGNED  NOT NULL COMMENT 'ソートID',
	`created_at` DATETIME  NOT NULL COMMENT '登録日時',
	`updated_at` DATETIME  NOT NULL COMMENT '最終更新日時',
	PRIMARY KEY (`auth_id`,`sort_id`)
) COMMENT='区分属性別の権限を管理する。区分属性を持たない権限管理は従来のshop_auth_configで管理する';

#-----------------------------------------------------------------------------
#-- r_shop_class_auth
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `r_shop_class_auth`;


CREATE TABLE `r_shop_class_auth`
(
	`shop_id` INTEGER UNSIGNED  NOT NULL COMMENT '店舗ID',
	`auth_id` TINYINT UNSIGNED  NOT NULL COMMENT '権限ID  1：ジェネリック発注 2：ポスト(BLE) 3：ポスト(BLE)通知メール 4：Web to Fax 5:クレジット決済機能 6:レセコン設定完了フラグ 7:相談予約',
	`auth_status` TINYINT UNSIGNED  NOT NULL COMMENT '権限ステータス 1: 使用可 0 or null: 使用不可',
	`created_at` DATETIME  NOT NULL COMMENT '登録日時',
	`updated_at` DATETIME  NOT NULL COMMENT '最終更新日時',
	PRIMARY KEY (`shop_id`,`auth_id`)
) COMMENT='店舗別に区分属性別権限を管理する';

#-----------------------------------------------------------------------------
#-- i_shop_manual
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `i_shop_manual`;


CREATE TABLE `i_shop_manual`
(
	`shop_manual_id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT '店舗マニュアルID',
	`manual_title` VARCHAR(200)  NOT NULL COMMENT 'マニュアルタイトル',
	`manual_file_path` VARCHAR(255) COMMENT 'マニュアルファイルパス',
	`manual_file_size` INTEGER UNSIGNED COMMENT 'マニュアルファイルサイズ',
	`manual_file_type` TINYINT COMMENT 'マニュアルファイルタイプ',
	`manual_orgn_name` VARCHAR(100) COMMENT 'オリジナルファイル名',
	`new_icon_flg` TINYINT COMMENT '新着アイコン表示フラグ',
	`exc_icon_flg` TINYINT COMMENT '重要アイコン表示フラグ',
	`dsp_order` INTEGER UNSIGNED COMMENT '表示順',
	`manual_dsp_sts` TINYINT COMMENT '表示ステータス',
	`dsp_from` DATETIME COMMENT '表示開始日時',
	`dsp_to` DATETIME COMMENT '表示終了日時',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`shop_manual_id`)
) COMMENT='店舗マニュアル';

#-----------------------------------------------------------------------------
#-- i_shop_manual_cate
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `i_shop_manual_cate`;


CREATE TABLE `i_shop_manual_cate`
(
	`shop_manual_cate_id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT '店舗マニュアルカテゴリID',
	`shop_manual_id` INTEGER UNSIGNED COMMENT '店舗マニュアルID',
	`xl_cate_id` TINYINT COMMENT 'カテゴリ（大々分類）',
	`big_cate_id` INTEGER UNSIGNED COMMENT 'カテゴリ（大分類）',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`shop_manual_cate_id`),
	INDEX `i_shop_manual_cate_FI_1` (`shop_manual_id`)
) COMMENT='店舗マニュアルカテゴリ';

#-----------------------------------------------------------------------------
#-- m_handw_tm
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `m_handw_tm`;


CREATE TABLE `m_handw_tm`
(
	`tm_id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT 'テーマID',
	`tm_name` VARCHAR(30)  NOT NULL COMMENT 'テーマ名称',
	`tm_image_fname` VARCHAR(50) COMMENT 'テーマイメージサムネイル画像名',
	`tm_memo` VARCHAR(512) COMMENT 'テーマメモ',
	`tm_default_type` TINYINT UNSIGNED default 0 COMMENT 'テーマデフォルト区分',
	`tm_ope_sts` TINYINT default 0 NOT NULL COMMENT 'テーマ運用状況区分',
	`created_at` DATETIME  NOT NULL COMMENT 'レコード作成年月日',
	`updated_at` DATETIME  NOT NULL COMMENT 'レコード更新年月日',
	PRIMARY KEY (`tm_id`)
) COMMENT='M_手書きPADテーママスタ';

#-----------------------------------------------------------------------------
#-- m_handw_tm_shopsel
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `m_handw_tm_shopsel`;


CREATE TABLE `m_handw_tm_shopsel`
(
	`tm_shopsel_id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT 'テーマ店舗利用ID',
	`shop_id` INTEGER  NOT NULL COMMENT 'EPARK店舗ID',
	`tm_id` INTEGER UNSIGNED  NOT NULL COMMENT 'テーマID',
	`dsp_order` TINYINT COMMENT '表示順',
	`tm_shopsel_ope_sts` TINYINT default 0 NOT NULL COMMENT '店舗別利用テーマ運用状況区分',
	`created_at` DATETIME  NOT NULL COMMENT 'レコード作成年月日',
	`updated_at` DATETIME  NOT NULL COMMENT 'レコード更新年月日',
	PRIMARY KEY (`tm_shopsel_id`)
) COMMENT='M_手書きPAD店舗別利用テーママスタ';

#-----------------------------------------------------------------------------
#-- t_dining_sales
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `t_dining_sales`;


CREATE TABLE `t_dining_sales`
(
	`dining_sales_id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT 'ダイニング売上ID',
	`shop_id` INTEGER UNSIGNED  NOT NULL COMMENT 'EPARK店舗ID',
	`reg_no` CHAR(2)  NOT NULL COMMENT 'レジNO.',
	`sales_at` DATETIME  NOT NULL COMMENT '会計日時',
	`member_id` INTEGER UNSIGNED  NOT NULL COMMENT 'EPARK会員ID',
	`biz_day` DATE COMMENT '営業日',
	`receipt_no` CHAR(12)  NOT NULL COMMENT 'レシートNO.',
	`order_time` DATETIME COMMENT '新規オーダー時刻',
	`guest_amount` TINYINT UNSIGNED default 1 COMMENT '来店客数',
	`total_price_tax` INTEGER default 0 COMMENT '税込飲食料金',
	`total_price` INTEGER default 0 COMMENT '税抜飲食料金',
	`takeout_price_tax` INTEGER default 0 COMMENT '税込テイクアウト料金',
	`takeout_price` INTEGER default 0 COMMENT '税抜テイクアウト料金',
	`discount_price_tax` INTEGER default 0 COMMENT '税込値引き金額',
	`discount_price` INTEGER default 0 COMMENT '税抜値引き金額',
	`service_charge_tax` INTEGER default 0 COMMENT '税込サービス料金',
	`service_charge` INTEGER default 0 COMMENT '税抜サービス料金',
	`sales_total_tax` INTEGER default 0 COMMENT '税込合計売上金額',
	`sales_total` INTEGER default 0 COMMENT '税抜合計売上金額',
	`created_at` DATETIME  NOT NULL COMMENT '作成年月日',
	`updated_at` DATETIME  NOT NULL COMMENT '更新年月日',
	PRIMARY KEY (`dining_sales_id`),
	UNIQUE KEY `uix_t_dining_sales1` (`shop_id`, `reg_no`, `sales_at`),
	KEY `ix_t_dining_sales2`(`member_id`)
) COMMENT='ダイニング売上トランザクション  EPARK店舗ID + レジNO. + 会計日時でユニーク';

#-----------------------------------------------------------------------------
#-- r_dining_mail_target
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `r_dining_mail_target`;


CREATE TABLE `r_dining_mail_target`
(
	`shop_mail_id` INTEGER UNSIGNED  NOT NULL COMMENT '店舗メールID',
	`member_id` INTEGER UNSIGNED  NOT NULL COMMENT 'EPARK会員ID',
	`mail_target_type` TINYINT UNSIGNED default 1 NOT NULL COMMENT 'メール送信対象区分 0：対象外 1:対象',
	`last_visit_date` DATE  NOT NULL COMMENT '最終来店日',
	`created_at` DATETIME  NOT NULL COMMENT '作成年月日',
	`updated_at` DATETIME  NOT NULL COMMENT '更新年月日',
	PRIMARY KEY (`shop_mail_id`,`member_id`),
	KEY `ix_r_dining_mail_target1`(`member_id`),
	KEY `ix_r_dining_mail_target2`(`last_visit_date`)
) COMMENT='R_ダイニングメール送信対象連携';

#-----------------------------------------------------------------------------
#-- m_zip_code
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `m_zip_code`;


CREATE TABLE `m_zip_code`
(
	`zip_id` INTEGER(10) UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT '郵便番号を一意に識別',
	`zip_code` CHAR(7)  NOT NULL COMMENT '郵便番号（郵便番号は同じ番号で町域名が違うものが存在）',
	`city_code` CHAR(5)  NOT NULL COMMENT 'JIS X 0402に準拠した市区町村コード',
	`town_kanji_name` VARCHAR(80)  NOT NULL COMMENT '町域漢字名称',
	`town_kana_name` VARCHAR(80)  NOT NULL COMMENT '町域カナ名称',
	`address` VARCHAR(480)  NOT NULL COMMENT '全文検索カラム',
	`created_at` DATETIME  NOT NULL COMMENT '作成年月日',
	`updated_at` DATETIME  NOT NULL COMMENT '更新年月日',
	PRIMARY KEY (`zip_id`),
	KEY `zip_code_index`(`zip_code`)
);

#-----------------------------------------------------------------------------
#-- m_city
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `m_city`;


CREATE TABLE `m_city`
(
	`city_code` CHAR(5)  NOT NULL COMMENT 'JIS X 0402に準拠した市区町村コード',
	`pref_code` CHAR(2)  NOT NULL COMMENT '当該市区町村が所属する都道府県コード',
	`city_kanji_name` VARCHAR(80)  NOT NULL COMMENT '市区町村漢字名称',
	`city_kana_name` VARCHAR(80)  NOT NULL COMMENT '市区町村カナ名称',
	`created_at` DATETIME  NOT NULL COMMENT '作成年月日',
	`updated_at` DATETIME  NOT NULL COMMENT '更新年月日',
	PRIMARY KEY (`city_code`),
	KEY `pref_code_index`(`pref_code`)
) COMMENT='M_市区町村マスタ';

#-----------------------------------------------------------------------------
#-- l_qr_call_mail_send
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `l_qr_call_mail_send`;


CREATE TABLE `l_qr_call_mail_send`
(
	`qr_call_mail_send_id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT 'QRコールメール送信ID',
	`receive_id` BIGINT UNSIGNED  NOT NULL COMMENT '予約受付ID',
	`call_delivery_type` TINYINT UNSIGNED default 0 NOT NULL COMMENT 'コール配信種別',
	`call_date` DATETIME  NOT NULL COMMENT 'コール日時',
	`call_count` TINYINT UNSIGNED default 0 NOT NULL COMMENT 'コール回数',
	`created_at` DATETIME  NOT NULL COMMENT '作成日時',
	`updated_at` DATETIME  NOT NULL COMMENT '更新日時',
	PRIMARY KEY (`qr_call_mail_send_id`)
) COMMENT='L_QRコールメール送信';

#-----------------------------------------------------------------------------
#-- l_mem_call_mail_send
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `l_mem_call_mail_send`;


CREATE TABLE `l_mem_call_mail_send`
(
	`mem_call_mail_send_id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT '携帯呼出メール送信ID',
	`receive_id` BIGINT UNSIGNED  NOT NULL COMMENT '予約受付ID',
	`call_delivery_type` TINYINT UNSIGNED default 0 NOT NULL COMMENT 'コール配信種別',
	`call_date` DATETIME  NOT NULL COMMENT 'コール日時',
	`call_count` TINYINT UNSIGNED default 0 NOT NULL COMMENT 'コール回数',
	`created_at` DATETIME  NOT NULL COMMENT '作成日時',
	`updated_at` DATETIME  NOT NULL COMMENT '更新日時',
	PRIMARY KEY (`mem_call_mail_send_id`)
) COMMENT='L_携帯呼出メール送信';

#-----------------------------------------------------------------------------
#-- m_shop_mng_scr_conf
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `m_shop_mng_scr_conf`;


CREATE TABLE `m_shop_mng_scr_conf`
(
	`shop_id` INTEGER UNSIGNED  NOT NULL COMMENT '店舗ID',
	`scr_conf_code` TINYINT UNSIGNED  NOT NULL COMMENT '画面設定項目コード',
	`scr_conf_status` TINYINT UNSIGNED  NOT NULL COMMENT '画面設定項目ステータス',
	`created_at` DATETIME  NOT NULL COMMENT '作成日時',
	`updated_at` DATETIME  NOT NULL COMMENT '更新日時',
	PRIMARY KEY (`shop_id`,`scr_conf_code`),
	KEY `ix_m_shop_mng_scr_conf1`(`scr_conf_code`),
	KEY `ix_m_shop_mng_scr_conf2`(`updated_at`)
) COMMENT='店舗管理画面設定';

#-----------------------------------------------------------------------------
#-- h_mem_use
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `h_mem_use`;


CREATE TABLE `h_mem_use`
(
	`mem_use_hst_id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT '会員利用履歴ID',
	`receive_id` INTEGER UNSIGNED  NOT NULL COMMENT '予約受付ID',
	`shop_id` INTEGER UNSIGNED  NOT NULL COMMENT '店舗ID',
	`mem_id` INTEGER UNSIGNED  NOT NULL COMMENT 'EPARK会員ID',
	`receipt_date` DATETIME  NOT NULL COMMENT '案内予定日時',
	`shop_rsv_dptm_id` INTEGER UNSIGNED COMMENT '予約部門ID',
	`shop_rsv_dptm_val` VARCHAR(100) COMMENT '予約部門名',
	`shop_rsv_ct_id` INTEGER UNSIGNED COMMENT '予約条件カテゴリID',
	`shop_rsv_ct_opt_id` INTEGER UNSIGNED COMMENT '予約条件カテゴリオプションID',
	`shop_rsv_ct_val` VARCHAR(100) COMMENT '予約条件カテゴリ内容',
	`shop_rsv_ct_order` TINYINT UNSIGNED COMMENT '予約条件カテゴリ表示順',
	`created_at` DATETIME  NOT NULL COMMENT '作成日時',
	`updated_at` DATETIME  NOT NULL COMMENT '更新日時',
	PRIMARY KEY (`mem_use_hst_id`),
	KEY `ix_h_mem_use1`(`shop_id`, `mem_id`),
	KEY `ix_h_mem_use2`(`shop_rsv_dptm_id`, `shop_rsv_ct_opt_id`),
	KEY `ix_h_mem_use3`(`updated_at`),
	KEY `ix_h_mem_use4`(`receive_id`)
) COMMENT='H_会員利用履歴';

#-----------------------------------------------------------------------------
#-- m_shop_big_medical
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `m_shop_big_medical`;


CREATE TABLE `m_shop_big_medical`
(
	`shop_id` INTEGER UNSIGNED  NOT NULL COMMENT 'Epark店舗ID',
	`co_op_method_cate` TINYINT UNSIGNED  NOT NULL COMMENT '連携方法区分',
	`co_op_root_url` VARCHAR(255) COMMENT '連携先APIルートURL',
	`hsp_code` VARCHAR(10)  NOT NULL COMMENT '病院コード',
	`triage` VARCHAR(400) COMMENT 'トリアージ 病院毎のトリアージ',
	`sts_maint` TINYINT UNSIGNED default 0 NOT NULL COMMENT 'メンテナンスステータス',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`shop_id`)
) COMMENT='大病院用店舗マスタ';

#-----------------------------------------------------------------------------
#-- m_shop_mem_med_sprt
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `m_shop_mem_med_sprt`;


CREATE TABLE `m_shop_mem_med_sprt`
(
	`shop_mem_id` INTEGER UNSIGNED  NOT NULL COMMENT '店舗会員連携ID',
	`regi_no` VARCHAR(20)  NOT NULL COMMENT '診察券番号',
	`seek_dgns_name` VARCHAR(255)  NOT NULL COMMENT '受診者名称漢字',
	`seek_dgns_kana` VARCHAR(255)  NOT NULL COMMENT '受診者名称カナ',
	`seek_dgns_sex` TINYINT UNSIGNED  NOT NULL COMMENT '受診者性別',
	`seek_dgns_bday` DATE  NOT NULL COMMENT '受診者生年月日',
	`regi_order_no` TINYINT  NOT NULL COMMENT '登録順序',
	`mem_cond_sts` TINYINT UNSIGNED  NOT NULL COMMENT '会員運用ステータス',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`shop_mem_id`,`regi_no`),
	INDEX `I_referenced_l_med_sprt_send_log_FK_3_1` (`regi_no`)
) COMMENT='大病院用会員情報';

#-----------------------------------------------------------------------------
#-- l_med_sprt_send_log
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `l_med_sprt_send_log`;


CREATE TABLE `l_med_sprt_send_log`
(
	`send_mail_id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT 'メール送信ログID',
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID',
	`shop_mem_id` INTEGER UNSIGNED  NOT NULL COMMENT '店舗会員連携ID',
	`regi_no` VARCHAR(20)  NOT NULL COMMENT '診察券番号',
	`medi_rec_pk` VARCHAR(20)  NOT NULL COMMENT '電子カルテ内部番号',
	`hsp_dept` TINYINT UNSIGNED COMMENT '診療科',
	`send_type` TINYINT UNSIGNED COMMENT '送信種別',
	`mail_title` VARCHAR(50) COMMENT 'メールタイトル',
	`mail_body` VARCHAR(500) COMMENT 'メール本文',
	`res_send_mail` TINYINT UNSIGNED  NOT NULL COMMENT 'メール送信結果 0:OK 1:NG',
	`error_detail` VARCHAR(256) COMMENT 'エラー詳細',
	`send_mail_at` DATETIME  NOT NULL COMMENT 'メール送信日時',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`send_mail_id`),
	KEY `ix_l_med_sprt_send_log`(`shop_mem_id`, `regi_no`, `send_mail_at`),
	INDEX `l_med_sprt_send_log_FI_1` (`shop_id`),
	INDEX `l_med_sprt_send_log_FI_3` (`regi_no`)
) COMMENT='受診者メール送信ログ';

#-----------------------------------------------------------------------------
#-- m_inquiry_symptoms
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `m_inquiry_symptoms`;


CREATE TABLE `m_inquiry_symptoms`
(
	`shop_rsv_dept_id` INTEGER  NOT NULL COMMENT '部門ID(FK) 部門ID (shop_reserve_departmentテーブルid)',
	`inquiry_symptom_no` INTEGER UNSIGNED  NOT NULL COMMENT '問診症状番号 問診内容の連番',
	`inquiry_symptom` VARCHAR(80) COMMENT '問診症状内容 せき、くしゃみ、のどが痛い等',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`shop_rsv_dept_id`,`inquiry_symptom_no`)
) COMMENT='問診症状管理マスタ';

#-----------------------------------------------------------------------------
#-- l_rsv_err
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `l_rsv_err`;


CREATE TABLE `l_rsv_err`
(
	`rsv_err_id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT '予約時のエラーログID',
	`owner_shop_id` INTEGER UNSIGNED  NOT NULL COMMENT 'オーナ店舗ID',
	`shop_id` INTEGER UNSIGNED  NOT NULL COMMENT 'Epark店舗ID',
	`member_id` INTEGER UNSIGNED  NOT NULL COMMENT 'Epark会員ID',
	`shop_mem_id` INTEGER UNSIGNED  NOT NULL COMMENT '店舗会員連携ID',
	`member_rsv_id` VARCHAR(20)  NOT NULL COMMENT '予約者ID',
	`cate_run` TINYINT UNSIGNED  NOT NULL COMMENT '処理種別',
	`err_level` TINYINT UNSIGNED  NOT NULL COMMENT 'エラーレベル',
	`err_no` INTEGER UNSIGNED  NOT NULL COMMENT 'エラー番号',
	`http_status_code` INTEGER UNSIGNED COMMENT 'HTTPステータスコード',
	`err_title` VARCHAR(100)  NOT NULL COMMENT 'エラータイトル',
	`err_msg` VARCHAR(255)  NOT NULL COMMENT 'エラーメッセージ',
	`err_catch_place` VARCHAR(50)  NOT NULL COMMENT 'エラー発生場所',
	`err_time` DATETIME  NOT NULL COMMENT 'エラー日時',
	`flg_send_mail` TINYINT UNSIGNED COMMENT 'エラー通知メール送信フラグ',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`rsv_err_id`),
	KEY `ix_t_rcv_pl1`(`err_time`),
	KEY `ix_t_rcv_pl2`(`shop_id`, `shop_mem_id`, `member_rsv_id`)
) COMMENT='予約エラーログ';

#-----------------------------------------------------------------------------
#-- m_nt_corner
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `m_nt_corner`;


CREATE TABLE `m_nt_corner`
(
	`nt_corner_id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT 'コーナーID',
	`shop_id` INTEGER  NOT NULL COMMENT 'EPARK店舗ID',
	`nt_corner_name` VARCHAR(64)  NOT NULL COMMENT 'コーナー名称',
	`nt_print_title` VARCHAR(64) COMMENT '発券タイトル',
	`nt_print_message` VARCHAR(1024) COMMENT '発券メッセージ',
	`admissiontk_chk_type` TINYINT UNSIGNED default 0 NOT NULL COMMENT '入場券チェック有無区分',
	`barcode_type` TINYINT UNSIGNED default 0 NOT NULL COMMENT '入場券チェック入力区分',
	`character_type` TINYINT UNSIGNED default 0 NOT NULL COMMENT '入場券チェック方法区分',
	`digits_range_min` TINYINT UNSIGNED default 0 COMMENT '入場券番号桁数最小値',
	`digits_range_max` TINYINT UNSIGNED default 0 COMMENT '入場券番号桁数最大値',
	`nt_people_min` TINYINT UNSIGNED  NOT NULL COMMENT 'グループ発券人数最小値',
	`nt_people_max` TINYINT UNSIGNED  NOT NULL COMMENT 'グループ発券人数最大値',
	`nt_corner_ope_sts` TINYINT UNSIGNED default 0 NOT NULL COMMENT 'コーナー運用状況区分',
	`created_at` DATETIME  NOT NULL COMMENT 'レコード作成年月日',
	`updated_at` DATETIME  NOT NULL COMMENT 'レコード更新年月日',
	PRIMARY KEY (`nt_corner_id`),
	INDEX `FI_m_nt_corner` (`shop_id`)
) COMMENT='M_整理券コーナマスタ';

#-----------------------------------------------------------------------------
#-- m_nt_corner_i18n
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `m_nt_corner_i18n`;


CREATE TABLE `m_nt_corner_i18n`
(
	`nt_corner_id` INTEGER UNSIGNED  NOT NULL COMMENT 'コーナーID',
	`culture` VARCHAR(7)  NOT NULL COMMENT '言語区分',
	`nt_recept_message` VARCHAR(64) COMMENT '受付画面メッセージ',
	`attention_text` VARCHAR(1024) COMMENT '案内頁文言',
	PRIMARY KEY (`nt_corner_id`,`culture`)
) COMMENT='M_整理券コーナー多言語マスタ';

#-----------------------------------------------------------------------------
#-- m_nt_effective_date
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `m_nt_effective_date`;


CREATE TABLE `m_nt_effective_date`
(
	`effective_date_id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT 'スケジュール適用期間ID',
	`nt_corner_id` INTEGER UNSIGNED  NOT NULL COMMENT 'コーナーID',
	`effective_start_date` DATE  NOT NULL COMMENT '適用開始日',
	`effective_end_date` DATE  NOT NULL COMMENT '適用終了日',
	`ef_dt_ope_sts` TINYINT UNSIGNED default 0 NOT NULL COMMENT 'スケジュール適用期間運用状況区分',
	`created_at` DATETIME  NOT NULL COMMENT 'レコード作成年月日',
	`updated_at` DATETIME  NOT NULL COMMENT 'レコード更新年月日',
	PRIMARY KEY (`effective_date_id`),
	INDEX `FI_m_nt_effective_date` (`nt_corner_id`)
) COMMENT='M_整理券スケジュール適用期間マスタ';

#-----------------------------------------------------------------------------
#-- m_nt_schedule_time
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `m_nt_schedule_time`;


CREATE TABLE `m_nt_schedule_time`
(
	`schedule_time_id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT 'スケジュールID',
	`effective_date_id` INTEGER UNSIGNED  NOT NULL COMMENT 'スケジュール適用期間ID',
	`schedule_start_time` TIME  NOT NULL COMMENT '開催開始時間',
	`schedule_end_time` TIME  NOT NULL COMMENT '開催終了時間',
	`ticket_possible_cnt` INTEGER UNSIGNED  NOT NULL COMMENT '発券可能数',
	`next_disp_cnt` INTEGER UNSIGNED COMMENT '次回枠対象数',
	`nt_no_prefix` VARCHAR(10) COMMENT '受付番号冒頭文字列',
	`nt_no_digits_cnt` TINYINT UNSIGNED COMMENT '受付番号数値部桁数',
	`nt_no_range_min` INTEGER UNSIGNED COMMENT '受付番号範囲最小値',
	`nt_no_range_max` INTEGER UNSIGNED COMMENT '受付番号範囲最大値',
	`recept_start_time` TIME COMMENT '受付開始時間',
	`recept_end_time` TIME COMMENT '受付停止時間',
	`sc_tm_ope_sts` TINYINT UNSIGNED default 0 NOT NULL COMMENT 'スケジュール運用状況区分',
	`created_at` DATETIME  NOT NULL COMMENT 'レコード作成年月日',
	`updated_at` DATETIME  NOT NULL COMMENT 'レコード更新年月日',
	PRIMARY KEY (`schedule_time_id`),
	INDEX `FI_m_nt_schedule_time` (`effective_date_id`)
) COMMENT='M_整理券スケジュールマスタ';

#-----------------------------------------------------------------------------
#-- t_nt_date_control
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `t_nt_date_control`;


CREATE TABLE `t_nt_date_control`
(
	`nt_date_ctl_id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT '整理券状況管理ID',
	`nt_ctl_date` DATE  NOT NULL COMMENT '管理対象日',
	`schedule_time_id` INTEGER UNSIGNED  NOT NULL COMMENT 'スケジュールID',
	`shop_id` INTEGER  NOT NULL COMMENT 'EPARK店舗ID',
	`nt_corner_id` INTEGER UNSIGNED  NOT NULL COMMENT 'コーナーID',
	`effective_date_id` INTEGER UNSIGNED  NOT NULL COMMENT 'スケジュール適用期間ID',
	`recept_stop_type` TINYINT UNSIGNED default 0 NOT NULL COMMENT '発券受付区分',
	`recept_start_time` TIME COMMENT '受付開始時間',
	`recept_end_time` TIME COMMENT '受付停止時間',
	`recept_cnt` INTEGER UNSIGNED default 0 NOT NULL COMMENT '受付済数',
	`ticket_possible_cnt` INTEGER UNSIGNED COMMENT '発券可能数',
	`next_disp_cnt` INTEGER UNSIGNED COMMENT '次回枠対象数',
	`recept_people_cnt` INTEGER UNSIGNED default 0 NOT NULL COMMENT '発券済人数',
	`nt_dt_ope_sts` TINYINT UNSIGNED default 0 NOT NULL COMMENT '整理券状況管理運用状況区分',
	`created_at` DATETIME  NOT NULL COMMENT 'レコード作成年月日',
	`updated_at` DATETIME  NOT NULL COMMENT 'レコード更新年月日',
	PRIMARY KEY (`nt_date_ctl_id`),
	UNIQUE KEY `uix_t_nt_date_control1` (`nt_corner_id`, `nt_ctl_date`, `schedule_time_id`),
	INDEX `FI_t_nt_date_control1` (`schedule_time_id`),
	INDEX `FI_t_nt_date_control2` (`shop_id`),
	INDEX `FI_t_nt_date_control4` (`effective_date_id`)
) COMMENT='T_整理券状況管理データ';

#-----------------------------------------------------------------------------
#-- t_numbered_ticket
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `t_numbered_ticket`;


CREATE TABLE `t_numbered_ticket`
(
	`nt_id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT '整理券ID',
	`shop_id` INTEGER  NOT NULL COMMENT 'EPARK店舗ID',
	`nt_corner_id` INTEGER UNSIGNED  NOT NULL COMMENT 'コーナーID',
	`nt_date_ctl_id` INTEGER UNSIGNED  NOT NULL COMMENT '整理券状況管理ID',
	`nt_no` VARCHAR(10)  NOT NULL COMMENT '受付番号',
	`nt_date` DATETIME  NOT NULL COMMENT '受付日時',
	`nt_people_cnt` TINYINT UNSIGNED default 0 COMMENT 'グループ発券人数',
	`cancel_type` TINYINT UNSIGNED default 0 NOT NULL COMMENT 'キャンセル区分',
	`cancel_people_cnt` TINYINT UNSIGNED default 0 COMMENT 'キャンセル済人数',
	`cancel_last_at` DATETIME COMMENT '最終キャンセル日時',
	`nt_ope_sts` TINYINT UNSIGNED default 0 NOT NULL COMMENT '整理券運用状況区分',
	`created_at` DATETIME  NOT NULL COMMENT 'レコード作成年月日',
	`updated_at` DATETIME  NOT NULL COMMENT 'レコード更新年月日',
	PRIMARY KEY (`nt_id`),
	KEY `ix_t_numbered_ticket1`(`created_at`),
	INDEX `FI_t_numbered_ticket1` (`shop_id`),
	INDEX `FI_t_numbered_ticket2` (`nt_corner_id`),
	INDEX `FI_t_numbered_ticket3` (`nt_date_ctl_id`)
) COMMENT='T_整理券データ';

#-----------------------------------------------------------------------------
#-- m_survey
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `m_survey`;


CREATE TABLE `m_survey`
(
	`survey_id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT 'アンケートID',
	`name` VARCHAR(255)  NOT NULL COMMENT 'アンケート名',
	`description` VARCHAR(1000)  NOT NULL COMMENT 'アンケート説明',
	`shop_id` INTEGER COMMENT '店舗ID',
	`group_id` INTEGER COMMENT 'グループID',
	`trgt_sex_type` TINYINT UNSIGNED COMMENT '対象性別',
	`trgt_from_age` TINYINT UNSIGNED COMMENT '対象年齢_from',
	`trgt_to_age` TINYINT UNSIGNED COMMENT '対象年齢_to',
	`trgt_birth_month` TINYINT UNSIGNED COMMENT '対象_生年月日_月',
	`trgt_pref_id` TINYINT UNSIGNED COMMENT '対象_都道府県ID',
	`trgt_mem_type` TINYINT UNSIGNED default 0 COMMENT '対象会員',
	`survey_ope_sts` TINYINT UNSIGNED default 0 COMMENT '運用区分',
	`survey_send_num` INTEGER UNSIGNED default 0 COMMENT 'アンケート配信数',
	`survey_answer_num` INTEGER UNSIGNED default 0 COMMENT 'アンケート回答数',
	`survey_startdate` DATETIME COMMENT 'アンケート配信開始日時',
	`survey_enddate` DATETIME COMMENT 'アンケート配信終了日時',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`survey_id`)
) COMMENT='EXPOアンケート';

#-----------------------------------------------------------------------------
#-- m_survey_qstn
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `m_survey_qstn`;


CREATE TABLE `m_survey_qstn`
(
	`survey_qstn_id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT 'アンケート設問ID',
	`survey_id` INTEGER UNSIGNED  NOT NULL COMMENT 'アンケートID',
	`question` VARCHAR(255)  NOT NULL COMMENT '設問内容',
	`answer_type` TINYINT UNSIGNED  NOT NULL COMMENT '回答形式',
	`required_flag` TINYINT UNSIGNED default 0 COMMENT '必須項目フラグ',
	`display_order` TINYINT UNSIGNED default 0 COMMENT '表示順',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`survey_qstn_id`)
) COMMENT='EXPOアンケート設問';

#-----------------------------------------------------------------------------
#-- m_survey_qstn_ch
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `m_survey_qstn_ch`;


CREATE TABLE `m_survey_qstn_ch`
(
	`survey_qstn_ch_id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT 'アンケート選択肢ID',
	`survey_qstn_id` INTEGER UNSIGNED  NOT NULL COMMENT 'アンケート設問ID',
	`choice` VARCHAR(255)  NOT NULL COMMENT '選択肢',
	`display_order` TINYINT UNSIGNED default 0 COMMENT '表示順',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`survey_qstn_ch_id`)
) COMMENT='EXPOアンケート選択肢';

#-----------------------------------------------------------------------------
#-- m_survey_answer
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `m_survey_answer`;


CREATE TABLE `m_survey_answer`
(
	`survey_answer_id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT 'アンケート回答ID',
	`survey_id` INTEGER UNSIGNED  NOT NULL COMMENT 'アンケートID',
	`member_id` INTEGER  NOT NULL COMMENT 'EPARK会員ID',
	`receipt_date` DATETIME  NOT NULL COMMENT '回答日時',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`survey_answer_id`)
) COMMENT='EXPOアンケート回答';

#-----------------------------------------------------------------------------
#-- m_survey_answer_all
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `m_survey_answer_all`;


CREATE TABLE `m_survey_answer_all`
(
	`survey_answer_all_id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT 'アンケート回答詳細ID',
	`survey_qstn_id` INTEGER UNSIGNED  NOT NULL COMMENT 'アンケート設問ID',
	`survey_answer_id` INTEGER UNSIGNED  NOT NULL COMMENT 'アンケート回答ID',
	`answer` VARCHAR(1000) COMMENT '回答内容',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`survey_answer_all_id`)
) COMMENT='EXPOアンケート回答詳細';

#-----------------------------------------------------------------------------
#-- m_various_types
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `m_various_types`;


CREATE TABLE `m_various_types`
(
	`job_type_id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT '作業報告区分ID',
	`job_cate_type` TINYINT UNSIGNED  NOT NULL COMMENT '区分種別 1:設置商品マスタ区分 2:作業内容区分 3:研修内容区分 4:業者マスタ区分',
	`big_type_code` TINYINT UNSIGNED  NOT NULL COMMENT '各区分種別に応じた大区分を表す',
	`mid_type_code` TINYINT UNSIGNED default 0 NOT NULL COMMENT '各区分種別に応じた中区分を表す',
	`min_type_code` SMALLINT UNSIGNED default 0 NOT NULL COMMENT '各区分種別に応じた小区分を表す',
	`type_name` VARCHAR(30)  NOT NULL COMMENT '作業報告区分の名称',
	`disp_order` TINYINT  NOT NULL COMMENT '表示時の並び順',
	`last_update_user_id` INTEGER(11)  NOT NULL COMMENT 'admin_userテーブルのidと紐づきます。',
	`ope_type` TINYINT  NOT NULL COMMENT '運用状態を表す 0：運用中 1：運用停止 2：削除済',
	`created_at` DATETIME  NOT NULL COMMENT 'レコード作成年月日',
	`updated_at` DATETIME  NOT NULL COMMENT 'レコード更新年月日',
	PRIMARY KEY (`job_type_id`),
	KEY `ix_m_various_types1`(`job_cate_type`),
	KEY `ix_m_various_types2`(`disp_order`),
	KEY `fk_admin_user_m_various_types`(`last_update_user_id`)
) COMMENT='M_作業報告区分マスタ';

#-----------------------------------------------------------------------------
#-- t_job_rpt_pgm
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `t_job_rpt_pgm`;


CREATE TABLE `t_job_rpt_pgm`
(
	`job_pgm_id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT '作業予定情報を一意に管理するID',
	`shop_id` INTEGER(11) UNSIGNED  NOT NULL COMMENT 'EPARK店舗、SBM店舗ID',
	`service_code` VARCHAR(8)  NOT NULL COMMENT 'サービスを識別 EP:Epark、TM:時間割、SBM:ソフトバンク',
	`job_code` VARCHAR(20)  NOT NULL COMMENT '設置工事コード ファイルメーカで管理している任意の工事コード',
	`job_status` TINYINT UNSIGNED  NOT NULL COMMENT '作業区分 1:予定 2:報告 3:完了確認 4：差戻し 5:一時保管',
	`job_date` DATE COMMENT '作業予定日',
	`job_start_time` TIME COMMENT '作業開始時刻 HH:MM:SS',
	`job_end_time` TIME COMMENT '作業終了時刻 HH:MM:SS',
	`op_shop_hope_date` DATE COMMENT '店舗情報解放希望日 YYYY-MM-DD：導入完了後にEparkサービスを開始したい日付。',
	`worker_id` INTEGER UNSIGNED  NOT NULL COMMENT '設置作業者ID',
	`use_svc_memo` VARCHAR(255) COMMENT '■順番待ち＋将来順番予約 ■会員証なし ■音声呼出なし ■iPad 1 アカウント ■メール配信 あり',
	`csv_upload_at` DATETIME  NOT NULL COMMENT 'CSVを取り込んだ日時',
	`csv_upload_name` VARCHAR(30) COMMENT 'CSV取込実行者名',
	`created_at` DATETIME  NOT NULL COMMENT 'レコード作成年月日',
	`updated_at` DATETIME  NOT NULL COMMENT 'レコード更新年月日',
	PRIMARY KEY (`job_pgm_id`),
	UNIQUE KEY `t_job_rpt_pgm_U_1` (`job_code`),
	UNIQUE KEY `uix_t_wk_rpt_program` (`job_code`),
	KEY `ix_t_wk_rpt_program1`(`job_code`),
	KEY `ix_t_wk_rpt_program2`(`job_status`),
	KEY `fk_m_job_rpt_worker_t_job_rpt_pgm`(`worker_id`),
	KEY `fk_shop_t_job_rpt_pgm`(`shop_id`)
) COMMENT='T_作業予定情報';

#-----------------------------------------------------------------------------
#-- t_job_rpt_comp_hist
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `t_job_rpt_comp_hist`;


CREATE TABLE `t_job_rpt_comp_hist`
(
	`job_rpt_comp_hist_id` INTEGER(11) UNSIGNED  NOT NULL COMMENT '作業完了報告履歴ID',
	`job_rpt_comp_id` INTEGER(10) UNSIGNED  NOT NULL COMMENT '作業完了報告ID',
	`shop_id` INTEGER(11) UNSIGNED  NOT NULL COMMENT '店舗ID',
	`job_status` TINYINT(3) UNSIGNED  NOT NULL COMMENT '作業区分 0:取消 1:予定 2:報告 3:完了確認 4：差戻し 5:一時保管',
	`update_user` VARCHAR(50) COMMENT '更新者名',
	`ip_address` VARCHAR(20) COMMENT '処理時のIPアドレス',
	`user_agent` VARCHAR(255) COMMENT '処理時のUA',
	`created_at` DATETIME  NOT NULL COMMENT 'レコード作成年月日',
	PRIMARY KEY (`job_rpt_comp_hist_id`),
	KEY `ix_job_rpt_comp_hist1`(`job_rpt_comp_id`),
	KEY `ix_job_rpt_comp_hist2`(`shop_id`)
) COMMENT='T_作業完了報告履歴';

#-----------------------------------------------------------------------------
#-- t_job_rpt_pgm_dtl
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `t_job_rpt_pgm_dtl`;


CREATE TABLE `t_job_rpt_pgm_dtl`
(
	`job_pgm_id` INTEGER UNSIGNED  NOT NULL COMMENT '作業予定情報ID',
	`job_type_id` INTEGER UNSIGNED  NOT NULL COMMENT '作業報告区分ID',
	`created_at` DATETIME  NOT NULL COMMENT 'レコード作成年月日',
	`updated_at` DATETIME  NOT NULL COMMENT 'レコード更新年月日',
	PRIMARY KEY (`job_pgm_id`,`job_type_id`),
	KEY `fk_t_job_rpt_pgm_t_job_rpt_pgm_dtl`(`job_pgm_id`),
	KEY `fk_m_various_types_t_job_rpt_pgm_dtl`(`job_type_id`)
) COMMENT='T_作業予定詳細';

#-----------------------------------------------------------------------------
#-- t_job_rpt_comp
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `t_job_rpt_comp`;


CREATE TABLE `t_job_rpt_comp`
(
	`job_rpt_comp_id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT '作業完了情報を一意に管理するID',
	`shop_id` INTEGER(11) UNSIGNED  NOT NULL COMMENT '店舗ID',
	`service_code` VARCHAR(8)  NOT NULL COMMENT 'サービスを識別 EP:Epark、TM:時間割、SBM:ソフトバンク',
	`job_code` VARCHAR(20)  NOT NULL COMMENT '設置工事コード ファイルメーカで管理している任意の工事コード',
	`job_status` TINYINT UNSIGNED COMMENT '作業区分 0:取消 1:予定 2:報告 3:完了確認 4：差戻し 5:一時保管',
	`job_date` DATE  NOT NULL COMMENT '作業実施日',
	`job_start_time` TIME  NOT NULL COMMENT '作業開始時刻 HH:MM:SS',
	`job_end_time` TIME  NOT NULL COMMENT '作業終了時刻 HH:MM:SS',
	`op_shop_hope_date` DATE COMMENT '店舗情報解放希望日 YYYY-MM-DD：導入完了後にEparkサービスを開始したい日付。',
	`worker_id` INTEGER UNSIGNED COMMENT '設置作業者ID',
	`use_svc_memo` VARCHAR(255) COMMENT '■順番待ち＋将来順番予約 ■会員証なし ■音声呼出なし ■iPad 1 アカウント ■メール配信 あり',
	`send_mail_type` TINYINT UNSIGNED default 0 COMMENT '0:未送信 1:送信済 9:エラー',
	`argee_job_type` TINYINT UNSIGNED default 0 NOT NULL COMMENT '0:未 1:同意',
	`argee_job_dtl_type` VARCHAR(10) default '0' NOT NULL COMMENT '000：全て非同意、111：全て同意 0（非同意）、1（同意）のどちらかが記述 左1桁：インターネット回線等ASP環境が整備されています。 中1桁：利用機器一式について、不具合・欠陥等一切ありません。 右1桁：システム使用方法の説明を受け、理解しています。',
	`pc_rpt_latitude` DECIMAL(9,6)  NOT NULL COMMENT '報告端末緯度',
	`pc_rpt_longitude` DECIMAL(9,6)  NOT NULL COMMENT '報告端末経度',
	`pc_rpt_addr` VARCHAR(255) COMMENT '逆ジオコーディングで取得した住所情報を保持します。',
	`ip_address` VARCHAR(20) COMMENT '同意時の端末IPアドレス',
	`user_agent` VARCHAR(255) COMMENT '同意時のユーザーエージェント',
	`notes_remarks` VARCHAR(255) COMMENT '備考・メモ、その他連絡事項入力欄',
	`csv_upload_at` DATETIME COMMENT 'CSVを取り込んだ日時',
	`csv_upload_name` VARCHAR(30) COMMENT 'CSV取込実行者',
	`job_rpt_send_at` DATETIME  NOT NULL COMMENT '作業報告送信日',
	`job_rpt_send_name` VARCHAR(30)  NOT NULL COMMENT '作業報告送信者名',
	`last_updated_at` DATETIME COMMENT '最終更新日',
	`last_updated_name` VARCHAR(30) COMMENT '最終更新者名',
	`last_conf_at` DATETIME COMMENT '作業最終完了確認日',
	`last_conf_name` VARCHAR(30) COMMENT '作業最終完了確認者名',
	`comp_mail_send_at` DATETIME COMMENT '作業完了メール送信日',
	`comp_mail_send_name` VARCHAR(30) COMMENT '作業完了メール送信者名',
	`created_at` DATETIME  NOT NULL COMMENT 'レコード作成年月日',
	`updated_at` DATETIME  NOT NULL COMMENT 'レコード更新年月日',
	PRIMARY KEY (`job_rpt_comp_id`),
	UNIQUE KEY `t_job_rpt_comp_U_1` (`job_code`),
	UNIQUE KEY `uix_t_wk_rpt_comple1` (`job_code`),
	KEY `fk_m_job_rpt_worker_t_job_rpt_comp`(`worker_id`),
	KEY `fk_shop_t_job_rpt_comp`(`shop_id`)
) COMMENT='T_作業完了情報';

#-----------------------------------------------------------------------------
#-- t_job_rpt_comp_dtl
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `t_job_rpt_comp_dtl`;


CREATE TABLE `t_job_rpt_comp_dtl`
(
	`job_rpt_comp_id` INTEGER UNSIGNED  NOT NULL COMMENT '作業完了情報ID',
	`job_type_id` INTEGER UNSIGNED  NOT NULL COMMENT '作業報告区分ID',
	`created_at` DATETIME  NOT NULL COMMENT 'レコード作成年月日',
	`updated_at` DATETIME  NOT NULL COMMENT 'レコード更新年月日',
	PRIMARY KEY (`job_rpt_comp_id`,`job_type_id`),
	KEY `fk_t_job_rpt_comp_t_job_rpt_comp_dtl`(`job_rpt_comp_id`),
	KEY `fk_m_various_types_t_job_rpt_comp_dtl`(`job_type_id`)
) COMMENT='T_作業研修内容詳細（完了）';

#-----------------------------------------------------------------------------
#-- m_job_rpt_trader
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `m_job_rpt_trader`;


CREATE TABLE `m_job_rpt_trader`
(
	`setup_trader_code` VARCHAR(11)  NOT NULL COMMENT '設置業者コード ファイルメーカで採番された任意のコード',
	`setup_trader_name` VARCHAR(100)  NOT NULL COMMENT '設置業者名',
	`company_type` INTEGER UNSIGNED COMMENT '1:自社 2:販売代理店 区分マスタで管理',
	`structure_type` INTEGER UNSIGNED COMMENT '1:FP 2:薬局 3:自動車 4:会員証 5:携帯 6:CRM 7:商業施設 区分マスタで管理',
	`main_prdct_type` INTEGER UNSIGNED COMMENT '1:EPARK 2:会員証 3:薬局 区分マスタで管理',
	`trader_mail_addr` VARCHAR(255) COMMENT '設置業者メールアドレス',
	`director_name` VARCHAR(30) COMMENT '設置責任者名',
	`last_updated_user_id` INTEGER(11)  NOT NULL COMMENT 'admin_userテーブルのidと紐づきます。',
	`ope_type` TINYINT default 0 NOT NULL COMMENT '運用状態を表す 0：運用中 1：運用停止 2：削除済',
	`created_at` DATETIME  NOT NULL COMMENT 'レコード作成年月日',
	`updated_at` DATETIME  NOT NULL COMMENT 'レコード更新年月日',
	PRIMARY KEY (`setup_trader_code`),
	KEY `fk_admin_user_m_job_rpt_trader`(`last_updated_user_id`)
) COMMENT='設置業者マスタ';

#-----------------------------------------------------------------------------
#-- m_job_rpt_worker
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `m_job_rpt_worker`;


CREATE TABLE `m_job_rpt_worker`
(
	`worker_id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT '設置作業者ID',
	`worker_name` VARCHAR(100)  NOT NULL COMMENT '作業者名',
	`setup_trader_code` VARCHAR(11)  NOT NULL COMMENT '設置業者コード',
	`all_report_cnt` INTEGER UNSIGNED default 0 COMMENT '総報告回数',
	`all_remand_cnt` INTEGER UNSIGNED default 0 COMMENT '総差戻回数',
	`last_updated_user_id` INTEGER(11) UNSIGNED COMMENT 'admin_userテーブルのidと紐づきます。',
	`ope_type` TINYINT COMMENT '運用状態を表す 0：運用中 1：運用停止 2：削除済',
	`created_at` DATETIME  NOT NULL COMMENT 'レコード作成年月日',
	`updated_at` DATETIME  NOT NULL COMMENT 'レコード更新年月日',
	PRIMARY KEY (`worker_id`),
	KEY `fk_admin_user_m_job_rpt_worker`(`last_updated_user_id`),
	KEY `fk_m_job_rpt_trader_m_job_rpt_worker`(`setup_trader_code`)
) COMMENT='M_設置作業者マスタ';

#-----------------------------------------------------------------------------
#-- t_job_rpt_id_rel
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `t_job_rpt_id_rel`;


CREATE TABLE `t_job_rpt_id_rel`
(
	`job_id` INTEGER  NOT NULL AUTO_INCREMENT COMMENT '作業ID',
	`job_pgm_id` INTEGER UNSIGNED COMMENT '作業予定情報ID',
	`job_rpt_comp_id` INTEGER UNSIGNED COMMENT '作業完了情報ID',
	`shop_id` INTEGER UNSIGNED  NOT NULL COMMENT '店舗ID',
	`group_flg` TINYINT(3) UNSIGNED default 0 COMMENT 'グループ表示フラグ(0=非表示, 1=表示)',
	`del_flg` TINYINT(3) UNSIGNED default 0 COMMENT '削除フラグ(0=未削除, 1=削除)',
	`created_at` DATETIME  NOT NULL COMMENT 'レコード作成年月日',
	`updated_at` DATETIME  NOT NULL COMMENT 'レコード更新年月日',
	PRIMARY KEY (`job_id`),
	KEY `ix_t_job_rpt_id_rel1`(`job_pgm_id`),
	KEY `ix_t_job_rpt_id_rel2`(`job_rpt_comp_id`),
	KEY `ix_t_job_rpt_id_rel3`(`shop_id`),
	KEY `ix_t_job_rpt_id_rel4`(`group_flg`),
	KEY `ix_t_job_rpt_id_rel5`(`del_flg`)
) COMMENT='T_作業ID関連';

#-----------------------------------------------------------------------------
#-- t_job_aprt_pgm
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `t_job_aprt_pgm`;


CREATE TABLE `t_job_aprt_pgm`
(
	`job_pgm_id` INTEGER UNSIGNED  NOT NULL COMMENT '作業予定情報ID',
	`job_aprt_no` INTEGER UNSIGNED  NOT NULL COMMENT '作業予定情報毎の連番',
	`setup_type` TINYINT UNSIGNED COMMENT '0:未使用 1:販売店用意 2:お客様用意 画面の表示は設置有無',
	`setup_prdct_code` VARCHAR(11) COMMENT '機器設置区分が 2:お客様用意 の場合はNULL',
	`prdct_name` VARCHAR(100)  NOT NULL COMMENT '機器設置区分が 2:お客様用意 の場合は名称を手入力',
	`setup_use_type` TINYINT UNSIGNED  NOT NULL COMMENT '0:受付用 1:スタッフ用 画面の表示は設置区分',
	`prdct_serial` VARCHAR(30) COMMENT '端末シリアル',
	`use_cabinet_flg` TINYINT UNSIGNED COMMENT '0:なし 1:あり',
	`cabinet_serial` VARCHAR(30) COMMENT '筐体シリアル',
	`line_speed` FLOAT(5,1) COMMENT '回線速度',
	`ip_addr_type` TINYINT UNSIGNED COMMENT '0:DHCP 1:固定',
	`ip_addr` CHAR(15) COMMENT 'xxx.xxx.xxx.xxx',
	`subnet_mask` CHAR(15) COMMENT 'xxx.xxx.xxx.xxx',
	`default_gateway` CHAR(15) COMMENT 'xxx.xxx.xxx.xxx',
	`primary_dns` CHAR(15) COMMENT 'xxx.xxx.xxx.xxx',
	`secondary_dns` CHAR(15) COMMENT 'xxx.xxx.xxx.xxx',
	`aprt_chg_flg` TINYINT UNSIGNED COMMENT '0:なし 1:あり',
	`old_prdct_name` VARCHAR(100) COMMENT '旧端末種別名',
	`old_prdct_serial` VARCHAR(30) COMMENT '旧シリアル',
	`created_at` DATETIME  NOT NULL COMMENT 'レコード作成年月日',
	`updated_at` DATETIME  NOT NULL COMMENT 'レコード更新年月日',
	PRIMARY KEY (`job_pgm_id`,`job_aprt_no`),
	KEY `fk_t_job_rpt_pgm_t_job_aprt_pgm`(`job_pgm_id`),
	KEY `fk_m_job_rpt_products_t_job_aprt_pgm`(`setup_prdct_code`)
) COMMENT='T_機器作業予定情報';

#-----------------------------------------------------------------------------
#-- t_job_printer_pgm
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `t_job_printer_pgm`;


CREATE TABLE `t_job_printer_pgm`
(
	`job_pgm_id` INTEGER UNSIGNED  NOT NULL COMMENT '作業予定情報を一意に管理するID',
	`job_printer_no` INTEGER UNSIGNED  NOT NULL COMMENT '作業予定情報毎の連番',
	`setup_type` TINYINT UNSIGNED COMMENT '0:未使用 1:販売店用意 2:お客様用意 画面の表示は設置有無',
	`setup_prdct_code` VARCHAR(11) COMMENT '機器設置区分が 2:お客様用意 の場合はNULL',
	`printer_name` VARCHAR(100)  NOT NULL COMMENT '機器設置区分が 2:お客様用意 の場合は名称を手入力',
	`printer_serial` VARCHAR(30) COMMENT 'プリンタシリアル',
	`conect_aprt_serial` VARCHAR(30) COMMENT '接続機器シリアル',
	`printer_chg_flg` TINYINT UNSIGNED COMMENT '0:なし 1:あり',
	`old_prdct_name` VARCHAR(100) COMMENT '旧端末種別名',
	`old_prdct_serial` VARCHAR(30) COMMENT '旧シリアル',
	`created_at` DATETIME  NOT NULL COMMENT 'レコード作成年月日',
	`updated_at` DATETIME  NOT NULL COMMENT 'レコード更新年月日',
	PRIMARY KEY (`job_pgm_id`,`job_printer_no`),
	KEY `fk_t_job_rpt_pgm_t_job_printer_pgm`(`job_pgm_id`),
	KEY `fk_m_job_rpt_products_t_job_printer_pgm`(`setup_prdct_code`)
) COMMENT='T_プリンタ作業予定情報';

#-----------------------------------------------------------------------------
#-- t_job_mntr_pgm
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `t_job_mntr_pgm`;


CREATE TABLE `t_job_mntr_pgm`
(
	`job_pgm_id` INTEGER UNSIGNED  NOT NULL COMMENT '作業予定情報ID',
	`job_mntr_no` INTEGER UNSIGNED  NOT NULL COMMENT '作業予定情報毎の連番',
	`setup_type` TINYINT UNSIGNED COMMENT '0:未使用 1:販売店用意 2:お客様用意 画面の表示は設置有無',
	`mntr_model_no` VARCHAR(30) COMMENT '表示機・モニタ型番',
	`created_at` DATETIME  NOT NULL COMMENT 'レコード作成年月日',
	`updated_at` DATETIME  NOT NULL COMMENT 'レコード更新年月日',
	PRIMARY KEY (`job_pgm_id`,`job_mntr_no`),
	KEY `fk_t_job_rpt_pgm_t_job_monitor_pgm`(`job_pgm_id`)
) COMMENT='T_モニタ作業予定情報';

#-----------------------------------------------------------------------------
#-- t_job_router_pgm
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `t_job_router_pgm`;


CREATE TABLE `t_job_router_pgm`
(
	`job_pgm_id` INTEGER UNSIGNED  NOT NULL COMMENT '作業予定情報ID',
	`job_router_no` INTEGER UNSIGNED  NOT NULL COMMENT '作業予定情報毎の連番',
	`setup_type` TINYINT UNSIGNED COMMENT '0:未使用 1:販売店用意 2:お客様用意 画面の表示は設置有無',
	`setup_prdct_code` VARCHAR(11) COMMENT '商品コード',
	`prdct_name` VARCHAR(100)  NOT NULL COMMENT '商品コードに存在しなければ、手入力',
	`ip_addr` CHAR(15) COMMENT 'xxx.xxx.xxx.xxx',
	`ssid_name` VARCHAR(32) COMMENT 'SSID名',
	`created_at` DATETIME  NOT NULL COMMENT 'レコード作成年月日',
	`updated_at` DATETIME  NOT NULL COMMENT 'レコード更新年月日',
	PRIMARY KEY (`job_pgm_id`,`job_router_no`),
	KEY `fk_t_job_rpt_pgm_t_job_router_pgm`(`job_pgm_id`),
	KEY `fk_m_job_rpt_products_t_job_router_pgm`(`setup_prdct_code`)
) COMMENT='T_ルータ作業予定情報';

#-----------------------------------------------------------------------------
#-- t_job_aprt_comp
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `t_job_aprt_comp`;


CREATE TABLE `t_job_aprt_comp`
(
	`job_rpt_comp_id` INTEGER UNSIGNED  NOT NULL COMMENT '作業完了情報を一意に管理するID',
	`job_aprt_no` INTEGER UNSIGNED  NOT NULL COMMENT '作業完了情報毎の連番',
	`setup_type` TINYINT UNSIGNED COMMENT '0:未使用 1:販売店用意 2:お客様用意 画面の表示は設置有無',
	`setup_prdct_code` VARCHAR(11) COMMENT '機器設置区分が 2:お客様用意 の場合はNULL',
	`prdct_name` VARCHAR(100)  NOT NULL COMMENT '機器設置区分が 2:お客様用意 の場合は名称を手入力',
	`setup_use_type` TINYINT UNSIGNED COMMENT '0:受付用 1:スタッフ用 画面の表示は設置区分',
	`prdct_serial` VARCHAR(30)  NOT NULL COMMENT '端末シリアル',
	`use_cabinet_flg` TINYINT UNSIGNED COMMENT '0:なし 1:あり',
	`cabinet_serial` VARCHAR(30) COMMENT '筐体シリアル',
	`line_speed` FLOAT(5,1) COMMENT '回線速度',
	`ip_addr_type` TINYINT UNSIGNED COMMENT '0:DHCP 1:固定',
	`ip_addr` CHAR(15) COMMENT 'xxx.xxx.xxx.xxx',
	`subnet_mask` CHAR(15) COMMENT 'xxx.xxx.xxx.xxx',
	`default_gateway` CHAR(15) COMMENT 'xxx.xxx.xxx.xxx',
	`primary_dns` CHAR(15) COMMENT 'xxx.xxx.xxx.xxx',
	`secondary_dns` CHAR(15) COMMENT 'xxx.xxx.xxx.xxx',
	`apparratus_chg_flg` TINYINT UNSIGNED COMMENT '0:なし 1:あり',
	`old_prdct_name` VARCHAR(100) COMMENT '旧端末種別名',
	`old_prdct_serial` VARCHAR(30) COMMENT '旧シリアル',
	`created_at` DATETIME  NOT NULL COMMENT 'レコード作成年月日',
	`updated_at` DATETIME  NOT NULL COMMENT 'レコード更新年月日',
	PRIMARY KEY (`job_rpt_comp_id`,`job_aprt_no`),
	KEY `fk_t_job_rpt_comp_t_job_aprt_comp`(`job_rpt_comp_id`),
	KEY `fk_m_job_rpt_product_t_job_aprt_comp`(`setup_prdct_code`)
) COMMENT='T_機器作業完了情報';

#-----------------------------------------------------------------------------
#-- t_job_printer_comp
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `t_job_printer_comp`;


CREATE TABLE `t_job_printer_comp`
(
	`job_rpt_comp_id` INTEGER UNSIGNED  NOT NULL COMMENT '作業完了情報を一意に管理するID',
	`job_printer_no` INTEGER UNSIGNED  NOT NULL COMMENT '作業完了情報毎の連番',
	`setup_type` TINYINT UNSIGNED COMMENT '0:未使用 1:販売店用意 2:お客様用意 画面の表示は設置有無',
	`setup_prdct_code` VARCHAR(11) COMMENT '機器設置区分が 2:お客様用意 の場合はNULL',
	`printer_name` VARCHAR(100)  NOT NULL COMMENT '機器設置区分が 2:お客様用意 の場合は名称を手入力',
	`printer_serial` VARCHAR(30) COMMENT 'プリンタシリアル',
	`conect_aprt_serial` VARCHAR(30) COMMENT '接続機器シリアル',
	`printer_chg_flg` TINYINT UNSIGNED COMMENT '0:なし 1:あり',
	`old_prdct_name` VARCHAR(100) COMMENT '旧端末種別名',
	`old_prdct_serial` VARCHAR(30) COMMENT '旧シリアル',
	`created_at` DATETIME  NOT NULL COMMENT 'レコード作成年月日',
	`updated_at` DATETIME  NOT NULL COMMENT 'レコード更新年月日',
	PRIMARY KEY (`job_rpt_comp_id`,`job_printer_no`),
	KEY `fk_t_job_rpt_comp_t_job_printer_comp`(`job_rpt_comp_id`),
	KEY `fk_m_job_rpt_product_t_job_printer_comp`(`setup_prdct_code`)
) COMMENT='T_プリンタ作業完了情報';

#-----------------------------------------------------------------------------
#-- t_job_mntr_comp
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `t_job_mntr_comp`;


CREATE TABLE `t_job_mntr_comp`
(
	`job_rpt_comp_id` INTEGER UNSIGNED  NOT NULL COMMENT '作業完了情報を一意に管理するID',
	`job_mntr_no` INTEGER UNSIGNED  NOT NULL COMMENT '作業完了情報毎の連番',
	`setup_type` TINYINT UNSIGNED COMMENT '0:未使用 1:販売店用意 2:お客様用意 画面の表示は設置有無',
	`mntr_model_no` VARCHAR(30) COMMENT '表示機・モニタ型番',
	`created_at` DATETIME  NOT NULL COMMENT 'レコード作成年月日',
	`updated_at` DATETIME  NOT NULL COMMENT 'レコード更新年月日',
	PRIMARY KEY (`job_rpt_comp_id`,`job_mntr_no`),
	KEY `fk_t_job_rpt_comp_t_job_monitor_pgm1`(`job_rpt_comp_id`)
) COMMENT='T_モニタ作業完了情報';

#-----------------------------------------------------------------------------
#-- t_job_router_comp
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `t_job_router_comp`;


CREATE TABLE `t_job_router_comp`
(
	`job_rpt_comp_id` INTEGER UNSIGNED  NOT NULL COMMENT '作業完了情報を一意に管理するID',
	`job_router_no` INTEGER UNSIGNED  NOT NULL COMMENT '作業完了情報毎の連番',
	`setup_type` TINYINT UNSIGNED COMMENT '0:未使用 1:販売店用意 2:お客様用意 画面の表示は設置有無',
	`setup_prdct_code` VARCHAR(11) COMMENT '商品コード',
	`prdct_name` VARCHAR(100)  NOT NULL COMMENT '商品コードに存在しなければ、手入力',
	`ip_addr` CHAR(15) COMMENT 'xxx.xxx.xxx.xxx',
	`ssid_name` VARCHAR(32) COMMENT 'SSID名',
	`created_at` DATETIME  NOT NULL COMMENT 'レコード作成年月日',
	`updated_at` DATETIME  NOT NULL COMMENT 'レコード更新年月日',
	PRIMARY KEY (`job_rpt_comp_id`,`job_router_no`),
	KEY `fk_t_job_rpt_comp_t_job_router_pgm1`(`job_rpt_comp_id`),
	KEY `fk_m_job_rpt_products_t_job_router_comp`(`setup_prdct_code`)
) COMMENT='T_ルータ作業完了情報';

#-----------------------------------------------------------------------------
#-- m_job_rpt_prdct
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `m_job_rpt_prdct`;


CREATE TABLE `m_job_rpt_prdct`
(
	`setup_prdctr_code` VARCHAR(11)  NOT NULL COMMENT '商品コード',
	`job_type_id` INTEGER UNSIGNED  NOT NULL COMMENT '作業報告区分ID',
	`setup_name` VARCHAR(100)  NOT NULL COMMENT '商品名',
	`setup_name_short` VARCHAR(100)  NOT NULL COMMENT '商品略称 メール送信用名称',
	`select_type` TINYINT UNSIGNED  NOT NULL COMMENT '0:通常 1:保守案件（あまり選択頻度が多くない商品）',
	`disp_order` TINYINT  NOT NULL COMMENT '表示時の並び順',
	`last_updated_user_id` INTEGER(11) UNSIGNED  NOT NULL COMMENT 'admin_userテーブルのidと紐づきます。',
	`ope_type` TINYINT  NOT NULL COMMENT '運用状態を表す 0：運用中 1：運用停止 2：削除済',
	`created_at` DATETIME  NOT NULL COMMENT 'レコード作成年月日',
	`updated_at` DATETIME  NOT NULL COMMENT 'レコード更新年月日',
	PRIMARY KEY (`setup_prdctr_code`),
	KEY `fk_admin_user_m_job_rpt_products`(`last_updated_user_id`)
) COMMENT='M_設置商品マスタ';

#-----------------------------------------------------------------------------
#-- t_shop_aprt_info
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `t_shop_aprt_info`;


CREATE TABLE `t_shop_aprt_info`
(
	`shop_aprt_id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT '店舗別機器情報ID',
	`shop_id` INTEGER(11) UNSIGNED  NOT NULL COMMENT 'EPARK店舗、SBM店舗ID',
	`service_code` VARCHAR(8) COMMENT 'サービスを識別 EP:Epark、TM:時間割、SBM:ソフトバンク',
	`setup_type` TINYINT UNSIGNED COMMENT '0:未使用 1:販売店用意 2:お客様用意 画面の表示は設置有無',
	`setup_prdct_code` VARCHAR(11) COMMENT '機器設置区分が 2:お客様用意 の場合はNULL',
	`prdct_name` VARCHAR(100)  NOT NULL COMMENT '機器設置区分が 2:お客様用意 の場合は名称を手入力',
	`setup_use_type` TINYINT UNSIGNED COMMENT '0:受付用 1:スタッフ用 画面の表示は設置区分',
	`prdct_serial` VARCHAR(30)  NOT NULL COMMENT '端末シリアル',
	`use_cabinet_flg` TINYINT UNSIGNED COMMENT '0:なし 1:あり',
	`cabinet_serial` VARCHAR(30) COMMENT '筐体シリアル',
	`line_speed` FLOAT(5,1) COMMENT '回線速度',
	`ip_addr_type` TINYINT UNSIGNED COMMENT '0:DHCP 1:固定',
	`ip_addr` CHAR(15) COMMENT 'xxx.xxx.xxx.xxx',
	`subnet_mask` CHAR(15) COMMENT 'xxx.xxx.xxx.xxx',
	`default_gateway` CHAR(15) COMMENT 'xxx.xxx.xxx.xxx',
	`primary_dns` CHAR(15) COMMENT 'xxx.xxx.xxx.xxx',
	`secondary_dns` CHAR(15) COMMENT 'xxx.xxx.xxx.xxx',
	`aprt_chg_flg` TINYINT UNSIGNED COMMENT '0:なし 1:あり',
	`old_prdct_name` VARCHAR(100) COMMENT '旧端末種別名',
	`old_prdct_serial` VARCHAR(30) COMMENT '旧シリアル',
	`created_at` DATETIME  NOT NULL COMMENT 'レコード作成年月日',
	`updated_at` DATETIME  NOT NULL COMMENT 'レコード更新年月日',
	PRIMARY KEY (`shop_aprt_id`),
	KEY `ix_shop_t_shop_aprt_comp`(`shop_id`),
	KEY `ix_m_job_rpt_product_t_shop_aprt_comp`(`setup_prdct_code`)
) COMMENT='T_店舗別機器情報';

#-----------------------------------------------------------------------------
#-- t_shop_printer_info
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `t_shop_printer_info`;


CREATE TABLE `t_shop_printer_info`
(
	`job_printer_no` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT '作業完了情報毎の連番',
	`shop_id` INTEGER UNSIGNED  NOT NULL COMMENT 'EPARK店舗、SBM店舗ID',
	`setup_type` TINYINT UNSIGNED COMMENT '0:未使用 1:販売店用意 2:お客様用意 画面の表示は設置有無',
	`setup_prdct_code` VARCHAR(11) COMMENT '機器設置区分が 2:お客様用意 の場合はNULL',
	`printer_name` VARCHAR(100)  NOT NULL COMMENT '機器設置区分が 2:お客様用意 の場合は名称を手入力',
	`printer_serial` VARCHAR(30) COMMENT 'プリンタシリアル',
	`conect_aprt_serial` VARCHAR(30) COMMENT '接続機器シリアル',
	`printer_chg_flg` TINYINT UNSIGNED COMMENT '0:なし 1:あり',
	`old_prdct_name` VARCHAR(100) COMMENT '旧端末種別名',
	`old_prdct_serial` VARCHAR(30) COMMENT '旧シリアル',
	`created_at` DATETIME  NOT NULL COMMENT 'レコード作成年月日',
	`updated_at` DATETIME  NOT NULL COMMENT 'レコード更新年月日',
	PRIMARY KEY (`job_printer_no`),
	KEY `ix_shop_t_shop_printer_comp`(`shop_id`),
	KEY `ix_m_job_rpt_products_t_shop_printer_comp`(`setup_prdct_code`)
) COMMENT='T_店舗別プリンタ情報';

#-----------------------------------------------------------------------------
#-- t_shop_mntr_info
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `t_shop_mntr_info`;


CREATE TABLE `t_shop_mntr_info`
(
	`shop_mntr_id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT '店舗別モニタ情報ID',
	`shop_id` INTEGER UNSIGNED  NOT NULL COMMENT 'EPARK店舗、SBM店舗ID',
	`setup_type` TINYINT UNSIGNED COMMENT '0:未使用 1:販売店用意 2:お客様用意 画面の表示は設置有無',
	`mntr_model_no` VARCHAR(30) COMMENT '表示機・モニタ型番',
	`created_at` DATETIME  NOT NULL COMMENT 'レコード作成年月日',
	`updated_at` DATETIME  NOT NULL COMMENT 'レコード更新年月日',
	PRIMARY KEY (`shop_mntr_id`),
	KEY `ix_shop_t_shop_mntr_comp`(`shop_id`)
) COMMENT='T_店舗別モニタ情報';

#-----------------------------------------------------------------------------
#-- t_shop_router_info
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `t_shop_router_info`;


CREATE TABLE `t_shop_router_info`
(
	`job_router_no` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT '店舗別モニタ情報ID',
	`shop_id` INTEGER UNSIGNED  NOT NULL COMMENT 'EPARK店舗、SBM店舗ID',
	`setup_type` TINYINT UNSIGNED COMMENT '0:未使用 1:販売店用意 2:お客様用意 画面の表示は設置有無',
	`setup_prdct_code` VARCHAR(11) COMMENT '設置商品コード',
	`prdct_name` VARCHAR(100)  NOT NULL COMMENT '商品コードに存在しなければ、手入力',
	`ip_addr` CHAR(15) COMMENT 'xxx.xxx.xxx.xxx',
	`ssid_name` VARCHAR(32) COMMENT 'SSID名',
	`created_at` DATETIME  NOT NULL COMMENT 'レコード作成年月日',
	`updated_at` DATETIME  NOT NULL COMMENT 'レコード更新年月日',
	PRIMARY KEY (`job_router_no`),
	KEY `ix_shop_t_shop_router_comp1`(`shop_id`),
	KEY `ix_m_job_rpt_products_t_shop_router_comp1`(`setup_prdct_code`)
) COMMENT='T_店舗別ルータ情報';

#-----------------------------------------------------------------------------
#-- w_job_rpt_csv_fmt
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `w_job_rpt_csv_fmt`;


CREATE TABLE `w_job_rpt_csv_fmt`
(
	`csv_fmt_id` INTEGER(11) UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT 'CSVフォーマットID',
	`imp_exp_flg` TINYINT(1) UNSIGNED  NOT NULL COMMENT 'インポートかエクスポートかを区別します。 0:インポート 1:エクスポート',
	`owner_shop_id` INTEGER(11)  NOT NULL COMMENT 'オーナーショップID',
	`owner_shop_name` VARCHAR(80)  NOT NULL COMMENT 'オーナー店舗名',
	`shop_id` INTEGER(11) UNSIGNED COMMENT '店舗ID',
	`shop_name` VARCHAR(80)  NOT NULL COMMENT '店舗名',
	`service_code` VARCHAR(8)  NOT NULL COMMENT 'サービスを識別 EP:Epark、TM:時間割、SBM:ソフトバンク',
	`job_rpt_id` INTEGER UNSIGNED  NOT NULL COMMENT 'インポート時は、チェック用に使用するので、NULLの状態があります。',
	`job_code` VARCHAR(20)  NOT NULL COMMENT '工事コード',
	`job_status` TINYINT UNSIGNED  NOT NULL COMMENT '作業区分 1:予定 2:報告 3:完了確認 4：差戻し 5:一時保管',
	`job_date` DATE COMMENT 'YYYY-MM-DD',
	`job_start_time` TIME COMMENT 'HH:MM:SS',
	`job_end_time` TIME COMMENT 'HH:MM:SS',
	`op_shop_hope_date` DATE COMMENT '店舗情報解放希望日',
	`job_big_type_code` TINYINT UNSIGNED COMMENT '作業内容大区分コード',
	`job_big_type_name` VARCHAR(30) COMMENT '作業内容大区分',
	`job_mid_type_code` TINYINT UNSIGNED COMMENT '作業内容中区分コード',
	`job_mid_type_name` VARCHAR(30) COMMENT '作業内容中区分',
	`job_min_type_code` VARCHAR(100) COMMENT '作業内容小区分コード',
	`job_min_type_name` VARCHAR(255) COMMENT '作業内容小区分',
	`tr_big_type_code` TINYINT UNSIGNED COMMENT '研修内容大区分コード',
	`tr_big_type_name` VARCHAR(30) COMMENT '研修内容大区分',
	`tr_mid_type_code` TINYINT UNSIGNED COMMENT '研修内容中区分コード',
	`tr_mid_type_name` VARCHAR(30) COMMENT '研修内容中区分',
	`tr_min_type_code` VARCHAR(100) COMMENT '研修内容小区分コード',
	`tr_min_type_name` VARCHAR(255) COMMENT '研修内容小区分',
	`trader_code` VARCHAR(11) COMMENT '業者コード',
	`trader_name` VARCHAR(30) COMMENT '業者名',
	`worker_id` INTEGER UNSIGNED COMMENT '設置作業者ID',
	`worker_name` VARCHAR(30) COMMENT '作業者名',
	`use_svc_memo` VARCHAR(255) COMMENT '■順番待ち＋将来順番予約 ■会員証なし ■音声呼出なし ■iPad 1 アカウント ■メール配信 あり',
	`send_mail_type` TINYINT UNSIGNED COMMENT 'メール送信区分',
	`argee_job_type` TINYINT UNSIGNED COMMENT '作業完了同意区分',
	`argee_job_dtl_type` VARCHAR(10) COMMENT '作業完了同意内訳',
	`csv_uplodat_at` DATETIME COMMENT 'CSV取り込み日',
	`csv_upload_name` VARCHAR(30) COMMENT 'CSV取り込み実行者',
	`job_rpt_send_at` DATETIME COMMENT '作業報告送信日',
	`job_rpt_send_name` VARCHAR(30) COMMENT '作業報告送信者',
	`last_updated_at` DATETIME COMMENT '最終更新日',
	`last_updated_name` VARCHAR(30) COMMENT '最終更新者',
	`last_conf_at` DATETIME COMMENT '最終完了確認日',
	`last_conf_name` VARCHAR(30) COMMENT '最終完了確認者',
	`comp_mail_send_at` DATETIME COMMENT '作業完了メール送信日',
	`comp_mail_send_name` VARCHAR(30) COMMENT '作業完了メール送信者',
	`dtl_info_type` TINYINT UNSIGNED  NOT NULL COMMENT '1:機器 2:プリンタ 3:表示機・モニター 4:ルータ、wifi',
	`job_aprt_no` INTEGER UNSIGNED COMMENT '機器作業連番',
	`aprt_setup_type` TINYINT UNSIGNED COMMENT '0:未使用 1:販売店用意 2:お客様用意',
	`aprt_setup_prdct_code` VARCHAR(11) COMMENT '端末設置商品コード',
	`aprt_prdct_name` VARCHAR(100) COMMENT '端末商品名称',
	`aprt_setup_use_type` TINYINT UNSIGNED COMMENT '端末設置用途区分',
	`aprt_prdct_serial` VARCHAR(30) COMMENT '端末シリアル',
	`aprt_use_cabinet_flg` TINYINT UNSIGNED COMMENT '0:なし 1:あり',
	`aprt_cabinet_serial` VARCHAR(30) COMMENT '端末筐体シリアル',
	`aprt_line_speed` FLOAT(5,1) COMMENT '端末回線速度',
	`aprt_ip_addr_type` TINYINT UNSIGNED COMMENT '0:DHCP 1:固定',
	`aprt_ip_addr` CHAR(15) COMMENT 'xxx.xxx.xxx.xxx',
	`aprt_subnet_mask` CHAR(15) COMMENT 'xxx.xxx.xxx.xxx',
	`aprt_default_gateway` CHAR(15) COMMENT 'xxx.xxx.xxx.xxx',
	`aprt_primary_dns` CHAR(15) COMMENT 'xxx.xxx.xxx.xxx',
	`aprt_secondary_dns` CHAR(15) COMMENT 'xxx.xxx.xxx.xxx',
	`aprt_chg_flg` TINYINT UNSIGNED COMMENT '0:なし 1:あり',
	`aprt_old_prdct_name` VARCHAR(100) COMMENT '端末旧端末種別名',
	`aprt_old_prdct_serial` VARCHAR(30) COMMENT '端末旧シリアル',
	`job_printer_no` INTEGER UNSIGNED COMMENT 'プリンタ作業連番',
	`pr_set_type` TINYINT UNSIGNED COMMENT '0:未使用 1:販売店用意 2:お客様用意',
	`pr_setup_prdct_code` VARCHAR(11) COMMENT 'プリンタ設置商品コード',
	`pr_printer_name` VARCHAR(100) COMMENT 'プリンタ名称',
	`pr_printer_serial` VARCHAR(30) COMMENT 'プリンタシリアル',
	`pr_conect_aprt_serial` VARCHAR(30) COMMENT 'プリンタ接続機器シリアル',
	`pr_printer_chg_flg` TINYINT UNSIGNED COMMENT 'プリンタ入替フラグ',
	`pr_old_prdct_name` VARCHAR(100) COMMENT 'プリンタ旧端末種別名',
	`pr_old_prdct_serial` VARCHAR(30) COMMENT 'プリンタ旧シリアル',
	`job_mntr_no` INTEGER UNSIGNED COMMENT 'モニタ作業連番',
	`mntr_setup_type` TINYINT UNSIGNED COMMENT '0:未使用 1:販売店用意 2:お客様用意',
	`mntr_model_no` VARCHAR(30) COMMENT 'モニタ型番',
	`job_router_no` INTEGER UNSIGNED COMMENT 'ルータ作業連番',
	`router_setup_type` TINYINT UNSIGNED COMMENT '0:未使用 1:販売店用意 2:お客様用意',
	`router_setup_prdct_code` VARCHAR(11) COMMENT 'ルータ設置商品コード',
	`router_prdct_name` VARCHAR(100) COMMENT '商品コードに存在しなければ、手入力',
	`router_ip_addr` VARCHAR(15) COMMENT 'xxx.xxx.xxx.xxx',
	`router_ssid_name` VARCHAR(32) COMMENT 'ルータSSID名',
	`update_status` TINYINT UNSIGNED COMMENT '更新ステータス 0:新規 1:更新 2:対象外 9:エラー',
	`created_at` DATETIME  NOT NULL COMMENT 'レコード作成年月日',
	`updated_at` DATETIME  NOT NULL COMMENT 'レコード更新年月日',
	PRIMARY KEY (`csv_fmt_id`),
	KEY `ix_w_wk_rpt_csv_format1`(`imp_exp_flg`, `created_at`)
) COMMENT='作業報告CSVフォーマットテンポラリ';

#-----------------------------------------------------------------------------
#-- i_resty_shop_cnf
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `i_resty_shop_cnf`;


CREATE TABLE `i_resty_shop_cnf`
(
	`shop_id` INTEGER UNSIGNED  NOT NULL COMMENT '店舗ID',
	`resty_shop_id` INTEGER COMMENT 'resty店舗ID',
	`resty_site_id` VARCHAR(40) COMMENT 'restyサイトID',
	`sha256_resty_shop_id` VARCHAR(64) COMMENT 'sha256 Resty店舗ID',
	`sha256_resty_site_id` VARCHAR(64) COMMENT 'sha256 RestyサイトID',
	`plan_id` TINYINT default 1 NOT NULL COMMENT 'プランID 1:空席検索（○△表示） 2:空席検索（○△表示なし） 3:テーブル条件予約 4:特別プラン予約',
	`is_rb` INTEGER default 0 NOT NULL COMMENT 'ReservationBook確認 0:Resty 1:ReservationBook',
	`created_at` DATETIME  NOT NULL COMMENT '作成年月日',
	`updated_at` DATETIME  NOT NULL COMMENT '更新年月日',
	PRIMARY KEY (`shop_id`),
	UNIQUE KEY `uix_i_resty_shop_cnf1` (`resty_shop_id`),
	UNIQUE KEY `uix_i_resty_shop_cnf2` (`sha256_resty_shop_id`)
) COMMENT='I_Resty店舗設定';

#-----------------------------------------------------------------------------
#-- i_medicine_notice
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `i_medicine_notice`;


CREATE TABLE `i_medicine_notice`
(
	`medicine_notice_id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT 'お薬手帳お知らせID',
	`notice_title` VARCHAR(100)  NOT NULL COMMENT 'お知らせタイトル',
	`notice_body` VARCHAR(1024)  NOT NULL COMMENT 'お知らせ本文',
	`disp_start_at` DATETIME default '9999-12-31 23:59:59' NOT NULL COMMENT 'お知らせ公開開始日時',
	`disp_end_at` DATETIME default '9999-12-31 23:59:59' NOT NULL COMMENT 'お知らせ公開終了日時',
	`created_at` DATETIME COMMENT '作成日時',
	`updated_at` DATETIME COMMENT '更新日時',
	PRIMARY KEY (`medicine_notice_id`)
) COMMENT='お薬手帳お知らせ';

#-----------------------------------------------------------------------------
#-- i_medicine_icon
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `i_medicine_icon`;


CREATE TABLE `i_medicine_icon`
(
	`medicine_icon_id` INTEGER  NOT NULL AUTO_INCREMENT COMMENT 'medicine_icon_id',
	`medicine_icon_title` VARCHAR(100)  NOT NULL COMMENT 'お薬手帳アプリアイコンのタイトル',
	`medicine_icon_url` VARCHAR(1024)  NOT NULL COMMENT 'お薬手帳アプリアイコンのURL',
	`use_status` TINYINT default 0 NOT NULL COMMENT '利用状況ステータス',
	`created_at` DATETIME default '1900-01-01 00:00:00' COMMENT '作成日時',
	`updated_at` DATETIME default '1900-01-01 00:00:00' COMMENT '更新日時',
	PRIMARY KEY (`medicine_icon_id`)
) COMMENT='お薬手帳アイコン情報';

#-----------------------------------------------------------------------------
#-- h_nsips_cordi_error
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `h_nsips_cordi_error`;


CREATE TABLE `h_nsips_cordi_error`
(
	`nsips_cordi_error_id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT 'NSIPS連携エラー情報ID',
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID',
	`error_code` VARCHAR(255) COMMENT 'エラーCD',
	`error_message` VARCHAR(2048)  NOT NULL COMMENT 'エラーメッセージ',
	`created_at` DATETIME COMMENT '作成日時',
	`updated_at` DATETIME COMMENT '更新日時',
	PRIMARY KEY (`nsips_cordi_error_id`)
) COMMENT='NSIPS連携エラー情報';

#-----------------------------------------------------------------------------
#-- m_mem_app_id
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `m_mem_app_id`;


CREATE TABLE `m_mem_app_id`
(
	`member_id` INTEGER UNSIGNED  NOT NULL COMMENT 'EPARK会員ID',
	`mem_app_id` VARCHAR(100)  NOT NULL COMMENT 'EPARK会員アプリID',
	`created_at` DATETIME  NOT NULL COMMENT '作成日時',
	`updated_at` DATETIME  NOT NULL COMMENT '更新日時',
	PRIMARY KEY (`member_id`),
	KEY `ix_m_mem_app_id1`(`mem_app_id`)
) COMMENT='M_EPARK会員アプリID管理マスタ';

#-----------------------------------------------------------------------------
#-- t_mem_relate_fin
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `t_mem_relate_fin`;


CREATE TABLE `t_mem_relate_fin`
(
	`mem_relate_fin_id` INTEGER  NOT NULL AUTO_INCREMENT COMMENT '会員連携完了情報ID',
	`client_id` VARCHAR(128)  NOT NULL COMMENT 'クライアントID',
	`grp_mem_id` VARCHAR(128)  NOT NULL COMMENT 'グループサイト会員ID',
	`epark_mem_id` INTEGER  NOT NULL COMMENT 'EPARK会員ID',
	`delete_flg` INTEGER  NOT NULL COMMENT '削除フラグ 0:有効 1:削除',
	`created_at` DATETIME  NOT NULL COMMENT '作成日時',
	`updated_at` DATETIME  NOT NULL COMMENT '更新日時',
	PRIMARY KEY (`mem_relate_fin_id`),
	KEY `UIX_t_mem_relate_fin`(`client_id`, `grp_mem_id`),
	KEY `IX_t_mem_relate_fin2`(`epark_mem_id`)
) COMMENT='T_EPARK会員連携完了情報';

#-----------------------------------------------------------------------------
#-- t_mem_relate_resign
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `t_mem_relate_resign`;


CREATE TABLE `t_mem_relate_resign`
(
	`mem_relate_resign_id` INTEGER  NOT NULL AUTO_INCREMENT COMMENT '会員連携退会情報ID',
	`resign_ymd` INTEGER  NOT NULL COMMENT '退会年月日',
	`client_id` VARCHAR(128)  NOT NULL COMMENT 'クライアントID',
	`grp_mem_id` VARCHAR(128)  NOT NULL COMMENT 'グループサイト会員ID',
	`epark_mem_id` INTEGER  NOT NULL COMMENT 'EPARK会員ID',
	`delete_flg` INTEGER  NOT NULL COMMENT '削除フラグ 0:有効 1:削除',
	`created_at` DATETIME  NOT NULL COMMENT '作成日時',
	`updated_at` DATETIME  NOT NULL COMMENT '更新日時',
	PRIMARY KEY (`mem_relate_resign_id`),
	KEY `IX_t_mem_relate_resign`(`resign_ymd`, `client_id`)
) COMMENT='T_EPARK会員連携退会情報';

#-----------------------------------------------------------------------------
#-- m_mem_cardlist
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `m_mem_cardlist`;


CREATE TABLE `m_mem_cardlist`
(
	`member_id` INTEGER  NOT NULL COMMENT '会員ID',
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID',
	`group_id` INTEGER  NOT NULL COMMENT 'グループID',
	`display_order` INTEGER UNSIGNED default 1 NOT NULL COMMENT '表示順序',
	`news_status` TINYINT UNSIGNED default 1 NOT NULL COMMENT 'メール配信ステータス 0: 拒否 1: 希望',
	`created_at` DATETIME COMMENT 'レコード作成年月日',
	`updated_at` DATETIME COMMENT 'レコード更新年月日',
	PRIMARY KEY (`member_id`,`shop_id`,`group_id`)
) COMMENT='M_CardBookメンバーカードリスト';

#-----------------------------------------------------------------------------
#-- t_cardbook_account
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `t_cardbook_account`;


CREATE TABLE `t_cardbook_account`
(
	`accounting_id` INTEGER  NOT NULL COMMENT 'カードブック会計データID',
	`owner_shop_id` INTEGER  NOT NULL COMMENT 'オーナー店舗ID',
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID',
	`business_date` DATE  NOT NULL COMMENT '処理対象の営業日',
	`denpyo_no` INTEGER  NOT NULL COMMENT '伝票番号',
	`pos_no` INTEGER  NOT NULL COMMENT 'レジ番号',
	`receipt_no` INTEGER  NOT NULL COMMENT 'レシート番号',
	`member_code` VARCHAR(20)  NOT NULL COMMENT 'POS会計時に読みこんだ会員カードNO',
	`customer_cnt` INTEGER  NOT NULL COMMENT '会計人数',
	`bill_date` DATETIME  NOT NULL COMMENT '会計日時',
	`item_total_price` INTEGER  NOT NULL COMMENT '合計金額',
	`add_price_point` INTEGER UNSIGNED default 0 COMMENT '金額付与ポイント',
	`shop_member_card_id` INTEGER COMMENT '来店ポイント会員証ID',
	`created_at` DATETIME COMMENT 'レコード作成年月日',
	`updated_at` DATETIME COMMENT 'レコード更新年月日',
	PRIMARY KEY (`accounting_id`),
	UNIQUE KEY `t_cardbook_account_uniq` (`shop_id`, `pos_no`, `receipt_no`, `bill_date`),
	KEY `index_t_cardbook_accounting1`(`owner_shop_id`),
	KEY `index_t_cardbook_accounting2`(`business_date`),
	KEY `index_t_cardbook_accounting3`(`member_code`),
	KEY `pk_t_cardbook_accounting`(`shop_id`, `business_date`, `pos_no`, `receipt_no`)
) COMMENT='T_カードブック会計データ';

#-----------------------------------------------------------------------------
#-- t_cardbook_shop
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `t_cardbook_shop`;


CREATE TABLE `t_cardbook_shop`
(
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID',
	`group_id` INTEGER  NOT NULL COMMENT 'グループID',
	`pos_type` TINYINT UNSIGNED default 0 NOT NULL COMMENT 'POS端末の種類',
	`is_pos` TINYINT(1) UNSIGNED default 1 NOT NULL COMMENT 'POS連携店舗',
	`seq_mem_code` INTEGER UNSIGNED default 0 NOT NULL COMMENT 'バーコードに割り振る会員コード用のシーケンス',
	`barcode_spec` TINYINT UNSIGNED COMMENT 'バーコードの規格',
	`barcode_len` INTEGER UNSIGNED default 0 NOT NULL COMMENT 'バーコードの長さ',
	`barcode_start_code` VARCHAR(32) default '' NOT NULL COMMENT '開始文字列',
	`barcode_end_code` VARCHAR(32) default '' NOT NULL COMMENT '終了文字列',
	`barcode_cd_cate` TINYINT UNSIGNED default 0 NOT NULL COMMENT 'バーコードのチェックディジットの種類',
	`barcode_prefix` VARCHAR(64) default '' NOT NULL COMMENT 'バーコードの先頭に付加する文字列 (インストアコード、識別コードなど)',
	`cb_shop_photo` VARCHAR(100) default '' NOT NULL COMMENT 'カードブック用店舗詳細画像',
	`last_dwnld_mem_code` INTEGER default 0 NOT NULL COMMENT '最後にダウンロードmem_code',
	`created_at` DATETIME COMMENT 'レコード作成年月日',
	`updated_at` DATETIME COMMENT 'レコード更新年月日',
	PRIMARY KEY (`shop_id`,`group_id`,`pos_type`),
	KEY `ix_t_cardbook_shop1`(`is_pos`),
	KEY `ix_t_cardbook_shop2`(`shop_id`, `group_id`),
	KEY `pk_t_cardbook_shop`(`shop_id`, `group_id`, `pos_type`)
) COMMENT='CardBook参加店舗情報';

#-----------------------------------------------------------------------------
#-- i_cb_shop_info
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `i_cb_shop_info`;


CREATE TABLE `i_cb_shop_info`
(
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID',
	`pos_type` TINYINT UNSIGNED default 0 NOT NULL COMMENT 'POS端末の種類',
	`cb_shop_photo` VARCHAR(100) default '' NOT NULL COMMENT 'カードブック用店舗詳細画像',
	`shop_search_photo` VARCHAR(100) default '' NOT NULL COMMENT 'カードブックお店検索用マイショップ画像名',
	`checkin_flg` TINYINT default 0 NOT NULL COMMENT 'チェックインフラグ',
	`checkin_point_flg` TINYINT default 0 NOT NULL COMMENT 'チェックインポイントフラグ',
	`checkin_point` INTEGER default 0 NOT NULL COMMENT 'チェックインポイント',
	`barcode_flg` TINYINT default 0 NOT NULL COMMENT 'バーコードフラグ 0:表示 1:非表示',
	`qrcode_flg` TINYINT default 0 NOT NULL COMMENT 'QRコードフラグ 0:表示 1:非表示',
	`linear_barcode_flg` TINYINT default 0 NOT NULL COMMENT '1次元バーコードフラグ 0:表示 1:非表示',
	`tel_no_flg` TINYINT default 1 NOT NULL COMMENT '電話番号表示フラグ 0:電話番号を表示しない 1:電話番号を表示する',
	`tel_link_flg` TINYINT default 1 NOT NULL COMMENT '電話番号リンクフラグ 0:リンクをつけない 1:リンクをつける',
	`coupon_sample_photo` VARCHAR(100) COMMENT 'クーポン引き換えの例画像',
	`brandcard_photo` VARCHAR(100) COMMENT 'ブランドカード画像',
	`plan_status` TINYINT default 1 NOT NULL COMMENT 'プランステータス',
	`cb_search_keywords` VARCHAR(1024) COMMENT 'カードブック検索キーワード',
	`coupon_use_msg1_dd_flg` TINYINT default 1 NOT NULL COMMENT 'クーポン使用メッセージ1 (クーポン番号・表示、クーポン使用ボタン・表示の場合) の表示フラグ',
	`coupon_use_msg1_dd` VARCHAR(100) COMMENT 'クーポン使用メッセージ1 (クーポン番号・表示、クーポン使用ボタン・表示の場合)',
	`coupon_use_msg1_dh_flg` TINYINT default 1 NOT NULL COMMENT 'クーポン使用メッセージ1 (クーポン番号・表示、クーポン使用ボタン・非表示の場合) の表示フラグ',
	`coupon_use_msg1_dh` VARCHAR(100) COMMENT 'クーポン使用メッセージ1 (クーポン番号・表示、クーポン使用ボタン・非表示の場合)',
	`coupon_use_msg1_hd_flg` TINYINT default 1 NOT NULL COMMENT 'クーポン使用メッセージ1 (クーポン番号・非表示、クーポン使用ボタン・表示の場合) の表示フラグ',
	`coupon_use_msg1_hd` VARCHAR(100) COMMENT 'クーポン使用メッセージ1 (クーポン番号・非表示、クーポン使用ボタン・表示の場合)',
	`coupon_use_msg1_hh_flg` TINYINT default 1 NOT NULL COMMENT 'クーポン使用メッセージ1 (クーポン番号・非表示、クーポン使用ボタン・非表示の場合) の表示フラグ',
	`coupon_use_msg1_hh` VARCHAR(100) COMMENT 'クーポン使用メッセージ1 (クーポン番号・非表示、クーポン使用ボタン・非表示の場合)',
	`coupon_use_msg2_dd_flg` TINYINT default 1 NOT NULL COMMENT 'クーポン使用メッセージ2 (クーポン番号・表示、クーポン使用ボタン・表示の場合) の表示フラグ',
	`coupon_use_msg2_dd` VARCHAR(100) COMMENT 'クーポン使用メッセージ2 (クーポン番号・表示、クーポン使用ボタン・表示の場合)',
	`coupon_use_msg2_dh_flg` TINYINT default 1 NOT NULL COMMENT 'クーポン使用メッセージ2 (クーポン番号・表示、クーポン使用ボタン・非表示の場合) の表示フラグ',
	`coupon_use_msg2_dh` VARCHAR(100) COMMENT 'クーポン使用メッセージ2 (クーポン番号・表示、クーポン使用ボタン・非表示の場合)',
	`coupon_use_msg2_hd_flg` TINYINT default 1 NOT NULL COMMENT 'クーポン使用メッセージ2 (クーポン番号・非表示、クーポン使用ボタン・表示の場合) の表示フラグ',
	`coupon_use_msg2_hd` VARCHAR(100) COMMENT 'クーポン使用メッセージ2 (クーポン番号・非表示、クーポン使用ボタン・表示の場合)',
	`coupon_use_msg2_hh_flg` TINYINT default 1 NOT NULL COMMENT 'クーポン使用メッセージ2 (クーポン番号・非表示、クーポン使用ボタン・非表示の場合) の表示フラグ',
	`coupon_use_msg2_hh` VARCHAR(100) COMMENT 'クーポン使用メッセージ2 (クーポン番号・非表示、クーポン使用ボタン・非表示の場合)',
	`waiting_tag_flg` TINYINT default 0 NOT NULL COMMENT '順番待ちタグ表示フラグ 1:表示 0:非表示',
	`resty_tag_flg` TINYINT default 0 NOT NULL COMMENT '席予約タグ表示フラグ 1:表示 0:非表示',
	`point_tag_flg` TINYINT default 0 NOT NULL COMMENT 'ポイントタグ表示フラグ 1:表示 0:非表示',
	`takeout_tag_flg` TINYINT default 0 NOT NULL COMMENT 'テイクアウトタグ表示フラグ 1:表示 0:非表示',
	`created_at` DATETIME COMMENT 'レコード作成年月日',
	`updated_at` DATETIME COMMENT 'レコード更新年月日',
	PRIMARY KEY (`shop_id`)
) COMMENT='I_カードブック店舗情報';

#-----------------------------------------------------------------------------
#-- i_cb_group_info
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `i_cb_group_info`;


CREATE TABLE `i_cb_group_info`
(
	`group_id` INTEGER  NOT NULL COMMENT 'グループID',
	`cb_group_photo` VARCHAR(100) default '' NOT NULL COMMENT 'カードブック用店舗詳細画像名',
	`group_search_photo` VARCHAR(100) default '' NOT NULL COMMENT 'カードブックお店検索用マイショップ画像名',
	`checkin_flg` TINYINT default 0 NOT NULL COMMENT 'チェックインフラグ',
	`checkin_point_flg` TINYINT default 0 NOT NULL COMMENT 'チェックインポイントフラグ',
	`checkin_point` INTEGER default 0 NOT NULL COMMENT 'チェックインポイント',
	`barcode_flg` TINYINT default 0 NOT NULL COMMENT 'バーコードフラグ 0:表示 1:非表示',
	`qrcode_flg` TINYINT default 0 NOT NULL COMMENT 'QRコードフラグ 0:表示 1:非表示',
	`linear_barcode_flg` TINYINT default 0 NOT NULL COMMENT '1次元バーコードフラグ 0:表示 1:非表示',
	`tel_setting_sts` TINYINT default 1 NOT NULL COMMENT '電話番号設定方法ステータス 0:各店舗ごとに設定する 1:グループで一括設定する',
	`tel_no_flg` TINYINT default 1 NOT NULL COMMENT '電話番号表示フラグ 0:電話番号を表示しない 1:電話番号を表示する',
	`tel_link_flg` TINYINT default 1 NOT NULL COMMENT '電話番号リンクフラグ 0:リンクをつけない 1:リンクをつける',
	`coupon_sample_photo` VARCHAR(100) COMMENT 'クーポン引き換えの例画像',
	`brandcard_photo` VARCHAR(100) COMMENT 'ブランドカード画像',
	`campaign_url` VARCHAR(255) COMMENT 'キャンペーンURL',
	`campaign_url_flg` VARCHAR(1) default '0' NOT NULL COMMENT 'キャンペーンURL表示フラグ',
	`coupon_use_msg1_dd_flg` TINYINT default 1 NOT NULL COMMENT 'クーポン使用メッセージ1 (クーポン番号・表示、クーポン使用ボタン・表示の場合) の表示フラグ',
	`coupon_use_msg1_dd` VARCHAR(100) COMMENT 'クーポン使用メッセージ1 (クーポン番号・表示、クーポン使用ボタン・表示の場合)',
	`coupon_use_msg1_dh_flg` TINYINT default 1 NOT NULL COMMENT 'クーポン使用メッセージ1 (クーポン番号・表示、クーポン使用ボタン・非表示の場合) の表示フラグ',
	`coupon_use_msg1_dh` VARCHAR(100) COMMENT 'クーポン使用メッセージ1 (クーポン番号・表示、クーポン使用ボタン・非表示の場合)',
	`coupon_use_msg1_hd_flg` TINYINT default 1 NOT NULL COMMENT 'クーポン使用メッセージ1 (クーポン番号・非表示、クーポン使用ボタン・表示の場合) の表示フラグ',
	`coupon_use_msg1_hd` VARCHAR(100) COMMENT 'クーポン使用メッセージ1 (クーポン番号・非表示、クーポン使用ボタン・表示の場合)',
	`coupon_use_msg1_hh_flg` TINYINT default 1 NOT NULL COMMENT 'クーポン使用メッセージ1 (クーポン番号・非表示、クーポン使用ボタン・非表示の場合) の表示フラグ',
	`coupon_use_msg1_hh` VARCHAR(100) COMMENT 'クーポン使用メッセージ1 (クーポン番号・非表示、クーポン使用ボタン・非表示の場合)',
	`coupon_use_msg2_dd_flg` TINYINT default 1 NOT NULL COMMENT 'クーポン使用メッセージ2 (クーポン番号・表示、クーポン使用ボタン・表示の場合) の表示フラグ',
	`coupon_use_msg2_dd` VARCHAR(100) COMMENT 'クーポン使用メッセージ2 (クーポン番号・表示、クーポン使用ボタン・表示の場合)',
	`coupon_use_msg2_dh_flg` TINYINT default 1 NOT NULL COMMENT 'クーポン使用メッセージ2 (クーポン番号・表示、クーポン使用ボタン・非表示の場合) の表示フラグ',
	`coupon_use_msg2_dh` VARCHAR(100) COMMENT 'クーポン使用メッセージ2 (クーポン番号・表示、クーポン使用ボタン・非表示の場合)',
	`coupon_use_msg2_hd_flg` TINYINT default 1 NOT NULL COMMENT 'クーポン使用メッセージ2 (クーポン番号・非表示、クーポン使用ボタン・表示の場合) の表示フラグ',
	`coupon_use_msg2_hd` VARCHAR(100) COMMENT 'クーポン使用メッセージ2 (クーポン番号・非表示、クーポン使用ボタン・表示の場合)',
	`coupon_use_msg2_hh_flg` TINYINT default 1 NOT NULL COMMENT 'クーポン使用メッセージ2 (クーポン番号・非表示、クーポン使用ボタン・非表示の場合) の表示フラグ',
	`coupon_use_msg2_hh` VARCHAR(100) COMMENT 'クーポン使用メッセージ2 (クーポン番号・非表示、クーポン使用ボタン・非表示の場合)',
	`coupon_button_flg` TINYINT default 0 NOT NULL COMMENT 'クーポンボタンフラグ',
	`point_button_flg` TINYINT default 0 NOT NULL COMMENT 'ポイントボタンフラグ',
	`waiting_button_flg` TINYINT default 0 NOT NULL COMMENT '順番待ちボタンフラグ',
	`reservation_button_flg` TINYINT default 0 NOT NULL COMMENT '座席予約ボタンフラグ',
	`takeout_button_flg` TINYINT default 0 NOT NULL COMMENT 'テイクアウトボタンフラグ',
	`others_button_flg` TINYINT default 0 NOT NULL COMMENT 'その他サービスボタンフラグ',
	`created_at` DATETIME COMMENT 'レコード作成年月日',
	`updated_at` DATETIME COMMENT 'レコード更新年月日',
	PRIMARY KEY (`group_id`)
) COMMENT='I_カードブックグループ情報';

#-----------------------------------------------------------------------------
#-- t_mem_cardlist_shop
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `t_mem_cardlist_shop`;


CREATE TABLE `t_mem_cardlist_shop`
(
	`member_id` INTEGER  NOT NULL COMMENT '会員ID',
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID',
	`group_id` INTEGER  NOT NULL COMMENT 'グループID',
	`barcode_type` TINYINT  NOT NULL COMMENT 'バーコードタイプ 0: 画面バーコード、1: 紙バーコード ※今後増える可能性有',
	`pos_type` TINYINT default 0 NOT NULL COMMENT 'POS端末の種類',
	`barcode_mem_code` INTEGER UNSIGNED  NOT NULL COMMENT 'バーコード 会員コード',
	`barcode_text` VARCHAR(50)  NOT NULL COMMENT 'バーコード 文字列',
	`barcode_spec` TINYINT  NOT NULL COMMENT 'バーコードの規格',
	`created_at` DATETIME COMMENT 'レコード作成年月日',
	`updated_at` DATETIME COMMENT 'レコード更新年月日',
	PRIMARY KEY (`member_id`,`shop_id`,`group_id`,`barcode_type`,`pos_type`),
	KEY `ix_t_mem_cardlist_shop1`(`member_id`),
	KEY `ix_t_mem_cardlist_shop2`(`shop_id`),
	KEY `ix_t_mem_cardlist_shop3`(`shop_id`, `group_id`),
	KEY `ix_t_mem_cardlist_shop4`(`shop_id`, `group_id`, `pos_type`),
	KEY `ix_t_mem_cardlist_shop5`(`shop_id`, `group_id`, `barcode_type`, `pos_type`),
	KEY `ix_t_mem_cardlist_shop6`(`group_id`, `member_id`, `barcode_type`),
	KEY `ix_t_mem_cardlist_shop7`(`shop_id`, `group_id`, `pos_type`, `barcode_text`),
	KEY `pk_t_mem_cardlist_shop`(`member_id`, `shop_id`, `group_id`, `barcode_type`, `pos_type`)
) COMMENT='カードリスト内各店舗の情報';

#-----------------------------------------------------------------------------
#-- h_cb_cv_target
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `h_cb_cv_target`;


CREATE TABLE `h_cb_cv_target`
(
	`shop_id` INTEGER UNSIGNED default 0 NOT NULL COMMENT '店舗ID',
	`group_id` INTEGER UNSIGNED default 0 NOT NULL COMMENT 'グループID',
	`member_id` INTEGER UNSIGNED  NOT NULL COMMENT '会員ID',
	`use_coupon_cv_flg` TINYINT UNSIGNED default 0 NOT NULL COMMENT 'クーポン使用コンバージョンフラグ 0:無効 ,1:有効',
	`add_point_cv_flg` TINYINT UNSIGNED default 0 NOT NULL COMMENT 'ポイント追加コンバージョンフラグ 0:無効 ,1:有効',
	`gps_point_cv_flg` TINYINT UNSIGNED default 0 NOT NULL COMMENT 'GPSポイントコンバージョンフラグ 0:無効 ,1:有効',
	`created_at` DATETIME COMMENT 'レコード作成年月日',
	`updated_at` DATETIME COMMENT 'レコード更新年月日',
	PRIMARY KEY (`shop_id`,`group_id`,`member_id`)
) COMMENT='カードブックコンバージョン対象';

#-----------------------------------------------------------------------------
#-- l_cb_start_up_recode
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `l_cb_start_up_recode`;


CREATE TABLE `l_cb_start_up_recode`
(
	`start_up_recode_id` INTEGER UNSIGNED  NOT NULL COMMENT 'スタートアップレコードID',
	`member_id` INTEGER UNSIGNED  NOT NULL COMMENT '会員ID',
	`app_version` VARCHAR(10)  NOT NULL COMMENT 'アプリバージョン',
	`os_type` TINYINT UNSIGNED  NOT NULL COMMENT 'OS種別',
	`initial_start_flg` TINYINT UNSIGNED  NOT NULL COMMENT '初回起動',
	`latitude` DOUBLE  NOT NULL COMMENT '緯度',
	`longitude` DOUBLE  NOT NULL COMMENT '経度',
	`start_up_at` DATETIME  NOT NULL COMMENT '起動日時',
	`created_at` DATETIME COMMENT 'レコード作成年月日',
	`updated_at` DATETIME COMMENT 'レコード更新年月日',
	PRIMARY KEY (`start_up_recode_id`)
) COMMENT='カードブックログイン記録';

#-----------------------------------------------------------------------------
#-- l_cb_use_coupon_log
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `l_cb_use_coupon_log`;


CREATE TABLE `l_cb_use_coupon_log`
(
	`cb_use_coupon_log_id` INTEGER UNSIGNED  NOT NULL COMMENT 'カードブッククーポン使用履歴ID',
	`coupon_id` INTEGER UNSIGNED  NOT NULL COMMENT 'クーポンID',
	`shop_id` INTEGER UNSIGNED  NOT NULL COMMENT '店舗ID',
	`member_id` INTEGER UNSIGNED  NOT NULL COMMENT '会員ID',
	`coupon_type` TINYINT UNSIGNED  NOT NULL COMMENT 'クーポンタイプ',
	`created_at` DATETIME COMMENT 'レコード作成年月日',
	`updated_at` DATETIME COMMENT 'レコード更新年月日',
	PRIMARY KEY (`cb_use_coupon_log_id`)
) COMMENT='カードブッククーポン使用履歴';

#-----------------------------------------------------------------------------
#-- l_cb_myshop_regist
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `l_cb_myshop_regist`;


CREATE TABLE `l_cb_myshop_regist`
(
	`shop_id` INTEGER UNSIGNED  NOT NULL COMMENT '店舗ID',
	`member_id` INTEGER UNSIGNED  NOT NULL COMMENT '会員ID',
	`created_at` DATETIME COMMENT 'レコード作成年月日',
	`updated_at` DATETIME COMMENT 'レコード更新年月日',
	PRIMARY KEY (`shop_id`,`member_id`)
) COMMENT='カードブックマイショップ登録';

#-----------------------------------------------------------------------------
#-- i_insistence_point
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `i_insistence_point`;


CREATE TABLE `i_insistence_point`
(
	`id` INTEGER(8) UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT 'ID',
	`shop_id` INTEGER UNSIGNED COMMENT '店舗ID',
	`group_id` INTEGER UNSIGNED COMMENT 'グループID',
	`title` VARCHAR(30)  NOT NULL COMMENT 'タイトル',
	`insistence_text` VARCHAR(160)  NOT NULL COMMENT '内容',
	`image_name` VARCHAR(100)  NOT NULL COMMENT '画像名',
	`cropped_image_name` VARCHAR(100)  NOT NULL COMMENT 'トリミング後の画像名',
	`created_at` DATETIME COMMENT '作成日',
	`updated_at` DATETIME COMMENT '更新日',
	PRIMARY KEY (`id`)
) COMMENT='こだわりポイント';

#-----------------------------------------------------------------------------
#-- l_cb_checkin_log
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `l_cb_checkin_log`;


CREATE TABLE `l_cb_checkin_log`
(
	`checkin_id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT 'チェックインID',
	`shop_id` INTEGER UNSIGNED default 0 NOT NULL COMMENT '店舗ID',
	`group_id` INTEGER UNSIGNED default 0 NOT NULL COMMENT 'グループID',
	`member_id` INTEGER UNSIGNED  NOT NULL COMMENT '会員ID',
	`checkin_point` INTEGER UNSIGNED default 0 NOT NULL COMMENT 'チェックイン時取得ポイント',
	`checkin_at` DATETIME  NOT NULL COMMENT '起動日時',
	`created_at` DATETIME COMMENT 'レコード作成年月日',
	`updated_at` DATETIME COMMENT 'レコード更新年月日',
	PRIMARY KEY (`checkin_id`)
) COMMENT='CBチェックインログ';

#-----------------------------------------------------------------------------
#-- i_cb_prob_conf
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `i_cb_prob_conf`;


CREATE TABLE `i_cb_prob_conf`
(
	`cb_prob_conf_id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT 'カードブック確率情報ID',
	`shop_point_mst_id` INTEGER  NOT NULL COMMENT '店舗ポイントマスタID',
	`rule_name` VARCHAR(100)  NOT NULL COMMENT 'ルール名称',
	`rule_status` TINYINT UNSIGNED default 0 NOT NULL COMMENT 'ルール状態',
	`rank_list` VARCHAR(20)  NOT NULL COMMENT '会員ランクリスト',
	`shop_target_type` TINYINT UNSIGNED default 0 NOT NULL COMMENT '店舗対象タイプ',
	`probability_per` TINYINT UNSIGNED  NOT NULL COMMENT '当たり確率',
	`bonus_type` TINYINT UNSIGNED default 1 NOT NULL COMMENT 'ボーナスタイプ',
	`permanent_flg` TINYINT UNSIGNED default 0 NOT NULL COMMENT '常時設定フラグ',
	`start_at` DATETIME COMMENT '開始日時',
	`end_at` DATETIME COMMENT '終了日時',
	`bonus_start_time` TIME COMMENT 'ボーナス有効開始時間',
	`bonus_end_time` TIME COMMENT 'ボーナス有効終了時間',
	`created_at` DATETIME  NOT NULL COMMENT '作成日時',
	`updated_at` DATETIME  NOT NULL COMMENT '更新日時',
	PRIMARY KEY (`cb_prob_conf_id`),
	KEY `ix_i_cb_prob_conf1`(`shop_point_mst_id`),
	KEY `ix_i_cb_prob_conf2`(`created_at`),
	KEY `ix_i_cb_prob_conf3`(`updated_at`)
) COMMENT='カードブック確率変動基本情報テーブル';

#-----------------------------------------------------------------------------
#-- i_cb_prob_value
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `i_cb_prob_value`;


CREATE TABLE `i_cb_prob_value`
(
	`cb_prob_value_id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT 'カードブック確率値ID',
	`cb_prob_conf_id` INTEGER UNSIGNED  NOT NULL COMMENT 'カードブック確率情報ID',
	`bonus_probability` TINYINT UNSIGNED  NOT NULL COMMENT 'ボーナス確率',
	`bonus_value` INTEGER UNSIGNED  NOT NULL COMMENT 'ボーナス値',
	`anime_num` TINYINT default 0 NOT NULL COMMENT 'アニメーション番号',
	`created_at` DATETIME  NOT NULL COMMENT '作成日時',
	`updated_at` DATETIME  NOT NULL COMMENT '更新日時',
	PRIMARY KEY (`cb_prob_value_id`),
	KEY `ix_i_cb_prob_value1`(`cb_prob_conf_id`),
	KEY `ix_i_cb_prob_value2`(`created_at`),
	KEY `ix_i_cb_prob_value3`(`updated_at`)
) COMMENT='カードブック確率変動確率値テーブル';

#-----------------------------------------------------------------------------
#-- r_cb_prob_relation
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `r_cb_prob_relation`;


CREATE TABLE `r_cb_prob_relation`
(
	`cb_prob_relation_id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT 'カードブック確率変動設定店舗連結ID',
	`shop_id` INTEGER  NOT NULL COMMENT '会員ID',
	`cb_prob_conf_id` INTEGER UNSIGNED  NOT NULL COMMENT 'カードブック確率情報ID',
	`deleted_flg` TINYINT(1) UNSIGNED default 0 NOT NULL COMMENT '削除フラグ',
	`created_at` DATETIME  NOT NULL COMMENT '作成日時',
	`updated_at` DATETIME  NOT NULL COMMENT '更新日時',
	PRIMARY KEY (`cb_prob_relation_id`),
	UNIQUE KEY `uix_r_cb_prob_relation1` (`shop_id`, `cb_prob_conf_id`),
	KEY `ix_r_cb_prob_relation2`(`cb_prob_conf_id`),
	KEY `ix_r_cb_prob_relation3`(`created_at`),
	KEY `ix_r_cb_prob_relation4`(`updated_at`)
) COMMENT='カードブック確率変動設定店舗連結テーブル';

#-----------------------------------------------------------------------------
#-- l_cb_prob_log
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `l_cb_prob_log`;


CREATE TABLE `l_cb_prob_log`
(
	`cb_prob_log_id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT 'カードブック確率変動履歴ID',
	`member_id` INTEGER  NOT NULL COMMENT '会員ID',
	`shop_member_card_id` INTEGER  NOT NULL COMMENT '来店ポイント会員証ID',
	`point` INTEGER COMMENT 'ポイント',
	`coupon_id` INTEGER COMMENT 'クーポンID',
	`created_at` DATETIME  NOT NULL COMMENT '作成日時',
	`updated_at` DATETIME  NOT NULL COMMENT '更新日時',
	PRIMARY KEY (`cb_prob_log_id`),
	KEY `ix_l_cb_prob_log1`(`member_id`),
	KEY `ix_l_cb_prob_log2`(`shop_member_card_id`),
	KEY `ix_l_cb_prob_log3`(`created_at`),
	KEY `ix_l_cb_prob_log4`(`updated_at`)
) COMMENT='カードブック確率変動履歴テーブル';

#-----------------------------------------------------------------------------
#-- t_prob_coupon_rev
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `t_prob_coupon_rev`;


CREATE TABLE `t_prob_coupon_rev`
(
	`prob_coupon_rev_id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT '確率変動クーポン有効期限ID',
	`coupon_id` INTEGER  NOT NULL COMMENT 'クーポンID',
	`shop_member_card_id` INTEGER  NOT NULL COMMENT '来店ポイント会員証ID',
	`coupon_count` INTEGER UNSIGNED COMMENT '取得クーポン枚数',
	`use_count` INTEGER UNSIGNED default 0 COMMENT '使用回数',
	`coupon_issue_day` DATETIME  NOT NULL COMMENT 'クーポン発行日',
	`coupon_rapse_day` DATETIME COMMENT 'クーポン失効日',
	`created_at` DATETIME  NOT NULL COMMENT '作成日時',
	`updated_at` DATETIME  NOT NULL COMMENT '更新日時',
	PRIMARY KEY (`prob_coupon_rev_id`),
	UNIQUE KEY `uix_t_prob_coupon_rev1` (`coupon_id`, `shop_member_card_id`, `coupon_count`),
	KEY `ix_t_prob_coupon_rev2`(`created_at`),
	KEY `ix_t_prob_coupon_rev3`(`updated_at`)
) COMMENT='確率変動クーポン有効期限テーブル';

#-----------------------------------------------------------------------------
#-- r_memship_member_rel
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `r_memship_member_rel`;


CREATE TABLE `r_memship_member_rel`
(
	`memship_mem_rel_id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT '会員証会員連結テーブルID',
	`membership_member_id` INTEGER COMMENT '会員証会員ID',
	`member_card_id` INTEGER COMMENT '会員証管理ID',
	`shop_member_card_id` INTEGER COMMENT 'ショップメンバーカードID',
	`created_at` DATETIME COMMENT 'レコード作成年月日',
	`updated_at` DATETIME COMMENT 'レコード更新年月日',
	PRIMARY KEY (`memship_mem_rel_id`),
	KEY `ix_memship_member_rel1`(`membership_member_id`),
	KEY `ix_memship_member_rel2`(`member_card_id`),
	KEY `ix_memship_member_rel3`(`shop_member_card_id`)
) COMMENT='会員証会員連結テーブル';

#-----------------------------------------------------------------------------
#-- i_membership_member
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `i_membership_member`;


CREATE TABLE `i_membership_member`
(
	`membership_member_id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT '会員証会員ID',
	`member_status` TINYINT UNSIGNED default 0 NOT NULL COMMENT '会員の運用状況 0：運用停止 1： 運用中',
	`kanji_family_name` VARCHAR(20) COMMENT '漢字姓',
	`kanji_name` VARCHAR(20) COMMENT '漢字名',
	`kana_family_name` VARCHAR(20) COMMENT '仮名姓',
	`kana_name` VARCHAR(20) COMMENT '仮名名',
	`pref_id` INTEGER COMMENT '都道府県ID',
	`zip_code` VARCHAR(7) COMMENT '郵便番号',
	`address1` VARCHAR(100) COMMENT '市区町村',
	`address2` VARCHAR(100) COMMENT '市区町村以下',
	`sex` TINYINT UNSIGNED COMMENT '性別 1：男性 2：女性',
	`married_status` TINYINT UNSIGNED COMMENT '既婚未婚状況',
	`birth_day` DATE COMMENT '誕生日',
	`occupation` VARCHAR(30) COMMENT '職業',
	`member_type` TINYINT UNSIGNED COMMENT '会員種別 1：一般 2：法人',
	`from_rank` TINYINT UNSIGNED COMMENT '元のランク',
	`card_type` TINYINT UNSIGNED COMMENT 'カードタイプ',
	`client_data_id` VARCHAR(20) COMMENT '顧客管理ID',
	`dm_flg` TINYINT UNSIGNED COMMENT 'DM用フラグ 0：不可 1：可',
	`client_data_point` INTEGER UNSIGNED COMMENT '顧客管理ポイント',
	`tel_number` VARCHAR(20) COMMENT '電話番号',
	`cellphone_number` VARCHAR(20) COMMENT '携帯電話番号',
	`fax_number` VARCHAR(20) COMMENT 'ファックス番号',
	`entry_date` DATETIME COMMENT '登録日時',
	`renewed_date` DATETIME COMMENT '変更日時',
	`company_name` VARCHAR(400) COMMENT '会社名',
	`company_affiliation` VARCHAR(200) COMMENT '会社の所属',
	`registered_shop_id` INTEGER COMMENT '会員登録店舗ID',
	`memo` VARCHAR(2000) COMMENT 'null',
	`created_at` DATETIME COMMENT 'レコード作成日時',
	`updated_at` DATETIME COMMENT 'レコード更新日時',
	PRIMARY KEY (`membership_member_id`),
	KEY `ix_i_membership_member1`(`registered_shop_id`)
) COMMENT='南国酒家 紙カード会員情報';

#-----------------------------------------------------------------------------
#-- i_cb_member_notice
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `i_cb_member_notice`;


CREATE TABLE `i_cb_member_notice`
(
	`cb_member_notice_id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT '自動生成プライマリキー',
	`member_id` INTEGER  NOT NULL COMMENT '会員ID',
	`notice_type` TINYINT UNSIGNED  NOT NULL COMMENT 'お知らせ種別 1：EPARKからのお知らせ, 2：グループからのお知らせ, 3：店舗からのお知らせ, 4：CardBookお知らせ',
	`group_id` INTEGER(11)  NOT NULL COMMENT 'グループID',
	`shop_id` INTEGER(11)  NOT NULL COMMENT '店舗ID',
	`status` TINYINT UNSIGNED default 0 NOT NULL COMMENT '受信許可状態 0：受信拒否(OFF), 1：受信許可(ON)',
	`created_at` DATETIME  NOT NULL COMMENT 'レコード作成日時',
	`updated_at` DATETIME  NOT NULL COMMENT 'レコード更新日時',
	`deleted_flg` TINYINT UNSIGNED default 0 NOT NULL COMMENT '削除フラグ 0:有効 1:削除',
	PRIMARY KEY (`cb_member_notice_id`),
	KEY `ix_i_cb_member_notice1`(`member_id`),
	KEY `ix_i_cb_member_notice2`(`notice_type`),
	KEY `ix_i_cb_member_notice3`(`group_id`),
	KEY `ix_i_cb_member_notice4`(`shop_id`),
	KEY `ix_i_cb_member_notice5`(`created_at`),
	KEY `ix_i_cb_member_notice6`(`updated_at`)
) COMMENT='カードブック会員のお知らせ通知設定テーブル';

#-----------------------------------------------------------------------------
#-- i_cb_member_notice_read
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `i_cb_member_notice_read`;


CREATE TABLE `i_cb_member_notice_read`
(
	`mem_notice_read_id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT '自動生成プライマリキー',
	`member_id` INTEGER  NOT NULL COMMENT '会員ID',
	`notice_type` TINYINT UNSIGNED  NOT NULL COMMENT 'お知らせ種別 1：EPARKからのお知らせ, 2：グループからのお知らせ, 3：店舗からのお知らせ, 4：CardBookお知らせ',
	`notice_id` INTEGER UNSIGNED  NOT NULL COMMENT 'お知らせID お知らせ種別が1：mobile_information.id, お知らせ種別が2：group_info.id, お知らせ種別が3：shop_info.id, お知らせ種別が4：i_cb_mobile_info.cb_mobile_info_id',
	`created_at` DATETIME  NOT NULL COMMENT 'レコード作成日時',
	`updated_at` DATETIME  NOT NULL COMMENT 'レコード更新日時',
	`delete_flg` TINYINT UNSIGNED default 0 NOT NULL COMMENT '削除フラグ 0:有効 1:削除',
	PRIMARY KEY (`mem_notice_read_id`),
	UNIQUE KEY `uix_i_cb_member_notice_read1` (`member_id`, `notice_type`, `notice_id`),
	KEY `ix_i_cb_member_notice_read2`(`member_id`),
	KEY `ix_i_cb_member_notice_read3`(`created_at`),
	KEY `ix_i_cb_member_notice_read4`(`updated_at`)
) COMMENT='カードブック会員のお知らせ既読情報テーブル';

#-----------------------------------------------------------------------------
#-- i_cb_delivery_order
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `i_cb_delivery_order`;


CREATE TABLE `i_cb_delivery_order`
(
	`delivery_order_id` INTEGER UNSIGNED  NOT NULL COMMENT '配信オーダーID',
	`group_id` INTEGER UNSIGNED  NOT NULL COMMENT 'グループID',
	`delivery_order_photo` VARCHAR(100) COMMENT '配信オーダー画像',
	`created_at` DATETIME COMMENT 'レコード作成日時',
	`updated_at` DATETIME COMMENT 'レコード更新日時',
	PRIMARY KEY (`delivery_order_id`,`group_id`),
	KEY `ix_i_cb_delivery_coupon1`(`group_id`)
) COMMENT='配信オーダーCB用情報テーブル';

#-----------------------------------------------------------------------------
#-- i_cb_segments
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `i_cb_segments`;


CREATE TABLE `i_cb_segments`
(
	`segment_id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT '店舗区分管理ID',
	`group_id` INTEGER UNSIGNED  NOT NULL COMMENT 'グループID',
	`name` VARCHAR(255) COMMENT '店舗区分名',
	`status` TINYINT UNSIGNED default 0 NOT NULL COMMENT '運用ステータス 1:運用中 0:停止中',
	`updated_at` DATETIME COMMENT '更新年月日',
	`created_at` DATETIME COMMENT '作成年月日',
	PRIMARY KEY (`segment_id`)
) COMMENT='I_店舗区分管理';

#-----------------------------------------------------------------------------
#-- r_cb_segments
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `r_cb_segments`;


CREATE TABLE `r_cb_segments`
(
	`r_cb_segment_id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT 'セグメント連結ID',
	`segment_id` INTEGER UNSIGNED  NOT NULL COMMENT '店舗区分管理ID',
	`shop_id` INTEGER UNSIGNED  NOT NULL COMMENT '店舗ID',
	`updated_at` DATETIME COMMENT '更新年月日',
	`created_at` DATETIME COMMENT '作成年月日',
	PRIMARY KEY (`r_cb_segment_id`)
) COMMENT='R_セグメント連結管理';

#-----------------------------------------------------------------------------
#-- i_memship_mem_family
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `i_memship_mem_family`;


CREATE TABLE `i_memship_mem_family`
(
	`ms_mem_family_id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT '会員証家族ID',
	`membership_member_id` INTEGER UNSIGNED  NOT NULL COMMENT '会員証会員ID',
	`f_kana_family_name` VARCHAR(20) COMMENT '仮名姓',
	`f_kana_name` VARCHAR(20) COMMENT '仮名名',
	`f_kanji_family_name` VARCHAR(20) COMMENT '漢字姓',
	`f_kanji_name` VARCHAR(20) COMMENT '漢字名',
	`birth_day` DATE COMMENT '誕生日',
	`relationship_sts` TINYINT UNSIGNED default 1 COMMENT '続柄 1：子供 2：父 3：母 4：祖父 5：祖母 6：甥 7：姪 8：叔父 9：叔母 10：曾祖父 11：曾祖母 12：孫 13：曾孫 14：その他',
	`sex_type` TINYINT UNSIGNED COMMENT '性別 1：男性 2：女性 9：その他',
	`created_at` DATETIME COMMENT 'レコード作成日時',
	`updated_at` DATETIME COMMENT 'レコード更新日時',
	PRIMARY KEY (`ms_mem_family_id`)
) COMMENT='紙カード会員家族情報';

#-----------------------------------------------------------------------------
#-- m_iqos_shop
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `m_iqos_shop`;


CREATE TABLE `m_iqos_shop`
(
	`shop_id` INTEGER UNSIGNED  NOT NULL COMMENT '店舗ID',
	`status` TINYINT UNSIGNED default 1 NOT NULL COMMENT 'ステータス',
	`created_at` DATETIME  NOT NULL COMMENT 'レコード作成日時',
	`updated_at` DATETIME  NOT NULL COMMENT 'レコード更新日時',
	PRIMARY KEY (`shop_id`)
) COMMENT='iqos店舗マスタテーブル';

#-----------------------------------------------------------------------------
#-- i_iqos_reservetime
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `i_iqos_reservetime`;


CREATE TABLE `i_iqos_reservetime`
(
	`id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT 'ID',
	`shop_id` INTEGER UNSIGNED  NOT NULL COMMENT '店舗ID',
	`mobile_reserve_on` DATETIME  NOT NULL COMMENT '携帯受付開始時間',
	`mobile_reserve_off` DATETIME  NOT NULL COMMENT '携帯受付終了時間',
	`created_at` DATETIME  NOT NULL COMMENT 'レコード作成日時',
	`updated_at` DATETIME  NOT NULL COMMENT 'レコード更新日時',
	PRIMARY KEY (`id`),
	KEY `ix_i_iqos_reservetime1`(`shop_id`, `mobile_reserve_on`, `mobile_reserve_off`)
) COMMENT='iqos携帯受付時間情報テーブル';

#-----------------------------------------------------------------------------
#-- t_urgent_mail
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `t_urgent_mail`;


CREATE TABLE `t_urgent_mail`
(
	`urgent_mail_id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT 'ID',
	`shop_id` INTEGER COMMENT '店舗ID メール配信をおこなった店舗ID',
	`group_id` INTEGER COMMENT 'グループID メール配信をおこなった店舗が所属するグループID。個店の場合空白',
	`start_at` DATETIME  NOT NULL COMMENT '開始日時 メール配信対象期間(From)',
	`end_at` DATETIME  NOT NULL COMMENT '終了日時 メール配信対象期間(To)',
	`sender` VARCHAR(30) COMMENT '差出人名 入力された差出人名',
	`subject` VARCHAR(30)  NOT NULL COMMENT '配信タイトル',
	`text` VARCHAR(1000)  NOT NULL COMMENT 'メール内容 入力されたメール内容(除フッタ)',
	`delivery_amount` INTEGER UNSIGNED  NOT NULL COMMENT '配信数 実際に配信をおこなった配信対象者数',
	`status` TINYINT UNSIGNED  NOT NULL COMMENT 'ステータス 0：下書き(仮保存) 1：送信済 2: 削除',
	`delivery_at` DATETIME COMMENT '配信日時',
	`created_at` DATETIME  NOT NULL COMMENT '作成年月日',
	`updated_at` DATETIME  NOT NULL COMMENT '更新年月日',
	PRIMARY KEY (`urgent_mail_id`),
	KEY `ix_t_urgent_mail1`(`delivery_at`)
) COMMENT='緊急メール配信';

#-----------------------------------------------------------------------------
#-- t_urgent_mail_target
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `t_urgent_mail_target`;


CREATE TABLE `t_urgent_mail_target`
(
	`urgent_mail_id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT '緊急メール配信ID',
	`shop_id` INTEGER UNSIGNED  NOT NULL COMMENT '店舗ID',
	`created_at` DATETIME  NOT NULL COMMENT '作成年月日',
	`updated_at` DATETIME  NOT NULL COMMENT '更新年月日',
	PRIMARY KEY (`urgent_mail_id`,`shop_id`)
) COMMENT='緊急メール対象店舗';

#-----------------------------------------------------------------------------
#-- t_urgent_mail_receive
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `t_urgent_mail_receive`;


CREATE TABLE `t_urgent_mail_receive`
(
	`urgent_mail_id` INTEGER UNSIGNED  NOT NULL COMMENT '緊急メール配信ID',
	`receive_id` BIGINT  NOT NULL COMMENT '予約ID',
	`member_id` INTEGER  NOT NULL COMMENT '会員ID',
	`group_name` VARCHAR(80) COMMENT 'グループ名',
	`shop_name` VARCHAR(80)  NOT NULL COMMENT '店舗名',
	`receipt_date` DATETIME  NOT NULL COMMENT '予約日時',
	`call_name` VARCHAR(40)  NOT NULL COMMENT '会員呼出名',
	`delivery_email` VARCHAR(255)  NOT NULL COMMENT '配信対象メールアドレス',
	`created_at` DATETIME  NOT NULL COMMENT '作成年月日',
	`updated_at` DATETIME  NOT NULL COMMENT '更新年月日',
	PRIMARY KEY (`urgent_mail_id`,`receive_id`)
) COMMENT='緊急メール配信対象予約';

#-----------------------------------------------------------------------------
#-- m_generic_products
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `m_generic_products`;


CREATE TABLE `m_generic_products`
(
	`m_gen_products_id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT 'ID　auto_increment',
	`common_supplier_code` TINYINT UNSIGNED  NOT NULL COMMENT '共通卸コード',
	`jan_code` VARCHAR(13)  NOT NULL COMMENT 'JANコード',
	`drug_name` VARCHAR(512)  NOT NULL COMMENT '医薬品名',
	`drug_kana` VARCHAR(512)  NOT NULL COMMENT '医薬品カナ名',
	`specification` VARCHAR(128)  NOT NULL COMMENT '規格',
	`packaging` VARCHAR(128)  NOT NULL COMMENT '包装',
	`price_rate` TINYINT UNSIGNED  NOT NULL COMMENT '対薬価率',
	`sale_price` INTEGER UNSIGNED  NOT NULL COMMENT '販売価格',
	`origin_drug_name` VARCHAR(512)  NOT NULL COMMENT '先発品名',
	`origin_drug_kana` VARCHAR(512)  NOT NULL COMMENT '先発品カナ名',
	`package_price` INTEGER UNSIGNED  NOT NULL COMMENT '包装薬価',
	`pharm_maker_name` VARCHAR(128)  NOT NULL COMMENT '製薬メーカー名',
	`pharm_maker_kana` VARCHAR(128)  NOT NULL COMMENT '製薬メーカーカナ名',
	`tab_attr` TINYINT UNSIGNED  NOT NULL COMMENT 'タブ属性',
	`well_selling` TINYINT UNSIGNED  NOT NULL COMMENT '売れ筋属性',
	`date_open` DATETIME  NOT NULL COMMENT '販売開始日時',
	`date_close` DATETIME  NOT NULL COMMENT '販売終了日時',
	`public_waiting_attr` TINYINT UNSIGNED  NOT NULL COMMENT '公開待機属性',
	`created_at` DATETIME  NOT NULL COMMENT '登録日時',
	`updated_at` DATETIME  NOT NULL COMMENT '最終更新日時',
	PRIMARY KEY (`m_gen_products_id`)
) COMMENT='卸別ジェネリック販売商品ID';

#-----------------------------------------------------------------------------
#-- l_gen_order_history
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `l_gen_order_history`;


CREATE TABLE `l_gen_order_history`
(
	`l_gen_ord_history_id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT 'ID',
	`order_at` DATETIME  NOT NULL COMMENT '注文受付日時',
	`order_no` VARCHAR(20)  NOT NULL COMMENT '注文番号',
	`order_comment` VARCHAR(512) COMMENT '注文コメント',
	`shop_id` INTEGER UNSIGNED  NOT NULL COMMENT 'EPARK店舗ID',
	`shop_name` VARCHAR(512)  NOT NULL COMMENT '薬局店舗名',
	`post` VARCHAR(7)  NOT NULL COMMENT '郵便番号',
	`address` VARCHAR(512)  NOT NULL COMMENT '住所',
	`tel` VARCHAR(20)  NOT NULL COMMENT '電話番号',
	`order_mail_address` VARCHAR(100) COMMENT '注文確認メール送信先アドレス',
	`common_supplier_code` TINYINT UNSIGNED  NOT NULL COMMENT '共通卸コード',
	`jan_code` VARCHAR(13)  NOT NULL COMMENT 'JANコード',
	`drug_name` VARCHAR(512)  NOT NULL COMMENT '医薬品名',
	`drug_kana` VARCHAR(512)  NOT NULL COMMENT '医薬品カナ名',
	`packaging` VARCHAR(128)  NOT NULL COMMENT '包装規格',
	`price_rate` TINYINT UNSIGNED  NOT NULL COMMENT '対薬価率',
	`sale_price` INTEGER UNSIGNED  NOT NULL COMMENT '販売価格',
	`origin_drug_name` VARCHAR(512)  NOT NULL COMMENT '先発品名',
	`origin_drug_kana` VARCHAR(512)  NOT NULL COMMENT '先発品カナ名',
	`package_price` INTEGER UNSIGNED  NOT NULL COMMENT '包装薬価',
	`quantity` TINYINT  NOT NULL COMMENT '注文個数',
	`amount` INTEGER  NOT NULL COMMENT '金額',
	`tax_amount` INTEGER  NOT NULL COMMENT '外税額',
	`pharm_maker_name` VARCHAR(128)  NOT NULL COMMENT '製薬メーカー名',
	`pharm_maker_kana` VARCHAR(128)  NOT NULL COMMENT '製薬メーカーカナ名',
	`date_open` DATETIME COMMENT '販売開始日時',
	`date_close` DATETIME COMMENT '販売終了日時',
	`created_at` DATETIME  NOT NULL COMMENT '登録日時',
	`updated_at` DATETIME  NOT NULL COMMENT '最終更新日時',
	PRIMARY KEY (`l_gen_ord_history_id`)
) COMMENT='販売履歴ID';

#-----------------------------------------------------------------------------
#-- s_mems_card_point
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `s_mems_card_point`;


CREATE TABLE `s_mems_card_point`
(
	`shop_member_card_id` INTEGER UNSIGNED  NOT NULL COMMENT '店舗毎のEPARK会員を一意に識別するID',
	`total_point` INTEGER UNSIGNED default 0 NOT NULL COMMENT '利用可能なポイント',
	`past_total_point` INTEGER UNSIGNED default 0 NOT NULL COMMENT '過去累計ポイント',
	`created_at` DATETIME  NOT NULL COMMENT 'レコード作成年月日',
	`updated_at` DATETIME  NOT NULL COMMENT 'レコード更新年月日',
	PRIMARY KEY (`shop_member_card_id`)
) COMMENT='S_会員証ポイント集計';

#-----------------------------------------------------------------------------
#-- m_brand_list
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `m_brand_list`;


CREATE TABLE `m_brand_list`
(
	`keyword_id` INTEGER UNSIGNED  NOT NULL COMMENT 'キーワード',
	`brand_name` VARCHAR(200) COMMENT 'ブランド名称',
	`brand_name_en` VARCHAR(200) COMMENT 'ブランド名称（英語表記）',
	`meta_title_pc_memo` VARCHAR(500) COMMENT 'Meta-title－PC用',
	`meta_title_sp_memo` VARCHAR(500) COMMENT 'Meta-title－SP用',
	`meta_desc_pc_memo` VARCHAR(500) COMMENT 'Meta-description－PC用',
	`meta_desc_sp_memo` VARCHAR(500) COMMENT 'Meta-description－SP用',
	`meta_btxt_pc_memo` VARCHAR(500) COMMENT 'Meta-brantxt－PC用',
	`meta_btxt_pc_dsply` TINYINT UNSIGNED default 1 NOT NULL COMMENT 'Meta-brandtxtの表示フラグ－PC用',
	`meta_btxt_sp_memo` VARCHAR(500) COMMENT 'Meta-brandtxt－SP用',
	`meta_btxt_sp_dsply` TINYINT UNSIGNED default 1 NOT NULL COMMENT 'Meta-brandtxtの表示フラグ－SP・FP用',
	`free_html_field_top` VARCHAR(8000)  NOT NULL COMMENT 'HTML自由記述欄（ページ上部）',
	`free_html_field_bottom` VARCHAR(8000)  NOT NULL COMMENT 'HTML自由記述欄（ページ下部）',
	`xl_category_id` INTEGER COMMENT '大々分類カテゴリID',
	`big_category_id` INTEGER COMMENT '大分類カテゴリID',
	`mid_category_id` INTEGER COMMENT '中分類カテゴリID',
	`display_status` TINYINT UNSIGNED default 0 NOT NULL COMMENT '表示ステータスフラグ',
	`list_index_flg` TINYINT UNSIGNED default 0 COMMENT 'インデックス表示フラグ',
	`list_display_status` TINYINT UNSIGNED default 0 COMMENT '一覧表示ステータスフラグ',
	`grp_hdr_dsply` TINYINT UNSIGNED default 0 NOT NULL COMMENT 'グループサイトヘッダの表示フラグ',
	`pc_area_search_type` TINYINT UNSIGNED default 0 NOT NULL COMMENT 'エリア検索の表示タイプ－PC用',
	`image1_name` VARCHAR(50) COMMENT '画像1名称',
	`image2_name` VARCHAR(50) COMMENT '画像2名称',
	`image3_name` VARCHAR(50) COMMENT '画像3名称',
	`sp_img1_name` VARCHAR(50) COMMENT 'SP用画像1名称',
	`sp_img2_name` VARCHAR(50) COMMENT 'SP用画像2名称',
	`sp_img3_name` VARCHAR(50) COMMENT 'SP用画像3名称',
	`fp_img1_name` VARCHAR(50) COMMENT 'FP用画像1名称',
	`relational_brand_id` VARCHAR(600) COMMENT '関連ブランドID',
	`sp_shop_list_dsply` TINYINT UNSIGNED default 1 NOT NULL COMMENT '店舗一覧の表示フラグ－SP用',
	`shop_dsply_order_type` TINYINT UNSIGNED default 0 NOT NULL COMMENT '店舗表示順のタイプ',
	`created_at` DATETIME  NOT NULL COMMENT '登録日',
	`updated_at` DATETIME COMMENT '更新日',
	PRIMARY KEY (`keyword_id`),
	KEY `ix_brand_list_created`(`created_at`)
) COMMENT='ブランドページに表示するブランド登録、店舗の紐付を行う';

#-----------------------------------------------------------------------------
#-- t_shop_geo_hash
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `t_shop_geo_hash`;


CREATE TABLE `t_shop_geo_hash`
(
	`shop_id` INTEGER UNSIGNED  NOT NULL COMMENT '店舗ID',
	`owner_shop_id` INTEGER UNSIGNED  NOT NULL COMMENT 'オーナー店舗ID',
	`geo_hash` VARCHAR(20) COMMENT '店舗ジオハッシュ',
	`created_at` DATETIME  NOT NULL COMMENT '登録日時',
	`updated_at` DATETIME  NOT NULL COMMENT '更新日時',
	PRIMARY KEY (`shop_id`),
	KEY `ix_t_shop_geo_hash1`(`owner_shop_id`, `geo_hash`)
) COMMENT='T_店舗ジオハッシュテーブル';

#-----------------------------------------------------------------------------
#-- m_sync_member_info
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `m_sync_member_info`;


CREATE TABLE `m_sync_member_info`
(
	`epark_member_id` INTEGER(11)  NOT NULL COMMENT 'EPARK会員ID',
	`site_client_id` VARCHAR(128) default 'epark_faspa' NOT NULL COMMENT 'サイトクライアントID',
	`kanji_last_name` VARCHAR(32) COMMENT '漢字(姓)',
	`kanji_first_name` VARCHAR(32) COMMENT '漢字(名)',
	`kana_last_name` VARCHAR(32) COMMENT 'ひらがな(姓)',
	`kana_first_name` VARCHAR(32) COMMENT 'ひらがな(名)',
	`nick_name` VARCHAR(255) COMMENT 'ニックネーム',
	`email_verify_flg` TINYINT UNSIGNED default 1 NOT NULL COMMENT 'メールアドレス認証フラグ',
	`phone_number` VARCHAR(15) COMMENT '電話番号',
	`phone_no_verify_flg` TINYINT UNSIGNED default 1 NOT NULL COMMENT '電話番号認証フラグ',
	`created_at` DATETIME  NOT NULL COMMENT '作成年月日',
	`updated_at` DATETIME  NOT NULL COMMENT '更新年月日',
	PRIMARY KEY (`epark_member_id`),
	KEY `ix_m_sync_member_info1`(`site_client_id`),
	KEY `ix_m_sync_member_info2`(`updated_at`),
	KEY `ix_m_sync_member_info3`(`phone_number`)
) COMMENT='M_SYNC_MEMBER情報テーブル';

#-----------------------------------------------------------------------------
#-- s_ds_presc_img_cnt
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `s_ds_presc_img_cnt`;


CREATE TABLE `s_ds_presc_img_cnt`
(
	`ds_presc_img_cnt_id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT 'プライマリキー',
	`receive_id` INTEGER UNSIGNED  NOT NULL COMMENT '予約id',
	`shop_id` INTEGER UNSIGNED  NOT NULL COMMENT '店舗id',
	`img_cnt` TINYINT UNSIGNED  NOT NULL COMMENT '画像枚数',
	`img_created_at` DATETIME COMMENT '処方箋画像作成日時',
	`created_at` DATETIME COMMENT '作成時間',
	`updated_at` DATETIME COMMENT '更新時間',
	PRIMARY KEY (`ds_presc_img_cnt_id`),
	UNIQUE KEY `uix_s_ds_presc_img_cnt1` (`receive_id`),
	KEY `ix_s_ds_presc_img_cnt2`(`img_created_at`),
	KEY `ix_s_ds_presc_img_cnt3`(`created_at`),
	KEY `ix_s_ds_presc_img_cnt4`(`updated_at`)
) COMMENT='処方せん枚数集計格納テーブル';

#-----------------------------------------------------------------------------
#-- m_business_brand
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `m_business_brand`;


CREATE TABLE `m_business_brand`
(
	`brand_id` INTEGER UNSIGNED  NOT NULL COMMENT '業態ID',
	`owner_shop_id` INTEGER UNSIGNED  NOT NULL COMMENT 'オーナー企業ID',
	`brand_name` VARCHAR(80)  NOT NULL COMMENT '業態名',
	`brand_name_kana` VARCHAR(200) COMMENT '業態名ひらがな',
	`brand_status` TINYINT UNSIGNED  NOT NULL COMMENT '状態',
	`created_at` DATETIME  NOT NULL COMMENT 'レコード作成日時',
	`updated_at` DATETIME  NOT NULL COMMENT 'レコード更新日時',
	PRIMARY KEY (`brand_id`)
) COMMENT='M_業態';

#-----------------------------------------------------------------------------
#-- m_y2cloud_brand
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `m_y2cloud_brand`;


CREATE TABLE `m_y2cloud_brand`
(
	`shop_id` INTEGER UNSIGNED  NOT NULL COMMENT '店舗ID',
	`brand_id` INTEGER UNSIGNED  NOT NULL COMMENT '業態ID',
	`created_at` DATETIME  NOT NULL COMMENT 'レコード作成日時',
	`updated_at` DATETIME  NOT NULL COMMENT 'レコード更新日時',
	PRIMARY KEY (`shop_id`)
) COMMENT='M_店舗ブランド';

#-----------------------------------------------------------------------------
#-- i_shop_cond_medical
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `i_shop_cond_medical`;


CREATE TABLE `i_shop_cond_medical`
(
	`shop_id` INTEGER UNSIGNED  NOT NULL COMMENT '店舗ID',
	`specimen_type` TINYINT UNSIGNED default 0 NOT NULL COMMENT '検体測定室区分',
	`dispense_post_type` TINYINT UNSIGNED default 0 NOT NULL COMMENT '調剤ポスト区分',
	`home_visit_type` TINYINT UNSIGNED default 0 NOT NULL COMMENT '在宅訪問区分',
	`nonsmoking_trt_type` TINYINT UNSIGNED default 0 NOT NULL COMMENT '禁煙治療区分',
	`health_consult_type` TINYINT UNSIGNED default 0 NOT NULL COMMENT '健康相談区分',
	`child_space_type` TINYINT UNSIGNED default 0 NOT NULL COMMENT 'キッズスペース区分',
	`drug_store_type` TINYINT UNSIGNED default 0 NOT NULL COMMENT 'ドラッグストア区分',
	PRIMARY KEY (`shop_id`)
) COMMENT='I_医療施設条件';

#-----------------------------------------------------------------------------
#-- m_ds_sch_rsv_type
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `m_ds_sch_rsv_type`;


CREATE TABLE `m_ds_sch_rsv_type`
(
	`shop_id` INTEGER UNSIGNED  NOT NULL COMMENT '店舗ID',
	`shop_rsv_dept_id` INTEGER UNSIGNED  NOT NULL COMMENT '部門ID',
	`rsv_web_flg` TINYINT UNSIGNED default 0 NOT NULL COMMENT 'WEB予約受付利用区分',
	`new_arrivals_flg` TINYINT UNSIGNED default 1 NOT NULL COMMENT '新着通知設定状態',
	`new_arrivals_time` TINYINT UNSIGNED default 0 NOT NULL COMMENT '新着通知時間',
	`rsv_limit_time_type` TINYINT UNSIGNED default 0 NOT NULL COMMENT '予約可能期間単位',
	`rsv_limit_time_start` TINYINT UNSIGNED default 1 NOT NULL COMMENT '予約可能開始期間',
	`rsv_limit_time_end` TINYINT UNSIGNED default 7 NOT NULL COMMENT '予約可能終了期間',
	`cal_type` TINYINT UNSIGNED default 1 NOT NULL COMMENT 'カレンダー区分',
	`rsv_time_interval` TINYINT UNSIGNED default 30 NOT NULL COMMENT '予約枠間隔',
	`rsv_start_time` DATETIME  NOT NULL COMMENT '予約受付基本開始時刻',
	`rsv_end_time` DATETIME  NOT NULL COMMENT '予約受付基本終了時刻',
	`display_type_flg` TINYINT UNSIGNED default 1 NOT NULL COMMENT '表示区分',
	`disp_order` TINYINT UNSIGNED default 0 NOT NULL COMMENT '表示順序',
	`ope_type_sts` TINYINT UNSIGNED default 0 NOT NULL COMMENT '運用状況区分',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`shop_id`,`shop_rsv_dept_id`)
) COMMENT='M_相談予約店舗別予約種別';

#-----------------------------------------------------------------------------
#-- t_ds_sch_rsv_cal_frm
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `t_ds_sch_rsv_cal_frm`;


CREATE TABLE `t_ds_sch_rsv_cal_frm`
(
	`shop_id` INTEGER UNSIGNED  NOT NULL COMMENT '店舗ID',
	`shop_rsv_dept_id` INTEGER UNSIGNED  NOT NULL COMMENT '部門ID',
	`rsv_frame_date_time` DATETIME  NOT NULL COMMENT '予約枠日時',
	`rsv_frame_count` INTEGER UNSIGNED default 0 NOT NULL COMMENT '予約枠数',
	`display_type_flg` TINYINT UNSIGNED default 0 NOT NULL COMMENT '表示区分',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`shop_id`,`shop_rsv_dept_id`,`rsv_frame_date_time`)
) COMMENT='T_相談予約カレンダー予約枠設定';

#-----------------------------------------------------------------------------
#-- l_ds_sch_rsv_api_err
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `l_ds_sch_rsv_api_err`;


CREATE TABLE `l_ds_sch_rsv_api_err`
(
	`rsv_api_err_id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT '予約時のエラーログID',
	`shop_id` INTEGER UNSIGNED default 0 NOT NULL COMMENT '店舗ID',
	`member_id` INTEGER UNSIGNED default 0 NOT NULL COMMENT '会員ID',
	`shop_rsv_dept_id` INTEGER UNSIGNED default 0 NOT NULL COMMENT '部門ID',
	`err_level` TINYINT UNSIGNED  NOT NULL COMMENT 'エラーレベル',
	`http_status_code` INTEGER UNSIGNED COMMENT 'HTTPステータスコード',
	`http_status_msg` VARCHAR(255)  NOT NULL COMMENT 'HTTPステータスエラー内容',
	`status_code` INTEGER UNSIGNED  NOT NULL COMMENT 'ステータスエラー番号',
	`status_title` VARCHAR(100)  NOT NULL COMMENT 'ステータスエラータイトル',
	`status_msg` VARCHAR(255)  NOT NULL COMMENT 'ステータスエラー内容',
	`err_catch_place` VARCHAR(50)  NOT NULL COMMENT 'エラー発生場所',
	`err_time` DATETIME  NOT NULL COMMENT 'エラー日時',
	`flg_send_mail` TINYINT UNSIGNED default 0 COMMENT 'エラー通知メール送信フラグ',
	`server_ip_address` VARCHAR(15)  NOT NULL COMMENT 'エラー発生サーバーIPアドレス',
	`referer` VARCHAR(255)  NOT NULL COMMENT 'リファラ',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`rsv_api_err_id`)
) COMMENT='L_相談予約APIエラーログ';

#-----------------------------------------------------------------------------
#-- m_worldpicom_info
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `m_worldpicom_info`;


CREATE TABLE `m_worldpicom_info`
(
	`shop_id` INTEGER  NOT NULL COMMENT 'EPARK店舗ID',
	`ip_address` VARCHAR(64)  NOT NULL COMMENT '連携先IPアドレス',
	`rsv_mng_port` SMALLINT  NOT NULL COMMENT '予約管理連携用ポート番号',
	`no_mng_port` SMALLINT  NOT NULL COMMENT '番号管理連携用ポート番号',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`shop_id`)
) COMMENT='ワールドピーコム連携情報マスタ';

#-----------------------------------------------------------------------------
#-- h_rootsupd_terminal
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `h_rootsupd_terminal`;


CREATE TABLE `h_rootsupd_terminal`
(
	`guid` VARCHAR(40)  NOT NULL COMMENT '端末識別ID',
	`shop_kind` TINYINT UNSIGNED default 0 NOT NULL COMMENT '店舗種別',
	`shop_id` INTEGER(11) UNSIGNED  NOT NULL COMMENT 'EPARK店舗ID',
	`display_flg` TINYINT UNSIGNED default 0 NOT NULL COMMENT '表示フラグ',
	`exec_status` TINYINT UNSIGNED default 0 NOT NULL COMMENT 'ルート証明更新ステータス',
	`exec_count` SMALLINT UNSIGNED default 1 NOT NULL COMMENT 'パッチ実行回数',
	`exec_date` DATETIME  NOT NULL COMMENT 'パッチ実行日付',
	`computer_name` VARCHAR(80) COMMENT 'コンピューター名',
	`computer_domain` VARCHAR(80) COMMENT 'コンピュータードメイン名',
	`netbios_domain` VARCHAR(80) COMMENT 'NetBIOSドメイン名',
	`user_name` VARCHAR(80) COMMENT 'ユーザー名',
	`os_name` VARCHAR(80) COMMENT 'OS名',
	`os_version` VARCHAR(40) COMMENT 'OSバージョン',
	`os_suite_mask` SMALLINT UNSIGNED COMMENT 'スイートマスク',
	`os_serial_number` VARCHAR(40) COMMENT 'シリアルナンバー',
	`os_last_boot_up_time` VARCHAR(40) COMMENT '起動時刻',
	`os_local_date_time` VARCHAR(40) COMMENT '端末時刻',
	`product_vendor` VARCHAR(40) COMMENT '製品ベンダー',
	`product_version` VARCHAR(40) COMMENT '製品バージョン',
	`product_name` VARCHAR(40) COMMENT '製品名',
	`product_id` VARCHAR(40) COMMENT '製品識別番号',
	`product_uuid` VARCHAR(40) COMMENT 'UUID',
	`ie_version` VARCHAR(40) COMMENT 'IEバージョン',
	`user_agent` VARCHAR(200) COMMENT 'ユーザーエージェント',
	`referrer` VARCHAR(2100) COMMENT 'リファラ',
	`remote_address` VARCHAR(20) COMMENT 'リモートアドレス',
	`screen_width` VARCHAR(4) COMMENT 'ウインドウ幅',
	`screen_height` VARCHAR(4) COMMENT 'ウインドウ高',
	`error_message` VARCHAR(8000) COMMENT 'エラー内容',
	`install_date` DATETIME COMMENT 'Windowsのインストール日時',
	`created_at` DATETIME  NOT NULL COMMENT 'レコード作成日時',
	`updated_at` DATETIME  NOT NULL COMMENT 'レコード更新日時',
	PRIMARY KEY (`guid`,`shop_kind`,`shop_id`),
	KEY `ix_h_rootsupd_terminal1`(`exec_date`),
	KEY `ix_h_rootsupd_terminal2`(`created_at`),
	KEY `ix_h_rootsupd_terminal3`(`updated_at`)
) COMMENT='H_ルート証明書更新実施端末';

#-----------------------------------------------------------------------------
#-- h_rootsupd_network
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `h_rootsupd_network`;


CREATE TABLE `h_rootsupd_network`
(
	`id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT '識別ID',
	`guid` VARCHAR(40)  NOT NULL COMMENT '端末識別ID',
	`shop_kind` TINYINT UNSIGNED default 0 NOT NULL COMMENT '店舗種別',
	`shop_id` INTEGER(11) UNSIGNED  NOT NULL COMMENT 'EPARK店舗ID',
	`nic_description` VARCHAR(80) COMMENT 'NICデバイス名',
	`mac_address` VARCHAR(20) COMMENT 'MACアドレス',
	`ip_address` VARCHAR(20) COMMENT 'IPアドレス',
	`ip_subnet` VARCHAR(20) COMMENT 'サブネットマスク',
	`default_gateway` VARCHAR(20) COMMENT 'デフォルトゲートウエイ',
	`dns_server` VARCHAR(40) COMMENT 'DNSサーバ',
	`created_at` DATETIME  NOT NULL COMMENT 'レコード作成日時',
	`updated_at` DATETIME  NOT NULL COMMENT 'レコード更新日時',
	PRIMARY KEY (`id`),
	KEY `ix_h_rootsupd_network1`(`guid`, `shop_kind`, `shop_id`)
) COMMENT='H_ルート証明書更新実施端末ネットワーク';

#-----------------------------------------------------------------------------
#-- h_rootsupd_printer
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `h_rootsupd_printer`;


CREATE TABLE `h_rootsupd_printer`
(
	`id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT '識別ID',
	`guid` VARCHAR(40)  NOT NULL COMMENT '端末識別ID',
	`shop_kind` TINYINT UNSIGNED default 0 NOT NULL COMMENT '店舗種別',
	`shop_id` INTEGER(11) UNSIGNED  NOT NULL COMMENT 'EPARK店舗ID',
	`printer_name` VARCHAR(80) COMMENT 'プリンター名',
	`port_name` VARCHAR(40) COMMENT 'ポート名',
	`created_at` DATETIME  NOT NULL COMMENT 'レコード作成日時',
	`updated_at` DATETIME  NOT NULL COMMENT 'レコード更新日時',
	PRIMARY KEY (`id`),
	KEY `ix_h_rootsupd_printer1`(`guid`, `shop_kind`, `shop_id`)
) COMMENT='H_ルート証明書更新実施端末プリンター';

#-----------------------------------------------------------------------------
#-- h_inventory
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `h_inventory`;


CREATE TABLE `h_inventory`
(
	`guid` VARCHAR(40)  NOT NULL COMMENT '端末識別ID',
	`inventory_key` VARCHAR(40)  NOT NULL COMMENT 'インベントリキー',
	`inventory_val` VARCHAR(200) COMMENT 'インベントリ情報',
	`created_at` DATETIME  NOT NULL COMMENT 'レコード作成日時',
	`updated_at` DATETIME  NOT NULL COMMENT 'レコード更新日時',
	PRIMARY KEY (`guid`,`inventory_key`),
	KEY `ix_h_inventory1`(`created_at`),
	KEY `ix_h_inventory2`(`updated_at`)
) COMMENT='H_端末情報';

#-----------------------------------------------------------------------------
#-- h_rootsupd_err
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `h_rootsupd_err`;


CREATE TABLE `h_rootsupd_err`
(
	`id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT '識別ID',
	`shop_kind` TINYINT UNSIGNED  NOT NULL COMMENT '店舗種別',
	`shop_id` INTEGER(11) UNSIGNED  NOT NULL COMMENT 'EPARK店舗ID',
	`exec_date` DATETIME  NOT NULL COMMENT 'パッチ実行日付',
	`error_message` VARCHAR(8000)  NOT NULL COMMENT 'エラー内容',
	`created_at` DATETIME  NOT NULL COMMENT 'レコード作成日時',
	`updated_at` DATETIME  NOT NULL COMMENT 'レコード更新日時',
	PRIMARY KEY (`id`),
	KEY `ix_h_rootsupd_err1`(`shop_kind`, `shop_id`, `exec_date`)
) COMMENT='H_GUID未発行用ルート証明書更新実施エラー情報';

#-----------------------------------------------------------------------------
#-- shop_lock
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `shop_lock`;


CREATE TABLE `shop_lock`
(
	`shop_id` INTEGER  NOT NULL COMMENT 'EPARK店舗ID',
	`created_at` DATETIME COMMENT 'レコード作成日時',
	`updated_at` DATETIME COMMENT 'レコード更新日時',
	PRIMARY KEY (`shop_id`)
) COMMENT='店舗用ロック';

#-----------------------------------------------------------------------------
#-- shop_config
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `shop_config`;


CREATE TABLE `shop_config`
(
	`shop_id` INTEGER UNSIGNED  NOT NULL COMMENT '店舗ID',
	`pc_logout_hour` TINYINT UNSIGNED default 99 NOT NULL COMMENT 'PC強制ログアウト実行時間 0時から23時で管理を想定 99：しない、2：AM2時に実行 8:AM8時に実行',
	`status` TINYINT UNSIGNED default 0 NOT NULL COMMENT 'ステータス 0:有効、1:無効',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`shop_id`)
) COMMENT='店舗設定';

#-----------------------------------------------------------------------------
#-- shop_ip_address
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `shop_ip_address`;


CREATE TABLE `shop_ip_address`
(
	`shop_id` INTEGER UNSIGNED  NOT NULL COMMENT '店舗ID',
	`ip_address` VARCHAR(15)  NOT NULL COMMENT 'IPアドレス',
	`status` TINYINT UNSIGNED default 0 NOT NULL COMMENT 'ステータス 0:有効、1:無効',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`shop_id`,`ip_address`)
) COMMENT='店舗のログインを許可するIPアドレス';

#-----------------------------------------------------------------------------
#-- group_ip_address
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `group_ip_address`;


CREATE TABLE `group_ip_address`
(
	`group_id` INTEGER UNSIGNED  NOT NULL COMMENT 'グループID',
	`ip_address` VARCHAR(15)  NOT NULL COMMENT 'IPアドレス',
	`status` TINYINT UNSIGNED default 0 NOT NULL COMMENT 'ステータス 0:有効、1:無効',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`group_id`,`ip_address`)
) COMMENT='グループのログインを許可するIPアドレス';

#-----------------------------------------------------------------------------
#-- pc_login
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `pc_login`;


CREATE TABLE `pc_login`
(
	`app_type` TINYINT UNSIGNED  NOT NULL COMMENT 'アプリケーションの種別',
	`logout_hour` TINYINT UNSIGNED  NOT NULL COMMENT '強制ログアウト時刻',
	`session_id` VARCHAR(100)  NOT NULL COMMENT 'セッションID',
	`created_at` DATETIME  NOT NULL COMMENT '作成日時',
	`updated_at` DATETIME  NOT NULL COMMENT '更新日時',
	PRIMARY KEY (`app_type`,`session_id`)
) COMMENT='PC端末のログイン時セッション情報';

#-----------------------------------------------------------------------------
#-- m_client
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `m_client`;


CREATE TABLE `m_client`
(
	`client_id` VARCHAR(40)  NOT NULL COMMENT 'クライアントID',
	`client_uri` VARCHAR(8) COMMENT 'クライアントURI',
	`op_type` TINYINT UNSIGNED default 0 NOT NULL COMMENT 'クライアント利用状況',
	`info_shortage_type` TINYINT UNSIGNED default 0 NOT NULL COMMENT '不足情報判定区分',
	`client_scope_type` TINYINT UNSIGNED default 0 NOT NULL COMMENT 'クライアント範囲タイプ',
	`site_logo` VARCHAR(100) COMMENT 'サービスロゴ',
	`site_name` VARCHAR(40) COMMENT 'サービス名',
	`site_detail` VARCHAR(100) COMMENT 'サービス詳細',
	`ret_uri_login` VARCHAR(100) COMMENT '戻り先ログイン',
	`ret_uri_top` VARCHAR(100) COMMENT '戻り先サービストップ',
	`ret_uri_medit` VARCHAR(100) COMMENT '戻り先会員情報更新',
	`ret_uri_mwdrw` VARCHAR(100) COMMENT '戻り先退会',
	`email_lack_col_grp` INTEGER UNSIGNED COMMENT 'メール不足項目グループ',
	`phone_lack_col_grp` INTEGER UNSIGNED COMMENT '携帯電話不足項目グループ',
	`mail_txt_grp` INTEGER UNSIGNED COMMENT 'メール項目グループ',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`client_id`),
	UNIQUE KEY `uix_m_client_1` (`client_uri`),
	KEY `ix_m_client_2`(`created_at`),
	KEY `ix_m_client_3`(`updated_at`)
) COMMENT='M_クライアント';

#-----------------------------------------------------------------------------
#-- m_client_item_col
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `m_client_item_col`;


CREATE TABLE `m_client_item_col`
(
	`item_id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT '項目ID',
	`group_id` INTEGER UNSIGNED COMMENT 'グループID',
	`item_cat_type` TINYINT UNSIGNED default 0 NOT NULL COMMENT '項目カテゴリタイプ',
	`item_name` VARCHAR(32) COMMENT '項目名',
	`description_txt` VARCHAR(1024) COMMENT '項目説明テキスト',
	`item_input_type` TINYINT UNSIGNED default 9 NOT NULL COMMENT '項目入力タイプ',
	`item_op_type` TINYINT UNSIGNED default 0 NOT NULL COMMENT '項目ご利用状態タイプ',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`item_id`),
	KEY `ix_m_client_item_col_1`(`group_id`),
	KEY `ix_m_client_item_col_2`(`created_at`),
	KEY `ix_m_client_item_col_3`(`updated_at`)
) COMMENT='M_クライアント別項目';

#-----------------------------------------------------------------------------
#-- m_ticket_ads
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `m_ticket_ads`;


CREATE TABLE `m_ticket_ads`
(
	`ticket_ads_id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT '整理券広告ID',
	`ticket_ads_name` VARCHAR(50)  NOT NULL COMMENT '整理券広告名',
	`epark_grp_site_id` INTEGER UNSIGNED  NOT NULL COMMENT 'EPARKグループサイトID',
	`ads_client_name` VARCHAR(50)  NOT NULL COMMENT '広告依頼者名',
	`ads_image_name` VARCHAR(50)  NOT NULL COMMENT '広告画像名',
	`ads_publish_flg` TINYINT UNSIGNED default 0 NOT NULL COMMENT '広告掲載フラグ 0:掲載停止中 1:掲載中',
	`ads_print_sts` TINYINT UNSIGNED default 1 NOT NULL COMMENT '整理券印刷形式 0:切れ目なし 1:切れ目あり',
	`deleted_flg` TINYINT UNSIGNED default 0 NOT NULL COMMENT '削除フラグ 0:有効データ 1:削除済み',
	`publish_start_at` DATETIME  NOT NULL COMMENT '掲載開始日時',
	`publish_end_at` DATETIME  NOT NULL COMMENT '掲載終了日時',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`ticket_ads_id`),
	KEY `ix_m_num_ticket_ads1`(`deleted_flg`, `ads_publish_flg`, `publish_start_at`, `publish_end_at`),
	KEY `ix_m_num_ticket_ads2`(`created_at`),
	KEY `ix_m_num_ticket_ads3`(`updated_at`)
) COMMENT='M_整理券広告マスタ';

#-----------------------------------------------------------------------------
#-- i_ticket_ads_shop
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `i_ticket_ads_shop`;


CREATE TABLE `i_ticket_ads_shop`
(
	`shop_id` INTEGER UNSIGNED  NOT NULL COMMENT '店舗ID',
	`ticket_ads_id` INTEGER UNSIGNED  NOT NULL COMMENT '整理券広告ID',
	`print_ads_flg` TINYINT UNSIGNED default 0 NOT NULL COMMENT '広告発券フラグ 0:発券不可 1:発券可能',
	`deleted_flg` TINYINT UNSIGNED default 0 NOT NULL COMMENT '削除フラグ 0:有効データ 1:削除済み',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`shop_id`,`ticket_ads_id`),
	KEY `i_ticket_ads_shop1`(`shop_id`, `print_ads_flg`),
	KEY `i_ticket_ads_shop2`(`created_at`),
	KEY `i_ticket_ads_shop3`(`updated_at`)
) COMMENT='I_整理券広告店舗情報';

#-----------------------------------------------------------------------------
#-- m_epark_grp_site
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `m_epark_grp_site`;


CREATE TABLE `m_epark_grp_site`
(
	`epark_grp_site_id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT 'EPARKグループサイトID',
	`epark_grp_site_name` VARCHAR(100)  NOT NULL COMMENT 'EPARKグループサイト名',
	`deleted_flg` TINYINT UNSIGNED default 0 NOT NULL COMMENT '削除フラグ 0:有効データ 1:削除済み',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`epark_grp_site_id`),
	KEY `m_epark_grp_site1`(`created_at`),
	KEY `m_epark_grp_site2`(`updated_at`)
) COMMENT='M_EPARKグループサイト情報';

#-----------------------------------------------------------------------------
#-- l_ds_fax_transmission
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `l_ds_fax_transmission`;


CREATE TABLE `l_ds_fax_transmission`
(
	`id` BIGINT UNSIGNED  NOT NULL COMMENT 'ID',
	`receive_id` BIGINT UNSIGNED  NOT NULL COMMENT '予約ID',
	`shop_id` INTEGER COMMENT '店舗ID',
	`shop_name` VARCHAR(80) COMMENT '店舗名',
	`owner_shop_id` INTEGER COMMENT 'オーナー店舗ID',
	`test_shop_flg` TINYINT COMMENT 'テスト店舗フラグ',
	`fax_order_date` DATETIME COMMENT 'FAX送信依頼日時',
	`fax_order_cnt` TINYINT UNSIGNED COMMENT 'FAX送信依頼枚数',
	`fax_number` VARCHAR(20) COMMENT 'FAX番号',
	`fax_setting_type` TINYINT UNSIGNED COMMENT 'FAX送信設定',
	`biz_fax_response_type` TINYINT UNSIGNED COMMENT 'bizFAXからの応答',
	`biz_fax_message` VARCHAR(255) COMMENT 'bizFAXからのメッセージ',
	`created_at` DATETIME  NOT NULL COMMENT '作成日時',
	`updated_at` DATETIME  NOT NULL COMMENT '更新日時',
	PRIMARY KEY (`id`)
) COMMENT='新着FAX通知の送信履歴';

#-----------------------------------------------------------------------------
#-- i_cb_app_version
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `i_cb_app_version`;


CREATE TABLE `i_cb_app_version`
(
	`cb_app_version_id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT '自動生成プライマリキー',
	`android_latest_ver` VARCHAR(20)  NOT NULL COMMENT 'Android任意アップデートバージョン（最新のバージョン）',
	`android_required_ver` VARCHAR(20)  NOT NULL COMMENT 'Android必須アップデートバージョン',
	`ios_latest_ver` VARCHAR(20)  NOT NULL COMMENT 'iOS任意アップデートバージョン（最新のバージョン）',
	`ios_required_ver` VARCHAR(20)  NOT NULL COMMENT 'iOS必須アップデートバージョン',
	`created_at` DATETIME  NOT NULL COMMENT '作成日時',
	`updated_at` DATETIME  NOT NULL COMMENT '更新日時',
	PRIMARY KEY (`cb_app_version_id`),
	KEY `ix_i_cb_app_version1`(`android_latest_ver`),
	KEY `ix_i_cb_app_version2`(`android_required_ver`),
	KEY `ix_i_cb_app_version3`(`ios_latest_ver`),
	KEY `ix_i_cb_app_version4`(`ios_required_ver`),
	KEY `ix_i_cb_app_version5`(`created_at`),
	KEY `ix_i_cb_app_version6`(`updated_at`)
) COMMENT='カードブックアプリバージョン情報テーブル';

#-----------------------------------------------------------------------------
#-- ds_shop_survey
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `ds_shop_survey`;


CREATE TABLE `ds_shop_survey`
(
	`ds_shop_survey_id` INTEGER UNSIGNED  NOT NULL COMMENT 'アンケート対象店舗リストID',
	`shop_id` INTEGER UNSIGNED  NOT NULL COMMENT '店舗ID',
	`survey_type` TINYINT UNSIGNED default 0 NOT NULL COMMENT 'アンケート種別 0:大手 1:個店',
	`notice_time_1` DATETIME COMMENT '店舗へのアンケート送信予定時間1',
	`notice_time_2` DATETIME COMMENT '店舗へのアンケート送信予定時間2',
	`notice_time_3` DATETIME COMMENT '店舗へのアンケート送信予定時間3',
	`answer_status` TINYINT UNSIGNED  NOT NULL COMMENT 'アンケートステータス 0:未回答 1:回答済み',
	`answer_detail` VARCHAR(8192) COMMENT 'アンケート回答内容',
	`created_at` DATETIME  NOT NULL COMMENT '作成日時',
	`updated_at` DATETIME  NOT NULL COMMENT '更新日時',
	PRIMARY KEY (`ds_shop_survey_id`),
	KEY `ix_ds_shop_survey1`(`shop_id`, `answer_status`),
	KEY `ix_ds_shop_survey2`(`created_at`),
	KEY `ix_ds_shop_survey3`(`updated_at`)
) COMMENT='L_薬局店舗対象アンケートテーブル';

#-----------------------------------------------------------------------------
#-- i_tg_shop
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `i_tg_shop`;


CREATE TABLE `i_tg_shop`
(
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID',
	`tg_conf_id` INTEGER UNSIGNED COMMENT '音声ガイダンス設定ID',
	`shop_read_name` VARCHAR(200) COMMENT '読み上げ店舗名称',
	`add_msg_flg` TINYINT UNSIGNED default 0 NOT NULL COMMENT '追加文言フラグ',
	`created_at` DATETIME  NOT NULL COMMENT '作成年月日',
	`updated_at` DATETIME  NOT NULL COMMENT '更新年月日',
	PRIMARY KEY (`shop_id`),
	KEY `ix_i_tg_conf1`(`tg_conf_id`),
	KEY `ix_i_tg_conf2`(`updated_at`),
	KEY `ix_i_tg_conf3`(`created_at`)
) COMMENT='I_音声ガイダンス利用店舗';

#-----------------------------------------------------------------------------
#-- m_tg_conf
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `m_tg_conf`;


CREATE TABLE `m_tg_conf`
(
	`tg_conf_id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT '音声ガイダンス設定ID',
	`tg_conf_name` VARCHAR(40)  NOT NULL COMMENT '音声ガイダンス設定名称',
	`add_msg_set_name` VARCHAR(40)  NOT NULL COMMENT '追加文言設定名称',
	`add_msg` VARCHAR(255)  NOT NULL COMMENT '追加文言',
	`ope_sts` TINYINT UNSIGNED default 0 NOT NULL COMMENT '運用ステータス',
	`deleted_flg` TINYINT UNSIGNED default 0 NOT NULL COMMENT '削除フラグ',
	`created_at` DATETIME  NOT NULL COMMENT '作成年月日',
	`updated_at` DATETIME  NOT NULL COMMENT '更新年月日',
	PRIMARY KEY (`tg_conf_id`),
	KEY `ix_m_tg_conf1`(`ope_sts`, `deleted_flg`),
	KEY `ix_m_tg_conf2`(`deleted_flg`),
	KEY `ix_m_tg_conf3`(`updated_at`),
	KEY `ix_m_tg_conf4`(`created_at`)
) COMMENT='M_ガイダンス設定';

#-----------------------------------------------------------------------------
#-- i_tg_conf_opt
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `i_tg_conf_opt`;


CREATE TABLE `i_tg_conf_opt`
(
	`tg_conf_id` INTEGER UNSIGNED  NOT NULL COMMENT '音声ガイダンス設定ID',
	`key_num` TINYINT UNSIGNED  NOT NULL COMMENT 'キー番号',
	`opt_name` VARCHAR(40)  NOT NULL COMMENT '項目名称',
	`process_name` VARCHAR(40) default '' NOT NULL COMMENT '経路名称',
	`prog_type` TINYINT UNSIGNED  NOT NULL COMMENT '進行タイプ',
	`guide_msg` VARCHAR(255) COMMENT '案内文言',
	`prog_xfer_flg` TINYINT UNSIGNED COMMENT '転送進行フラグ',
	`prog_name` VARCHAR(255) COMMENT '進行名称',
	`ope_sts` TINYINT UNSIGNED default 0 NOT NULL COMMENT '運用ステータス',
	`deleted_flg` TINYINT UNSIGNED default 0 NOT NULL COMMENT '削除フラグ',
	`created_at` DATETIME  NOT NULL COMMENT '作成年月日',
	`updated_at` DATETIME  NOT NULL COMMENT '更新年月日',
	PRIMARY KEY (`tg_conf_id`,`key_num`),
	KEY `ix_i_tg_conf_opt1`(`updated_at`),
	KEY `ix_i_tg_conf_opt2`(`created_at`)
) COMMENT='I_音声ガイダンス設定オプション';

#-----------------------------------------------------------------------------
#-- i_tg_xfer_target
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `i_tg_xfer_target`;


CREATE TABLE `i_tg_xfer_target`
(
	`tg_xfer_target_id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT '転送設定ID',
	`shop_id` INTEGER UNSIGNED  NOT NULL COMMENT '店舗ID',
	`target_tel_no` VARCHAR(20)  NOT NULL COMMENT '対象電話番号',
	`process_name` VARCHAR(40)  NOT NULL COMMENT '経路名称',
	`ope_sts` TINYINT UNSIGNED default 0 NOT NULL COMMENT '運用ステータス',
	`deleted_flg` TINYINT UNSIGNED default 0 NOT NULL COMMENT '削除フラグ',
	`created_at` DATETIME  NOT NULL COMMENT '作成年月日',
	`updated_at` DATETIME  NOT NULL COMMENT '更新年月日',
	PRIMARY KEY (`tg_xfer_target_id`),
	KEY `ix_i_tg_xfer_target1`(`shop_id`, `ope_sts`, `deleted_flg`),
	KEY `ix_i_tg_xfer_target2`(`shop_id`, `deleted_flg`),
	KEY `ix_i_tg_xfer_target3`(`updated_at`),
	KEY `ix_i_tg_xfer_target4`(`created_at`)
) COMMENT='I_音声ガイダンス転送対象';

#-----------------------------------------------------------------------------
#-- i_tg_xfer_conf
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `i_tg_xfer_conf`;


CREATE TABLE `i_tg_xfer_conf`
(
	`tg_xfer_conf_id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT '転送設定ID',
	`tg_conf_id` INTEGER UNSIGNED  NOT NULL COMMENT '音声ガイダンスID',
	`xfer_tel_no` VARCHAR(20)  NOT NULL COMMENT '転送先電話番号',
	`xfer_start_time` TIME  NOT NULL COMMENT '転送開始時間',
	`xfer_end_time` TIME  NOT NULL COMMENT '転送終了時間',
	`ope_sts` TINYINT UNSIGNED default 0 NOT NULL COMMENT '運用ステータス',
	`deleted_at` TINYINT UNSIGNED default 0 NOT NULL COMMENT '削除フラグ',
	`created_at` DATETIME  NOT NULL COMMENT '作成年月日',
	`updated_at` DATETIME  NOT NULL COMMENT '更新年月日',
	PRIMARY KEY (`tg_xfer_conf_id`),
	KEY `ix_i_tg_xfer_conf1`(`tg_conf_id`, `ope_sts`, `deleted_at`),
	KEY `ix_i_tg_xfer_conf2`(`tg_conf_id`, `deleted_at`),
	KEY `ix_i_tg_xfer_conf3`(`updated_at`),
	KEY `ix_i_tg_xfer_conf4`(`created_at`)
) COMMENT='I_音声ガイダンス転送設定';

#-----------------------------------------------------------------------------
#-- l_comingshop_members
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `l_comingshop_members`;


CREATE TABLE `l_comingshop_members`
(
	`id` INTEGER UNSIGNED  NOT NULL COMMENT 'id',
	`owner_shop_id` INTEGER  NOT NULL COMMENT 'オーナーID',
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID',
	`member_id` INTEGER  NOT NULL COMMENT '会員ＩＤ',
	`comingshop_at` DATETIME  NOT NULL COMMENT '来店日時',
	`condition_name` VARCHAR(100) COMMENT '部門選択条件名',
	`condition_value` VARCHAR(100) COMMENT '部門選択条件内容',
	`department_value` VARCHAR(100) COMMENT '部門名',
	`category_name_1` VARCHAR(100) COMMENT '条件内容1',
	`category_value_1` VARCHAR(100) COMMENT '条件1内容',
	`category_name_2` VARCHAR(100) COMMENT '条件名2',
	`category_value_2` VARCHAR(100) COMMENT '条件内容2',
	`category_name_3` VARCHAR(100) COMMENT '条件名3',
	`category_value_3` VARCHAR(100) COMMENT '条件内容3',
	`category_name_4` VARCHAR(100) COMMENT '条件名4',
	`category_value_4` VARCHAR(100) COMMENT '条件内容4',
	`category_name_5` VARCHAR(100) COMMENT '条件名5',
	`category_value_5` VARCHAR(100) COMMENT '条件内容5',
	`created_at` DATETIME  NOT NULL COMMENT 'レコード作成日時',
	`updated_at` DATETIME  NOT NULL COMMENT 'レコード更新日時',
	PRIMARY KEY (`id`),
	KEY `ix_l_comingshop_members1`(`shop_id`, `member_id`, `comingshop_at`),
	KEY `ix_l_comingshop_members2`(`owner_shop_id`),
	KEY `ix_l_comingshop_members3`(`member_id`),
	KEY `ix_l_comingshop_members4`(`comingshop_at`)
) COMMENT='L_会員来店履歴';

#-----------------------------------------------------------------------------
#-- i_cb_mobile_info
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `i_cb_mobile_info`;


CREATE TABLE `i_cb_mobile_info`
(
	`cb_mobile_info_id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT 'CBモバイルお知らせID',
	`entry_name` VARCHAR(30) default 'CardBook運営事務局' NOT NULL COMMENT '設定者',
	`delete_flg` TINYINT UNSIGNED  NOT NULL COMMENT '掲載状況 0:運用中 1:停止中',
	`info_title` VARCHAR(20)  NOT NULL COMMENT 'タイトル',
	`target_type` TINYINT UNSIGNED default 0 NOT NULL COMMENT 'お知らせ対象 0：すべて 1：ユーザー 2：店舗管理画面 3：グループ管理画面',
	`info_body` VARCHAR(1000)  NOT NULL COMMENT '本文',
	`info_img` VARCHAR(255) COMMENT 'お知らせ画像',
	`info_url` VARCHAR(1000) COMMENT 'お知らせURL',
	`display_start` DATETIME  NOT NULL COMMENT '表示開始日',
	`display_end` DATETIME  NOT NULL COMMENT '表示終了日',
	`created_at` DATETIME  NOT NULL COMMENT '作成日時',
	`updated_at` DATETIME  NOT NULL COMMENT '更新日時',
	PRIMARY KEY (`cb_mobile_info_id`),
	KEY `ix_i_cb_mobile_info1`(`display_start`, `delete_flg`),
	KEY `ix_i_cb_mobile_info2`(`created_at`),
	KEY `ix_i_cb_mobile_info3`(`updated_at`)
) COMMENT='I_CBモバイルお知らせ';

#-----------------------------------------------------------------------------
#-- m_ag_shop
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `m_ag_shop`;


CREATE TABLE `m_ag_shop`
(
	`ag_shop_id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT '自動配席店舗ID',
	`shop_id` INTEGER UNSIGNED  NOT NULL COMMENT '店舗ID',
	`kura_shop_id` INTEGER UNSIGNED  NOT NULL COMMENT 'くら寿司店舗ID',
	`ag_auth_flg` TINYINT UNSIGNED default 0 NOT NULL COMMENT '自動配席利用権限 0:権限なし 1:権限あり',
	`ag_use_flg` TINYINT UNSIGNED default 0 NOT NULL COMMENT '自動配席運用フラグ 0:運用停止 1:運用中',
	`seat_po_use_type` TINYINT UNSIGNED default 1 NOT NULL COMMENT '座席優先順位パターン利用区分 1:通常時 2:引き際時',
	`guide_sys_type` TINYINT UNSIGNED default 1 NOT NULL COMMENT '案内システム区分 1:自動案内 2:順番待ち',
	`ag_call_flg` TINYINT UNSIGNED default 0 NOT NULL COMMENT '自動呼出運用フラグ 0:運用停止 1:運用中',
	`ag_certify_flg` TINYINT UNSIGNED default 0 NOT NULL COMMENT '本人認証運用フラグ 0:運用停止 1:運用中',
	`vg_guidemoni_flg` TINYINT UNSIGNED default 0 NOT NULL COMMENT '音声ガイドガイドモニター運用フラグ 0:運用停止 1:運用中',
	`vg_navimoni_flg` TINYINT UNSIGNED default 0 NOT NULL COMMENT '音声ガイド誘導モニター運用フラグ 0:運用停止 1:運用中',
	`vg_range_sensor_flg` TINYINT UNSIGNED default 0 NOT NULL COMMENT '音声ガイド測距センサー運用フラグ 0:運用停止 1:運用中',
	`mult_accept_terminals_flg` TINYINT UNSIGNED default 0 NOT NULL COMMENT '受付機複数台運用フラグ 0:運用停止 1:運用中',
	`ag_call_itvl_sec` INTEGER UNSIGNED default 60 NOT NULL COMMENT '自動呼出間隔秒数',
	`ag_cancel_itvl_sec` INTEGER UNSIGNED default 1800 NOT NULL COMMENT '自動無断キャンセル猶予秒数',
	`ag_call_extend_sec` INTEGER UNSIGNED default 600 NOT NULL COMMENT '自動案内延長秒数',
	`cooperation_server_type` TINYINT UNSIGNED default 1 NOT NULL COMMENT '連携サーバータイプ 1:直接API(タッチパネル管理パソコン) 2:中間サーバー',
	`mid_server_ip` VARCHAR(255) default '0' COMMENT '中間サーバーIP',
	`ag_delay_message` VARCHAR(100) COMMENT '遅延メッセージ',
	`so_qr_flg` TINYINT UNSIGNED default 1 NOT NULL COMMENT 'スマホオーダー用QRコード発券フラグ 0:運用停止 1:運用中',
	`payment_barcode_flg` TINYINT UNSIGNED default 0 NOT NULL COMMENT '決済用バーコード発券フラグ 0:運用停止 1:運用中',
	`ag_logic_type` TINYINT UNSIGNED default 1 NOT NULL COMMENT '自動案内ロジックタイプ 1:6名定員ロジック 2:4名定員ロジック',
	`ag_push_notice_flg` TINYINT UNSIGNED default 1 NOT NULL COMMENT '自動案内PUSH通知運用フラグ 0:運用停止 1:運用中',
	`ag_push_notice_num` INTEGER UNSIGNED default 2 NOT NULL COMMENT '自動案内PUSH通知実行組数',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`ag_shop_id`),
	KEY `uix_m_ag_shop1`(`shop_id`),
	KEY `ix_m_ag_shop2`(`created_at`),
	KEY `ix_m_ag_shop3`(`updated_at`)
) COMMENT='M_自動配席店舗別設定マスタ';

#-----------------------------------------------------------------------------
#-- i_ag_dept
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `i_ag_dept`;


CREATE TABLE `i_ag_dept`
(
	`ag_dept_id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT '自動配席部門ID',
	`ag_shop_id` INTEGER UNSIGNED  NOT NULL COMMENT '自動配席店舗ID',
	`dept_id` INTEGER UNSIGNED  NOT NULL COMMENT '部門ID',
	`dept_seat_type` TINYINT UNSIGNED default 0 NOT NULL COMMENT '部門別座席タイプ 1:テーブル(BOX席) 2:カウンター',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`ag_dept_id`),
	KEY `ix_i_ag_dept1`(`ag_shop_id`),
	KEY `uix_i_ag_dept2`(`dept_id`),
	KEY `ix_i_ag_dept3`(`created_at`),
	KEY `ix_i_ag_dept4`(`updated_at`)
) COMMENT='I_自動配席店舗別部門情報';

#-----------------------------------------------------------------------------
#-- i_ag_layout
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `i_ag_layout`;


CREATE TABLE `i_ag_layout`
(
	`ag_layout_id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT '自動配席レイアウトID',
	`ag_shop_id` INTEGER UNSIGNED  NOT NULL COMMENT '自動配席店舗ID',
	`seat_type` TINYINT UNSIGNED default 0 NOT NULL COMMENT '座席種別 0:座席 10:レーン 20:上向きクイックターン 21:右向きクイックターン 22:下向きクイックターン 23:左向きクイックターン',
	`seat_row` INTEGER UNSIGNED  NOT NULL COMMENT '座席行位置',
	`seat_line` INTEGER UNSIGNED  NOT NULL COMMENT '座席列位置',
	`seat_width` INTEGER UNSIGNED  NOT NULL COMMENT '座席横サイズ',
	`seat_height` INTEGER UNSIGNED  NOT NULL COMMENT '座席縦サイズ',
	`quick_turn_flg` TINYINT UNSIGNED default 0 COMMENT 'クイックターンフラグ 0:OFF 1:ON',
	`switch_po_type_sts` TINYINT UNSIGNED default 0 COMMENT '優先順位切り替えステータス 0:normal 1:special',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`ag_layout_id`),
	KEY `ix_i_ag_layout1`(`ag_shop_id`, `seat_type`),
	KEY `ix_i_ag_layout2`(`created_at`),
	KEY `ix_i_ag_layout3`(`updated_at`)
) COMMENT='I_自動配席レイアウト情報';

#-----------------------------------------------------------------------------
#-- i_ag_seat
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `i_ag_seat`;


CREATE TABLE `i_ag_seat`
(
	`ag_seat_id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT '自動配席座席ID',
	`ag_layout_id` INTEGER UNSIGNED  NOT NULL COMMENT '自動配席レイアウトID',
	`shop_id` INTEGER UNSIGNED  NOT NULL COMMENT '店舗ID',
	`ag_dept_id` INTEGER UNSIGNED  NOT NULL COMMENT '自動配席部門ID',
	`seat_no` VARCHAR(255)  NOT NULL COMMENT '座席番号',
	`seat_sts` TINYINT UNSIGNED default 0 NOT NULL COMMENT '座席ステータス 0:空 1:食 2:掃 3:ER 4:呼 5:会',
	`no_run_flg` TINYINT UNSIGNED default 0 NOT NULL COMMENT '稼動停止フラグ 0:稼動中 1:稼動停止',
	`forced_stop_flg` TINYINT UNSIGNED default 0 NOT NULL COMMENT '強制稼動停止フラグ 0:稼動中 1:稼動停止',
	`ag_hold_sts` TINYINT UNSIGNED default 0 NOT NULL COMMENT '自動案内ホールドステータス 0:通常 1:スタッフ端末ホールド中 2:案内端末ホールド中 3:受付端末ホールド中 4:受付端末複数台ホールド中',
	`capa_ppl` TINYINT UNSIGNED  NOT NULL COMMENT '定員人数',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`ag_seat_id`),
	KEY `uix_i_ag_seat1`(`shop_id`, `seat_no`),
	KEY `ix_i_ag_seat2`(`ag_dept_id`, `no_run_flg`, `seat_sts`),
	KEY `ix_i_ag_seat3`(`created_at`),
	KEY `ix_i_ag_seat4`(`updated_at`)
) COMMENT='I_自動配席座席情報';

#-----------------------------------------------------------------------------
#-- i_ag_po_type
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `i_ag_po_type`;


CREATE TABLE `i_ag_po_type`
(
	`ag_seat_po_id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT '自動配席座席優先順位ID',
	`ag_dept_id` INTEGER UNSIGNED  NOT NULL COMMENT '自動配席部門ID',
	`ag_seat_id` INTEGER UNSIGNED  NOT NULL COMMENT '自動配席座席ID',
	`seat_po_type` TINYINT UNSIGNED default 0 NOT NULL COMMENT '座席優先順位パターン 1:通常時 2:引き際時',
	`seat_po_no` INTEGER UNSIGNED default 0 COMMENT '座席優先順位',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`ag_seat_po_id`),
	KEY `ix_i_ag_po_type1`(`ag_seat_id`, `seat_po_type`),
	KEY `ix_i_ag_po_type2`(`ag_dept_id`, `seat_po_type`),
	KEY `ix_i_ag_po_type3`(`created_at`),
	KEY `ix_i_ag_po_type4`(`updated_at`)
) COMMENT='I_自動配席座席優先順位情報';

#-----------------------------------------------------------------------------
#-- i_ag_quick_turn
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `i_ag_quick_turn`;


CREATE TABLE `i_ag_quick_turn`
(
	`ag_qt_id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT '自動配席クイックターンID',
	`ag_layout_id` INTEGER UNSIGNED  NOT NULL COMMENT '自動配席レイアウトID',
	`ag_seat_id` INTEGER UNSIGNED  NOT NULL COMMENT '自動配席座席ID',
	`deleted_flg` TINYINT UNSIGNED default 0 NOT NULL COMMENT '削除フラグ 0:有効データ 1:削除済',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`ag_qt_id`),
	KEY `ix_i_ag_quick_turn1`(`ag_layout_id`, `deleted_flg`),
	KEY `ix_i_ag_quick_turn2`(`created_at`),
	KEY `ix_i_ag_quick_turn3`(`updated_at`)
) COMMENT='I_自動配席クイックターン情報';

#-----------------------------------------------------------------------------
#-- i_ag_zone_group
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `i_ag_zone_group`;


CREATE TABLE `i_ag_zone_group`
(
	`ag_zone_id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT '自動配席ゾーンID',
	`ag_shop_id` INTEGER UNSIGNED  NOT NULL COMMENT '自動配席店舗ID',
	`zone_no` VARCHAR(255) default '0' NOT NULL COMMENT 'ゾーン番号',
	`zone_type` TINYINT UNSIGNED default 0 NOT NULL COMMENT 'ゾーン種別 1:テーブル(BOX席) 2:カウンター',
	`ag_seat_id` INTEGER UNSIGNED  NOT NULL COMMENT '自動配席座席ID',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`ag_zone_id`),
	KEY `ix_i_ag_quick_turn1`(`ag_shop_id`, `zone_no`),
	KEY `ix_i_ag_quick_turn2`(`created_at`),
	KEY `ix_i_ag_quick_turn3`(`updated_at`)
) COMMENT='I_自動配席ゾーン情報';

#-----------------------------------------------------------------------------
#-- t_ag_recv
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `t_ag_recv`;


CREATE TABLE `t_ag_recv`
(
	`ag_recv_id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT '自動配席受付ID',
	`shop_id` INTEGER UNSIGNED  NOT NULL COMMENT '店舗ID',
	`dept_id` INTEGER UNSIGNED  NOT NULL COMMENT '部門ID',
	`recv_ppl` TINYINT UNSIGNED  NOT NULL COMMENT '受付合計人数',
	`recv_children` TINYINT UNSIGNED  NOT NULL COMMENT '受付子供人数',
	`seat_po_type` TINYINT UNSIGNED default 0 NOT NULL COMMENT '座席優先順位パターン 1:通常時 2:引き際時',
	`guided_type` TINYINT UNSIGNED default 0 NOT NULL COMMENT '案内タイプ 1:受付端末 2:スタッフ端末 3:案内端末 4:くら寿司配席サーバー',
	`expect_ag_seat_num` TINYINT UNSIGNED default 0 NOT NULL COMMENT '配席予定座席数',
	`receive_id` INTEGER UNSIGNED COMMENT '予約受付ID',
	`guide_tar_date` DATETIME COMMENT '案内予定日時',
	`re_guide_tar_date` DATETIME COMMENT '不在戻し再案内目安日時',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`ag_recv_id`),
	KEY `ix_t_ag_recv1`(`receive_id`, `re_guide_tar_date`),
	KEY `ix_t_ag_recv2`(`shop_id`, `created_at`),
	KEY `ix_t_ag_recv3`(`created_at`),
	KEY `ix_t_ag_recv4`(`updated_at`)
) COMMENT='T_自動配席受付データ';

#-----------------------------------------------------------------------------
#-- t_ag_seat_recv
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `t_ag_seat_recv`;


CREATE TABLE `t_ag_seat_recv`
(
	`seat_recv_id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT '座席別受付ID',
	`ag_recv_id` INTEGER UNSIGNED  NOT NULL COMMENT '自動配席受付ID',
	`ag_seat_id` INTEGER UNSIGNED  NOT NULL COMMENT '自動配席座席ID',
	`guided_adults` TINYINT UNSIGNED  NOT NULL COMMENT '配席大人数',
	`guided_children` TINYINT UNSIGNED  NOT NULL COMMENT '配席子供数',
	`guide_sts` TINYINT UNSIGNED default 0 NOT NULL COMMENT '案内ステータス 1:着席中 2:退席済',
	`seated_at` DATETIME  NOT NULL COMMENT '着席時間',
	`left_at` DATETIME COMMENT '退席時間',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`seat_recv_id`),
	KEY `ix_t_ag_seat_recv1`(`seated_at`),
	KEY `ix_t_ag_seat_recv2`(`ag_recv_id`, `seated_at`, `guide_sts`),
	KEY `ix_t_ag_seat_recv3`(`created_at`),
	KEY `ix_t_ag_seat_recv4`(`updated_at`)
) COMMENT='T_自動配席座席別受付データ';

#-----------------------------------------------------------------------------
#-- h_ag_recv_hist
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `h_ag_recv_hist`;


CREATE TABLE `h_ag_recv_hist`
(
	`ag_recv_hist_id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT '自動配席受付履歴ID',
	`shop_id` INTEGER UNSIGNED  NOT NULL COMMENT '店舗ID',
	`dept_id` INTEGER UNSIGNED  NOT NULL COMMENT '部門ID',
	`recv_ppl` TINYINT UNSIGNED  NOT NULL COMMENT '受付合計人数',
	`recv_children` TINYINT UNSIGNED  NOT NULL COMMENT '受付子供人数',
	`seat_po_type` TINYINT UNSIGNED default 0 NOT NULL COMMENT '座席優先順位パターン 1:通常時 2:引き際時',
	`guided_type` TINYINT UNSIGNED default 0 NOT NULL COMMENT '案内タイプ 1:受付端末 2:スタッフ端末 3:案内端末 4:くら寿司配席サーバー',
	`expect_ag_seat_num` TINYINT UNSIGNED default 0 NOT NULL COMMENT '配席予定座席数',
	`receive_id` INTEGER UNSIGNED COMMENT '予約受付ID',
	`guide_tar_date` DATETIME COMMENT '案内予定日時',
	`re_guide_tar_date` DATETIME COMMENT '不在戻し再案内目安日時',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`ag_recv_hist_id`),
	KEY `ix_h_ag_recv_hist1`(`receive_id`),
	KEY `ix_h_ag_recv_hist2`(`shop_id`, `created_at`),
	KEY `ix_h_ag_recv_hist3`(`created_at`),
	KEY `ix_h_ag_recv_hist4`(`updated_at`)
) COMMENT='H_自動配席受付データ履歴';

#-----------------------------------------------------------------------------
#-- h_ag_seat_recv_hist
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `h_ag_seat_recv_hist`;


CREATE TABLE `h_ag_seat_recv_hist`
(
	`seat_recv_hist_id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT '座席別受付履歴ID',
	`ag_recv_hist_id` INTEGER UNSIGNED  NOT NULL COMMENT '自動配席受付履歴ID',
	`ag_seat_id` INTEGER UNSIGNED  NOT NULL COMMENT '自動配席座席ID',
	`guided_adults` TINYINT UNSIGNED  NOT NULL COMMENT '配席大人数',
	`guided_children` TINYINT UNSIGNED  NOT NULL COMMENT '配席子供数',
	`seated_at` DATETIME  NOT NULL COMMENT '着席時間',
	`left_at` DATETIME COMMENT '退席時間',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`seat_recv_hist_id`),
	KEY `ix_t_ag_seat_recv1`(`seated_at`),
	KEY `ix_t_ag_seat_recv2`(`ag_recv_hist_id`, `seated_at`),
	KEY `ix_t_ag_seat_recv3`(`created_at`),
	KEY `ix_t_ag_seat_recv4`(`updated_at`)
) COMMENT='H_自動配席座席別受付データ履歴';

#-----------------------------------------------------------------------------
#-- h_ag_imp_result
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `h_ag_imp_result`;


CREATE TABLE `h_ag_imp_result`
(
	`ag_imp_result_id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT '自動配席インポートID',
	`admin_user_id` INTEGER UNSIGNED  NOT NULL COMMENT '実行ユーザーID',
	`imp_result_sts` TINYINT UNSIGNED default 0 NOT NULL COMMENT '処理結果状況 0:未処理 1:XMLチェック完了 2:実テーブル登録中 3:一部データエラーあり 4:正常終了 9:エラー終了',
	`imp_file_name` VARCHAR(255)  NOT NULL COMMENT '実行ファイル名',
	`imp_log_name` VARCHAR(255)  NOT NULL COMMENT 'ログファイル名',
	`imp_time` VARCHAR(255) COMMENT '実行所要時間',
	`imp_at` DATETIME  NOT NULL COMMENT '実行日時',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`ag_imp_result_id`),
	KEY `ix_h_ag_imp_result1`(`created_at`),
	KEY `ix_h_ag_imp_result2`(`updated_at`)
) COMMENT='H_自動配席インポート結果履歴';

#-----------------------------------------------------------------------------
#-- h_ag_imp_err
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `h_ag_imp_err`;


CREATE TABLE `h_ag_imp_err`
(
	`ag_imp_err_id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT '自動配席エラーID',
	`ag_imp_result_id` INTEGER UNSIGNED  NOT NULL COMMENT '自動配席インポートID',
	`shop_id` INTEGER UNSIGNED  NOT NULL COMMENT '店舗ID',
	`err_place` VARCHAR(255)  NOT NULL COMMENT 'エラー箇所',
	`err_content` VARCHAR(255)  NOT NULL COMMENT 'エラー内容',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`ag_imp_err_id`),
	KEY `ix_h_ag_imp_err1`(`ag_imp_result_id`, `shop_id`),
	KEY `ix_h_ag_imp_err2`(`created_at`),
	KEY `ix_h_ag_imp_err3`(`updated_at`)
) COMMENT='H_自動配席インポート時エラー履歴';

#-----------------------------------------------------------------------------
#-- t_certify_no
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `t_certify_no`;


CREATE TABLE `t_certify_no`
(
	`receive_id` INTEGER UNSIGNED  NOT NULL COMMENT '受付ID',
	`shop_id` INTEGER UNSIGNED  NOT NULL COMMENT '店舗ID',
	`reserve_date` DATETIME  NOT NULL,
	`certify_no` VARCHAR(255) COMMENT '本人認証番号',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`receive_id`),
	KEY `uix_t_certify_no1`(`receive_id`),
	KEY `ix_t_certify_no2`(`shop_id`, `reserve_date`),
	KEY `ix_t_certify_no3`(`created_at`),
	KEY `ix_t_certify_no4`(`updated_at`)
) COMMENT='T_本人認証番号データ';

#-----------------------------------------------------------------------------
#-- h_certify_no_hist
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `h_certify_no_hist`;


CREATE TABLE `h_certify_no_hist`
(
	`receive_id` INTEGER UNSIGNED  NOT NULL COMMENT '受付ID',
	`shop_id` INTEGER UNSIGNED  NOT NULL COMMENT '店舗ID',
	`reserve_date` DATETIME  NOT NULL,
	`certify_no` VARCHAR(255) COMMENT '本人証明番号',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`receive_id`),
	KEY `uix_h_certify_no_hist1`(`receive_id`),
	KEY `ix_h_certify_no_hist2`(`shop_id`, `reserve_date`),
	KEY `ix_h_certify_no_hist3`(`created_at`),
	KEY `ix_h_certify_no_hist4`(`updated_at`)
) COMMENT='H_本人証明番号データ履歴';

#-----------------------------------------------------------------------------
#-- t_check_in
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `t_check_in`;


CREATE TABLE `t_check_in`
(
	`check_in_id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT '来店証明ID',
	`receive_id` INTEGER UNSIGNED  NOT NULL COMMENT '受付ID',
	`check_in_sts` TINYINT UNSIGNED default 0 NOT NULL COMMENT '来店証明ステータス0:未来店 1:来店済み',
	`check_in_at` DATETIME  NOT NULL COMMENT '来店日時',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`check_in_id`),
	KEY `ix_t_check_in1`(`receive_id`, `check_in_sts`),
	KEY `ix_t_check_in2`(`created_at`),
	KEY `ix_t_check_in3`(`updated_at`)
) COMMENT='T_来店証明データ';

#-----------------------------------------------------------------------------
#-- h_check_in_hist
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `h_check_in_hist`;


CREATE TABLE `h_check_in_hist`
(
	`check_in_hist_id` INTEGER UNSIGNED  NOT NULL COMMENT '来店証明履歴ID',
	`receive_id` INTEGER UNSIGNED  NOT NULL COMMENT '受付ID',
	`check_in_sts` TINYINT UNSIGNED default 0 NOT NULL COMMENT '来店証明ステータス0:未来店 1:来店済み',
	`check_in_at` DATETIME  NOT NULL COMMENT '来店日時',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`check_in_hist_id`),
	KEY `ix_h_check_in_hist1`(`receive_id`, `check_in_sts`),
	KEY `ix_h_check_in_hist2`(`created_at`),
	KEY `ix_h_check_in_hist3`(`updated_at`)
) COMMENT='H_来店証明データ履歴';

#-----------------------------------------------------------------------------
#-- t_ag_call_recv
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `t_ag_call_recv`;


CREATE TABLE `t_ag_call_recv`
(
	`ag_call_id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT '自動呼出ID',
	`receive_id` INTEGER UNSIGNED  NOT NULL COMMENT '予約ID',
	`ag_call_cnt` TINYINT UNSIGNED default 0 NOT NULL COMMENT '呼出回数',
	`ag_called_at` DATETIME COMMENT '呼出時間',
	`ag_call_type` TINYINT UNSIGNED default 1 NOT NULL COMMENT '呼出タイプ1:自動呼出2:手動呼出',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`ag_call_id`),
	KEY `ix_t_ag_call_recv_no1`(`receive_id`, `ag_call_cnt`),
	KEY `ix_t_ag_call_recv_no2`(`created_at`),
	KEY `ix_t_ag_call_recv_no3`(`updated_at`)
) COMMENT='T_自動配席呼出データ';

#-----------------------------------------------------------------------------
#-- h_ag_call_recv_hist
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `h_ag_call_recv_hist`;


CREATE TABLE `h_ag_call_recv_hist`
(
	`ag_call_id` INTEGER UNSIGNED  NOT NULL COMMENT '自動呼出ID',
	`receive_id` INTEGER UNSIGNED  NOT NULL COMMENT '予約ID',
	`ag_call_cnt` TINYINT UNSIGNED default 0 NOT NULL COMMENT '呼出回数',
	`ag_called_at` DATETIME COMMENT '呼出時間',
	`ag_call_type` TINYINT UNSIGNED default 1 NOT NULL COMMENT '呼出タイプ1:自動呼出2:手動呼出',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`ag_call_id`),
	KEY `ix_h_ag_call_recv_hist1`(`receive_id`, `ag_call_cnt`),
	KEY `ix_h_ag_call_recv_hist2`(`created_at`),
	KEY `ix_h_ag_call_recv_hist3`(`updated_at`)
) COMMENT='h_自動配席呼出データ履歴';

#-----------------------------------------------------------------------------
#-- i_ag_navigate
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `i_ag_navigate`;


CREATE TABLE `i_ag_navigate`
(
	`ag_navigate_id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT '自動配席座席誘導ID',
	`ag_shop_id` INTEGER UNSIGNED  NOT NULL COMMENT '自動配席店舗ID',
	`ag_seat_id` TINYINT UNSIGNED  NOT NULL COMMENT '自動配席座席ID',
	`vg_navigate_type` VARCHAR(255)  NOT NULL COMMENT '音声ガイド座席誘導種別',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`ag_navigate_id`),
	KEY `ix_i_ag_navigate_group1`(`ag_shop_id`, `ag_seat_id`),
	KEY `ix_i_ag_navigate_group2`(`created_at`),
	KEY `ix_i_ag_navigate_group3`(`updated_at`)
) COMMENT='I_自動配席座席誘導情報';

#-----------------------------------------------------------------------------
#-- i_ag_advertisement
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `i_ag_advertisement`;


CREATE TABLE `i_ag_advertisement`
(
	`ag_advertisement_id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT '自動配席広告ID',
	`ag_shop_id` INTEGER UNSIGNED  NOT NULL COMMENT '自動配席店舗ID',
	`ag_advertisement_type` VARCHAR(255)  NOT NULL COMMENT '自動配席広告種別',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`ag_advertisement_id`),
	KEY `ix_i_ag_advertisement_group1`(`ag_shop_id`),
	KEY `ix_i_ag_advertisement_group2`(`created_at`),
	KEY `ix_i_ag_advertisement_group3`(`updated_at`)
) COMMENT='I_自動配席広告情報';

#-----------------------------------------------------------------------------
#-- i_ag_cooperation
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `i_ag_cooperation`;


CREATE TABLE `i_ag_cooperation`
(
	`client_id` VARCHAR(255)  NOT NULL COMMENT 'クライアントID',
	`client_name` VARCHAR(255)  NOT NULL COMMENT 'クライアント名',
	`client_secret` VARCHAR(255)  NOT NULL COMMENT 'クライアントシークレット',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`client_id`),
	KEY `ix_i_ag_cooperation1`(`created_at`),
	KEY `ix_i_ag_cooperation2`(`updated_at`)
) COMMENT='I_自動配席連携情報';

#-----------------------------------------------------------------------------
#-- t_ag_push_notice_recv
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `t_ag_push_notice_recv`;


CREATE TABLE `t_ag_push_notice_recv`
(
	`id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT '自動生成プライマリキー',
	`shop_id` INTEGER UNSIGNED  NOT NULL COMMENT '店舗ID',
	`receive_id` INTEGER UNSIGNED  NOT NULL COMMENT '受付ID',
	`member_id` INTEGER UNSIGNED  NOT NULL COMMENT '会員ID',
	`status` INTEGER UNSIGNED default 1 NOT NULL COMMENT 'ステータス 1:通知前 2:通知成功 3:通知失敗',
	`guide_status` TINYINT COMMENT '案内状態 0:未案内 1:案内済 2:不在 3:無断キャンセル 4:案内済再案内 5:不在再案内 6:接客中 7:接客中再案内 8:キャンセル',
	`push_timing` TINYINT UNSIGNED default 1 NOT NULL COMMENT '呼出前PUSH実行タイミング 1:通常 2:前倒し(未来時間帯)',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	KEY `index_shop_id`(`shop_id`),
	KEY `index_receive_id`(`receive_id`),
	KEY `index_status`(`status`)
) COMMENT='T_PUSH通知対象受付データ';

#-----------------------------------------------------------------------------
#-- h_ag_push_notice_recv_hist
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `h_ag_push_notice_recv_hist`;


CREATE TABLE `h_ag_push_notice_recv_hist`
(
	`id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT '自動生成プライマリキー',
	`shop_id` INTEGER UNSIGNED  NOT NULL COMMENT '店舗ID',
	`receive_id` INTEGER UNSIGNED  NOT NULL COMMENT '受付ID',
	`member_id` INTEGER UNSIGNED  NOT NULL COMMENT '会員ID',
	`status` INTEGER UNSIGNED default 1 NOT NULL COMMENT 'ステータス 1:通知前 2:通知成功 3:通知失敗',
	`guide_status` TINYINT COMMENT '案内状態 0:未案内 1:案内済 2:不在 3:無断キャンセル 4:案内済再案内 5:不在再案内 6:接客中 7:接客中再案内 8:キャンセル',
	`push_timing` TINYINT UNSIGNED default 1 NOT NULL COMMENT '呼出前PUSH実行タイミング 1:通常 2:前倒し(未来時間帯)',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	KEY `index_shop_id`(`shop_id`),
	KEY `index_receive_id`(`receive_id`),
	KEY `index_status`(`status`)
) COMMENT='H_PUSH通知対象受付データ履歴';

#-----------------------------------------------------------------------------
#-- i_memberrankconf
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `i_memberrankconf`;


CREATE TABLE `i_memberrankconf`
(
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID',
	`sex_disp` TINYINT default 0 NOT NULL COMMENT '性別表示 0: 非表示 1:表示',
	`age_disp` TINYINT default 0 NOT NULL COMMENT '年齢表示 0: 非表示 1:表示',
	`birthday_disp` TINYINT default 0 NOT NULL COMMENT '誕生日表示 0: 非表示 1:表示',
	`postno_disp` TINYINT default 0 NOT NULL COMMENT '郵便番号表示 0: 非表示 1:表示',
	`shopmail_disp` TINYINT default 0 NOT NULL COMMENT '店舗メール表示 0: 非表示 1:表示',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`shop_id`),
	KEY `ix_i_memberrankconf1`(`created_at`),
	KEY `ix_i_memberrankconf2`(`updated_at`)
) COMMENT='I_会員ランク設定';

#-----------------------------------------------------------------------------
#-- l_rsv_thx_mail_err
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `l_rsv_thx_mail_err`;


CREATE TABLE `l_rsv_thx_mail_err`
(
	`receive_id` BIGINT  NOT NULL COMMENT '予約ID',
	`error_msg` TEXT COMMENT 'エラーメッセージ',
	`error_type` TINYINT  NOT NULL COMMENT 'エラー種別',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`receive_id`)
) COMMENT='予約サンキューメール機能エラーログ';

#-----------------------------------------------------------------------------
#-- i_tp_config
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `i_tp_config`;


CREATE TABLE `i_tp_config`
(
	`id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT 'タッチパネル設定ID',
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID',
	`close_reception_flg` TINYINT UNSIGNED default 0 NOT NULL COMMENT '受付終了画面運用フラグ 0:自動表示 1:手動表示',
	`issue_chime_flg` TINYINT UNSIGNED  NOT NULL COMMENT '発券チャイム機能運用フラグ 0:使用しない 1:使用する',
	PRIMARY KEY (`id`)
) COMMENT='I_タッチパネル設定';

#-----------------------------------------------------------------------------
#-- receive_mail_cv
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `receive_mail_cv`;


CREATE TABLE `receive_mail_cv`
(
	`id` INTEGER  NOT NULL AUTO_INCREMENT COMMENT '予約受付メールコンバージョン情報ID',
	`receive_id` BIGINT  NOT NULL COMMENT '予約受付ID',
	`shop_id` BIGINT  NOT NULL COMMENT '店舗ID',
	`member_id` INTEGER default 0 NOT NULL COMMENT '会員ID',
	`entry_type` TINYINT COMMENT '予約エントリータイプ',
	`mail_send_type` TINYINT  NOT NULL COMMENT 'メール配信種別',
	`mail_id` INTEGER  NOT NULL COMMENT 'メールID',
	`repeat_type` TINYINT  NOT NULL COMMENT 'メール種別',
	`created_at` DATETIME  NOT NULL COMMENT '作成年月日',
	`updated_at` DATETIME  NOT NULL COMMENT '更新年月日',
	PRIMARY KEY (`id`),
	KEY `index_receive_id`(`receive_id`),
	KEY `index_shop_id`(`shop_id`),
	KEY `index_member_id`(`member_id`),
	KEY `index_entry_type`(`entry_type`),
	KEY `index_mail_send_type`(`mail_send_type`),
	KEY `index_mail_id`(`mail_id`),
	KEY `index_repeat_TYPE`(`repeat_type`)
) COMMENT='予約受付メールコンバージョン情報';

#-----------------------------------------------------------------------------
#-- display_setting
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `display_setting`;


CREATE TABLE `display_setting`
(
	`id` INTEGER  NOT NULL COMMENT '機能(コンテンツ)のID',
	`status` TINYINT default 0 COMMENT 'ステータス 0: 表示 1: 非表示',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`)
) COMMENT='機能の表示設定';

#-----------------------------------------------------------------------------
#-- shop_release_date
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `shop_release_date`;


CREATE TABLE `shop_release_date`
(
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID',
	`release_date` DATETIME  NOT NULL COMMENT '店舗公開予定日時',
	`release_status` TINYINT default 1 NOT NULL COMMENT '公開ステータス 0=「公開しない」1=「公開する」2=「公開済み」',
	`created_at` DATETIME  NOT NULL COMMENT 'レコード新規作成年月日',
	`updated_at` DATETIME  NOT NULL COMMENT 'レコード最終更新年月日',
	PRIMARY KEY (`shop_id`)
) COMMENT='店舗公開予定日時';

#-----------------------------------------------------------------------------
#-- t_cxl_wait
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `t_cxl_wait`;


CREATE TABLE `t_cxl_wait`
(
	`id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT 'ID',
	`receive_id` BIGINT  NOT NULL COMMENT '予約ID',
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID',
	`member_id` INTEGER COMMENT '会員ID',
	`cxl_wait_entry_route` TINYINT UNSIGNED COMMENT '受付ルート(1：WEBでの受付、2：店頭発券からの紐付け)',
	`origin_receipt_date` DATETIME  NOT NULL COMMENT '元案内予定日時',
	`cxl_wait_status` TINYINT UNSIGNED default 0 NOT NULL COMMENT 'CXL待ちステータス(0：CXL待ち未受付、1：CXL待ち受付、2：CXL待ち来店証明完了、3：CXL待ち確定、9：CXL待ち取消)',
	`cxl_wait_entry_date` DATETIME COMMENT 'CXL待ち受付日時',
	`cxl_wait_no` VARCHAR(255) COMMENT 'CXL待ち用案内受付番号',
	`cxl_send_type` INTEGER COMMENT 'CXL待ちお知らせ送信先（1：メール、2：LINE）',
	`visit_proof_date` DATETIME COMMENT '来店証明日時',
	`cxl_wait_done_date` DATETIME COMMENT 'CXL待ち確定日時',
	`cxl_wait_abort_date` DATETIME COMMENT 'CXL待ち取消日時',
	`total_skip_count` SMALLINT UNSIGNED default 0 NOT NULL COMMENT 'CXL待ち割込総スキップ回数',
	`total_skip_slot` SMALLINT UNSIGNED default 0 NOT NULL COMMENT 'CXL待ち割込総スキップ組数',
	`visit_proof_no` INTEGER UNSIGNED COMMENT '来店証明番号',
	`cxl_wait_receipt_cd` INTEGER UNSIGNED COMMENT 'CXL待ち発券コード',
	`created_at` DATETIME  NOT NULL COMMENT 'レコード作成年月日',
	`updated_at` DATETIME  NOT NULL COMMENT 'レコード更新年月日',
	PRIMARY KEY (`id`),
	KEY `index_member_id`(`member_id`),
	KEY `index_cxl_wait_receipt_cd`(`cxl_wait_receipt_cd`),
	KEY `index_shop_id`(`shop_id`, `origin_receipt_date`),
	KEY `index_receive_id`(`receive_id`)
) COMMENT='T_キャンセル待ち受付';

#-----------------------------------------------------------------------------
#-- l_cxl_wait_history
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `l_cxl_wait_history`;


CREATE TABLE `l_cxl_wait_history`
(
	`id` INTEGER UNSIGNED  NOT NULL COMMENT 'ID',
	`receive_id` BIGINT  NOT NULL COMMENT '予約ID',
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID',
	`member_id` INTEGER COMMENT '会員ID',
	`cxl_wait_entry_route` TINYINT UNSIGNED COMMENT '受付ルート(1：WEBでの受付、2：店頭発券からの紐付け)',
	`origin_receipt_date` DATETIME  NOT NULL COMMENT '元案内予定日時',
	`cxl_wait_no` VARCHAR(255) COMMENT 'CXL待ち用案内受付番号',
	`cxl_send_type` INTEGER COMMENT 'CXL待ちお知らせ送信先（1：メール、2：LINE）',
	`cxl_wait_status` TINYINT UNSIGNED default 0 NOT NULL COMMENT 'CXL待ちステータス(0：CXL待ち未受付、1：CXL待ち受付、2：CXL待ち来店証明完了、3：CXL待ち確定、9：CXL待ち取消)',
	`cxl_wait_entry_date` DATETIME COMMENT 'CXL待ち受付日時',
	`visit_proof_date` DATETIME COMMENT '来店証明日時',
	`cxl_wait_done_date` DATETIME COMMENT 'CXL待ち確定日時',
	`cxl_wait_abort_date` DATETIME COMMENT 'CXL待ち取消日時',
	`total_skip_count` SMALLINT UNSIGNED default 0 NOT NULL COMMENT 'CXL待ち割込総スキップ回数',
	`total_skip_slot` SMALLINT UNSIGNED default 0 NOT NULL COMMENT 'CXL待ち割込総スキップ組数',
	`visit_proof_no` INTEGER UNSIGNED COMMENT '来店証明番号',
	`cxl_wait_receipt_cd` INTEGER UNSIGNED COMMENT 'CXL待ち発券コード',
	`created_at` DATETIME  NOT NULL COMMENT 'レコード作成年月日',
	`updated_at` DATETIME  NOT NULL COMMENT 'レコード更新年月日',
	PRIMARY KEY (`id`),
	KEY `index_member_id`(`member_id`),
	KEY `index_cxl_wait_receipt_cd`(`cxl_wait_receipt_cd`),
	KEY `index_shop_id`(`shop_id`, `origin_receipt_date`),
	KEY `index_receive_id`(`receive_id`)
) COMMENT='L_キャンセル待ち受付履歴';

#-----------------------------------------------------------------------------
#-- h_cxl_skip
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `h_cxl_skip`;


CREATE TABLE `h_cxl_skip`
(
	`id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT 'ID',
	`t_cxl_wait_id` INTEGER UNSIGNED  NOT NULL COMMENT 'キャンセル待ち受付ID',
	`receive_id` BIGINT  NOT NULL COMMENT '予約ID',
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID',
	`member_id` INTEGER  NOT NULL COMMENT '会員ID',
	`skip_reason_type` TINYINT UNSIGNED COMMENT 'スキップ理由タイプ(0：不在無断キャンセル、1：ユーザキャンセル、2：スタッフキャンセル)',
	`skip_slot` SMALLINT UNSIGNED default 0 NOT NULL COMMENT '割込みスキップ組数',
	`skip_date` DATETIME COMMENT '割込み日時',
	`old_slot` SMALLINT UNSIGNED default 0 NOT NULL COMMENT 'スキップ前の待ち組数',
	`new_slot` SMALLINT UNSIGNED default 0 NOT NULL COMMENT 'スキップ後の待ち組数',
	`mail_send_date` DATETIME COMMENT 'メール通知日時',
	`created_at` DATETIME  NOT NULL COMMENT 'レコード作成年月日',
	`updated_at` DATETIME  NOT NULL COMMENT 'レコード更新年月日',
	PRIMARY KEY (`id`),
	KEY `index_t_cxl_wait_id`(`t_cxl_wait_id`),
	KEY `index_receive_id`(`receive_id`),
	KEY `index_shop_id`(`shop_id`),
	KEY `index_member_id`(`member_id`)
) COMMENT='L_キャンセル待ちスキップ';

#-----------------------------------------------------------------------------
#-- l_cxl_skip_history
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `l_cxl_skip_history`;


CREATE TABLE `l_cxl_skip_history`
(
	`id` INTEGER UNSIGNED  NOT NULL COMMENT 'ID',
	`t_cxl_wait_id` INTEGER UNSIGNED  NOT NULL COMMENT 'キャンセル待ち受付ID',
	`receive_id` BIGINT  NOT NULL COMMENT '予約ID',
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID',
	`member_id` INTEGER  NOT NULL COMMENT '会員ID',
	`skip_reason_type` TINYINT UNSIGNED COMMENT 'スキップ理由タイプ(0：不在無断キャンセル、1：ユーザキャンセル、2：スタッフキャンセル)',
	`skip_slot` SMALLINT UNSIGNED default 0 NOT NULL COMMENT '割込みスキップ組数',
	`skip_date` DATETIME COMMENT '割込み日時',
	`old_slot` SMALLINT UNSIGNED default 0 NOT NULL COMMENT 'スキップ前の待ち組数',
	`new_slot` SMALLINT UNSIGNED default 0 NOT NULL COMMENT 'スキップ後の待ち組数',
	`mail_send_date` DATETIME COMMENT 'メール通知日時',
	`created_at` DATETIME  NOT NULL COMMENT 'レコード作成年月日',
	`updated_at` DATETIME  NOT NULL COMMENT 'レコード更新年月日',
	PRIMARY KEY (`id`),
	KEY `index_t_cxl_wait_id`(`t_cxl_wait_id`),
	KEY `index_receive_id`(`receive_id`),
	KEY `index_shop_id`(`shop_id`),
	KEY `index_member_id`(`member_id`)
) COMMENT='L_キャンセル待ちスキップ履歴';

#-----------------------------------------------------------------------------
#-- i_mail_sozai_folder
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `i_mail_sozai_folder`;


CREATE TABLE `i_mail_sozai_folder`
(
	`mail_sozai_folder_id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT 'グループ・店舗メール用素材フォルダID',
	`group_id` INTEGER COMMENT 'グループID',
	`shop_id` INTEGER COMMENT '店舗ID',
	`status` TINYINT default 0 NOT NULL COMMENT '状態',
	`parent_folder_id` INTEGER UNSIGNED default 0 NOT NULL COMMENT '親フォルダのID',
	`name` VARCHAR(512)  NOT NULL COMMENT 'フォルダ名',
	`path` VARCHAR(2048)  NOT NULL COMMENT 'フォルダフルパス',
	`has_children` TINYINT default 0 NOT NULL COMMENT '子フォルダの存在フラグ (0: 存在しない、1: 存在する',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`mail_sozai_folder_id`),
	KEY `ix_mail_sozai_folder1`(`parent_folder_id`),
	KEY `ix_mail_sozai_folder2`(`created_at`),
	KEY `ix_mail_sozai_folder3`(`updated_at`)
) COMMENT='I_グループ・店舗メール用素材フォルダ';

#-----------------------------------------------------------------------------
#-- i_mail_sozai
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `i_mail_sozai`;


CREATE TABLE `i_mail_sozai`
(
	`mail_sozai_id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT 'グループ・店舗メール用素材ファイルID',
	`group_id` INTEGER COMMENT 'グループID',
	`shop_id` INTEGER COMMENT '店舗ID',
	`status` TINYINT default 0 NOT NULL COMMENT '状態',
	`folder_id` INTEGER UNSIGNED  NOT NULL COMMENT 'フォルダのID',
	`folder_path` VARCHAR(2048)  NOT NULL COMMENT 'フォルダフルパス',
	`file_name` VARCHAR(100)  NOT NULL COMMENT 'ファイル名',
	`name` VARCHAR(100)  NOT NULL COMMENT '素材名',
	`type` TINYINT  NOT NULL COMMENT '素材の種類',
	`mime_type` VARCHAR(128)  NOT NULL COMMENT '素材ファイルのMIMEタイプ',
	`size` INTEGER UNSIGNED  NOT NULL COMMENT '素材ファイルのバイトサイズ',
	`mtime` INTEGER UNSIGNED  NOT NULL COMMENT '素材ファイルの最終更新日時 (Unixtime)',
	`original_sozai_id` INTEGER UNSIGNED COMMENT '元となる素材のID',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`mail_sozai_id`),
	KEY `ix_mail_sozai1`(`original_sozai_id`),
	KEY `ix_mail_sozai2`(`folder_id`),
	KEY `ix_mail_sozai3`(`created_at`),
	KEY `ix_mail_sozai4`(`updated_at`)
) COMMENT='I_グループ・店舗メール用素材ファイル';

#-----------------------------------------------------------------------------
#-- i_shop_uiux_config
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `i_shop_uiux_config`;


CREATE TABLE `i_shop_uiux_config`
(
	`shop_id` INTEGER(11) UNSIGNED  NOT NULL COMMENT '店舗ID',
	`attr_code` SMALLINT(6) UNSIGNED  NOT NULL COMMENT '設定項目コード 0001:クーポン完了メッセージ 0002:中止メッセージ 0200:発券機受付状態(0:受付中, 1:受付中止) 0100:クーポン完了メッセージ編集(0:編集, 1:デフォルト) 0101:中止メッセージ編集(0:編集, 1:デフォルト)',
	`attr_value` VARCHAR(255) COMMENT '設定項目値',
	`created_at` DATETIME  NOT NULL COMMENT '作成日',
	`updated_at` DATETIME  NOT NULL COMMENT '更新日',
	PRIMARY KEY (`shop_id`,`attr_code`)
) COMMENT='I_店舗表示／状態項目設定';

#-----------------------------------------------------------------------------
#-- i_cb_uuid_member
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `i_cb_uuid_member`;


CREATE TABLE `i_cb_uuid_member`
(
	`cb_uuid_member_id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT 'カードブックUUID会員ID',
	`cb_uuid` VARCHAR(255)  NOT NULL COMMENT 'カードブックUUID',
	`member_id` INTEGER(11) default 0 NOT NULL COMMENT '会員ID',
	`os_cd` TINYINT(4)  NOT NULL COMMENT '端末種別',
	`created_at` DATETIME  NOT NULL COMMENT 'レコード作成年月日',
	`updated_at` DATETIME  NOT NULL COMMENT 'レコード更新年月日',
	PRIMARY KEY (`cb_uuid_member_id`),
	KEY `ix_i_cb_uuid_member1`(`cb_uuid`),
	KEY `ix_i_cb_uuid_member2`(`member_id`)
) COMMENT='I_カードブックUUID会員';

#-----------------------------------------------------------------------------
#-- i_cb_coupon_conf
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `i_cb_coupon_conf`;


CREATE TABLE `i_cb_coupon_conf`
(
	`cb_coupon_conf_id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT 'カードブッククーポン設定ID',
	`group_id` INTEGER(11)  NOT NULL COMMENT 'グループID',
	`status` TINYINT(4)  NOT NULL COMMENT '運用ステータス',
	`coupon_name` VARCHAR(150)  NOT NULL COMMENT 'クーポン名',
	`coupon_text` VARCHAR(2000)  NOT NULL COMMENT 'クーポン内容',
	`coupon_type` TINYINT(3) UNSIGNED default 0 NOT NULL COMMENT 'クーポンタイプ',
	`target_shop_type` TINYINT(3) UNSIGNED default 0 NOT NULL COMMENT '対象店舗タイプ',
	`coupon_use_limit_type` TINYINT(4) default 0 NOT NULL COMMENT 'クーポン利用可能回数タイプ',
	`coupon_use_limit` TINYINT(3) UNSIGNED  NOT NULL COMMENT 'クーポン利用可能回数',
	`cb_coupon_photo` VARCHAR(100)  NOT NULL COMMENT 'カードブッククーポン画像',
	`use_period_type` TINYINT(3) UNSIGNED default 0 NOT NULL COMMENT '使用期限タイプ',
	`start_date` DATE  NOT NULL COMMENT '開始日',
	`end_date` DATE  NOT NULL COMMENT '終了日',
	`use_time_type` TINYINT(3) default 0 NOT NULL COMMENT '使用時間タイプ',
	`start_time` TIME COMMENT '開始時間',
	`end_time` TIME COMMENT '終了時間',
	`created_at` DATETIME  NOT NULL COMMENT '作成年月日',
	`updated_at` DATETIME  NOT NULL COMMENT '更新年月日',
	PRIMARY KEY (`cb_coupon_conf_id`),
	KEY `ix_i_cb_coupon_conf1`(`group_id`)
) COMMENT='I_カードブッククーポン設定';

#-----------------------------------------------------------------------------
#-- l_cb_coupon_log
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `l_cb_coupon_log`;


CREATE TABLE `l_cb_coupon_log`
(
	`cb_coupon_log_id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT 'カードブッククーポンログID',
	`cb_coupon_conf_id` INTEGER(10) UNSIGNED  NOT NULL COMMENT 'カードブッククーポン設定ID',
	`cb_uuid_member_id` INTEGER(10) UNSIGNED  NOT NULL COMMENT 'カードブックUUID会員ID',
	`member_id` INTEGER(11) default 0 NOT NULL COMMENT '会員ID',
	`shop_id_used` INTEGER(11) default 0 NOT NULL COMMENT '使用した店舗ID',
	`registration_type` TINYINT(3) default 0 NOT NULL COMMENT '登録タイプ',
	`created_at` DATETIME  NOT NULL COMMENT '作成年月日',
	`updated_at` DATETIME  NOT NULL COMMENT '更新年月日',
	PRIMARY KEY (`cb_coupon_log_id`),
	KEY `ix_l_cb_coupon_log1`(`cb_coupon_conf_id`),
	KEY `ix_l_cb_coupon_log2`(`cb_uuid_member_id`),
	KEY `ix_l_cb_coupon_log3`(`member_id`)
) COMMENT='L_カードブッククーポンログ';

#-----------------------------------------------------------------------------
#-- r_cb_coupon_shop
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `r_cb_coupon_shop`;


CREATE TABLE `r_cb_coupon_shop`
(
	`cb_coupon_shop_id` INTEGER UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT 'カードブッククーポン対象店舗ID',
	`cb_coupon_conf_id` INTEGER(10) UNSIGNED  NOT NULL COMMENT 'カードブッククーポン設定ID',
	`shop_id` INTEGER(11)  NOT NULL COMMENT '店舗ID',
	`created_at` DATETIME  NOT NULL COMMENT '作成年月日',
	`updated_at` DATETIME  NOT NULL COMMENT '更新年月日',
	PRIMARY KEY (`cb_coupon_shop_id`),
	UNIQUE KEY `uix_r_cb_coupon_shop1` (`cb_coupon_conf_id`, `shop_id`)
) COMMENT='R_カードブッククーポン対象店舗';

#-----------------------------------------------------------------------------
#-- t_grm_coop_shop
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `t_grm_coop_shop`;


CREATE TABLE `t_grm_coop_shop`
(
	`shop_id` INTEGER(11)  NOT NULL COMMENT 'EPARK店舗ID',
	`is_grm_coop_shop` TINYINT(3) UNSIGNED default 1 NOT NULL COMMENT 'グルメ店舗判定値 0:グルメ店舗以外 1:グルメ店舗',
	`forced_coop_type` TINYINT(3) UNSIGNED default 9 NOT NULL COMMENT '強制連携区分 0:連携無効 1:連携有効 9:未設定',
	`auto_coop_type` TINYINT(3) UNSIGNED default 0 NOT NULL COMMENT '自動連携区分 0:連携無効 1:連携有効',
	`coop_sts` TINYINT(3) UNSIGNED default 0 NOT NULL COMMENT '連携状態 0:無効 1:有効',
	`conv_lock_flg` TINYINT(3) UNSIGNED default 0 NOT NULL COMMENT '変換値固定フラグ 0:無効 1:有効',
	`coop_latitude` DOUBLE COMMENT '連携用店舗の緯度',
	`coop_longitude` DOUBLE COMMENT '連携用店舗の経度',
	`coop_conv_zip_code` VARCHAR(7) COMMENT '連携変換した郵便番号',
	`coop_conv_area_id` SMALLINT UNSIGNED COMMENT '連携変換したエリアID',
	`coop_conv_pref_id` INTEGER UNSIGNED COMMENT '連携変換した都道府県ID',
	`coop_conv_city_id` INTEGER UNSIGNED COMMENT '連携変換した地区町村ID',
	`coop_conv_stations` VARCHAR(100) default '' NOT NULL COMMENT 'カンマ区切りの連携変換した駅ID',
	`coop_display_point` DECIMAL(10,2) default 0 NOT NULL COMMENT '連携用並び順点',
	`coop_max_last_month` SMALLINT default 0 NOT NULL COMMENT '連携用前月の待ち組数最大値',
	`last_output_at` DATETIME COMMENT '最終出力年月日',
	`created_at` DATETIME  NOT NULL COMMENT '作成年月日',
	`updated_at` DATETIME  NOT NULL COMMENT '更新年月日',
	PRIMARY KEY (`shop_id`),
	KEY `t_grm_coop_shop_I_1`(`coop_max_last_month`),
	KEY `ix_t_grm_coop_shop1`(`last_output_at`),
	KEY `ix_t_grm_coop_shop2`(`updated_at`),
	KEY `ix_t_grm_coop_shop3`(`created_at`),
	KEY `ix_t_grm_coop_shop4`(`is_grm_coop_shop`, `forced_coop_type`, `auto_coop_type`, `coop_sts`)
) COMMENT='T_グルメ連携店舗';

#-----------------------------------------------------------------------------
#-- t_grm_shop_cat_large
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `t_grm_shop_cat_large`;


CREATE TABLE `t_grm_shop_cat_large`
(
	`large_coop_id` SMALLINT(5) UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT '連携用店舗大カテゴリID',
	`shop_category_id` INTEGER(11)  NOT NULL COMMENT '店舗カテゴリID',
	`created_at` DATETIME  NOT NULL COMMENT '作成年月日',
	`updated_at` DATETIME  NOT NULL COMMENT '更新年月日',
	PRIMARY KEY (`large_coop_id`),
	KEY `ix_t_grm_shop_cat_large1`(`shop_category_id`)
) COMMENT='T_グルメ連携店舗大カテゴリ';

#-----------------------------------------------------------------------------
#-- t_grm_shop_cat_mid
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `t_grm_shop_cat_mid`;


CREATE TABLE `t_grm_shop_cat_mid`
(
	`mid_coop_id` SMALLINT(5) UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT '連携用店舗中カテゴリID',
	`large_coop_id` SMALLINT(5) UNSIGNED  NOT NULL COMMENT '連携用店舗大カテゴリID',
	`shop_category_id` INTEGER(11)  NOT NULL COMMENT '店舗カテゴリID',
	`created_at` DATETIME  NOT NULL COMMENT '作成年月日',
	`updated_at` DATETIME  NOT NULL COMMENT '更新年月日',
	PRIMARY KEY (`mid_coop_id`),
	KEY `ix_t_grm_shop_cat_mid1`(`large_coop_id`),
	KEY `ix_t_grm_shop_cat_mid2`(`shop_category_id`)
) COMMENT='T_グルメ連携店舗中カテゴリ';

#-----------------------------------------------------------------------------
#-- t_ep_wait_payment
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `t_ep_wait_payment`;


CREATE TABLE `t_ep_wait_payment`
(
	`payment_history_id` INTEGER(10) UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT '決済取引履歴ID',
	`receive_id` BIGINT(20)  NOT NULL COMMENT '予約ID',
	`trade_id` VARCHAR(64)  NOT NULL COMMENT '取引特定ID',
	`order_id` INTEGER(10) UNSIGNED  NOT NULL COMMENT 'オーダーID',
	`shop_id` INTEGER(11)  NOT NULL COMMENT '店舗ID',
	`member_id` INTEGER(8)  NOT NULL COMMENT '会員ID',
	`franchise_shop_id` VARCHAR(20)  NOT NULL COMMENT '加盟店ID',
	`service_id` VARCHAR(30)  NOT NULL COMMENT 'サービスID',
	`usage_amount` INTEGER(7)  NOT NULL COMMENT '利用金額',
	`payment_detail` INTEGER(8)  NOT NULL COMMENT '取引明細',
	`payment_status` TINYINT(4)  NOT NULL COMMENT '決済ステータス',
	`created_record_user` TINYINT(4)  NOT NULL COMMENT 'レコード作成ユーザー',
	`created_at` DATETIME  NOT NULL COMMENT 'レコード作成日時',
	PRIMARY KEY (`payment_history_id`),
	KEY `ix_t_ep_wait_payment1`(`receive_id`),
	KEY `ix_t_ep_wait_payment2`(`payment_status`),
	KEY `ix_t_ep_wait_payment3`(`trade_id`),
	KEY `ix_t_ep_wait_payment4`(`created_at`),
	KEY `ix_t_ep_wait_payment5`(`member_id`),
	KEY `ix_t_ep_wait_payment6`(`shop_id`),
	KEY `ix_t_ep_wait_payment7`(`order_id`)
) COMMENT='順番待ち決済データの格納テーブル';

#-----------------------------------------------------------------------------
#-- tp_after_login_notice
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `tp_after_login_notice`;


CREATE TABLE `tp_after_login_notice`
(
	`tp_after_login_id` INTEGER  NOT NULL AUTO_INCREMENT,
	`shop_id_select_flag` TINYINT  NOT NULL COMMENT '店舗ID選択フラグ：0カテゴリで判別、店舗IDで判別',
	`xl_category_id` INTEGER,
	`big_category_id` INTEGER,
	`mid_category_id` INTEGER,
	`shop_ids` VARCHAR(255) COMMENT '店舗ID：店舗IDをカンマ区切りで登録',
	`info_date` DATE  NOT NULL COMMENT 'おしらせ日付',
	`info_title` VARCHAR(60)  NOT NULL COMMENT '件名',
	`info_body` TEXT  NOT NULL COMMENT '本文',
	`info_status` TINYINT  NOT NULL COMMENT '表示ステータス。0:非承認、1:承認',
	`created_at` DATETIME  NOT NULL,
	`updated_at` DATETIME  NOT NULL,
	PRIMARY KEY (`tp_after_login_id`)
) COMMENT='TPログイン後お知らせ';

#-----------------------------------------------------------------------------
#-- i_ppc_resty_shop_config
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `i_ppc_resty_shop_config`;


CREATE TABLE `i_ppc_resty_shop_config`
(
	`shop_id` INTEGER(11)  NOT NULL COMMENT '店舗ID',
	`tel` VARCHAR(20) COMMENT '電話番号（PPC）',
	`url` VARCHAR(255) COMMENT 'Resty WEBフォームURL',
	`button_name` VARCHAR(50) COMMENT 'ボタン名',
	`popup_words_main` VARCHAR(100) COMMENT 'ポップアップ文言（メイン）',
	`popup_words_detail` VARCHAR(100) COMMENT 'ポップアップ文言（詳細）',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`shop_id`)
) COMMENT='予約連携利用権限';

#-----------------------------------------------------------------------------
#-- s_ppc_resty_click_count
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `s_ppc_resty_click_count`;


CREATE TABLE `s_ppc_resty_click_count`
(
	`id` INTEGER UNSIGNED  NOT NULL COMMENT 'ID',
	`shop_id` INTEGER(11)  NOT NULL COMMENT '店舗ID',
	`click_date` DATETIME  NOT NULL COMMENT 'クリック対象日',
	`reserve_type` TINYINT(1)  NOT NULL COMMENT '予約区分 (1:予約専用ダイヤル, 2:WEB予約)',
	`portal_type` TINYINT(1)  NOT NULL COMMENT 'クリック区分 (1:PC, 2:SP)',
	`click_count` INTEGER(11)  NOT NULL COMMENT 'クリックカウント数',
	`created_at` DATETIME  NOT NULL COMMENT '作成年月日',
	`updated_at` DATETIME  NOT NULL COMMENT '更新年月日',
	PRIMARY KEY (`id`),
	KEY `index_shop_id`(`shop_id`),
	KEY `index_click_date`(`click_date`),
	KEY `index_for_click_day`(`shop_id`, `click_date`)
) COMMENT='PPC,Restyボタンクリック計測';

#-----------------------------------------------------------------------------
#-- receive_tel_call_api_log_history
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `receive_tel_call_api_log_history`;


CREATE TABLE `receive_tel_call_api_log_history`
(
	`id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT 'ID',
	`receive_id` BIGINT  NOT NULL COMMENT '予約ID',
	`shop_id` INTEGER  NOT NULL COMMENT '店舗ID（あえて冗長）',
	`transmission_status` TINYINT default 1 NOT NULL COMMENT '通信ステータス 1:通信中 2:完了',
	`result_status` TINYINT default 0 NOT NULL COMMENT '結果ステータス 0:未完了 1:正常 2:エラー終了 3:異常終了（タイムアウト等） 4:強制終了',
	`result_notified` TINYINT default 1 NOT NULL COMMENT '結果表示済みフラグ 1:未表示 2:表示済み',
	`call_count` TINYINT default 0 NOT NULL COMMENT '電話呼出API実行回数',
	`call_log_message` VARCHAR(100) COMMENT 'ログメッセージ（エラー発生時に）',
	`call_start_time` DATETIME COMMENT '通信開始日時',
	`call_end_time` DATETIME COMMENT '通信終了日時（強制終了時はその日時）',
	`guide_status` TINYINT UNSIGNED  NOT NULL COMMENT '案内状態 0: 未案内 1: 案内済 2: 不在 3: 無断キャンセル 4: 案内済再案内 5: 不在・無断キャンセル再案内 6: 接客中 7: 接客中再案内',
	`auto_call_flg` TINYINT UNSIGNED default 0 NOT NULL COMMENT '自動呼出フラグ 0: 手動呼出 1: 自動呼出',
	`acs2_callable_seat` TEXT COMMENT 'ACS2用 電話呼出時に紐付けられる呼出可能席(JSON)',
	`created_at` DATETIME COMMENT 'レコード作成日時',
	`updated_at` DATETIME COMMENT 'レコード更新日時',
	PRIMARY KEY (`id`),
	KEY `index_receive_id`(`receive_id`),
	KEY `index_transmission_status`(`transmission_status`),
	KEY `index_result_status`(`result_status`),
	KEY `index_result_notified`(`result_notified`)
) COMMENT='電話呼出API通信ログ管理の履歴テーブル';

#-----------------------------------------------------------------------------
#-- i_cb_category_genre
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `i_cb_category_genre`;


CREATE TABLE `i_cb_category_genre`
(
	`cb_category_genre_id` INTEGER  NOT NULL COMMENT 'ID',
	`xl_category_id` INTEGER  NOT NULL COMMENT '大々分類カテゴリID',
	`big_genre_id` INTEGER  NOT NULL COMMENT '大分類ジャンルID',
	`mid_genre_id` INTEGER  NOT NULL COMMENT '中分類ジャンルID',
	`genre_name` VARCHAR(40)  NOT NULL COMMENT 'ジャンル名',
	`display_order` BIGINT  NOT NULL COMMENT '表示順',
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`cb_category_genre_id`)
) COMMENT='I_カードブック用ジャンルマスタ';

#-----------------------------------------------------------------------------
#-- t_category_extension_receive
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `t_category_extension_receive`;


CREATE TABLE `t_category_extension_receive`
(
	`id` INTEGER(11)  NOT NULL AUTO_INCREMENT COMMENT 'ID',
	`receive_id` INTEGER(11)  NOT NULL COMMENT '受付ID',
	`shop_id` INTEGER(11)  NOT NULL COMMENT '店舗ID',
	`reserve_class` TINYINT(4) default 0 NOT NULL COMMENT '受付区分 0:無し 1:受電受付',
	`created_at` DATETIME COMMENT 'レコード作成日時',
	`updated_at` DATETIME COMMENT 'レコード更新日時',
	PRIMARY KEY (`id`)
) COMMENT='T_拡張受付データ';

#-----------------------------------------------------------------------------
#-- T_gotoeat_point_info
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `T_gotoeat_point_info`;


CREATE TABLE `T_gotoeat_point_info`
(
	`id` INTEGER(11)  NOT NULL AUTO_INCREMENT COMMENT 'ID',
	`member_id` INTEGER(11) COMMENT '会員ID',
	`user_name` VARCHAR(128) COMMENT '会員名',
	`shop_id` VARCHAR(20) COMMENT '店舗ID',
	`site_id` INTEGER(11) COMMENT 'サイトID',
	`receive_id` BIGINT(20) COMMENT '予約ID',
	`entry_date` DATETIME COMMENT '予約日時',
	`receive_date` DATETIME COMMENT '予約案内日時',
	`receive_shop_name` VARCHAR(128) COMMENT '予約案内店舗名',
	`receive_num` TINYINT(4) COMMENT '予約案内人数',
	`usage_amount` INTEGER(11) COMMENT '利用金額',
	`request_status` INTEGER(11) COMMENT '申請ステータス',
	`comment` VARCHAR(1000) COMMENT '備考',
	`request_date` DATETIME COMMENT 'ポイント申請日時',
	`gotoeat_point` INTEGER(11) COMMENT 'GTEポイント',
	`dealings_point_date` DATETIME COMMENT 'ポイント取引日付',
	`ocr_reception_date` DATETIME COMMENT 'OCR来店受付日時',
	`ocr_shop_tel` VARCHAR(12) COMMENT 'OCR店舗電話番号',
	`ocr_shop_name` VARCHAR(128) COMMENT 'OCR店舗名',
	`ocr_shop_address` VARCHAR(128) COMMENT 'OCR店舗住所',
	`ocr_visitor_num` TINYINT(4) COMMENT 'OCR人数',
	`ocr_payment` INTEGER(11) COMMENT 'OCR支払金額',
	`ocr_image` VARCHAR(128) COMMENT 'OCRイメージ',
	`ocr_image_mime_type` VARCHAR(8) COMMENT 'OCRイメージ拡張子',
	`reasons_for_ng` VARCHAR(1000) COMMENT '備考',
	`created_at` DATETIME COMMENT '登録日時',
	`updated_at` DATETIME COMMENT '更新日時',
	PRIMARY KEY (`id`),
	KEY `ix_t_gotoeat_point_info1`(`member_id`),
	KEY `ix_t_gotoeat_point_info2`(`shop_id`),
	KEY `ix_t_gotoeat_point_info3`(`receive_date`),
	KEY `ix_t_gotoeat_point_info4`(`request_status`),
	KEY `ix_t_gotoeat_point_info5`(`dealings_point_date`),
	KEY `ix_t_gotoeat_point_info6`(`updated_at`),
	KEY `ix_t_gotoeat_point_info7`(`member_id`, `request_status`),
	KEY `ix_t_gotoeat_point_info8`(`member_id`, `request_date`, `request_status`),
	KEY `ix_t_gotoeat_point_info9`(`member_id`, `dealings_point_date`, `request_status`)
) COMMENT='T_GTE用ポイント履歴情報';

#-----------------------------------------------------------------------------
#-- i_shop_gotoeat_term
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `i_shop_gotoeat_term`;


CREATE TABLE `i_shop_gotoeat_term`
(
	`id` INTEGER(11)  NOT NULL AUTO_INCREMENT COMMENT 'ID',
	`shop_id` INTEGER(11)  NOT NULL COMMENT '店舗ID',
	`gotoeat_start_date` DATETIME COMMENT 'キャンペーン開始日',
	`gotoeat_end_date_for_grant_visit` DATETIME COMMENT 'ポイント付与来店期日',
	`gotoeat_end_date_for_use_entry` DATETIME COMMENT 'ポイント消費予約期日',
	`gotoeat_end_date_for_use_visit` DATETIME COMMENT 'ポイント消費来店期日',
	`created_at` DATETIME COMMENT '登録日時',
	`updated_at` DATETIME COMMENT '更新日時',
	PRIMARY KEY (`id`),
	KEY `ix_i_shop_gotoeat_term1`(`shop_id`)
) COMMENT='I_店舗GoToEatキャンペーン期間';

#-----------------------------------------------------------------------------
#-- m_gotoeat_setting
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `m_gotoeat_setting`;


CREATE TABLE `m_gotoeat_setting`
(
	`id` INTEGER(11)  NOT NULL AUTO_INCREMENT COMMENT 'ID',
	`gotoeat_start_date_all` DATETIME COMMENT 'キャンペーン開始日',
	`gotoeat_end_date_for_grant_visit_all` DATETIME COMMENT 'ポイント付与来店期日',
	`gotoeat_end_date_for_petition_all` DATETIME COMMENT 'ポイント申請期日',
	`gotoeat_end_date_for_use_entry_all` DATETIME COMMENT 'ポイント消費予約期日',
	`gotoeat_end_date_for_use_visit_all` DATETIME COMMENT 'ポイント消費来店期日',
	`created_at` DATETIME COMMENT '登録日時',
	`updated_at` DATETIME COMMENT '更新日時',
	PRIMARY KEY (`id`)
) COMMENT='M_GoToEatキャンペーン設定';

#-----------------------------------------------------------------------------
#-- S_gotoeat_shop_daily_used_point
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `S_gotoeat_shop_daily_used_point`;


CREATE TABLE `S_gotoeat_shop_daily_used_point`
(
	`id` INTEGER(11)  NOT NULL AUTO_INCREMENT COMMENT 'ID',
	`shop_id` INTEGER(11)  NOT NULL COMMENT '店舗ID',
	`gotoeat_point` INTEGER(11)  NOT NULL COMMENT 'GTE消費ポイントの日次サマリー値',
	`used_at` DATETIME  NOT NULL COMMENT '消費日時',
	`created_at` DATETIME COMMENT '登録日時',
	PRIMARY KEY (`id`),
	KEY `ix_s_gotoeat_shop_daily_used_point1`(`shop_id`, `used_at`)
) COMMENT='S_GoToEatキャンペーン店舗別消費ポイントの日次サマリー';

#-----------------------------------------------------------------------------
#-- S_gotoeat_shop_daily_gived_point
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `S_gotoeat_shop_daily_gived_point`;


CREATE TABLE `S_gotoeat_shop_daily_gived_point`
(
	`id` INTEGER(11)  NOT NULL AUTO_INCREMENT COMMENT 'ID',
	`shop_id` INTEGER(11)  NOT NULL COMMENT '店舗ID',
	`gotoeat_point` INTEGER(11)  NOT NULL COMMENT 'GTE付与ポイントの日次サマリー値',
	`gived_at` DATETIME  NOT NULL COMMENT '付与日時',
	`created_at` DATETIME COMMENT '登録日時',
	PRIMARY KEY (`id`),
	KEY `ix_s_gotoeat_shop_daily_gived_point1`(`shop_id`, `gived_at`)
) COMMENT='S_GoToEatキャンペーン店舗別付与ポイントの日次サマリー';

#-----------------------------------------------------------------------------
#-- L_gotoeat_Y01_csv_history_tmp
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `L_gotoeat_Y01_csv_history_tmp`;


CREATE TABLE `L_gotoeat_Y01_csv_history_tmp`
(
	`id` INTEGER(11)  NOT NULL AUTO_INCREMENT COMMENT 'ID',
	`receive_id` VARCHAR(20) COMMENT '予約ID',
	`member_id` INTEGER(11) COMMENT '会員ID',
	`gourmet_shop_id` VARCHAR(20) COMMENT 'グルメ店舗ID',
	`entry_date` DATETIME COMMENT '予約登録日時',
	`receive_date` DATE COMMENT '予約来店日',
	`receive_time` TIME COMMENT '予約来店時間',
	`receive_num` TINYINT(4) COMMENT '予約来店人数',
	`cancel_date` DATETIME COMMENT 'キャンセル日時',
	`status` TINYINT(4) COMMENT 'ステータス',
	`created_at` DATETIME COMMENT '登録日時',
	`updated_at` DATETIME COMMENT '更新日時',
	PRIMARY KEY (`id`)
) COMMENT='Y01_予約情報CSV履歴_一時保存テーブル';

#-----------------------------------------------------------------------------
#-- L_gotoeat_Y01_csv_history
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `L_gotoeat_Y01_csv_history`;


CREATE TABLE `L_gotoeat_Y01_csv_history`
(
	`id` INTEGER(11)  NOT NULL AUTO_INCREMENT COMMENT 'ID',
	`receive_data` VARCHAR(20) COMMENT '予約情報',
	`member_id` INTEGER(11) COMMENT '会員ID',
	`shop_id` VARCHAR(20) COMMENT '店舗ID',
	`entry_date` DATETIME COMMENT '予約登録日時',
	`receive_date` DATE COMMENT '予約来店日',
	`receive_time` TIME COMMENT '予約来店時間',
	`receive_num` TINYINT(4) COMMENT '予約来店人数',
	`cancel_date` DATETIME COMMENT 'キャンセル日時',
	`update_flg` TINYINT(4) COMMENT 'アップデートフラグ',
	`guide_status` TINYINT(4) COMMENT '案内ステータス',
	`reserve_status` TINYINT(4) COMMENT '予約ステータス',
	`last_output_file_date` DATETIME COMMENT '最終ファイル出力日時',
	`last_output_file_name` VARCHAR(30) COMMENT '最終ファイル出力名',
	`last_output_file_number` INTEGER(11) COMMENT '最終出力ファイル番号',
	`last_output_line_number` INTEGER(11) COMMENT '最終出力行番号',
	`created_at` DATETIME COMMENT '登録日時',
	`updated_at` DATETIME COMMENT '更新日時',
	PRIMARY KEY (`id`),
	KEY `ix_l_gotoeat_Y01_csv_history1`(`receive_data`),
	KEY `ix_l_gotoeat_Y01_csv_history2`(`member_id`),
	KEY `ix_l_gotoeat_Y01_csv_history3`(`shop_id`),
	KEY `ix_l_gotoeat_Y01_csv_history4`(`last_output_file_name`),
	KEY `ix_l_gotoeat_Y01_csv_history5`(`last_output_file_number`),
	KEY `ix_l_gotoeat_Y01_csv_history6`(`last_output_line_number`)
) COMMENT='Y01_予約情報CSV履歴';

#-----------------------------------------------------------------------------
#-- L_gotoeat_Y02_csv_history_tmp
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `L_gotoeat_Y02_csv_history_tmp`;


CREATE TABLE `L_gotoeat_Y02_csv_history_tmp`
(
	`id` INTEGER(11)  NOT NULL AUTO_INCREMENT COMMENT 'ID',
	`receive_id` VARCHAR(20) COMMENT '予約ID',
	`member_id` INTEGER(11) COMMENT '会員ID',
	`gourmet_shop_id` VARCHAR(20) COMMENT 'グルメ店舗ID',
	`receive_date` DATE COMMENT '来店日',
	`receive_time` TIME COMMENT '来店時間',
	`receive_num` TINYINT(4) COMMENT '来店人数',
	`usage_amount` INTEGER(11) COMMENT '利用金額',
	`status` TINYINT(4) COMMENT 'ステータス',
	`created_at` DATETIME COMMENT '登録日時',
	`updated_at` DATETIME COMMENT '更新日時',
	PRIMARY KEY (`id`)
) COMMENT='Y02_来店情報CSV履歴_一時保存テーブル';

#-----------------------------------------------------------------------------
#-- L_gotoeat_Y02_csv_history
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `L_gotoeat_Y02_csv_history`;


CREATE TABLE `L_gotoeat_Y02_csv_history`
(
	`id` INTEGER(11)  NOT NULL AUTO_INCREMENT COMMENT 'ID',
	`receive_data` VARCHAR(20) COMMENT '予約情報',
	`member_id` INTEGER(11) COMMENT '会員ID',
	`shop_id` VARCHAR(20) COMMENT '店舗ID',
	`visit_date` DATE COMMENT '来店日',
	`visit_time` TIME COMMENT '来店時間',
	`visit_num` TINYINT(4) COMMENT '来店人数',
	`use_amount` INTEGER(11) COMMENT '利用金額',
	`update_flg` TINYINT(4) COMMENT 'アップデートフラグ',
	`last_output_file_date` DATETIME COMMENT '最終ファイル出力日時',
	`last_output_file_name` VARCHAR(30) COMMENT '最終ファイル出力名',
	`last_output_file_number` INTEGER(11) COMMENT '最終出力ファイル番号',
	`last_output_line_number` INTEGER(11) COMMENT '最終出力行番号',
	`created_at` DATETIME COMMENT '登録日時',
	`updated_at` DATETIME COMMENT '更新日時',
	PRIMARY KEY (`id`),
	KEY `ix_l_gotoeat_Y02_csv_history1`(`receive_data`),
	KEY `ix_l_gotoeat_Y02_csv_history2`(`member_id`),
	KEY `ix_l_gotoeat_Y02_csv_history3`(`shop_id`),
	KEY `ix_l_gotoeat_Y02_csv_history4`(`last_output_file_name`),
	KEY `ix_l_gotoeat_Y02_csv_history5`(`last_output_file_number`),
	KEY `ix_l_gotoeat_Y02_csv_history6`(`last_output_line_number`)
) COMMENT='Y02_来店情報CSV履歴';

#-----------------------------------------------------------------------------
#-- L_gotoeat_Y03_csv_history
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `L_gotoeat_Y03_csv_history`;


CREATE TABLE `L_gotoeat_Y03_csv_history`
(
	`prefixed_reserve_id` VARCHAR(200)  NOT NULL COMMENT '予約番号',
	`encrypted_member_id` VARCHAR(200)  NOT NULL COMMENT '消費者ID',
	`shop_id` VARCHAR(200)  NOT NULL COMMENT '飲食店ID',
	`gotoeat_point_per_person` INTEGER(4) COMMENT '付与ポイント単価',
	`gotoeat_point` INTEGER(8) COMMENT '付与ポイント',
	`dealings_point_date` VARCHAR(8) COMMENT 'ポイント付与日',
	`expire_date` VARCHAR(8) COMMENT '有効期限',
	`crud_flag` TINYINT COMMENT '登録・修正・削除フラグ',
	`last_output_file_date` DATETIME COMMENT '最終ファイル出力日時',
	`last_output_file_name` VARCHAR(20) COMMENT '最終ファイル出力名',
	`last_output_file_number` INTEGER(11) COMMENT '最終出力ファイル番号',
	`last_output_line_number` INTEGER(11) COMMENT '最終出力行番号',
	`created_at` DATETIME COMMENT '登録日時',
	`updated_at` DATETIME COMMENT '更新日時',
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	PRIMARY KEY (`id`),
	KEY `ix_l_gotoeat_Y03_csv_history1`(`encrypted_member_id`),
	KEY `ix_l_gotoeat_Y03_csv_history2`(`shop_id`),
	KEY `ix_l_gotoeat_Y03_csv_history3`(`last_output_file_name`),
	KEY `ix_l_gotoeat_Y03_csv_history4`(`last_output_file_number`),
	KEY `ix_l_gotoeat_Y03_csv_history5`(`last_output_line_number`)
) COMMENT='Y03_ポイント付与情報CSV履歴';

#-----------------------------------------------------------------------------
#-- L_gotoeat_Y04_csv_history
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `L_gotoeat_Y04_csv_history`;


CREATE TABLE `L_gotoeat_Y04_csv_history`
(
	`prefixed_reserve_id` VARCHAR(200)  NOT NULL COMMENT '予約番号',
	`encrypted_member_id` VARCHAR(200)  NOT NULL COMMENT '消費者ID',
	`shop_id` VARCHAR(200)  NOT NULL COMMENT '飲食店ID',
	`dealings_point_date` VARCHAR(12) COMMENT 'ポイント利用日時',
	`gotoeat_point` INTEGER(8) COMMENT '利用ポイント',
	`crud_flag` TINYINT COMMENT '登録・修正・削除フラグ',
	`last_output_file_date` DATETIME COMMENT '最終ファイル出力日時',
	`last_output_file_name` VARCHAR(20) COMMENT '最終ファイル出力名',
	`last_output_file_number` INTEGER(11) COMMENT '最終出力ファイル番号',
	`last_output_line_number` INTEGER(11) COMMENT '最終出力行番号',
	`created_at` DATETIME COMMENT '登録日時',
	`updated_at` DATETIME COMMENT '更新日時',
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	PRIMARY KEY (`id`),
	KEY `ix_l_gotoeat_Y04_csv_history1`(`encrypted_member_id`),
	KEY `ix_l_gotoeat_Y04_csv_history2`(`shop_id`),
	KEY `ix_l_gotoeat_Y04_csv_history3`(`last_output_file_name`),
	KEY `ix_l_gotoeat_Y04_csv_history4`(`last_output_file_number`),
	KEY `ix_l_gotoeat_Y04_csv_history5`(`last_output_line_number`)
) COMMENT='Y04_ポイント利用情報CSV履歴';

#-----------------------------------------------------------------------------
#-- L_gotoeat_Y07_csv_history
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `L_gotoeat_Y07_csv_history`;


CREATE TABLE `L_gotoeat_Y07_csv_history`
(
	`account_number` VARCHAR(200) COMMENT '口座番号',
	`shop_id` VARCHAR(200)  NOT NULL COMMENT '飲食店ID',
	`payment_date` DATETIME COMMENT '飲食店への代金支払日',
	`prefixed_reserve_id` VARCHAR(200)  NOT NULL COMMENT '予約番号',
	`payment_amount` INTEGER(11) COMMENT '飲食店への代金支払い額',
	`crud_flag` TINYINT(4)  NOT NULL COMMENT '登録・修正・削除フラグ',
	`last_output_file_date` DATETIME COMMENT '最終ファイル出力日時',
	`last_output_file_name` VARCHAR(30) COMMENT '最終ファイル出力名',
	`last_output_file_number` INTEGER(11) COMMENT '最終出力ファイル番号',
	`last_output_line_number` INTEGER(11) COMMENT '最終出力行番号',
	`created_at` DATETIME COMMENT '登録日時',
	`updated_at` DATETIME COMMENT '更新日時',
	`id` INTEGER  NOT NULL AUTO_INCREMENT,
	PRIMARY KEY (`id`),
	KEY `ix_l_gotoeat_Y07_csv_history1`(`shop_id`),
	KEY `ix_l_gotoeat_Y07_csv_history2`(`last_output_file_name`),
	KEY `ix_l_gotoeat_Y07_csv_history3`(`last_output_file_number`),
	KEY `ix_l_gotoeat_Y07_csv_history4`(`last_output_line_number`)
) COMMENT='代金支払い明細情報CSV履歴テーブル';

#-----------------------------------------------------------------------------
#-- L_gotoeat_Y08_csv_history_tmp
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `L_gotoeat_Y08_csv_history_tmp`;


CREATE TABLE `L_gotoeat_Y08_csv_history_tmp`
(
	`report_date` DATETIME  NOT NULL COMMENT '報告日',
	`member_id` INTEGER(11)  NOT NULL COMMENT 'メンバーID',
	`mon_added_total_point` INTEGER(11) COMMENT '［月］付与ポイント総額',
	`mon_expired_total_point` INTEGER(11) COMMENT '［月］失効ポイント総額 ',
	`mon_use_total_point` INTEGER(11) COMMENT '［月］利用ポイント総額',
	`mon_remain_total_point` INTEGER(11) COMMENT '［月］残余ポイント総額 ',
	`mon_exp_add_total_point` INTEGER(11) COMMENT '［月］付与予定ポイント総額',
	`mon_exp_remain_lunch_total_visitor` TINYINT(4) COMMENT '［月］未来店残予約総人数-ランチ',
	`mon_exp_remain_dinner_total_visitor` TINYINT(4) COMMENT '［月］未来店残予約総人数-ディナー',
	`mon_last_tmp_work_date` DATETIME COMMENT '［月］最終一時作業日時',
	`tue_added_total_point` INTEGER(11) COMMENT '［火］付与ポイント総額',
	`tue_expired_total_point` INTEGER(11) COMMENT '［火］失効ポイント総額 ',
	`tue_use_total_point` INTEGER(11) COMMENT '［火］利用ポイント総額',
	`tue_remain_total_point` INTEGER(11) COMMENT '［火］残余ポイント総額 ',
	`tue_exp_add_total_point` INTEGER(11) COMMENT '［火］付与予定ポイント総額',
	`tue_exp_remain_lunch_total_visitor` TINYINT(4) COMMENT '［火］未来店残予約総人数-ランチ',
	`tue_exp_remain_dinner_total_visitor` TINYINT(4) COMMENT '［火］未来店残予約総人数-ディナー',
	`tue_last_tmp_work_date` DATETIME COMMENT '［火］最終一時作業日時',
	`wed_added_total_point` INTEGER(11) COMMENT '［水］付与ポイント総額',
	`wed_expired_total_point` INTEGER(11) COMMENT '［水］失効ポイント総額 ',
	`wed_use_total_point` INTEGER(11) COMMENT '［水］利用ポイント総額',
	`wed_remain_total_point` INTEGER(11) COMMENT '［水］残余ポイント総額 ',
	`wed_exp_add_total_point` INTEGER(11) COMMENT '［水］付与予定ポイント総額',
	`wed_exp_remain_lunch_total_visitor` TINYINT(4) COMMENT '［水］未来店残予約総人数-ランチ',
	`wed_exp_remain_dinner_total_visitor` TINYINT(4) COMMENT '［水］未来店残予約総人数-ディナー',
	`wed_last_tmp_work_date` DATETIME COMMENT '［水］最終一時作業日時',
	`thu_added_total_point` INTEGER(11) COMMENT '［木］付与ポイント総額',
	`thu_expired_total_point` INTEGER(11) COMMENT '［木］失効ポイント総額 ',
	`thu_use_total_point` INTEGER(11) COMMENT '［木］利用ポイント総額',
	`thu_remain_total_point` INTEGER(11) COMMENT '［木］残余ポイント総額 ',
	`thu_exp_add_total_point` INTEGER(11) COMMENT '［木］付与予定ポイント総額',
	`thu_exp_remain_lunch_total_visitor` TINYINT(4) COMMENT '［木］未来店残予約総人数-ランチ',
	`thu_exp_remain_dinner_total_visitor` TINYINT(4) COMMENT '［木］未来店残予約総人数-ディナー',
	`thu_last_tmp_work_date` DATETIME COMMENT '［木］最終一時作業日時',
	`fri_added_total_point` INTEGER(11) COMMENT '［金］付与ポイント総額',
	`fri_expired_total_point` INTEGER(11) COMMENT '［金］失効ポイント総額 ',
	`fri_use_total_point` INTEGER(11) COMMENT '［金］利用ポイント総額',
	`fri_remain_total_point` INTEGER(11) COMMENT '［金］残余ポイント総額 ',
	`fri_exp_add_total_point` INTEGER(11) COMMENT '［金］付与予定ポイント総額',
	`fri_exp_remain_lunch_total_visitor` TINYINT(4) COMMENT '［金］未来店残予約総人数-ランチ',
	`fri_exp_remain_dinner_total_visitor` TINYINT(4) COMMENT '［金］未来店残予約総人数-ディナー',
	`fri_last_tmp_work_date` DATETIME COMMENT '［金］最終一時作業日時',
	`sat_added_total_point` INTEGER(11) COMMENT '［土］付与ポイント総額',
	`sat_expired_total_point` INTEGER(11) COMMENT '［土］失効ポイント総額 ',
	`sat_use_total_point` INTEGER(11) COMMENT '［土］利用ポイント総額',
	`sat_remain_total_point` INTEGER(11) COMMENT '［土］残余ポイント総額 ',
	`sat_exp_add_total_point` INTEGER(11) COMMENT '［土］付与予定ポイント総額',
	`sat_exp_remain_lunch_total_visitor` TINYINT(4) COMMENT '［土］未来店残予約総人数-ランチ',
	`sat_exp_remain_dinner_total_visitor` TINYINT(4) COMMENT '［土］未来店残予約総人数-ディナー',
	`sat_last_tmp_work_date` DATETIME COMMENT '［土］最終一時作業日時',
	`sun_added_total_point` INTEGER(11) COMMENT '［日］付与ポイント総額',
	`sun_expired_total_point` INTEGER(11) COMMENT '［日］失効ポイント総額 ',
	`sun_use_total_point` INTEGER(11) COMMENT '［日］利用ポイント総額',
	`sun_remain_total_point` INTEGER(11) COMMENT '［日］残余ポイント総額 ',
	`sun_exp_add_total_point` INTEGER(11) COMMENT '［日］付与予定ポイント総額',
	`sun_exp_remain_lunch_total_visitor` TINYINT(4) COMMENT '［日］未来店残予約総人数-ランチ',
	`sun_exp_remain_dinner_total_visitor` TINYINT(4) COMMENT '［日］未来店残予約総人数-ディナー',
	`sun_last_tmp_work_date` DATETIME COMMENT '［日］最終一時作業日時',
	`created_at` DATETIME COMMENT '登録日時',
	`updated_at` DATETIME COMMENT '更新日時',
	PRIMARY KEY (`report_date`,`member_id`),
	KEY `ix_l_gotoeat_Y08_csv_history_tmp1`(`member_id`)
) COMMENT='Y08_消費者ポイント現況CSV履歴_一時データ保存用';

#-----------------------------------------------------------------------------
#-- L_gotoeat_Y08_csv_history
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `L_gotoeat_Y08_csv_history`;


CREATE TABLE `L_gotoeat_Y08_csv_history`
(
	`report_date` DATETIME  NOT NULL COMMENT '報告日',
	`member_id` INTEGER(11)  NOT NULL COMMENT 'メンバーID',
	`mon_added_total_point` INTEGER(11) COMMENT '［月］付与ポイント総額',
	`mon_expired_total_point` INTEGER(11) COMMENT '［月］失効ポイント総額 ',
	`mon_use_total_point` INTEGER(11) COMMENT '［月］利用ポイント総額',
	`mon_remain_total_point` INTEGER(11) COMMENT '［月］残余ポイント総額 ',
	`mon_exp_add_total_point` INTEGER(11) COMMENT '［月］付与予定ポイント総額',
	`mon_exp_remain_lunch_total_visitor` TINYINT(4) COMMENT '［月］未来店残予約総人数-ランチ',
	`mon_exp_remain_dinner_total_visitor` TINYINT(4) COMMENT '［月］未来店残予約総人数-ディナー',
	`mon_update_flg` TINYINT(4) COMMENT '［月］アップデートフラグ',
	`mon_last_output_file_date` DATETIME COMMENT '［月］最終ファイル出力日時',
	`mon_last_output_file_name` VARCHAR(30) COMMENT '［月］最終ファイル出力名',
	`mon_last_output_file_number` INTEGER(11) COMMENT '［月］最終出力ファイル番号',
	`mon_last_output_line_number` INTEGER(11) COMMENT '［月］最終出力行番号',
	`tue_added_total_point` INTEGER(11) COMMENT '［火］付与ポイント総額',
	`tue_expired_total_point` INTEGER(11) COMMENT '［火］失効ポイント総額 ',
	`tue_use_total_point` INTEGER(11) COMMENT '［火］利用ポイント総額',
	`tue_remain_total_point` INTEGER(11) COMMENT '［火］残余ポイント総額 ',
	`tue_exp_add_total_point` INTEGER(11) COMMENT '［火］付与予定ポイント総額',
	`tue_exp_remain_lunch_total_visitor` TINYINT(4) COMMENT '［火］未来店残予約総人数-ランチ',
	`tue_exp_remain_dinner_total_visitor` TINYINT(4) COMMENT '［火］未来店残予約総人数-ディナー',
	`tue_update_flg` TINYINT(4) COMMENT '［火］アップデートフラグ',
	`tue_last_output_file_date` DATETIME COMMENT '［火］最終ファイル出力日時',
	`tue_last_output_file_name` VARCHAR(30) COMMENT '［火］最終ファイル出力名',
	`tue_last_output_file_number` INTEGER(11) COMMENT '［火］最終出力ファイル番号',
	`tue_last_output_line_number` INTEGER(11) COMMENT '［火］最終出力行番号',
	`wed_added_total_point` INTEGER(11) COMMENT '［水］付与ポイント総額',
	`wed_expired_total_point` INTEGER(11) COMMENT '［水］失効ポイント総額 ',
	`wed_use_total_point` INTEGER(11) COMMENT '［水］利用ポイント総額',
	`wed_remain_total_point` INTEGER(11) COMMENT '［水］残余ポイント総額 ',
	`wed_exp_add_total_point` INTEGER(11) COMMENT '［水］付与予定ポイント総額',
	`wed_exp_remain_lunch_total_visitor` TINYINT(4) COMMENT '［水］未来店残予約総人数-ランチ',
	`wed_exp_remain_dinner_total_visitor` TINYINT(4) COMMENT '［水］未来店残予約総人数-ディナー',
	`wed_update_flg` TINYINT(4) COMMENT '［水］アップデートフラグ',
	`wed_last_output_file_date` DATETIME COMMENT '［水］最終ファイル出力日時',
	`wed_last_output_file_name` VARCHAR(30) COMMENT '［水］最終ファイル出力名',
	`wed_last_output_file_number` INTEGER(11) COMMENT '［水］最終出力ファイル番号',
	`wed_last_output_line_number` INTEGER(11) COMMENT '［水］最終出力行番号',
	`thu_added_total_point` INTEGER(11) COMMENT '［木］付与ポイント総額',
	`thu_expired_total_point` INTEGER(11) COMMENT '［木］失効ポイント総額 ',
	`thu_use_total_point` INTEGER(11) COMMENT '［木］利用ポイント総額',
	`thu_remain_total_point` INTEGER(11) COMMENT '［木］残余ポイント総額 ',
	`thu_exp_add_total_point` INTEGER(11) COMMENT '［木］付与予定ポイント総額',
	`thu_exp_remain_lunch_total_visitor` TINYINT(4) COMMENT '［木］未来店残予約総人数-ランチ',
	`thu_exp_remain_dinner_total_visitor` TINYINT(4) COMMENT '［木］未来店残予約総人数-ディナー',
	`thu_update_flg` TINYINT(4) COMMENT '［木］アップデートフラグ',
	`thu_last_output_file_date` DATETIME COMMENT '［木］最終ファイル出力日時',
	`thu_last_output_file_name` VARCHAR(30) COMMENT '［木］最終ファイル出力名',
	`thu_last_output_file_number` INTEGER(11) COMMENT '［木］最終出力ファイル番号',
	`thu_last_output_line_number` INTEGER(11) COMMENT '［木］最終出力行番号',
	`fri_added_total_point` INTEGER(11) COMMENT '［金］付与ポイント総額',
	`fri_expired_total_point` INTEGER(11) COMMENT '［金］失効ポイント総額 ',
	`fri_use_total_point` INTEGER(11) COMMENT '［金］利用ポイント総額',
	`fri_remain_total_point` INTEGER(11) COMMENT '［金］残余ポイント総額 ',
	`fri_exp_add_total_point` INTEGER(11) COMMENT '［金］付与予定ポイント総額',
	`fri_exp_remain_lunch_total_visitor` TINYINT(4) COMMENT '［金］未来店残予約総人数-ランチ',
	`fri_exp_remain_dinner_total_visitor` TINYINT(4) COMMENT '［金］未来店残予約総人数-ディナー',
	`fri_update_flg` TINYINT(4) COMMENT '［金］アップデートフラグ',
	`fri_last_output_file_date` DATETIME COMMENT '［金］最終ファイル出力日時',
	`fri_last_output_file_name` VARCHAR(30) COMMENT '［金］最終ファイル出力名',
	`fri_last_output_file_number` INTEGER(11) COMMENT '［金］最終出力ファイル番号',
	`fri_last_output_line_number` INTEGER(11) COMMENT '［金］最終出力行番号',
	`sat_added_total_point` INTEGER(11) COMMENT '［土］付与ポイント総額',
	`sat_expired_total_point` INTEGER(11) COMMENT '［土］失効ポイント総額 ',
	`sat_use_total_point` INTEGER(11) COMMENT '［土］利用ポイント総額',
	`sat_remain_total_point` INTEGER(11) COMMENT '［土］残余ポイント総額 ',
	`sat_exp_add_total_point` INTEGER(11) COMMENT '［土］付与予定ポイント総額',
	`sat_exp_remain_lunch_total_visitor` TINYINT(4) COMMENT '［土］未来店残予約総人数-ランチ',
	`sat_exp_remain_dinner_total_visitor` TINYINT(4) COMMENT '［土］未来店残予約総人数-ディナー',
	`sat_update_flg` TINYINT(4) COMMENT '［土］アップデートフラグ',
	`sat_last_output_file_date` DATETIME COMMENT '［土］最終ファイル出力日時',
	`sat_last_output_file_name` VARCHAR(30) COMMENT '［土］最終ファイル出力名',
	`sat_last_output_file_number` INTEGER(11) COMMENT '［土］最終出力ファイル番号',
	`sat_last_output_line_number` INTEGER(11) COMMENT '［土］最終出力行番号',
	`sun_added_total_point` INTEGER(11) COMMENT '［日］付与ポイント総額',
	`sun_expired_total_point` INTEGER(11) COMMENT '［日］失効ポイント総額 ',
	`sun_use_total_point` INTEGER(11) COMMENT '［日］利用ポイント総額',
	`sun_remain_total_point` INTEGER(11) COMMENT '［日］残余ポイント総額 ',
	`sun_exp_add_total_point` INTEGER(11) COMMENT '［日］付与予定ポイント総額',
	`sun_exp_remain_lunch_total_visitor` TINYINT(4) COMMENT '［日］未来店残予約総人数-ランチ',
	`sun_exp_remain_dinner_total_visitor` TINYINT(4) COMMENT '［日］未来店残予約総人数-ディナー',
	`sun_update_flg` TINYINT(4) COMMENT '［日］アップデートフラグ',
	`sun_last_output_file_date` DATETIME COMMENT '［日］最終ファイル出力日時',
	`sun_last_output_file_name` VARCHAR(30) COMMENT '［日］最終ファイル出力名',
	`sun_last_output_file_number` INTEGER(11) COMMENT '［日］最終出力ファイル番号',
	`sun_last_output_line_number` INTEGER(11) COMMENT '［日］最終出力行番号',
	`created_at` DATETIME COMMENT '登録日時',
	`updated_at` DATETIME COMMENT '更新日時',
	PRIMARY KEY (`report_date`,`member_id`),
	KEY `ix_l_gotoeat_Y08_csv_history_1`(`mon_last_output_file_number`, `mon_last_output_line_number`),
	KEY `ix_l_gotoeat_Y08_csv_history_2`(`tue_last_output_file_number`, `tue_last_output_line_number`),
	KEY `ix_l_gotoeat_Y08_csv_history_3`(`wed_last_output_file_number`, `wed_last_output_line_number`),
	KEY `ix_l_gotoeat_Y08_csv_history_4`(`thu_last_output_file_number`, `thu_last_output_line_number`),
	KEY `ix_l_gotoeat_Y08_csv_history_5`(`fri_last_output_file_number`, `fri_last_output_line_number`),
	KEY `ix_l_gotoeat_Y08_csv_history_6`(`sat_last_output_file_number`, `sat_last_output_line_number`),
	KEY `ix_l_gotoeat_Y08_csv_history_7`(`sun_last_output_file_number`, `sun_last_output_line_number`),
	KEY `ix_l_gotoeat_Y08_csv_history_8`(`member_id`)
) COMMENT='Y08_消費者ポイント現況CSV履歴';

#-----------------------------------------------------------------------------
#-- L_gotoeat_Y09_csv_history
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `L_gotoeat_Y09_csv_history`;


CREATE TABLE `L_gotoeat_Y09_csv_history`
(
	`id` INTEGER(11)  NOT NULL AUTO_INCREMENT COMMENT 'ID',
	`shop_id` INTEGER(11) COMMENT '店舗ID',
	`group_name` VARCHAR(200) COMMENT 'グループ名',
	`shop_name` VARCHAR(200) COMMENT '店舗名',
	`registration_date` DATETIME COMMENT '登録日',
	`cancellation_date` DATETIME COMMENT '解約日',
	`shop_address` VARCHAR(500) COMMENT '飲食店住所',
	`shop_zip_code` VARCHAR(7) COMMENT '飲食店郵便番号',
	`shop_tel` VARCHAR(20) COMMENT '飲食店電話番号',
	`shop_capacity` TINYINT(4) COMMENT '飲食店定員数',
	`update_flg` TINYINT(4) COMMENT 'アップデートフラグ',
	`last_output_file_date` DATETIME COMMENT '最終ファイル出力日時',
	`last_output_file_name` VARCHAR(30) COMMENT '最終ファイル出力名',
	`last_output_file_number` INTEGER(11) COMMENT '最終出力ファイル番号',
	`last_output_line_number` INTEGER(11) COMMENT '最終出力行番号',
	`created_at` DATETIME COMMENT '登録日時',
	`updated_at` DATETIME COMMENT '更新日時',
	PRIMARY KEY (`id`),
	KEY `ix_l_gotoeat_Y09_csv_history1`(`shop_id`),
	KEY `ix_l_gotoeat_Y09_csv_history2`(`last_output_file_name`),
	KEY `ix_l_gotoeat_Y09_csv_history3`(`last_output_file_number`),
	KEY `ix_l_gotoeat_Y09_csv_history4`(`last_output_line_number`)
) COMMENT='Y09_飲食マスタCSV履歴';

#-----------------------------------------------------------------------------
#-- S_gotoeat_shop_monthly_used_point
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `S_gotoeat_shop_monthly_used_point`;


CREATE TABLE `S_gotoeat_shop_monthly_used_point`
(
	`id` INTEGER(11)  NOT NULL AUTO_INCREMENT COMMENT 'ID',
	`start_date` DATE  NOT NULL COMMENT '集計開始日',
	`end_date` DATE  NOT NULL COMMENT '集計終了日',
	`shop_id` INTEGER(11)  NOT NULL COMMENT '店舗ID',
	`gotoeat_point` INTEGER(11)  NOT NULL COMMENT '消費ポイントの月次サマリ',
	`created_at` DATETIME COMMENT '登録日時',
	`updated_at` DATETIME COMMENT '更新日時',
	PRIMARY KEY (`id`),
	KEY `ix_s_gotoeat_shop_monthly_used_point1`(`start_date`, `end_date`, `shop_id`)
) COMMENT='店舗別消費ポイントの月次サマリテーブル';

#-----------------------------------------------------------------------------
#-- L_gotoeat_Y06_csv_history
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `L_gotoeat_Y06_csv_history`;


CREATE TABLE `L_gotoeat_Y06_csv_history`
(
	`id` INTEGER(11)  NOT NULL AUTO_INCREMENT COMMENT 'ID',
	`shop_id` VARCHAR(200)  NOT NULL COMMENT '飲食店ID',
	`payment_date` DATETIME COMMENT '飲食店への代金支払い日',
	`account_number` VARCHAR(200) COMMENT '口座番号',
	`account_transfer_amount` INTEGER(8) COMMENT '口座振込額',
	`payment_amount` INTEGER(8)  NOT NULL COMMENT 'GoToEat給付金',
	`other_payment_amount` INTEGER(8) COMMENT 'その他ポイント支払額',
	`deduction_amount` INTEGER(8) COMMENT '手数料等天引き額',
	`crud_flag` TINYINT(4)  NOT NULL COMMENT '登録・修正・削除フラグ',
	`last_output_file_date` DATETIME COMMENT '最終ファイル出力日時',
	`last_output_file_name` VARCHAR(20) COMMENT '最終ファイル出力名',
	`last_output_file_number` INTEGER(11) COMMENT '最終出力ファイル番号',
	`last_output_line_number` INTEGER(11) COMMENT '最終出力行番号',
	`created_at` DATETIME COMMENT '登録日時',
	`updated_at` DATETIME COMMENT '更新日時',
	PRIMARY KEY (`id`),
	KEY `ix_l_gotoeat_Y06_csv_history1`(`shop_id`),
	KEY `ix_l_gotoeat_Y06_csv_history2`(`account_number`),
	KEY `ix_l_gotoeat_Y06_csv_history3`(`last_output_file_name`),
	KEY `ix_l_gotoeat_Y06_csv_history4`(`last_output_file_number`),
	KEY `ix_l_gotoeat_Y06_csv_history5`(`last_output_line_number`)
) COMMENT='代金支払情報CSV履歴';

#-----------------------------------------------------------------------------
#-- m_gotoeat_company
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `m_gotoeat_company`;


CREATE TABLE `m_gotoeat_company`
(
	`id` INTEGER(11)  NOT NULL AUTO_INCREMENT COMMENT 'ID',
	`company_id` VARCHAR(255) COMMENT '企業ID',
	`company_name` VARCHAR(255) COMMENT '企業名',
	`shop_id` INTEGER(11) COMMENT '店舗ID',
	`created_at` DATETIME COMMENT '登録日時',
	`updated_at` DATETIME COMMENT '更新日時',
	PRIMARY KEY (`id`),
	UNIQUE KEY `uix_m_gotoeat_company1` (`company_id`, `shop_id`),
	KEY `ix_m_gotoeat_company1`(`company_id`),
	KEY `ix_m_gotoeat_company2`(`shop_id`)
) COMMENT='M_GoToEat企業';

#-----------------------------------------------------------------------------
#-- L_gotoeat_Y08_gourmet_temp_csv_history
#-----------------------------------------------------------------------------

DROP TABLE IF EXISTS `L_gotoeat_Y08_gourmet_temp_csv_history`;


CREATE TABLE `L_gotoeat_Y08_gourmet_temp_csv_history`
(
	`report_date` DATETIME  NOT NULL COMMENT '報告日',
	`member_id` INTEGER(11)  NOT NULL COMMENT 'メンバーID',
	`mon_expected_lunch_visitor` TINYINT(4) COMMENT '［月］未来予約総人数【ランチ】',
	`mon_expected_dinner_visitor` TINYINT(4) COMMENT '［月］未来予約総人数【ディナー】',
	`mon_last_update_date` DATETIME COMMENT '［月］最終更新日時',
	`tue_expected_lunch_visitor` TINYINT(4) COMMENT '［火］未来予約総人数【ランチ】',
	`tue_expected_dinner_visitor` TINYINT(4) COMMENT '［火］未来予約総人数【ディナー】',
	`tue_last_update_date` DATETIME COMMENT '［火］最終更新日時',
	`wed_expected_lunch_visitor` TINYINT(4) COMMENT '［水］未来予約総人数【ランチ】',
	`wed_expected_dinner_visitor` TINYINT(4) COMMENT '［水］未来予約総人数【ディナー】',
	`wed_last_update_date` DATETIME COMMENT '［水］最終更新日時',
	`thu_expected_lunch_visitor` TINYINT(4) COMMENT '［木］未来予約総人数【ランチ】',
	`thu_expected_dinner_visitor` TINYINT(4) COMMENT '［木］未来予約総人数【ディナー】',
	`thu_last_update_date` DATETIME COMMENT '［木］最終更新日時',
	`fri_expected_lunch_visitor` TINYINT(4) COMMENT '［金］未来予約総人数【ランチ】',
	`fri_expected_dinner_visitor` TINYINT(4) COMMENT '［金］未来予約総人数【ディナー】',
	`fri_last_update_date` DATETIME COMMENT '［金］最終更新日時',
	`sat_expected_lunch_visitor` TINYINT(4) COMMENT '［土］未来予約総人数【ランチ】',
	`sat_expected_dinner_visitor` TINYINT(4) COMMENT '［土］未来予約総人数【ディナー】',
	`sat_last_update_date` DATETIME COMMENT '［土］最終更新日時',
	`sun_expected_lunch_visitor` TINYINT(4) COMMENT '［日］未来予約総人数【ランチ】',
	`sun_expected_dinner_visitor` TINYINT(4) COMMENT '［日］未来予約総人数【ディナー】',
	`sun_last_update_date` DATETIME COMMENT '［日］最終更新日時',
	`created_at` DATETIME COMMENT '登録日時',
	`updated_at` DATETIME COMMENT '更新日時',
	PRIMARY KEY (`report_date`,`member_id`),
	KEY `ix_l_gotoeat_gourmet_temp_csv_history1`(`member_id`)
) COMMENT='Y08_グルメメディアCSV一時取込テーブル';

# This restores the fkey checks, after having unset them earlier
SET FOREIGN_KEY_CHECKS = 1;