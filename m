Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2F4606A329
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 18:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=dL2KvPNG;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Lpzx7eb8;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=dL2KvPNG;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Lpzx7eb8
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMV9p-0002bp-C7; Thu, 29 Oct 2026 14:47:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xMV9Y-0002Vc-Kg
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 14:47:10 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xMV9U-00022c-UA
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 14:47:08 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6B94C1F449;
 Thu, 29 Oct 2026 18:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1793299621; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=u83QGbTIYd7FLeDTGF6xgJHlMXApj4v01AA4LJZXooA=;
 b=dL2KvPNGROUrTzEMOsKFD9PkJMRKlRuPsl1+8RIrrv3ZuhuG/pWrJMLEWT4VqikrXjpMvi
 uMyNiDT5wqwRPdQ4YTBvz2+UotkEJgR75+BV+dEdhwnafozIPEBaqDoFsKki1vgi1V1F02
 0m3eedxFCBDSpgKDu+49GPBeON5aeBc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1793299621;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=u83QGbTIYd7FLeDTGF6xgJHlMXApj4v01AA4LJZXooA=;
 b=Lpzx7eb81Ryp6MYvwjGCLQyUNkbBTvZZ9pFNRdesY9wD5VYcJW4oheyD6H+9FXgrZGJ+QK
 OiNnLuObrYzvkFAw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=dL2KvPNG;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Lpzx7eb8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1793299621; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=u83QGbTIYd7FLeDTGF6xgJHlMXApj4v01AA4LJZXooA=;
 b=dL2KvPNGROUrTzEMOsKFD9PkJMRKlRuPsl1+8RIrrv3ZuhuG/pWrJMLEWT4VqikrXjpMvi
 uMyNiDT5wqwRPdQ4YTBvz2+UotkEJgR75+BV+dEdhwnafozIPEBaqDoFsKki1vgi1V1F02
 0m3eedxFCBDSpgKDu+49GPBeON5aeBc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1793299621;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=u83QGbTIYd7FLeDTGF6xgJHlMXApj4v01AA4LJZXooA=;
 b=Lpzx7eb81Ryp6MYvwjGCLQyUNkbBTvZZ9pFNRdesY9wD5VYcJW4oheyD6H+9FXgrZGJ+QK
 OiNnLuObrYzvkFAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1C62813419;
 Thu, 29 Oct 2026 18:46:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cMnTJaOU42pwUgAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 29 Oct 2026 18:46:59 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
Subject: [PULL 0/8] Migration patches for 2026-10-29
Date: Thu, 29 Oct 2026 15:46:33 -0300
Message-ID: <20261029184641.1973813-1-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6B94C1F449
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-12.51 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_TLS_ALL(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,gitlab.com:url,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -12.51
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The following changes since commit 5624b266cdd513506fb333e9041778407b6d1ac4:

  Merge tag 'qga-pull-2026-10-28-2' of https://github.com/kostyanf14/qemu into staging (2026-10-28 14:53:37 -0500)

are available in the Git repository at:

  https://gitlab.com/farosas/qemu.git tags/migration-20261029-pull-request

for you to fetch changes up to 232489829c3bf5b5c13d5e1f6d8d1e63244637b4:

  migration: Postpone the outgoing preempt channel for preempt_pre_7_2 (2026-10-29 13:13:13 -0300)

----------------------------------------------------------------
Migration pull-request

- Compatibility fix for multifd+postcopy migration against older versions
- Rework of early connection code
- Adjustment to snapshot thread name

----------------------------------------------------------------

Peter Xu (7):
  tests/migration-test: Add multifd+postcopy test for preempt recovery
  migration: Add two more trace points for incoming channel mgmt
  migration: Fix socket listen backlog
  migration: Split migration_channel_process_incoming()
  migration: Dump type of channel in set_incoming_channel tracepoint
  migration: Fix incoming channel race with multifd and preempt_pre_7_2
  migration: Postpone the outgoing preempt channel for preempt_pre_7_2

yuanminghao (1):
  migration: shorten dst snapshot load thread name

 migration/channel.c                    | 448 +++++++++++++++++++++----
 migration/channel.h                    |   6 +-
 migration/migration.c                  |  67 +++-
 migration/migration.h                  |  37 +-
 migration/socket.c                     |  25 +-
 migration/trace-events                 |   8 +-
 tests/qtest/migration/postcopy-tests.c |  11 +
 7 files changed, 512 insertions(+), 90 deletions(-)

-- 
2.53.0


