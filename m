Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4CB5C3ABAC
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 16:42:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAtSz-0007vT-2a; Fri, 02 May 2025 12:42:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uAtSi-0007nj-Ic
 for qemu-devel@nongnu.org; Fri, 02 May 2025 12:42:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uAtSe-0006UL-QQ
 for qemu-devel@nongnu.org; Fri, 02 May 2025 12:42:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746204124;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/yyVmAMhJTDOQ6t8/5jDqz0Y+aQajW34hgAyEzYdjng=;
 b=PnnspxqQ0s4StRu5jEY1UYmBgl8d3+/atPej3ikrU+0N/rGxpNlk1Cn3bEGk/iR2zC0iJR
 8jiEGD1ZZqsfwqRrP7C1ebFwWKMsmNalJDtybeDpnIfkUqBEmUkg0bQFHHVpaA2vZGF754
 GrEHgD9Dpy8vkxHnzhsIV1Xnp+2nCMA=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-kaGfrvn0N-6JdcuG87tm9A-1; Fri, 02 May 2025 12:42:03 -0400
X-MC-Unique: kaGfrvn0N-6JdcuG87tm9A-1
X-Mimecast-MFC-AGG-ID: kaGfrvn0N-6JdcuG87tm9A_1746204122
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7c760637fe5so397707885a.0
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 09:42:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746204122; x=1746808922;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/yyVmAMhJTDOQ6t8/5jDqz0Y+aQajW34hgAyEzYdjng=;
 b=TuVrG4744fxyP7coA9M8RsCz5u+fCe3bGnsIbcx147vmHqrgultGcyWAg+LOmnq2Bw
 dfBv+78xwGaDVYL4WM4xXCCwX0EBiGu76z/11EutEEsFnM+ekCEEqpzIW88hYw6rYQQ2
 khXlQTwMql5eODOGa5I3XEOLyx6v1hae33SPP2HPeLTecPzDtIhd6yq+M+wnI0mLislu
 VL10rGVEAjm26lyTlqCAm5ZIazY+tmjqlErmU3PKm5jbOvE0Y+GJTjN6CW2ND7s7Tqgg
 sWIyvWULPDNEh/grrklrrpYei0CFWpqATMYagzpYyqn/I1uvFBDRdnCF8VKkgGWqT2mo
 1SYg==
X-Gm-Message-State: AOJu0YwRBNcoCOir7vmpqFf0OFO432gNlrt/VRx6DYYMxm6POVUCq54F
 Fgj8aOvsc6BADmeqd1c9Ad+zk8RAolDwUdDYhnhEpKa2cKRuliTq566+223X831jk0atv4QWuTo
 KRDR28wdlEhuuVHibp6peARRgwXjDcuCdWTpaR16lr3yeOk2QKmiuvKhDygL80AepLpD5AWwzxR
 ARgN0GkdGyteyr7FmzCS5b0m505EVyVcOpjg==
X-Gm-Gg: ASbGnctsYTuE++DYG9rNsOGkOXubyd9YjCIMNzDw0SWxnSchOd5Q9ezVeNGmgChTtzo
 U3R2QPbfY2Q+S5Ah1NuiUBDbslPm5WfW6SL2lF7RKXSYndzSj2mqX2WesvRaiuR7/wVhiMukVkK
 0c9580ixhEYQMz+t131U0iTSALQm+io5MubT1WSISokT9rBz6EKP9YASqscVVNcUSoQU/IEwEdb
 uCeJH01SQuEEs1UjLnqJSKu2dzoplVTE6kL+/DJ2ZkpLKSL9WK9B9XTaXtCQ8gIXS3j1VHG0IZu
X-Received: by 2002:a05:620a:318c:b0:7c7:a5b7:b288 with SMTP id
 af79cd13be357-7cad5b3fe4amr438178885a.19.1746204121714; 
 Fri, 02 May 2025 09:42:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENfU5gIhrYe/f/nl/oozzz3iYMVMw3WBONgYvAb3U5RJWsP6IateHtZbGxfbxrZ8cvpIJmhg==
X-Received: by 2002:a05:620a:318c:b0:7c7:a5b7:b288 with SMTP id
 af79cd13be357-7cad5b3fe4amr438174885a.19.1746204121157; 
 Fri, 02 May 2025 09:42:01 -0700 (PDT)
Received: from x1.com ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7cad23d1c8dsm203108385a.60.2025.05.02.09.41.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 09:42:00 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Stefan Hajnoczi <stefanha@redhat.com>,
 peterx@redhat.com, Prasad Pandit <pjp@fedoraproject.org>
Subject: [PULL 11/14] tests/qtest/migration: consolidate set capabilities
Date: Fri,  2 May 2025 12:41:38 -0400
Message-ID: <20250502164141.747202-12-peterx@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250502164141.747202-1-peterx@redhat.com>
References: <20250502164141.747202-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.644,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Prasad Pandit <pjp@fedoraproject.org>

Migration capabilities are set in multiple '.start_hook'
functions for various tests. Instead, consolidate setting
capabilities in 'migrate_start_set_capabilities()' function
which is called from the 'migrate_start()' function.
While simplifying the capabilities setting, it helps
to declutter the qtest sources.

Suggested-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Message-ID: <20250411114534.3370816-7-ppandit@redhat.com>
[fix open brace]
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration/framework.h         |  9 ++-
 tests/qtest/migration/compression-tests.c | 22 +++++--
 tests/qtest/migration/cpr-tests.c         |  6 +-
 tests/qtest/migration/file-tests.c        | 58 ++++++++----------
 tests/qtest/migration/framework.c         | 75 +++++++++++++++--------
 tests/qtest/migration/misc-tests.c        |  4 +-
 tests/qtest/migration/postcopy-tests.c    |  8 ++-
 tests/qtest/migration/precopy-tests.c     | 29 +++++----
 tests/qtest/migration/tls-tests.c         | 23 ++++++-
 9 files changed, 150 insertions(+), 84 deletions(-)

diff --git a/tests/qtest/migration/framework.h b/tests/qtest/migration/framework.h
index e4a11870f6..01e425e64e 100644
--- a/tests/qtest/migration/framework.h
+++ b/tests/qtest/migration/framework.h
@@ -12,6 +12,7 @@
 #define TEST_FRAMEWORK_H
 
 #include "libqtest.h"
+#include <qapi/qapi-types-migration.h>
 
 #define FILE_TEST_FILENAME "migfile"
 #define FILE_TEST_OFFSET 0x1000
@@ -120,6 +121,13 @@ typedef struct {
 
     /* Do not connect to target monitor and qtest sockets in qtest_init */
     bool defer_target_connect;
+
+    /*
+     * Migration capabilities to be set in both source and
+     * destination. For unilateral capabilities, use
+     * migration_set_capabilities().
+     */
+    bool caps[MIGRATION_CAPABILITY__MAX];
 } MigrateStart;
 
 typedef enum PostcopyRecoveryFailStage {
@@ -207,7 +215,6 @@ typedef struct {
 
     /* Postcopy specific fields */
     void *postcopy_data;
-    bool postcopy_preempt;
     PostcopyRecoveryFailStage postcopy_recovery_fail_stage;
 } MigrateCommon;
 
diff --git a/tests/qtest/migration/compression-tests.c b/tests/qtest/migration/compression-tests.c
index 8b58401b84..41e79f031b 100644
--- a/tests/qtest/migration/compression-tests.c
+++ b/tests/qtest/migration/compression-tests.c
@@ -35,6 +35,9 @@ static void test_multifd_tcp_zstd(void)
 {
     MigrateCommon args = {
         .listen_uri = "defer",
+        .start = {
+            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
+        },
         .start_hook = migrate_hook_start_precopy_tcp_multifd_zstd,
     };
     test_precopy_common(&args);
@@ -56,6 +59,9 @@ static void test_multifd_tcp_qatzip(void)
 {
     MigrateCommon args = {
         .listen_uri = "defer",
+        .start = {
+            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
+        },
         .start_hook = migrate_hook_start_precopy_tcp_multifd_qatzip,
     };
     test_precopy_common(&args);
@@ -74,6 +80,9 @@ static void test_multifd_tcp_qpl(void)
 {
     MigrateCommon args = {
         .listen_uri = "defer",
+        .start = {
+            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
+        },
         .start_hook = migrate_hook_start_precopy_tcp_multifd_qpl,
     };
     test_precopy_common(&args);
@@ -92,6 +101,9 @@ static void test_multifd_tcp_uadk(void)
 {
     MigrateCommon args = {
         .listen_uri = "defer",
+        .start = {
+            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
+        },
         .start_hook = migrate_hook_start_precopy_tcp_multifd_uadk,
     };
     test_precopy_common(&args);
@@ -103,10 +115,6 @@ migrate_hook_start_xbzrle(QTestState *from,
                           QTestState *to)
 {
     migrate_set_parameter_int(from, "xbzrle-cache-size", 33554432);
-
-    migrate_set_capability(from, "xbzrle", true);
-    migrate_set_capability(to, "xbzrle", true);
-
     return NULL;
 }
 
@@ -118,6 +126,9 @@ static void test_precopy_unix_xbzrle(void)
         .listen_uri = uri,
         .start_hook = migrate_hook_start_xbzrle,
         .iterations = 2,
+        .start = {
+            .caps[MIGRATION_CAPABILITY_XBZRLE] = true,
+        },
         /*
          * XBZRLE needs pages to be modified when doing the 2nd+ round
          * iteration to have real data pushed to the stream.
@@ -146,6 +157,9 @@ static void test_multifd_tcp_zlib(void)
 {
     MigrateCommon args = {
         .listen_uri = "defer",
+        .start = {
+            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
+        },
         .start_hook = migrate_hook_start_precopy_tcp_multifd_zlib,
     };
     test_precopy_common(&args);
diff --git a/tests/qtest/migration/cpr-tests.c b/tests/qtest/migration/cpr-tests.c
index 4758841824..5536e14610 100644
--- a/tests/qtest/migration/cpr-tests.c
+++ b/tests/qtest/migration/cpr-tests.c
@@ -24,9 +24,6 @@ static void *migrate_hook_start_mode_reboot(QTestState *from, QTestState *to)
     migrate_set_parameter_str(from, "mode", "cpr-reboot");
     migrate_set_parameter_str(to, "mode", "cpr-reboot");
 
-    migrate_set_capability(from, "x-ignore-shared", true);
-    migrate_set_capability(to, "x-ignore-shared", true);
-
     return NULL;
 }
 
@@ -39,6 +36,9 @@ static void test_mode_reboot(void)
         .connect_uri = uri,
         .listen_uri = "defer",
         .start_hook = migrate_hook_start_mode_reboot,
+        .start = {
+            .caps[MIGRATION_CAPABILITY_X_IGNORE_SHARED] = true,
+        },
     };
 
     test_file_common(&args, true);
diff --git a/tests/qtest/migration/file-tests.c b/tests/qtest/migration/file-tests.c
index f260e2871d..4d78ce0855 100644
--- a/tests/qtest/migration/file-tests.c
+++ b/tests/qtest/migration/file-tests.c
@@ -107,15 +107,6 @@ static void test_precopy_file_offset_bad(void)
     test_file_common(&args, false);
 }
 
-static void *migrate_hook_start_mapped_ram(QTestState *from,
-                                           QTestState *to)
-{
-    migrate_set_capability(from, "mapped-ram", true);
-    migrate_set_capability(to, "mapped-ram", true);
-
-    return NULL;
-}
-
 static void test_precopy_file_mapped_ram_live(void)
 {
     g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
@@ -123,7 +114,9 @@ static void test_precopy_file_mapped_ram_live(void)
     MigrateCommon args = {
         .connect_uri = uri,
         .listen_uri = "defer",
-        .start_hook = migrate_hook_start_mapped_ram,
+        .start = {
+            .caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true,
+        },
     };
 
     test_file_common(&args, false);
@@ -136,26 +129,14 @@ static void test_precopy_file_mapped_ram(void)
     MigrateCommon args = {
         .connect_uri = uri,
         .listen_uri = "defer",
-        .start_hook = migrate_hook_start_mapped_ram,
+        .start = {
+            .caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true,
+        },
     };
 
     test_file_common(&args, true);
 }
 
-static void *migrate_hook_start_multifd_mapped_ram(QTestState *from,
-                                                   QTestState *to)
-{
-    migrate_hook_start_mapped_ram(from, to);
-
-    migrate_set_parameter_int(from, "multifd-channels", 4);
-    migrate_set_parameter_int(to, "multifd-channels", 4);
-
-    migrate_set_capability(from, "multifd", true);
-    migrate_set_capability(to, "multifd", true);
-
-    return NULL;
-}
-
 static void test_multifd_file_mapped_ram_live(void)
 {
     g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
@@ -163,7 +144,10 @@ static void test_multifd_file_mapped_ram_live(void)
     MigrateCommon args = {
         .connect_uri = uri,
         .listen_uri = "defer",
-        .start_hook = migrate_hook_start_multifd_mapped_ram,
+        .start = {
+            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
+            .caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true,
+        },
     };
 
     test_file_common(&args, false);
@@ -176,7 +160,10 @@ static void test_multifd_file_mapped_ram(void)
     MigrateCommon args = {
         .connect_uri = uri,
         .listen_uri = "defer",
-        .start_hook = migrate_hook_start_multifd_mapped_ram,
+        .start = {
+            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
+            .caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true,
+        },
     };
 
     test_file_common(&args, true);
@@ -185,8 +172,6 @@ static void test_multifd_file_mapped_ram(void)
 static void *migrate_hook_start_multifd_mapped_ram_dio(QTestState *from,
                                                        QTestState *to)
 {
-    migrate_hook_start_multifd_mapped_ram(from, to);
-
     migrate_set_parameter_bool(from, "direct-io", true);
     migrate_set_parameter_bool(to, "direct-io", true);
 
@@ -201,6 +186,10 @@ static void test_multifd_file_mapped_ram_dio(void)
         .connect_uri = uri,
         .listen_uri = "defer",
         .start_hook = migrate_hook_start_multifd_mapped_ram_dio,
+        .start = {
+            .caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true,
+            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
+        },
     };
 
     if (!probe_o_direct_support(tmpfs)) {
@@ -246,7 +235,6 @@ static void *migrate_hook_start_multifd_mapped_ram_fdset_dio(QTestState *from,
     fdset_add_fds(from, file, O_WRONLY, 2, true);
     fdset_add_fds(to, file, O_RDONLY, 2, true);
 
-    migrate_hook_start_multifd_mapped_ram(from, to);
     migrate_set_parameter_bool(from, "direct-io", true);
     migrate_set_parameter_bool(to, "direct-io", true);
 
@@ -261,8 +249,6 @@ static void *migrate_hook_start_multifd_mapped_ram_fdset(QTestState *from,
     fdset_add_fds(from, file, O_WRONLY, 2, false);
     fdset_add_fds(to, file, O_RDONLY, 2, false);
 
-    migrate_hook_start_multifd_mapped_ram(from, to);
-
     return NULL;
 }
 
@@ -275,6 +261,10 @@ static void test_multifd_file_mapped_ram_fdset(void)
         .listen_uri = "defer",
         .start_hook = migrate_hook_start_multifd_mapped_ram_fdset,
         .end_hook = migrate_hook_end_multifd_mapped_ram_fdset,
+        .start = {
+            .caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true,
+            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
+        },
     };
 
     test_file_common(&args, true);
@@ -289,6 +279,10 @@ static void test_multifd_file_mapped_ram_fdset_dio(void)
         .listen_uri = "defer",
         .start_hook = migrate_hook_start_multifd_mapped_ram_fdset_dio,
         .end_hook = migrate_hook_end_multifd_mapped_ram_fdset,
+        .start = {
+            .caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true,
+            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
+        },
     };
 
     if (!probe_o_direct_support(tmpfs)) {
diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index 10e1d04b58..e48b80a127 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -30,6 +30,7 @@
 #define QEMU_VM_FILE_MAGIC 0x5145564d
 #define QEMU_ENV_SRC "QTEST_QEMU_BINARY_SRC"
 #define QEMU_ENV_DST "QTEST_QEMU_BINARY_DST"
+#define MULTIFD_TEST_CHANNELS 4
 
 unsigned start_address;
 unsigned end_address;
@@ -207,6 +208,51 @@ static QList *migrate_start_get_qmp_capabilities(const MigrateStart *args)
     return capabilities;
 }
 
+static void migrate_start_set_capabilities(QTestState *from, QTestState *to,
+                                           MigrateStart *args)
+{
+    /*
+     * MigrationCapability_lookup and MIGRATION_CAPABILITY_ constants
+     * are from qapi-types-migration.h.
+     */
+    for (uint8_t i = 0; i < MIGRATION_CAPABILITY__MAX; i++) {
+        if (!args->caps[i]) {
+            continue;
+        }
+        if (from) {
+            migrate_set_capability(from,
+                            MigrationCapability_lookup.array[i], true);
+        }
+        if (to) {
+            migrate_set_capability(to,
+                            MigrationCapability_lookup.array[i], true);
+        }
+    }
+
+    /*
+     * Always enable migration events.  Libvirt always uses it, let's try
+     * to mimic as closer as that.
+     */
+    migrate_set_capability(from, "events", true);
+    if (!args->defer_target_connect) {
+        migrate_set_capability(to, "events", true);
+    }
+
+    /*
+     * Default number of channels should be fine for most
+     * tests. Individual tests can override by calling
+     * migrate_set_parameter() directly.
+     */
+    if (args->caps[MIGRATION_CAPABILITY_MULTIFD]) {
+        migrate_set_parameter_int(from, "multifd-channels",
+                                  MULTIFD_TEST_CHANNELS);
+        migrate_set_parameter_int(to, "multifd-channels",
+                                  MULTIFD_TEST_CHANNELS);
+    }
+
+    return;
+}
+
 int migrate_start(QTestState **from, QTestState **to, const char *uri,
                   MigrateStart *args)
 {
@@ -379,14 +425,7 @@ int migrate_start(QTestState **from, QTestState **to, const char *uri,
         unlink(shmem_path);
     }
 
-    /*
-     * Always enable migration events.  Libvirt always uses it, let's try
-     * to mimic as closer as that.
-     */
-    migrate_set_capability(*from, "events", true);
-    if (!args->defer_target_connect) {
-        migrate_set_capability(*to, "events", true);
-    }
+    migrate_start_set_capabilities(*from, *to, args);
 
     return 0;
 }
@@ -432,6 +471,10 @@ static int migrate_postcopy_prepare(QTestState **from_ptr,
 {
     QTestState *from, *to;
 
+    /* set postcopy capabilities */
+    args->start.caps[MIGRATION_CAPABILITY_POSTCOPY_BLOCKTIME] = true;
+    args->start.caps[MIGRATION_CAPABILITY_POSTCOPY_RAM] = true;
+
     if (migrate_start(&from, &to, "defer", &args->start)) {
         return -1;
     }
@@ -440,17 +483,7 @@ static int migrate_postcopy_prepare(QTestState **from_ptr,
         args->postcopy_data = args->start_hook(from, to);
     }
 
-    migrate_set_capability(from, "postcopy-ram", true);
-    migrate_set_capability(to, "postcopy-ram", true);
-    migrate_set_capability(to, "postcopy-blocktime", true);
-
-    if (args->postcopy_preempt) {
-        migrate_set_capability(from, "postcopy-preempt", true);
-        migrate_set_capability(to, "postcopy-preempt", true);
-    }
-
     migrate_ensure_non_converge(from);
-
     migrate_prepare_for_dirty_mem(from);
     qtest_qmp_assert_success(to, "{ 'execute': 'migrate-incoming',"
                              "  'arguments': { "
@@ -948,15 +981,9 @@ void *migrate_hook_start_precopy_tcp_multifd_common(QTestState *from,
                                                     QTestState *to,
                                                     const char *method)
 {
-    migrate_set_parameter_int(from, "multifd-channels", 16);
-    migrate_set_parameter_int(to, "multifd-channels", 16);
-
     migrate_set_parameter_str(from, "multifd-compression", method);
     migrate_set_parameter_str(to, "multifd-compression", method);
 
-    migrate_set_capability(from, "multifd", true);
-    migrate_set_capability(to, "multifd", true);
-
     /* Start incoming migration from the 1st socket */
     migrate_incoming_qmp(to, "tcp:127.0.0.1:0", NULL, "{}");
 
diff --git a/tests/qtest/migration/misc-tests.c b/tests/qtest/migration/misc-tests.c
index 2e612d9e38..54995256d8 100644
--- a/tests/qtest/migration/misc-tests.c
+++ b/tests/qtest/migration/misc-tests.c
@@ -98,6 +98,7 @@ static void test_ignore_shared(void)
     QTestState *from, *to;
     MigrateStart args = {
         .use_shmem = true,
+        .caps[MIGRATION_CAPABILITY_X_IGNORE_SHARED] = true,
     };
 
     if (migrate_start(&from, &to, uri, &args)) {
@@ -107,9 +108,6 @@ static void test_ignore_shared(void)
     migrate_ensure_non_converge(from);
     migrate_prepare_for_dirty_mem(from);
 
-    migrate_set_capability(from, "x-ignore-shared", true);
-    migrate_set_capability(to, "x-ignore-shared", true);
-
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
 
diff --git a/tests/qtest/migration/postcopy-tests.c b/tests/qtest/migration/postcopy-tests.c
index 982457bed1..483e3ff99f 100644
--- a/tests/qtest/migration/postcopy-tests.c
+++ b/tests/qtest/migration/postcopy-tests.c
@@ -39,7 +39,9 @@ static void test_postcopy_suspend(void)
 static void test_postcopy_preempt(void)
 {
     MigrateCommon args = {
-        .postcopy_preempt = true,
+        .start = {
+            .caps[MIGRATION_CAPABILITY_POSTCOPY_PREEMPT] = true,
+        },
     };
 
     test_postcopy_common(&args);
@@ -73,7 +75,9 @@ static void test_postcopy_recovery_fail_reconnect(void)
 static void test_postcopy_preempt_recovery(void)
 {
     MigrateCommon args = {
-        .postcopy_preempt = true,
+        .start = {
+            .caps[MIGRATION_CAPABILITY_POSTCOPY_PREEMPT] = true,
+        },
     };
 
     test_postcopy_recovery_common(&args);
diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
index 565630dddf..87b0a7e8ef 100644
--- a/tests/qtest/migration/precopy-tests.c
+++ b/tests/qtest/migration/precopy-tests.c
@@ -170,23 +170,14 @@ static void test_precopy_tcp_plain(void)
     test_precopy_common(&args);
 }
 
-static void *migrate_hook_start_switchover_ack(QTestState *from, QTestState *to)
-{
-
-    migrate_set_capability(from, "return-path", true);
-    migrate_set_capability(to, "return-path", true);
-
-    migrate_set_capability(from, "switchover-ack", true);
-    migrate_set_capability(to, "switchover-ack", true);
-
-    return NULL;
-}
-
 static void test_precopy_tcp_switchover_ack(void)
 {
     MigrateCommon args = {
         .listen_uri = "tcp:127.0.0.1:0",
-        .start_hook = migrate_hook_start_switchover_ack,
+        .start = {
+            .caps[MIGRATION_CAPABILITY_RETURN_PATH] = true,
+            .caps[MIGRATION_CAPABILITY_SWITCHOVER_ACK] = true,
+        },
         /*
          * Source VM must be running in order to consider the switchover ACK
          * when deciding to do switchover or not.
@@ -455,6 +446,9 @@ static void test_multifd_tcp_uri_none(void)
     MigrateCommon args = {
         .listen_uri = "defer",
         .start_hook = migrate_hook_start_precopy_tcp_multifd,
+        .start = {
+            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
+        },
         /*
          * Multifd is more complicated than most of the features, it
          * directly takes guest page buffers when sending, make sure
@@ -470,6 +464,9 @@ static void test_multifd_tcp_zero_page_legacy(void)
     MigrateCommon args = {
         .listen_uri = "defer",
         .start_hook = migrate_hook_start_precopy_tcp_multifd_zero_page_legacy,
+        .start = {
+            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
+        },
         /*
          * Multifd is more complicated than most of the features, it
          * directly takes guest page buffers when sending, make sure
@@ -485,6 +482,9 @@ static void test_multifd_tcp_no_zero_page(void)
     MigrateCommon args = {
         .listen_uri = "defer",
         .start_hook = migrate_hook_start_precopy_tcp_multifd_no_zero_page,
+        .start = {
+            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
+        },
         /*
          * Multifd is more complicated than most of the features, it
          * directly takes guest page buffers when sending, make sure
@@ -501,6 +501,9 @@ static void test_multifd_tcp_channels_none(void)
         .listen_uri = "defer",
         .start_hook = migrate_hook_start_precopy_tcp_multifd,
         .live = true,
+        .start = {
+            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
+        },
         .connect_channels = ("[ { 'channel-type': 'main',"
                              "    'addr': { 'transport': 'socket',"
                              "              'type': 'inet',"
diff --git a/tests/qtest/migration/tls-tests.c b/tests/qtest/migration/tls-tests.c
index 2cb4a44bcd..72f44defbb 100644
--- a/tests/qtest/migration/tls-tests.c
+++ b/tests/qtest/migration/tls-tests.c
@@ -375,9 +375,11 @@ static void test_postcopy_tls_psk(void)
 static void test_postcopy_preempt_tls_psk(void)
 {
     MigrateCommon args = {
-        .postcopy_preempt = true,
         .start_hook = migrate_hook_start_tls_psk_match,
         .end_hook = migrate_hook_end_tls_psk,
+        .start = {
+            .caps[MIGRATION_CAPABILITY_POSTCOPY_PREEMPT] = true,
+        },
     };
 
     test_postcopy_common(&args);
@@ -397,9 +399,11 @@ static void test_postcopy_recovery_tls_psk(void)
 static void test_postcopy_preempt_all(void)
 {
     MigrateCommon args = {
-        .postcopy_preempt = true,
         .start_hook = migrate_hook_start_tls_psk_match,
         .end_hook = migrate_hook_end_tls_psk,
+        .start = {
+            .caps[MIGRATION_CAPABILITY_POSTCOPY_PREEMPT] = true,
+        },
     };
 
     test_postcopy_recovery_common(&args);
@@ -631,6 +635,9 @@ static void test_multifd_tcp_tls_psk_match(void)
         .listen_uri = "defer",
         .start_hook = migrate_hook_start_multifd_tcp_tls_psk_match,
         .end_hook = migrate_hook_end_tls_psk,
+        .start = {
+            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
+        },
     };
     test_precopy_common(&args);
 }
@@ -640,6 +647,7 @@ static void test_multifd_tcp_tls_psk_mismatch(void)
     MigrateCommon args = {
         .start = {
             .hide_stderr = true,
+            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
         },
         .listen_uri = "defer",
         .start_hook = migrate_hook_start_multifd_tcp_tls_psk_mismatch,
@@ -656,6 +664,9 @@ static void test_multifd_tcp_tls_x509_default_host(void)
         .listen_uri = "defer",
         .start_hook = migrate_hook_start_multifd_tls_x509_default_host,
         .end_hook = migrate_hook_end_tls_x509,
+        .start = {
+            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
+        },
     };
     test_precopy_common(&args);
 }
@@ -666,6 +677,9 @@ static void test_multifd_tcp_tls_x509_override_host(void)
         .listen_uri = "defer",
         .start_hook = migrate_hook_start_multifd_tls_x509_override_host,
         .end_hook = migrate_hook_end_tls_x509,
+        .start = {
+            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
+        },
     };
     test_precopy_common(&args);
 }
@@ -688,6 +702,7 @@ static void test_multifd_tcp_tls_x509_mismatch_host(void)
     MigrateCommon args = {
         .start = {
             .hide_stderr = true,
+            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
         },
         .listen_uri = "defer",
         .start_hook = migrate_hook_start_multifd_tls_x509_mismatch_host,
@@ -703,6 +718,9 @@ static void test_multifd_tcp_tls_x509_allow_anon_client(void)
         .listen_uri = "defer",
         .start_hook = migrate_hook_start_multifd_tls_x509_allow_anon_client,
         .end_hook = migrate_hook_end_tls_x509,
+        .start = {
+            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
+        },
     };
     test_precopy_common(&args);
 }
@@ -712,6 +730,7 @@ static void test_multifd_tcp_tls_x509_reject_anon_client(void)
     MigrateCommon args = {
         .start = {
             .hide_stderr = true,
+            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
         },
         .listen_uri = "defer",
         .start_hook = migrate_hook_start_multifd_tls_x509_reject_anon_client,
-- 
2.48.1


