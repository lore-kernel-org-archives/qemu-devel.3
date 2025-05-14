Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35DDDC3ABD8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 13:12:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFBgt-00033J-Aw; Wed, 14 May 2025 08:58:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uFBgn-0002fO-E7; Wed, 14 May 2025 08:58:25 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uFBgk-0007oE-H1; Wed, 14 May 2025 08:58:24 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E5E49121ADE;
 Wed, 14 May 2025 15:57:48 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 93AAB20B84C;
 Wed, 14 May 2025 15:57:58 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.2.4 00/34] Patch Round-up for stable 9.2.4,
 freeze on 2025-05-24
Date: Wed, 14 May 2025 15:57:22 +0300
Message-Id: <qemu-stable-9.2.4-20250514155748@cover.tls.msk.ru>
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

The following patches are queued for QEMU stable v9.2.4:

  https://gitlab.com/qemu-project/qemu/-/commits/staging-9.2

Patch freeze is 2025-05-24, and the release is planned for 2025-05-26:

  https://wiki.qemu.org/Planning/9.2

Please respond here or CC qemu-stable@nongnu.org on any additional patches
you think should (or shouldn't) be included in the release.

The changes which are staging for inclusion, with the original commit hash
from master branch, are given below the bottom line.

Thanks!

/mjt

--------------------------------------
01 e768f0246ce2 hemanshu.khilari.foss:
   docs/specs/riscv-iommu: Fixed broken link to external risv iommu document
02 2542d5cf471a Heinrich Schuchardt:
   hw/rtc/goldfish: keep time offset when resetting
03 04e99f9eb792 Philippe Mathieu-Daudé:
   hw/pci-host/designware: Fix ATU_UPPER_TARGET register access
04 070a500cc0da Richard Henderson:
   target/avr: Fix buffer read in avr_print_insn
05 fca2817fdcb0 Richard Henderson:
   target/mips: Revert TARGET_PAGE_BITS_VARY
06 d89b9899babc Richard Henderson:
   target/mips: Require even maskbits in update_pagemask
07 256ba7715b10 Richard Henderson:
   target/mips: Simplify and fix update_pagemask
08 c0b32426ce56 Marco Cavenati:
   migration: fix SEEK_CUR offset calculation in qio_channel_block_seek
09 c17ad4b11bd2 Akihiko Odaki:
   virtio-net: Fix num_buffers for version 1
10 719255486df2 Suravee Suthikulpanit:
   hw/i386/amd_iommu: Assign pci-id 0x1419 for the AMD IOMMU device
11 e139bc4b1772 Philippe Mathieu-Daudé:
   tcg: Allocate TEMP_VAL_MEM frame in temp_load()
12 9808ce6d5cb7 Nicholas Piggin:
   target/ppc: Big-core scratch register fix
13 b3d47c8303b8 Nicholas Piggin:
   target/ppc: Fix SPRC/SPRD SPRs for P9/10
14 61b6d9b749ba Kevin Wolf:
   scsi-disk: Apply error policy for host_status errors again
15 a7a05f5f6a40 Daan De Meyer:
   smbios: Fix buffer overrun when using path= option
16 c07cd110a182 Pierrick Bouvier:
   plugins/loader: fix deadlock when resetting/uninstalling a plugin
17 b0b5af62ef9e Arthur Sengileyev:
   Fix objdump output parser in "nsis.py"
18 e28fbd1c525d Antoine Damhet:
   Revert "virtio-net: Copy received header to buffer"
19 94a159f3dc73 Paolo Bonzini:
   target/i386/hvf: fix lflags_to_rflags
20 6b661b7ed7cd Richard Henderson:
   target/avr: Improve decode of LDS, STS
21 d5f241834be1 Philippe Mathieu-Daudé:
   hw/core: Get default_cpu_type calling machine_class_default_cpu_type()
22 56a9f0d4c4a4 Peter Maydell:
   hw/core/cpu: gdb_arch_name string should not be freed
23 d4a785ba30ce Hauke Mehrtens:
   target/mips: Fix MIPS16e translation
24 563cd698dffb Akihiko Odaki:
   meson: Use has_header_symbol() to check getcpu()
25 6804b89fb531 Akihiko Odaki:
   meson: Remove CONFIG_STATX and CONFIG_STATX_MNT_ID
26 9401f91b9b0c Richard Henderson:
   accel/tcg: Don't use TARGET_LONG_BITS in decode_sleb128
27 8ed7c0b6488a Peter Maydell:
   target/arm: Don't assert() for ISB/SB inside IT block
28 eba837a31b95 Bernhard Beschow:
   hw/gpio/imx_gpio: Fix interpretation of GDIR polarity
29 e54ef98c8a80 Paolo Bonzini:
   target/i386: do not trigger IRQ shadow for LSS
30 1e94ddc68544 Paolo Bonzini:
   target/i386: do not block singlestep for STI
31 d5d028eee38d Daniel P. Berrangé:
   gitlab: use --refetch in check-patch/check-dco jobs
32 54e54e594bc8 Bernhard Beschow:
   hw/i2c/imx: Always set interrupt status bit if interrupt condition occurs
33 61da38db70af Christian Schoenebeck:
   9pfs: fix concurrent v9fs_reclaim_fd() calls
34 89f7b4da7662 Christian Schoenebeck:
   9pfs: fix FD leak and reduce latency of v9fs_reclaim_fd()

