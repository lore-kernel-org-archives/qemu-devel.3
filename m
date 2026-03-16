Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A27C2F4644A
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 10:53:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w25Z6-00030A-Vp; Mon, 16 Mar 2026 06:52:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w25Z5-0002zp-L3; Mon, 16 Mar 2026 06:52:51 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w25Z2-0006NW-Ry; Mon, 16 Mar 2026 06:52:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1773658361; bh=03xVM0hbVtqeiosEJ5qJ8pm4oxqCd4yCopbs96MwAt4=;
 h=From:To:Cc:Subject:Date;
 b=q1UxAibjx0KauMgC6mLcRIQodSOi1FvUrOnmYXNWwCKYHPXvhSEqSp/QMf1r8NvP+
 TBsuUMrT3Zj+TGTlv7DRm1mY7QLXlaPrUpdaC2TGSfekapAt20laATCWmXtMAXsrJy
 b7RmDUC0Sk9AAfAe8w4TDDsVGB0cscxxBM3UlgBzSHGlk+g29g5izzS0tpZS9KqeP6
 2oHqnDNfhKj50kUBm3GGx1UMZ0ro6EQcDwXi70pdjxX87n97R3JDpgTBtT5x15jAFz
 BZcG7ZfBS6xYWkwMnj1rsXFp2gMvx8Napj5gxhwWLrsCpH9XgwcbCvTN/hEXfG5+iz
 JmPM3F6w2cjHg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A848F193DC1;
 Mon, 16 Mar 2026 13:52:41 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id E996A380682;
 Mon, 16 Mar 2026 13:52:44 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>,
	qemu-trivial@nongnu.org
Subject: [PULL v2 00/13] Trivial patches for 2026-03-16
Date: Mon, 16 Mar 2026 13:52:38 +0300
Message-ID: <20260316105244.107822-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The following changes since commit fff352b9b6080e580aa1fadd29b4eccf4cb2922a:

  Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2026-03-12 15:21:06 +0000)

are available in the Git repository at:

  https://gitlab.com/mjt0k/qemu.git tags/pull-trivial-patches

for you to fetch changes up to 7cc61f922f4b5db006e8f03d61208a3d652ed2df:

  rename CONFIG_EPOLL_CREATE1 to CONFIG_EPOLL, and stop checking for epoll in meson.build (2026-03-16 13:50:18 +0300)

----------------------------------------------------------------
trivial patches for 2026-03-16

a few patches accumulated in trivial-patches tree to date.
A larger part of it is my linux-user cleanup series.

v2: drop the slirp socket change (net/slirp: allow hostfwd socket
paths with dashes).  Not resending anything, just the cover letter,
since the patchset is the same except of this single patch.

----------------------------------------------------------------
Michael Tokarev (7):
      linux-user/syscall.c: assume splice is always present
      meson.build: stop checking for splice()
      linux-user: assume inotify sycalls are always present
      meson.build: stop checking for inotify_init()
      linux-user: assume epoll is always present
      meson.build: do not check for epoll.h (CONFIG_EPOLL)
      rename CONFIG_EPOLL_CREATE1 to CONFIG_EPOLL, and stop checking for epoll in meson.build

Sergei Heifetz (5):
      migration/savevm.c: reorder usage and assertion of mis->from_src_file
      dump/dump.c: reorder usage and assertion of block
      system/physmem.c: remove useless assertion of block
      hw/usb/core.c: reorder usage and assertion of p->ep
      target/i386: fix NULL pointer dereference in legacy-cache=off handling

Thomas Huth (1):
      docs: Move xbzrle.txt into the migration folder and convert to rst

 docs/devel/migration/features.rst               |   1 +
 docs/{xbzrle.txt => devel/migration/xbzrle.rst} | 106 ++++++++++++++----------
 dump/dump.c                                     |   2 +-
 hw/usb/core.c                                   |   2 +-
 linux-user/fd-trans.c                           |   5 --
 linux-user/fd-trans.h                           |   4 -
 linux-user/syscall.c                            |  44 ++--------
 linux-user/syscall_defs.h                       |   3 -
 meson.build                                     |  19 +----
 migration/savevm.c                              |   3 +-
 system/physmem.c                                |   2 -
 target/i386/cpu.c                               |   7 +-
 util/aio-posix.h                                |   4 +-
 util/meson.build                                |   2 +-
 14 files changed, 86 insertions(+), 118 deletions(-)
 rename docs/{xbzrle.txt => devel/migration/xbzrle.rst} (74%)

