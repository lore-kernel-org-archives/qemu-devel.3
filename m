Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD504C3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 17:09:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHQS2-0000IU-43; Tue, 20 May 2025 13:08:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uHQS0-0000IK-PP
 for qemu-devel@nongnu.org; Tue, 20 May 2025 13:08:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uHQRy-0001ER-NW
 for qemu-devel@nongnu.org; Tue, 20 May 2025 13:08:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747760902;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=01YMP5taIjwAvddt2i07PXPU0sX/XjmcmoeCbymdLxA=;
 b=DuKwTQqHnjfktOh9emuzhJmMAmu4dNwNuf/vyWpECKsEgJ9gKPBQA6YNYwLTkG4xi/9Ir4
 KqMkXUp+LU1atCJ59E8dbpSADZz2gZOPGLNQkwqywiHfQAjU/wHccT22D2bJOO8JA0l7vZ
 ft2bcFdURykwqhDXji9/e2QmAyo9+bs=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-fNl9qgLJMeS_bwx0Neu4Cw-1; Tue, 20 May 2025 13:08:21 -0400
X-MC-Unique: fNl9qgLJMeS_bwx0Neu4Cw-1
X-Mimecast-MFC-AGG-ID: fNl9qgLJMeS_bwx0Neu4Cw_1747760900
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6f8e114ef64so32230416d6.1
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 10:08:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747760900; x=1748365700;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=01YMP5taIjwAvddt2i07PXPU0sX/XjmcmoeCbymdLxA=;
 b=vb/oNxUqoejTVoATJg5x5F5U+or6lGSILsYu3ES3nIjxDO6rD6POmbtt9toFgZ44Xi
 Os7kQDG25iowRAy0uC5Wgax/GoJYIokcHsEUNLWAyF29rwbKumj+Je/kjAPRB/kvRVT8
 MAiv7dksMn34x+Lf/G6ZVQq4nwfdrWip3tmfEXpJYe/f1qRhHjlOqga/fDR1k2YwicaG
 YlPUrBnQ7b82aHsF5NTIrU5XhpXdaltgXuglyhu2qphSN9RnZR9YwzF+apyM3mbwB/0A
 bFlE1IR/tB3CS7TB6YovH2jJaRJkV0Q6JoXg6bdAV4jgYIWBSSvegZCDLwpKp+oo3MgE
 GdIg==
X-Gm-Message-State: AOJu0YwQHBdR6E85563bJzfxcZTxTFebP9leVWNI4FC42dCgCqMWVJlq
 swRg2wKa3JcFTbc+05QbKWVeqffnr7LTZMYMmKnivklyLqf3mAKX6OKwDi6EAoU3ppuEGKlPkfS
 82CMx1Zx4CNYRWqdXBYvlA3Iu9b5kKGrxq1O0z1cKA3j7iiCeUelwYKWQhxgy/wLUqJ6C81m8rp
 tVU/2pcCZNix1p1Wwk4bfJ5HjIkLRTDLGFuzjq3A==
X-Gm-Gg: ASbGncvPMV0o90AKW3fCsXSbsruciWix3TP7LLEjB9rw5CisOVshDx0iPBx0Frf4cEP
 D5YLRhx6eIFEYQfmaeK8ixr4xoI991X5lj3zaiDEpIO2Nhq0ka1on7KnCYnZLsWpgVsu6O44zj+
 9/HjKfrFxZref7ePwPZYA78fzVipeV1BcRfuahbgUAvN07q3S9bjIdVwQHMSakOQJGmYxXBHdA8
 UnGvhV9FRIPgQE6gLCEOABCE2HKfzZnZfoxAuv2lkHNJXUkq1Fb4SbnH7wvfOT+stQwTi3e7J/s
X-Received: by 2002:a05:622a:4005:b0:494:48b1:a03d with SMTP id
 d75a77b69052e-494b093a12dmr293141311cf.34.1747760899884; 
 Tue, 20 May 2025 10:08:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBtN0Jtppega6vHyPnOfgc8RcpYEk1Blkg/X/w3cpR7PL0MqyYaq9MBBXSrJXS+WCq8G7avQ==
X-Received: by 2002:a05:620a:4729:b0:7c5:5fa0:4617 with SMTP id
 af79cd13be357-7cd47fc5ad5mr2841983385a.40.1747760888467; 
 Tue, 20 May 2025 10:08:08 -0700 (PDT)
Received: from x1.com ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7cd467be47bsm763846585a.16.2025.05.20.10.08.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 10:08:07 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Stefan Hajnoczi <stefanha@redhat.com>,
 peterx@redhat.com, Prasad Pandit <pjp@fedoraproject.org>
Subject: [PULL 09/12] tests/qtest/migration: add postcopy tests with multifd
Date: Tue, 20 May 2025 13:07:48 -0400
Message-ID: <20250520170751.786787-10-peterx@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520170751.786787-1-peterx@redhat.com>
References: <20250520170751.786787-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Add new qtests to run postcopy migration with multifd
channels enabled.

Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>
Link: https://lore.kernel.org/r/20250512125124.147064-4-ppandit@redhat.com
[peterx: rename all new tests to be under /migration/multifd+postcopy/]
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/qtest/migration/compression-tests.c | 18 ++++++++
 tests/qtest/migration/postcopy-tests.c    | 27 ++++++++++++
 tests/qtest/migration/precopy-tests.c     | 28 ++++++++++++-
 tests/qtest/migration/tls-tests.c         | 51 +++++++++++++++++++++++
 4 files changed, 122 insertions(+), 2 deletions(-)

diff --git a/tests/qtest/migration/compression-tests.c b/tests/qtest/migration/compression-tests.c
index 41e79f031b..b827665b8e 100644
--- a/tests/qtest/migration/compression-tests.c
+++ b/tests/qtest/migration/compression-tests.c
@@ -42,6 +42,20 @@ static void test_multifd_tcp_zstd(void)
     };
     test_precopy_common(&args);
 }
+
+static void test_multifd_postcopy_tcp_zstd(void)
+{
+    MigrateCommon args = {
+        .listen_uri = "defer",
+        .start = {
+            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
+            .caps[MIGRATION_CAPABILITY_POSTCOPY_RAM] = true,
+        },
+        .start_hook = migrate_hook_start_precopy_tcp_multifd_zstd,
+    };
+
+    test_precopy_common(&args);
+}
 #endif /* CONFIG_ZSTD */
 
 #ifdef CONFIG_QATZIP
@@ -184,6 +198,10 @@ void migration_test_add_compression(MigrationTestEnv *env)
 #ifdef CONFIG_ZSTD
     migration_test_add("/migration/multifd/tcp/plain/zstd",
                        test_multifd_tcp_zstd);
+    if (env->has_uffd) {
+        migration_test_add("/migration/multifd+postcopy/tcp/plain/zstd",
+                           test_multifd_postcopy_tcp_zstd);
+    }
 #endif
 
 #ifdef CONFIG_QATZIP
diff --git a/tests/qtest/migration/postcopy-tests.c b/tests/qtest/migration/postcopy-tests.c
index 483e3ff99f..3773525843 100644
--- a/tests/qtest/migration/postcopy-tests.c
+++ b/tests/qtest/migration/postcopy-tests.c
@@ -94,6 +94,29 @@ static void migration_test_add_postcopy_smoke(MigrationTestEnv *env)
     }
 }
 
+static void test_multifd_postcopy(void)
+{
+    MigrateCommon args = {
+        .start = {
+            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
+        },
+    };
+
+    test_postcopy_common(&args);
+}
+
+static void test_multifd_postcopy_preempt(void)
+{
+    MigrateCommon args = {
+        .start = {
+            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
+            .caps[MIGRATION_CAPABILITY_POSTCOPY_PREEMPT] = true,
+        },
+    };
+
+    test_postcopy_common(&args);
+}
+
 void migration_test_add_postcopy(MigrationTestEnv *env)
 {
     migration_test_add_postcopy_smoke(env);
@@ -114,6 +137,10 @@ void migration_test_add_postcopy(MigrationTestEnv *env)
             "/migration/postcopy/recovery/double-failures/reconnect",
             test_postcopy_recovery_fail_reconnect);
 
+        migration_test_add("/migration/multifd+postcopy/plain",
+                           test_multifd_postcopy);
+        migration_test_add("/migration/multifd+postcopy/preempt/plain",
+                           test_multifd_postcopy_preempt);
         if (env->is_x86) {
             migration_test_add("/migration/postcopy/suspend",
                                test_postcopy_suspend);
diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
index a62d3c5378..bb38292550 100644
--- a/tests/qtest/migration/precopy-tests.c
+++ b/tests/qtest/migration/precopy-tests.c
@@ -569,7 +569,7 @@ static void test_multifd_tcp_channels_none(void)
  *
  *  And see that it works
  */
-static void test_multifd_tcp_cancel(void)
+static void test_multifd_tcp_cancel(bool postcopy_ram)
 {
     MigrateStart args = {
         .hide_stderr = true,
@@ -583,6 +583,11 @@ static void test_multifd_tcp_cancel(void)
     migrate_ensure_non_converge(from);
     migrate_prepare_for_dirty_mem(from);
 
+    if (postcopy_ram) {
+        migrate_set_capability(from, "postcopy-ram", true);
+        migrate_set_capability(to, "postcopy-ram", true);
+    }
+
     migrate_set_parameter_int(from, "multifd-channels", 16);
     migrate_set_parameter_int(to, "multifd-channels", 16);
 
@@ -624,6 +629,10 @@ static void test_multifd_tcp_cancel(void)
         return;
     }
 
+    if (postcopy_ram) {
+        migrate_set_capability(to2, "postcopy-ram", true);
+    }
+
     migrate_set_parameter_int(to2, "multifd-channels", 16);
 
     migrate_set_capability(to2, "multifd", true);
@@ -647,6 +656,16 @@ static void test_multifd_tcp_cancel(void)
     migrate_end(from, to2, true);
 }
 
+static void test_multifd_precopy_tcp_cancel(void)
+{
+    test_multifd_tcp_cancel(false);
+}
+
+static void test_multifd_postcopy_tcp_cancel(void)
+{
+    test_multifd_tcp_cancel(true);
+}
+
 static void test_cancel_src_after_failed(QTestState *from, QTestState *to,
                                          const char *uri, const char *phase)
 {
@@ -1233,7 +1252,12 @@ static void migration_test_add_precopy_smoke(MigrationTestEnv *env)
     migration_test_add("/migration/multifd/tcp/uri/plain/none",
                        test_multifd_tcp_uri_none);
     migration_test_add("/migration/multifd/tcp/plain/cancel",
-                       test_multifd_tcp_cancel);
+                       test_multifd_precopy_tcp_cancel);
+    if (env->has_uffd) {
+        migration_test_add("/migration/multifd+postcopy/tcp/plain/cancel",
+                           test_multifd_postcopy_tcp_cancel);
+    }
+
 #ifdef CONFIG_RDMA
     migration_test_add("/migration/precopy/rdma/plain",
                        test_precopy_rdma_plain);
diff --git a/tests/qtest/migration/tls-tests.c b/tests/qtest/migration/tls-tests.c
index 72f44defbb..21e9fec87d 100644
--- a/tests/qtest/migration/tls-tests.c
+++ b/tests/qtest/migration/tls-tests.c
@@ -395,6 +395,19 @@ static void test_postcopy_recovery_tls_psk(void)
     test_postcopy_recovery_common(&args);
 }
 
+static void test_multifd_postcopy_recovery_tls_psk(void)
+{
+    MigrateCommon args = {
+        .start_hook = migrate_hook_start_tls_psk_match,
+        .end_hook = migrate_hook_end_tls_psk,
+        .start = {
+            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
+        },
+    };
+
+    test_postcopy_recovery_common(&args);
+}
+
 /* This contains preempt+recovery+tls test altogether */
 static void test_postcopy_preempt_all(void)
 {
@@ -409,6 +422,20 @@ static void test_postcopy_preempt_all(void)
     test_postcopy_recovery_common(&args);
 }
 
+static void test_multifd_postcopy_preempt_recovery_tls_psk(void)
+{
+    MigrateCommon args = {
+        .start_hook = migrate_hook_start_tls_psk_match,
+        .end_hook = migrate_hook_end_tls_psk,
+        .start = {
+            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
+            .caps[MIGRATION_CAPABILITY_POSTCOPY_PREEMPT] = true,
+        },
+    };
+
+    test_postcopy_recovery_common(&args);
+}
+
 static void test_precopy_unix_tls_psk(void)
 {
     g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
@@ -657,6 +684,21 @@ static void test_multifd_tcp_tls_psk_mismatch(void)
     test_precopy_common(&args);
 }
 
+static void test_multifd_postcopy_tcp_tls_psk_match(void)
+{
+    MigrateCommon args = {
+        .start = {
+            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
+            .caps[MIGRATION_CAPABILITY_POSTCOPY_RAM] = true,
+        },
+        .listen_uri = "defer",
+        .start_hook = migrate_hook_start_multifd_tcp_tls_psk_match,
+        .end_hook = migrate_hook_end_tls_psk,
+    };
+
+    test_precopy_common(&args);
+}
+
 #ifdef CONFIG_TASN1
 static void test_multifd_tcp_tls_x509_default_host(void)
 {
@@ -774,6 +816,11 @@ void migration_test_add_tls(MigrationTestEnv *env)
                            test_postcopy_preempt_tls_psk);
         migration_test_add("/migration/postcopy/preempt/recovery/tls/psk",
                            test_postcopy_preempt_all);
+        migration_test_add("/migration/multifd+postcopy/recovery/tls/psk",
+                           test_multifd_postcopy_recovery_tls_psk);
+        migration_test_add(
+            "/migration/multifd+postcopy/preempt/recovery/tls/psk",
+            test_multifd_postcopy_preempt_recovery_tls_psk);
     }
 #ifdef CONFIG_TASN1
     migration_test_add("/migration/precopy/unix/tls/x509/default-host",
@@ -805,6 +852,10 @@ void migration_test_add_tls(MigrationTestEnv *env)
                        test_multifd_tcp_tls_psk_match);
     migration_test_add("/migration/multifd/tcp/tls/psk/mismatch",
                        test_multifd_tcp_tls_psk_mismatch);
+    if (env->has_uffd) {
+        migration_test_add("/migration/multifd+postcopy/tcp/tls/psk/match",
+                           test_multifd_postcopy_tcp_tls_psk_match);
+    }
 #ifdef CONFIG_TASN1
     migration_test_add("/migration/multifd/tcp/tls/x509/default-host",
                        test_multifd_tcp_tls_x509_default_host);
-- 
2.49.0


