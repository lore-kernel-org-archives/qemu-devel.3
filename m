Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C140ECE588
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 20:13:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snkk6-0000ir-0B; Mon, 09 Sep 2024 16:12:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1snkk4-0000dD-Du
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 16:12:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1snkk2-00053O-EQ
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 16:12:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725912725;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zyF+uB2XFDTWxO0PkzZtc9eGB9NRgyi0toAwC4na6TY=;
 b=ic7mX/jYSzQp6eClJGjpytw/F4/HMaAtz3WwSCWZshZDrCFHjTOMOgOJzca7SRvfla+BAY
 8GNFvS4qYXE5jD3lJBJ6kcyMQoWTN4LQXDEeksEs+EkIg9R66m1mas8nR6ySivFcNTi2si
 OVGAI+7QWa03Rx66aR6FXXilrQ05O1I=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-446-gzn0EMHlOU-oQQAjoEQg7Q-1; Mon, 09 Sep 2024 16:12:04 -0400
X-MC-Unique: gzn0EMHlOU-oQQAjoEQg7Q-1
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-3e04ec0155dso208797b6e.0
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 13:12:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725912723; x=1726517523;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zyF+uB2XFDTWxO0PkzZtc9eGB9NRgyi0toAwC4na6TY=;
 b=BREVmDyVj+e0rRhANxHc1yD8OwKFzaomqyZ2AbRHzCCwseBJf5fWeSQUu2Z5uawWm3
 iZI6WAQ1nd5LNdu5/P1bydf0xGQfbmyXeHdNbR93YH7o2Q8eLvexCxfmXFuO/xP5sxtn
 DmFnMYYbeBwjj7FQ2abFH4L8zZcnuB6m7Dzg3R9bQTY2mjaSIlVBrFuAhi87GGF7mPtB
 DxvO7nMxtWuh1S4zv6sjeVB5D5vRx99SmdxH8dvN7U+dKr7NqmQgkH21sJiQdJuXiYyS
 1rInVf01FsWhVTI7SqaTjhB1Mqb0+p+jcjs0XzTgpffFg23MvpsFLpXGIDI+KEzr2F4x
 7GpQ==
X-Gm-Message-State: AOJu0Yw5V8t6ZwQZ6MGzOu1yQTjZEfkFnyuI5fH/chqna35QLMwb5b02
 BRkKCTeZ18hAZ2xTG2pNybbxg5NKZQM8pvZway7oBI+HsEsX0j6WtsTtRSqrwNYkaZg+QKOKxJd
 H11dj6tZJn5sC2A7FVlhTM8j3FdDxrDt/sxaW50hyFyzLIiN9LhLPh57McIxCv51h/MbFzyh4kK
 7/egQfRxSQSalD/ar4WrAN/FeP755XPDJMhA==
X-Received: by 2002:a05:6808:1889:b0:3db:1516:2bcc with SMTP id
 5614622812f47-3e037ae4badmr5722542b6e.31.1725912722985; 
 Mon, 09 Sep 2024 13:12:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIaqtkXI8xWWU00jT15xA39fI+oshHeb894QR6JyHUUl5dqe7a/eym2PXiK2Fe0YWpjikALQ==
X-Received: by 2002:a05:6808:1889:b0:3db:1516:2bcc with SMTP id
 5614622812f47-3e037ae4badmr5722501b6e.31.1725912722425; 
 Mon, 09 Sep 2024 13:12:02 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45822f93978sm22838561cf.83.2024.09.09.13.12.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 13:12:00 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Bryan Zhang <bryan.zhang@bytedance.com>,
 Markus Armbruster <armbru@redhat.com>, Hao Xiang <hao.xiang@linux.dev>,
 Yichen Wang <yichen.wang@bytedance.com>,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: [PULL 6/9] migration: Add migration parameters for QATzip
Date: Mon,  9 Sep 2024 16:11:44 -0400
Message-ID: <20240909201147.3761639-7-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240909201147.3761639-1-peterx@redhat.com>
References: <20240909201147.3761639-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
level.

Acked-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Bryan Zhang <bryan.zhang@bytedance.com>
Signed-off-by: Hao Xiang <hao.xiang@linux.dev>
Signed-off-by: Yichen Wang <yichen.wang@bytedance.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>
Link: https://lore.kernel.org/r/20240830232722.58272-4-yichen.wang@bytedance.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 qapi/migration.json            | 18 ++++++++++++++++++
 migration/options.h            |  1 +
 migration/migration-hmp-cmds.c |  4 ++++
 migration/options.c            | 34 ++++++++++++++++++++++++++++++++++
 4 files changed, 57 insertions(+)

diff --git a/qapi/migration.json b/qapi/migration.json
index 7324571e92..f4c27426c8 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -792,6 +792,11 @@
 #     speed, and 9 means best compression ratio which will consume
 #     more CPU.  Defaults to 1.  (Since 5.0)
 #
+# @multifd-qatzip-level: Set the compression level to be used in live
+#     migration. The level is an integer between 1 and 9, where 1 means
+#     the best compression speed, and 9 means the best compression
+#     ratio which will consume more CPU. Defaults to 1.  (Since 9.2)
+#
 # @multifd-zstd-level: Set the compression level to be used in live
 #     migration, the compression level is an integer between 0 and 20,
 #     where 0 means no compression, 1 means the best compression
@@ -852,6 +857,7 @@
            'xbzrle-cache-size', 'max-postcopy-bandwidth',
            'max-cpu-throttle', 'multifd-compression',
            'multifd-zlib-level', 'multifd-zstd-level',
+           'multifd-qatzip-level',
            'block-bitmap-mapping',
            { 'name': 'x-vcpu-dirty-limit-period', 'features': ['unstable'] },
            'vcpu-dirty-limit',
@@ -967,6 +973,11 @@
 #     speed, and 9 means best compression ratio which will consume
 #     more CPU.  Defaults to 1.  (Since 5.0)
 #
+# @multifd-qatzip-level: Set the compression level to be used in live
+#     migration. The level is an integer between 1 and 9, where 1 means
+#     the best compression speed, and 9 means the best compression
+#     ratio which will consume more CPU. Defaults to 1.  (Since 9.2)
+#
 # @multifd-zstd-level: Set the compression level to be used in live
 #     migration, the compression level is an integer between 0 and 20,
 #     where 0 means no compression, 1 means the best compression
@@ -1040,6 +1051,7 @@
             '*max-cpu-throttle': 'uint8',
             '*multifd-compression': 'MultiFDCompression',
             '*multifd-zlib-level': 'uint8',
+            '*multifd-qatzip-level': 'uint8',
             '*multifd-zstd-level': 'uint8',
             '*block-bitmap-mapping': [ 'BitmapMigrationNodeAlias' ],
             '*x-vcpu-dirty-limit-period': { 'type': 'uint64',
@@ -1171,6 +1183,11 @@
 #     speed, and 9 means best compression ratio which will consume
 #     more CPU.  Defaults to 1.  (Since 5.0)
 #
+# @multifd-qatzip-level: Set the compression level to be used in live
+#     migration. The level is an integer between 1 and 9, where 1 means
+#     the best compression speed, and 9 means the best compression
+#     ratio which will consume more CPU. Defaults to 1.  (Since 9.2)
+#
 # @multifd-zstd-level: Set the compression level to be used in live
 #     migration, the compression level is an integer between 0 and 20,
 #     where 0 means no compression, 1 means the best compression
@@ -1241,6 +1258,7 @@
             '*max-cpu-throttle': 'uint8',
             '*multifd-compression': 'MultiFDCompression',
             '*multifd-zlib-level': 'uint8',
+            '*multifd-qatzip-level': 'uint8',
             '*multifd-zstd-level': 'uint8',
             '*block-bitmap-mapping': [ 'BitmapMigrationNodeAlias' ],
             '*x-vcpu-dirty-limit-period': { 'type': 'uint64',
diff --git a/migration/options.h b/migration/options.h
index a2397026db..a0bd6edc06 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -78,6 +78,7 @@ uint64_t migrate_max_postcopy_bandwidth(void);
 int migrate_multifd_channels(void);
 MultiFDCompression migrate_multifd_compression(void);
 int migrate_multifd_zlib_level(void);
+int migrate_multifd_qatzip_level(void);
 int migrate_multifd_zstd_level(void);
 uint8_t migrate_throttle_trigger_threshold(void);
 const char *migrate_tls_authz(void);
diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 7d608d26e1..28165cfc9e 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -576,6 +576,10 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
         p->has_multifd_zlib_level = true;
         visit_type_uint8(v, param, &p->multifd_zlib_level, &err);
         break;
+    case MIGRATION_PARAMETER_MULTIFD_QATZIP_LEVEL:
+        p->has_multifd_qatzip_level = true;
+        visit_type_uint8(v, param, &p->multifd_qatzip_level, &err);
+        break;
     case MIGRATION_PARAMETER_MULTIFD_ZSTD_LEVEL:
         p->has_multifd_zstd_level = true;
         visit_type_uint8(v, param, &p->multifd_zstd_level, &err);
diff --git a/migration/options.c b/migration/options.c
index 645f55003d..147cd2b8fd 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -55,6 +55,13 @@
 #define DEFAULT_MIGRATE_MULTIFD_COMPRESSION MULTIFD_COMPRESSION_NONE
 /* 0: means nocompress, 1: best speed, ... 9: best compress ratio */
 #define DEFAULT_MIGRATE_MULTIFD_ZLIB_LEVEL 1
+/*
+ * 1: best speed, ... 9: best compress ratio
+ * There is some nuance here. Refer to QATzip documentation to understand
+ * the mapping of QATzip levels to standard deflate levels.
+ */
+#define DEFAULT_MIGRATE_MULTIFD_QATZIP_LEVEL 1
+
 /* 0: means nocompress, 1: best speed, ... 20: best compress ratio */
 #define DEFAULT_MIGRATE_MULTIFD_ZSTD_LEVEL 1
 
@@ -123,6 +130,9 @@ Property migration_properties[] = {
     DEFINE_PROP_UINT8("multifd-zlib-level", MigrationState,
                       parameters.multifd_zlib_level,
                       DEFAULT_MIGRATE_MULTIFD_ZLIB_LEVEL),
+    DEFINE_PROP_UINT8("multifd-qatzip-level", MigrationState,
+                      parameters.multifd_qatzip_level,
+                      DEFAULT_MIGRATE_MULTIFD_QATZIP_LEVEL),
     DEFINE_PROP_UINT8("multifd-zstd-level", MigrationState,
                       parameters.multifd_zstd_level,
                       DEFAULT_MIGRATE_MULTIFD_ZSTD_LEVEL),
@@ -787,6 +797,13 @@ int migrate_multifd_zlib_level(void)
     return s->parameters.multifd_zlib_level;
 }
 
+int migrate_multifd_qatzip_level(void)
+{
+    MigrationState *s = migrate_get_current();
+
+    return s->parameters.multifd_qatzip_level;
+}
+
 int migrate_multifd_zstd_level(void)
 {
     MigrationState *s = migrate_get_current();
@@ -892,6 +909,8 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
     params->multifd_compression = s->parameters.multifd_compression;
     params->has_multifd_zlib_level = true;
     params->multifd_zlib_level = s->parameters.multifd_zlib_level;
+    params->has_multifd_qatzip_level = true;
+    params->multifd_qatzip_level = s->parameters.multifd_qatzip_level;
     params->has_multifd_zstd_level = true;
     params->multifd_zstd_level = s->parameters.multifd_zstd_level;
     params->has_xbzrle_cache_size = true;
@@ -946,6 +965,7 @@ void migrate_params_init(MigrationParameters *params)
     params->has_multifd_channels = true;
     params->has_multifd_compression = true;
     params->has_multifd_zlib_level = true;
+    params->has_multifd_qatzip_level = true;
     params->has_multifd_zstd_level = true;
     params->has_xbzrle_cache_size = true;
     params->has_max_postcopy_bandwidth = true;
@@ -1038,6 +1058,14 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
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
@@ -1195,6 +1223,9 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
     if (params->has_multifd_compression) {
         dest->multifd_compression = params->multifd_compression;
     }
+    if (params->has_multifd_qatzip_level) {
+        dest->multifd_qatzip_level = params->multifd_qatzip_level;
+    }
     if (params->has_multifd_zlib_level) {
         dest->multifd_zlib_level = params->multifd_zlib_level;
     }
@@ -1315,6 +1346,9 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
     if (params->has_multifd_compression) {
         s->parameters.multifd_compression = params->multifd_compression;
     }
+    if (params->has_multifd_qatzip_level) {
+        s->parameters.multifd_qatzip_level = params->multifd_qatzip_level;
+    }
     if (params->has_multifd_zlib_level) {
         s->parameters.multifd_zlib_level = params->multifd_zlib_level;
     }
-- 
2.45.0


