Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBF44103E2EA
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 22:14:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0Ro6-0000th-KQ; Wed, 11 Mar 2026 18:13:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w0Ro3-0000ro-9w
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 18:13:31 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w0Rnz-0004yj-AF
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 18:13:29 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 011484D641
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 22:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773267204; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=RDaLoSsTrn0pVHnPscMM4+RNOLm/QVTzJ5WTa8UhA94=;
 b=E9UqaBv0mTnfUwIJNZ7nSUqcZr06uAAUw1Patm9v+DeENrtwNER3hGu5y9bW+tGWPvlDMX
 UVKSxzrMGtBGfXNOlivzUMv2iHtPDsBtVbI3/9zJVUS+vkhBUCg7Hpog838ROGNpHbH29v
 e5Ib2o5wswLzQK9ibwWvVtCW8buaKjM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773267204;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=RDaLoSsTrn0pVHnPscMM4+RNOLm/QVTzJ5WTa8UhA94=;
 b=SiAS87cjELStjmI8C53UZfy3nM5+gBj/cVWq5Cl0tUF6ndrBF9R4HJMDy/7kndBo/ZW9hz
 O3sjR17VF6a0uYDg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=E9UqaBv0;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=SiAS87cj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773267204; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=RDaLoSsTrn0pVHnPscMM4+RNOLm/QVTzJ5WTa8UhA94=;
 b=E9UqaBv0mTnfUwIJNZ7nSUqcZr06uAAUw1Patm9v+DeENrtwNER3hGu5y9bW+tGWPvlDMX
 UVKSxzrMGtBGfXNOlivzUMv2iHtPDsBtVbI3/9zJVUS+vkhBUCg7Hpog838ROGNpHbH29v
 e5Ib2o5wswLzQK9ibwWvVtCW8buaKjM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773267204;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=RDaLoSsTrn0pVHnPscMM4+RNOLm/QVTzJ5WTa8UhA94=;
 b=SiAS87cjELStjmI8C53UZfy3nM5+gBj/cVWq5Cl0tUF6ndrBF9R4HJMDy/7kndBo/ZW9hz
 O3sjR17VF6a0uYDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 499203FC44
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 22:13:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id L6prBAPpsWnCeQAAD6G6ig
 (envelope-from <farosas@suse.de>)
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 22:13:23 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Subject: [PULL 0/3] QTest patches for 2026-03-11
Date: Wed, 11 Mar 2026 19:13:17 -0300
Message-ID: <20260311221320.22112-1-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 PREVIOUSLY_DELIVERED(0.00)[qemu-devel@nongnu.org];
 FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 011484D641
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

The following changes since commit 1fd5ff9d76d23ab23a68419cbc76d5ee33e8b455:

  Merge tag 'for-upstream' of https://gitlab.com/kmwolf/qemu into staging (2026-03-10 16:29:24 +0000)

are available in the Git repository at:

  https://gitlab.com/farosas/qemu.git tags/qtest-20260311-pull-request

for you to fetch changes up to 6ba08f4acec830d12f6983b0988c901258654a12:

  tests/qtest/test-x86-cpuid-compat: Switch test_feature_flag to data-driven (2026-03-11 18:43:20 -0300)

----------------------------------------------------------------
Qtest pull request

- memory leak fixes

----------------------------------------------------------------

Peter Maydell (3):
  tests/qtest/vhost-user-test: Use g_timeout_add() to schedule connect
  tests/qtest/test-x86-cpuid-compat: Switch test_cpuid_prop to
    data-driven
  tests/qtest/test-x86-cpuid-compat: Switch test_feature_flag to
    data-driven

 tests/qtest/test-x86-cpuid-compat.c | 410 ++++++++++++++++------------
 tests/qtest/vhost-user-test.c       |  36 ++-
 2 files changed, 262 insertions(+), 184 deletions(-)

-- 
2.51.0


