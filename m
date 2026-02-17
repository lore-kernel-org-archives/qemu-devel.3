Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86536E909D0
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 16:16:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsNjF-00018y-7A; Tue, 17 Feb 2026 11:15:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vsNjD-00018N-NI
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 11:15:11 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vsNjC-000379-4P
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 11:15:11 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id F16233E720;
 Tue, 17 Feb 2026 16:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1771344898; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/FTa9nDOo0CQKYv3Kw0PjHMAuXiEYgAuNBcR2Xn4edk=;
 b=U+pau7cKJSCu7C+fY84Rzot5bg9jXPBwguMdbdutUxfGypLw0AWwvyt5X53C5QxjjBSp8d
 +rjTFJQsiKPp19war52jlzEbbNzF6QbXH656jET5DeL76tyKioH0nP5tZIegYRqbDkKyOu
 H8ZUrOU5BNksI02LK3Ja1JKS1KER6Ao=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1771344898;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/FTa9nDOo0CQKYv3Kw0PjHMAuXiEYgAuNBcR2Xn4edk=;
 b=w6hgHXFSqSw7rLsdbWRdmxxMQa7js/9zaFA3UYRE7KP90Z6Ek9QnO9VZvMch/Ee5dHIyA9
 wxPwbNrL6OZsqmAQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=vUt9K8Dr;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=azxbTjW8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1771344897; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/FTa9nDOo0CQKYv3Kw0PjHMAuXiEYgAuNBcR2Xn4edk=;
 b=vUt9K8Drwiu5c7p8h+F0X4EXSfR9C0JAUexBHsTtvov7fovksSyDQLh30zbmBNSbTfFWMx
 1uGsmHxxQhJaAK8DEtZ9BG+u3G1o49Xg7JSnDtailqFZj42lglhI8koxZIsONgboi9Yrse
 m0532juNZH2Cks7YkfxpRmRV1FxX+dc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1771344897;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/FTa9nDOo0CQKYv3Kw0PjHMAuXiEYgAuNBcR2Xn4edk=;
 b=azxbTjW8O0xS9LXqm7c10TcCwox7P8f5FuptfWIfVIcXUaEG/gx51BDc5UGEHPLHrmARpc
 +sh0eNuPQWowEcCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F18633EA66;
 Tue, 17 Feb 2026 16:14:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iGUILQCUlGmHTgAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 17 Feb 2026 16:14:56 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
Subject: [PULL 06/32] migration: Update comments mentioning qmp_migrate_finish
Date: Tue, 17 Feb 2026 13:14:17 -0300
Message-ID: <20260217161443.12738-7-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260217161443.12738-1-farosas@suse.de>
References: <20260217161443.12738-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 URIBL_BLOCKED(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: F16233E720
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The qmp_migrate_finish function was recently removed in commit
2379a04e60 ("migration: Remove qmp_migrate_finish"), update comments
that mention it.

Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260202124112.30684-1-farosas@suse.de
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 7ab0294d22..850150a261 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1473,8 +1473,8 @@ void migration_cancel(void)
     }
 
     /*
-     * If qmp_migrate_finish has not been called, then there is no path that
-     * will complete the cancellation.  Do it now.
+     * If migration_connect_outgoing has not been called, then there
+     * is no path that will complete the cancellation. Do it now.
      */
     if (setup && !s->to_dst_file) {
         migrate_set_state(&s->state, MIGRATION_STATUS_CANCELLING,
@@ -2057,11 +2057,12 @@ void qmp_migrate(const char *uri, bool has_channels,
      * For cpr-transfer, the target may not be listening yet on the migration
      * channel, because first it must finish cpr_load_state.  The target tells
      * us it is listening by closing the cpr-state socket.  Wait for that HUP
-     * event before connecting in qmp_migrate_finish.
+     * event before connecting in migration_connect_outgoing.
      *
      * The HUP could occur because the target fails while reading CPR state,
      * in which case the target will not listen for the incoming migration
-     * connection, so qmp_migrate_finish will fail to connect, and then recover.
+     * connection, so migration_connect_outgoing will fail to connect,
+     * and then recover.
      */
     if (migrate_mode() == MIG_MODE_CPR_TRANSFER) {
         cpr_transfer_add_hup_watch(s, migration_connect_outgoing_cb,
-- 
2.51.0


