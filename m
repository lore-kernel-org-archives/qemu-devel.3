Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BEEB103E2E6
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 21:35:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0RCP-0005Mr-9l; Wed, 11 Mar 2026 17:34:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w0RCH-0005Lo-Kr
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 17:34:30 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w0RCC-00034P-OJ
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 17:34:26 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AEE185BD30;
 Wed, 11 Mar 2026 21:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773264862; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=wkt4vLDDlWeSPeqcQoUkx4lx9wcHrIbFyBvj8ydtUtc=;
 b=OD4+54dg+GRIpKfu6gLcZkuLkI0nAe7YVRc47KK8q6ATRqmVjIMnuXk0irpp+9vtdLGSXw
 /q1tVEp8AhjV6yT4J5xcwvsVDOyXla/+Pq2xWW251JB7koXXsra6ABXVqmbz4MMQ8chJ5N
 xEFvd/t9C9f6vPFfco4trz7ORc3QR/0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773264862;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=wkt4vLDDlWeSPeqcQoUkx4lx9wcHrIbFyBvj8ydtUtc=;
 b=SMhqRtBKeG3aMqL4U/SglnNWNBeEXm6DVNb7ZBCXImmkSAO7AggewhVb2SAtV7qwlV6Ecx
 a4sWcpypq05eZRAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773264862; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=wkt4vLDDlWeSPeqcQoUkx4lx9wcHrIbFyBvj8ydtUtc=;
 b=OD4+54dg+GRIpKfu6gLcZkuLkI0nAe7YVRc47KK8q6ATRqmVjIMnuXk0irpp+9vtdLGSXw
 /q1tVEp8AhjV6yT4J5xcwvsVDOyXla/+Pq2xWW251JB7koXXsra6ABXVqmbz4MMQ8chJ5N
 xEFvd/t9C9f6vPFfco4trz7ORc3QR/0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773264862;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=wkt4vLDDlWeSPeqcQoUkx4lx9wcHrIbFyBvj8ydtUtc=;
 b=SMhqRtBKeG3aMqL4U/SglnNWNBeEXm6DVNb7ZBCXImmkSAO7AggewhVb2SAtV7qwlV6Ecx
 a4sWcpypq05eZRAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 383303FC1B;
 Wed, 11 Mar 2026 21:34:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id XyYIO9zfsWngUgAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 11 Mar 2026 21:34:20 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Prasad Pandit <ppandit@redhat.com>
Subject: [PATCH v2 0/5] migration-test: Plumbing
Date: Wed, 11 Mar 2026 18:34:13 -0300
Message-ID: <20260311213418.16951-1-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.983]; MIME_GOOD(-0.10)[text/plain];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
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

Fix leaks. A couple of normal ones and a few that happen due to a test
expecting failure in the destination side, but 'exit-on-error' is set
so the coroutine just exits the entire process while a few resources
are still allocated, but outside of the scope of the migration code.

For v2 I set exit-on-error unconditionally in migration-test. The QEMU
process should never return 1 anymore.

I also removed the cleanup patches because they are no longer strictly
necessary, I'll add them for the next release cyle to keep the changes
during the freeze restricted to what is necessary to fix the bugs.

CI run: https://gitlab.com/farosas/qemu/-/pipelines/2379240537
--enable-asan --enable-ubsan build is clean for x86_64 migration-test --full

v1:
cover: https://lore.kernel.org/r/20260310142134.15137-1-farosas@suse.de
series: https://lore.kernel.org/r/20260310135540.8679-1-farosas@suse.de

Fabiano Rosas (5):
  tests/qtest/migration: Fix leak of migration tests data
  io: Fix TLS bye task leak
  tests/qtest/migration: Fix leak in CPR exec test
  migration/multifd: Fix leaks of TLS error objects
  tests/qtest/migration: Force exit-on-error=false

 io/channel-tls.c                       |  4 +++-
 migration/migration.c                  |  5 +++++
 migration/multifd.c                    | 27 ++++++++++++--------------
 tests/qtest/dbus-vmstate-test.c        |  5 +++--
 tests/qtest/migration/cpr-tests.c      |  5 +++--
 tests/qtest/migration/framework.c      |  7 +++----
 tests/qtest/migration/framework.h      |  2 --
 tests/qtest/migration/migration-qmp.c  |  6 ++++++
 tests/qtest/migration/migration-util.c | 19 +++++++++++++-----
 tests/qtest/migration/migration-util.h |  2 +-
 tests/qtest/migration/misc-tests.c     |  4 ++--
 tests/qtest/migration/precopy-tests.c  | 12 +++++-------
 tests/qtest/migration/tls-tests.c      | 14 +++++++------
 13 files changed, 65 insertions(+), 47 deletions(-)

-- 
2.51.0


