Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CFF606A337
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 14:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=w62znqvK;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=g88/3Jw1;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=jpn3/Txw;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=mSkfj8I8
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTKEr-0007dv-5D; Tue, 17 Nov 2026 09:32:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xTKEp-0007da-Mg
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 09:32:47 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xTKEo-00042T-2a
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 09:32:47 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7F66B1F7A4;
 Tue, 17 Nov 2026 14:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1794925963; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aWk6QXenceXHDB2foceOzqdWr7mbh8OdPJHbQGcw+Zg=;
 b=w62znqvKiz0fjvu4VgNavOtMOipkXhjbr7wpwlgjw+I6xy+UJ75tZRQ6NcfhcvKY40tMWs
 rM0OkYg0Q7nJiS9deNCLyGwtKrvd6hgHVBbzFsyTVYA1vMC7mSzCCastk2Ifh/a6NRBf9F
 WWSbabXu+0ib9aTLT91BtMSbroSZYYw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1794925963;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aWk6QXenceXHDB2foceOzqdWr7mbh8OdPJHbQGcw+Zg=;
 b=g88/3Jw1aIVS0OzS4BD6iAA1v+l9gUTToXJYMeHswTrb6QvqNOZZT5Ud35OJ+f5AmcgVl0
 Hzjbszu1D1SWOWCw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="jpn3/Txw";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=mSkfj8I8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1794925961; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aWk6QXenceXHDB2foceOzqdWr7mbh8OdPJHbQGcw+Zg=;
 b=jpn3/TxwQw1HwgpH7kuvlxhhG/zE5UiVOIc76z3VRckVheBwL2VTFOELCg1BfJd9OkitCb
 ax38lfizN7bgvKDLGMKW6utQbeHwjBQGZcmFrr3THKARTPAmc5aqKb275vFR/hYqCuA6Kp
 4L/wpuZj+dmaBNvETXd4sZcgzL0L0So=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1794925961;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aWk6QXenceXHDB2foceOzqdWr7mbh8OdPJHbQGcw+Zg=;
 b=mSkfj8I8QG8Hs3KRvIN2BQj7UEpwgc9J5JO2tI+ZdrJku3vLe2uU7BOZw9qT4ZpdHmCxgf
 BpxCKituT9RLUfBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2A18813507;
 Tue, 17 Nov 2026 14:32:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id lN5qDIRl/GpRQAAAD6G6ig:T3
 (envelope-from <farosas@suse.de>); Tue, 17 Nov 2026 14:32:39 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, niming <niming@sangfor.com.cn>,
 zhuwei <zhuwei@sangfor.com.cn>
Subject: [PULL 2/3] migration: free migration blocker error in
 migrate_del_blocker() stub
Date: Tue, 17 Nov 2026 11:32:32 -0300
Message-ID: <20261117143234.1794926-3-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261117143234.1794926-1-farosas@suse.de>
References: <20261117143234.1794926-1-farosas@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-12.01 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 URIBL_BLOCKED(0.00)[suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,sangfor.com.cn:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 RCPT_COUNT_THREE(0.00)[4]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -12.01
X-Rspamd-Queue-Id: 7F66B1F7A4
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

From: niming <niming@sangfor.com.cn>

The migrate_del_blocker() implementation in stubs/migr-blocker.c was an
empty no-op, while the real one in migration/migration.c takes ownership
of the Error from the migration blocker, frees it and then clears the
pointer:

    void migrate_del_blocker(Error **reasonp)
    {
        if (*reasonp) {
            ...
            error_free(*reasonp);
            *reasonp = NULL;
        }
    }

Command line tools such as qemu-img link against the stub API. Block
drivers like vmdk allocate a migration blocker Error during open() (see
error_setg() in vmdk_open(), "does not support live migration") and pass
it to migrate_add_blocker_normal(). Because the stub migrate_add_blocker*()
is a no-op it does not take ownership of the Error, so on close the
stub migrate_del_blocker() has to free it itself; leaving the body empty
leaks the error message.

This becomes visible when running under ASan: "qemu-img info foo.vmdk"
leaks the migration-blocker error and hangs / fails to exit when the
image is closed.

Free the Error in the stub migrate_del_blocker() and set the pointer to
NULL to match the semantics of the real implementation. This also covers
every other driver that uses a migration blocker through the stub.

Signed-off-by: niming <niming@sangfor.com.cn>
Signed-off-by: zhuwei <zhuwei@sangfor.com.cn>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 stubs/migr-blocker.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/stubs/migr-blocker.c b/stubs/migr-blocker.c
index e54c7160d3d..3c1f2813814 100644
--- a/stubs/migr-blocker.c
+++ b/stubs/migr-blocker.c
@@ -1,5 +1,6 @@
 #include "qemu/osdep.h"
 #include "migration/blocker.h"
+#include "qapi/error.h"
 
 int migrate_add_blocker(Error **reasonp, Error **errp)
 {
@@ -18,4 +19,12 @@ int migrate_add_blocker_modes(Error **reasonp, unsigned modes, Error **errp)
 
 void migrate_del_blocker(Error **reasonp)
 {
+    /*
+     * migrate_add_blocker*() is a no-op here, so nobody owns the Error;
+     * free it to avoid a leak (e.g. "qemu-img info foo.vmdk").
+     */
+    if (reasonp && *reasonp) {
+        error_free(*reasonp);
+        *reasonp = NULL;
+    }
 }
-- 
2.53.0


