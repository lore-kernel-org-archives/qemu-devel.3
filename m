Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA0E7D778AE
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 19:56:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjNEq-00027f-60; Fri, 23 Jan 2026 14:54:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vjNEn-00026R-Sw
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 14:54:33 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vjNEm-0003WE-3l
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 14:54:33 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 853E133868;
 Fri, 23 Jan 2026 19:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769198050; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6XLBSEmh608quyWJeIecal4f8dXOkZyXRe+KQK96iSc=;
 b=K0AqCnjBNh0XmuWG/YIid9F08efSXyfzPUC9zcK6tuqvGRc/fUpsmbhJ0KCuX/bx2rgBbo
 oUR2jBFse0Pe8Kk5fDkxVOhmAO9+l0Hjmts7YLh9Rb4tXl42JN+5gm5BY5SEyXalJeOoIH
 I3gvRRogTc29T85+JHxtrN+V74zKfQw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769198050;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6XLBSEmh608quyWJeIecal4f8dXOkZyXRe+KQK96iSc=;
 b=7iyo9oMfduiVREmcKZ//zI5nSDbrwk+Pbfkhimna6qkEThOUGf31QQyAAKzp7cAjNhNLra
 YDa0SysTVnqodCDw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=K0AqCnjB;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=7iyo9oMf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769198050; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6XLBSEmh608quyWJeIecal4f8dXOkZyXRe+KQK96iSc=;
 b=K0AqCnjBNh0XmuWG/YIid9F08efSXyfzPUC9zcK6tuqvGRc/fUpsmbhJ0KCuX/bx2rgBbo
 oUR2jBFse0Pe8Kk5fDkxVOhmAO9+l0Hjmts7YLh9Rb4tXl42JN+5gm5BY5SEyXalJeOoIH
 I3gvRRogTc29T85+JHxtrN+V74zKfQw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769198050;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6XLBSEmh608quyWJeIecal4f8dXOkZyXRe+KQK96iSc=;
 b=7iyo9oMfduiVREmcKZ//zI5nSDbrwk+Pbfkhimna6qkEThOUGf31QQyAAKzp7cAjNhNLra
 YDa0SysTVnqodCDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2FC1F1395E;
 Fri, 23 Jan 2026 19:54:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kGH+N+DRc2lFZQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 23 Jan 2026 19:54:08 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Prasad Pandit <ppandit@redhat.com>
Subject: [PULL 08/36] tests/migration-test: Remove postcopy_data from
 MigrateCommon
Date: Fri, 23 Jan 2026 16:53:23 -0300
Message-ID: <20260123195352.12850-9-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260123195352.12850-1-farosas@suse.de>
References: <20260123195352.12850-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_COUNT_TWO(0.00)[2]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 853E133868
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

From: Peter Xu <peterx@redhat.com>

Now postcopy is not the only user of start_hook / end_hook that will pass
in a opaque pointer.  It doesn't need to be defined in MigrateCommon as
part of the framework, as all other hook users can pass hook_data around.
Do it too for postcopy.

Reviewed-by: Prasad Pandit <ppandit@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260114153751.2427172-2-peterx@redhat.com
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration/framework.c | 18 ++++++++++--------
 tests/qtest/migration/framework.h |  1 -
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index 57d3b9b7c5..78bd3ec31a 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -541,6 +541,7 @@ void migrate_end(QTestState *from, QTestState *to, bool test_dest)
 
 static int migrate_postcopy_prepare(QTestState **from_ptr,
                                     QTestState **to_ptr,
+                                    void **hook_data,
                                     MigrateCommon *args)
 {
     QTestState *from, *to;
@@ -554,7 +555,7 @@ static int migrate_postcopy_prepare(QTestState **from_ptr,
     }
 
     if (args->start_hook) {
-        args->postcopy_data = args->start_hook(from, to);
+        *hook_data = args->start_hook(from, to);
     }
 
     migrate_ensure_non_converge(from);
@@ -582,7 +583,7 @@ static int migrate_postcopy_prepare(QTestState **from_ptr,
 }
 
 static void migrate_postcopy_complete(QTestState *from, QTestState *to,
-                                      MigrateCommon *args)
+                                      void *hook_data, MigrateCommon *args)
 {
     MigrationTestEnv *env = migration_get_env();
 
@@ -601,8 +602,7 @@ static void migrate_postcopy_complete(QTestState *from, QTestState *to,
     }
 
     if (args->end_hook) {
-        args->end_hook(from, to, args->postcopy_data);
-        args->postcopy_data = NULL;
+        args->end_hook(from, to, hook_data);
     }
 
     migrate_end(from, to, true);
@@ -610,13 +610,14 @@ static void migrate_postcopy_complete(QTestState *from, QTestState *to,
 
 void test_postcopy_common(MigrateCommon *args)
 {
+    void *hook_data = NULL;
     QTestState *from, *to;
 
-    if (migrate_postcopy_prepare(&from, &to, args)) {
+    if (migrate_postcopy_prepare(&from, &to, &hook_data, args)) {
         return;
     }
     migrate_postcopy_start(from, to, &src_state);
-    migrate_postcopy_complete(from, to, args);
+    migrate_postcopy_complete(from, to, hook_data, args);
 }
 
 static void wait_for_postcopy_status(QTestState *one, const char *status)
@@ -742,6 +743,7 @@ void test_postcopy_recovery_common(MigrateCommon *args)
 {
     QTestState *from, *to;
     g_autofree char *uri = NULL;
+    void *hook_data = NULL;
 
     /*
      * Always enable OOB QMP capability for recovery tests, migrate-recover is
@@ -752,7 +754,7 @@ void test_postcopy_recovery_common(MigrateCommon *args)
     /* Always hide errors for postcopy recover tests since they're expected */
     args->start.hide_stderr = true;
 
-    if (migrate_postcopy_prepare(&from, &to, args)) {
+    if (migrate_postcopy_prepare(&from, &to, &hook_data, args)) {
         return;
     }
 
@@ -808,7 +810,7 @@ void test_postcopy_recovery_common(MigrateCommon *args)
     /* Restore the postcopy bandwidth to unlimited */
     migrate_set_parameter_int(from, "max-postcopy-bandwidth", 0);
 
-    migrate_postcopy_complete(from, to, args);
+    migrate_postcopy_complete(from, to, hook_data, args);
 }
 
 int test_precopy_common(MigrateCommon *args)
diff --git a/tests/qtest/migration/framework.h b/tests/qtest/migration/framework.h
index 2ef0f57962..c180cc3e46 100644
--- a/tests/qtest/migration/framework.h
+++ b/tests/qtest/migration/framework.h
@@ -231,7 +231,6 @@ typedef struct {
     bool live;
 
     /* Postcopy specific fields */
-    void *postcopy_data;
     PostcopyRecoveryFailStage postcopy_recovery_fail_stage;
 } MigrateCommon;
 
-- 
2.51.0


