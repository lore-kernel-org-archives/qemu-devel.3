Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 347BEC54E67
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 22:45:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpFWK-0006A1-9E; Tue, 26 Mar 2024 18:43:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bryan.zhang@bytedance.com>)
 id 1rpFWI-00069D-IE
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 18:43:50 -0400
Received: from mail-qk1-x72b.google.com ([2607:f8b0:4864:20::72b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bryan.zhang@bytedance.com>)
 id 1rpFWG-0007b3-CK
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 18:43:50 -0400
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-789e6f7f748so352077385a.3
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 15:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1711493027; x=1712097827; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QnG6eRKzWdMMY6J8vB7INPN8ux+bZX8gkkiNJp6OwR0=;
 b=WSYjkq87So8LvF1/mU+pPTMJqn+0mkEr0Iy9f00Hte+0tKX2bUpFh0o7UAd3ykZm3r
 w8USULIo8YRiRQpInQ1YzGWaf0yHN5E1430JwW0vRcOyFVkz4qPhR6W+3z3PrLPhjJDL
 FifhSaYyNE39PmLAXmOLZ4Hm5eXnhaiE/TRh2EA9RrwrdYeokWzMoD2UPlN8vVC87oPz
 atUB3e6luwQajR1SjsNQz/747Gd3pdcyQ+g5Cog2OWVZzniT2Wx7zjS6C1iNSFjL4EsW
 8lHrgHlCCDw4I+naLuW2YXVi295W3dHWHxaRuPhe0NLMsSUuDTwqtenRtKPSx9to7gGk
 cYSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711493027; x=1712097827;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QnG6eRKzWdMMY6J8vB7INPN8ux+bZX8gkkiNJp6OwR0=;
 b=KuSg+Z8vy2l1mjlLlTq406tByA+lz0K9TAI7rmSWij+JaEDqMecvD2eaOIFY3GS/Ij
 SETlHX6BMxANSp6N0rACo+CKXXqnTu7qBUL9fShcbyEuutrEQRwSXw2xJq2vbcuNP8LZ
 O0pWvCEzBKdU3TL4uBoLe/PXr2hYl0wk+obXL6z17+1vAyGFlbqBJ9mwBTfZmsgFtSkC
 znNOdK2oYrw/pKhLZ+bEdsKyOyJBkq+JscYyGwucnPyxMnrGHeUT/TYGnJSqPksk/l2R
 1tmNDCIk3VfCYd2vgdadiDy6MAB1K5YT39UuU7vU541qyQBQ/y2/eN+cUX2hQFrqTuaR
 GMbA==
X-Gm-Message-State: AOJu0YxLbsLcV4KF3XL9uhuk7UBtcYYGs6JAQOUVWV9E84R+jPF/Kn39
 cmnnwASlMx4Z3zwe0osQuLBOU70c1oFCewleqSrDuuJQxVD7Y1KfbpMYXgip3IbH8jPp+PawGM8
 z
X-Google-Smtp-Source: AGHT+IHqJyVNPKlq2fcCaqqWUKO5DO2lWK9t67D8Y8osn48gUEBRki3rOodRcwBrT7Ovj2K/HUTr5Q==
X-Received: by 2002:a05:620a:44c4:b0:789:e524:933b with SMTP id
 y4-20020a05620a44c400b00789e524933bmr2950044qkp.31.1711493026968; 
 Tue, 26 Mar 2024 15:43:46 -0700 (PDT)
Received: from n36-186-108.byted.org. ([147.160.184.146])
 by smtp.gmail.com with ESMTPSA id
 x15-20020a05620a0ecf00b007887d30dbb7sm3397816qkm.60.2024.03.26.15.43.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Mar 2024 15:43:46 -0700 (PDT)
From: Bryan Zhang <bryan.zhang@bytedance.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, yuan1.liu@intel.com,
 berrange@redhat.com, nanhai.zou@intel.com, hao.xiang@linux.dev,
 Bryan Zhang <bryan.zhang@bytedance.com>
Subject: [PATCH v2 2/5] migration: Add migration parameters for QATzip
Date: Tue, 26 Mar 2024 22:42:18 +0000
Message-Id: <20240326224221.3623014-3-bryan.zhang@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240326224221.3623014-1-bryan.zhang@bytedance.com>
References: <20240326224221.3623014-1-bryan.zhang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72b;
 envelope-from=bryan.zhang@bytedance.com; helo=mail-qk1-x72b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Adds support for migration parameters to control QATzip compression
level and to enable/disable software fallback when QAT hardware is
unavailable. This is a preparatory commit for a subsequent commit that
will actually use QATzip compression.

Signed-off-by: Bryan Zhang <bryan.zhang@bytedance.com>
Signed-off-by: Hao Xiang <hao.xiang@linux.dev>
---
Revision: This commit now includes a parameter for controlling software
fallback. Fallback is generally intended to be disabled, but having this
option available enables using software fallback for testing.

This commit also now has some glue code to properly set parameters.

 migration/migration-hmp-cmds.c |  8 +++++
 migration/options.c            | 57 ++++++++++++++++++++++++++++++++++
 migration/options.h            |  2 ++
 qapi/migration.json            | 35 +++++++++++++++++++++
 4 files changed, 102 insertions(+)

diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 99b49df5dd..4bd23ba14d 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -630,6 +630,14 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
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
index 3e3e0b93b4..1316ea605a 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -62,6 +62,15 @@
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
 
@@ -143,6 +152,12 @@ Property migration_properties[] = {
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
@@ -861,6 +876,20 @@ int migrate_multifd_zlib_level(void)
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
@@ -983,6 +1012,11 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
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
@@ -1038,6 +1072,8 @@ void migrate_params_init(MigrationParameters *params)
     params->has_multifd_channels = true;
     params->has_multifd_compression = true;
     params->has_multifd_zlib_level = true;
+    params->has_multifd_qatzip_level = true;
+    params->has_multifd_qatzip_sw_fallback = true;
     params->has_multifd_zstd_level = true;
     params->has_xbzrle_cache_size = true;
     params->has_max_postcopy_bandwidth = true;
@@ -1147,6 +1183,14 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
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
@@ -1312,6 +1356,12 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
     if (params->has_multifd_compression) {
         dest->multifd_compression = params->multifd_compression;
     }
+    if (params->has_multifd_qatzip_level) {
+        dest->multifd_qatzip_level = params->multifd_qatzip_level;
+    }
+    if (params->has_multifd_qatzip_sw_fallback) {
+        dest->multifd_qatzip_sw_fallback = params->multifd_qatzip_sw_fallback;
+    }
     if (params->has_xbzrle_cache_size) {
         dest->xbzrle_cache_size = params->xbzrle_cache_size;
     }
@@ -1447,6 +1497,13 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
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
     if (params->has_xbzrle_cache_size) {
         s->parameters.xbzrle_cache_size = params->xbzrle_cache_size;
         xbzrle_cache_resize(params->xbzrle_cache_size, errp);
diff --git a/migration/options.h b/migration/options.h
index 246c160aee..94aee24d97 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -87,6 +87,8 @@ MigMode migrate_mode(void);
 int migrate_multifd_channels(void);
 MultiFDCompression migrate_multifd_compression(void);
 int migrate_multifd_zlib_level(void);
+int migrate_multifd_qatzip_level(void);
+bool migrate_multifd_qatzip_sw_fallback(void);
 int migrate_multifd_zstd_level(void);
 uint8_t migrate_throttle_trigger_threshold(void);
 const char *migrate_tls_authz(void);
diff --git a/qapi/migration.json b/qapi/migration.json
index 0b33a71ab4..66ea6d32fc 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -853,6 +853,16 @@
 #     speed, and 9 means best compression ratio which will consume
 #     more CPU. Defaults to 1. (Since 5.0)
 #
+# @multifd-qatzip-level: Set the compression level to be used in live
+#     migration. The level is an integer between 1 and 9, where 1 means
+#     the best compression speed, and 9 means the best compression
+#     ratio which will consume more CPU. Defaults to 1.
+#
+# @multifd-qatzip-sw-fallback: Enable software fallback if QAT hardware
+#     is unavailable. Defaults to false. Software fallback performance
+#     is very poor compared to regular zlib, so be cautious about
+#     enabling this option.
+#
 # @multifd-zstd-level: Set the compression level to be used in live
 #     migration, the compression level is an integer between 0 and 20,
 #     where 0 means no compression, 1 means the best compression
@@ -915,6 +925,7 @@
            'xbzrle-cache-size', 'max-postcopy-bandwidth',
            'max-cpu-throttle', 'multifd-compression',
            'multifd-zlib-level', 'multifd-zstd-level',
+           'multifd-qatzip-level', 'multifd-qatzip-sw-fallback',
            'block-bitmap-mapping',
            { 'name': 'x-vcpu-dirty-limit-period', 'features': ['unstable'] },
            'vcpu-dirty-limit',
@@ -1045,6 +1056,16 @@
 #     speed, and 9 means best compression ratio which will consume
 #     more CPU. Defaults to 1. (Since 5.0)
 #
+# @multifd-qatzip-level: Set the compression level to be used in live
+#     migration. The level is an integer between 1 and 9, where 1 means
+#     the best compression speed, and 9 means the best compression
+#     ratio which will consume more CPU. Defaults to 1.
+#
+# @multifd-qatzip-sw-fallback: Enable software fallback if QAT hardware
+#     is unavailable. Defaults to false. Software fallback performance
+#     is very poor compared to regular zlib, so be cautious about
+#     enabling this option.
+#
 # @multifd-zstd-level: Set the compression level to be used in live
 #     migration, the compression level is an integer between 0 and 20,
 #     where 0 means no compression, 1 means the best compression
@@ -1125,6 +1146,8 @@
             '*max-cpu-throttle': 'uint8',
             '*multifd-compression': 'MultiFDCompression',
             '*multifd-zlib-level': 'uint8',
+            '*multifd-qatzip-level': 'uint8',
+            '*multifd-qatzip-sw-fallback': 'bool',
             '*multifd-zstd-level': 'uint8',
             '*block-bitmap-mapping': [ 'BitmapMigrationNodeAlias' ],
             '*x-vcpu-dirty-limit-period': { 'type': 'uint64',
@@ -1273,6 +1296,16 @@
 #     speed, and 9 means best compression ratio which will consume
 #     more CPU. Defaults to 1. (Since 5.0)
 #
+# @multifd-qatzip-level: Set the compression level to be used in live
+#     migration. The level is an integer between 1 and 9, where 1 means
+#     the best compression speed, and 9 means the best compression
+#     ratio which will consume more CPU. Defaults to 1.
+#
+# @multifd-qatzip-sw-fallback: Enable software fallback if QAT hardware
+#     is unavailable. Defaults to false. Software fallback performance
+#     is very poor compared to regular zlib, so be cautious about
+#     enabling this option.
+#
 # @multifd-zstd-level: Set the compression level to be used in live
 #     migration, the compression level is an integer between 0 and 20,
 #     where 0 means no compression, 1 means the best compression
@@ -1350,6 +1383,8 @@
             '*max-cpu-throttle': 'uint8',
             '*multifd-compression': 'MultiFDCompression',
             '*multifd-zlib-level': 'uint8',
+            '*multifd-qatzip-level': 'uint8',
+            '*multifd-qatzip-sw-fallback': 'bool',
             '*multifd-zstd-level': 'uint8',
             '*block-bitmap-mapping': [ 'BitmapMigrationNodeAlias' ],
             '*x-vcpu-dirty-limit-period': { 'type': 'uint64',
-- 
2.30.2


