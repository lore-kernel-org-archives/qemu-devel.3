Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE08DD778AE
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 19:58:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjNG7-0007xX-N4; Fri, 23 Jan 2026 14:55:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vjNG5-0007jP-Rv
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 14:55:53 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vjNG4-0003sN-4Z
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 14:55:53 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8825433863;
 Fri, 23 Jan 2026 19:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769198099; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zpGo0nMwG8A/Z2gfh4vpP4cU7uBRdhejmM493QQcTCw=;
 b=ILwr2KEo81KO7rskGZ/164VUKiIUtQWljTkFa4uNTtc+cCpQFWHz3LBemwKaqFAOZYBAzS
 fC7Bks4OyYdNZTWT+GHGm7bdeYC/XAIJLn0F83kJeYwduWqnZIAU9MnhBUiiw/NKY9gkng
 Te/RotojIA/cBdLvq94ojWku8wQkPUY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769198099;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zpGo0nMwG8A/Z2gfh4vpP4cU7uBRdhejmM493QQcTCw=;
 b=UUq9+K6pGW7aTmsY/eF23a3LL39bC0BWr5OQd2F0qvKDrEvGbUjHI49az/Hi2C8Zoh02ks
 sOqddhoP9+479yBA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ILwr2KEo;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=UUq9+K6p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769198099; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zpGo0nMwG8A/Z2gfh4vpP4cU7uBRdhejmM493QQcTCw=;
 b=ILwr2KEo81KO7rskGZ/164VUKiIUtQWljTkFa4uNTtc+cCpQFWHz3LBemwKaqFAOZYBAzS
 fC7Bks4OyYdNZTWT+GHGm7bdeYC/XAIJLn0F83kJeYwduWqnZIAU9MnhBUiiw/NKY9gkng
 Te/RotojIA/cBdLvq94ojWku8wQkPUY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769198099;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zpGo0nMwG8A/Z2gfh4vpP4cU7uBRdhejmM493QQcTCw=;
 b=UUq9+K6pGW7aTmsY/eF23a3LL39bC0BWr5OQd2F0qvKDrEvGbUjHI49az/Hi2C8Zoh02ks
 sOqddhoP9+479yBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 347981395E;
 Fri, 23 Jan 2026 19:54:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0O45ORHSc2lFZQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 23 Jan 2026 19:54:57 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Prasad Pandit <pjp@fedoraproject.org>
Subject: [PULL 35/36] migration: Remove qmp_migrate_finish
Date: Fri, 23 Jan 2026 16:53:50 -0300
Message-ID: <20260123195352.12850-36-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260123195352.12850-1-farosas@suse.de>
References: <20260123195352.12850-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
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
X-Rspamd-Queue-Id: 8825433863
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

After cleanups, the qmp_migrate_finish function is now just a call to
migration_connect_outgoing(). Remove qmp_migrate_finish() and rename
the qmp_migrate_finish_cb callback.

This also allows the function's error handling to be removed as it now
receives &local_err like the rest of the callees of qmp_migrate().

Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>
Link: https://lore.kernel.org/qemu-devel/20260123141656.6765-25-farosas@suse.de
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c | 35 +++++++++++++----------------------
 1 file changed, 13 insertions(+), 22 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 5d64068389..b103a82fc0 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1998,15 +1998,18 @@ static bool migrate_prepare(MigrationState *s, bool resume, Error **errp)
     return true;
 }
 
-static void qmp_migrate_finish(MigrationAddress *addr, Error **errp);
-
-static gboolean qmp_migrate_finish_cb(QIOChannel *channel,
-                                      GIOCondition cond,
-                                      void *opaque)
+static gboolean migration_connect_outgoing_cb(QIOChannel *channel,
+                                              GIOCondition cond, void *opaque)
 {
-    MigrationAddress *addr = opaque;
+    MigrationState *s = migrate_get_current();
+    Error *local_err = NULL;
+
+    migration_connect_outgoing(s, opaque, &local_err);
+
+    if (local_err) {
+        migration_connect_error_propagate(s, local_err);
+    }
 
-    qmp_migrate_finish(addr, NULL);
     return G_SOURCE_REMOVE;
 }
 
@@ -2055,10 +2058,11 @@ void qmp_migrate(const char *uri, bool has_channels,
      * connection, so qmp_migrate_finish will fail to connect, and then recover.
      */
     if (migrate_mode() == MIG_MODE_CPR_TRANSFER) {
-        cpr_transfer_add_hup_watch(s, qmp_migrate_finish_cb, main_ch->addr);
+        cpr_transfer_add_hup_watch(s, migration_connect_outgoing_cb,
+                                   main_ch->addr);
 
     } else {
-        qmp_migrate_finish(main_ch->addr, errp);
+        migration_connect_outgoing(s, main_ch->addr, &local_err);
     }
 
 out:
@@ -2068,19 +2072,6 @@ out:
     }
 }
 
-static void qmp_migrate_finish(MigrationAddress *addr, Error **errp)
-{
-    MigrationState *s = migrate_get_current();
-    Error *local_err = NULL;
-
-    migration_connect_outgoing(s, addr, &local_err);
-
-    if (local_err) {
-        migration_connect_error_propagate(s, error_copy(local_err));
-        error_propagate(errp, local_err);
-    }
-}
-
 void qmp_migrate_cancel(Error **errp)
 {
     /*
-- 
2.51.0


