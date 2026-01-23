Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06341D778AE
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 19:56:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjNFH-0003kq-Jb; Fri, 23 Jan 2026 14:55:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vjNFG-0003jF-0u
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 14:55:02 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vjNFE-0003aE-AM
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 14:55:01 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4E7F03386C;
 Fri, 23 Jan 2026 19:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769198072; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IUnDK3WpqxryWIvg8TMFpCBEQuNkZay+AhRJeUZx8Yo=;
 b=05rRXPKZa0QN1hyND2JVRpiEIWpxJ9kOj+WbygnxcZGVWmHSiLiU6DYGtCrA2297nShNBh
 PwVTjTHX0wSJBxnIvSrxg3xgHJUTbTJpopruLsq95XZj4YCk2ZuLRst8+mjTcUA+KlFWj5
 Ya+5OBlLEWBlKzI7XxRCLIkqMGqkoxE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769198072;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IUnDK3WpqxryWIvg8TMFpCBEQuNkZay+AhRJeUZx8Yo=;
 b=rWFm3Pru0J1iDNksBE6NRqViIO/inHS4NLxzJBSGO/UQ578SMnene7yXBH6NGvLOjHQxUe
 6zdrTuTpbKuY0VBw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=05rRXPKZ;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=rWFm3Pru
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769198072; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IUnDK3WpqxryWIvg8TMFpCBEQuNkZay+AhRJeUZx8Yo=;
 b=05rRXPKZa0QN1hyND2JVRpiEIWpxJ9kOj+WbygnxcZGVWmHSiLiU6DYGtCrA2297nShNBh
 PwVTjTHX0wSJBxnIvSrxg3xgHJUTbTJpopruLsq95XZj4YCk2ZuLRst8+mjTcUA+KlFWj5
 Ya+5OBlLEWBlKzI7XxRCLIkqMGqkoxE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769198072;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IUnDK3WpqxryWIvg8TMFpCBEQuNkZay+AhRJeUZx8Yo=;
 b=rWFm3Pru0J1iDNksBE6NRqViIO/inHS4NLxzJBSGO/UQ578SMnene7yXBH6NGvLOjHQxUe
 6zdrTuTpbKuY0VBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EED151395E;
 Fri, 23 Jan 2026 19:54:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8BMDK/bRc2lFZQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 23 Jan 2026 19:54:30 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Prasad Pandit <pjp@fedoraproject.org>
Subject: [PULL 20/36] migration: Expand migration_connect_error_propagate to
 cover cancelling
Date: Fri, 23 Jan 2026 16:53:35 -0300
Message-ID: <20260123195352.12850-21-farosas@suse.de>
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
X-Rspamd-Queue-Id: 4E7F03386C
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
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

Cover the CANCELLING state in migration_connect_error_propagate() and
use it to funnel errors from migrate_prepare() until the end of
migration_connect().

Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>
Link: https://lore.kernel.org/qemu-devel/20260123141656.6765-10-farosas@suse.de
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 000f113307..a83edb39a0 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1572,18 +1572,25 @@ static void migrate_error_free(MigrationState *s)
 static void migration_connect_error_propagate(MigrationState *s, Error *error)
 {
     MigrationStatus current = s->state;
-    MigrationStatus next;
-
-    assert(s->to_dst_file == NULL);
+    MigrationStatus next = MIGRATION_STATUS_NONE;
 
     switch (current) {
     case MIGRATION_STATUS_SETUP:
         next = MIGRATION_STATUS_FAILED;
         break;
+
     case MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP:
         /* Never fail a postcopy migration; switch back to PAUSED instead */
         next = MIGRATION_STATUS_POSTCOPY_PAUSED;
         break;
+
+    case MIGRATION_STATUS_CANCELLING:
+        /*
+         * Don't move out of CANCELLING, the only valid transition is to
+         * CANCELLED, at migration_cleanup().
+         */
+        break;
+
     default:
         /*
          * This really shouldn't happen. Just be careful to not crash a VM
@@ -1594,7 +1601,10 @@ static void migration_connect_error_propagate(MigrationState *s, Error *error)
         return;
     }
 
-    migrate_set_state(&s->state, current, next);
+    if (next) {
+        migrate_set_state(&s->state, current, next);
+    }
+
     migrate_error_propagate(s, error);
 }
 
@@ -4098,10 +4108,7 @@ void migration_connect(MigrationState *s, Error *error_in)
     return;
 
 fail:
-    migrate_error_propagate(s, error_copy(local_err));
-    if (s->state != MIGRATION_STATUS_CANCELLING) {
-        migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
-    }
+    migration_connect_error_propagate(s, local_err);
     migration_cleanup(s);
     if (s->error) {
         error_report_err(error_copy(s->error));
-- 
2.51.0


