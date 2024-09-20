Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF2EBCF58E5
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2024 07:42:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srYGt-0006BK-71; Fri, 20 Sep 2024 03:41:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1srYGr-00067F-2F; Fri, 20 Sep 2024 03:41:41 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1srYGo-0000Av-Jw; Fri, 20 Sep 2024 03:41:40 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 3DC6190856;
 Fri, 20 Sep 2024 10:41:15 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id E9D021409D9;
 Fri, 20 Sep 2024 10:41:34 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>,
	qemu-trivial@nongnu.org
Subject: [PULL 00/22] Trivial patches for 2024-09-20
Date: Fri, 20 Sep 2024 10:41:12 +0300
Message-Id: <20240920074134.664961-1-mjt@tls.msk.ru>
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

The following changes since commit 01dc65a3bc262ab1bec8fe89775e9bbfa627becb:

  Merge tag 'pull-target-arm-20240919' of https://git.linaro.org/people/pmaydell/qemu-arm into staging (2024-09-19 14:15:15 +0100)

are available in the Git repository at:

  https://gitlab.com/mjt0k/qemu.git tags/pull-trivial-patches

for you to fetch changes up to 06e2329636f9c05b046ccf8aa1b245bbdfb01263:

  license: Update deprecated SPDX tag GPL-2.0 to GPL-2.0-only (2024-09-20 10:11:59 +0300)

----------------------------------------------------------------
trivial patches for 2024-09-20

Various things.  Including explicit-LFS usage removal for linux-user
which allows qemu to be built on musl, some minor tests fixes, removals
of unused functions, license tag fixes, and others.

----------------------------------------------------------------
Bibo Mao (1):
      hw/loongarch/virt: Add description for virt machine type

Dr. David Alan Gilbert (3):
      envlist: Remove unused envlist_parse
      hw/sysbus: Remove unused sysbus_mmio_unmap
      util/cutils: Remove unused qemu_get_exec_dir

Inès Varhol (1):
      hw/display: Fix mirrored output in dm163

Mark Cave-Ayland (1):
      hw/mips/jazz: fix typo in in-built NIC alias

Michael Tokarev (3):
      mark <zlib.h> with for-crc32 in a consistent manner
      linux-user/syscall.c: drop 64 suffix from flock64 &Co
      linux-user/syscall.c: eliminate other explicit LFS usages

Philippe Mathieu-Daudé (8):
      tests/unit: Really build pbkdf test on macOS
      target/hexagon: Rename macros.inc -> macros.h.inc
      tests/bench: Rename test_akcipher_keys.inc -> test_akcipher_keys.c.inc
      tests/functional: Correct typo in test_netdev_ethtool.py SPDX tag
      license: Simplify GPL-2.0-or-later license descriptions
      license: Update deprecated SPDX tag LGPL-2.0+ to LGPL-2.0-or-later
      license: Update deprecated SPDX tag GPL-2.0+ to GPL-2.0-or-later
      license: Update deprecated SPDX tag GPL-2.0 to GPL-2.0-only

Tejas Vipin (1):
      ppc: fix incorrect spelling of PowerMac

Thomas Huth (4):
      hw/virtio/Kconfig: Include vhost-user-scmi only on arm targets
      tests/qemu-iotests/testenv: Use the "virt" machine for or1k
      tests/qemu-iotests/testenv: Use the "r2d" machine for sh4/sh4eb
      tests/functional: Put the or1k_sim test into the slow category

 block/vdi.c                                        |  4 +-
 docs/system/ppc/powermac.rst                       |  4 +-
 gdbstub/gdbstub.c                                  |  2 +-
 gdbstub/syscalls.c                                 |  2 +-
 gdbstub/system.c                                   |  2 +-
 gdbstub/user-target.c                              |  2 +-
 gdbstub/user.c                                     |  2 +-
 hw/core/sysbus.c                                   | 10 ---
 hw/core/uboot_image.h                              |  2 +-
 hw/display/dm163.c                                 |  2 +-
 hw/loongarch/virt.c                                |  1 +
 hw/m68k/bootinfo.h                                 |  2 +-
 hw/mips/jazz.c                                     |  2 +-
 hw/net/cadence_gem.c                               |  2 +-
 hw/net/dp8393x.c                                   |  2 +-
 hw/net/eepro100.c                                  |  4 +-
 hw/net/ftgmac100.c                                 |  3 +-
 hw/net/i82596.c                                    |  2 +-
 hw/net/igb_regs.h                                  |  2 +-
 hw/net/imx_fec.c                                   |  3 +-
 hw/net/lan9118.c                                   |  3 +-
 hw/net/mcf_fec.c                                   |  3 +-
 hw/net/npcm7xx_emc.c                               |  3 +-
 hw/net/rtl8139.c                                   |  4 +-
 hw/net/smc91c111.c                                 |  3 +-
 hw/net/stellaris_enet.c                            |  2 +-
 hw/nvram/fw_cfg-acpi.c                             |  2 +-
 hw/nvram/mac_nvram.c                               |  2 +-
 hw/ppc/mac_newworld.c                              |  2 +-
 hw/ppc/mac_oldworld.c                              |  2 +-
 hw/ppc/rs6000_mc.c                                 |  4 +-
 hw/virtio/Kconfig                                  |  2 +-
 hw/virtio/virtio-acpi.c                            |  2 +-
 include/gdbstub/syscalls.h                         |  2 +-
 include/gdbstub/user.h                             |  2 +-
 include/hw/nvram/fw_cfg_acpi.h                     |  2 +-
 include/hw/sysbus.h                                |  1 -
 include/hw/usb/dwc2-regs.h                         |  2 +-
 include/hw/virtio/virtio-acpi.h                    |  2 +-
 include/qemu/crc-ccitt.h                           |  2 +-
 include/qemu/cutils.h                              |  5 +-
 include/qemu/envlist.h                             |  2 -
 include/qemu/timed-average.h                       |  4 +-
 linux-user/alpha/syscall.tbl                       |  2 +-
 linux-user/alpha/syscallhdr.sh                     |  2 +-
 linux-user/arm/syscallhdr.sh                       |  2 +-
 linux-user/hppa/syscall.tbl                        |  2 +-
 linux-user/hppa/syscallhdr.sh                      |  2 +-
 linux-user/i386/syscallhdr.sh                      |  2 +-
 linux-user/m68k/syscall.tbl                        |  2 +-
 linux-user/m68k/syscallhdr.sh                      |  2 +-
 linux-user/microblaze/syscall.tbl                  |  2 +-
 linux-user/microblaze/syscallhdr.sh                |  2 +-
 linux-user/mips/syscall_o32.tbl                    |  2 +-
 linux-user/mips/syscallhdr.sh                      |  2 +-
 linux-user/mips64/syscall_n32.tbl                  |  2 +-
 linux-user/mips64/syscall_n64.tbl                  |  2 +-
 linux-user/mips64/syscallhdr.sh                    |  2 +-
 linux-user/ppc/syscall.tbl                         |  2 +-
 linux-user/ppc/syscallhdr.sh                       |  2 +-
 linux-user/s390x/syscall.tbl                       |  2 +-
 linux-user/s390x/syscallhdr.sh                     |  2 +-
 linux-user/sh4/syscall.tbl                         |  2 +-
 linux-user/sh4/syscallhdr.sh                       |  2 +-
 linux-user/sparc/syscall.tbl                       |  2 +-
 linux-user/sparc/syscallhdr.sh                     |  2 +-
 linux-user/syscall.c                               | 78 +++++++++++-----------
 linux-user/x86_64/syscallhdr.sh                    |  2 +-
 linux-user/xtensa/syscall.tbl                      |  2 +-
 linux-user/xtensa/syscallhdr.sh                    |  2 +-
 qemu.nsi                                           |  4 +-
 scripts/kernel-doc                                 |  2 +-
 target/alpha/cpu-param.h                           |  2 +-
 target/arm/cpu-param.h                             |  2 +-
 target/arm/helper.c                                |  2 +-
 target/arm/tcg/helper-a64.c                        |  2 +-
 target/hexagon/gen_idef_parser_funcs.py            |  2 +-
 target/hexagon/idef-parser/README.rst              |  4 +-
 .../idef-parser/{macros.inc => macros.h.inc}       |  0
 target/hexagon/meson.build                         |  2 +-
 target/hppa/cpu-param.h                            |  2 +-
 target/i386/cpu-param.h                            |  2 +-
 target/loongarch/tcg/op_helper.c                   |  2 +-
 target/m68k/cpu-param.h                            |  2 +-
 target/microblaze/cpu-param.h                      |  2 +-
 target/mips/cpu-param.h                            |  2 +-
 target/openrisc/cpu-param.h                        |  2 +-
 target/ppc/cpu-param.h                             |  2 +-
 target/riscv/cpu-param.h                           |  2 +-
 target/s390x/cpu-param.h                           |  2 +-
 target/sh4/cpu-param.h                             |  2 +-
 target/sparc/cpu-param.h                           |  2 +-
 target/sparc/insns.decode                          |  2 +-
 tests/bench/benchmark-crypto-akcipher.c            |  2 +-
 ..._akcipher_keys.inc => test_akcipher_keys.c.inc} |  0
 tests/functional/meson.build                       |  2 +-
 tests/functional/test_netdev_ethtool.py            |  2 +-
 tests/qemu-iotests/testenv.py                      |  3 +
 tests/tcg/loongarch64/system/regdef.h              |  2 +-
 tests/unit/test-crypto-pbkdf.c                     |  2 +-
 util/cutils.c                                      |  5 --
 util/envlist.c                                     | 69 -------------------
 util/timed-average.c                               |  4 +-
 103 files changed, 149 insertions(+), 233 deletions(-)
 rename target/hexagon/idef-parser/{macros.inc => macros.h.inc} (100%)
 rename tests/bench/{test_akcipher_keys.inc => test_akcipher_keys.c.inc} (100%)

