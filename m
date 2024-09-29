Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42A81CF6495
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Sep 2024 17:15:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1suxVV-0007jH-Un; Sun, 29 Sep 2024 13:14:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1suxVS-0007gH-MW
 for qemu-devel@nongnu.org; Sun, 29 Sep 2024 13:14:50 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1suxVQ-0003Zc-R5
 for qemu-devel@nongnu.org; Sun, 29 Sep 2024 13:14:50 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-7db90a28cf6so3274122a12.0
 for <qemu-devel@nongnu.org>; Sun, 29 Sep 2024 10:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1727630087; x=1728234887;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=07wA5zG/1d+R2WMpD9te0aExZ2w/43FEpg9CjU1sU5s=;
 b=Mz0cdj8+JXR5XZyZx32HGRm5YMjb9G3iZLKIa189iuS1OiiyCuovNAUE7kV4B9yX9/
 sMe5jJaJbFu/uUbwKnoAAVHkYTU6cHUq5VdXRxEyuJWHY+L0BeDGdzzbC7C8wa9p59Ri
 jdpUy8R6YOznKBK3gEwYhMmm9cQg+0eQT4rFqCixaVn3DCkjrCbTgO4YQdAuv6cGbYDv
 962GGqtzOc6TKdh4qBXj/4Rd/x/elrBOgXKwl7RgC4xYG1TDqa/FwZnh7alS81W4ODmh
 bccRJRVhQxx4QmOhe5ETzA6GGn1sZaQ+2ZdnArpO+R5SqQf1iJZL+vy5RlQJ6an7drAq
 zhcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727630087; x=1728234887;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=07wA5zG/1d+R2WMpD9te0aExZ2w/43FEpg9CjU1sU5s=;
 b=N2jC06XI0YZtgjMA8bSdEdFYul78Ykw9Fk4I2gY2GwstNuE5WeDXdIND5unGgV2llM
 rxY0+wh0GhFonNLbbacQ0E6kIPcoixv4if+tooSJM0k5ma/uU9x7bNCxqt30JxN4zl4a
 ey5j8cTfITQyYovEUVyodcRlS464aA3xA2spntLwmmr4yEDTJCdN0cInxCyROT+vaMWn
 VzlAUNe9fbeOR3uCEQvap7B/lqOIRXZMLvMIZwGryp2wxCn/AYQE/bomFMjjt0i1sog/
 w2mGyULDiUF+uNhpCtYg80K4AdBa8RUaiL/i2ZeKz68BJS4rA5qIZh7D/e1ZdO3Jfy4E
 sSeg==
X-Gm-Message-State: AOJu0Ywu5ixznUWAjvt2LeH58QR4FhmnvmzS6DFw1d4J2L8lSTPl/Mfc
 2Fgm3dy4+lfNLdQLKsEv3sbzY4K+2pVEgUJsWB4r27NLCaSnYXOaiQhLj1RTnQHU4AUd9YRId0W
 ahsg=
X-Google-Smtp-Source: AGHT+IGBLcGT94nzH90KtP3n54E/O8/Eifq2ZhQHwyZoHaddaW+Tnh8H3cWm4JjbAQK1SQg8ZDAmvw==
X-Received: by 2002:a17:90b:19ca:b0:2e0:7e80:2011 with SMTP id
 98e67ed59e1d1-2e09121de91mr20742707a91.16.1727630086510; 
 Sun, 29 Sep 2024 10:14:46 -0700 (PDT)
Received: from Hyman-Dev-Euler.zelin.local ([85.208.104.155])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e06e1e09e2sm9597408a91.32.2024.09.29.10.14.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Sep 2024 10:14:46 -0700 (PDT)
From: yong.huang@smartx.com
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, yong.huang@smartx.com
Subject: [PATCH v2 2/3] qapi/migration: Introduce cpu-throttle-responsive
 parameter
Date: Mon, 30 Sep 2024 01:14:27 +0800
Message-Id: <a469edd24adcd6c1f1c6476e522fbc959ee22d68.1727630000.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1727630000.git.yong.huang@smartx.com>
References: <cover.1727630000.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=yong.huang@smartx.com; helo=mail-pg1-x52f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001,
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

From: Hyman Huang <yong.huang@smartx.com>

To enable the responsive throttle that will be implemented
in the next commit, introduce the cpu-responsive-throttle
parameter.

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
---
 migration/migration-hmp-cmds.c |  8 ++++++++
 migration/options.c            | 20 ++++++++++++++++++++
 migration/options.h            |  1 +
 qapi/migration.json            | 16 +++++++++++++++-
 4 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 28165cfc9e..e7c292fa51 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -264,6 +264,10 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
         monitor_printf(mon, "%s: %s\n",
             MigrationParameter_str(MIGRATION_PARAMETER_CPU_THROTTLE_TAILSLOW),
             params->cpu_throttle_tailslow ? "on" : "off");
+        assert(params->has_cpu_throttle_responsive);
+        monitor_printf(mon, "%s: %s\n",
+            MigrationParameter_str(MIGRATION_PARAMETER_CPU_THROTTLE_RESPONSIVE),
+            params->cpu_throttle_responsive ? "on" : "off");
         assert(params->has_max_cpu_throttle);
         monitor_printf(mon, "%s: %u\n",
             MigrationParameter_str(MIGRATION_PARAMETER_MAX_CPU_THROTTLE),
@@ -512,6 +516,10 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
         p->has_cpu_throttle_tailslow = true;
         visit_type_bool(v, param, &p->cpu_throttle_tailslow, &err);
         break;
+    case MIGRATION_PARAMETER_CPU_THROTTLE_RESPONSIVE:
+        p->has_cpu_throttle_responsive = true;
+        visit_type_bool(v, param, &p->cpu_throttle_responsive, &err);
+        break;
     case MIGRATION_PARAMETER_MAX_CPU_THROTTLE:
         p->has_max_cpu_throttle = true;
         visit_type_uint8(v, param, &p->max_cpu_throttle, &err);
diff --git a/migration/options.c b/migration/options.c
index 147cd2b8fd..568d5b1074 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -111,6 +111,8 @@ Property migration_properties[] = {
                       DEFAULT_MIGRATE_CPU_THROTTLE_INCREMENT),
     DEFINE_PROP_BOOL("x-cpu-throttle-tailslow", MigrationState,
                       parameters.cpu_throttle_tailslow, false),
+    DEFINE_PROP_BOOL("x-cpu-throttle-responsive", MigrationState,
+                      parameters.cpu_throttle_responsive, false),
     DEFINE_PROP_SIZE("x-max-bandwidth", MigrationState,
                       parameters.max_bandwidth, MAX_THROTTLE),
     DEFINE_PROP_SIZE("avail-switchover-bandwidth", MigrationState,
@@ -705,6 +707,13 @@ uint8_t migrate_cpu_throttle_initial(void)
     return s->parameters.cpu_throttle_initial;
 }
 
+bool migrate_cpu_throttle_responsive(void)
+{
+    MigrationState *s = migrate_get_current();
+
+    return s->parameters.cpu_throttle_responsive;
+}
+
 bool migrate_cpu_throttle_tailslow(void)
 {
     MigrationState *s = migrate_get_current();
@@ -891,6 +900,8 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
     params->cpu_throttle_increment = s->parameters.cpu_throttle_increment;
     params->has_cpu_throttle_tailslow = true;
     params->cpu_throttle_tailslow = s->parameters.cpu_throttle_tailslow;
+    params->has_cpu_throttle_responsive = true;
+    params->cpu_throttle_responsive = s->parameters.cpu_throttle_responsive;
     params->tls_creds = g_strdup(s->parameters.tls_creds);
     params->tls_hostname = g_strdup(s->parameters.tls_hostname);
     params->tls_authz = g_strdup(s->parameters.tls_authz ?
@@ -959,6 +970,7 @@ void migrate_params_init(MigrationParameters *params)
     params->has_cpu_throttle_initial = true;
     params->has_cpu_throttle_increment = true;
     params->has_cpu_throttle_tailslow = true;
+    params->has_cpu_throttle_responsive = true;
     params->has_max_bandwidth = true;
     params->has_downtime_limit = true;
     params->has_x_checkpoint_delay = true;
@@ -1191,6 +1203,10 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
         dest->cpu_throttle_tailslow = params->cpu_throttle_tailslow;
     }
 
+    if (params->has_cpu_throttle_responsive) {
+        dest->cpu_throttle_responsive = params->cpu_throttle_responsive;
+    }
+
     if (params->tls_creds) {
         assert(params->tls_creds->type == QTYPE_QSTRING);
         dest->tls_creds = params->tls_creds->u.s;
@@ -1302,6 +1318,10 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
         s->parameters.cpu_throttle_tailslow = params->cpu_throttle_tailslow;
     }
 
+    if (params->has_cpu_throttle_responsive) {
+        s->parameters.cpu_throttle_responsive = params->cpu_throttle_responsive;
+    }
+
     if (params->tls_creds) {
         g_free(s->parameters.tls_creds);
         assert(params->tls_creds->type == QTYPE_QSTRING);
diff --git a/migration/options.h b/migration/options.h
index a0bd6edc06..28caab83cd 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -68,6 +68,7 @@ bool migrate_has_block_bitmap_mapping(void);
 uint32_t migrate_checkpoint_delay(void);
 uint8_t migrate_cpu_throttle_increment(void);
 uint8_t migrate_cpu_throttle_initial(void);
+bool migrate_cpu_throttle_responsive(void);
 bool migrate_cpu_throttle_tailslow(void);
 bool migrate_direct_io(void);
 uint64_t migrate_downtime_limit(void);
diff --git a/qapi/migration.json b/qapi/migration.json
index b66cccf107..7322bfdd39 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -728,6 +728,10 @@
 #     be excessive at tail stage.  The default value is false.  (Since
 #     5.1)
 #
+# @cpu-throttle-responsive: Make CPU throttling more responsive by
+#                           introduce an extra detection metric of
+#                           migration convergence.  (Since 9.2)
+#
 # @tls-creds: ID of the 'tls-creds' object that provides credentials
 #     for establishing a TLS connection over the migration data
 #     channel.  On the outgoing side of the migration, the credentials
@@ -853,7 +857,7 @@
            'announce-rounds', 'announce-step',
            'throttle-trigger-threshold',
            'cpu-throttle-initial', 'cpu-throttle-increment',
-           'cpu-throttle-tailslow',
+           'cpu-throttle-tailslow', 'cpu-throttle-responsive',
            'tls-creds', 'tls-hostname', 'tls-authz', 'max-bandwidth',
            'avail-switchover-bandwidth', 'downtime-limit',
            { 'name': 'x-checkpoint-delay', 'features': [ 'unstable' ] },
@@ -909,6 +913,10 @@
 #     be excessive at tail stage.  The default value is false.  (Since
 #     5.1)
 #
+# @cpu-throttle-responsive: Make CPU throttling more responsive by
+#                           introduce an extra detection metric of
+#                           migration convergence.  (Since 9.1)
+#
 # @tls-creds: ID of the 'tls-creds' object that provides credentials
 #     for establishing a TLS connection over the migration data
 #     channel.  On the outgoing side of the migration, the credentials
@@ -1041,6 +1049,7 @@
             '*cpu-throttle-initial': 'uint8',
             '*cpu-throttle-increment': 'uint8',
             '*cpu-throttle-tailslow': 'bool',
+            '*cpu-throttle-responsive': 'bool',
             '*tls-creds': 'StrOrNull',
             '*tls-hostname': 'StrOrNull',
             '*tls-authz': 'StrOrNull',
@@ -1123,6 +1132,10 @@
 #     be excessive at tail stage.  The default value is false.  (Since
 #     5.1)
 #
+# @cpu-throttle-responsive: Make CPU throttling more responsive by
+#                           introduce an extra detection metric of
+#                           migration convergence. (Since 9.1)
+#
 # @tls-creds: ID of the 'tls-creds' object that provides credentials
 #     for establishing a TLS connection over the migration data
 #     channel.  On the outgoing side of the migration, the credentials
@@ -1248,6 +1261,7 @@
             '*cpu-throttle-initial': 'uint8',
             '*cpu-throttle-increment': 'uint8',
             '*cpu-throttle-tailslow': 'bool',
+            '*cpu-throttle-responsive': 'bool',
             '*tls-creds': 'str',
             '*tls-hostname': 'str',
             '*tls-authz': 'str',
-- 
2.27.0


