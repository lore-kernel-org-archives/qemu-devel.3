Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D51BAC3ABCB
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 15:30:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEV6Z-0000vP-GU; Mon, 12 May 2025 11:30:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uEV6H-0000fG-Av; Mon, 12 May 2025 11:29:54 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uEV6D-00066A-Rk; Mon, 12 May 2025 11:29:53 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c23:38c4:0:640:3b6a:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id A491060C32;
 Mon, 12 May 2025 18:29:42 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:b504::1:8])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id fTHAn00FVCg0-bIgrf3hK; Mon, 12 May 2025 18:29:42 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1747063782;
 bh=e+WkNTNyLYGhG6Q1vV2wcSpW+C2a2bL8N+2VKIWCd3Q=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=mp8X67MI9liSKc04OuBOtdh5Hofhr1HfugpgLzFMmNz+R8TjV9/wGPoItJzrrCQuO
 V+uZ7IwlsiFNkE8HKsRor+E5kNn/1Kir0F/SUbbaojpCCMSN+T5foHuTYioO6O/qUH
 0qIGPUgKko9z/kSY3UOkzgcjO89XWehwA7dHUm9A=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org,
	vsementsov@yandex-team.ru,
	stefanha@gmail.com
Subject: [PULL v3 0/8] block-job patches 2025-04-29
Date: Mon, 12 May 2025 18:29:39 +0300
Message-ID: <20250512152940.1294079-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
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

The following changes since commit 73d29ea2417b58ca55fba1aa468ba38e3607b583:

  Merge tag 'for-upstream' of https://repo.or.cz/qemu/kevin into staging (2025-04-27 12:47:23 -0400)

are available in the Git repository at:

  https://gitlab.com/vsementsov/qemu.git tags/pull-block-jobs-2025-04-29-v3

for you to fetch changes up to 3d3911f16b6ceb9ed202aadf2cd75ded516a1a0b:

  blockdev-backup: Add error handling option for copy-before-write jobs (2025-05-12 18:19:31 +0300)

----------------------------------------------------------------
block-job patches

- deprecate some old block-job- APIs
- on-cbw-error option for backup
- more efficient zero handling in block commit

v3:
[08]: fix long lines

v2:
[03]: move variable declaration to function top, to silence clang and to
      follow QEMU coding style

----------------------------------------------------------------
Raman Dzehtsiar (1):
      blockdev-backup: Add error handling option for copy-before-write jobs

Vincent Vanlaer (5):
      block: get type of block allocation in commit_run
      block: move commit_run loop to separate function
      block: refactor error handling of commit_iteration
      block: allow commit to unmap zero blocks
      block: add test non-active commit with zeroed data

Vladimir Sementsov-Ogievskiy (2):
      qapi: synchronize jobs and block-jobs documentation
      qapi/block-core: deprecate some block-job- APIs

 block/backup.c                                  |   3 +-
 block/commit.c                                  | 118 +++++++++++++++++-------
 block/copy-before-write.c                       |   2 +
 block/copy-before-write.h                       |   1 +
 block/replication.c                             |   4 +-
 blockdev.c                                      |   6 ++
 docs/about/deprecated.rst                       |  31 +++++++
 include/block/block_int-global-state.h          |   2 +
 qapi/block-core.json                            |  95 ++++++++++++++-----
 qapi/job.json                                   |  30 +++++-
 tests/qemu-iotests/tests/commit-zero-blocks     |  96 +++++++++++++++++++
 tests/qemu-iotests/tests/commit-zero-blocks.out |  54 +++++++++++
 tests/qemu-iotests/tests/copy-before-write      |  95 +++++++++++++++++++
 tests/qemu-iotests/tests/copy-before-write.out  |   4 +-
 14 files changed, 476 insertions(+), 65 deletions(-)
 create mode 100755 tests/qemu-iotests/tests/commit-zero-blocks
 create mode 100644 tests/qemu-iotests/tests/commit-zero-blocks.out

-- 
2.48.1


