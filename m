Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55389CA0EE6
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 22:39:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoUzA-00082Y-Kz; Tue, 19 Aug 2025 18:39:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uoUz9-00082Q-B0
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 18:39:19 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uoUz7-00083L-Al
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 18:39:19 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9F47721243;
 Tue, 19 Aug 2025 22:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1755643153; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=zW1SwuXe7MZ8OTEwokNIbRFXmpZG8oGqrebiGLL5h6A=;
 b=eT2QHi112oBSmB0WX9KxvbfgUoo0f/DuW81cMkgnqkG6y9SfuXf7kADtivhPN8xKV53fAp
 X0rqYcbbPPqipUhk0pr1FU6+TACuzag6HZf41lv3wVODhg/Zcs6rjtlnzjcbIJ6SGSPMG0
 axQQO8ThOsVGo321+QVFzbKz1cOMopA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1755643153;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=zW1SwuXe7MZ8OTEwokNIbRFXmpZG8oGqrebiGLL5h6A=;
 b=kNuSDJ6L2N+/vXL+vO/HX7ydfy2ANVqsE6FNd8AE2M5vsPyWNpx4WWmtZ9eSHNYyh4a9+w
 XD/nVVRE+w6t5aCA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=eT2QHi11;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=kNuSDJ6L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1755643153; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=zW1SwuXe7MZ8OTEwokNIbRFXmpZG8oGqrebiGLL5h6A=;
 b=eT2QHi112oBSmB0WX9KxvbfgUoo0f/DuW81cMkgnqkG6y9SfuXf7kADtivhPN8xKV53fAp
 X0rqYcbbPPqipUhk0pr1FU6+TACuzag6HZf41lv3wVODhg/Zcs6rjtlnzjcbIJ6SGSPMG0
 axQQO8ThOsVGo321+QVFzbKz1cOMopA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1755643153;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=zW1SwuXe7MZ8OTEwokNIbRFXmpZG8oGqrebiGLL5h6A=;
 b=kNuSDJ6L2N+/vXL+vO/HX7ydfy2ANVqsE6FNd8AE2M5vsPyWNpx4WWmtZ9eSHNYyh4a9+w
 XD/nVVRE+w6t5aCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9DC38139B3;
 Tue, 19 Aug 2025 22:39:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id W8IdFg79pGh+TgAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 19 Aug 2025 22:39:10 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Fabian Vogt <fvogt@suse.de>, Peter Xu <peterx@redhat.com>
Subject: [PATCH 0/4] ppc: Fix migration issues with XICS and quiesce
Date: Tue, 19 Aug 2025 19:39:01 -0300
Message-Id: <20250819223905.2247-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9F47721243
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.49 / 50.00]; BAYES_HAM(-2.98)[99.91%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 FREEMAIL_CC(0.00)[gmail.com,redhat.com,suse.de];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 DKIM_TRACE(0.00)[suse.de:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid]
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Fabian reports two issues with migration on ppc64le, one of which with
a proposed fix, which I include in this series.

1) XICS migration causes a guest hang after migration due to missing
   ICP server state. Fix is to bring back the vmstate_register call
   for that device. Breaks backward migration, but it was already
   non-functional anyway.

2) pseries migration causes a guest hang after migration due to a new
   variable used to track the stopped state of vcpus, which is not
   migrated. Fix is to migrate the new variable. To avoid breaking
   backward migration, a compat property is added. Breaks forward
   migration, a workaround is proposed.

I also added some functional tests changes because there are currently
no test that can detect the kind of hangs seen here. RFC on those,
feel free to nitpick.

Thanks

CI run: https://gitlab.com/farosas/qemu/-/pipelines/1992482993

Fabian Vogt (1):
  hw/intc/xics: Add missing call to register vmstate_icp_server

Fabiano Rosas (3):
  tests/functional: Extract migration code into a new class
  tests/functional: Add a OS level migration test for pseries
  target/ppc: Fix env->quiesced migration

 hw/core/machine.c                       |  1 +
 hw/intc/xics.c                          |  2 ++
 target/ppc/cpu.h                        |  1 +
 target/ppc/cpu_init.c                   |  7 +++++
 target/ppc/machine.c                    | 40 ++++++++++++++++++++++++
 tests/functional/qemu_test/migration.py | 40 ++++++++++++++++++++++++
 tests/functional/test_migration.py      | 24 ++-------------
 tests/functional/test_ppc64_pseries.py  | 41 +++++++++++++++++++++++++
 8 files changed, 135 insertions(+), 21 deletions(-)
 create mode 100644 tests/functional/qemu_test/migration.py

-- 
2.35.3


