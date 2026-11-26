Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B301606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 21:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=Ub2vhvO9;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=vSBCYf/j;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=ZJ3wI4nj;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=el0675iz
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWhJH-0000hP-TG; Thu, 26 Nov 2026 16:47:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xWhJA-0000h0-Ma
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 16:47:13 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xWhJ8-0008TF-O4
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 16:47:12 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C33371FE0D;
 Thu, 26 Nov 2026 21:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795729629; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=V5JiRZ+1WNvzd/QE7+6ylKXABD0lu/UC8rV7FfqsIgA=;
 b=Ub2vhvO9rJkT7oJVK3KyJ5sSchSVborHoieMzP8EcRu9+uwxvTAOp0EM9NYAqR1Ii3s9YY
 DS3ART9ryeDDQsqloMUJpMIAhTU7iTJAFZ4+0R26bkv97JZwZhoa9fVwk0pZ5PcJYG0dPq
 bUV2SyNZO6Tasu4DpJRCk5vpDraXBKI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795729629;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=V5JiRZ+1WNvzd/QE7+6ylKXABD0lu/UC8rV7FfqsIgA=;
 b=vSBCYf/jLthPuSuqgtjR3QNAZbOKJ+51jqvvk8YmpZAQj/rcl8+3O8I/zwXrvw6Pciq116
 rBg6fjiE6HgG9oBg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ZJ3wI4nj;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=el0675iz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795729628; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=V5JiRZ+1WNvzd/QE7+6ylKXABD0lu/UC8rV7FfqsIgA=;
 b=ZJ3wI4njGg8uKue0IMUNpOuxz+gyKvIo9WIQvnv9AGdjVDs0Z2wxp0n7J6USmW5WwCObE/
 wDJMf2qvDoN4qWe15XmQDZg2LxCN5q0Jc+MJ+vzOlLv5eh5QLXDXWDx7Tu70/KNevFct1l
 ccy+6Ioe7mFNXu/s8AbCD3448T4oKxA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795729628;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=V5JiRZ+1WNvzd/QE7+6ylKXABD0lu/UC8rV7FfqsIgA=;
 b=el0675iz4jeOvjE1oxctHHASEUNDCWVXWsKUn4hg/T9QL19UftwhRefIu5Ag5NK5y5C/bS
 rVRVCCLq3uVQMbBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9E4BD134C3;
 Thu, 26 Nov 2026 21:47:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 3qzICtuoCGtRZgAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 26 Nov 2026 21:47:07 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
Subject: [PATCH 0/5] migration-test: Support running a real kernel
Date: Thu, 26 Nov 2026 18:46:59 -0300
Message-ID: <20261126214704.3108327-1-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-12.01 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -12.01
X-Rspamd-Queue-Id: C33371FE0D
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
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

There's a class of migration performance bugs that are very specific
to the internals of QEMU and most likely require work on our side, but
are currently invisible to our testing because migration-test runs a
simple guest workload (not even that, really). The more important ones
are BQL contention issues that result in vcpu starvation.

My plan is to incrementally add some pieces to migration-test to
reduce that testing gap.

The first piece is adding support for running a kernel + initrd inside
the guest which gives us an easy way to start exercising migration of
a more loaded guest that can already cause VM exits.

This series adds support for -kernel and -initrd arguments to
migration-test and runs the same set of tests we currently have, but
with the kernel instead of the custom loop. By default it uses the
initrd from tests/migration-stress/ which runs a read-write loop over
all memory and has customizable vcpu and memory size.

I don't intend for this to run in CI nor for it to run by default. The
developer needs to pass the options explicitly and bring at least
their own kernel.

My plan is to do pretty much what we did with the cross-migration
work, keep it around, unubtrosive and stable so we can do
experimentation and debugging when the need arises in an environment
that is closer to where the bugs actually lie.

I've been using this sporadically for downstream work and so far
tested guests with a couple of TiB of ram and ~256 vcpus. With and
without hugepages (more on this below).

- patches 1 and 2 bring the stress.c up-to-date with current coding
style and fix a bug. (note that guestperf is currently broken, I don't
have bandwidth for it).

- patch 3 consolidates some code into bootfile.c so we keep framework.c
under control.

- patch 4 adds parsing of dmesg and detection of panics and such.

- patch 5 adds the support for kernel/initrd/append.

Minimal invocation is:

QTEST_MIG_KERNEL=/boot/vmlinuz-...
QTEST_QEMU_BINARY=./qemu-system-x86_64 ./tests/qtest/migration-test

extra env vars:
  QTEST_MIG_APPEND="" allows changing kernel command-line options.
  QTEST_MIG_GUEST_STDOUT=1 redirects the guest output

CI run: https://gitlab.com/farosas/qemu/-/pipelines/3120905449

====================================================================
Heads up for upcoming work, suggestions welcomed:

- Hugepages support: so we can send the host into the costly dirty
  logging split/restore paths while the guest is loaded. This is already
  done, I just need to fish it out from a larger branch.

- Worker thread: to execute in parallel with the migration so we can
  poke at QEMU directly instead of hoping for the right timing in the
  kernel. The worker thread infra is done, but no useful work to put in
  it so far. I wrote a work function that spams the serial console via
  qtest, but I haven't had success triggering any issues with it.

  (I also played a bit with adding the pci-testdev to the guest, but
  that code seems to have kvm-unit-test assumptions that I haven't
  figured out yet)

Fabiano Rosas (5):
  tests/migration-stress: Fix stress.c loop
  tests/migration-stress: Cleanups to stress.c
  tests/qtest/migration: Move guest workload code into bootfile.c
  tests/qtest/migration: Adapt wait_for_serial routine for stress.c
  tests/qtest/migration: Make it possible to run stress.c

 tests/migration-stress/stress.c        | 140 +++++-----
 tests/qtest/migration/bootfile.c       | 353 ++++++++++++++++++++++++-
 tests/qtest/migration/bootfile.h       |  23 +-
 tests/qtest/migration/cpr-tests.c      |  52 +++-
 tests/qtest/migration/framework.c      | 269 ++++++-------------
 tests/qtest/migration/framework.h      |   4 +-
 tests/qtest/migration/misc-tests.c     |   1 +
 tests/qtest/migration/postcopy-tests.c |   6 +-
 tests/qtest/migration/precopy-tests.c  |  19 +-
 9 files changed, 606 insertions(+), 261 deletions(-)

-- 
2.53.0


