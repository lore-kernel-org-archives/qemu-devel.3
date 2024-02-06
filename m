Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15BA0C48297
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 23:21:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXUjx-0006Dm-NN; Tue, 06 Feb 2024 18:20:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rXUjw-0006DO-Ld
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 18:20:32 -0500
Received: from mail-vs1-xe29.google.com ([2607:f8b0:4864:20::e29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rXUjh-0005iG-OV
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 18:20:32 -0500
Received: by mail-vs1-xe29.google.com with SMTP id
 ada2fe7eead31-46d2c1077easo956176137.1
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 15:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1707261612; x=1707866412; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GOyUBhprnkXUNH3q7XOwDPa0Q/3zpIV90CrsK+ksq4M=;
 b=lUCAda4gaHomk38YZqhwubNdhhxPXn1YiP4w3IgZ5+Fz5GfxvMEQASuqfWjN3KqbqT
 Mc1gLMAOF3lFSc3lWHjiiLWIjjzLGt1UY92EDqNNyC+upO6tpsexzsH7t1OzG+xVlFVw
 J96oNXM/2M8cOTi8orXaC50tlcwTNvlyhpqvgslvudcgI7/byIQo8MlHakxUtrwfzwzM
 23Rrjq6qmP+IyaLvQnP9uAfr17CnvhFKBci0Zo3xXJYim56Cmi3iIpKHiCaf0K2QXzRj
 Nbi9e4pdCouf/ewEiZVOXSA0iAza7rJixsRnDebGXxdp2HauOEt19t82KeNeLe3IcdTu
 Vepg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707261612; x=1707866412;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GOyUBhprnkXUNH3q7XOwDPa0Q/3zpIV90CrsK+ksq4M=;
 b=QqwJAecLcK8pCVVL0OQdACvvhjtvzwsL4qHm1GyM47WCA1RoZgoQuO2g6MfUtFDwUI
 0K50RMog2YWOiqzbSREG8xzuF5wPJABP4/WxQkcaWfP8L4U1jos2hHnNZNFjSAgba41J
 6VSRxAtYNA6N7+jR/7SYTwYkTC7pz+tR2JIdwffef4Eq+8o3T+sC3TT65Dyicn3r4wx2
 itC+xaqsV/eH6bWJhIMIBdkjOt3VRu9jIJN7ld/i10+tljwMUpNmGSQCZSVpZfM4m+Vc
 8iIj00Jf/PN2ZYZxevnmoTwcbeoPLBao5CRX2qXDHNeRukZ7TgQ2iM6VFYtvQqhwJsTx
 Yz9w==
X-Gm-Message-State: AOJu0YyHNvu71uRmeC21mVlKQoAJtlwf/0+Hso57VoGyhVvmH31CPptX
 5uWcTqmaUq9g3Ka9/91tNCKhdTgv3o7wBCbmS5wQCfV6Mkn5eW4h3WyWHN5fDdG6igiPdXOHd29
 07Xs=
X-Google-Smtp-Source: AGHT+IFQKKlKdB6Ds43ZQ7GJK7ykk4LqNjvNJhTqIrBeQXqtD+bWy5e0boDJJjYuRlvKyqJAepKztg==
X-Received: by 2002:a05:6102:34d5:b0:46d:1043:fe65 with SMTP id
 a21-20020a05610234d500b0046d1043fe65mr1113085vst.26.1707261612354; 
 Tue, 06 Feb 2024 15:20:12 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXHNS8gDsLf0J52zqZtp8RjTGFYKSXyxXs94Czhe+zj0oD3QaZhqzYteRO5FjqwhHZXhhIGUmlu/MVCEhsugCo6CJX3vJGi0k41NOLktexfF9f4
Received: from n231-230-216.byted.org ([130.44.215.112])
 by smtp.gmail.com with ESMTPSA id
 d11-20020a67b60b000000b0046d20ce8886sm2352vsm.1.2024.02.06.15.20.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Feb 2024 15:20:11 -0800 (PST)
From: Hao Xiang <hao.xiang@bytedance.com>
To: qemu-devel@nongnu.org,
	farosas@suse.de,
	peterx@redhat.com
Cc: Hao Xiang <hao.xiang@bytedance.com>
Subject: [PATCH 1/6] migration/multifd: Add new migration option
 multifd-zero-page.
Date: Tue,  6 Feb 2024 23:19:03 +0000
Message-Id: <20240206231908.1792529-2-hao.xiang@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240206231908.1792529-1-hao.xiang@bytedance.com>
References: <20240206231908.1792529-1-hao.xiang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::e29;
 envelope-from=hao.xiang@bytedance.com; helo=mail-vs1-xe29.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

This new parameter controls where the zero page checking is running. If
this parameter is set to true, zero page checking is done in the multifd
sender threads. If this parameter is set to false, zero page checking is
done in the migration main thread.

Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
---
 migration/migration-hmp-cmds.c |  7 +++++++
 migration/options.c            | 20 ++++++++++++++++++++
 migration/options.h            |  1 +
 qapi/migration.json            | 24 +++++++++++++++++++++---
 4 files changed, 49 insertions(+), 3 deletions(-)

diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 99b49df5dd..8b0c205a41 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -344,6 +344,9 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
         monitor_printf(mon, "%s: %s\n",
             MigrationParameter_str(MIGRATION_PARAMETER_MULTIFD_COMPRESSION),
             MultiFDCompression_str(params->multifd_compression));
+        monitor_printf(mon, "%s: %s\n",
+            MigrationParameter_str(MIGRATION_PARAMETER_MULTIFD_ZERO_PAGE),
+            params->multifd_zero_page ? "on" : "off");
         monitor_printf(mon, "%s: %" PRIu64 " bytes\n",
             MigrationParameter_str(MIGRATION_PARAMETER_XBZRLE_CACHE_SIZE),
             params->xbzrle_cache_size);
@@ -634,6 +637,10 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
         p->has_multifd_zstd_level = true;
         visit_type_uint8(v, param, &p->multifd_zstd_level, &err);
         break;
+    case MIGRATION_PARAMETER_MULTIFD_ZERO_PAGE:
+        p->has_multifd_zero_page = true;
+        visit_type_bool(v, param, &p->multifd_zero_page, &err);
+        break;
     case MIGRATION_PARAMETER_XBZRLE_CACHE_SIZE:
         p->has_xbzrle_cache_size = true;
         if (!visit_type_size(v, param, &cache_size, &err)) {
diff --git a/migration/options.c b/migration/options.c
index 3e3e0b93b4..cb18a41267 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -179,6 +179,8 @@ Property migration_properties[] = {
     DEFINE_PROP_MIG_MODE("mode", MigrationState,
                       parameters.mode,
                       MIG_MODE_NORMAL),
+    DEFINE_PROP_BOOL("multifd-zero-page", MigrationState,
+                     parameters.multifd_zero_page, true),
 
     /* Migration capabilities */
     DEFINE_PROP_MIG_CAP("x-xbzrle", MIGRATION_CAPABILITY_XBZRLE),
@@ -903,6 +905,13 @@ uint64_t migrate_xbzrle_cache_size(void)
     return s->parameters.xbzrle_cache_size;
 }
 
+bool migrate_multifd_zero_page(void)
+{
+    MigrationState *s = migrate_get_current();
+
+    return s->parameters.multifd_zero_page;
+}
+
 /* parameter setters */
 
 void migrate_set_block_incremental(bool value)
@@ -1013,6 +1022,8 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
     params->vcpu_dirty_limit = s->parameters.vcpu_dirty_limit;
     params->has_mode = true;
     params->mode = s->parameters.mode;
+    params->has_multifd_zero_page = true;
+    params->multifd_zero_page = s->parameters.multifd_zero_page;
 
     return params;
 }
@@ -1049,6 +1060,7 @@ void migrate_params_init(MigrationParameters *params)
     params->has_x_vcpu_dirty_limit_period = true;
     params->has_vcpu_dirty_limit = true;
     params->has_mode = true;
+    params->has_multifd_zero_page = true;
 }
 
 /*
@@ -1350,6 +1362,10 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
     if (params->has_mode) {
         dest->mode = params->mode;
     }
+
+    if (params->has_multifd_zero_page) {
+        dest->multifd_zero_page = params->multifd_zero_page;
+    }
 }
 
 static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
@@ -1494,6 +1510,10 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
     if (params->has_mode) {
         s->parameters.mode = params->mode;
     }
+
+    if (params->has_multifd_zero_page) {
+        s->parameters.multifd_zero_page = params->multifd_zero_page;
+    }
 }
 
 void qmp_migrate_set_parameters(MigrateSetParameters *params, Error **errp)
diff --git a/migration/options.h b/migration/options.h
index 246c160aee..c080a6ba18 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -93,6 +93,7 @@ const char *migrate_tls_authz(void);
 const char *migrate_tls_creds(void);
 const char *migrate_tls_hostname(void);
 uint64_t migrate_xbzrle_cache_size(void);
+bool migrate_multifd_zero_page(void);
 
 /* parameters setters */
 
diff --git a/qapi/migration.json b/qapi/migration.json
index 819708321d..ff033a0344 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -874,6 +874,11 @@
 # @mode: Migration mode. See description in @MigMode. Default is 'normal'.
 #        (Since 8.2)
 #
+# @multifd-zero-page: Multifd zero page checking. If the parameter is true,
+#     zero page checking is done on the multifd sender thread. If the parameter
+#     is false, zero page checking is done on the migration main thread. Default
+#     is set to true. (Since 9.0)
+#
 # Features:
 #
 # @deprecated: Member @block-incremental is deprecated.  Use
@@ -907,7 +912,8 @@
            'block-bitmap-mapping',
            { 'name': 'x-vcpu-dirty-limit-period', 'features': ['unstable'] },
            'vcpu-dirty-limit',
-           'mode'] }
+           'mode',
+           'multifd-zero-page'] }
 
 ##
 # @MigrateSetParameters:
@@ -1062,6 +1068,11 @@
 # @mode: Migration mode. See description in @MigMode. Default is 'normal'.
 #        (Since 8.2)
 #
+# @multifd-zero-page: Multifd zero page checking. If the parameter is true,
+#     zero page checking is done on the multifd sender thread. If the parameter
+#     is false, zero page checking is done on the migration main thread. Default
+#     is set to true. (Since 9.0)
+#
 # Features:
 #
 # @deprecated: Member @block-incremental is deprecated.  Use
@@ -1115,7 +1126,8 @@
             '*x-vcpu-dirty-limit-period': { 'type': 'uint64',
                                             'features': [ 'unstable' ] },
             '*vcpu-dirty-limit': 'uint64',
-            '*mode': 'MigMode'} }
+            '*mode': 'MigMode',
+            '*multifd-zero-page': 'bool'} }
 
 ##
 # @migrate-set-parameters:
@@ -1290,6 +1302,11 @@
 # @mode: Migration mode. See description in @MigMode. Default is 'normal'.
 #        (Since 8.2)
 #
+# @multifd-zero-page: Multifd zero page checking. If the parameter is true,
+#     zero page checking is done on the multifd sender thread. If the parameter
+#     is false, zero page checking is done on the migration main thread. Default
+#     is set to true. (Since 9.0)
+#
 # Features:
 #
 # @deprecated: Member @block-incremental is deprecated.  Use
@@ -1340,7 +1357,8 @@
             '*x-vcpu-dirty-limit-period': { 'type': 'uint64',
                                             'features': [ 'unstable' ] },
             '*vcpu-dirty-limit': 'uint64',
-            '*mode': 'MigMode'} }
+            '*mode': 'MigMode',
+            '*multifd-zero-page': 'bool'} }
 
 ##
 # @query-migrate-parameters:
-- 
2.30.2


