Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C57BC27C79
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 18:17:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJGtl-0000QE-Mc; Mon, 17 Jun 2024 14:16:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sJGtd-0000EI-A2
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 14:16:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sJGtb-0006JU-FR
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 14:16:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718648158;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HIZg7f7EMSb4DXS9WhlUqeNfOnQttCV1Q7L9oJ5REA8=;
 b=S6Al0s5AGXqKvyonOKaiTdiN8eRtLCOMUSI7rADMdbk+d9VYPSpKuOuv4fXsWBQSZt6z/H
 uOLeAu8f+o1I5YBrpNRsu5bddKl0zZUIxEOJq5qvr1QkqnErnWRq4xWpRT74/cPEkzRESq
 GSG+tR5f/A2M8sg3k4sShZos6a44iOQ=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-XDT_jXlzPBWVfTX4b-Ko5Q-1; Mon, 17 Jun 2024 14:15:57 -0400
X-MC-Unique: XDT_jXlzPBWVfTX4b-Ko5Q-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6b2cbdb07fcso834166d6.3
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 11:15:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718648156; x=1719252956;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HIZg7f7EMSb4DXS9WhlUqeNfOnQttCV1Q7L9oJ5REA8=;
 b=g2B4I05U6GiAHL+DgmpAHmDGHuSz7hklq7V6rZuz96jf8iQnKtnlgid4o6UMm79X2p
 qiBGMSOzdBCTIDfv1E5uNTjs5mb8ttmV4NvQwVaH+by2Id1IUO0ncuhVooEBTe702Vmh
 +h96TQMyI2QqTSMuZnaX0tluycjQ+8eElPki9nK0qHAun8JpIhXX2oPxqk+IyKd166/S
 4d/7QRATK/ExGthKattLZSbUFVebz6wPtXje0T8MjeR01vhmKW/c7bvQCEOUNqO/k1Aj
 MzOI7vYEBT/f/POzdPGoONucCgLzscEB0JahuVyDkkzb//eWZVRj51KVi+2reH1ZPTXE
 +GhQ==
X-Gm-Message-State: AOJu0YwYoXI+bnXFPhKv3I3e9qaW738t+YC1DRgatzAu8yt6ChjUTNic
 MkZzkjkPrWJ806bVeouUneXcZEAATRpX3lxteNBOSz6fOrSTnSTdQnURVCF7fuYxrgika/T3Lin
 X4lm/IjsGr1Va2sjf0/8qBUmllBR7SasMtAjGpb6cfb4/mkWm6EpXypLmM33G48hLQNcqK524Wx
 TF0Ximv0IVmBsLU7K6K8KnS026Z+PfJbQVTw==
X-Received: by 2002:a05:620a:2b41:b0:798:da55:1269 with SMTP id
 af79cd13be357-798da5517dcmr1103938685a.1.1718648155629; 
 Mon, 17 Jun 2024 11:15:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEENFI7nLdoDmqZEc7XQVS3SR0APG3J2rMVthD9C+jBu6T6x1HaOUSULK7B7QqJx/NFJTMW0w==
X-Received: by 2002:a05:620a:2b41:b0:798:da55:1269 with SMTP id
 af79cd13be357-798da5517dcmr1103933885a.1.1718648154756; 
 Mon, 17 Jun 2024 11:15:54 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-798abc07501sm449643685a.89.2024.06.17.11.15.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jun 2024 11:15:53 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eric Blake <eblake@redhat.com>, Prasad Pandit <ppandit@redhat.com>,
 peterx@redhat.com, Jiri Denemark <jdenemar@redhat.com>,
 Bandan Das <bdas@redhat.com>
Subject: [PATCH v2 10/10] tests/migration-tests: Cover postcopy failure on
 reconnect
Date: Mon, 17 Jun 2024 14:15:34 -0400
Message-ID: <20240617181534.1425179-11-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240617181534.1425179-1-peterx@redhat.com>
References: <20240617181534.1425179-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
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

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/qtest/migration-test.c | 89 ++++++++++++++++++++++++++++++------
 1 file changed, 74 insertions(+), 15 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index a16b1a4824..3e237a1499 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -70,6 +70,17 @@ static QTestMigrationState dst_state;
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
@@ -680,7 +691,7 @@ typedef struct {
     /* Postcopy specific fields */
     void *postcopy_data;
     bool postcopy_preempt;
-    bool postcopy_recovery_test_fail;
+    PostcopyRecoveryFailStage postcopy_recovery_fail_stage;
 } MigrateCommon;
 
 static int test_migrate_start(QTestState **from, QTestState **to,
@@ -1360,12 +1371,16 @@ static void wait_for_postcopy_status(QTestState *one, const char *status)
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
@@ -1399,6 +1414,14 @@ static void postcopy_recover_fail(QTestState *from, QTestState *to)
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
 
@@ -1408,28 +1431,53 @@ static void postcopy_recover_fail(QTestState *from, QTestState *to)
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
+     * because when the channel is shutdown it should also happens on src.
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
 
@@ -1471,12 +1519,12 @@ static void test_postcopy_recovery_common(MigrateCommon *args)
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
 
@@ -1510,7 +1558,16 @@ static void test_postcopy_recovery(void)
 static void test_postcopy_recovery_double_fail(void)
 {
     MigrateCommon args = {
-        .postcopy_recovery_test_fail = true,
+        .postcopy_recovery_fail_stage = POSTCOPY_FAIL_RECOVERY,
+    };
+
+    test_postcopy_recovery_common(&args);
+}
+
+static void test_postcopy_recovery_channel_reconnect(void)
+{
+    MigrateCommon args = {
+        .postcopy_recovery_fail_stage = POSTCOPY_FAIL_CHANNEL_ESTABLISH,
     };
 
     test_postcopy_recovery_common(&args);
@@ -3497,6 +3554,8 @@ int main(int argc, char **argv)
                            test_postcopy_preempt_recovery);
         migration_test_add("/migration/postcopy/recovery/double-failures",
                            test_postcopy_recovery_double_fail);
+        migration_test_add("/migration/postcopy/recovery/channel-reconnect",
+                           test_postcopy_recovery_channel_reconnect);
         if (is_x86) {
             migration_test_add("/migration/postcopy/suspend",
                                test_postcopy_suspend);
-- 
2.45.0


