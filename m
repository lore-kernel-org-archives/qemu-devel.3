Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF7B7EDA6BE
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 17:34:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxTck-0001AZ-5T; Tue, 03 Mar 2026 12:33:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vxTch-0001A3-SE
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 12:33:32 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vxTcg-0005yK-Cj
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 12:33:31 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4A12B5BE14;
 Tue,  3 Mar 2026 17:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1772559206; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=8BKHicj8PboqzW9oOdPM1IiCkajVxFx21lEgY86iFBs=;
 b=o7vYZTUk5IGVbJXXqYm+9JfJkPmiW160H7XvWUUV14orCUoTHY6qgJWpLyJ1Ff7Gz/5L0x
 RbH4kqY+pIZu7aUGvWPaxd/cqumSJnBt7pWMUHuz/xvyNOAIcft1/xYtD8BAjC0TvTAPyh
 D9dFt+PrI6G/JVUK85T7ZPH2lvgXk10=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1772559206;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=8BKHicj8PboqzW9oOdPM1IiCkajVxFx21lEgY86iFBs=;
 b=ofS87gtqIagmKIM5rTFv6jqoeMWrTZa5aKtep2BdP5JNnykAik9O8OB4qHAa8AXl8Noc7d
 3EfAvgoEijwJXyDg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=EEM3qSF5;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=uPQfhsQW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1772559205; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=8BKHicj8PboqzW9oOdPM1IiCkajVxFx21lEgY86iFBs=;
 b=EEM3qSF50ZiECd/Ko34JaiTFWHgkIlJTTn+rTMDLRsbNYDJZYvyXIAvUmbfX4+oa9A26x0
 6B1y+mYmXz/IlhpZmBMt5ZUCJduobCrXOx62Y0XABLDIl5QnQa4hqD00p3QdbGZZ94mqkc
 hDIZVvIJDbC2EzUwjC7/ZwTTuwhZaQM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1772559205;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=8BKHicj8PboqzW9oOdPM1IiCkajVxFx21lEgY86iFBs=;
 b=uPQfhsQW+X76FtmyMhP23CfD3C2eBTAHGBMevpwuAsZTMMiF04EvV7MSNNXvr/HYSh0LYc
 VmuJBYHIBhkrYbDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 931313EA69;
 Tue,  3 Mar 2026 17:33:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yslUFWMbp2n+VAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 03 Mar 2026 17:33:23 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: adityag@linux.ibm.com, thuth@redhat.com, berrange@redhat.com,
 peterx@redhat.com
Subject: [PATCH v4 0/4] tests/functional: Fix ppc64 issue with make -j
Date: Tue,  3 Mar 2026 14:33:16 -0300
Message-ID: <20260303173320.10942-1-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,gitlab.com:url,suse.de:dkim,suse.de:mid];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 TO_DN_NONE(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 4A12B5BE14
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

As reported in [1], running the ppc64 functional tests in parallel is
currently broken due to one test importing another and causing
unittest.main to instantiate the imported test twice. Fix by removing
the dependency between tests.

1- https://lore.kernel.org/r/aXOGKb88Yho2jb_o@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com

CI run: https://gitlab.com/farosas/qemu/-/pipelines/2361425606

v3:
https://lore.kernel.org/r/20260303134348.8890-1-farosas@suse.de
v2:
https://lore.kernel.org/r/20260204172332.21367-1-farosas@suse.de
v1:
https://lore.kernel.org/r/20260128142829.25326-1-farosas@suse.de

Fabiano Rosas (4):
  tests/functional/migration: Use socket_dir
  tests/functional/migration: Add migrate_vms
  tests/functional/migration: Use the migrate_vms helper
  tests/functional/ppc64/pseries: Remove custom migration routine

 tests/functional/migration.py            | 46 ++++++++++++++----------
 tests/functional/ppc64/test_migration.py | 11 ------
 tests/functional/ppc64/test_pseries.py   | 10 +++---
 3 files changed, 33 insertions(+), 34 deletions(-)

-- 
2.51.0


