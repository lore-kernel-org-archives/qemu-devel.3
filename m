Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7DE0F3C24A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 13:09:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzaKw-0006ch-7M; Mon, 09 Mar 2026 09:07:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vzaKs-0006bw-1A
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 09:07:50 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vzaKo-00080O-SW
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 09:07:49 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E77584D21A;
 Mon,  9 Mar 2026 13:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773061656; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DI4CN1QY/8LqIY/V9/C3XgP4aivA7WCH9SmXXgY6CpE=;
 b=GFrNyUEcYpdCLbQjYG7+u4Vgjs8l2NU3F1bWjnWU5XPTtoC3nTMJp91i08xgW/Bcmeflay
 v2qI023Go+WwWqqDWSpTh3jaQ+xqLeygdldvB9uyOI9J6IDUhnbHpwFCyuhZCjYcEH0+Y+
 JMm/PTMlg7KI0grJ8s+ZqXc45TVVbRM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773061656;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DI4CN1QY/8LqIY/V9/C3XgP4aivA7WCH9SmXXgY6CpE=;
 b=nFsdWhPte3SixI9xfGY4LLNt9578FbOgI5zKGdmiqxH834ZrpX3ikE3TL0es/YJYoH0SmZ
 gedNNed1CyW+qiDg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="RoN/DEZW";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=OgCa0WeS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773061655; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DI4CN1QY/8LqIY/V9/C3XgP4aivA7WCH9SmXXgY6CpE=;
 b=RoN/DEZWYTLKseTchVl93roSyBo6rlW3j3/QYMy0MDW59kqcF6kjh+GH+m/eYlMnHfhFqw
 UlYuqWQ47HzMOTQMQaSSG5l65YuqCePCGLHU5GqL9Y7j7dV8Rb6zvfzQJqN+Vci0c/Lml+
 bl8MU6kyANcxQ0vhEPdvgOZncC26A5I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773061655;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DI4CN1QY/8LqIY/V9/C3XgP4aivA7WCH9SmXXgY6CpE=;
 b=OgCa0WeSVxI6UEdQG/mLNaXY/9IWmhh7b+5QPz6Uk4fcnl1J+bYI2aWwWwTpGjLz0GXWvf
 UEC1i7PcnEKSoEDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B820A3EEF3;
 Mon,  9 Mar 2026 13:07:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cCUUHxbGrmlJcAAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 09 Mar 2026 13:07:34 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Prasad Pandit <pjp@fedoraproject.org>
Subject: [PULL 01/22] migration: introduce MIGRATION_STATUS_FAILING
Date: Mon,  9 Mar 2026 10:07:06 -0300
Message-ID: <20260309130730.20526-2-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260309130730.20526-1-farosas@suse.de>
References: <20260309130730.20526-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim,suse.de:email];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: E77584D21A
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
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

From: Prasad Pandit <pjp@fedoraproject.org>

When migration connection is broken, the QEMU and libvirtd(8)
process on the source side receive TCP connection reset
notification. QEMU sets the migration status to FAILED and
proceeds to migration_cleanup(). Meanwhile, Libvirtd(8) sends
a QMP command to migrate_set_capabilities().

The migration_cleanup() and qmp_migrate_set_capabilities()
calls race with each other. When the latter is invoked first,
since the migration is not running (FAILED), migration
capabilities are reset to false, so during migration_cleanup()
the QEMU process crashes with assertion failure.

Introduce a new migration status FAILING and use it as an
interim status when an error occurs. Once migration_cleanup()
is done, it sets the migration status to FAILED. This helps
to avoid the above race condition and ensuing failure.

Interim status FAILING is set wherever the execution moves
towards migration_cleanup():
  - postcopy_start()
  - migration_thread()
  - migration_cleanup()
  - multifd_send_setup()
  - bg_migration_thread()
  - migration_completion()
  - migration_detect_error()
  - bg_migration_completion()
  - multifd_send_error_propagate()
  - migration_connect_error_propagate()

The migration status finally moves to FAILED and reports an
appropriate error to the user.

Interim status FAILING is _NOT_ set in the following routines
because they do not follow the migration_cleanup() path to the
FAILED state:
  - cpr_exec_cb()
  - qemu_savevm_state()
  - postcopy_listen_thread()
  - process_incoming_migration_co()
  - multifd_recv_terminate_threads()
  - migration_channel_process_incoming()

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>
Link: https://lore.kernel.org/qemu-devel/20260224102547.226087-1-ppandit@redhat.com
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c                 | 32 +++++++++++++++++----------
 migration/multifd.c                   |  4 ++--
 qapi/migration.json                   |  9 +++++---
 tests/qtest/migration/migration-qmp.c |  3 ++-
 tests/qtest/migration/precopy-tests.c |  3 ++-
 5 files changed, 32 insertions(+), 19 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index a5b0465ed3..e80774e89b 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1016,6 +1016,7 @@ bool migration_is_running(void)
     case MIGRATION_STATUS_DEVICE:
     case MIGRATION_STATUS_WAIT_UNPLUG:
     case MIGRATION_STATUS_CANCELLING:
+    case MIGRATION_STATUS_FAILING:
     case MIGRATION_STATUS_COLO:
         return true;
     default:
@@ -1158,6 +1159,7 @@ static void fill_source_migration_info(MigrationInfo *info)
     case MIGRATION_STATUS_POSTCOPY_PAUSED:
     case MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP:
     case MIGRATION_STATUS_POSTCOPY_RECOVER:
+    case MIGRATION_STATUS_FAILING:
         /* TODO add some postcopy stats */
         populate_time_info(info, s);
         populate_ram_info(info, s);
@@ -1210,6 +1212,7 @@ static void fill_destination_migration_info(MigrationInfo *info)
     case MIGRATION_STATUS_POSTCOPY_PAUSED:
     case MIGRATION_STATUS_POSTCOPY_RECOVER:
     case MIGRATION_STATUS_FAILED:
+    case MIGRATION_STATUS_FAILING:
     case MIGRATION_STATUS_COLO:
         info->has_status = true;
         break;
@@ -1330,6 +1333,9 @@ static void migration_cleanup(MigrationState *s)
     if (s->state == MIGRATION_STATUS_CANCELLING) {
         migrate_set_state(&s->state, MIGRATION_STATUS_CANCELLING,
                           MIGRATION_STATUS_CANCELLED);
+    } else if (s->state == MIGRATION_STATUS_FAILING) {
+        migrate_set_state(&s->state, MIGRATION_STATUS_FAILING,
+                          MIGRATION_STATUS_FAILED);
     }
 
     /*
@@ -1387,7 +1393,7 @@ void migration_connect_error_propagate(MigrationState *s, Error *error)
 
     switch (current) {
     case MIGRATION_STATUS_SETUP:
-        next = MIGRATION_STATUS_FAILED;
+        next = MIGRATION_STATUS_FAILING;
         break;
 
     case MIGRATION_STATUS_POSTCOPY_PAUSED:
@@ -1401,9 +1407,10 @@ void migration_connect_error_propagate(MigrationState *s, Error *error)
         break;
 
     case MIGRATION_STATUS_CANCELLING:
+    case MIGRATION_STATUS_FAILING:
         /*
-         * Don't move out of CANCELLING, the only valid transition is to
-         * CANCELLED, at migration_cleanup().
+         * Keep the current state, next transition is to be done
+         * in migration_cleanup().
          */
         break;
 
@@ -1553,6 +1560,7 @@ bool migration_has_failed(MigrationState *s)
 {
     return (s->state == MIGRATION_STATUS_CANCELLING ||
             s->state == MIGRATION_STATUS_CANCELLED ||
+            s->state == MIGRATION_STATUS_FAILING ||
             s->state == MIGRATION_STATUS_FAILED);
 }
 
@@ -2479,7 +2487,7 @@ static int postcopy_start(MigrationState *ms, Error **errp)
         if (postcopy_preempt_establish_channel(ms)) {
             if (ms->state != MIGRATION_STATUS_CANCELLING) {
                 migrate_set_state(&ms->state, ms->state,
-                                  MIGRATION_STATUS_FAILED);
+                                  MIGRATION_STATUS_FAILING);
             }
             error_setg(errp, "%s: Failed to establish preempt channel",
                        __func__);
@@ -2642,7 +2650,7 @@ fail_closefb:
     qemu_fclose(fb);
 fail:
     if (ms->state != MIGRATION_STATUS_CANCELLING) {
-        migrate_set_state(&ms->state, ms->state, MIGRATION_STATUS_FAILED);
+        migrate_set_state(&ms->state, ms->state, MIGRATION_STATUS_FAILING);
     }
     bql_unlock();
     return -1;
@@ -2833,7 +2841,7 @@ fail:
     }
 
     if (s->state != MIGRATION_STATUS_CANCELLING) {
-        migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
+        migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILING);
     }
 }
 
@@ -2870,7 +2878,7 @@ static void bg_migration_completion(MigrationState *s)
 
 fail:
     migrate_set_state(&s->state, current_active_state,
-                      MIGRATION_STATUS_FAILED);
+                      MIGRATION_STATUS_FAILING);
 }
 
 typedef enum MigThrError {
@@ -3071,7 +3079,7 @@ static MigThrError migration_detect_error(MigrationState *s)
          * For precopy (or postcopy with error outside IO, or before dest
          * starts), we fail with no time.
          */
-        migrate_set_state(&s->state, state, MIGRATION_STATUS_FAILED);
+        migrate_set_state(&s->state, state, MIGRATION_STATUS_FAILING);
         trace_migration_thread_file_err();
 
         /* Time to stop the migration, now. */
@@ -3302,7 +3310,7 @@ static void migration_iteration_finish(MigrationState *s)
         migrate_start_colo_process(s);
         s->vm_old_state = RUN_STATE_RUNNING;
         /* Fallthrough */
-    case MIGRATION_STATUS_FAILED:
+    case MIGRATION_STATUS_FAILING:
     case MIGRATION_STATUS_CANCELLED:
     case MIGRATION_STATUS_CANCELLING:
         if (!migration_block_activate(&local_err)) {
@@ -3368,7 +3376,7 @@ static void bg_migration_iteration_finish(MigrationState *s)
     switch (s->state) {
     case MIGRATION_STATUS_COMPLETED:
     case MIGRATION_STATUS_ACTIVE:
-    case MIGRATION_STATUS_FAILED:
+    case MIGRATION_STATUS_FAILING:
     case MIGRATION_STATUS_CANCELLED:
     case MIGRATION_STATUS_CANCELLING:
         break;
@@ -3553,7 +3561,7 @@ static void *migration_thread(void *opaque)
     if (ret) {
         migrate_error_propagate(s, local_err);
         migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
-                          MIGRATION_STATUS_FAILED);
+                          MIGRATION_STATUS_FAILING);
         goto out;
     }
 
@@ -3745,7 +3753,7 @@ fail:
     /* local_err is guaranteed to be set when reaching here */
     migrate_error_propagate(s, local_err);
     migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
-                      MIGRATION_STATUS_FAILED);
+                      MIGRATION_STATUS_FAILING);
 
 done:
     bg_migration_iteration_finish(s);
diff --git a/migration/multifd.c b/migration/multifd.c
index ad6261688f..178c6b3350 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -431,7 +431,7 @@ static void multifd_send_error_propagate(Error *err)
             s->state == MIGRATION_STATUS_DEVICE ||
             s->state == MIGRATION_STATUS_ACTIVE) {
             migrate_set_state(&s->state, s->state,
-                              MIGRATION_STATUS_FAILED);
+                              MIGRATION_STATUS_FAILING);
         }
     }
 }
@@ -986,7 +986,7 @@ bool multifd_send_setup(void)
 
 err:
     migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
-                      MIGRATION_STATUS_FAILED);
+                      MIGRATION_STATUS_FAILING);
     return false;
 }
 
diff --git a/qapi/migration.json b/qapi/migration.json
index f925e5541b..7134d4ce47 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -158,7 +158,10 @@
 #
 # @completed: migration is finished.
 #
-# @failed: some error occurred during migration process.
+# @failing: error occurred during migration, clean-up underway.
+#     (since 11.0)
+#
+# @failed: error occurred during migration, clean-up done.
 #
 # @colo: VM is in the process of fault tolerance, VM can not get into
 #     this state unless colo capability is enabled for migration.
@@ -181,8 +184,8 @@
   'data': [ 'none', 'setup', 'cancelling', 'cancelled',
             'active', 'postcopy-device', 'postcopy-active',
             'postcopy-paused', 'postcopy-recover-setup',
-            'postcopy-recover', 'completed', 'failed', 'colo',
-            'pre-switchover', 'device', 'wait-unplug' ] }
+            'postcopy-recover', 'completed', 'failing', 'failed',
+            'colo', 'pre-switchover', 'device', 'wait-unplug' ] }
 
 ##
 # @VfioStats:
diff --git a/tests/qtest/migration/migration-qmp.c b/tests/qtest/migration/migration-qmp.c
index 5c46ceb3e6..8279504db1 100644
--- a/tests/qtest/migration/migration-qmp.c
+++ b/tests/qtest/migration/migration-qmp.c
@@ -241,7 +241,8 @@ void wait_for_migration_fail(QTestState *from, bool allow_active)
     do {
         status = migrate_query_status(from);
         bool result = !strcmp(status, "setup") || !strcmp(status, "failed") ||
-            (allow_active && !strcmp(status, "active"));
+            (allow_active && !strcmp(status, "active")) ||
+            !strcmp(status, "failing");
         if (!result) {
             fprintf(stderr, "%s: unexpected status status=%s allow_active=%d\n",
                     __func__, status, allow_active);
diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
index a5423ca33c..f17dc5176d 100644
--- a/tests/qtest/migration/precopy-tests.c
+++ b/tests/qtest/migration/precopy-tests.c
@@ -1247,7 +1247,7 @@ void migration_test_add_precopy(MigrationTestEnv *env)
     }
 
     /* ensure new status don't go unnoticed */
-    assert(MIGRATION_STATUS__MAX == 16);
+    assert(MIGRATION_STATUS__MAX == 17);
 
     for (int i = MIGRATION_STATUS_NONE; i < MIGRATION_STATUS__MAX; i++) {
         switch (i) {
@@ -1259,6 +1259,7 @@ void migration_test_add_precopy(MigrationTestEnv *env)
         case MIGRATION_STATUS_POSTCOPY_PAUSED:
         case MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP:
         case MIGRATION_STATUS_POSTCOPY_RECOVER:
+        case MIGRATION_STATUS_FAILING:
             continue;
         default:
             migration_test_add_suffix("/migration/cancel/src/after/",
-- 
2.51.0


