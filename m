Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90DD3C41513
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 18:29:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPnge-00043r-Jt; Fri, 05 Jul 2024 14:29:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1sPngY-0003mt-Up
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 14:29:32 -0400
Received: from mail-qv1-xf32.google.com ([2607:f8b0:4864:20::f32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1sPngO-0006x7-8B
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 14:29:30 -0400
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6b2c6291038so16200726d6.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 11:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1720204158; x=1720808958; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6YWYSPSFizkKzrZgTlQrK6YRNZXwdhaz0tq+XpBvoro=;
 b=FkuOyXUI5CATdDWos+7LyGsMLvBUyxdjLRahs7VfoIa1XUr90ZZrbzpkbhDbF0g/uF
 hQXTW3bIY9TQd4O5RR4JU4ZaoBoIRnExty+E86OuLceHoA7Lvb38Ag4sQ9Z8bEn1oorB
 JZE4RAlibiJjSaXgqhxat+SXQE+vpq6/DFVDRnJBOMw+Zxrur6XS4UCm/aleHe9a0e/B
 21xLOhPGRUpqk3iznJ94lhXXB/Q7HlzB31q93I+bgMzXPdQvwYB1CkHQYFdvSHdVa9XZ
 OIT4hEBIJG+esw6nOVVmK+L0JiRIccIWVIPRoY5+273owqsngDdwclgI4Y/qxELfRKBH
 RyQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720204158; x=1720808958;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6YWYSPSFizkKzrZgTlQrK6YRNZXwdhaz0tq+XpBvoro=;
 b=BjeYrCSmihANK2mZmSs6tnak6ZnPm0h2qthPOrNUQAh9pL73bEqRd3tfsO1w5sNy0/
 KPamMQH81VJwCfr5uYTUqF941xS2aer7ysHC12P6E46IJ3brjnW7kDAillJbnmuZ3N9I
 chp64r942P/uXkWKauwAhEY9I77PWPezOQhnTq6DWwqHdbkvNTQIYrx2sXN7pS1iFt+2
 89foWP/WPmwSYiQGcm+FdPfNZVYE6DmOl/ZwJHZ2Ghv4uzTL45qqz2PeNmzbM0QahKXX
 CQh/UJvTTKTJrZNsafL4udJV/umE7B7bwjLLTJfusbMaRkvaF97aYrRCY1i2nYCmaOb2
 Cgww==
X-Forwarded-Encrypted: i=1;
 AJvYcCW17WhU/wXEYnfB1Bn7sE9O5zgmR4w90vEibSe2GnGrB/uWlHWJmRWCsok8Bf59Eup2ptVCHlFjrLJ6zrv1NM918ZjnvmQ=
X-Gm-Message-State: AOJu0YwQB3O1wSduto0ZpdzIjXxhpGIiTKIm4Ic7HFi2xxm8RQahKTRe
 t23WZKZIBIrSDEuDmeDLYzx1oyCV/hpy4Jf4GkbzoonJPucF0Nks99SsBRUu8KY=
X-Google-Smtp-Source: AGHT+IG00tKGNLqtRrO+Z2QBzw4ySlkKS9qEz+vG+AP0GKD0/DU5DE87EUhWABApWW1fEMlVRQ+m2Q==
X-Received: by 2002:a05:6214:411b:b0:6b5:ab8:3c5a with SMTP id
 6a1803df08f44-6b5ee6343abmr70470066d6.25.1720204157908; 
 Fri, 05 Jul 2024 11:29:17 -0700 (PDT)
Received: from DY4X0N7X05.bytedance.net
 (ec2-54-152-246-50.compute-1.amazonaws.com. [54.152.246.50])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b5fb7e316esm4972936d6.30.2024.07.05.11.29.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 05 Jul 2024 11:29:17 -0700 (PDT)
From: Yichen Wang <yichen.wang@bytedance.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Cc: "Hao Xiang" <hao.xiang@linux.dev>, "Liu, Yuan1" <yuan1.liu@intel.com>,
 "Zou, Nanhai" <nanhai.zou@intel.com>,
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>,
 "Yichen Wang" <yichen.wang@bytedance.com>,
 Bryan Zhang <bryan.zhang@bytedance.com>
Subject: [PATCH v4 2/4] migration: Add migration parameters for QATzip
Date: Fri,  5 Jul 2024 11:28:59 -0700
Message-Id: <20240705182901.48948-3-yichen.wang@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240705182901.48948-1-yichen.wang@bytedance.com>
References: <20240705182901.48948-1-yichen.wang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f32;
 envelope-from=yichen.wang@bytedance.com; helo=mail-qv1-xf32.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Bryan Zhang <bryan.zhang@bytedance.com>

Adds support for migration parameters to control QATzip compression
level and to enable/disable software fallback when QAT hardware is
unavailable. This is a preparatory commit for a subsequent commit that
will actually use QATzip compression.

Signed-off-by: Bryan Zhang <bryan.zhang@bytedance.com>
Signed-off-by: Hao Xiang <hao.xiang@linux.dev>
Signed-off-by: Yichen Wang <yichen.wang@bytedance.com>
---
 migration/migration-hmp-cmds.c |  8 +++++
 migration/options.c            | 57 ++++++++++++++++++++++++++++++++++
 migration/options.h            |  2 ++
 qapi/migration.json            | 35 +++++++++++++++++++++
 4 files changed, 102 insertions(+)

diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 7d608d26e1..664e2390a3 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -576,6 +576,14 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
         p->has_multifd_zlib_level = true;
         visit_type_uint8(v, param, &p->multifd_zlib_level, &err);
         break;
+    case MIGRATION_PARAMETER_MULTIFD_QATZIP_LEVEL:
+        p->has_multifd_qatzip_level = true;
+        visit_type_uint8(v, param, &p->multifd_qatzip_level, &err);
+        break;
+    case MIGRATION_PARAMETER_MULTIFD_QATZIP_SW_FALLBACK:
+        p->has_multifd_qatzip_sw_fallback = true;
+        visit_type_bool(v, param, &p->multifd_qatzip_sw_fallback, &err);
+        break;
     case MIGRATION_PARAMETER_MULTIFD_ZSTD_LEVEL:
         p->has_multifd_zstd_level = true;
         visit_type_uint8(v, param, &p->multifd_zstd_level, &err);
diff --git a/migration/options.c b/migration/options.c
index 645f55003d..334d70fb6d 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -55,6 +55,15 @@
 #define DEFAULT_MIGRATE_MULTIFD_COMPRESSION MULTIFD_COMPRESSION_NONE
 /* 0: means nocompress, 1: best speed, ... 9: best compress ratio */
 #define DEFAULT_MIGRATE_MULTIFD_ZLIB_LEVEL 1
+/*
+ * 1: best speed, ... 9: best compress ratio
+ * There is some nuance here. Refer to QATzip documentation to understand
+ * the mapping of QATzip levels to standard deflate levels.
+ */
+#define DEFAULT_MIGRATE_MULTIFD_QATZIP_LEVEL 1
+/* QATzip's SW fallback implementation is extremely slow, so avoid fallback */
+#define DEFAULT_MIGRATE_MULTIFD_QATZIP_SW_FALLBACK false
+
 /* 0: means nocompress, 1: best speed, ... 20: best compress ratio */
 #define DEFAULT_MIGRATE_MULTIFD_ZSTD_LEVEL 1
 
@@ -123,6 +132,12 @@ Property migration_properties[] = {
     DEFINE_PROP_UINT8("multifd-zlib-level", MigrationState,
                       parameters.multifd_zlib_level,
                       DEFAULT_MIGRATE_MULTIFD_ZLIB_LEVEL),
+    DEFINE_PROP_UINT8("multifd-qatzip-level", MigrationState,
+                      parameters.multifd_qatzip_level,
+                      DEFAULT_MIGRATE_MULTIFD_QATZIP_LEVEL),
+    DEFINE_PROP_BOOL("multifd-qatzip-sw-fallback", MigrationState,
+                      parameters.multifd_qatzip_sw_fallback,
+                      DEFAULT_MIGRATE_MULTIFD_QATZIP_SW_FALLBACK),
     DEFINE_PROP_UINT8("multifd-zstd-level", MigrationState,
                       parameters.multifd_zstd_level,
                       DEFAULT_MIGRATE_MULTIFD_ZSTD_LEVEL),
@@ -787,6 +802,20 @@ int migrate_multifd_zlib_level(void)
     return s->parameters.multifd_zlib_level;
 }
 
+int migrate_multifd_qatzip_level(void)
+{
+    MigrationState *s = migrate_get_current();
+
+    return s->parameters.multifd_qatzip_level;
+}
+
+bool migrate_multifd_qatzip_sw_fallback(void)
+{
+    MigrationState *s = migrate_get_current();
+
+    return s->parameters.multifd_qatzip_sw_fallback;
+}
+
 int migrate_multifd_zstd_level(void)
 {
     MigrationState *s = migrate_get_current();
@@ -892,6 +921,11 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
     params->multifd_compression = s->parameters.multifd_compression;
     params->has_multifd_zlib_level = true;
     params->multifd_zlib_level = s->parameters.multifd_zlib_level;
+    params->has_multifd_qatzip_level = true;
+    params->multifd_qatzip_level = s->parameters.multifd_qatzip_level;
+    params->has_multifd_qatzip_sw_fallback = true;
+    params->multifd_qatzip_sw_fallback =
+        s->parameters.multifd_qatzip_sw_fallback;
     params->has_multifd_zstd_level = true;
     params->multifd_zstd_level = s->parameters.multifd_zstd_level;
     params->has_xbzrle_cache_size = true;
@@ -946,6 +980,8 @@ void migrate_params_init(MigrationParameters *params)
     params->has_multifd_channels = true;
     params->has_multifd_compression = true;
     params->has_multifd_zlib_level = true;
+    params->has_multifd_qatzip_level = true;
+    params->has_multifd_qatzip_sw_fallback = true;
     params->has_multifd_zstd_level = true;
     params->has_xbzrle_cache_size = true;
     params->has_max_postcopy_bandwidth = true;
@@ -1038,6 +1074,14 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
         return false;
     }
 
+    if (params->has_multifd_qatzip_level &&
+        ((params->multifd_qatzip_level > 9) ||
+        (params->multifd_qatzip_level < 1))) {
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "multifd_qatzip_level",
+                   "a value between 1 and 9");
+        return false;
+    }
+
     if (params->has_multifd_zstd_level &&
         (params->multifd_zstd_level > 20)) {
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "multifd_zstd_level",
@@ -1195,6 +1239,12 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
     if (params->has_multifd_compression) {
         dest->multifd_compression = params->multifd_compression;
     }
+    if (params->has_multifd_qatzip_level) {
+        dest->multifd_qatzip_level = params->multifd_qatzip_level;
+    }
+    if (params->has_multifd_qatzip_sw_fallback) {
+        dest->multifd_qatzip_sw_fallback = params->multifd_qatzip_sw_fallback;
+    }
     if (params->has_multifd_zlib_level) {
         dest->multifd_zlib_level = params->multifd_zlib_level;
     }
@@ -1315,6 +1365,13 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
     if (params->has_multifd_compression) {
         s->parameters.multifd_compression = params->multifd_compression;
     }
+    if (params->has_multifd_qatzip_level) {
+        s->parameters.multifd_qatzip_level = params->multifd_qatzip_level;
+    }
+    if (params->has_multifd_qatzip_sw_fallback) {
+        s->parameters.multifd_qatzip_sw_fallback =
+            params->multifd_qatzip_sw_fallback;
+    }
     if (params->has_multifd_zlib_level) {
         s->parameters.multifd_zlib_level = params->multifd_zlib_level;
     }
diff --git a/migration/options.h b/migration/options.h
index a2397026db..24d98c6a29 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -78,6 +78,8 @@ uint64_t migrate_max_postcopy_bandwidth(void);
 int migrate_multifd_channels(void);
 MultiFDCompression migrate_multifd_compression(void);
 int migrate_multifd_zlib_level(void);
+int migrate_multifd_qatzip_level(void);
+bool migrate_multifd_qatzip_sw_fallback(void);
 int migrate_multifd_zstd_level(void);
 uint8_t migrate_throttle_trigger_threshold(void);
 const char *migrate_tls_authz(void);
diff --git a/qapi/migration.json b/qapi/migration.json
index 0f24206bce..8c9f2a8aa7 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -789,6 +789,16 @@
 #     speed, and 9 means best compression ratio which will consume
 #     more CPU. Defaults to 1.  (Since 5.0)
 #
+# @multifd-qatzip-level: Set the compression level to be used in live
+#     migration. The level is an integer between 1 and 9, where 1 means
+#     the best compression speed, and 9 means the best compression
+#     ratio which will consume more CPU. Defaults to 1. (Since 9.1)
+#
+# @multifd-qatzip-sw-fallback: Enable software fallback if QAT hardware
+#     is unavailable. Defaults to false. Software fallback performance
+#     is very poor compared to regular zlib, so be cautious about
+#     enabling this option. (Since 9.1)
+#
 # @multifd-zstd-level: Set the compression level to be used in live
 #     migration, the compression level is an integer between 0 and 20,
 #     where 0 means no compression, 1 means the best compression
@@ -849,6 +859,7 @@
            'xbzrle-cache-size', 'max-postcopy-bandwidth',
            'max-cpu-throttle', 'multifd-compression',
            'multifd-zlib-level', 'multifd-zstd-level',
+           'multifd-qatzip-level', 'multifd-qatzip-sw-fallback',
            'block-bitmap-mapping',
            { 'name': 'x-vcpu-dirty-limit-period', 'features': ['unstable'] },
            'vcpu-dirty-limit',
@@ -964,6 +975,16 @@
 #     speed, and 9 means best compression ratio which will consume
 #     more CPU. Defaults to 1.  (Since 5.0)
 #
+# @multifd-qatzip-level: Set the compression level to be used in live
+#     migration. The level is an integer between 1 and 9, where 1 means
+#     the best compression speed, and 9 means the best compression
+#     ratio which will consume more CPU. Defaults to 1. (Since 9.1)
+#
+# @multifd-qatzip-sw-fallback: Enable software fallback if QAT hardware
+#     is unavailable. Defaults to false. Software fallback performance
+#     is very poor compared to regular zlib, so be cautious about
+#     enabling this option. (Since 9.1)
+#
 # @multifd-zstd-level: Set the compression level to be used in live
 #     migration, the compression level is an integer between 0 and 20,
 #     where 0 means no compression, 1 means the best compression
@@ -1037,6 +1058,8 @@
             '*max-cpu-throttle': 'uint8',
             '*multifd-compression': 'MultiFDCompression',
             '*multifd-zlib-level': 'uint8',
+            '*multifd-qatzip-level': 'uint8',
+            '*multifd-qatzip-sw-fallback': 'bool',
             '*multifd-zstd-level': 'uint8',
             '*block-bitmap-mapping': [ 'BitmapMigrationNodeAlias' ],
             '*x-vcpu-dirty-limit-period': { 'type': 'uint64',
@@ -1168,6 +1191,16 @@
 #     speed, and 9 means best compression ratio which will consume
 #     more CPU. Defaults to 1.  (Since 5.0)
 #
+# @multifd-qatzip-level: Set the compression level to be used in live
+#     migration. The level is an integer between 1 and 9, where 1 means
+#     the best compression speed, and 9 means the best compression
+#     ratio which will consume more CPU. Defaults to 1. (Since 9.1)
+#
+# @multifd-qatzip-sw-fallback: Enable software fallback if QAT hardware
+#     is unavailable. Defaults to false. Software fallback performance
+#     is very poor compared to regular zlib, so be cautious about
+#     enabling this option. (Since 9.1)
+#
 # @multifd-zstd-level: Set the compression level to be used in live
 #     migration, the compression level is an integer between 0 and 20,
 #     where 0 means no compression, 1 means the best compression
@@ -1238,6 +1271,8 @@
             '*max-cpu-throttle': 'uint8',
             '*multifd-compression': 'MultiFDCompression',
             '*multifd-zlib-level': 'uint8',
+            '*multifd-qatzip-level': 'uint8',
+            '*multifd-qatzip-sw-fallback': 'bool',
             '*multifd-zstd-level': 'uint8',
             '*block-bitmap-mapping': [ 'BitmapMigrationNodeAlias' ],
             '*x-vcpu-dirty-limit-period': { 'type': 'uint64',
-- 
Yichen Wang


