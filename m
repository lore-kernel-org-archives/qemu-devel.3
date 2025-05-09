Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D145C3ABCB
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 20:58:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDUm5-00077Q-Nh; Fri, 09 May 2025 16:56:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uDUm2-0006yN-TU; Fri, 09 May 2025 16:56:50 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uDUlz-00027c-TQ; Fri, 09 May 2025 16:56:49 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 724FD120672;
 Fri, 09 May 2025 23:56:34 +0300 (MSK)
Received: from localhost.localdomain (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id EA48D2081C6;
 Fri,  9 May 2025 23:56:36 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>,
	qemu-trivial@nongnu.org
Subject: [PULL v3 00/21] Trivial patches for 2025-05-07
Date: Fri,  9 May 2025 23:56:28 +0300
Message-Id: <20250509205629.674225-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The following changes since commit c5e2c4042e3c50b96cc5eaa9683325c5a96913b0:

  Merge tag 'pull-loongarch-20250506' of https://github.com/bibo-mao/qemu into staging (2025-05-06 11:03:45 -0400)

are available in the Git repository at:

  https://gitlab.com/mjt0k/qemu.git tags/pull-trivial-patches

for you to fetch changes up to 2f418cc9915284cb8eb7d607ec70fe13fe55ce5c:

  docs/devel/testing/functional: Fix typo (2025-05-09 23:50:19 +0300)

----------------------------------------------------------------
trivial patches for 2025-05-07

Mostly typos in comments by Gustavo Romero,
plus changing -hda in examples to -drive,

v2: update the last patch Author (it was "via qemu-trivial")
v3: drop problematic linux-user commit, and add one more
    trivial comment fix by Gustavo Romero.
    The remaining changes are all comment fixes and single doc
    fix, there's no code changes.
----------------------------------------------------------------
Gustavo Romero (12):
      hw/pci/pci.c: Turn DPRINTF into trace events
      hw/isa/ich9: Remove stray empty comment
      hw/i386/acpi-build: Fix typo and grammar in comment
      hw/i386/acpi-build: Update document reference
      hw/acpi/ich9: Remove ICH9_DEBUG macro
      hw/i386/acpi-build: Fix typo in function name
      hw/core/machine: Fix indentation
      qom/object: Fix typo in comment
      hw/net/e1000: Remove stray empty comment in header
      hw/pci-host/gpex-acpi: Fix typo in comment
      hw/acpi/pcihp: Fix typo in function name
      docs/devel/testing/functional: Fix typo

Integral (1):
      docs: replace `-hda` with `-drive` & update `root=` kernel parameter

Michael Tokarev (8):
      linux-user/mmap.c: fix "of of" typo in comment
      block.c: fix "the the" typo in comment
      hw/xen/xen-hvm-common.c: fix "the the" typo in comment
      include/exec/cpu-common.h: fix "the the" typo in comment
      include/hw/xen/interface/io/blkif.h: fix "the the" typo in comment
      qapi/qom.json: fix "the the" typo in comment
      hw/display/apple-gfx.m: fix "in in" typo in comment
      qapi/machine-target.json: fix "in in" typo in comment

 block.c                             |  2 +-
 docs/devel/testing/functional.rst   |  2 +-
 docs/system/gdb.rst                 |  2 +-
 docs/system/linuxboot.rst           |  6 +++---
 docs/system/target-mips.rst         |  2 +-
 hw/acpi/acpi-pci-hotplug-stub.c     |  2 +-
 hw/acpi/ich9.c                      | 13 +------------
 hw/acpi/pcihp.c                     |  2 +-
 hw/acpi/piix4.c                     |  2 +-
 hw/core/machine.c                   |  8 ++++----
 hw/display/apple-gfx.m              |  2 +-
 hw/i386/acpi-build.c                | 10 +++++-----
 hw/i386/acpi-build.h                |  2 +-
 hw/isa/lpc_ich9.c                   |  1 -
 hw/net/e1000x_regs.h                |  2 +-
 hw/pci-host/gpex-acpi.c             |  2 +-
 hw/pci/pci.c                        | 19 ++++++-------------
 hw/pci/trace-events                 |  4 ++++
 hw/xen/xen-hvm-common.c             |  2 +-
 include/exec/cpu-common.h           |  2 +-
 include/hw/acpi/pcihp.h             |  2 +-
 include/hw/xen/interface/io/blkif.h |  2 +-
 linux-user/mmap.c                   |  2 +-
 qapi/machine-target.json            |  2 +-
 qapi/qom.json                       |  2 +-
 qom/object.c                        |  2 +-
 26 files changed, 42 insertions(+), 57 deletions(-)

