Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F096C0218A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 13:35:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdUh5-0002as-Cj; Thu, 30 Jan 2025 08:34:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tdUh2-0002aG-37; Thu, 30 Jan 2025 08:34:52 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tdUh0-0002WL-7G; Thu, 30 Jan 2025 08:34:51 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id DCAFBE303E;
 Thu, 30 Jan 2025 16:34:18 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id CBBBE1A7F85;
 Thu, 30 Jan 2025 16:34:47 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id C377552400; Thu, 30 Jan 2025 16:34:47 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>,
	qemu-trivial@nongnu.org
Subject: [PULL 0/7] Trivial patches for 2025-01-30
Date: Thu, 30 Jan 2025 16:34:40 +0300
Message-Id: <20250130133447.873566-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit 871af84dd599fab68c8ed414d9ecbdb2bcfc5801:

  Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2025-01-29 09:51:03 -0500)

are available in the Git repository at:

  https://gitlab.com/mjt0k/qemu.git tags/pull-trivial-patches

for you to fetch changes up to 6a784f12000582b9f0f40fadc967ad474fc27c7b:

  hw/i386/pc: Remove unused pc_compat_2_3 declarations (2025-01-30 13:01:22 +0300)

----------------------------------------------------------------
trivial patches for 2025-01-30

Just a few of them.  Including some bugfixes.

----------------------------------------------------------------
Dominik 'Disconnect3d' Czarnota (1):
      gdbstub/user-target: fix gdbserver int format (%d -> %x)

Laurent Vivier (2):
      net: Fix announce_self
      net/dump: Correctly compute Ethernet packet offset

Michael Tokarev (1):
      vvfat: create_long_filename: fix out-of-bounds array access

Philippe Mathieu-Daudé (2):
      licenses: Remove SPDX tags not being license identifier for Linaro
      hw/i386/pc: Remove unused pc_compat_2_3 declarations

Thomas Huth (1):
      tests/functional/test_mips_malta: Fix comment about endianness of the test

 accel/tcg/vcpu-state.h                           |  9 +++++++--
 block/vvfat.c                                    | 11 +++++------
 gdbstub/user-target.c                            | 10 +++++-----
 hw/misc/ivshmem-flat.c                           |  5 +++--
 include/hw/i386/pc.h                             |  3 ---
 include/hw/misc/ivshmem-flat.h                   |  5 +++--
 net/dump.c                                       |  3 ++-
 net/net.c                                        |  1 +
 scripts/qom-cast-macro-clean-cocci-gen.py        |  7 +++++--
 target/m68k/semihosting-stub.c                   |  7 +++++--
 target/mips/tcg/system/semihosting-stub.c        |  5 +++--
 tests/functional/test_aarch64_sbsaref.py         |  8 +++++---
 tests/functional/test_aarch64_sbsaref_alpine.py  |  8 +++++---
 tests/functional/test_aarch64_sbsaref_freebsd.py |  8 +++++---
 tests/functional/test_mips_malta.py              |  2 +-
 tests/qtest/libqos/virtio-scmi.c                 |  2 +-
 16 files changed, 56 insertions(+), 38 deletions(-)

