Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7DD606A320
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 18:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvz.org header.i=@openvz.org header.a=rsa-sha256 header.s=google header.b=K9aTtn2y
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQqeg-0005OZ-Qp; Tue, 10 Nov 2026 13:33:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xQqec-0005Mg-9r
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 13:33:10 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xQqeY-0003Mp-JE
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 13:33:09 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-4918c2d727fso1298645f8f.3
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 10:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1794335585; x=1794940385; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wZ5fd90wMmGhR18V4PeDCCYB/ele6ujHSK6hnH2+u28=;
 b=K9aTtn2ycXb2idX78Z6daLGk3QY2mfxpIvb1U1NoNtmLhxZfMwyGLOpDsW5Z/klIb1
 KWfG8AjxsZ1KgyLzScQJnLMMhzuE+1ouJElJQsnYTrKffVNdaCeiCnxyf/zf5NwExxC+
 4STwqVlv4dL8CBUFVHDj/0W/E3IiBNx1I7oqEH+99HucvodLslhHrg0XF0HrzhHcb0Yb
 HS1yN3QzTW2NfQJSXug/EzI8rl2eLvAL8dd9zZ/rt85me7Ndnuo058BiVVedkHKiYyNc
 z5T4fiJ08ulWJdQMpEQ4E5HqPxWh6aDKD6s4bbhfRJ6rUaLDHJvgfWxf1yyd8l44I2t3
 xHWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794335585; x=1794940385;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=wZ5fd90wMmGhR18V4PeDCCYB/ele6ujHSK6hnH2+u28=;
 b=WnB7i/mGo1KbS0IFFoCc3oYH5tYG/s1VJPb2Qv+SbgcfsCish1SsW+NhYxa/4c6f6M
 C4UhbKbcHGlt1MYxPbObarBgdEB8n46mfDI2QsF7SHVaJmRmFIYFiTODA3AOkyrAL2mM
 Rc9ynSLjt/xi+rSGd1pbsJiYGYVypYJ4gVGQj/LE4uLBShyh9STal++4q4YPq2hnMHCi
 CojoiDU3feqJGjT+rFaHJqwDbY52F0TcrSCvmrhsN8f1Cd/g/FwPbjLasKvWdGFgAUBu
 TAuGSXRHVRkCS0qr7ac21AobQniqVNFYiundVnM7QEKw4dfSiYU5Gf3UiUPLblrxIoSf
 akPQ==
X-Gm-Message-State: APuU4Z9J9CmXqxugKMiy/dDohhjB857oVv1pPLE0mjrBcK63QxDKrQyh
 Qiggoydw6Le6xObGCak1aXHuHF3DN0DXykAN+DfM2hvmDogiIAf0nGBi7jTHx4tPbiKr9nNwtfs
 pSnh/
X-Gm-Gg: AYBFou2YZH9lsaN7I55Ve3VRZujwXX85XjpISiPYusisu1Ok1Az/7rF1ZJgE67d4dRc
 cCiLMS+3ycYnjsMzvefMoRP5YmQK3AG9CH6AJWTjIi4nZqU4KTgIdY51AUUTC9IOXaIC00yP+ts
 nxRor8g5CCEPAdocKmHXgS6hKe5iR8yeDagh8eJ147mE6S8l1b3x5aGNqU9/77ijkqoM24N4O7Y
 X2tqwZxvyfiJxv7fIX+sacM7xPJOz3N/sp6Jhv1XW5Lomt+u1RRyG3xhFPIxEL1XhzdmaoHFVad
 BV5Z0atde9QLOFF0zuL7DAcGHvevqtrANpswJOC8o+C1QYMHasaig1R4uYLacNe/xErVkOAQuPy
 pGWgq92FkRmJ7xubLR21U65Kz0cddjKFqKi0k6tzIJt42pZQrF9oq8ItapltdQuqlNaO1BWp+0k
 eN+lHBXJmhG5FoAcyTpoS1xNmA3z/diuV99q53VS5reMK2LtewC8/8bUPiltkIQgTxjeskpokdJ
 8Q/UKBfvmTH9VOifEiGJJYt+cB8rMOMre8dng6Dw0YCBRp+ZwbiO5o6cJLb5dIP8w0w8MWsafCi
 LnOfb5a/m7IX8KfOOOgU6WfCGQ==
X-Received: by 2002:a05:6000:3c5:b0:48e:e98:8b64 with SMTP id
 ffacd0b85a97d-4982e82c23fmr6266416f8f.19.1794335584874; 
 Tue, 10 Nov 2026 10:33:04 -0800 (PST)
Received: from athena.sw.ru ([2a06:5b06:b600:300:4f78:6441:d0f1:22af])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-498363df7a5sm6384827f8f.37.2026.11.10.10.33.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 10:33:04 -0800 (PST)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: den@openvz.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH v2 3/5] tests/qtest/migration: check the destination run state
 in postcopy tests
Date: Tue, 10 Nov 2026 19:32:55 +0100
Message-ID: <20261110183257.2930908-4-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110183257.2930908-1-den@openvz.org>
References: <20261110183257.2930908-1-den@openvz.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=den@openvz.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Denis V. Lunev <den@openvz.org>

The destination must not report postcopy-active or completed while it
is still in RUN_STATE_INMIGRATE. The destination autostarts in these
tests, so the run state change emits RESUME and the order is visible in
the event stream: record a MIGRATION postcopy-active or completed event
seen before RESUME and fail the postcopy tests on it once the
destination has completed.

migrate_postcopy_start() waited for the destination's RESUME with
qtest_qmp_eventwait(), which reads events past the event callback and
drops the ones it does not want. Poll query-status instead, so every
destination event reaches the callback.

Signed-off-by: Denis V. Lunev <den@openvz.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>
Cc: Juraj Marcin <jmarcin@redhat.com>
---
 tests/qtest/migration/framework.c      |  6 ++++--
 tests/qtest/migration/migration-qmp.c  | 10 ++++++++--
 tests/qtest/migration/migration-qmp.h  |  3 ++-
 tests/qtest/migration/migration-util.c |  8 ++++++++
 tests/qtest/migration/migration-util.h |  2 ++
 5 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index b7aef6b21c..1cf18233f7 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -667,6 +667,8 @@ static void migrate_postcopy_complete(QTestState *from, QTestState *to,
     MigrationTestEnv *env = migration_get_env();
 
     wait_for_migration_complete(from);
+    wait_for_migration_complete(to);
+    g_assert(!dst_state.migrated_before_resume);
 
     if (args->start.suspend_me) {
         /* wakeup succeeds only if guest is suspended */
@@ -695,7 +697,7 @@ void test_postcopy_common(MigrateCommon *args)
     if (migrate_postcopy_prepare(&from, &to, &hook_data, args)) {
         return;
     }
-    migrate_postcopy_start(from, to, &src_state);
+    migrate_postcopy_start(from, to, &src_state, &dst_state);
     migrate_postcopy_complete(from, to, hook_data, args);
 }
 
@@ -842,7 +844,7 @@ void test_postcopy_recovery_common(MigrateCommon *args,
     migrate_set_parameter_int(from, "max-postcopy-bandwidth", 4096);
 
     /* Now we start the postcopy */
-    migrate_postcopy_start(from, to, &src_state);
+    migrate_postcopy_start(from, to, &src_state, &dst_state);
 
     /*
      * Wait until postcopy is really started; we can only run the
diff --git a/tests/qtest/migration/migration-qmp.c b/tests/qtest/migration/migration-qmp.c
index 437b5eaeff..77befe1027 100644
--- a/tests/qtest/migration/migration-qmp.c
+++ b/tests/qtest/migration/migration-qmp.c
@@ -549,10 +549,16 @@ void migrate_cancel(QTestState *who)
 }
 
 void migrate_postcopy_start(QTestState *from, QTestState *to,
-                            QTestMigrationState *src_state)
+                            QTestMigrationState *src_state,
+                            QTestMigrationState *dst_state)
 {
     qtest_qmp_assert_success(from, "{ 'execute': 'migrate-start-postcopy' }");
 
     wait_for_stop(from, src_state);
-    qtest_qmp_eventwait(to, "RESUME");
+
+    /* Poll so that every destination event passes the event callback */
+    while (!dst_state->resume_seen) {
+        qtest_qmp_assert_success(to, "{ 'execute': 'query-status' }");
+        g_usleep(1000);
+    }
 }
diff --git a/tests/qtest/migration/migration-qmp.h b/tests/qtest/migration/migration-qmp.h
index 940ffd5950..f275cd7692 100644
--- a/tests/qtest/migration/migration-qmp.h
+++ b/tests/qtest/migration/migration-qmp.h
@@ -46,6 +46,7 @@ void migrate_continue(QTestState *who, const char *state);
 void migrate_recover(QTestState *who, const char *uri);
 void migrate_cancel(QTestState *who);
 void migrate_postcopy_start(QTestState *from, QTestState *to,
-                            QTestMigrationState *src_state);
+                            QTestMigrationState *src_state,
+                            QTestMigrationState *dst_state);
 
 #endif /* MIGRATION_QMP_H */
diff --git a/tests/qtest/migration/migration-util.c b/tests/qtest/migration/migration-util.c
index db66d8b24f..4b5663c5a6 100644
--- a/tests/qtest/migration/migration-util.c
+++ b/tests/qtest/migration/migration-util.c
@@ -178,6 +178,14 @@ bool migrate_watch_for_events(QTestState *who, const char *name,
     } else if (g_str_equal(name, "RESUME")) {
         state->resume_seen = true;
         return true;
+    } else if (g_str_equal(name, "MIGRATION") && !state->resume_seen) {
+        const char *status = qdict_get_str(qdict_get_qdict(event, "data"),
+                                           "status");
+
+        if (g_str_equal(status, "postcopy-active") ||
+            g_str_equal(status, "completed")) {
+            state->migrated_before_resume = true;
+        }
     }
 
     return false;
diff --git a/tests/qtest/migration/migration-util.h b/tests/qtest/migration/migration-util.h
index 694773e594..f195aeea48 100644
--- a/tests/qtest/migration/migration-util.h
+++ b/tests/qtest/migration/migration-util.h
@@ -22,6 +22,8 @@ typedef struct QTestMigrationState {
     bool resume_seen;
     bool suspend_seen;
     bool suspend_me;
+    /* postcopy-active or completed reported before RESUME */
+    bool migrated_before_resume;
 } QTestMigrationState;
 
 bool migrate_watch_for_events(QTestState *who, const char *name,
-- 
2.53.0


