Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF640C3ABA0
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2024 16:11:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sproV-0003Hl-3W; Sun, 15 Sep 2024 12:09:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1sproQ-0003Dw-Re
 for qemu-devel@nongnu.org; Sun, 15 Sep 2024 12:09:23 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1sproO-0006Px-Nf
 for qemu-devel@nongnu.org; Sun, 15 Sep 2024 12:09:22 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-718e11e4186so3544935b3a.2
 for <qemu-devel@nongnu.org>; Sun, 15 Sep 2024 09:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1726416559; x=1727021359;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VxfIUT8pMVWFFKuG2ha9l+max75wFuRXKMQhUKzr0eU=;
 b=fWUJnH2Yi+N163kYIT0B5xSAcp4z9t6klV8jSNdwRW20Wrr+/tUSFgGNVEQgsei0nL
 1iwB5xNJJ11aHjJa3W96wWu0RQbCuFQ/1MfUDq8x6I1LIQ7UqYuTbnWyTiBjhk0kanFF
 adXagL3RR7dSF4ALcN8DbGPbhlKB0P+Kk4Vb8taCkEOb51HbIToSiXLm1u8Hfaon6hDp
 NwUeKoAR2ov5H4b8MZYoqGPDa1LbK9ebR6qVsFiAXkoGqjyZ7bD6qNzBXGACzQ70dFdo
 fDkGDyx93a0Woo6j0LD0hyjPLJiYz0+2DN1yuIqtUVJI6RrrCooP7dd+jO7ExOnLye0N
 l1Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726416559; x=1727021359;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VxfIUT8pMVWFFKuG2ha9l+max75wFuRXKMQhUKzr0eU=;
 b=exoP6kfrZ+aMtzInGm1moSnaoLH+9Je58EgY+MfRxZ2WXGdZ/CkU9154dNQbwf6Bty
 wYjgAxHvH3RKxkMxUM7et7LLtcJHg1z/1QJvNX0GqDacw0nRx+783mTr+JNRcB0hNqAy
 o9xmVAH+T7s4TkOknk/amnWfuVbDC/Xwj4tyvjocSAU+ZujQZ9DcfT0SWBEGJA+fDNUJ
 qhqVBy49ZsI/r0qeLmDJhLJn+aUvIf4BCnMWcJs66aXKbqBEWncgrGuWsjAjcJtODWs5
 BTxQ14KYR8I2mNX5i4StCfHpPcQ2pE3vH5cue2E61rADWIIgKY9GVzcqLZPva59OsPjE
 cwdQ==
X-Gm-Message-State: AOJu0Yz46KSsdbztUv5tVRUWVJ7GtzGkhgq+5LfXiX+dazNOPWTiytxe
 YXhT3BNTdDga9JWBAm0QV3RWYUaZrmElVxNm5Pfw+T/aGLAKnK71/FP38WxfKrS48TEIH0XLIIa
 kY/nQDw==
X-Google-Smtp-Source: AGHT+IGO3cZ8epqoxRRAaW2eKvyivLEIxVnTWOBSybaA9cfAcCbYsndlt4bvvQrFE4RauY2gKzw7ZQ==
X-Received: by 2002:a05:6a21:168e:b0:1d2:bb49:6381 with SMTP id
 adf61e73a8af0-1d2bb496410mr5558241637.47.1726416558401; 
 Sun, 15 Sep 2024 09:09:18 -0700 (PDT)
Received: from localhost.localdomain ([118.114.94.247])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71944bb5967sm2344795b3a.182.2024.09.15.09.09.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Sep 2024 09:09:18 -0700 (PDT)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, yong.huang@smartx.com
Subject: [PATCH v1 6/7] qapi/migration: Introduce cpu-responsive-throttle
 parameter
Date: Mon, 16 Sep 2024 00:08:49 +0800
Message-Id: <81d939d716918ed5feea3850cf0644a66d9f1a7b.1726390099.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1726390098.git.yong.huang@smartx.com>
References: <cover.1726390098.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=yong.huang@smartx.com; helo=mail-pf1-x432.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
index 28165cfc9e..1fe6c74d66 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -264,6 +264,10 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
         monitor_printf(mon, "%s: %s\n",
             MigrationParameter_str(MIGRATION_PARAMETER_CPU_THROTTLE_TAILSLOW),
             params->cpu_throttle_tailslow ? "on" : "off");
+        assert(params->has_cpu_responsive_throttle);
+        monitor_printf(mon, "%s: %s\n",
+            MigrationParameter_str(MIGRATION_PARAMETER_CPU_RESPONSIVE_THROTTLE),
+            params->cpu_responsive_throttle ? "on" : "off");
         assert(params->has_max_cpu_throttle);
         monitor_printf(mon, "%s: %u\n",
             MigrationParameter_str(MIGRATION_PARAMETER_MAX_CPU_THROTTLE),
@@ -512,6 +516,10 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
         p->has_cpu_throttle_tailslow = true;
         visit_type_bool(v, param, &p->cpu_throttle_tailslow, &err);
         break;
+    case MIGRATION_PARAMETER_CPU_RESPONSIVE_THROTTLE:
+        p->has_cpu_responsive_throttle = true;
+        visit_type_bool(v, param, &p->cpu_responsive_throttle, &err);
+        break;
     case MIGRATION_PARAMETER_MAX_CPU_THROTTLE:
         p->has_max_cpu_throttle = true;
         visit_type_uint8(v, param, &p->max_cpu_throttle, &err);
diff --git a/migration/options.c b/migration/options.c
index 147cd2b8fd..b4c269bf1d 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -111,6 +111,8 @@ Property migration_properties[] = {
                       DEFAULT_MIGRATE_CPU_THROTTLE_INCREMENT),
     DEFINE_PROP_BOOL("x-cpu-throttle-tailslow", MigrationState,
                       parameters.cpu_throttle_tailslow, false),
+    DEFINE_PROP_BOOL("x-cpu-responsive-throttle", MigrationState,
+                      parameters.cpu_responsive_throttle, false),
     DEFINE_PROP_SIZE("x-max-bandwidth", MigrationState,
                       parameters.max_bandwidth, MAX_THROTTLE),
     DEFINE_PROP_SIZE("avail-switchover-bandwidth", MigrationState,
@@ -705,6 +707,13 @@ uint8_t migrate_cpu_throttle_initial(void)
     return s->parameters.cpu_throttle_initial;
 }
 
+bool migrate_responsive_throttle(void)
+{
+    MigrationState *s = migrate_get_current();
+
+    return s->parameters.cpu_responsive_throttle;
+}
+
 bool migrate_cpu_throttle_tailslow(void)
 {
     MigrationState *s = migrate_get_current();
@@ -891,6 +900,8 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
     params->cpu_throttle_increment = s->parameters.cpu_throttle_increment;
     params->has_cpu_throttle_tailslow = true;
     params->cpu_throttle_tailslow = s->parameters.cpu_throttle_tailslow;
+    params->has_cpu_responsive_throttle = true;
+    params->cpu_responsive_throttle = s->parameters.cpu_responsive_throttle;
     params->tls_creds = g_strdup(s->parameters.tls_creds);
     params->tls_hostname = g_strdup(s->parameters.tls_hostname);
     params->tls_authz = g_strdup(s->parameters.tls_authz ?
@@ -959,6 +970,7 @@ void migrate_params_init(MigrationParameters *params)
     params->has_cpu_throttle_initial = true;
     params->has_cpu_throttle_increment = true;
     params->has_cpu_throttle_tailslow = true;
+    params->has_cpu_responsive_throttle = true;
     params->has_max_bandwidth = true;
     params->has_downtime_limit = true;
     params->has_x_checkpoint_delay = true;
@@ -1191,6 +1203,10 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
         dest->cpu_throttle_tailslow = params->cpu_throttle_tailslow;
     }
 
+    if (params->has_cpu_responsive_throttle) {
+        dest->cpu_responsive_throttle = params->cpu_responsive_throttle;
+    }
+
     if (params->tls_creds) {
         assert(params->tls_creds->type == QTYPE_QSTRING);
         dest->tls_creds = params->tls_creds->u.s;
@@ -1302,6 +1318,10 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
         s->parameters.cpu_throttle_tailslow = params->cpu_throttle_tailslow;
     }
 
+    if (params->has_cpu_responsive_throttle) {
+        s->parameters.cpu_responsive_throttle = params->cpu_responsive_throttle;
+    }
+
     if (params->tls_creds) {
         g_free(s->parameters.tls_creds);
         assert(params->tls_creds->type == QTYPE_QSTRING);
diff --git a/migration/options.h b/migration/options.h
index a0bd6edc06..80d0fcdaf9 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -68,6 +68,7 @@ bool migrate_has_block_bitmap_mapping(void);
 uint32_t migrate_checkpoint_delay(void);
 uint8_t migrate_cpu_throttle_increment(void);
 uint8_t migrate_cpu_throttle_initial(void);
+bool migrate_responsive_throttle(void);
 bool migrate_cpu_throttle_tailslow(void);
 bool migrate_direct_io(void);
 uint64_t migrate_downtime_limit(void);
diff --git a/qapi/migration.json b/qapi/migration.json
index 95b490706c..c61d3b3a6b 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -732,6 +732,10 @@
 #     be excessive at tail stage.  The default value is false.  (Since
 #     5.1)
 #
+# @cpu-responsive-throttle: Make CPU throttling more responsively by
+#                           introduce an extra detection metric of
+#                           migration convergence. (Since 9.1)
+#
 # @tls-creds: ID of the 'tls-creds' object that provides credentials
 #     for establishing a TLS connection over the migration data
 #     channel.  On the outgoing side of the migration, the credentials
@@ -857,7 +861,7 @@
            'announce-rounds', 'announce-step',
            'throttle-trigger-threshold',
            'cpu-throttle-initial', 'cpu-throttle-increment',
-           'cpu-throttle-tailslow',
+           'cpu-throttle-tailslow', 'cpu-responsive-throttle',
            'tls-creds', 'tls-hostname', 'tls-authz', 'max-bandwidth',
            'avail-switchover-bandwidth', 'downtime-limit',
            { 'name': 'x-checkpoint-delay', 'features': [ 'unstable' ] },
@@ -913,6 +917,10 @@
 #     be excessive at tail stage.  The default value is false.  (Since
 #     5.1)
 #
+# @cpu-responsive-throttle: Make CPU throttling more responsively by
+#                           introduce an extra detection metric of
+#                           migration convergence. (Since 9.1)
+#
 # @tls-creds: ID of the 'tls-creds' object that provides credentials
 #     for establishing a TLS connection over the migration data
 #     channel.  On the outgoing side of the migration, the credentials
@@ -1045,6 +1053,7 @@
             '*cpu-throttle-initial': 'uint8',
             '*cpu-throttle-increment': 'uint8',
             '*cpu-throttle-tailslow': 'bool',
+            '*cpu-responsive-throttle': 'bool',
             '*tls-creds': 'StrOrNull',
             '*tls-hostname': 'StrOrNull',
             '*tls-authz': 'StrOrNull',
@@ -1127,6 +1136,10 @@
 #     be excessive at tail stage.  The default value is false.  (Since
 #     5.1)
 #
+# @cpu-responsive-throttle: Make CPU throttling more responsively by
+#                           introduce an extra detection metric of
+#                           migration convergence. (Since 9.1)
+#
 # @tls-creds: ID of the 'tls-creds' object that provides credentials
 #     for establishing a TLS connection over the migration data
 #     channel.  On the outgoing side of the migration, the credentials
@@ -1252,6 +1265,7 @@
             '*cpu-throttle-initial': 'uint8',
             '*cpu-throttle-increment': 'uint8',
             '*cpu-throttle-tailslow': 'bool',
+            '*cpu-responsive-throttle': 'bool',
             '*tls-creds': 'str',
             '*tls-hostname': 'str',
             '*tls-authz': 'str',
-- 
2.39.1


