Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDC77C47258
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 11:57:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rV9C9-0008C2-K5; Wed, 31 Jan 2024 06:55:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rV9C7-0008Ai-4R; Wed, 31 Jan 2024 06:55:55 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rV9C4-0003t8-K7; Wed, 31 Jan 2024 06:55:54 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A7164490BE;
 Wed, 31 Jan 2024 14:56:46 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id D026870267;
 Wed, 31 Jan 2024 14:55:49 +0300 (MSK)
Received: (nullmailer pid 2263911 invoked by uid 1000);
 Wed, 31 Jan 2024 11:55:49 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-trivial@nongnu.org
Subject: [PULL 00/21] Trivial patches for 2024-01-31
Date: Wed, 31 Jan 2024 14:55:28 +0300
Message-Id: <20240131115549.2263854-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The following changes since commit 11be70677c70fdccd452a3233653949b79e97908:

  Merge tag 'pull-vfio-20240129' of https://github.com/legoater/qemu into staging (2024-01-29 10:53:56 +0000)

are available in the Git repository at:

  https://gitlab.com/mjt0k/qemu.git tags/pull-trivial-patches

for you to fetch changes up to 54f0058fa7821c391719e69a92804636b2c403ae:

  hw/hyperv: Include missing headers (2024-01-30 21:20:20 +0300)

----------------------------------------------------------------
trivial patches for 2024-01-31

----------------------------------------------------------------
Greg Kurz (3):
      hw/i386: Add `\n` to hint message
      hw/loongarch: Add `\n` to hint message
      hw/arm: Add `\n` to hint message

Han Han (1):
      qapi/migration.json: Fix the member name for MigrationCapability

Markus Armbruster (1):
      dump: Fix HMP dump-guest-memory -z without -R

Michael Tokarev (1):
      colo: examples: remove mentions of script= and (wrong) downscript=

Peter Maydell (10):
      scripts/clean-includes: Update exclude list
      hyperv: Clean up includes
      disas/riscv: Clean up includes
      aspeed: Clean up includes
      acpi: Clean up includes
      m68k: Clean up includes
      include: Clean up includes
      cxl: Clean up includes
      riscv: Clean up includes
      misc: Clean up includes

Philippe Mathieu-Daudé (4):
      mailmap: Fix Stefan Weil email
      backends/hostmem: Fix block comments style (checkpatch.pl warnings)
      hw/intc/xics: Include missing 'cpu.h' header
      hw/hyperv: Include missing headers

Yihuan Pan (1):
      qemu-docs: Update options for graphical frontends

 .mailmap                                  |  4 ++++
 audio/pwaudio.c                           |  1 -
 backends/hostmem.c                        | 12 ++++++++----
 disas/riscv-xthead.c                      |  1 +
 disas/riscv-xventana.c                    |  1 +
 disas/riscv.h                             |  1 -
 docs/colo-proxy.txt                       |  6 +++---
 docs/system/keys.rst.inc                  | 11 ++++++-----
 dump/dump-hmp-cmds.c                      |  2 +-
 hw/arm/aspeed_eeprom.c                    |  1 +
 hw/arm/aspeed_eeprom.h                    |  1 -
 hw/arm/virt-acpi-build.c                  |  2 +-
 hw/cxl/cxl-events.c                       |  4 +---
 hw/hyperv/hv-balloon-internal.h           |  1 -
 hw/hyperv/hv-balloon-our_range_memslots.c |  1 +
 hw/hyperv/hv-balloon-our_range_memslots.h |  1 -
 hw/hyperv/hv-balloon-page_range_tree.c    |  1 +
 hw/hyperv/hv-balloon-page_range_tree.h    |  1 -
 hw/hyperv/hv-balloon.c                    |  1 +
 hw/hyperv/hyperv.c                        |  4 ++++
 hw/i386/acpi-build.c                      |  4 ++--
 hw/intc/xics.c                            |  1 +
 hw/loongarch/acpi-build.c                 |  2 +-
 hw/nvram/fw_cfg-acpi.c                    |  1 +
 hw/virtio/virtio-acpi.c                   |  1 +
 include/hw/arm/raspberrypi-fw-defs.h      |  1 -
 include/hw/audio/asc.h                    |  1 -
 include/hw/m68k/q800-glue.h               |  1 -
 include/hw/mem/memory-device.h            |  1 -
 include/hw/nvram/fw_cfg_acpi.h            |  1 -
 include/hw/ppc/spapr_nested.h             |  1 -
 include/hw/virtio/virtio-acpi.h           |  1 -
 include/hw/xen/xen-hvm-common.h           |  1 -
 include/qemu/qtree.h                      |  1 -
 include/ui/rect.h                         |  2 --
 net/af-xdp.c                              |  1 -
 plugins/core.c                            |  1 -
 plugins/loader.c                          |  1 -
 qapi/migration.json                       |  2 +-
 qemu-options.hx                           |  8 ++++----
 scripts/clean-includes                    |  2 +-
 target/riscv/vector_internals.c           |  1 +
 target/riscv/vector_internals.h           |  1 -
 tests/qtest/qtest_aspeed.h                |  2 --
 util/userfaultfd.c                        |  1 -
 45 files changed, 47 insertions(+), 50 deletions(-)

