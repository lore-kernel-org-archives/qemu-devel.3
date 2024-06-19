Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94012C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 22:32:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sK3pq-0001wP-CK; Wed, 19 Jun 2024 18:31:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sK3pp-0001wA-8e
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 18:31:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sK3pn-0008Sd-9p
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 18:31:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718836278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JFT2jGiD3g0jPKvPAJ8TR6jC43QPlRfHqiMRMDNZuHA=;
 b=JJaKkMPqlxs3dPq48sU4YbGVgsLmYi46Po8hknRmwkJOoY73GseAaMa6/YIyyZ1AwujO6u
 I5q/s4Slc3EvSbmS/HIXy2phbO+Blf55zZ+g0MN61uM5/V6PER3eRo5TbXqzZEHRrCEGfs
 fNhYqMx560YKXSKm02fPwK1kmLmdB7o=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-Sd7XmWodPQylL_SASId15Q-1; Wed, 19 Jun 2024 18:31:14 -0400
X-MC-Unique: Sd7XmWodPQylL_SASId15Q-1
Received: by mail-yb1-f198.google.com with SMTP id
 3f1490d57ef6-dfdb41f87cbso51076276.0
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2024 15:31:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718836274; x=1719441074;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JFT2jGiD3g0jPKvPAJ8TR6jC43QPlRfHqiMRMDNZuHA=;
 b=bKQG+UsmwNuS4VJ2E8h0fVtx0IhM8x+Pcd/bDZogkzG4u2XUDRM9ECpqQVe6kb9or3
 v6f8nAiIPLwTgbwGYEqrNXSYQtm9z4U8G4cbXVHOHWxvSa9+kXsKFeoxY+axj9bL6in/
 XwfUzT8coO/EiuSZmpITMC2d9IO0/fargSQnU9oUQ4u/q524Z1KZPTd+YKEJ0rjyOzfH
 NYg7msUBMcF8uszRCKvJIPEEUOsutbDUrgn1DHGh2coIHamtiYgIjmBVLEXn/I4jd6Ij
 yEVu1hYUm+pzN0pkHMUH9FxdxktVCB6w2xUu6QU5Hdra/DnNfQ3U8OxVFwUwlnUhQ1e0
 mEFw==
X-Gm-Message-State: AOJu0YxuFmy1zrTkgsrK+pVr2ZdvnQNsckG7m/x7p63PN0EaEwHTyRG0
 f2601FazRehvonLjvHZHjHk+bUmHUr7547JTZ1zubAeNTquCszoHGy2Zxt7DRlgGucwuJdf2RXB
 2E8AqutKn5w9gcxFUvcbUoyMkBCgHuJCptnIELNRVyG5jhcRUZvhW08WUMHj3x1U+D2OB2lAnCs
 4jL8iH8ZSUn6dUY36OK/TQv2JFDTnJAr+mVg==
X-Received: by 2002:a25:3f47:0:b0:e02:b52a:b79f with SMTP id
 3f1490d57ef6-e02be22ce36mr3382300276.3.1718836273649; 
 Wed, 19 Jun 2024 15:31:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAwywbyWdVlOX1db4OT8cRQl3tpMTxvT7rqU0kLnIj7CPSjiPOt0mxDM/U51di1N0eoDB5Sw==
X-Received: by 2002:a25:3f47:0:b0:e02:b52a:b79f with SMTP id
 3f1490d57ef6-e02be22ce36mr3382283276.3.1718836273122; 
 Wed, 19 Jun 2024 15:31:13 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b2a5c466bfsm80844256d6.68.2024.06.19.15.31.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jun 2024 15:31:11 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Bandan Das <bdas@redhat.com>,
 Zhijian Li <lizhijian@fujitsu.com>, Fabiano Rosas <farosas@suse.de>,
 Jiri Denemark <jdenemar@redhat.com>, Prasad Pandit <ppandit@redhat.com>,
 Eric Blake <eblake@redhat.com>, peterx@redhat.com
Subject: [PATCH v3 11/11] tests/migration-tests: Cover postcopy failure on
 reconnect
Date: Wed, 19 Jun 2024 18:30:46 -0400
Message-ID: <20240619223046.1798968-12-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240619223046.1798968-1-peterx@redhat.com>
References: <20240619223046.1798968-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Make sure there will be an event for postcopy recovery, irrelevant of
whether the reconnect will success, or when the failure happens.

The added new case is to fail early in postcopy recovery, in which case it
didn't even reach RECOVER stage on src (and in real life it'll be the same
to dest, but the test case is just slightly more involved due to the dual
socketpair setup).

To do that, rename the postcopy_recovery_test_fail to reflect either stage
to fail, instead of a boolean.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/qtest/migration-test.c | 95 +++++++++++++++++++++++++++++-------
 1 file changed, 77 insertions(+), 18 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index de81e28088..fe33b86783 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -72,6 +72,17 @@ static QTestMigrationState dst_state;
 #define QEMU_ENV_SRC "QTEST_QEMU_BINARY_SRC"
 #define QEMU_ENV_DST "QTEST_QEMU_BINARY_DST"
 
+typedef enum PostcopyRecoveryFailStage {
+    /*
+     * "no failure" must be 0 as it's the default.  OTOH, real failure
+     * cases must be >0 to make sure they trigger by a "if" test.
+     */
+    POSTCOPY_FAIL_NONE = 0,
+    POSTCOPY_FAIL_CHANNEL_ESTABLISH,
+    POSTCOPY_FAIL_RECOVERY,
+    POSTCOPY_FAIL_MAX
+} PostcopyRecoveryFailStage;
+
 #if defined(__linux__)
 #include <sys/syscall.h>
 #include <sys/vfs.h>
@@ -692,7 +703,7 @@ typedef struct {
     /* Postcopy specific fields */
     void *postcopy_data;
     bool postcopy_preempt;
-    bool postcopy_recovery_test_fail;
+    PostcopyRecoveryFailStage postcopy_recovery_fail_stage;
 } MigrateCommon;
 
 static int test_migrate_start(QTestState **from, QTestState **to,
@@ -1370,12 +1381,16 @@ static void wait_for_postcopy_status(QTestState *one, const char *status)
                                                   "completed", NULL });
 }
 
-static void postcopy_recover_fail(QTestState *from, QTestState *to)
+static void postcopy_recover_fail(QTestState *from, QTestState *to,
+                                  PostcopyRecoveryFailStage stage)
 {
 #ifndef _WIN32
+    bool fail_early = (stage == POSTCOPY_FAIL_CHANNEL_ESTABLISH);
     int ret, pair1[2], pair2[2];
     char c;
 
+    g_assert(stage > POSTCOPY_FAIL_NONE && stage < POSTCOPY_FAIL_MAX);
+
     /* Create two unrelated socketpairs */
     ret = qemu_socketpair(PF_LOCAL, SOCK_STREAM, 0, pair1);
     g_assert_cmpint(ret, ==, 0);
@@ -1409,6 +1424,14 @@ static void postcopy_recover_fail(QTestState *from, QTestState *to)
     ret = send(pair2[1], &c, 1, 0);
     g_assert_cmpint(ret, ==, 1);
 
+    if (stage == POSTCOPY_FAIL_CHANNEL_ESTABLISH) {
+        /*
+         * This will make src QEMU to fail at an early stage when trying to
+         * resume later, where it shouldn't reach RECOVER stage at all.
+         */
+        close(pair1[1]);
+    }
+
     migrate_recover(to, "fd:fd-mig");
     migrate_qmp(from, to, "fd:fd-mig", NULL, "{'resume': true}");
 
@@ -1418,28 +1441,53 @@ static void postcopy_recover_fail(QTestState *from, QTestState *to)
      */
     migration_event_wait(from, "postcopy-recover-setup");
 
+    if (fail_early) {
+        /*
+         * When fails at reconnection, src QEMU will automatically goes
+         * back to PAUSED state.  Making sure there is an event in this
+         * case: Libvirt relies on this to detect early reconnection
+         * errors.
+         */
+        migration_event_wait(from, "postcopy-paused");
+    } else {
+        /*
+         * We want to test "fail later" at RECOVER stage here.  Make sure
+         * both QEMU instances will go into RECOVER stage first, then test
+         * kicking them out using migrate-pause.
+         *
+         * Explicitly check the RECOVER event on src, that's what Libvirt
+         * relies on, rather than polling.
+         */
+        migration_event_wait(from, "postcopy-recover");
+        wait_for_postcopy_status(from, "postcopy-recover");
+
+        /* Need an explicit kick on src QEMU in this case */
+        migrate_pause(from);
+    }
+
     /*
-     * Make sure both QEMU instances will go into RECOVER stage, then test
-     * kicking them out using migrate-pause.
+     * For all failure cases, we'll reach such states on both sides now.
+     * Check them.
      */
-    wait_for_postcopy_status(from, "postcopy-recover");
+    wait_for_postcopy_status(from, "postcopy-paused");
     wait_for_postcopy_status(to, "postcopy-recover");
 
     /*
-     * This would be issued by the admin upon noticing the hang, we should
-     * make sure we're able to kick this out.
+     * Kick dest QEMU out too. This is normally not needed in reality
+     * because when the channel is shutdown it should also happen on src.
+     * However here we used separate socket pairs so we need to do that
+     * explicitly.
      */
-    migrate_pause(from);
-    wait_for_postcopy_status(from, "postcopy-paused");
-
-    /* Do the same test on dest */
     migrate_pause(to);
     wait_for_postcopy_status(to, "postcopy-paused");
 
     close(pair1[0]);
-    close(pair1[1]);
     close(pair2[0]);
     close(pair2[1]);
+
+    if (stage != POSTCOPY_FAIL_CHANNEL_ESTABLISH) {
+        close(pair1[1]);
+    }
 #endif
 }
 
@@ -1481,12 +1529,12 @@ static void test_postcopy_recovery_common(MigrateCommon *args)
     wait_for_postcopy_status(to, "postcopy-paused");
     wait_for_postcopy_status(from, "postcopy-paused");
 
-    if (args->postcopy_recovery_test_fail) {
+    if (args->postcopy_recovery_fail_stage) {
         /*
          * Test when a wrong socket specified for recover, and then the
          * ability to kick it out, and continue with a correct socket.
          */
-        postcopy_recover_fail(from, to);
+        postcopy_recover_fail(from, to, args->postcopy_recovery_fail_stage);
         /* continue with a good recovery */
     }
 
@@ -1517,10 +1565,19 @@ static void test_postcopy_recovery(void)
     test_postcopy_recovery_common(&args);
 }
 
-static void test_postcopy_recovery_double_fail(void)
+static void test_postcopy_recovery_fail_handshake(void)
+{
+    MigrateCommon args = {
+        .postcopy_recovery_fail_stage = POSTCOPY_FAIL_RECOVERY,
+    };
+
+    test_postcopy_recovery_common(&args);
+}
+
+static void test_postcopy_recovery_fail_reconnect(void)
 {
     MigrateCommon args = {
-        .postcopy_recovery_test_fail = true,
+        .postcopy_recovery_fail_stage = POSTCOPY_FAIL_CHANNEL_ESTABLISH,
     };
 
     test_postcopy_recovery_common(&args);
@@ -3702,8 +3759,10 @@ int main(int argc, char **argv)
                            test_postcopy_preempt);
         migration_test_add("/migration/postcopy/preempt/recovery/plain",
                            test_postcopy_preempt_recovery);
-        migration_test_add("/migration/postcopy/recovery/double-failures",
-                           test_postcopy_recovery_double_fail);
+        migration_test_add("/migration/postcopy/recovery/double-failures/handshake",
+                           test_postcopy_recovery_fail_handshake);
+        migration_test_add("/migration/postcopy/recovery/double-failures/reconnect",
+                           test_postcopy_recovery_fail_reconnect);
         if (is_x86) {
             migration_test_add("/migration/postcopy/suspend",
                                test_postcopy_suspend);
-- 
2.45.0


