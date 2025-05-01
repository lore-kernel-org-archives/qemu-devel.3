Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D33CC3ABA3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 09:26:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAQAe-0006AR-Kg; Thu, 01 May 2025 05:25:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uAQAZ-00068x-Gp; Thu, 01 May 2025 05:25:27 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uAQAW-00054V-JO; Thu, 01 May 2025 05:25:27 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:8a1d:0:640:a167:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 28F0560919;
 Thu,  1 May 2025 12:25:16 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:b533::1:21])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id EPTMlH1FX0U0-0dOaqYvA; Thu, 01 May 2025 12:25:15 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1746091515;
 bh=s+3buzIgr5Bb5YcsxydQAH9d5RKXTCIS+p+gi84+HbM=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=VlPW7q4wZov44DyPECo7AwskbDo/ItaWlLHshJBFwbiTVb9xSVKpjAsCF/3zGnB6X
 R7hYLf9tkFvGSx7W9nxutyRyu7a1NIe6SEd5LFwR8nHYqCEKroNU92+C1sdBn2tlIt
 rKXHnazsGFyO1BBzeq3OBHId++2m7yG4OP8VOhvA=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org,
	vsementsov@yandex-team.ru,
	stefanha@gmail.com
Subject: [PULL v2 0/8] block-job patches 2025-04-29
Date: Thu,  1 May 2025 12:25:10 +0300
Message-ID: <20250501092511.24068-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

  https://gitlab.com/vsementsov/qemu.git tags/pull-block-jobs-2025-04-29-v2

for you to fetch changes up to 35655b2d1b1015e3a6fa99ef9c2afc1826a765ba:

  blockdev-backup: Add error handling option for copy-before-write jobs (2025-05-01 12:12:19 +0300)

----------------------------------------------------------------
block-job patches

- deprecate some old block-job- APIs
- on-cbw-error option for backup
- more efficient zero handling in block commit

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
 tests/qemu-iotests/tests/copy-before-write      |  90 ++++++++++++++++++
 tests/qemu-iotests/tests/copy-before-write.out  |   4 +-
 14 files changed, 471 insertions(+), 65 deletions(-)
 create mode 100755 tests/qemu-iotests/tests/commit-zero-blocks
 create mode 100644 tests/qemu-iotests/tests/commit-zero-blocks.out

-- 
2.48.1


