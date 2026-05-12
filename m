Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02656CD4F21
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:15:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuPP-0005I1-9V; Tue, 12 May 2026 17:12:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wMuP9-0004j8-5j
 for qemu-devel@nongnu.org; Tue, 12 May 2026 17:12:40 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wMuP5-0004oG-56
 for qemu-devel@nongnu.org; Tue, 12 May 2026 17:12:38 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0AC035C825
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 21:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1778620348; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=H5Qknj+AUaWYeSUBUfDFmOpGVNT61gox0hiFlKDzJ2s=;
 b=gAHVPVSGm13UaEnNwOtDsLO6z8qh1HBz87aswNlIwlMWXt1mCoeAYdiDyBHyft1lXA/xMp
 3TO5EWEwmf4F7L5dAS7jUDGmsbJlnnEuzs/OUm6XmL51/PcELlDH/tv0+4G9B6uOVU04tu
 +AYhUMMyLb+9hVYYGE9Lz6nfDPA2hiA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1778620348;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=H5Qknj+AUaWYeSUBUfDFmOpGVNT61gox0hiFlKDzJ2s=;
 b=wzU1dFH6JcdpFOpgntjRLGtGgFuxMWFY3Cg/K7QybIfqGBmiuhnv9voF3PcW+pgCP68303
 l/FHFjwe5d/XllCQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=gAHVPVSG;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=wzU1dFH6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1778620348; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=H5Qknj+AUaWYeSUBUfDFmOpGVNT61gox0hiFlKDzJ2s=;
 b=gAHVPVSGm13UaEnNwOtDsLO6z8qh1HBz87aswNlIwlMWXt1mCoeAYdiDyBHyft1lXA/xMp
 3TO5EWEwmf4F7L5dAS7jUDGmsbJlnnEuzs/OUm6XmL51/PcELlDH/tv0+4G9B6uOVU04tu
 +AYhUMMyLb+9hVYYGE9Lz6nfDPA2hiA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1778620348;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=H5Qknj+AUaWYeSUBUfDFmOpGVNT61gox0hiFlKDzJ2s=;
 b=wzU1dFH6JcdpFOpgntjRLGtGgFuxMWFY3Cg/K7QybIfqGBmiuhnv9voF3PcW+pgCP68303
 l/FHFjwe5d/XllCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7299B593A9
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 21:12:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gX7lELuXA2r+IAAAD6G6ig
 (envelope-from <farosas@suse.de>)
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 21:12:27 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Subject: [PULL 0/4] Qtest patches for 2026-05-12
Date: Tue, 12 May 2026 18:12:17 -0300
Message-ID: <20260512211221.3173-1-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 PREVIOUSLY_DELIVERED(0.00)[qemu-devel@nongnu.org];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 URIBL_BLOCKED(0.00)[suse.de:dkim,suse.de:mid,gitlab.com:url,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,gitlab.com:url];
 TO_DN_NONE(0.00)[]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 0AC035C825
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
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

The following changes since commit 5e61afe211e82a9af15a8794a0bd29bb574e953b:

  Merge tag 'ui-pull-request' of https://gitlab.com/marcandre.lureau/qemu into staging (2026-05-11 10:49:53 -0400)

are available in the Git repository at:

  https://gitlab.com/farosas/qemu.git tags/qtest-20260512-pull-request

for you to fetch changes up to 0129c626503c6d7220848a1f944a8f8e033ceaf9:

  tests/qtest/iommu-smmuv3-test: Skip if no TCG GICv3 device present (2026-05-12 18:11:30 -0300)

----------------------------------------------------------------
QTest pull request

- Fix iommu-smmuv3 test when TCG is disabled.
- Replacement of QTEST_TRACE env var with QTEST_QEMU_ARGS
- New verbosity switches for QTEST_LOG

----------------------------------------------------------------

Fabiano Rosas (3):
  tests/qtest/libqtest: Replace QTEST_TRACE with QTEST_QEMU_ARGS
  tests/qtest: Individual verbose switches
  docs/devel/qtest: Mention environment variables usage

Peter Maydell (1):
  tests/qtest/iommu-smmuv3-test: Skip if no TCG GICv3 device present

 docs/devel/testing/qtest.rst          | 44 ++++++++++++++++
 tests/qtest/fuzz/fuzz.c               |  7 +--
 tests/qtest/fuzz/generic_fuzz.c       |  2 +-
 tests/qtest/iommu-smmuv3-test.c       |  5 ++
 tests/qtest/libqmp.c                  |  7 +--
 tests/qtest/libqtest.c                | 75 +++++++++++++++++++++++----
 tests/qtest/libqtest.h                | 11 ++++
 tests/qtest/migration/framework.c     |  2 +-
 tests/qtest/migration/framework.h     |  5 +-
 tests/qtest/migration/precopy-tests.c |  2 +-
 tests/unit/meson.build                |  2 +-
 tests/unit/test-qga.c                 |  2 +-
 12 files changed, 140 insertions(+), 24 deletions(-)

-- 
2.51.0


