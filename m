Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D9D9C48BEB
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 11:29:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd7E1-00088b-GW; Thu, 22 Feb 2024 06:26:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rd7DP-000838-9e; Thu, 22 Feb 2024 06:26:11 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rd7DM-0004oy-6e; Thu, 22 Feb 2024 06:26:11 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 68FB84FB42;
 Thu, 22 Feb 2024 14:26:25 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id DC38B8716E;
 Thu, 22 Feb 2024 14:26:01 +0300 (MSK)
Received: (nullmailer pid 2526139 invoked by uid 1000);
 Thu, 22 Feb 2024 11:26:01 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-trivial@nongnu.org
Subject: [PULL 00/34] Trivial patches for 2024-02-22
Date: Thu, 22 Feb 2024 14:25:27 +0300
Message-Id: <20240222112601.2526057-1-mjt@tls.msk.ru>
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

The following changes since commit 760b4dcdddba4a40b9fa0eb78fdfc7eda7cb83d0:

  Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2024-02-20 10:11:08 +0000)

are available in the Git repository at:

  https://gitlab.com/mjt0k/qemu.git tags/pull-trivial-patches

for you to fetch changes up to 185311130f54ead75c407cdf83004d575829b5d2:

  system/vl: Update description for input grab key (2024-02-22 08:59:16 +0300)

----------------------------------------------------------------
trivial patches for 2024-02-22

The bulk is a spelling fixes series from Manos Pitsidianakis.
Plus a few small things in other places.

----------------------------------------------------------------
Manos Pitsidianakis (20):
      system/physmem: remove redundant arg reassignment
      docs: correct typos
      tests: correct typos
      accel/tcg: correct typos
      loongson3: correct typos
      ppc: correct typos
      sh4: correct typos
      include/exec/memory.h: correct typos
      hw/arm/omap.h: correct typos
      hw/cxl/cxl_device.h: correct typos
      hw/net/npcm_gmac.h: correct typos
      hw/riscv/virt.h: correct typos
      pc-bios/README: correct typos
      qapi/ui: correct typos
      qemu-options.hx: correct typos
      ci/gitlab-pipeline-status: correct typos
      hexagon: correct typos
      m68k: correct typos
      s390x: correct typos
      target/sparc: correct typos

Philippe Mathieu-Daudé (11):
      hw/usb: Style cleanup
      hw/usb/uhci: Rename NB_PORTS -> UHCI_PORTS
      hw/usb/ehci: Rename NB_PORTS -> EHCI_PORTS
      hw/i386/kvm/ioapic: Replace magic '24' value by proper definition
      target/i386/monitor: Remove unused 'hw/i386/pc.h' header
      hw/timer: Move HPET_INTCAP definition to "hpet.h"
      hw/isa/lpc_ich9: Remove unused 'hw/i386/pc.h'
      hw/i386/acpi: Declare pc_madt_cpu_entry() in 'acpi-common.h'
      hw/i386/port92: Add missing 'hw/isa/isa.h' header
      hw/acpi/cpu_hotplug: Include 'pci_device.h' instead of 'pci.h'
      hw/acpi/cpu_hotplug: Include 'x86.h' instead of 'pc.h'

Thomas Huth (1):
      hw/hppa/Kconfig: Fix building with "configure --without-default-devices"

Tianlan Zhou (2):
      docs/system: Update description for input grab key
      system/vl: Update description for input grab key

 accel/tcg/ldst_atomicity.c.inc                |  2 +-
 docs/devel/ci-jobs.rst.inc                    |  2 +-
 docs/devel/docs.rst                           |  2 +-
 docs/devel/testing.rst                        |  2 +-
 docs/interop/prl-xml.txt                      |  2 +-
 docs/interop/vhost-user.rst                   |  2 +-
 docs/system/devices/canokey.rst               |  2 +-
 docs/system/keys.rst.inc                      |  2 +-
 hw/acpi/cpu_hotplug.c                         |  4 ++--
 hw/hppa/Kconfig                               |  2 ++
 hw/i386/acpi-common.c                         |  1 -
 hw/i386/acpi-common.h                         |  3 +++
 hw/i386/kvm/ioapic.c                          |  2 +-
 hw/i386/port92.c                              |  1 +
 hw/isa/lpc_ich9.c                             |  1 -
 hw/mips/loongson3_bootp.h                     |  4 ++--
 hw/sh4/sh7750_regs.h                          |  2 +-
 hw/timer/hpet.c                               |  1 -
 hw/usb/hcd-ehci-pci.c                         |  2 +-
 hw/usb/hcd-ehci-sysbus.c                      |  2 +-
 hw/usb/hcd-ehci.c                             | 21 +++++++++++----------
 hw/usb/hcd-ehci.h                             |  8 ++++----
 hw/usb/hcd-uhci.c                             | 24 +++++++++++++-----------
 hw/usb/hcd-uhci.h                             |  4 ++--
 include/exec/memory.h                         |  2 +-
 include/hw/arm/omap.h                         |  3 ++-
 include/hw/cxl/cxl_device.h                   |  4 ++--
 include/hw/i386/pc.h                          |  6 ------
 include/hw/net/npcm_gmac.h                    |  4 ++--
 include/hw/riscv/virt.h                       |  4 ++--
 include/hw/timer/hpet.h                       |  2 ++
 pc-bios/README                                |  2 +-
 qapi/ui.json                                  |  4 ++--
 qemu-options.hx                               |  4 ++--
 scripts/ci/gitlab-pipeline-status             |  2 +-
 system/physmem.c                              |  7 ++-----
 system/vl.c                                   |  2 +-
 target/hexagon/idef-parser/macros.inc         |  2 +-
 target/i386/monitor.c                         |  1 -
 target/m68k/cpu.h                             |  7 ++++---
 target/ppc/translate/vmx-impl.c.inc           |  2 +-
 target/s390x/cpu_features_def.h.inc           |  2 +-
 target/sparc/asi.h                            |  8 ++++----
 tests/avocado/acpi-bits/bits-tests/smbios.py2 |  2 +-
 tests/avocado/mem-addr-space-check.py         |  6 +++---
 tests/avocado/reverse_debugging.py            |  2 +-
 46 files changed, 88 insertions(+), 88 deletions(-)

