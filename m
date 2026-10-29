Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838C7606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 18:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=uAKJFCrW;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=AL57SlDH;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=uAKJFCrW;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=AL57SlDH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMVAF-0002pX-Fq; Thu, 29 Oct 2026 14:47:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xMV9f-0002WD-CF
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 14:47:15 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xMV9d-00023w-Kx
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 14:47:15 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6FB8A1F8C2;
 Thu, 29 Oct 2026 18:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1793299632; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p0uOWDa+WPB76fa3h6SyMG/PYYR+nyzZ1IYnU1HR1aQ=;
 b=uAKJFCrW7DCEPI/Ni/c9GB9LGKGDS+z3IGQt2ydRxlSMd6B8nvBqfx0hkujsInhd2ACI9V
 aRG8PgVWFpETs2F+YGN+AGc8RYpDw7NMaCKBdahbKc5cNrnQf7kS/OItNw5zgMypf4DCZP
 vHJ48on3hUQZyHeDL7KKqY1KjHo/Kw4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1793299632;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p0uOWDa+WPB76fa3h6SyMG/PYYR+nyzZ1IYnU1HR1aQ=;
 b=AL57SlDHHlqtg92Z+MWiXc344ep4q+B32RVZSJbbBXXwGSOYpBR/w5p/BfTtcmOWogEflE
 fLNxqcnH4kcyT6Ag==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1793299632; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p0uOWDa+WPB76fa3h6SyMG/PYYR+nyzZ1IYnU1HR1aQ=;
 b=uAKJFCrW7DCEPI/Ni/c9GB9LGKGDS+z3IGQt2ydRxlSMd6B8nvBqfx0hkujsInhd2ACI9V
 aRG8PgVWFpETs2F+YGN+AGc8RYpDw7NMaCKBdahbKc5cNrnQf7kS/OItNw5zgMypf4DCZP
 vHJ48on3hUQZyHeDL7KKqY1KjHo/Kw4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1793299632;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p0uOWDa+WPB76fa3h6SyMG/PYYR+nyzZ1IYnU1HR1aQ=;
 b=AL57SlDHHlqtg92Z+MWiXc344ep4q+B32RVZSJbbBXXwGSOYpBR/w5p/BfTtcmOWogEflE
 fLNxqcnH4kcyT6Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 92DF61342D;
 Thu, 29 Oct 2026 18:47:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cMnTJaOU42pwUgAAD6G6ig:T9
 (envelope-from <farosas@suse.de>); Thu, 29 Oct 2026 18:47:11 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
Subject: [PULL 8/8] migration: Postpone the outgoing preempt channel for
 preempt_pre_7_2
Date: Thu, 29 Oct 2026 15:46:41 -0300
Message-ID: <20261029184641.1973813-9-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261029184641.1973813-1-farosas@suse.de>
References: <20261029184641.1973813-1-farosas@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-11.80 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-0.996]; MIME_GOOD(-0.10)[text/plain];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -11.80
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

This is the corresponding outgoing fix for the same problem mentioned in
the previous patch.

The idea is simple: either migration to an old QEMU or when TLS is enabled,
we rely on correct ordering of channels to make it work: first main, then
multifd, finally preempt.

This patch re-orders multifd and postcopy preempt channel on outgoing side,
but only for the old machine types where preempt_pre_7_2 set, to make it
follow the right orders to create the channels.

Keep the resume path alone because the resume path never involve multifd
channels, even if multifd is enabled.  For that, fun fact: when multifd is
enabled with postcopy preempt, network interruption will break all multifd
channels, but they're never re-connected, until they got recycled at the
end of postcopy migration.  OTOH, multifd_recv_all_channels_created()
reports true even after postcopy network down, as multifd_recv_state->count
is never decremented.

NOTE: this will move the preempt channel connection no matter multifd is
enabled or not.  It should fix multifd's case, but should have zero impact
on when multifd is not enabled.

Fixes: e27418861288 ("migration: enable multifd and postcopy together")
Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index b140fb69509..53cb6d38210 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3729,6 +3729,21 @@ static void *migration_thread(void *opaque)
         goto out;
     }
 
+    /*
+     * Only for old 7.1/7.2 machine types (preempt mode supported since
+     * 7.1).  Connect the preempt channel only after multifd channels,
+     * because some QEMU versions (v10.1 to v11.1) will assume the order of
+     * channels to be: (1) main, then (2) multifd channels, then (3)
+     * preempt channel.  IOW, (3) must be after (2).
+     *
+     * multifd_send_setup() makes sure all multifd channels be connected
+     * first, then initiate preempt channel here guarantees the ordering to
+     * those QEMU binaries.
+     */
+    if (migrate_postcopy_preempt() && s->preempt_pre_7_2) {
+        postcopy_preempt_setup(s);
+    }
+
     bql_lock();
     qemu_savevm_state_header(s->to_dst_file);
     bql_unlock();
@@ -4009,16 +4024,16 @@ void migration_start_outgoing(MigrationState *s)
         open_return_path_on_source(s);
     }
 
-    /*
-     * This needs to be done before resuming a postcopy.  Note: for newer
-     * QEMUs we will delay the channel creation until postcopy_start(), to
-     * avoid disorder of channel creations.
-     */
-    if (migrate_postcopy_preempt() && s->preempt_pre_7_2) {
-        postcopy_preempt_setup(s);
-    }
-
     if (resume) {
+        /*
+         * This needs to be done before resuming a postcopy.  Note: for newer
+         * QEMUs we will delay the channel creation until postcopy_start(), to
+         * avoid disorder of channel creations.
+         */
+        if (migrate_postcopy_preempt() && s->preempt_pre_7_2) {
+            postcopy_preempt_setup(s);
+        }
+
         /* Wakeup the main migration thread to do the recovery */
         migrate_set_state(&s->state, MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP,
                           MIGRATION_STATUS_POSTCOPY_RECOVER);
-- 
2.53.0


