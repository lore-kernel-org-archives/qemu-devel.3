Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB0FDC41513
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 11:53:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1PYa-0008Gj-SK; Mon, 29 Apr 2024 07:52:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1s1PYV-0008D8-K7; Mon, 29 Apr 2024 07:52:25 -0400
Received: from forwardcorp1c.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1s1PYQ-0001nr-89; Mon, 29 Apr 2024 07:52:22 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:2a2a:0:640:d546:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTPS id 1B14160AB4;
 Mon, 29 Apr 2024 14:52:11 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:b739::1:30])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 0qOEuD11MuQ0-bgx8Sp8A; Mon, 29 Apr 2024 14:52:10 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1714391530;
 bh=6TYnRPf9ZNeil/HpkGLDU/uDkd+ujp7pA5YQ5tZtyZs=;
 h=Message-Id:Date:Cc:Subject:To:From;
 b=D6jHNeO/0hBFnOeFM2FjJjVba+0jwiaTHOeOoZuJnOM3l25I42rOaPG+CtK79HDNG
 BY7BTo7+9O+6bPxd7hJztr5NnQXQofn2V0YuFKZHWPAfTL2NMygpOLNNtHW/xJWruY
 bUGlbLPoZPOoYKXnm0G4UIWGEy1ju6mg4OSm+Y+Y=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
	vsementsov@yandex-team.ru
Subject: [PULL 0/6] Block jobs patches for 2024-04-29
Date: Mon, 29 Apr 2024 14:51:51 +0300
Message-Id: <20240429115157.2260885-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

The following changes since commit fd87be1dada5672f877e03c2ca8504458292c479:

  Merge tag 'accel-20240426' of https://github.com/philmd/qemu into staging (2024-04-26 15:28:13 -0700)

are available in the Git repository at:

  https://gitlab.com/vsementsov/qemu.git tags/pull-block-jobs-2024-04-29

for you to fetch changes up to 2ca7608c6b8d57fd6347b11af12a0f035263efef:

  iotests: add backup-discard-source (2024-04-29 13:35:30 +0300)

----------------------------------------------------------------
Block jobs patches for 2024-04-29

- backup: discard-source parameter
- blockcommit: Reopen base image as RO after abort

----------------------------------------------------------------
Alexander Ivanov (1):
      blockcommit: Reopen base image as RO after abort

Vladimir Sementsov-Ogievskiy (5):
      block/copy-before-write: fix permission
      block/copy-before-write: support unligned snapshot-discard
      block/copy-before-write: create block_copy bitmap in filter node
      qapi: blockdev-backup: add discard-source parameter
      iotests: add backup-discard-source

 block/backup.c                                     |   5 +-
 block/block-copy.c                                 |  12 +-
 block/copy-before-write.c                          |  39 +++++--
 block/copy-before-write.h                          |   1 +
 block/mirror.c                                     |  11 +-
 block/replication.c                                |   4 +-
 blockdev.c                                         |   2 +-
 include/block/block-common.h                       |   2 +
 include/block/block-copy.h                         |   2 +
 include/block/block_int-global-state.h             |   2 +-
 qapi/block-core.json                               |   4 +
 tests/qemu-iotests/257.out                         | 112 +++++++++---------
 tests/qemu-iotests/tests/backup-discard-source     | 152 +++++++++++++++++++++++++
 tests/qemu-iotests/tests/backup-discard-source.out |   5 +
 14 files changed, 281 insertions(+), 72 deletions(-)
 create mode 100755 tests/qemu-iotests/tests/backup-discard-source
 create mode 100644 tests/qemu-iotests/tests/backup-discard-source.out

Alexander Ivanov (1):
  blockcommit: Reopen base image as RO after abort

Vladimir Sementsov-Ogievskiy (5):
  block/copy-before-write: fix permission
  block/copy-before-write: support unligned snapshot-discard
  block/copy-before-write: create block_copy bitmap in filter node
  qapi: blockdev-backup: add discard-source parameter
  iotests: add backup-discard-source

 block/backup.c                                |   5 +-
 block/block-copy.c                            |  12 +-
 block/copy-before-write.c                     |  39 ++++-
 block/copy-before-write.h                     |   1 +
 block/mirror.c                                |  11 +-
 block/replication.c                           |   4 +-
 blockdev.c                                    |   2 +-
 include/block/block-common.h                  |   2 +
 include/block/block-copy.h                    |   2 +
 include/block/block_int-global-state.h        |   2 +-
 qapi/block-core.json                          |   4 +
 tests/qemu-iotests/257.out                    | 112 ++++++-------
 .../qemu-iotests/tests/backup-discard-source  | 152 ++++++++++++++++++
 .../tests/backup-discard-source.out           |   5 +
 14 files changed, 281 insertions(+), 72 deletions(-)
 create mode 100755 tests/qemu-iotests/tests/backup-discard-source
 create mode 100644 tests/qemu-iotests/tests/backup-discard-source.out

-- 
2.34.1


