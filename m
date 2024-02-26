Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31C1FC48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 19:59:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reh6u-00012i-Et; Mon, 26 Feb 2024 14:58:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1reh6m-0000yj-Tm
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 14:57:53 -0500
Received: from mail-vk1-xa30.google.com ([2607:f8b0:4864:20::a30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1reh6k-0004tk-L0
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 14:57:52 -0500
Received: by mail-vk1-xa30.google.com with SMTP id
 71dfb90a1353d-4cb26623d0aso809017e0c.1
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 11:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1708977469; x=1709582269; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZgDjuALvbSevFWEfp0Xrz/jY7qt4RLoP+bPDhImpo/k=;
 b=VsbAA6lYtbS7rugZBrrV+RWXL+77F4qc8Fs1eMiazc1Vs0jh/6R9nLhKXg6exjeZg5
 M/DMxQBaqNsXyDs94hIIToOzvjoRvNC5NG5hhDJo3GwDSEMqCvHhy72NH0msB62SGi9I
 PYDFi9Q4AJtOMgVfK1DjKV++cniLR3HRrvCR59IXAPEFU3YwXdoGeIYT6BZ+GKjRqDJg
 C9WK5Dy/NOTrqnS2MHSajQQGUkWis5/ZEvyXzg7AI9Y19CaTmi5aq639mlOg28j8ZW3K
 6SOK8bldE7GVPX6KQN34+ZYgtFmlBvO4yBbEzW+y9Ez+ugdtDmhC7d9arUSe1A89TdyE
 kt+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708977469; x=1709582269;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZgDjuALvbSevFWEfp0Xrz/jY7qt4RLoP+bPDhImpo/k=;
 b=U0I0y5BhKHW2eMe2ysLbVvOFwFGDFJUCZnEw9TQtwWsQbTBWXm7Ihbd2MH790Yj/vP
 fnrBeQYGPN6JqJEMKFB0ChwGfBqhjthyz2A7ECEFSF3GSA5/7hTNNMCCzUJxghfTyoZc
 KsKfA3LL/+krFKS6Gpum1YRfm1WXF69uNYLntKzxF/+z2eJZWGblF9pa1Qr4qKi/y2J7
 ELlQ7g2iscem/vh+h5AG5/HBPHMqYlQOOsKpCy8GAAjKJjgA5ehYpK57XTDKZzucdYBe
 t9PUBnQRSY712+tp4RfbDgWnwymDnh1KhpnI9WYHoWMnkxZ+Pd0mEcZ4/rf+i71dsvit
 NypQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfQuiJ1NDoyYIFz8GWyUj3sweUSCRbTkBDJgqA60Dgc49IT6VdPr2if6EbL4JU/fA0Cltf4Ud5GoUwm7554HGOrad6/hk=
X-Gm-Message-State: AOJu0YzNcHCHVCFIyfzmH9deB89E5KvQlkNjN2FOt4Q4kL8RXGnt1P/O
 a/nUVTLNmy4wa95BNe3jca+wzuPt3xthO6UrIc31HsoT8BSXBjgXkxBu3Sqreqo=
X-Google-Smtp-Source: AGHT+IF96s81tLbr+OkLEguOKeJ2SwaPlPN5oDO+/nB5jtBRiMfnlJsTGNwBA86UIrNMiPycO6u+KQ==
X-Received: by 2002:a1f:48c3:0:b0:4c9:98f8:83d7 with SMTP id
 v186-20020a1f48c3000000b004c998f883d7mr4354080vka.0.1708977469029; 
 Mon, 26 Feb 2024 11:57:49 -0800 (PST)
Received: from n231-230-216.byted.org ([130.44.212.95])
 by smtp.gmail.com with ESMTPSA id
 ej5-20020a056122270500b004ca3dc45886sm712738vkb.47.2024.02.26.11.57.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Feb 2024 11:57:48 -0800 (PST)
From: Hao Xiang <hao.xiang@bytedance.com>
To: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 peterx@redhat.com, farosas@suse.de, eblake@redhat.com, armbru@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, jdenemar@redhat.com,
 marcel.apfelbaum@gmail.com, philmd@linaro.org, wangyanan55@huawei.com,
 qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@bytedance.com>
Subject: [PATCH v3 1/7] migration/multifd: Add new migration option
 zero-page-detection.
Date: Mon, 26 Feb 2024 19:56:48 +0000
Message-Id: <20240226195654.934709-2-hao.xiang@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240226195654.934709-1-hao.xiang@bytedance.com>
References: <20240226195654.934709-1-hao.xiang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::a30;
 envelope-from=hao.xiang@bytedance.com; helo=mail-vk1-xa30.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This new parameter controls where the zero page checking is running.
1. If this parameter is set to 'legacy', zero page checking is
done in the migration main thread.
2. If this parameter is set to 'none', zero page checking is disabled.

Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
---
 hw/core/qdev-properties-system.c    | 10 ++++++++++
 include/hw/qdev-properties-system.h |  4 ++++
 migration/migration-hmp-cmds.c      |  9 +++++++++
 migration/options.c                 | 21 ++++++++++++++++++++
 migration/options.h                 |  1 +
 migration/ram.c                     |  4 ++++
 qapi/migration.json                 | 30 ++++++++++++++++++++++++++---
 7 files changed, 76 insertions(+), 3 deletions(-)

diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index 1a396521d5..228e685f52 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -679,6 +679,16 @@ const PropertyInfo qdev_prop_mig_mode = {
     .set_default_value = qdev_propinfo_set_default_value_enum,
 };
 
+const PropertyInfo qdev_prop_zero_page_detection = {
+    .name = "ZeroPageDetection",
+    .description = "zero_page_detection values, "
+                   "none,legacy",
+    .enum_table = &ZeroPageDetection_lookup,
+    .get = qdev_propinfo_get_enum,
+    .set = qdev_propinfo_set_enum,
+    .set_default_value = qdev_propinfo_set_default_value_enum,
+};
+
 /* --- Reserved Region --- */
 
 /*
diff --git a/include/hw/qdev-properties-system.h b/include/hw/qdev-properties-system.h
index 06c359c190..839b170235 100644
--- a/include/hw/qdev-properties-system.h
+++ b/include/hw/qdev-properties-system.h
@@ -8,6 +8,7 @@ extern const PropertyInfo qdev_prop_macaddr;
 extern const PropertyInfo qdev_prop_reserved_region;
 extern const PropertyInfo qdev_prop_multifd_compression;
 extern const PropertyInfo qdev_prop_mig_mode;
+extern const PropertyInfo qdev_prop_zero_page_detection;
 extern const PropertyInfo qdev_prop_losttickpolicy;
 extern const PropertyInfo qdev_prop_blockdev_on_error;
 extern const PropertyInfo qdev_prop_bios_chs_trans;
@@ -47,6 +48,9 @@ extern const PropertyInfo qdev_prop_iothread_vq_mapping_list;
 #define DEFINE_PROP_MIG_MODE(_n, _s, _f, _d) \
     DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_mig_mode, \
                        MigMode)
+#define DEFINE_PROP_ZERO_PAGE_DETECTION(_n, _s, _f, _d) \
+    DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_zero_page_detection, \
+                       ZeroPageDetection)
 #define DEFINE_PROP_LOSTTICKPOLICY(_n, _s, _f, _d) \
     DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_losttickpolicy, \
                         LostTickPolicy)
diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 99b49df5dd..7e96ae6ffd 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -344,6 +344,11 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
         monitor_printf(mon, "%s: %s\n",
             MigrationParameter_str(MIGRATION_PARAMETER_MULTIFD_COMPRESSION),
             MultiFDCompression_str(params->multifd_compression));
+        assert(params->has_zero_page_detection);
+        monitor_printf(mon, "%s: %s\n",
+            MigrationParameter_str(MIGRATION_PARAMETER_ZERO_PAGE_DETECTION),
+            qapi_enum_lookup(&ZeroPageDetection_lookup,
+                params->zero_page_detection));
         monitor_printf(mon, "%s: %" PRIu64 " bytes\n",
             MigrationParameter_str(MIGRATION_PARAMETER_XBZRLE_CACHE_SIZE),
             params->xbzrle_cache_size);
@@ -634,6 +639,10 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
         p->has_multifd_zstd_level = true;
         visit_type_uint8(v, param, &p->multifd_zstd_level, &err);
         break;
+    case MIGRATION_PARAMETER_ZERO_PAGE_DETECTION:
+        p->has_zero_page_detection = true;
+        visit_type_ZeroPageDetection(v, param, &p->zero_page_detection, &err);
+        break;
     case MIGRATION_PARAMETER_XBZRLE_CACHE_SIZE:
         p->has_xbzrle_cache_size = true;
         if (!visit_type_size(v, param, &cache_size, &err)) {
diff --git a/migration/options.c b/migration/options.c
index 3e3e0b93b4..3c603391b0 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -179,6 +179,9 @@ Property migration_properties[] = {
     DEFINE_PROP_MIG_MODE("mode", MigrationState,
                       parameters.mode,
                       MIG_MODE_NORMAL),
+    DEFINE_PROP_ZERO_PAGE_DETECTION("zero-page-detection", MigrationState,
+                       parameters.zero_page_detection,
+                       ZERO_PAGE_DETECTION_LEGACY),
 
     /* Migration capabilities */
     DEFINE_PROP_MIG_CAP("x-xbzrle", MIGRATION_CAPABILITY_XBZRLE),
@@ -903,6 +906,13 @@ uint64_t migrate_xbzrle_cache_size(void)
     return s->parameters.xbzrle_cache_size;
 }
 
+ZeroPageDetection migrate_zero_page_detection(void)
+{
+    MigrationState *s = migrate_get_current();
+
+    return s->parameters.zero_page_detection;
+}
+
 /* parameter setters */
 
 void migrate_set_block_incremental(bool value)
@@ -1013,6 +1023,8 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
     params->vcpu_dirty_limit = s->parameters.vcpu_dirty_limit;
     params->has_mode = true;
     params->mode = s->parameters.mode;
+    params->has_zero_page_detection = true;
+    params->zero_page_detection = s->parameters.zero_page_detection;
 
     return params;
 }
@@ -1049,6 +1061,7 @@ void migrate_params_init(MigrationParameters *params)
     params->has_x_vcpu_dirty_limit_period = true;
     params->has_vcpu_dirty_limit = true;
     params->has_mode = true;
+    params->has_zero_page_detection = true;
 }
 
 /*
@@ -1350,6 +1363,10 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
     if (params->has_mode) {
         dest->mode = params->mode;
     }
+
+    if (params->has_zero_page_detection) {
+        dest->zero_page_detection = params->zero_page_detection;
+    }
 }
 
 static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
@@ -1494,6 +1511,10 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
     if (params->has_mode) {
         s->parameters.mode = params->mode;
     }
+
+    if (params->has_zero_page_detection) {
+        s->parameters.zero_page_detection = params->zero_page_detection;
+    }
 }
 
 void qmp_migrate_set_parameters(MigrateSetParameters *params, Error **errp)
diff --git a/migration/options.h b/migration/options.h
index 246c160aee..b7c4fb3861 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -93,6 +93,7 @@ const char *migrate_tls_authz(void);
 const char *migrate_tls_creds(void);
 const char *migrate_tls_hostname(void);
 uint64_t migrate_xbzrle_cache_size(void);
+ZeroPageDetection migrate_zero_page_detection(void);
 
 /* parameters setters */
 
diff --git a/migration/ram.c b/migration/ram.c
index 4649a81204..67035fb4b1 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1123,6 +1123,10 @@ static int save_zero_page(RAMState *rs, PageSearchStatus *pss,
     QEMUFile *file = pss->pss_channel;
     int len = 0;
 
+    if (migrate_zero_page_detection() == ZERO_PAGE_DETECTION_NONE) {
+        return 0;
+    }
+
     if (!buffer_is_zero(p, TARGET_PAGE_SIZE)) {
         return 0;
     }
diff --git a/qapi/migration.json b/qapi/migration.json
index 5a565d9b8d..1e66272f8f 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -653,6 +653,18 @@
 { 'enum': 'MigMode',
   'data': [ 'normal', 'cpr-reboot' ] }
 
+##
+# @ZeroPageDetection:
+#
+# @none: Do not perform zero page checking.
+#
+# @legacy: Perform zero page checking from main migration thread.
+#
+# Since: 9.0
+##
+{ 'enum': 'ZeroPageDetection',
+  'data': [ 'none', 'legacy' ] }
+
 ##
 # @BitmapMigrationBitmapAliasTransform:
 #
@@ -874,6 +886,9 @@
 # @mode: Migration mode. See description in @MigMode. Default is 'normal'.
 #        (Since 8.2)
 #
+# @zero-page-detection: Whether and how to detect zero pages. More details
+#     see description in @ZeroPageDetection. Default is 'legacy'.  (since 9.0)
+#
 # Features:
 #
 # @deprecated: Member @block-incremental is deprecated.  Use
@@ -907,7 +922,8 @@
            'block-bitmap-mapping',
            { 'name': 'x-vcpu-dirty-limit-period', 'features': ['unstable'] },
            'vcpu-dirty-limit',
-           'mode'] }
+           'mode',
+           'zero-page-detection'] }
 
 ##
 # @MigrateSetParameters:
@@ -1066,6 +1082,9 @@
 # @mode: Migration mode. See description in @MigMode. Default is 'normal'.
 #        (Since 8.2)
 #
+# @zero-page-detection: Whether and how to detect zero pages. More details
+#     see description in @ZeroPageDetection. Default is 'legacy'.  (since 9.0)
+#
 # Features:
 #
 # @deprecated: Member @block-incremental is deprecated.  Use
@@ -1119,7 +1138,8 @@
             '*x-vcpu-dirty-limit-period': { 'type': 'uint64',
                                             'features': [ 'unstable' ] },
             '*vcpu-dirty-limit': 'uint64',
-            '*mode': 'MigMode'} }
+            '*mode': 'MigMode',
+            '*zero-page-detection': 'ZeroPageDetection'} }
 
 ##
 # @migrate-set-parameters:
@@ -1294,6 +1314,9 @@
 # @mode: Migration mode. See description in @MigMode. Default is 'normal'.
 #        (Since 8.2)
 #
+# @zero-page-detection: Whether and how to detect zero pages. More details
+#     see description in @ZeroPageDetection. Default is 'legacy'.  (since 9.0)
+#
 # Features:
 #
 # @deprecated: Member @block-incremental is deprecated.  Use
@@ -1344,7 +1367,8 @@
             '*x-vcpu-dirty-limit-period': { 'type': 'uint64',
                                             'features': [ 'unstable' ] },
             '*vcpu-dirty-limit': 'uint64',
-            '*mode': 'MigMode'} }
+            '*mode': 'MigMode',
+            '*zero-page-detection': 'ZeroPageDetection'} }
 
 ##
 # @query-migrate-parameters:
-- 
2.30.2


