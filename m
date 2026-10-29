Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD10606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 18:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=nxQRRj+R;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=X2bZ8POD;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=AA8bRlm9;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=UqDhJ+qH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMVA3-0002gS-Ua; Thu, 29 Oct 2026 14:47:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xMV9d-0002Vz-RM
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 14:47:15 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xMV9a-00023g-Ew
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 14:47:13 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0D1731FAA3;
 Thu, 29 Oct 2026 18:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1793299629; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=abqJJXaGGpMxrTTz4LNv0nEat57E5J8kh+2eC1Qx7y8=;
 b=nxQRRj+RKAfndZ80dRkCHQyb2y5tM+tLzX3JT/VezVIVgh2sPvC/2mrBfpUPrVnEyDKYfv
 37KvA09F09i8ZJ93WQnR12XLCRvJW5GoENSq8QkV9K0/Lv67BPqKQuKEhdaVuDQq3tEwhP
 aL3Ds72YDAve0jQ7RMlojMEHpILrNMk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1793299629;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=abqJJXaGGpMxrTTz4LNv0nEat57E5J8kh+2eC1Qx7y8=;
 b=X2bZ8PODmJ/LcKfy9cK5O/iKDFOiaul1PirJareJgZwbThudXjHZLGgK+zptzbPDvkqiUd
 ckrGDA6frZZ4okCQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=AA8bRlm9;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=UqDhJ+qH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1793299628; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=abqJJXaGGpMxrTTz4LNv0nEat57E5J8kh+2eC1Qx7y8=;
 b=AA8bRlm9P3EeKwXP2grltD48ztLXIO9q9isAXno1K3nzxNNQS+ROpL3uQ/LjrLXUWnJCZM
 mAa9VYGLc+68NtWKIrl2yrZF6i+UFFnt31dRnEHQDq2ql8+5zxONcQJvR3KuJl1bRJJv9T
 6UccIDByJ1yE60KR/L2Ct89jybFb+wQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1793299628;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=abqJJXaGGpMxrTTz4LNv0nEat57E5J8kh+2eC1Qx7y8=;
 b=UqDhJ+qHbPlPP3fp+wVwKFY7mxxdY32QzXROBGPRYqEsNF4S7aVeFzoBoJMq5mJ69fn/cW
 FhdDnnBU/nJZafBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2F3C713419;
 Thu, 29 Oct 2026 18:47:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cMnTJaOU42pwUgAAD6G6ig:T6
 (envelope-from <farosas@suse.de>); Thu, 29 Oct 2026 18:47:07 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
Subject: [PULL 5/8] migration: Split migration_channel_process_incoming()
Date: Thu, 29 Oct 2026 15:46:38 -0300
Message-ID: <20261029184641.1973813-6-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261029184641.1973813-1-farosas@suse.de>
References: <20261029184641.1973813-1-farosas@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-12.01 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:dkim];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -12.01
X-Rspamd-Queue-Id: 0D1731FAA3
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

From: Peter Xu <peterx@redhat.com>

Introduce two smaller functions for it,

- migration_incoming_channel_install(): peek at channels whenever possible,
  and install the channel to one of the slots (main, multifd, preempt)

- migration_incoming_error_propagate(): handling an error happened during
  channel establish phase of an incoming migration.

When at it, move the set channel tracepoint into the 1st helper, replacing
the existing tracepoint with trace_migration_channel_process_incoming().
So far, they should fire almost the same time if the channel peek worked.
This fact will change in follow up refactorings.

I also moved migration_ioc_register_yank() to be after identify, hopefully
it makes more sense: we'd better be careful on registration of yank, or we
should be prepared for explosions.  Previously it worked, my guess is when
error happens we never unregister yank but hang dest QEMU or quit,
depending on exit_on_error value.

No real functional change intended.

Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/channel.c    | 57 +++++++++++++++++++++++++++++-------------
 migration/trace-events |  1 +
 2 files changed, 41 insertions(+), 17 deletions(-)

diff --git a/migration/channel.c b/migration/channel.c
index 266ae8f7760..8407ea46cb8 100644
--- a/migration/channel.c
+++ b/migration/channel.c
@@ -197,6 +197,42 @@ out:
     return channel;
 }
 
+static void migration_incoming_error_propagate(MigrationIncomingState *mis,
+                                               Error *error)
+{
+    error_report_err(error);
+    migrate_set_state(&mis->state, mis->state, MIGRATION_STATUS_FAILED);
+    if (mis->exit_on_error) {
+        exit(EXIT_FAILURE);
+    }
+}
+
+static bool migration_incoming_channel_install(MigrationIncomingState *mis,
+                                               QIOChannel *ioc,
+                                               Error **errp)
+{
+    MigChannelType ch = migration_channel_identify(mis, ioc, errp);
+
+    if (!ch) {
+        assert(*errp);
+        return false;
+    }
+
+    trace_migration_set_incoming_channel(ioc,
+                                         object_get_typename(OBJECT(ioc)));
+    migration_ioc_register_yank(ioc);
+
+    if (migration_incoming_setup(ioc, ch, errp)) {
+        migration_start_incoming();
+    }
+
+    if (*errp) {
+        return false;
+    }
+
+    return true;
+}
+
 /**
  * @migration_channel_process_incoming - Create new incoming migration channel
  *
@@ -209,31 +245,18 @@ void migration_channel_process_incoming(QIOChannel *ioc)
 {
     MigrationIncomingState *mis = migration_incoming_get_current();
     Error *local_err = NULL;
-    MigChannelType ch;
 
-    trace_migration_set_incoming_channel(
+    trace_migration_channel_process_incoming(
         ioc, object_get_typename(OBJECT(ioc)));
 
     if (migrate_channel_requires_tls_upgrade(ioc)) {
         migration_tls_channel_process_incoming(ioc, &local_err);
     } else {
-        migration_ioc_register_yank(ioc);
-        ch = migration_channel_identify(mis, ioc, &local_err);
-        if (!ch) {
-            goto out;
-        }
-
-        if (migration_incoming_setup(ioc, ch, &local_err)) {
-            migration_start_incoming();
-        }
+        migration_incoming_channel_install(mis, ioc, &local_err);
     }
-out:
+
     if (local_err) {
-        error_report_err(local_err);
-        migrate_set_state(&mis->state, mis->state, MIGRATION_STATUS_FAILED);
-        if (mis->exit_on_error) {
-            exit(EXIT_FAILURE);
-        }
+        migration_incoming_error_propagate(mis, local_err);
     }
 }
 
diff --git a/migration/trace-events b/migration/trace-events
index 68bcf12dc71..c93c9f9e750 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -207,6 +207,7 @@ migration_start_incoming(void) ""
 migration_transferred_bytes(uint64_t qemu_file, uint64_t multifd, uint64_t rdma) "qemu_file %" PRIu64 " multifd %" PRIu64 " RDMA %" PRIu64
 
 # channel.c
+migration_channel_process_incoming(void *ioc, const char *ioctype) "ioc=%p ioctype=%s"
 migration_set_incoming_channel(void *ioc, const char *ioctype) "ioc=%p ioctype=%s"
 migration_set_outgoing_channel(void *ioc, const char *ioctype) "ioc=%p ioctype=%s"
 
-- 
2.53.0


