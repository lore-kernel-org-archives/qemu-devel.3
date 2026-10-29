Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B0B60A2622
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 18:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=BMrfmpO8;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=v4/zaKch;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=BMrfmpO8;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=v4/zaKch
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMV9n-0002ZV-BT; Thu, 29 Oct 2026 14:47:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xMV9d-0002W0-Ot
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 14:47:15 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xMV9c-00023e-1g
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 14:47:13 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 274FA22222;
 Thu, 29 Oct 2026 18:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1793299629; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pPN03CRQU8TXN2+fdlS1/hfeqTcY6ydjhZLZkENKmf4=;
 b=BMrfmpO8bgJR8kWyBTnhOA3PVIFXE8J7N00RogfQf8/77Abxepg6eciPQt+b1kOMXYUH0h
 peaJNKd41Te4vTSYBMH0iNoyaSdg24U/xwC0dqAXrIVW2Vy+awz3jrCFcZtLAwQTr5+2rK
 Q4Q23GWubeoDoRq5eJl/de7Q+zff6E4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1793299629;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pPN03CRQU8TXN2+fdlS1/hfeqTcY6ydjhZLZkENKmf4=;
 b=v4/zaKchCVRUfmhTYiS1+cxJhVjaAR0ScJUTY2XGo6kMeSed8XBtIH8hX9j/ssgf3xtany
 Lr5hvLhwwVZctOAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1793299629; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pPN03CRQU8TXN2+fdlS1/hfeqTcY6ydjhZLZkENKmf4=;
 b=BMrfmpO8bgJR8kWyBTnhOA3PVIFXE8J7N00RogfQf8/77Abxepg6eciPQt+b1kOMXYUH0h
 peaJNKd41Te4vTSYBMH0iNoyaSdg24U/xwC0dqAXrIVW2Vy+awz3jrCFcZtLAwQTr5+2rK
 Q4Q23GWubeoDoRq5eJl/de7Q+zff6E4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1793299629;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pPN03CRQU8TXN2+fdlS1/hfeqTcY6ydjhZLZkENKmf4=;
 b=v4/zaKchCVRUfmhTYiS1+cxJhVjaAR0ScJUTY2XGo6kMeSed8XBtIH8hX9j/ssgf3xtany
 Lr5hvLhwwVZctOAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4A2671342D;
 Thu, 29 Oct 2026 18:47:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cMnTJaOU42pwUgAAD6G6ig:T7
 (envelope-from <farosas@suse.de>); Thu, 29 Oct 2026 18:47:08 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
Subject: [PULL 6/8] migration: Dump type of channel in set_incoming_channel
 tracepoint
Date: Thu, 29 Oct 2026 15:46:39 -0300
Message-ID: <20261029184641.1973813-7-farosas@suse.de>
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
 ARC_NA(0.00)[]; RCPT_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email];
 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -11.80
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

Add this info to be crystal clear on what channel we're installing.

Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/channel.c    | 10 +++++++++-
 migration/channel.h    |  3 ++-
 migration/trace-events |  2 +-
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/migration/channel.c b/migration/channel.c
index 8407ea46cb8..b9065efd03f 100644
--- a/migration/channel.c
+++ b/migration/channel.c
@@ -34,6 +34,13 @@
 #include "trace.h"
 #include "yank_functions.h"
 
+static const char *const mig_channel_str[CH_NUM] = {
+    [CH_NONE] = "NONE",
+    [CH_MAIN] = "MAIN",
+    [CH_MULTIFD] = "MULTIFD",
+    [CH_POSTCOPY] = "PREEMPT",
+};
+
 void migration_connect_outgoing(MigrationState *s, MigrationAddress *addr,
                                 Error **errp)
 {
@@ -219,7 +226,8 @@ static bool migration_incoming_channel_install(MigrationIncomingState *mis,
     }
 
     trace_migration_set_incoming_channel(ioc,
-                                         object_get_typename(OBJECT(ioc)));
+                                         object_get_typename(OBJECT(ioc)),
+                                         mig_channel_str[ch]);
     migration_ioc_register_yank(ioc);
 
     if (migration_incoming_setup(ioc, ch, errp)) {
diff --git a/migration/channel.h b/migration/channel.h
index a7d0d290586..678712f2919 100644
--- a/migration/channel.h
+++ b/migration/channel.h
@@ -24,7 +24,8 @@ typedef enum {
     CH_NONE,
     CH_MAIN,
     CH_MULTIFD,
-    CH_POSTCOPY
+    CH_POSTCOPY,
+    CH_NUM,
 } MigChannelType;
 
 void migration_channel_process_incoming(QIOChannel *ioc);
diff --git a/migration/trace-events b/migration/trace-events
index c93c9f9e750..8840d82f8dc 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -208,7 +208,7 @@ migration_transferred_bytes(uint64_t qemu_file, uint64_t multifd, uint64_t rdma)
 
 # channel.c
 migration_channel_process_incoming(void *ioc, const char *ioctype) "ioc=%p ioctype=%s"
-migration_set_incoming_channel(void *ioc, const char *ioctype) "ioc=%p ioctype=%s"
+migration_set_incoming_channel(void *ioc, const char *ioctype, const char *type) "ioc=%p ioctype=%s type=%s"
 migration_set_outgoing_channel(void *ioc, const char *ioctype) "ioc=%p ioctype=%s"
 
 # global_state.c
-- 
2.53.0


