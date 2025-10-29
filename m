Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0224ACCF9EE
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 09:04:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE24M-00044V-Gs; Wed, 29 Oct 2025 05:02:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vE24F-00040I-HL; Wed, 29 Oct 2025 05:02:07 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vE241-00031X-N5; Wed, 29 Oct 2025 05:02:03 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 874DD163E5D;
 Wed, 29 Oct 2025 12:01:42 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id AFC2F3084A4;
 Wed, 29 Oct 2025 12:01:48 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>,
	qemu-trivial@nongnu.org
Subject: [PULL 0/7] Trivial patches for 2025-10-29
Date: Wed, 29 Oct 2025 12:01:38 +0300
Message-ID: <20251029090148.648212-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

The following changes since commit bc831f37398b51dfe65d99a67bcff9352f84a9d2:

  Merge tag 'hw-misc-20251028' of https://github.com/philmd/qemu into staging (2025-10-28 11:48:05 +0100)

are available in the Git repository at:

  https://gitlab.com/mjt0k/qemu.git tags/pull-trivial-patches

for you to fetch changes up to 7c7089321670fb51022a1c4493cbcc69aa288a0f:

  linux-user: Use correct type for FIBMAP and FIGETBSZ emulation (2025-10-29 11:58:55 +0300)

----------------------------------------------------------------
trivial patches for 2025-10-29

----------------------------------------------------------------
Bastian Blank (1):
      linux-user: Use correct type for FIBMAP and FIGETBSZ emulation

Nir Lichtman (1):
      docs/system/keys: fix incorrect reset scaling key binding

Peter Maydell (1):
      docs/system/sriov.rst: Fix typo in title

Thomas Huth (2):
      tests/functional/i386: Remove unused variable from the replay test
      hw/xen: Avoid non-inclusive language in params.h

Vladimir Sementsov-Ogievskiy (2):
      chardev: remove deprecated 'reconnect' option
      net/stream: remove deprecated 'reconnect' option

 chardev/char-socket.c                 | 24 +++++-------------------
 chardev/char.c                        |  3 ---
 docs/about/deprecated.rst             | 15 ---------------
 docs/about/removed-features.rst       | 22 ++++++++++++++++++++++
 docs/system/keys.rst.inc              |  2 +-
 docs/system/sriov.rst                 |  4 ++--
 include/hw/xen/interface/hvm/params.h |  9 ++-------
 linux-user/ioctls.h                   |  4 ++--
 net/stream.c                          | 20 +++++---------------
 qapi/char.json                        | 14 +-------------
 qapi/net.json                         | 13 +------------
 tests/functional/i386/test_replay.py  |  1 -
 12 files changed, 41 insertions(+), 90 deletions(-)

