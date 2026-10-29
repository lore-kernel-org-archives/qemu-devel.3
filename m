Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925C1606A324
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 18:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=j8LjqrIK;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=cLLOCSvt;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=j8LjqrIK;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=cLLOCSvt
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMVA9-0002hc-AL; Thu, 29 Oct 2026 14:47:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xMV9Y-0002Vb-2W
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 14:47:10 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xMV9U-00022q-SI
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 14:47:07 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 635C31F813;
 Thu, 29 Oct 2026 18:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1793299623; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k6NBGJzufmtbhbdPvtjxl8Tlabi1WpY93xHLXk8DHN0=;
 b=j8LjqrIKLxAZYfv3ERQ0MlTvyB9OT+TNF2JZ88c0zi83L2unDIGwtSvAdntaJtmYu0dqQm
 O8q2yFmATwjQMhXox9xTnC5FSC/1Vwz2/etLSfGAeh9Xoq5reLFyyLG5xUp1hJboO3BLrm
 lpxvFhGNDL31aptZylzeoC80oM1zVT0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1793299623;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k6NBGJzufmtbhbdPvtjxl8Tlabi1WpY93xHLXk8DHN0=;
 b=cLLOCSvtFmKckQZ1U2lJY1KHVfd8fWUsrr2BPEN3GorpIrokcLCcZrpOGrAOsSR3w8nv7/
 c1opFbZGY7/rweDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1793299623; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k6NBGJzufmtbhbdPvtjxl8Tlabi1WpY93xHLXk8DHN0=;
 b=j8LjqrIKLxAZYfv3ERQ0MlTvyB9OT+TNF2JZ88c0zi83L2unDIGwtSvAdntaJtmYu0dqQm
 O8q2yFmATwjQMhXox9xTnC5FSC/1Vwz2/etLSfGAeh9Xoq5reLFyyLG5xUp1hJboO3BLrm
 lpxvFhGNDL31aptZylzeoC80oM1zVT0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1793299623;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k6NBGJzufmtbhbdPvtjxl8Tlabi1WpY93xHLXk8DHN0=;
 b=cLLOCSvtFmKckQZ1U2lJY1KHVfd8fWUsrr2BPEN3GorpIrokcLCcZrpOGrAOsSR3w8nv7/
 c1opFbZGY7/rweDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F00B013419;
 Thu, 29 Oct 2026 18:47:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cMnTJaOU42pwUgAAD6G6ig:T2
 (envelope-from <farosas@suse.de>); Thu, 29 Oct 2026 18:47:01 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	yuanminghao <yuanmh12@chinatelecom.cn>
Subject: [PULL 1/8] migration: shorten dst snapshot load thread name
Date: Thu, 29 Oct 2026 15:46:34 -0300
Message-ID: <20261029184641.1973813-2-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261029184641.1973813-1-farosas@suse.de>
References: <20261029184641.1973813-1-farosas@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-11.80 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[99.99%]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-0.996]; MIME_GOOD(-0.10)[text/plain];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -11.80
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

From: yuanminghao <yuanmh12@chinatelecom.cn>

pthread_setname_np() fails with ERANGE if the name is longer than
15 characters, so "mig/dst/snapshot_load" (21 characters) is
rejected and the thread keeps its default name.

Shorten it to "mig/dst/snapld" (15 characters) so the name is
actually applied.

Signed-off-by: yuanminghao <yuanmh12@chinatelecom.cn>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/migration.h b/migration/migration.h
index 683bc7bdd52..1329f6bba48 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -42,7 +42,7 @@
 #define  MIGRATION_THREAD_DST_FAULT         "mig/dst/fault"
 #define  MIGRATION_THREAD_DST_LISTEN        "mig/dst/listen"
 #define  MIGRATION_THREAD_DST_PREEMPT       "mig/dst/preempt"
-#define  MIGRATION_THREAD_DST_SNAPSHOT_LOAD "mig/dst/snapshot_load"
+#define  MIGRATION_THREAD_DST_SNAPSHOT_LOAD "mig/dst/snapld"
 
 struct PostcopyBlocktimeContext;
 typedef struct ThreadPool ThreadPool;
-- 
2.53.0


