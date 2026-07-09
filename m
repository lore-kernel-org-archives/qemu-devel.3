Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEC14C44508
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 13:01:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whoNB-0001gK-Mj; Thu, 09 Jul 2026 09:01:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phind.uet@gmail.com>)
 id 1whoN5-0001dI-6C
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 09:00:56 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phind.uet@gmail.com>)
 id 1whoN2-00006u-K5
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 09:00:54 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-ca80d708489so548942a12.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 06:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783602051; x=1784206851; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZaEIfqybV7I+19pe9ex1wILGmf1tN0Ou6N7PZUVaFys=;
 b=X0fNRs+lQwO1DVp2lDS3xUkBEgrzl09J+el6aFUcWWakbpsbxyYtKW6ovFx9WiK0/7
 pYt+7fFLj1Hsi1ho/66utcJwxU4WziRSAz1aKemNJ7HGsoMiPK5WvR0HhAlOG5uiqg5A
 syOm6wTy8Bw6GWCTKybYXnt9fm83o6WNfdWWzm5duPT54vH1nrNHHlwiYwMiRJTCA5O1
 YvthAOZiNIn7BSZS5TRqLXYam4cBEfknYEgVmBWCry3oTPHHpOZZotmRkafAyM5FFWBz
 xx4n9Fdmjl2uHChRcliBDbEKtdHvDKDLcHNZ0Htit9lYkGI9H/K2tdyBKSvFJdaL1sOr
 jzVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783602051; x=1784206851;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZaEIfqybV7I+19pe9ex1wILGmf1tN0Ou6N7PZUVaFys=;
 b=Un/LFN31TZMWBbcnT7/UKGhWEMai+obxH583iMw1rqyji23t9tLio5o5j0Y2+EIP21
 DZFnviIIj+4SuB0UNX5up+z3N2n5sLNJREmKP6f/FQBveYopcys6uvRABQPdTFeSZ7qF
 hF5zG71kk5f6ytWdKE2fpBDbcG4xehhcxNabbkqmnZVbakz5a/n2AnD9NAH1Xg/ImXf9
 5zLZVbQgWz9NBivVmqLazcxFx89PQX+znslGUvbu92MCUCRxW2ErEJpBj7HOt/L7eHsJ
 IKdRKxmevabl0Mla4i93PnCiAd3pjV3s0D4L9qV4Xjstn6ZpZZDVKP8ewkm/K5SEzkn3
 Bicw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrIQmH/6Bu00HVW9iRLirq6UVYlZbY3o5tjKfwLoFLOQuos7ihxJSpIJPR9OxrLX9fjlq3ShsYwrkPS@nongnu.org
X-Gm-Message-State: AOJu0YzC6zoidff9NwnHeiZ2BzQKGeHYguJc1u9aaYf0tmmOlicrpsgr
 3xgHNnVOgL63VRjQNZMMsdhaYe/4eXa+b0jBhsfMXtu4mQA5VCE9wklZ
X-Gm-Gg: AfdE7cmjcxhW3rhyJor8HlCz5AmtB0hQiIpk2dNC3cWWpRTHHNDQfWdROCaxoCePLjS
 zu37EByaSga7/fo+kKJo9hCmUCK2yhTtTYLMt/55vVY6vqP2dU4LZxGtI72stzRtKWEnTgrkX/i
 HyTrK1voGAoot3pg+RslOaC/fU4pwegp9DMXpORow4cMgp7IbPfKa5IXK0SNDYDCNjHlgcXc9NM
 8NyEySRJI1BH1BuDEpblt0vFjWQR3rvZk+HRADFnd0oZHe1sbfmEkJNLX/UpCuF+miYy6pGSAwO
 ctXwgIDLyYWWIzr8GFALE9hzC9beln+xkVpLXKS20Ylo38tqOUorHCr5Kk393f5hGvLTUOJm4Of
 EICvjyW2rDq66nYJR91dUfe8EURUp07YSN6TELK0K3MMbyQxXyoj1YxHnXx4+e5zAZPdJAzbwbt
 YOKtWaFxv8TA6hRldusLEg4aL1W5Oab5CBTShmobCwbULUhwqndXGhPoFT
X-Received: by 2002:a05:6a20:d81a:b0:3bf:a8fa:a7b1 with SMTP id
 adf61e73a8af0-3c0d6c6f129mr3623269637.37.1783602050476; 
 Thu, 09 Jul 2026 06:00:50 -0700 (PDT)
Received: from C02G720XMD6P.sg.corp.seagroup.com ([111.223.92.222])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-31174ac14f2sm32908611eec.27.2026.07.09.06.00.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 06:00:49 -0700 (PDT)
From: phind.uet@gmail.com
To: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Nguyen Dinh Phi <phind.uet@gmail.com>,
	qemu-devel@nongnu.org
Subject: [PATCH 3/3] tests/migration: Add chain (A to B to C) precopy
 migration tests
Date: Thu,  9 Jul 2026 21:00:27 +0800
Message-ID: <20260709130032.58667-4-phind.uet@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260709130032.58667-1-phind.uet@gmail.com>
References: <20260709130032.58667-1-phind.uet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=phind.uet@gmail.com; helo=mail-pg1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Nguyen Dinh Phi <phind.uet@gmail.com>

Extract migrate_precopy_hop() from the SUCCESS path of test_precopy_common()
to wrap the per-hop migration sequence of a succesfull migration.
test_precopy_common() delegates its success path to this helper; failure
paths are handled directly.

Introduce test_precopy_chain(), a helper that drives two consecutive
migration hops on already-running processes: first A→B, then B→C, both
hops are expected to be success.

Add two test cases exercising the new helper:
    - /migration/precopy/tcp/plain/chain
    - /migration/multifd/tcp/channels/plain/chain

Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
---
 tests/qtest/migration/framework.c     | 195 +++++++++++++++++---------
 tests/qtest/migration/framework.h     |   1 +
 tests/qtest/migration/precopy-tests.c |  23 +++
 3 files changed, 153 insertions(+), 66 deletions(-)

diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index a7dffeb82c..b4218b2f23 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -883,28 +883,25 @@ void test_postcopy_recovery_common(MigrateCommon *args,
     migrate_postcopy_complete(from, to, hook_data, args);
 }
 
-int test_precopy_common(MigrateCommon *args)
+/*
+ * Perform one precopy migration hop on an already-running (from, to) pair.
+ * Both processes must have migrate_setup_instance() called before this
+ * function.
+ * Always expects the hop to succeed.
+ *
+ */
+static void migrate_precopy_hop(QTestState *from, QTestState *to,
+                                 const char *listen_uri,
+                                 const char *connect_uri,
+                                 MigrateCommon *args)
 {
-    QTestState *from, *to;
-    void *data_hook = NULL;
     QObject *channels = NULL;
-    const char *listen_uri = args->uri ?: "tcp:127.0.0.1:0";
-
-    if (migrate_start(&from, &to, &args->start)) {
-        return -1;
-    }
-
-    if (args->start_hook) {
-        data_hook = args->start_hook(from, to);
-    }
+    int iters;
 
     migrate_incoming_qmp(to, listen_uri, NULL, "{}");
 
-    /* Wait for the first serial output from the source */
-    if (args->result == MIG_TEST_SUCCEED) {
-        wait_for_serial(qtest_get_serial_path(from));
-        wait_for_suspend(from, &src_state);
-    }
+    wait_for_serial(qtest_get_serial_path(from));
+    wait_for_suspend(from, &src_state);
 
     if (args->live) {
         migrate_ensure_non_converge(from);
@@ -913,76 +910,104 @@ int test_precopy_common(MigrateCommon *args)
         /*
          * Testing non-live migration, we allow it to run at
          * full speed to ensure short test case duration.
-         * For tests expected to fail, we don't need to
-         * change anything.
          */
-        if (args->result == MIG_TEST_SUCCEED) {
-            qtest_qmp_assert_success(from, "{ 'execute' : 'stop'}");
-            wait_for_stop(from, &src_state);
-            migrate_ensure_converge(from);
-        }
+        qtest_qmp_assert_success(from, "{ 'execute' : 'stop'}");
+        wait_for_stop(from, &src_state);
+        migrate_ensure_converge(from);
     }
 
     if (args->connect_channels) {
         channels = qobject_from_json(args->connect_channels, &error_abort);
     }
 
-    if (args->result == MIG_TEST_QMP_ERROR) {
-        migrate_qmp_fail(from, args->uri, channels, "{}");
-        goto finish;
-    }
+    migrate_qmp(from, to, connect_uri, channels, "{}");
 
-    migrate_qmp(from, to, args->uri, channels, "{}");
+    if (args->live) {
+        /*
+         * For initial iteration(s) we must do a full pass,
+         * but for the final iteration, we need only wait
+         * for some dirty mem before switching to converge.
+         */
+        /*
+         * Avoid changing the args->iterations by using a local copy
+         */
+        iters = args->iterations;
+        while (iters > 1) {
+            wait_for_migration_pass(from, &src_state);
+            iters--;
+        }
+        migrate_wait_for_dirty_mem(from, to);
+
+        migrate_ensure_converge(from);
+
+        /*
+         * We do this first, as it has a timeout to stop us
+         * hanging forever if migration didn't converge
+         */
+        wait_for_migration_complete(from);
+
+        wait_for_stop(from, &src_state);
 
-    if (args->result != MIG_TEST_SUCCEED) {
-        bool allow_active = args->result == MIG_TEST_FAIL;
-        wait_for_migration_fail(from, allow_active);
     } else {
-        if (args->live) {
-            /*
-             * For initial iteration(s) we must do a full pass,
-             * but for the final iteration, we need only wait
-             * for some dirty mem before switching to converge
-             */
-            while (args->iterations > 1) {
-                wait_for_migration_pass(from, &src_state);
-                args->iterations--;
-            }
-            migrate_wait_for_dirty_mem(from, to);
+        wait_for_migration_complete(from);
+        /*
+         * Must wait for dst to finish reading all incoming
+         * data on the socket before issuing 'cont' otherwise
+         * it'll be ignored
+         */
+        wait_for_migration_complete(to);
 
-            migrate_ensure_converge(from);
+        qtest_qmp_assert_success(to, "{ 'execute' : 'cont'}");
+    }
 
-            /*
-             * We do this first, as it has a timeout to stop us
-             * hanging forever if migration didn't converge
-             */
-            wait_for_migration_complete(from);
+    wait_for_resume(to, &dst_state);
+
+    if (args->start.suspend_me) {
+        /* wakeup succeeds only if guest is suspended */
+        qtest_qmp_assert_success(to, "{'execute': 'system_wakeup'}");
+    }
 
-            wait_for_stop(from, &src_state);
+    wait_for_serial(qtest_get_serial_path(to));
+}
 
-        } else {
-            wait_for_migration_complete(from);
-            /*
-             * Must wait for dst to finish reading all incoming
-             * data on the socket before issuing 'cont' otherwise
-             * it'll be ignored
-             */
-            wait_for_migration_complete(to);
+int test_precopy_common(MigrateCommon *args)
+{
+    QTestState *from, *to;
+    void *data_hook = NULL;
+    const char *listen_uri = args->uri ?: "tcp:127.0.0.1:0";
 
-            qtest_qmp_assert_success(to, "{ 'execute' : 'cont'}");
-        }
+    if (migrate_start(&from, &to, &args->start)) {
+        return -1;
+    }
+
+    if (args->start_hook) {
+        data_hook = args->start_hook(from, to);
+    }
 
-        wait_for_resume(to, &dst_state);
+    if (args->result == MIG_TEST_SUCCEED) {
+        migrate_precopy_hop(from, to, listen_uri, args->uri, args);
+    } else {
+        QObject *channels = NULL;
+
+        migrate_incoming_qmp(to, listen_uri, NULL, "{}");
+
+        if (args->live) {
+            migrate_ensure_non_converge(from);
+            migrate_prepare_for_dirty_mem(from);
+        }
 
-        if (args->start.suspend_me) {
-            /* wakeup succeeds only if guest is suspended */
-            qtest_qmp_assert_success(to, "{'execute': 'system_wakeup'}");
+        if (args->connect_channels) {
+            channels = qobject_from_json(args->connect_channels, &error_abort);
         }
 
-        wait_for_serial(qtest_get_serial_path(to));
+        if (args->result == MIG_TEST_QMP_ERROR) {
+            migrate_qmp_fail(from, args->uri, channels, "{}");
+        } else {
+            migrate_qmp(from, to, args->uri, channels, "{}");
+            wait_for_migration_fail(from, args->result == MIG_TEST_FAIL);
+        }
     }
 
-finish:
     if (args->end_hook) {
         args->end_hook(from, to, data_hook);
     }
@@ -1000,6 +1025,44 @@ void test_precopy_unix_common(MigrateCommon *args)
     test_precopy_common(args);
 }
 
+int test_precopy_chain(MigrateCommon *args)
+{
+    QTestState *from, *to, *to2;
+    const char *listen_uri = args->uri ?: "tcp:127.0.0.1:0";
+
+    /*
+     * Hook callbacks operate on a fixed (from, to) pair; they do not
+     * compose across multiple migration legs.
+     */
+    g_assert(!args->start_hook && !args->end_hook);
+
+    if (migrate_start(&from, &to, &args->start)) {
+        return -1;
+    }
+
+    /* First leg: A -> B */
+    migrate_precopy_hop(from, to, listen_uri, args->uri, args);
+
+    /*
+     * Second leg: B -> C.
+     */
+    qtest_quit(from);
+    migrate_setup_instance(to, &src_state, &args->start);
+
+    to2 = migrate_launch_dest("dest_serial2", &args->start);
+    if (!to2) {
+        qtest_quit(to);
+        return -1;
+    }
+    migrate_setup_instance(to2, &dst_state, &args->start);
+
+    migrate_precopy_hop(to, to2, listen_uri, NULL, args);
+
+    migrate_end(to, to2, true);
+
+    return 0;
+}
+
 static void file_dirty_offset_region(void)
 {
     g_autofree char *path = g_strdup_printf("%s/%s", tmpfs, FILE_TEST_FILENAME);
diff --git a/tests/qtest/migration/framework.h b/tests/qtest/migration/framework.h
index f6936eb8c6..ca5289329a 100644
--- a/tests/qtest/migration/framework.h
+++ b/tests/qtest/migration/framework.h
@@ -254,6 +254,7 @@ void test_postcopy_common(MigrateCommon *args);
 void test_postcopy_recovery_common(MigrateCommon *args,
                                    PostcopyRecoveryFailStage fail_stage);
 int test_precopy_common(MigrateCommon *args);
+int test_precopy_chain(MigrateCommon *args);
 void test_precopy_unix_common(MigrateCommon *args);
 void test_file_common(MigrateCommon *args, bool stop_src);
 
diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
index 194462c841..fccff76ef6 100644
--- a/tests/qtest/migration/precopy-tests.c
+++ b/tests/qtest/migration/precopy-tests.c
@@ -182,6 +182,11 @@ static void test_precopy_tcp_plain(char *name, MigrateCommon *args)
     test_precopy_common(args);
 }
 
+static void test_precopy_tcp_plain_chain(char *name, MigrateCommon *args)
+{
+    test_precopy_chain(args);
+}
+
 static void test_precopy_tcp_switchover_ack(char *name, MigrateCommon *args)
 {
     /*
@@ -398,6 +403,20 @@ static void test_multifd_tcp_channels_none(char *name, MigrateCommon *args)
     test_precopy_common(args);
 }
 
+static void test_multifd_tcp_channels_chain(char *name, MigrateCommon *args)
+{
+    args->live = true;
+    args->connect_channels = ("[ { 'channel-type': 'main',"
+                             "    'addr': { 'transport': 'socket',"
+                             "              'type': 'inet',"
+                             "              'host': '127.0.0.1',"
+                             "              'port': '0' } } ]");
+
+    args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
+
+    test_precopy_chain(args);
+}
+
 /*
  * This test does:
  *  source               target
@@ -1112,6 +1131,8 @@ void migration_test_add_precopy(MigrationTestEnv *env)
         return;
     }
 
+    migration_test_add("/migration/precopy/tcp/plain/chain",
+                       test_precopy_tcp_plain_chain);
     migration_test_add("/migration/precopy/tcp/plain/switchover-ack",
                        test_precopy_tcp_switchover_ack);
 
@@ -1133,6 +1154,8 @@ void migration_test_add_precopy(MigrationTestEnv *env)
     }
     migration_test_add("/migration/multifd/tcp/channels/plain/none",
                        test_multifd_tcp_channels_none);
+    migration_test_add("/migration/multifd/tcp/channels/plain/chain",
+                       test_multifd_tcp_channels_chain);
     migration_test_add("/migration/multifd/tcp/plain/zero-page/legacy",
                        test_multifd_tcp_zero_page_legacy);
     migration_test_add("/migration/multifd/tcp/plain/zero-page/none",
-- 
2.50.1 (Apple Git-155)


